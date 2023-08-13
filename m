Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54177A645
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 14:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV9nQ-0002e0-1C; Sun, 13 Aug 2023 08:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nH-0002Zb-AD
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nD-0007yW-6n
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6877eb31261so2304215b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691928117; x=1692532917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HqNJmtyZKc+1TTSUOx7OVCOjIE+RV7DDXNmkl5fE+ho=;
 b=L/gnK2VZmf8INfrp3wHu/cimdPBeXU1VN+Z5Q2NVCqlD3KHq6IJfrwA9DFdKomkAba
 J4jMlfD1lYQnRcBoLdnnppyXl3LUDydVXQzOl0L+G1HvFu/kBG7Gu106Ob+eAyWbMaFZ
 33rseufqLKxo6FoR46PeoS6l6s6UuBbmPb93oDE2VRXddLJIbLuAbbr7Xg1BBzoI+pt1
 Ew3SXZHMCJudbY/QXJF5pbFYD1PSRMAF9wxrC8NuRptg8Bpr4V8hPvxox5PucI9RGXIo
 tpXATqY6qJd1Y9Ju6kYUA/UZ2VcIpDcpvYEl6ZjJtj+U2fRMDhSjZegB/oceON3PdQ9f
 xJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691928117; x=1692532917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqNJmtyZKc+1TTSUOx7OVCOjIE+RV7DDXNmkl5fE+ho=;
 b=AZapcjzzuHW3hVyIDJEBq6aJbwS08C8hIjUgyoHiIR6UevUigt37r+OIw7vxuP1fkx
 qaOiwCSuhsHzb39YelSghRBeeGMAu6QZMErCryYPsVvaq0+I1k3ia284ogFvZzFbWluk
 0VbrO56PbgqCkiQ2LSqY7NJz1AXcCuDv+RYY/TwtC5PPlkGytOG1dr958Gwb5JmXgilx
 ZQt4nyE6yT7PZCTEPXPrk6OsHCSwJFAgjqMJ0DaC3+6B6NTuGmWxJsk3xb/2c0JT4NvE
 IMa+wX528lWgbd7FpzFqrP3UldqgrldkhxarKyM8vkpuUUx94zcK9i7QCXGWXblbIxSh
 bkQQ==
X-Gm-Message-State: AOJu0Yxnkpw25by+XTFIwm+zvDt9bX+QTCBZYbTYc4xTLQSxrw78R4B+
 2Qfjr5nkTHrBouQlNbdY44M=
X-Google-Smtp-Source: AGHT+IH6chaiaP6ORRnQspRqxqQiUTEAQlprqknOLdKjuakdIaIdpoXwYifuyFQFc2qXwGkb607z5A==
X-Received: by 2002:a05:6a00:158d:b0:658:cbf1:d05a with SMTP id
 u13-20020a056a00158d00b00658cbf1d05amr8205280pfk.3.1691928117239; 
 Sun, 13 Aug 2023 05:01:57 -0700 (PDT)
Received: from localhost ([125.35.86.198]) by smtp.gmail.com with ESMTPSA id
 j17-20020a62b611000000b0067777e960d9sm6148792pff.155.2023.08.13.05.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 05:01:56 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH v2 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Date: Sun, 13 Aug 2023 20:01:51 +0800
Message-Id: <cover.1691926415.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
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

[1]. https://lore.kernel.org/all/cover.1691762906.git.yin31149@gmail.com/

ChangeLog
=========
v2:
  - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
loading the hash calculation state in
patch "vdpa: Restore receive-side scaling state"

v1: https://lore.kernel.org/all/cover.1691766252.git.yin31149@gmail.com/

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

Hawkins Jiawei (3):
  vdpa: Add SetSteeringEBPF method for NetClientState
  vdpa: Restore receive-side scaling state
  vdpa: Allow VIRTIO_NET_F_RSS in SVQ

 net/vhost-vdpa.c | 63 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 18 deletions(-)

-- 
2.25.1


