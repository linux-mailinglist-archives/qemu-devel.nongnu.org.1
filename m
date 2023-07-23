Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3D75E0E5
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVNG-0001eL-S5; Sun, 23 Jul 2023 05:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNF-0001eD-Q4
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNE-0001VD-4M
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:33 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-55adfa61199so2411656a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104450; x=1690709250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fOsd/QxkdLakTEWVjXArshVSd4UxetHsteWtHCzocSg=;
 b=jsewheDwTl6WQ9yCIuVQGlP1/SkrUVSsv/akFo5oSeRN6Myf9ad2aRF7ZWNFbrjKlO
 qTlLVuF2kZkanjyGHekdt0B1uFbkexrswsB4w8Yl8unMAbjzywwlZ5lbDIyFG2Ijfhef
 2GjgnytWWMNW0+1poPd0Nwhc5EMg8p1dt2X81uWVTm1Ipx74ao4Ocy+tuV5hveRUghTd
 fHPbN+pxGwoKGq3fPelSpSj2hdTDwO1i/nZsN8+2qZcgv6lnjYpkZPKbe/qjDRchPVWP
 fsM7aiMHmiiA+Myp5toGjuTJhA1n+zHUdwtnSUuD9zKd2Hn5HEhsMTqGdzyi7R9DdUYj
 k1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104450; x=1690709250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOsd/QxkdLakTEWVjXArshVSd4UxetHsteWtHCzocSg=;
 b=Yg36v1KwQRIhqoZVWHr3QtykQr9O23jEw7QEqi/7ESmmU3Pne/c1qTHrlfxGta8IHs
 bPL4preA+R1vee8MZ99TWih2UrJW+TlRdt9oe4ydnQxvXOvvSkTx5QRdesCYg2KBqX0+
 AVbA3HYrmymT0Ax7+nlMCM5NVLAJAAlnZdvAeWWYMgldGOD/mvtAGm8LckuZp9YoengX
 bRxw6ApzK1pme+8IqmUG1fYYwPXP5LJ/S5UtRrqFW9tZJqrQ0MDIMr9E8qZGWWHOi3wk
 2sEvm43lwY/WRURJiRAgib/HFq8U9Z9C2mp2TrhDaozX10P9vJfBapDjpfxiDxoZl5IP
 Shxg==
X-Gm-Message-State: ABy/qLYI60SPSOKno2d0NxKtjNq+lOPJOKbH5lvAn4m/My9J5LqCOfqq
 DLOF8aYgOUpC2ypsfqcoTPk=
X-Google-Smtp-Source: APBJJlHq14naDQEJStH3MAI5OmoWXF3IMkIRoz1KmkC4xm6hStOhOJt1l2jVfIm6pnFaFr8epixNJg==
X-Received: by 2002:a17:90b:3a90:b0:263:f72f:491 with SMTP id
 om16-20020a17090b3a9000b00263f72f0491mr7478003pjb.43.1690104449790; 
 Sun, 23 Jul 2023 02:27:29 -0700 (PDT)
Received: from localhost ([123.117.183.65]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a030d00b0025bbe90d3cbsm5268401pje.44.2023.07.23.02.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:27:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
Date: Sun, 23 Jul 2023 17:26:33 +0800
Message-Id: <cover.1690100802.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This series enables shadowed CVQ to intercept VLAN commands
through shadowed CVQ, update the virtio NIC device model
so qemu send it in a migration, and the restore of that
VLAN state in the destination.

ChangeLog
=========
v2:
 - remove the extra line pointed out by Eugenio in patch 3
"vdpa: Restore vlan filtering state"

v1: https://lore.kernel.org/all/cover.1689690854.git.yin31149@gmail.com/
 - based on patch "[PATCH 0/3] Vhost-vdpa Shadow Virtqueue VLAN support"
at https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01016.html
 - move `MAX_VLAN` macro to include/hw/virtio/virtio-net.h
instead of net/vhost-vdpa.c
 - fix conflicts with the master branch


TestStep
========
1. test the migration using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `ctrl_vlan` features on, command line like:
      -device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
indirect_desc=off,queue_reset=off,ctrl_vlan=on,...

  - For L1 guest, apply the patch series and compile the source code,
start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
`ctrl_vlan` features on, command line like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
ctrl_vlan=on,...

  - For L2 source guest, run the following bash command:
```bash
#!/bin/sh

for idx in {1..4094}
do
  ip link add link eth0 name vlan$idx type vlan id $idx
done
```

  - gdb attaches the L2 dest VM and break at the
vhost_vdpa_net_load_single_vlan(), and execute the following
gdbscript
```gdbscript
ignore 1 4094
c
```

  - Execute the live migration in L2 source monitor

  - Result
    * with this series, gdb can hit the breakpoint and continue
the executing without triggering any error or warning.

Eugenio Pérez (1):
  virtio-net: do not reset vlan filtering at set_features

Hawkins Jiawei (3):
  virtio-net: Expose MAX_VLAN
  vdpa: Restore vlan filtering state
  vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ

 hw/net/virtio-net.c            |  6 +----
 include/hw/virtio/virtio-net.h |  6 +++++
 net/vhost-vdpa.c               | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.25.1


