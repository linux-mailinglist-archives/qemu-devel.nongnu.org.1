Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8378C100
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaul6-0000EE-6s; Tue, 29 Aug 2023 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaul1-0000DD-Cp
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:31 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaukx-0000RZ-Gt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:30 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a88c422e23so2419401b6e.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693300284; x=1693905084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kt5NaLOPzgtctpYpbqbxiNfPAsCRtkv0E3nnj1188f8=;
 b=eD/BoF7iqMfdadO9T0bSYdyOCSj6XAr1EJEAE9RJp15O6EL/MSgxTvNVQUuDHgF3cd
 KCuGFDxh9UyFS6vv3Raqdkmo3b+mS6DTEmZ5spMGbUP3Ia+dZxW2qE/0Ayp8p6j2spu4
 5cxpJYBvS78oqEvoB+9/0yPZLbo4Pivf1y3zotKywrqgNtdsDWwfnfCHGdA7Ob9NQsjM
 csKO+LjnMXNKf+ANOGC/k/vfzTQR3IstqpQ4I+z0Q8NFNeR4BqduVWXts3zbwxIHzNG7
 KT1xGy5ZdvyRUy3K9lrdxRJTSSvI061bq6fo5hn4+6p7H9SOjBmjbfHW/FldKuxrJOaD
 QzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693300284; x=1693905084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kt5NaLOPzgtctpYpbqbxiNfPAsCRtkv0E3nnj1188f8=;
 b=fGPe1OrsUnmYEMFNpIdzS17r8BuXM063SP3SN2ah5OYPqGGKDltpEvSy7EdP6z2Yvt
 bANJxVKxhR5ugNLQ4ulGafKdVl5Oe2aMEgwx4htRAEOGrxGbd+VOS18ZFvzC2p73gPKE
 aIl0hwBD27sztJ+GnqfFnTx4JwDE5eVuFnAQWdiTaGD6iMrQCnp3yji1i+DeuR1E7bHN
 Eo2qx04T+pG6WIy49Tgg+YyyMrq+QqA0NxFWF/q/EjasKJ9T77iGUdFEj2yIbVCpp2QK
 UefK7u7VfZHI5zsZ1sgHZJ2XGlHouOV5xjPZnKx+QPshFIjRhpHN0v2oaA94hkH9fiVl
 Ewpw==
X-Gm-Message-State: AOJu0YyCq5lchPJXEUSmqMtzqobUEeZtavUZDFAPiYDSwy3hUNKj06GP
 ZMWGNACBNVuKwdbNU/Np/y4=
X-Google-Smtp-Source: AGHT+IEsGX2jWqeofgZWxHfEEnw0GvykHHoebCAfriVgdD6ehlxUKwcHuOvMbU3uh1/gltqbRzChQw==
X-Received: by 2002:aca:f03:0:b0:3a3:e638:78d2 with SMTP id
 3-20020aca0f03000000b003a3e63878d2mr10869686oip.12.1693300283995; 
 Tue, 29 Aug 2023 02:11:23 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 e14-20020a62aa0e000000b006873aa079aasm8337559pff.171.2023.08.29.02.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 02:11:23 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Date: Tue, 29 Aug 2023 17:11:14 +0800
Message-Id: <cover.1693299194.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x22d.google.com
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

[1]. https://lore.kernel.org/all/cover.1693297766.git.yin31149@gmail.com/

TestStep
========
1. test the migration using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`in-qemu` RSS, command line like:
	-netdev tap,vhost=off...
	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,hash=on,rss=on,guest_announce=off,
indirect_desc=off,queue_reset=off,...

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

ChangeLog
=========
v3:
  - resolve conflict with updated patch
"Vhost-vdpa Shadow Virtqueue Hash calculation Support" in patch
"vdpa: Restore receive-side scaling state"

RFC v2: https://lore.kernel.org/all/cover.1691926415.git.yin31149@gmail.com/
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state in
patch "vdpa: Restore receive-side scaling state"

RFC v1: https://lore.kernel.org/all/cover.1691766252.git.yin31149@gmail.com/

Hawkins Jiawei (3):
  vdpa: Add SetSteeringEBPF method for NetClientState
  vdpa: Restore receive-side scaling state
  vdpa: Allow VIRTIO_NET_F_RSS in SVQ

 net/vhost-vdpa.c | 63 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 18 deletions(-)

-- 
2.25.1


