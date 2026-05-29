1. The Dockerfiles were fixed
2. From the 2 Dockerfiles, 2 images were created:
```bash
docker build -f Dockerfile.train -t ml_train:01.00 .
```

```bash
docker build -f Dockerfile.infer -t ml_infer:01.00 .
```

3. Folder `models/` was created inside the repository.
4. Container from image `ml_train:01.00` was run:
```bash
docker run --rm -v ./models:/app/models <ml_train:version>
```
5. Container from image `ml_infer:01.00` was run:
```bash
docker run -d --rm -v ./models:/app/models -p 8090:8080 ml_infer:01.00
```
6. Infer Container was tested by:
```bash
curl localhost:8090
```
7. Created images were tagged before being pushed:
```bash
docker tag 93ee911971c7 aleitocu/ml_train:01.00
```
```bash
docker tag 075f44fc18be aleitocu/ml_infer:01.00
```
8. Images were pushed to Dockerhub:
```bash
docker image push aleitocu/ml_train:01.00
```
```bash
docker image push aleitocu/ml_infer:01.00
```
9. The current repository updates were added, commites and pushed back to GitHub
10. Inside UGent HPC, I cloned the current repository
```bash
git clone git@github.com:agferb/project_docker_microcredential.git
```
11. I created the slurm file `build-python-train-v1.sh` and submitted it to run:
```bash
sbatch build-python-train-v1.sh
```
12. The output and error files of the run are `python-ml-train-v1.64512814.stdout` and `python-ml-train-v1.64512814.stderr`. There was a system admin issue that couldn't be solved by users, so I tried different approaches.
13. The first approach was to only pull the image instead of building it:
```bash
apptainer pull /tmp/$USER/ml-train_01.00.sif docker://aleitocu/ml_train:01.00 # Inside slurm file
```
14. This approach still did not work, so I first tried building it from `$VSC_SCRATCH`, and then pulling it from `$VSC_SCRATCH`"
```bash
apptainer build --fakeroot ml-train_01.00.sif docker://aleitocu/ml_train:01.00 # Inside slurm file
```
```bash
apptainer pull ml-train_01.00.sif docker://aleitocu/ml_train:01.00 # Inside slurm file
```
15. None of these 2 approaches also did not work. So I installed apptainer locally, created a `.sif` image file, transfered it through HPC, and then runned the image directly from inside the slurm file. This last approach corresponds to the file `build-python-train-v2.sh`.
```bash
apptainer build ml-train_01.00.sif docker://aleitocu/ml_train:01.00 # After installing apptainer
```
```bash
scp ml-train_01.00.sif <username>@login.hpc.ugent.be:$VSC_SCRATCH
```
```bash
apptainer run ml-train_01.00.sif # Inside slurm file
```
16. Until the deadline of submission, the job was still pending, so the result from this workaraound will be discussed on a following occasion.