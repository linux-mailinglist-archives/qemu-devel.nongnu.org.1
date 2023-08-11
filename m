Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF5779238
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTTp-0005sf-0D; Fri, 11 Aug 2023 10:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTTn-0005sV-PC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:51:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTTm-00021q-71
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:51:07 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6873a30d02eso1548435b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691765464; x=1692370264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lGGS85EdF+n2tsSxAgTDPy2Jb7EnRjrZDRNYv6vgzSs=;
 b=bfpd0bnRdHqEW3gk1x0Oxsr5k3IkhTWEPel83jI5H8am9LncZKFHD0N7OFKa9o2fjY
 YKo0miKMkwllnHtMreE0kiAxY6ktj/JnJIeTkkWBHkpc58Es46T9F+nV/uVRL8fobps8
 3pVVkjyPENbF6cB+kAJ4kJxUSC0pxahBqAKpm2lLoPyiUTNbOYle5taNvoRHaFoJCEnA
 wWy60BWfTJiBHIRqq7XHFKDojOq4dnJvcYUHz/C30i9QCagwO0A90i31Io6LGMiqCxsO
 HVrtWA8h3U4bc3WLT6IjuOVhXj+86y4G+xqrq4ndhq0NAFNpDhsVv/XWixOjRV1uHJzd
 0XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691765464; x=1692370264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGGS85EdF+n2tsSxAgTDPy2Jb7EnRjrZDRNYv6vgzSs=;
 b=fQqY1fXMr+KROSTiE7i4ZwtwGjQ+RPz3aGFD4ki5mNEE5l8ndYRtOE0XsurLTu1fwG
 2jP2mX6UZLUsEIibTqXM5NWa+FFRg4TcH2ujT3+atJPR+9Fv45vYXHUaXBcVczAcJx4E
 NCZpQ5R+7Nm0qUI2OZPNcX7MAcsxmsf41Qw0Z0YBQrfwe3PZlYkXd4kLkondPKZ4nAyV
 uj0uDJ/Szkqs6Chv5/Y2zKddFY5HWHXiI4mdXVrVSeoJyX3nt2vwMz/5zoDom69n5Hmn
 eFDv+k5qnw/Cv0HuAYAnxvbKdfpAAaXWgXgQX7RcOskJm5hfaIoRI9Xf5B0X4CbicPVI
 SEDQ==
X-Gm-Message-State: AOJu0Yw1iFPi9fMNu3uaZQG/2fmRLzzUphC77BxM3vjtC6uhuptPvSpB
 sFX7gQQYiIJl6hjv4FzRWTc=
X-Google-Smtp-Source: AGHT+IELlbMFrmXVkUWaWZPYOQEq9AhG7r5ZzVml8z57I19TPn5QM2K9vkogIEetp0jiDZ+KpClEQA==
X-Received: by 2002:a05:6a21:4847:b0:104:ad71:f080 with SMTP id
 au7-20020a056a21484700b00104ad71f080mr1914941pzc.34.1691765463980; 
 Fri, 11 Aug 2023 07:51:03 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 m16-20020aa79010000000b006827d86ca0csm3416849pfo.55.2023.08.11.07.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 07:51:03 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, 18801353760@163.com,
 yuri.benditovich@daynix.com
Subject: [RFC PATCH 0/2] Vhost-vdpa Shadow Virtqueue Hash calculation Support
Date: Fri, 11 Aug 2023 22:50:48 +0800
Message-Id: <cover.1691762906.git.yin31149@gmail.com>
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

Note that this patch should be based on
patch "vdpa: Send all CVQ state load commands in parallel" at [1].

[1]. https://lore.kernel.org/all/cover.1689748694.git.yin31149@gmail.com/

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

Hawkins Jiawei (2):
  vdpa: Restore hash calculation state
  vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ

 net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

-- 
2.25.1


