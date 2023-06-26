Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8373DAFE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiHi-0002Dt-EV; Mon, 26 Jun 2023 05:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHa-0002D9-Ft
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHV-0006A0-U0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:14 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-98e0c1d5289so217418666b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1687770788; x=1690362788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1PBUTop7ogeJp5GaBxgT8u2seIPWHQa7lTNMzlDKA70=;
 b=gR5HExxuvFLNWrVw48ovJ0vx3o2ej/hk5ONjJGp7lALwiqy+I02F4/dvZ7NpMaOPY1
 BUdgvKmKP8adDATmUMGQ7TZ76Ez0QGhLshXXNVHSU6cFWZKtJwmzSTNtjOG3Lhdo8NNH
 S+Fisa7FJScSCkaNrA43CO3e7a9GJo/d1N1tDK7FS1zKHIo979Wfjx1utcNtlt2zQJ79
 kLflAcFmZMwQJzXnelgARROoZWe/tWrfoFN9NusSH10rnjh7741OLBStDthA5INy9BLT
 rvFDfl28crTC7kCdlzkiUnR7R1BiD8XvPAuYWXOqvjyfDEj+KIXlxNz2BztxLKr9z7DV
 zyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687770788; x=1690362788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1PBUTop7ogeJp5GaBxgT8u2seIPWHQa7lTNMzlDKA70=;
 b=SCfcIlfnou0fLzbcmkGNvCq0kBCGvSLptQJpTFzGtST5Tq03ideB5itaaf5w4zGCnf
 avuelZ3bRmRWC32IdOuRQGufAsDIWhTg5XKMcMnwsKZx4ozQfR+5EhWf5KbN930+lG4X
 o98ZHg6IXtnfFKKsMYvjVurviklOCZquykMC0ybBhTFxy0iuOEn6fT9qe6ZKw6Ri9Nps
 YFOPPhnWq/wSW59pNoNc90uwplABIQDYH3C022hv4Wzef4XJe6V1ExmNmgXvEF+LcPAT
 C8jeUQoiCkF7v+feI4QSO7ik08jvjsLObsN4zpe3nbCOLF0s9lACLC44Tx/X/1+BUH+D
 5mIw==
X-Gm-Message-State: AC+VfDz4OMiMNqoiu6howAZXr/26Wrs9HIJcXw/6mO8JLz1EqY3Ch7RE
 q/43gb/n5Roqs/7yTGwVk33ocg==
X-Google-Smtp-Source: ACHHUZ6311FuumwasVLoXwX5uwnM8sSKDDGiMv+rBLbSEwQYQInFy8eMddyFScjJsr8awXeS+iYgXw==
X-Received: by 2002:a17:906:d185:b0:98d:76f8:217b with SMTP id
 c5-20020a170906d18500b0098d76f8217bmr6330569ejz.73.1687770787748; 
 Mon, 26 Jun 2023 02:13:07 -0700 (PDT)
Received: from localhost.localdomain.cc ([62.4.35.38])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a50fc17000000b0051c7b5692easm2597693edr.7.2023.06.26.02.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 02:13:07 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v5 0/2] vhost: register and change IOMMU flag depending on ATS
 state
Date: Mon, 26 Jun 2023 12:12:56 +0300
Message-Id: <20230626091258.24453-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=viktor@daynix.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When IOMMU and vhost are enabled together, QEMU tracks IOTLB or
Device-TLB unmap events depending on whether Device-TLB is enabled. But
even if Device-TLB and PCI ATS is enabled, the guest can reject to use
it. For example, this situation appears when Windows Server 2022 is
running with intel-iommu with device-iotlb=on and virtio-net-pci with
vhost=on. The guest implies that no address translation info cached in
device IOTLB and doesn't send device IOTLB invalidation commands. So,
it leads to irrelevant address translations in vhost-net in the host
kernel. Therefore network frames from the guest in host tap interface
contains wrong payload data.

This series adds checking of ATS state for proper unmap flag register
(IOMMU_NOTIFIER_UNMAP or IOMMU_NOTIFIER_DEVIOTLB_UNMAP).

Tested on Windows Server 2022, Windows 11 and Fedora guests with
 -device virtio-net-pci,bus=pci.3,netdev=nd0,iommu_platform=on,ats=on
 -netdev tap,id=nd0,ifname=tap1,script=no,downscript=no,vhost=on
 -device intel-iommu,intremap=on,eim=on,device-iotlb=on/off
Tested on Fedora guest with
 -device virtio-iommu

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2001312

v5: add vhost_toggle_device_iotlb to vhost-stub
v4: call vhost_toggle_device_iotlb regardless of vhost backend,
    move vhost_started check to generic part
v3: call virtio_pci_ats_ctrl_trigger directly, remove
    IOMMU_NOTIFIER_UNMAP fallbacks
v2: remove memory_region_iommu_notify_flags_changed, move trigger to
    VirtioDeviceClass, use vhost_ops, use device_iotlb name

Viktor Prutyanov (2):
  vhost: register and change IOMMU flag depending on Device-TLB state
  virtio-net: pass Device-TLB enable/disable events to vhost

 hw/net/virtio-net.c       |  1 +
 hw/virtio/vhost-stub.c    |  4 ++++
 hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
 include/hw/virtio/vhost.h |  1 +
 4 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.21.0


