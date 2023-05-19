Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBB709A6D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01QO-0006yl-PI; Fri, 19 May 2023 10:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QN-0006ya-1t
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QL-0003G1-7C
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1xdeVgMpfooe9go3slx9PNk5dyeYPABczVEFjcv6058=;
 b=aJQ0KQKLi92T6uHPVlHeH6Ltzucm4YT5p2Nsaujh3ApJ/gmZtRlcrzC6CR0Jp36acn3c76
 o7w4kKgbbvxWQLcrjmpOuF4rOHQCckXMUUGhTz4QWqm+h4gMvLXQsRdpY77GFgfZ1BfPKg
 AI5HLJe2gI6vzls0yaRFw+OnJAg0oOI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Pj5j6EYjPk2Eu82oFB_DDQ-1; Fri, 19 May 2023 10:49:38 -0400
X-MC-Unique: Pj5j6EYjPk2Eu82oFB_DDQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f13ecb8f01so2123162e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507776; x=1687099776;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xdeVgMpfooe9go3slx9PNk5dyeYPABczVEFjcv6058=;
 b=SfMymySIwL2hbapEQ6b2vnP0GkaLr2x9qMarcEkcUs08mefB2DWN4Fh/SLTQ12zwuu
 XN9ct53akfsZyWB1OYKl4pVRR0SDqqH039PXBFYvNn29WKSBHxU8Z6XoonGzrx4HfNWi
 Ir8V3187eRoKE8tM/0eb2uBP9L/ApbDJuUopAXglzLA2/6zJ3fYFtr1fihqphK9CrDEp
 qu/m80UVN1oVRjy29m3HBRpNOLmMLnUqcfaQ5CvW8RxQfKWUbyzgTtXOE1V72EuFJXzX
 FUTzf4AV2V2e0uM+S6ruc6uvccZ/jEpkMzRZ5FC7aMY782oIBG1JcCKHoipE0N1X4Y/c
 Hs/g==
X-Gm-Message-State: AC+VfDwfIVcyLF+lLE7H3VvmVaZCS+F/gtJMV0Nfw+ZNVxoQ/xDnk3Cq
 72H6yMxEmIV1Fh/Uk9EQJisDI5odLGg4DooCoYoE6KRoz8vegjOS3bF8f748rIk2Za/eeYmSRW2
 eUxh2cY3dn0GOwAIaO8yta0dUS218h9dUFsTs8YIL/VVefcRYGNkKihq4Rbi2gg9VPBxA
X-Received: by 2002:ac2:5333:0:b0:4ed:d2cf:857b with SMTP id
 f19-20020ac25333000000b004edd2cf857bmr935642lfh.5.1684507776384; 
 Fri, 19 May 2023 07:49:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EkwJCnc20/f/WoH442j6POvLTI513BPvNyd5g+g9WUnMd04zjtK7ywvO+/ntdGxJAaKnLcQ==
X-Received: by 2002:ac2:5333:0:b0:4ed:d2cf:857b with SMTP id
 f19-20020ac25333000000b004edd2cf857bmr935636lfh.5.1684507775910; 
 Fri, 19 May 2023 07:49:35 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 w9-20020a19c509000000b004f391a2028dsm612062lfe.265.2023.05.19.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:49:35 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/40] virtio,pc,pci: fixes, features, cleanups
Message-ID: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 297e8182194e634baa0cbbfd96d2e09e2a0bcd40:

  accel/tcg: Fix append_mem_cb (2023-05-18 09:28:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 87af48a49c0a5663b3fff58c3407393772d3c448:

  hw/i386/pc: No need for rtc_state to be an out-parameter (2023-05-19 10:30:46 -0400)

----------------------------------------------------------------
virtio,pc,pci: fixes, features, cleanups

CXL volatile memory support
More memslots for vhost-user on x86 and ARM.
vIOMMU support for vhost-vdpa
pcie-to-pci bridge can now be compiled out
MADT revision bumped to 3
Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bernhard Beschow (9):
      hw/pci-host/i440fx: Inline sysbus_add_io()
      hw/pci-host/q35: Inline sysbus_add_io()
      hw/i386/pc_q35: Reuse machine parameter
      hw/i386/pc_{q35,piix}: Reuse MachineClass::desc as SMB product name
      hw/i386/pc_{q35,piix}: Minimize usage of get_system_memory()
      hw/i386/pc: Initialize ram_memory variable directly
      hw/pci-host/pam: Make init_pam() usage more readable
      hw/i386/pc: Create RTC controllers in south bridges
      hw/i386/pc: No need for rtc_state to be an out-parameter

Brice Goglin (1):
      docs/cxl: fix some typos

Cindy Lu (4):
      vhost: expose function vhost_dev_has_iommu()
      vhost_vdpa: fix the input in trace_vhost_vdpa_listener_region_del()
      vhost-vdpa: Add check for full 64-bit in region delete
      vhost-vdpa: Add support for vIOMMU.

David Hildenbrand (2):
      virtio-mem: Default to "unplugged-inaccessible=on" with 8.1 on x86-64
      vhost-user: Remove acpi-specific memslot limit

Eric DeVolder (3):
      ACPI: bios-tables-test.c step 2 (allowed-diff entries)
      ACPI: i386: bump to MADT to revision 3
      ACPI: bios-tables-test.c step 5 (update expected table binaries)

Eugenio Pérez (1):
      virtio-net: not enable vq reset feature unconditionally

Gregory Price (2):
      tests/qtest/cxl-test: whitespace, line ending cleanup
      hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)

