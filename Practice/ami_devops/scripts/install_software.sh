#!/bin/bash
amazon-linux-extras install -y nginx1 docker vim
systemctl enable --now nginx
systemctl enable --now docker