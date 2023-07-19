Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11360758F7B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1uo-00005x-3w; Wed, 19 Jul 2023 03:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uP-0008Rj-Kr
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM1uO-000269-4k
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 03:47:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6687446eaccso6587142b3a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689752858; x=1692344858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EuctLHKFpfIIcAY/FmjWvDpVmkm2uPH09eV5HTrhp9I=;
 b=iUUlZqU2mQe6Fb20jjC4kpCqfjl5b/wt8Cflbrd3SjsnU56m3b4a99dZzmhX9vrSYL
 a9zzplgOExSMD9E9JSE9qCFfO3Nh5StcmMGZXrNQyuTTKmgraZvfdMBmfT3/bKJNWwxC
 wzzbt0r85LstpNS98ST9YiDzAM5tQztFZAeQfRVOJkeAR7MUE+HqXKt1a+hFaD/lO1I+
 KMHncHIqvbRlawYoPrDAhbcXZ/nbioCKyX+yATKq3gl0MAlbO0p0vXCfWZ3aqf4rVhIi
 kPgvNig6J4EUGMZ9zPDSAXle6AXHz12e1WlI0jjRA7HpNzQ/hiCdNdxwHzqIfV3ohtpn
 axfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752858; x=1692344858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuctLHKFpfIIcAY/FmjWvDpVmkm2uPH09eV5HTrhp9I=;
 b=gBfPEe18atCjhSLvCecNxLbtpJqGqGXrq68EGcBjXqqa+LksE43dL5jlpVjFrWayh8
 TMENVnkKQuh19go6th5crIzOg8dkYjWBkkkUd5C4D+Hwo25Tzq0GxnNSQbORpxIL8GZw
 7WB1RqhX8wo02xtp7E+3FFYd6cJxo9s+243tnL6o8sFoZiT1oTQGx0RBI9tS+O2wMokw
 OIMjlpHOF04RPjcX/A28DiwFtMxXcIxfSPYco27lt4srFoDVxH7N2WF/jM2d73nNv/sl
 Y96t94lsCCufai4FFSTneXVUEAPzscydWS2whGUothDxZrSLeTHfOrRzG2I1H9rGK98x
 w/GA==
X-Gm-Message-State: ABy/qLY2wkdZMWt248j4H0W/qqeWSW6FIK6McmYNFjVZV0CB2+XwF+8S
 wWd/Aiu1aeRheE6zqyrmRHI=
X-Google-Smtp-Source: APBJJlHO6ld/EIpH4jUW/UlIAUVpKM5zwfl+UsVlDgXq+SrbS+B6DvfiV3hWjU8gTXlhvEMOKMpKAQ==
X-Received: by 2002:a05:6a20:9493:b0:12f:a373:ba8d with SMTP id
 hs19-20020a056a20949300b0012fa373ba8dmr16396932pzb.24.1689752857514; 
 Wed, 19 Jul 2023 00:47:37 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 m18-20020aa79012000000b006579b062d5dsm2679473pfo.21.2023.07.19.00.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:47:37 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
Date: Wed, 19 Jul 2023 15:47:27 +0800
Message-Id: <cover.1689690854.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42b.google.com
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

 hw/net/virtio-net.c            |  6 +---
 include/hw/virtio/virtio-net.h |  6 ++++
 net/vhost-vdpa.c               | 50 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

-- 
2.25.1


