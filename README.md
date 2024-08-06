## installation setup
```
conda create --name residual_mpc python=3.8.10
conda activate residual_mpc
./setup_carla.sh
./setup_env.sh
```

## to run mpc
```
./carla/CarlaUE4.sh
# different terminal
./run_mpc.sh
```

## to run mpc with CBF obstacle avoidance
```
./carla/CarlaUE4.sh
# different terminal
./run_mpc_obs.sh
```


## to run mpc with CBF obstacle avoidance + train residual learning
```
./carla/CarlaUE4.sh
# different terminal
./run_residual_train.sh
```