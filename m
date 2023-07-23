Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2F75E1B4
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXu7-0006eY-53; Sun, 23 Jul 2023 08:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXu3-0006e4-3b
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:35 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXtx-0007yS-Im
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:33 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-56341268f2fso1654829a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114166; x=1690718966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=glxwg3DPk+t43wBaRZpt9exepTdVy6nF2qQOdekCE6g=;
 b=VoDvHaV+M2l/prYlrWvQh4OjxSNCMabbix5yEzvtY2NzN9WjfRpTYfTPb9/XRFVwDB
 hD75PKE2traGqsHShNiS3KtGO6vG4sqq41ocjId+T7IrVhLlYQXKyLqxFfiTcBtUOZff
 6F6DjAF0r2xh74mRGar9r6RRCeC5ufzTMCJ0wxEfDi5ALt2drgalqMCsvMuWOH9/UBj/
 gNZqty7b/1FACX6FvwYiIuMN+2aRYJ2TnKxleNp+uyYMxvIWjveDkt3+5pCTrXACywRi
 QgwLcPi+v099G+rOMLKXuWBo5y/IIt0sd3J/RjwC41zzzf2aKF2T4z2r3xPyJzlgaNAL
 QkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114166; x=1690718966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glxwg3DPk+t43wBaRZpt9exepTdVy6nF2qQOdekCE6g=;
 b=aBE43j4wSzx6wuJ+IoxspBHWcSwF1JCpLIYWivrK+kq3ao3GHlB1XTQf13stj/u+rw
 hyM8l+nyuhEV4TiKGOBQMcBSwIioIsxb6afYInNz+ZE2ZF/+akJdQ8EngK9Qy87jbr0E
 8lm6pDI3gFa/afuHIM/3j47CwmXikDCIgngoJe0ErmB9MLBKHcYRD6GjP16gKzeuNIUX
 ZYbkBRvqRT2dCvHZaWcpfVrf9fKtMtaMZHvj9H4oedFOjJxRjIjBnSeB8JSb+YpTtlJw
 FxFmMnoNsFoxSLLinNq3AWds0FhzBIYBTJjHASSQuQBdMLjSm6C/TXSOE8vDuGAyqJFh
 Idtg==
X-Gm-Message-State: ABy/qLaMhNa98Bqj1e9GgxxztP35wd2heHot+MNTrxzs0U9YODv1ijlH
 4JObLwRRrD0G6PvOPpEMl5Y=
X-Google-Smtp-Source: APBJJlGXkTDvV+DmRDfEpRWa/rywdWO89t5D7vBBrw5ST4JhadWaaj3szS1+lOUEzYEW0nPp1WLDCg==
X-Received: by 2002:a05:6a20:7d87:b0:10f:f672:6e88 with SMTP id
 v7-20020a056a207d8700b0010ff6726e88mr7531383pzj.4.1690114166293; 
 Sun, 23 Jul 2023 05:09:26 -0700 (PDT)
Received: from localhost ([223.104.38.215]) by smtp.gmail.com with ESMTPSA id
 x7-20020a62fb07000000b006862af4914esm6066243pfm.145.2023.07.23.05.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 05:09:25 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
Date: Sun, 23 Jul 2023 20:09:10 +0800
Message-Id: <cover.1690106284.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x535.google.com
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
v3:
 - remove the extra "From" line in patch 1
"virtio-net: do not reset vlan filtering at set_features"

v2: https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.com/
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


