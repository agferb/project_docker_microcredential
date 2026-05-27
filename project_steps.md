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