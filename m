Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E37D20BF
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quO0y-0005p9-Ix; Sat, 21 Oct 2023 22:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO0w-0005ox-5Q
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:26 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO0u-0003Kz-LV
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:25 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2e22a4004so1581198b6e.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940983; x=1698545783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h0Nn7ykEFiIg5X13Nkv5CbkqLn8sjkHkKUxeNYr9uEc=;
 b=IOXK5F6Y4QCKCT255HXLcOyQKm2oGL5ruiPNWR+Yr3BIRdKlU+0KtDCkCbT61rpu5z
 wX8oV3wUx/s2HZT0TEgCSfbpdEjltn6+koCsYVOUf9IRCVD+uOh8rSzjtTN4cSmSmo1r
 3mkyBB54XD185IN+a84wB2QimPg1PGRnVlcOWbGuAncFLJ+sFBfMGfYaHlDtTd8UlYyF
 zM4drhdsKXbOGOQRcfmek2y6Ny3P8cTNuG99rUp2bcrakwjI21rdLygShtElcMFpy1Yc
 YP/HA+Y8hQwTCO+4Om6vhI5BRSfzZ17z5Wjv+acfeLJE1Z95UhBSSNY60M3A1RiwxkCv
 /50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940983; x=1698545783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0Nn7ykEFiIg5X13Nkv5CbkqLn8sjkHkKUxeNYr9uEc=;
 b=oq3zecQVwirUNvd84ODzGbXgBnLHiX5oP8gfyoaewtps7WkFFIL5qTGzhz9esSjAjZ
 H8SvWIVM8qR52spWvyIPfJshH/j1GDEkmkVBDZ+JZkk25p0O/y5j/5NwfOX5yjPQDjNd
 NVRoTT8qp8kNPtHOOfttvpzfSZ2FemmBuVfUv0RO7/QXfcnn0iyX/Bgkj76kAQ5RpB1W
 j+afwrjdRWRGnMJLiyKcEWwUXjCWVtoVz+uEJggq6I0Rp2O+cXMqTiZUqEMtc5eWl4J1
 Vov0j8zFFI+4jun7KtgzAlhdcxPH8VPeEijexQUmBvQShnLRP5JOCUVr5u1scZmYjxPJ
 G0Iw==
X-Gm-Message-State: AOJu0Yys2D7aBvCRivUT8+r2ycjDWEg0Q7/su2EfUW1a+WOQ9LR4buW1
 9HWmbmnNjH8JMANkl/G9hS48aeXvfu9WRTfZvus=
X-Google-Smtp-Source: AGHT+IFbx50AIWOOnW8/LwPQJt4rGLnh5yvlj08FzohIwxEQTO8unsGTRSjc7pGNOIneJM4BvRRCCA==
X-Received: by 2002:a05:6808:60e:b0:3b2:defb:e562 with SMTP id
 y14-20020a056808060e00b003b2defbe562mr6346665oih.45.1697940983120; 
 Sat, 21 Oct 2023 19:16:23 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 z4-20020aa79904000000b006b6f3bc8123sm3846881pff.50.2023.10.21.19.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:16:22 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Date: Sun, 22 Oct 2023 10:16:14 +0800
Message-Id: <cover.1697904740.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x235.google.com
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

[1]. https://lore.kernel.org/all/cover.1697902949.git.yin31149@gmail.com/

ChangeLog
=========
v4:
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
1. test the migration using vp-vdpa device
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

 net/vhost-vdpa.c | 72 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 21 deletions(-)

-- 
2.25.1


