Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF147C7FCC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFN-0006pw-Di; Fri, 13 Oct 2023 04:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDF4-0006Ji-7D
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:09:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDF1-0001X0-Tr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:09:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c894e4573bso14205665ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184589; x=1697789389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3mEdymVCxzgYaero7DJNwEE9QTNCmCbBka+B7Fju1hA=;
 b=SkB2kz3VaeaEyvKFAmNPHRJEPdMFU4jQ7hDGeRDS0Z33KjvUG9e/DbjIc+4Qufh5J9
 SL4oLXg7MFM8bU9vCBwMaTG0Ye5rYP8cnAcJXVV7hLmuPXS9HrhgGVR+FM9fNDxflkHe
 LRJND//4xcy0l5Hq/u9rPeszaJCrlEFO2t68XSPKZX8LaxDu1ecvWXLdiax5bdaSIttl
 396VHcMX/nKfnQ9OcPHDFvwSw+nUQGvEbv8ac8kD5wLSUGDNkiMvEsTe87Du/16sAvX1
 3GIrhcluf4TTLlO9qiJkkn/S1crE8JlePzJTJKAR9TYlFfmCK9pWZl3v0qqxhtZR3Xw9
 ycaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184589; x=1697789389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mEdymVCxzgYaero7DJNwEE9QTNCmCbBka+B7Fju1hA=;
 b=WtHNKAN0rpfQUIelIb2FMPV8yDsIDLthTqPUIJSeVGwocM7DLsyKPEvZtNukp5D27O
 D3lUvsF6bkbny0/hAfczeWsZKUkTqcp5aZdzxJGGAyZmCb6sGl1Hta1MGR/JpeluRn4m
 IUMCUHvEplpPV6xYRm3h4Uduh/pkrPlpDykMaEpjYzPk285JMl3BH+/hrxBbazgkZy6b
 cNIXzOTrKQtEakK99MuR0ar5E4HBkExVu7gvnVoA0s0prtkqojkP5BYDsj9IQWJo99Lr
 15DOAJn3sYe+Mo2l9Sx2bwqgUBAHdO+PgNhZuAaVnPnTUQtkCXI+FwBSQXMZzYOc2vIR
 ZJIg==
X-Gm-Message-State: AOJu0YzmSUU+UtRpVfFVX2TsRWD/vzlGFK6YK1bqd4auUabMCTw4K6Lf
 dqSs75DrbXQ0q8zqaF08LeU=
X-Google-Smtp-Source: AGHT+IF1+ul3SrSo7mu46mBM5PBmnn+nQkCqorpHECHa7JR7BSo5oJvFsgYkZs4B6XQdBPCOTwYAMg==
X-Received: by 2002:a17:903:41c1:b0:1c6:30d1:7214 with SMTP id
 u1-20020a17090341c100b001c630d17214mr26625811ple.55.1697184589067; 
 Fri, 13 Oct 2023 01:09:49 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 h14-20020a170902680e00b001b03a1a3151sm3322904plk.70.2023.10.13.01.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:09:48 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 0/7] vdpa: Send all CVQ state load commands in parallel
Date: Fri, 13 Oct 2023 16:09:35 +0800
Message-Id: <cover.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset allows QEMU to delay polling and checking the device
used buffer until either the SVQ is full or control commands shadow
buffers are full, instead of polling and checking immediately after
sending each SVQ control command, so that QEMU can send all the SVQ
control commands in parallel, which have better performance improvement.

I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
guest to build a test environment for sending multiple CVQ state load
commands. This patch series can improve latency from 20848 us to
13543 us for about 4099 CVQ state load commands, about 1.78 us per command.

ChangeLog
=========
v5:
  - inline the vhost_svq_available_slots in the caller suggested by Eugenio
  - remove redundant assertion and code suggested by Eugenio
  - fix conflicts with master branch
  - add some comments and refactor a small part of code to improve
its readability

v4: https://lore.kernel.org/all/cover.1693287885.git.yin31149@gmail.com/#t
  - refactor subject line suggested by Eugenio in patch
"vhost: Add count argument to vhost_svq_poll()"
  - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio in patch
"vdpa: Use iovec for vhost_vdpa_net_cvq_add()"
  - pack CVQ command by iov_from_buf() instead of accessing
