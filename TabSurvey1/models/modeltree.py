from modeltrees import ModelTreeRegressor, ModelTreeClassifier
from models.basemodel import BaseModel
from sklearn.ensemble import BaggingClassifier, BaggingRegressor
import numpy as np

'''
    A Gradient-Based Split Criterion for Highly Accurate and Transparent Model Trees 
    (https://www.ijcai.org/proceedings/2019/0281.pdf)
    
    See the implementation: https://github.com/schufa-innovationlab/model-trees
'''


class ModelTree(BaseModel):

    def __init__(self, params, args):
        super().__init__(params, args)
        if args.objective == "regression":
            base_model = ModelTreeRegressor(**self.params)
            self.model = BaggingRegressor(base_model, n_jobs=6)
        elif args.objective == "classification":
            print("ModelTree is not implemented for multi-class classification yet")
            import sys
            sys.exit(0)
        elif args.objective == "binary":
            base_model = ModelTreeClassifier(**self.params)
            self.model = BaggingClassifier(base_model, n_jobs=6)

    def fit(self, X, y, X_val=None, y_val=None):
        X = np.array(X, dtype=np.float64)
        return super().fit(X, y, X_val, y_val)

    @classmethod
    def define_trial_parameters(cls, trial, args):
        params = {
            "criterion": trial.suggest_categorical("criterion", ['gradient', 'gradient-renorm-z']),
            "max_depth": trial.suggest_int("max_depth", 1, 3),
        }
        return params
