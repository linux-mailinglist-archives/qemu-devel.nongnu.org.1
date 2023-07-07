Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B435C74B453
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNA-0000VJ-Ej; Fri, 07 Jul 2023 11:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN1-0000Ro-O3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnMy-00074s-On
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-262b213eddfso2263364a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743658; x=1691335658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=opOtE3v+p34sCrV/vr4XkoUz2EtPh2iEBYg1Qii9cUE=;
 b=Bi/yG+9ydjjd9YhWT5F0Xq7Sx1CVemLnz01UOBKCdVn1pCW3edyWzAL8eWa/FGKV0O
 BoU0T2L3Iw+xP8h3vxYxjk8mNMlo85iDQEALi1apRPaKP93iop248iejTd6eLqynklt9
 BG8U7HghHzkAcKybDGKjt+hDpS/6RyeG058UjgaCdXkrKPYO7Qim+IEnXa5dDXJInneY
 mHTTyRZFBgQ62D4tnZGc7C1k1YpV9s/o7pIKwBG5tF7w4awi1SVPlq3ei04J5j6TN7jG
 A8Kql31rpURo4HyVn8S8KUUi5CC8u57v9ZRaf+wQ1V7a/p/pjGi/ESDFi/iuFrkFktx+
 pMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743658; x=1691335658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=opOtE3v+p34sCrV/vr4XkoUz2EtPh2iEBYg1Qii9cUE=;
 b=Zf15Nlq0w7aqKlILr/WkR068MJaxCS7X2ukeuLT+gFnWpzDBG4K4tDjS/m1KrvxiYo
 Kt84F+v39fP36P9GMqkSCftOcA4+JAYV/1h0Xf83OmBV/OUBexCT44U3YxEWw8ROb6B3
 yy2Jk71uGE3EKiszDYS2/gO63pz+SZH1XBRR3YFGKPPg5jDuRfynUgCmNyaSAvuTxdai
 iyFveVTFeIuJiYrkICSkpHNPrb10rEa50PkUEN3Qt/evMi4BLdRUS15ELwyJIbyOhrEQ
 oc5B3B9AyiQCVwQMiur+zlaeAPtkknn5ThjxCTn1tp91n3xSB7l8/bqvuQPBNgAHWSPh
 Zz/w==
X-Gm-Message-State: ABy/qLbk+oM4/jVCmRe3BVHIcYeUHYbA7NYTyq5p/of3kaheppOZYdVl
 RtAtf21OO5cIBh+qyWl3nes=
X-Google-Smtp-Source: APBJJlGv5hA8pzYL6hhRczdzgOLS3cXSC15aXZ/fGU1h5I1CiQ+VNKd3HYfaQrgtUra0MNY5qjBBXA==
X-Received: by 2002:a17:902:d481:b0:1b8:2adc:8358 with SMTP id
 c1-20020a170902d48100b001b82adc8358mr8572021plg.11.1688743658049; 
 Fri, 07 Jul 2023 08:27:38 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 ij24-20020a170902ab5800b001ac897026cesm3458711plb.102.2023.07.07.08.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:37 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/7] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands support
Date: Fri,  7 Jul 2023 23:27:27 +0800
Message-Id: <cover.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1033.google.com
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

Note that this patch should be based on
[1] patch "vdpa: Return -EIO if device ack is VIRTIO_NET_ERR".

[1]. https://lore.kernel.org/all/cover.1688438055.git.yin31149@gmail.com/

TestStep
========
1. test the patch series using vp-vdpa device
  - For L0 guest, boot QEMU with virtio-net-pci net device with `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,ctrl_rx=on,...

  - For L1 guest, apply the patch series and compile the code,
start QEMU with vdpa device with svq mode and enable the `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,ctrl_rx=on,...

With this series, QEMU should not trigger any error or warning.
Without this series, QEMU should fail with
"vdpa svq does not work with features 0x40000".

2. test the patch "vhost: Fix false positive out-of-bounds"
  - For L0 guest, boot QEMU with virtio-net-pci net device with `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,ctrl_rx=on,...

  - For L1 guest, apply the patch series except
patch "vhost: Fix false positive out-of-bounds". start QEMU with vdpa device
with svq mode and enable the `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,ctrl_rx=on,...
  
  - For L2 guest, run the following bash command:
