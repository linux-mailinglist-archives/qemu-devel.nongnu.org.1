Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 169737D20BA
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quNm7-0004vJ-Jb; Sat, 21 Oct 2023 22:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNm2-0004us-Ql
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quNm1-0008Tf-68
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:01:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso23342665ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940056; x=1698544856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Iu3xgE4H0o6md740PwAk+ciW9VCG5zCZsc3oL/pt3E=;
 b=iecmjUJu0TBDqH3bW1Yu3POfQExUsVlmJbEim0mvukU/njptd7+gkQU2uQOmZepu5Z
 y5uiGRIl605P1I+at4P5v9W5UVaRzYfi3NPLL7JB0iqYyOv4DUHiVWTnvvy1/HSeTLqa
 H8ZkSVAIPVbWvTh7Oqop5a4USH3mmtRA0OH8W1TuHlKAtBXp4mguNfNnx9/MsMEk3WgO
 Yd4CvPpA1BzFShL8/YAbJn8YLcTQSt1TYostdxLzBqvKsoDHD4NPwyxwTtqacqcQQYPz
 0qCu4UGo+B8VTNjUqytaR5B/gBRWfTbEM+92b+pxRlUBbBlD0LmBFS9ABqCboMr5YY4Q
 fbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940056; x=1698544856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Iu3xgE4H0o6md740PwAk+ciW9VCG5zCZsc3oL/pt3E=;
 b=ibWGWJh5OgbguO3RXfmQKC6KLWwIKj+/vRarqw7vZuxoMEqi1aFXOHCf32h5G1Q6X4
 oymb1La3BfZxwbga9zR5safx+wsfn20IhfurB7nEaDTb5VZNzlor9GcrrZWl6cQGarVC
 WBz9rUGpZw2rei9IskCEslK/+kGW9AblGLhhAYvVrAkXlz0QjMATrNne//RKA0lX+gm1
 +u/ddvb4B2FW3yIq/dUDL6KDeNTZdzH17VG8ckeS8xk92QmAAV1mWd0eFc9hMUAyTalw
 Z/5QkCJCKfTHAU8I88I6Fc2IlUkRHMPX82lj/5++U6seeHm5ldAlaLptabUbEQ1sBQbH
 EQCw==
X-Gm-Message-State: AOJu0YzzxNfxLr5HyxORKWtUnQmCF34y/1BDPwOICqPYpa8kAviXqccg
 sZnni7ypMUvN0PiBO98WQko=
X-Google-Smtp-Source: AGHT+IFt4asnipcJXSdnbwc3J93/Kuud1tX6KUEeoNfKJvC+rzJ4Po1gUaBsIoEerDHjmDSqLINvig==
X-Received: by 2002:a17:903:189:b0:1c9:c879:ee74 with SMTP id
 z9-20020a170903018900b001c9c879ee74mr7672429plg.26.1697940055530; 
 Sat, 21 Oct 2023 19:00:55 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 ju17-20020a170903429100b001c0a4146961sm3767694plb.19.2023.10.21.19.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:00:55 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/2] Vhost-vdpa Shadow Virtqueue Hash calculation Support
Date: Sun, 22 Oct 2023 10:00:47 +0800
Message-Id: <cover.1697902949.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x635.google.com
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
v3:
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

 net/vhost-vdpa.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

-- 
2.25.1


