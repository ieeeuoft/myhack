import os
import pandas as pd
from torchvision.io import read_image
from torch.utils.data import Dataset

class MyHackImageDataset(Dataset):
    def __init__(self, metadata_csv, img_dir, category, transform=None):
        self.img_labels = pd.read_csv(metadata_csv)
        self.img_dir = img_dir
        self.transform = transform
        
    def size_dataset(self):
        return len(self.img_labels)
    
    def get_data(self, idx):
        img_path = os.path.join(img_dir, self.img_labels[idx, 'categories'])
        image = read_image(img_path)
        label = self.img_labels[idx, 'name']
        if self.transform: image = self.transform(image)
            
        return image, label
