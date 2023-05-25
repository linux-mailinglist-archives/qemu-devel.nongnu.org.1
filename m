Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A29710CA9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AXY-0003d4-Oo; Thu, 25 May 2023 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXW-0003ck-Vi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:57:59 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXU-0004o4-RW
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:57:58 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f3b9e54338so2411457e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685019475; x=1687611475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SaV9Zz/45xxhv8DmW+1aV9g5PjLgMzwfRc+MrhumrqA=;
 b=VyTrl78/3kHZKGv9n/qh14HsuZD2YYGtDaSSdkK3cpNWJh0qNH9ahi1idUJhd90adK
 OyXw5Bi6UcC6Ar11T02uMlZ2XvS680ROuI9JTTcyztjy7eTxBNsSzlrnZXsyBfiXyA6v
 bvd0up9ZMIwQ7o2dPQPSNh+ToUdxPYuTILYS0lqy4IIwLaprwBJrsxnY03kCaO5oZPFg
 ZAWsMmDGhWhf2atGkZwio0C8rYhx8OAf9cTR6VR1/HXAyIUzi7Nfpt5KyiVIW8lEA4ez
 mooB5zshEifsAR30TuUxk2JTXYxjYtMskxUqcYPOxwqkOkUIyrfZ8RCw9wYNE3MjlGKT
 PYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019475; x=1687611475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaV9Zz/45xxhv8DmW+1aV9g5PjLgMzwfRc+MrhumrqA=;
 b=U41DHe7WjcSrJqiYzwgMS9vnBf9AWGixAOML9IBZsx7zPe+ufq2J5SvNxPsU5S+b3R
 l+7wZXDr5Dv8hz2ok3ePm3OJRfC/PJKODVSXMlRGgsmhlhJbV/5yP6yNMUHSMCF8J8yQ
 X0nkIMQBWI84gVGNc0Zw0bJYCGoOxiQXpgFc5Mz4HMgOX7n9G9Sh6eDwQhhFv4GbkXH6
 MfTzJLkw1T8dyCrgEgByX4+yfC02tdIVaATe+h+wj1tstiObq/zoLi6BvRP4ov4U7vgz
 zOB6B/YEO86W5vUbEZ1nQl2FmrGT7E/MaG9/6Gn2v0YIVFK9tNkR+WIg92uWA41naFvq
 Xqhw==
X-Gm-Message-State: AC+VfDzHDqli2xRi8x7swU2Lnd2AyGxbfCAgYKfT6DzpQ5FKV2qodXCw
 +7nO0eIthr2rOVDJGSjRpmqx3w==
X-Google-Smtp-Source: ACHHUZ44SM3seC8zGEZslHfLniB4jTKTK80Sx2XlTjNo+6FSHqfJzEj5eO2ovU9HigSXa2vWyeF2Sg==
X-Received: by 2002:ac2:519c:0:b0:4f3:a820:dd8b with SMTP id
 u28-20020ac2519c000000b004f3a820dd8bmr5771933lfi.31.1685019474967; 
 Thu, 25 May 2023 05:57:54 -0700 (PDT)
Received: from localhost.Dlink ([94.188.60.65])
 by smtp.gmail.com with ESMTPSA id
 r9-20020ac25a49000000b004f1430ee142sm209509lfn.17.2023.05.25.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:57:54 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v4 0/2] vhost: register and change IOMMU flag depending on ATS
 state
Date: Thu, 25 May 2023 15:57:40 +0300
Message-Id: <20230525125742.4190-1-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::132;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x132.google.com
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
 hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.21.0