Hao Zeng (1):
      hw/cxl: cdat: Fix open file not closed in ct3_load_cdat()

Hawkins Jiawei (1):
      vhost: fix possible wrap in SVQ descriptor ring

Ira Weiny (1):
      hw/cxl: Introduce cxl_device_get_timestamp() utility function

Jonathan Cameron (6):
      hw/cxl: cdat: Fix failure to free buffer in erorr paths
      hw/cxl: drop pointless memory_region_transaction_guards
      hw/cxl: Fix endian handling for decoder commit.
      hw/cxl: Fix incorrect reset of commit and associated clearing of committed.
      hw/mem: Use memory_region_size() in cxl_type3
      hw/cxl: rename mailbox return code type from ret_code to CXLRetCode

Leonardo Bras (1):
      hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0

Mauro Matteo Cascella (1):
      virtio-crypto: fix NULL pointer dereference in virtio_crypto_free_request

Raghu H (2):
      docs/cxl: Remove incorrect CXL type 3 size parameter
      docs/cxl: Replace unsupported AARCH64 with x86_64

Sebastian Ott (1):
      hw/pci-bridge: make building pcie-to-pci bridge configurable

Stefan Hajnoczi (1):
      vhost-user: send SET_STATUS 0 after GET_VRING_BASE

Viktor Prutyanov (1):
      virtio-pci: add handling of PCI ATS and Device-TLB enable/disable

Vladimir Sementsov-Ogievskiy (2):
      pci: pci_add_option_rom(): improve style
      pci: pci_add_option_rom(): refactor: use g_autofree for path variable

 hw/virtio/vhost-shadow-virtqueue.h            |   3 +
 include/hw/cxl/cxl_device.h                   |  13 +-
 include/hw/i386/pc.h                          |   3 +-
 include/hw/pci-host/pam.h                     |   5 +-
 include/hw/pci/pci.h                          |   2 +
 include/hw/southbridge/ich9.h                 |   2 +
 include/hw/southbridge/piix.h                 |   3 +
 include/hw/virtio/vhost-vdpa.h                |  11 +
 include/hw/virtio/vhost.h                     |   1 +
 include/hw/virtio/virtio.h                    |   2 +
 hw/core/machine.c                             |   1 +
 hw/cxl/cxl-cdat.c                             |  60 ++---
 hw/cxl/cxl-component-utils.c                  |  14 +-
 hw/cxl/cxl-device-utils.c                     |  15 ++
 hw/cxl/cxl-mailbox-utils.c                    | 107 ++++----
 hw/i386/acpi-common.c                         |   2 +-
 hw/i386/pc.c                                  |  22 +-
 hw/i386/pc_piix.c                             |  18 +-
 hw/i386/pc_q35.c                              |  19 +-
 hw/isa/lpc_ich9.c                             |   8 +
 hw/isa/piix3.c                                |  15 ++
 hw/mem/cxl_type3.c                            | 342 +++++++++++++++++++-------
 hw/net/virtio-net.c                           |   1 -
 hw/pci-bridge/cxl_upstream.c                  |   3 +
 hw/pci-host/i440fx.c                          |  15 +-
 hw/pci-host/pam.c                             |  12 +-
 hw/pci-host/q35.c                             |  14 +-
 hw/pci/pci.c                                  |  29 +--
 hw/pci/pcie_aer.c                             |  11 +-
 hw/virtio/vhost-shadow-virtqueue.c            |   5 +-
 hw/virtio/vhost-user.c                        |  28 ++-
 hw/virtio/vhost-vdpa.c                        | 168 ++++++++++++-
 hw/virtio/vhost.c                             |   2 +-
 hw/virtio/virtio-crypto.c                     |  18 +-
 hw/virtio/virtio-mem.c                        |   2 +-
 hw/virtio/virtio-pci.c                        |  36 +++
 tests/qtest/bios-tables-test.c                |   8 +-
 tests/qtest/cxl-test.c                        | 140 ++++++++---
 docs/about/deprecated.rst                     |   8 +
 docs/system/devices/cxl.rst                   |  63 +++--
 hw/isa/Kconfig                                |   2 +
 hw/pci-bridge/Kconfig                         |   5 +
 hw/pci-bridge/meson.build                     |   3 +-
 tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
 tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
 tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
 tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
 tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
 tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
 tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
 tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
 tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
 tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
 tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
 57 files changed, 900 insertions(+), 341 deletions(-)


