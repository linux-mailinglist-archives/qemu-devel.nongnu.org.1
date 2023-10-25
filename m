Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBD7D5F58
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSNi-0000UY-Db; Tue, 24 Oct 2023 21:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNg-0000U4-HR
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNe-0008Fy-Kq
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cace3e142eso32862655ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698196097; x=1698800897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NecS2w6CgW4BN2IHxM3K2PD7fARAsDgOSj+yqv9SwKs=;
 b=OZ9lxY3eFWTFloEXMleI+lSwTbqIzVeB1vfR36U4jwMoW5otFNZv6yNUemOtg6VLBd
 M6eD1IvIYAuFh1J+pYvYEN9RHEXExShI8QEcqpkiGgh4N4Bp1h3/QBpz4as5W/ofBWWY
 aDy/j9Gdbw+5fMudV5pm3gor9Jp5m/Ys/6bxJ4AYCTSV/WcuE0PVi1kTDjDAvZZ1ZWEp
 ONbYV/vUuLuQZ5nXvJ+u0PaWJLlUUhP91wYmpCA22xVS/+ll14L4S8Td6AkUBsQ2G+95
 B0vJwVonbDiPJoV9Mgii4etfoCMj4vDXob7TosXvIQ3NAY7lqbuw7ZsjxHV098En/4TS
 fj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196097; x=1698800897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NecS2w6CgW4BN2IHxM3K2PD7fARAsDgOSj+yqv9SwKs=;
 b=UM6t7zzSTI+sVanz3pHl5LuEu4so2OljB3yfI0JTyuf7/f+BG1f6s4Np7JIkYMYhHA
 14dlUYZ951BB56F8soThTjz80cA8RLRC71Tr06AskKCUUNQDwg9cKprr6UjUBo39ENSi
 s7UQ0Viuzjul4XOiNbgW6qZoCWD+hv7lID0siGcRMqYzBePC3wMPyzEZWq6bTP9AtuU2
 EI6l7UNMaCGonE8Qn7Ql0/09MLe0HhGbiyGF/LzoHjViQokZW0K4afdcAeZDQRQwYn1c
 04KUm9lnyhUFaGW5hwk02hS/KvOknPScvni7YTHi65HkLz82Vvuv/H0HLK0jAvTcNkop
 SxUA==
X-Gm-Message-State: AOJu0Yw/ArFlaGkh0VtMg6gzlYeog1UCu7m4sXTrEsgnxR9w8JQbQRLA
 xn6jrjgWSAc18rSOfBwasnw=
X-Google-Smtp-Source: AGHT+IEUwdYZsbAR2xf0oEME3A0h9//YFgLQ1Z5w4YOZ20jAbwYDlWxvQYM+THGV52a2My5ixdHXOQ==
X-Received: by 2002:a17:903:124c:b0:1ca:e92f:e7f4 with SMTP id
 u12-20020a170903124c00b001cae92fe7f4mr7020104plh.28.1698196096494; 
 Tue, 24 Oct 2023 18:08:16 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 2-20020a170902ee4200b001c73d829fb7sm8042131plo.15.2023.10.24.18.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:08:16 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Date: Wed, 25 Oct 2023 09:08:03 +0800
Message-Id: <cover.1698195059.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62f.google.com
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

This series enables shadowed CVQ to intercept RSS command
through shadowed CVQ, update the virtio NIC device model
so qemu send it in a migration, and the restore of that
RSS state in the destination.

Note that this patch should be based on
patch "Vhost-vdpa Shadow Virtqueue Hash calculation Support" at [1].

[1]. https://lore.kernel.org/all/cover.1698194366.git.yin31149@gmail.com/

ChangeLog
=========
v5: 
  - resolve conflict with the updated patch 
"Vhost-vdpa Shadow Virtqueue Hash calculation Support" at [1]

v4: https://lore.kernel.org/all/cover.1697904740.git.yin31149@gmail.com/
  - add do_rss argument and relative code in vhost_vdpa_net_load_rss()

v3: https://lore.kernel.org/all/cover.1693299194.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"Vhost-vdpa Shadow Virtqueue Hash calculation Support" in patch
"vdpa: Restore receive-side scaling state"

RFC v2: https://lore.kernel.org/all/cover.1691926415.git.yin31149@gmail.com/
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state in
patch "vdpa: Restore receive-side scaling state"

RFC v1: https://lore.kernel.org/all/cover.1691766252.git.yin31149@gmail.com/

TestStep
========
1. regression testing using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `mq`, `hash` features on, command line like:
	-netdev tap,...
	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,hash=on,guest_announce=off,
indirect_desc=off,queue_reset=off,guest_uso4=off,guest_uso6=off,
host_uso=off,...

  - For L1 guest, apply the relative patch series and compile the
source code, start QEMU with two vdpa device with svq mode on,
enable the `ctrl_vq`, `mq`, `hash` features on, command line like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
hash=on,...

  - For L2 source guest, run the following bash command:
```bash
#!/bin/sh

ethtool -K eth0 rxhash on
```
  - Gdb attach the destination VM and break at the
vhost_vdpa_net_load_rss()

  - Execute the live migration in L2 source monitor

  - Result
    * with this series, gdb can hit the breakpoint and continue
the executing without triggering any error or warning.




2. test the migration using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`in-qemu` RSS, command line like:
	-netdev tap,vhost=off...
	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,hash=on,rss=on,guest_announce=off,
indirect_desc=off,queue_reset=off,guest_uso4=off,guest_uso6=off,
host_uso=off,...

  - For L1 guest, apply the relative patch series and compile the
source code, start QEMU with two vdpa device with svq mode on,
enable the `ctrl_vq`, `mq`, `rss` features on, command line like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
rss=on,...

  - For L2 source guest, run the following bash command:
```bash
#!/bin/sh

ethtool -K eth0 rxhash on
```

  - Execute the live migration in L2 source monitor

  - Result
    * with this series, L2 QEMU can execute without
triggering any error or warning. L0 QEMU echo
"Can't load eBPF RSS - fallback to software RSS".

Hawkins Jiawei (3):
  vdpa: Add SetSteeringEBPF method for NetClientState
  vdpa: Restore receive-side scaling state
  vdpa: Allow VIRTIO_NET_F_RSS in SVQ

 net/vhost-vdpa.c | 76 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 23 deletions(-)

-- 
2.25.1


