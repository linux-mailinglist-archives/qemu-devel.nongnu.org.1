Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 672297D5F52
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSIB-00059x-6m; Tue, 24 Oct 2023 21:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSI7-00059f-W1
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSI6-0007X6-2I
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:02:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so4077806b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698195751; x=1698800551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UcuXpzxHQREbSdw8YR9EuF2IGhId7WepqKSlhEe9Bq0=;
 b=LZNa65dhzgft4+N7NA7SunQBfHmwS6b3DjtQ32ZeqlQmX4gP6pquto+temFiDmy+Ki
 qwGtKOMaEGZcGJmka6q+WJZsOZhFaiwphigjqLd9ud006DowuylTgZXy47DUUd/A0TWD
 S3StVWrcosQP/Ikh0umA0cP5fHrGo7M/5YDQOIBJkALbWzoypbQsf+15J8w2aB0pM2IK
 Ymv8Im3nYDrgu89Ak0i/F0I/mE5hZ8iI47t72yswfQWFbkPEdd5wRzXIOk9YBblCp+Cg
 k+jKRq7TMkKZ23eQTj7KgAoXyeceNRCXYoNLYFwJFbkoOmUryeU4rioKhZ8oIdkOwvLy
 mU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698195751; x=1698800551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UcuXpzxHQREbSdw8YR9EuF2IGhId7WepqKSlhEe9Bq0=;
 b=O15vyckr3vuMenZQ+kxmiAGDaNRRuaAPbNO24+GM7221+EbybmeXdRJrnAAgtmTVH2
 NMjjzK1Fo+Y85lFbjmoaQI7IpgpsF5cnjFIOeEWf34xobYJdy8xeDjFewtl1R5MK/KiJ
 Yiea+C6jV3N/Kzvd4HpkxMMqzATZWredBiybkVTQiyBeg2UbTcTMt9+r9reHmV86NPPj
 hr7kkfd9RfirkGqkGzKlJOtCCnmC+Ee+osqCIHRMkN487ltMnlIlxGxtinapBYyBRBMv
 JjvNXJVRCzJn05HUBwFFOhzgW/PaT/1FSXBon6G/vy+YVIZtA9DGdndC1Exu5U7nPlwq
 My/g==
X-Gm-Message-State: AOJu0YwU+gPiy9p66LO5o1ypXqbKQNeLC47QuixW+/xeIn5/ihf2AJ+g
 S8rN7BgE6l4siokjoqI5Plw=
X-Google-Smtp-Source: AGHT+IH0M815kh247X1qu+W+pEpcmeuv/glf6g3UVfF/3E/ljeHRsM+C4wiIqrtOqepszgc5UZcEnQ==
X-Received: by 2002:a05:6a21:47c7:b0:17e:5d2f:f439 with SMTP id
 as7-20020a056a2147c700b0017e5d2ff439mr4697109pzc.46.1698195750561; 
 Tue, 24 Oct 2023 18:02:30 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c1cc00b001b03f208323sm7999943plc.64.2023.10.24.18.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:02:30 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 0/2] Vhost-vdpa Shadow Virtqueue Hash calculation Support
Date: Wed, 25 Oct 2023 09:02:23 +0800
Message-Id: <cover.1698194366.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42a.google.com
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

ChangeLog
=========
v4:
  - fix some typos pointed out by Michael
  - zero the `cfg` fields at the definition suggested by Michael

v3: https://lore.kernel.org/all/cover.1697902949.git.yin31149@gmail.com/
  - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
  - zero reserved fields in "cfg" manually instead of using memset()
to prevent compiler "array-bounds" warning

v2: https://lore.kernel.org/all/cover.1693297766.git.yin31149@gmail.com/
  - resolve conflict with updated patch
"vdpa: Send all CVQ state load commands in parallel", move the
`table` declaration at the beginning of the vhost_vdpa_net_load_rss()
in patch
"vdpa: Restore hash calculation state"

RFC: https://lore.kernel.org/all/cover.1691762906.git.yin31149@gmail.com/#t

TestStep
========
1. test the migration using vp-vdpa device
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

Hawkins Jiawei (2):
  vdpa: Restore hash calculation state
  vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ

 net/vhost-vdpa.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

-- 
2.25.1


