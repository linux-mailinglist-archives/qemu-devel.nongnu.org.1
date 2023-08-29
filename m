Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386978C0C2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauOC-0007jx-Px; Tue, 29 Aug 2023 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauO6-0007hu-UJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:47:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qauO0-0007WC-Vo
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:47:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so27637725ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693298863; x=1693903663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HzsiUfWpLVPHxp1Chkq4q1GCqb3d7nbeld0GV+M6y20=;
 b=Cv+O0dKRDpShpiyojJ4I4H3Kbtm5whJX/6NaPAp1+KEaKN6kYHyelCKIBfX2HYk4jh
 JuiDoNpaAPEglkiFQrSkMez6pwGX4dnhwQnwdtDPU26jLbI6KhazEjDuLAZDKf8QGGhs
 d+vZHvZp4kEV1t+hvrNZCYNZy69/1kVTY5yunWI6wSTTmSOYBg1uhID2bb1vp6e2GZSG
 BYWa6Qzl4ZsXFLd70HSzVRwMpltHkC2DbUStPkOBm/YH8q9UIxtOc5KCKc6fx+aN8itG
 fV+zEtTUhGn8DDB5uhCZ6PkHNPQIf9unnaoj4E4b8pD2W4P4nAptvBL3Lp1yTWx3m4I9
 MJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298863; x=1693903663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzsiUfWpLVPHxp1Chkq4q1GCqb3d7nbeld0GV+M6y20=;
 b=U988cFevt8ulaTlh6QAJBp4RAHeHab48qJrZhHNwz2/dQi2zO2NAv/eOf+lPk1Td5Q
 X4cbvSuzPzVxrv6duSGwHtz+Wt4baD5m7lrEbcvNOrcOl6i79X0D7DP9wZtXqVji4g2r
 rLN9iXDm3qZiPgPeQabt9BdKBV0lyTqoiEqJ5RBurwbXoy56GDfr0G88HZagjzXbQe7d
 xt176ItDpuD9A7ZgI75a6oi9kk+No2m/R+8B6FQblEK3uLFHIsPqjHRcITE7W9QX29tv
 9nQzuB0GIkOhCH7jOEcnHP8yLiiII3+DXv+RHyub6jDIgy/mnDRSak4zlbRbe1SjeDLR
 UiYw==
X-Gm-Message-State: AOJu0YxFEAkjSStaafB7928Sf+LcpwP4YqFxTrbzsnA2005ppmlXej5O
 3RgENWt7SBJW3JI0zlQcuUQ=
X-Google-Smtp-Source: AGHT+IHWgAZj/2Fy97N9H/y34XvHQmRJkZBsQOxdzMTTdFBnIv+xxZMYyQVx4ubVeEj/adrr/gybWw==
X-Received: by 2002:a17:902:d2c1:b0:1c1:eb8b:799d with SMTP id
 n1-20020a170902d2c100b001c1eb8b799dmr2825798plc.21.1693298863044; 
 Tue, 29 Aug 2023 01:47:43 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 z1-20020a170903018100b001bdb167f6ebsm8848297plg.94.2023.08.29.01.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:47:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 0/2] Vhost-vdpa Shadow Virtqueue Hash calculation Support
Date: Tue, 29 Aug 2023 16:47:33 +0800
Message-Id: <cover.1693297766.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x631.google.com
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

This series enables shadowed CVQ to intercept
VIRTIO_NET_CTRL_MQ_HASH_CONFIG command through shadowed CVQ,
update the virtio NIC device model so qemu send it in a
migration, and the restore of that Hash calculation state
in the destination.

Note that this patch should be based on
patch "vdpa: Send all CVQ state load commands in parallel" at [1].

[1]. https://lore.kernel.org/all/cover.1693287885.git.yin31149@gmail.com/

TestStep
========
1. test the migration using vp-vdpa device
  - For L0 guest, boot QEMU with two virtio-net-pci net device with
`ctrl_vq`, `mq`, `hash` features on, command line like:
	-netdev tap,...
	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
iommu_platform=on,mq=on,ctrl_vq=on,hash=on,guest_announce=off,
indirect_desc=off,queue_reset=off,...

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


ChangeLog
=========
v2:
  - resolve conflict with updated patch
"vdpa: Send all CVQ state load commands in parallel", move the
`table` declaration at the beginning of the vhost_vdpa_net_load_rss()
in patch
"vdpa: Restore hash calculation state"

RFC: https://lore.kernel.org/all/cover.1691762906.git.yin31149@gmail.com/#t

Hawkins Jiawei (2):
  vdpa: Restore hash calculation state
  vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ

 net/vhost-vdpa.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

-- 
2.25.1


