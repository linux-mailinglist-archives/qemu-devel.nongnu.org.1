Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ACC737541
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIf-0008OW-7o; Tue, 20 Jun 2023 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf6r-0003rU-5o
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:25:41 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf6p-0006Ss-Fu
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:25:40 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-be3e2d172cbso3805970276.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281931; x=1689873931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+NmhDLUDlX9G1igutWgl1hXjyHncAWgtZzqP6FNiwsU=;
 b=efQtiy0o47/jpdAW0STXu5tR6gJm1xcGnnHoPySH8LP1O5B6bkeOuaW7GFDMPz9pAr
 T0gFeLgeJCH/I8N+5KNAQu7rlQMHJhS75kgh3gYHWZTEeaXQLGMrGz2IkfRFqkIb6vYD
 rBVEUbVQH1sUDgDpwbJT3F1ftsb0Lsf4KwrWByBd82XYRbKs9NBeUjiVIkVkugnPxz89
 abEKAri5bJ9FnAnqFS/LK/IirNV9xKk4k2QZCIv4pmhyjK7yjpc+DC32PELd04h1ojqh
 eH4xAUhDzDL2XJOheR3ynUFXHTujb6LpFmDAZaKhp1+gr1BJawp/ivIZrsibBlrKMgp1
 r8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281931; x=1689873931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+NmhDLUDlX9G1igutWgl1hXjyHncAWgtZzqP6FNiwsU=;
 b=V1GdM9eolFoVtDWIOXodc1wtIGOadiyLzBLey3xKCDPBL37eMYThds3JNUZMyv5Ts1
 u92OGBgyMSNIBHIDq5rTG4QkO+kPJz+y71oVN0qbwYE3bxCR6OeG0roWoP0+BDRHQ15O
 RkuU/3FxxeKGOedbMTwNFUvpBqyh/L7Kd5x2jmXb5Ei6HBpKjghGTXexQJex+i8/p35U
 awXX6Gsxk+J24qPPsz7yeCOWp2OkmTqTmOLIQF6KYVG/mbQG94FumhIK4pjJ/mMtKUYv
 w436IPYvMyjL38NYNOqHYD7rrxXBC66TkzOYCsT8qyACAFF1BBAKQTeZnqs9191XOQmr
 t36g==
X-Gm-Message-State: AC+VfDyqW6EFKrTHdOpCAofHO44iLB3WAeJTlRStsF8Q+bsepjP9bwmg
 GNNaMcth1oWMXqnyN3vRyHQwgwM6+MVYyw==
X-Google-Smtp-Source: ACHHUZ5AsjjgD7tV/lTFO6N5z7j3mFTNw/gAZ1PD7cMeYZKHXVEA2G0RDJeS80HBtaiBHEQmUSOtAQ==
X-Received: by 2002:a0d:dbcf:0:b0:56d:4b17:7e9c with SMTP id
 d198-20020a0ddbcf000000b0056d4b177e9cmr10044442ywe.32.1687281931365; 
 Tue, 20 Jun 2023 10:25:31 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:25:30 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>
Subject: [PATCH v1 00/23] Q35 support for Xen
Date: Tue, 20 Jun 2023 13:24:33 -0400
Message-Id: <cover.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=jupham125@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

These are the Qemu changes needed to support the q35 chipset for xen
I based the patches from 2017 found on the mailing list here:
https://lists.xenproject.org/archives/html/xen-devel/2018-03/msg01176.html

I have been using a version of these patches on Xen 4.16 with Qemu
version 4.1 for over 6 months.  The guest VMs are very stable, and PCIe
PT is working as was designed (all of the PCIe devices are on the root
PCIe device).  I have successfully passed through GPUs, NICs, etc. I was
asked by those in the community to attempt to once again upstream the
patches.  I have them working with Seabios and OVMF (patches are needed
to OVMF which I will be sending to the mailing list). The Qemu patches 
allow for the xenvbd to properly unplug the AHCI SATA device, and all 
xen pv windows drivers work as intended.

I used the original author of the patches to get a majority of this to work:
Alexey Gerasimenko.  I fixed the patches to be in line with the upstream
Qemu and Xen versions.  Any original issues may still exist; however, I
am sure in time they can be improved. If the code doesn't exist then they
can't be actively looked at by the community.

I am not an expert on the Q35 chipset or PCIe technology.  This is my
first patch to this mailing list.


Joel Upham (23):
  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
  pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug
  q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35
  q35/xen: Add Xen platform device support for Q35
  q35: Fix incorrect values for PCIEXBAR masks
  xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities and
    PCIe Extended Capabilities enumeration
  xen/pt: avoid reading PCIe device type and cap version multiple times
  xen/pt: determine the legacy/PCIe mode for a passed through device
  xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
    check
  xen/pt: add support for PCIe Extended Capabilities and larger config
    space
  xen/pt: handle PCIe Extended Capabilities Next register
  xen/pt: allow to hide PCIe Extended Capabilities
  xen/pt: add Vendor-specific PCIe Extended Capability descriptor and
    sizing
  xen/pt: add fixed-size PCIe Extended Capabilities descriptors
  xen/pt: add AER PCIe Extended Capability descriptor and sizing
  xen/pt: add descriptors and size calculation for
    RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
  xen/pt: add Resizable BAR PCIe Extended Capability descriptor and
    sizing
  xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors and
    sizing
  xen/pt: Fake capability id
  xen platform: unplug ahci object
  pc/q35: setup q35 for xen
  qdev-monitor/pt: bypass root device check
  s3 support: enabling s3 with q35

 hw/acpi/ich9.c                |   22 +-
 hw/acpi/pcihp.c               |    6 +-
 hw/core/machine.c             |   19 +
 hw/i386/pc_piix.c             |    3 +-
 hw/i386/pc_q35.c              |   39 +-
 hw/i386/xen/xen-hvm.c         |    7 +-
 hw/i386/xen/xen_platform.c    |   19 +-
 hw/isa/lpc_ich9.c             |   53 +-
 hw/isa/piix3.c                |    2 +-
 hw/pci-host/q35.c             |   28 +-
 hw/pci/pci.c                  |   17 +
 hw/xen/xen-host-pci-device.c  |  106 +++-
 hw/xen/xen-host-pci-device.h  |    6 +-
 hw/xen/xen_pt.c               |   49 +-
 hw/xen/xen_pt.h               |   18 +-
 hw/xen/xen_pt_config_init.c   | 1103 ++++++++++++++++++++++++++++++---
 include/hw/acpi/pcihp.h       |    2 +
 include/hw/boards.h           |    1 +
 include/hw/i386/pc.h          |    3 +
 include/hw/pci-host/q35.h     |    4 +-
 include/hw/pci/pci.h          |    3 +
 include/hw/southbridge/ich9.h |    1 +
 include/hw/xen/xen.h          |    4 +-
 qemu-options.hx               |    1 +
 softmmu/qdev-monitor.c        |    4 +-
 stubs/xen-hw-stub.c           |    4 +-
 26 files changed, 1394 insertions(+), 130 deletions(-)

-- 
2.34.1


