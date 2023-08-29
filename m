Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27A78BE17
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhW-0004wy-3h; Tue, 29 Aug 2023 01:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarh8-0004wO-8Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:19 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarh2-0002VK-V0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:17 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-269304c135aso2544069a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288510; x=1693893310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BNr0fwhe7TG5BsAHo4NJFOsU7SCDY7g8AxBkzdL6Hws=;
 b=dQgIZkjeoZRmzNnV0beiR58USM3EEqAm70hvhe7Z6fV1LKpmGnTeA4Z4WAxF4T+na5
 lPIx3uWeonHA6I8VjC1cZt3Qi6rwGYYJPsB2WS4GTFkeiuAJQZEazyvzhyx/SSsFsC6U
 /g1N5jC/B7+CEv4bowE059I6w2SdCOnOPXE+iDOe6oZflnzQkihB59LEAoSSUi+gTRns
 Oh41dfaFbpJvssKkWZHr8hNAIi6gPA/bMHxf4GCzp4MPd0e2g+PpQO0+eEO8r/Vo4yUw
 3jnFfJ1Rvc8ZpY8RzEu5awFH3rYnFf+oxFOiTOlcLORvGQ6BWoOU5oz8tLw1OFowpvEQ
 ZTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288510; x=1693893310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNr0fwhe7TG5BsAHo4NJFOsU7SCDY7g8AxBkzdL6Hws=;
 b=CH6RqYC2L+ZfFRwYiFfgT+FwlvuXVMBIFS4e6MI3cgzTwupNjqB+G/njzTN0NHdBUM
 4KbFOjrPqcYsqrBUv63I0ur7Txdn4hgphmxGkXXldhF3zXt5Hc4ncdUudMoP53+LrzXI
 PvhboExJDs1Egt2deFlKpgqPaZLOcrWiOWiIayf8WBKruolbn01fUKdrRnkFlyCQuQaY
 E8kX58EDSC4jfB63w2+ju8aRPu870sdr/hhWFYmtdqQK+j+Vuzlu5ZQDH3md3iYXEVl/
 8PR442cHVuW8cTB2i5qioox+3qRXmYP1LNHCplBPHbnNC2fXGRFB4Xy58/+KZXxonQsS
 WZjA==
X-Gm-Message-State: AOJu0Yy0iWzIxzJ5xZcpVzpt5nihivYJV9ov3psexV41X9VD9JNr7yM3
 iTy+Rg0NoLyHhm51TVytaO4=
X-Google-Smtp-Source: AGHT+IGhesIlRWaq9WfrEdk15K59cYzmcYHiDVHSPlIdyec8oVxa8qk/7dIDDNAudrJxwJvdX7mlVg==
X-Received: by 2002:a17:90a:bd0a:b0:271:90d6:f335 with SMTP id
 y10-20020a17090abd0a00b0027190d6f335mr4623565pjr.25.1693288509254; 
 Mon, 28 Aug 2023 22:55:09 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 v22-20020a17090abb9600b0026d462d34ffsm9828649pjr.47.2023.08.28.22.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:08 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 0/8] vdpa: Send all CVQ state load commands in parallel
Date: Tue, 29 Aug 2023 13:54:42 +0800
Message-Id: <cover.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1029.google.com
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
commands. This patch series can improve latency from 20455 us to
13732 us for about 4099 CVQ state load commands, about 1.64 us per command.

Note that this patch should be based on
patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].

[1]. https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.com/

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

  - execute the live migration in L2 source monitor

  - Result
    * with this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 13732 us"
    * without this series, QEMU should not trigger any warning
or error except something like "vhost_vdpa_net_load() = 20455 us"

ChangeLog
=========
v4:
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

Hawkins Jiawei (8):
  vhost: Add count argument to vhost_svq_poll()
  vdpa: Use iovec for vhost_vdpa_net_cvq_add()
  vhost: Expose vhost_svq_available_slots()
  vdpa: Avoid using vhost_vdpa_net_load_*() outside
    vhost_vdpa_net_load()
  vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
  vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
  vdpa: Introduce cursors to vhost_vdpa_net_loadx()
  vdpa: Send cvq state load commands in parallel

 hw/virtio/vhost-shadow-virtqueue.c |  38 +--
 hw/virtio/vhost-shadow-virtqueue.h |   3 +-
 net/vhost-vdpa.c                   | 380 +++++++++++++++++++----------
 3 files changed, 276 insertions(+), 145 deletions(-)

-- 
2.25.1