`out` directly suggested by Eugenio in patch
"vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load()"
  - always check the return value of vhost_vdpa_net_svq_poll()
suggested Eugenio in patch
"vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()"
  - use `struct iovec` instead of `void **` as cursor,
add vhost_vdpa_net_load_cursor_reset() helper function
to reset the cursors, refactor vhost_vdpa_net_load_cmd() to prepare buffers
by iov_copy() instead of accessing `in` and `out` directly
suggested by Eugenio in patch
"vdpa: Introduce cursors to vhost_vdpa_net_loadx()"
  - refactor argument `cmds_in_flight` to `len` for
vhost_vdpa_net_svq_full(), check the return value of
vhost_vdpa_net_svq_poll() in vhost_vdpa_net_svq_flush(),
use iov_size(), vhost_vdpa_net_load_cursor_reset()
and iov_discard_front() to update the cursors instead of
accessing it directly according to Eugenio in patch
"vdpa: Send cvq state load commands in parallel"

v3: https://lore.kernel.org/all/cover.1689748694.git.yin31149@gmail.com/
  - refactor vhost_svq_poll() to accept cmds_in_flight
suggested by Jason and Eugenio
  - refactor vhost_vdpa_net_cvq_add() to make control commands buffers
is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can reuse
it suggested by Eugenio
  - poll and check when SVQ is full or control commands shadow buffers is
full

v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.com/
  - recover accidentally deleted rows
  - remove extra newline
  - refactor `need_poll_len` to `cmds_in_flight`
  - return -EINVAL when vhost_svq_poll() return 0 or check
on buffers written by device fails
  - change the type of `in_cursor`, and refactor the
code for updating cursor
  - return directly when vhost_vdpa_net_load_{mac,mq}()
returns a failure in vhost_vdpa_net_load()

v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.com/


TestStep
========
1. regression testing using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
      -device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,guest_uso4=off,guest_uso6=off,
host_uso=off,guest_announce=off,indirect_desc=off,queue_reset=off,
ctrl_rx=on,ctrl_rx_extra=on,...

  - For L1 guest, apply the patch series and compile the source code,
start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
`ctrl_rx`, `ctrl_rx_extra` features on, command line like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
ctrl_rx=on,ctrl_rx_extra=on...

  - For L2 source guest, run the following bash command:
```bash
#!/bin/sh

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
  - Execute the live migration in L2 source monitor

  - Result
    * with this series, QEMU should not trigger any error or warning.



2. perf using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `ctrl_vlan` features on, command line like:
      -device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,guest_uso4=off,guest_uso6=off,
host_uso=off,guest_announce=off,indirect_desc=off,queue_reset=off,
ctrl_rx=on,ctrl_rx_extra=on,...

  - For L1 guest, apply the patch series, then apply an addtional
patch to record the load time in microseconds as following:
```diff
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6363..501b510fd2 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net *net,
     }
 
     if (net->nc->info->load) {
+        int64_t start_us = g_get_monotonic_time();
         r = net->nc->info->load(net->nc);
+        error_report("vhost_vdpa_net_load() = %ld us",
+                     g_get_monotonic_time() - start_us);
         if (r < 0) {
             goto fail;
         }
```

  - For L1 guest, compile the code, and start QEMU with two vdpa device
with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
command line like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
ctrl_vlan=on...

  - For L2 source guest, run the following bash command:
```bash
#!/bin/sh

for idx in {1..4094}
do
  ip link add link eth0 name vlan$idx type vlan id $idx
done
```

  - execute the live migration in L2 source monitor

  - Result
    * with this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 13543 us"
    * without this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 20848 us"

Hawkins Jiawei (7):
  vdpa: Use iovec for vhost_vdpa_net_cvq_add()
  vdpa: Avoid using vhost_vdpa_net_load_*() outside
    vhost_vdpa_net_load()
  vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
  vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
  vdpa: Introduce cursors to vhost_vdpa_net_loadx()
  vhost: Expose vhost_svq_available_slots()
  vdpa: Send cvq state load commands in parallel

 hw/virtio/vhost-shadow-virtqueue.c |   2 +-
 hw/virtio/vhost-shadow-virtqueue.h |   1 +
 net/vhost-vdpa.c                   | 374 +++++++++++++++++++----------
 3 files changed, 244 insertions(+), 133 deletions(-)

-- 
2.25.1


