Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7137758FAE
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM20b-0004aw-Aw; Wed, 19 Jul 2023 03:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20Z-0004aT-4z
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM20X-0003KW-8v
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:54:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-676f16e0bc4so4415030b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689753240; x=1692345240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Mx5sp0XLbAP6dXX2K2vuKPRvY8wZewm5YXzIAnxx8E=;
 b=jpA9psHdlH0bzdf5Twk7QG/A0QiJ6ui2X0CVhmsGU1geUhS8VxZQph7FUnzGmWq94y
 G6HEc/q8FKW2j4gW2r+vP9ek7Dkq6s5ZrfAcE2JsGvylcUEOZ5oNKNKWUI6+3BPeXEWM
 MIjdAnHZR3896PU4jAkwcgAZmh0ChZoV0MzDzPaDZF4zHB66MB3dgIawyTa4Sk4jBvuC
 UOGPn1I3mW9tEFqoq3snozyJYwv6plCA+zE1ixvb6IsPFy2Pp8fGYc1K5m2gCBM3Jb87
 ni8vsSQtWb/9J/fyzcjLmtxJb0IRI0kPaRf2a71b0eNQaw5zBhLS5Ab/B8p2BbnShuep
 6VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689753240; x=1692345240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Mx5sp0XLbAP6dXX2K2vuKPRvY8wZewm5YXzIAnxx8E=;
 b=efMKnJPGViPZHtQnLgoxaXV6V8izQoyy6n1Q0Tzc+1BWSNpV6d/ILaBZdCRjG9Pk+J
 Fyo6bK81mBXrxIq1696PNWoGypO0tbtENoboKcvOICqQhF3P+E6dXWMol5MQcqrc3rLJ
 8KdZEvZFpb6zbC+E7sMgEF3lZsFFlfYHuwME32Qr839CsmGEhF1md5sSH4DFdk3XqnHF
 uS+GhesGy+i/GHKQba0OumGGIbgBNrmFQ6ZXj5s4zxWRD+4kYwzgROudqWlrJ4fyE4xx
 781UrEyICeiCqdM+gZbM5S7HcAcH8CVPN/IVRb3gDXa9KCTqsMD9aoltZU+fYHaYYcNi
 4pLQ==
X-Gm-Message-State: ABy/qLbyOuKFVk3CwDIyLrW+suvWdHh2byrEnANbZRycKRVR8qivddul
 wYeC5NNnowDdVjSSueP2+24=
X-Google-Smtp-Source: APBJJlG7qgCXvNCObEpyROScEZvHVdQzTfhtjvzk0zOH2YUJX0cMrhs/biEBLEO3CQI3oBUD+iIwXA==
X-Received: by 2002:a05:6a00:b47:b0:653:de9a:d933 with SMTP id
 p7-20020a056a000b4700b00653de9ad933mr20157109pfo.17.1689753239440; 
 Wed, 19 Jul 2023 00:53:59 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 a5-20020aa78645000000b0066883d75932sm2664079pfo.204.2023.07.19.00.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:53:59 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/8] vdpa: Send all CVQ state load commands in parallel
Date: Wed, 19 Jul 2023 15:53:45 +0800
Message-Id: <cover.1689748694.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42a.google.com
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

This patchset allows QEMU to delay polling and checking the device
used buffer until either the SVQ is full or control commands shadow
buffers are full, instead of polling and checking immediately after
sending each SVQ control command, so that QEMU can send all the SVQ
control commands in parallel, which have better performance improvement.

I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
guest to build a test environment for sending multiple CVQ state load
commands. This patch series can improve latency from 10023 us to
8697 us for about 4099 CVQ state load commands, about 0.32 us per command.

Note that this patch should be based on
patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].

[1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03719.html

TestStep
========
1. regression testing using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
      -device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
indirect_desc=off,queue_reset=off,ctrl_rx=on,ctrl_rx_extra=on,...

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
iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
indirect_desc=off,queue_reset=off,ctrl_vlan=on,...

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

  - wait for some time, then execute the live migration in L2 source monitor

  - Result
    * with this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 8697 us"
    * without this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 10023 us"

ChangeLog
=========
v3:
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

Hawkins Jiawei (8):
  vhost: Add argument to vhost_svq_poll()
  vdpa: Use iovec for vhost_vdpa_net_cvq_add()
  vhost: Expose vhost_svq_available_slots()
  vdpa: Avoid using vhost_vdpa_net_load_*() outside
    vhost_vdpa_net_load()
  vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
  vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
  vdpa: Add cursors to vhost_vdpa_net_loadx()
  vdpa: Send cvq state load commands in parallel

 hw/virtio/vhost-shadow-virtqueue.c |  38 ++--
 hw/virtio/vhost-shadow-virtqueue.h |   3 +-
 net/vhost-vdpa.c                   | 354 ++++++++++++++++++-----------
 3 files changed, 249 insertions(+), 146 deletions(-)

-- 
2.25.1


