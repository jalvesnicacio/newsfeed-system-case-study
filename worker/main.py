from flask import Flask
import requests
import redis
from rq import Queue
from api import getCatImage

app = Flask(__name__)

r = redis.Redis(host='redis', port=6380, db=0)
q = Queue(connection=r)


@app.route('/')
def index():

    task = q.enqueue(getCatImage, 5)
    n = len(q.jobs)

    html = '<center><br /><br />'
    for job in q.jobs:
        html += f'<a href="job/{job.id}">{job.id}</a><br /><br />'
    html += f'Total {n} Jobs in queue </center>'
    return f"{html}"


@app.route('/job/<job_id>')
def getJob(job_id):
    res = q.fetch_job(job_id)
    if not res.result:
        return f'<center><br /><br /><h3>The job is still pending</h3><br /><br />ID:{job_id}<br />Queued at: {res.enqueued_at}<br />Status: {res._status}</center>'
    return f'<center><br /><br /><img src="{res.result}" height="200px"><br /><br />ID:{job_id}<br />Queued at: {res.enqueued_at}<br />Finished at: {res.ended_at}</center>'


if __name__ == "__main__":

    app.run(host="0.0.0.0", debug=True)