```bash
for idx1 in {0..9}
do
  for idx2 in {0..9}
  do
    for idx3 in {0..6}
    do
      ip link add macvlan$idx1$idx2$idx3 link eth0
address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
      ip link set macvlan$idx1$idx2$idx3 up
    done
  done
done
```

With the patch "vhost: Fix false positive out-of-bounds", QEMU should not
trigger any error or warning.
Without that patch, QEMU should fail with something like
"free(): double free detected in tcache 2". Note that this UAF will be
solved in another patch.

3. test the patch "vdpa: Avoid forwarding large CVQ command failures"
  - For L0 guest, boot QEMU with virtio-net-pci net device with `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,ctrl_rx=on,...

  - For L1 guest, apply the patch series except
patch "vdpa: Avoid forwarding large CVQ command failures". Start QEMU
with vdpa device with svq mode and enable the `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,ctrl_rx=on,...
  
  - For L2 guest, run the following bash command:
```bash
for idx1 in {0..9}
do
  for idx2 in {0..9}
  do
    for idx3 in {0..6}
    do
      ip link add macvlan$idx1$idx2$idx3 link eth0
address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
      ip link set macvlan$idx1$idx2$idx3 up
    done
  done
done
```

With the patch "vdpa: Avoid forwarding large CVQ command failures",
L2 guest should not trigger any error or warning.
Without that patch, L2 guest should get warning like
"Failed to set Mac filter table.".

4. test the migration
  - For L0 guest, boot QEMU with two virtio-net-pci net device with `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,ctrl_rx=on,...

  - For L1 guest, apply the patch series. Start QEMU
with two vdpa device with svq mode and enable the `ctrl_vq`
and `ctrl_rx` feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,ctrl_rx=on,...
gdb attach the destination VM and break at the
net/vhost-vdpa.c:904
  
  - For L2 source guest, run the following bash command:
```bash
for idx1 in {0..2}
do
  for idx2 in {0..9}
  do
    ip link add macvlan$idx1$idx2 link eth0
address 4a:30:10:19:$idx1$idx2:1a type macvlan mode bridge
    ip link set macvlan$idx1$idx2 up
    done
  done
done
```, then executing the live migration in monitor.

With the patch series, gdb can hit the breakpoint and see those
30 MAC addresses according to `x/180bx n->mac_table.macs`.
Without that patch, QEMU should fail with
"vdpa svq does not work with features 0x40000".


ChangeLog
=========
v3:
  - rename argument name and use iov_to_buf suggested by Eugenio in
patch 1 "vdpa: Use iovec for vhost_vdpa_net_load_cmd()"
  - return early if mismatch the condition suggested by Eugenio in
patch 2 "vdpa: Restore MAC address filtering state" and
patch 3 "vdpa: Restore packet receive filtering state relative with
_F_CTRL_RX feature"
  - remove the `on` variable suggested by Eugenio in patch 3 "vdpa:
Restore packet receive filtering state relative with _F_CTRL_RX feature"
  - fix possible false positive out-of-bounds in patch 4 "vhost:
Fix false positive out-of-bounds"
  - avoid forwarding large CVQ command failures suggested by Eugenio by
patch 5 "vdpa: Accessing CVQ header through its structure" and
patch 6 "vdpa: Avoid forwarding large CVQ command failures"

v2: https://lore.kernel.org/all/cover.1688051252.git.yin31149@gmail.com/
  - refactor vhost_vdpa_net_load_cmd() to accept iovec suggested by
Eugenio
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04423.html

Hawkins Jiawei (7):
  vdpa: Use iovec for vhost_vdpa_net_load_cmd()
  vdpa: Restore MAC address filtering state
  vdpa: Restore packet receive filtering state relative with _F_CTRL_RX
    feature
  vhost: Fix false positive out-of-bounds
  vdpa: Accessing CVQ header through its structure
  vdpa: Avoid forwarding large CVQ command failures
  vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ

 hw/virtio/vhost-shadow-virtqueue.c |   2 +-
 net/vhost-vdpa.c                   | 338 ++++++++++++++++++++++++++++-
 2 files changed, 329 insertions(+), 11 deletions(-)

-- 
2.25.1


