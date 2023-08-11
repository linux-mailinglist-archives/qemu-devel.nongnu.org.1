Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5477931C
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUU4g-0003KK-Ju; Fri, 11 Aug 2023 11:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4N-0003Jf-9D
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:28:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4L-0001Z5-Dx
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:28:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdba48eccdso4844955ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691767732; x=1692372532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ietL2Lz7Q3Nw+5nv4dfNGrD7n7+rDGG9MBK0CR6FM74=;
 b=qCMAcLQu03iTquKNh+T6gee9qeIm/JDvTIXy1NvIPWyaG/pAc07ZzzFnFdctdk2bA5
 u6YM5eS3rOJ71g/mayLCSiIQ0SwkGqHFGE5fHn9z7eaAgq1H9L3QIpvQcRISp/4YVNQl
 4WuCM77IxShSplp3XYPuzayR5t+5Ll8M0ZOXKt1fy4Xe4E5Bse481NbHjpfnp4291yE+
 0yOCbgT/HzOgdkiq7gdKwZYV4JUZxoycGDdyUqmtEH0WyaJ3FSKrAI7oV1ojAremqu5i
 9DNEqv51CCT952TYUGGXez32b5FVHwuM2BhivPZ5YNzAqH5+FKdCSJc1DqNXzFulzbZr
 jcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767732; x=1692372532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ietL2Lz7Q3Nw+5nv4dfNGrD7n7+rDGG9MBK0CR6FM74=;
 b=TI4IxrqBf/VBVawhe0Nvh9ptlDB7boGFewZn9eCl1K6maEJVo+ohQ12sqvIOgPgbS8
 JNIgqZQuuFzFX43gLPF06oRTr7A1OaVqaRgL5sqb/n/g8C/BY4Udm4w2rMgJwYTXQ4pf
 /ddkxhI02uZwt875hpAk+L6KVgc1sW6jPGzEMX+5l/D+wWmtPHvH1D/73bvsLjo5scM7
 A3mANutqTUhgyBlJlShf/WK7qTTBdxvR4ymRHJCUBjE9zaffbUTiFkLpmK3gltkLXxBf
 qpJM6CFnqNTl5oipFcWdon2TRc0IJaJTAYsO05vTAnAD3mAD4NqOIqv/GVf3pXX74upS
 9YdQ==
X-Gm-Message-State: AOJu0YyJpcQ0MqCuzum9IFM+6ujGBiw/Gwe+AqwGvaZulMpybf46PUT1
 1SfC7LaW334cpY81lcO96lA=
X-Google-Smtp-Source: AGHT+IGSbU1rC7f40Oq6Xr2yq79ygg4umTfpku8Z9pao5s3TeN7todRGHdCIAzrTLj3E/zXFymL4eg==
X-Received: by 2002:a17:902:a405:b0:1b6:6e3a:77fb with SMTP id
 p5-20020a170902a40500b001b66e3a77fbmr2028669plq.2.1691767731563; 
 Fri, 11 Aug 2023 08:28:51 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 f3-20020a170902e98300b001b8a897cd26sm4034457plb.195.2023.08.11.08.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 08:28:51 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Date: Fri, 11 Aug 2023 23:28:41 +0800
Message-Id: <cover.1691766252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series enables shadowed CVQ to intercept RSS command
through shadowed CVQ, update the virtio NIC device model
so qemu send it in a migration, and the restore of that
RSS state in the destination.

Note that this patch should be based on
patch "Vhost-vdpa Shadow Virtqueue Hash calculation Support" at [1].

[1]. https://lore.kernel.org/all/cover.1691762906.git.yin31149@gmail.com/

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

 net/vhost-vdpa.c | 62 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 18 deletions(-)

-- 
2.25.1


