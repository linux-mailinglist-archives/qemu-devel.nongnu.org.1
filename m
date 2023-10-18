Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759977CE1C5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8rR-0002mu-NX; Wed, 18 Oct 2023 11:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rP-0002hl-1T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8rM-0006Kf-Sc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=hqoTTmD6z6atMol8PfweExfETKJhktk8P+a2C2EfhCA=;
 b=UxgjV/6BS0EL8o/lBmlHDJREW/Y30AAQUPMeWUrmvOiNcYO923lnAyFHzYfOKANu5FqwmC
 IQM5IR/ohSDcHi7CZAHYPURrltoxszgD3CjJs+QF0yUrcZtmnOS0gfVKXw4Rsh0F1I93jV
 25Z9FT49Nd6JwNHu4/IvLAAP+DbSQtE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-yomNEialNZGiwt70lWUzDw-1; Wed, 18 Oct 2023 11:53:22 -0400
X-MC-Unique: yomNEialNZGiwt70lWUzDw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso4643835e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644401; x=1698249201;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hqoTTmD6z6atMol8PfweExfETKJhktk8P+a2C2EfhCA=;
 b=PMorspFOdxbow/gpMPBgnFqZXhR5oMcekjIGweAYuoRIqhVZ6J/71x15aAV8gGoONC
 UNr+JiIGFUjbYSx5WK2Y22T6e+WdJ/PqnmIL2bA0Sk8RVR7TjTmcOadbU8aZKS4FcI07
 2F5/7+NexVUKK7tqRmOVPn9/VurLpkmIiWq8ah+0QAHfEomtL9LHgGg+jdabPfIa6Iug
 16C89FkEnndKWqZ5FrEXqqZhBoBijtzVpereMqdznV6jVRjKrdTlJRFA9Jtd9S6s1rQr
 UWesh0+F7IE9oNMw0ilW2BM1h+4U5GnIFvSs8NwuemQiYcAz4xH3U3XkpTMFhs1WPwCo
 vOXA==
X-Gm-Message-State: AOJu0YyfHIs+WqKv2FNrAEjWqKv91Z+cIAxfM8VErgFf5ZSQj4qJ/iiE
 23ssHUjN+BbsUH5Ah8PtOb8fWnOh56YE7PkDfamWu9Dh6v/2StCOvhbxA9Wbe+xJ2V3VLuBzUDp
 zyzYbgMLLC2GhIp8ni8D/32tvD19EeC95BaY+TrPjDMP7kOiihTRGZbodyeShh3b/8DzA04I=
X-Received: by 2002:a05:600c:138d:b0:405:34e4:14e3 with SMTP id
 u13-20020a05600c138d00b0040534e414e3mr4508782wmf.3.1697644400720; 
 Wed, 18 Oct 2023 08:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyo0mYvwDybc6tOcD9NmUTYWhiBG/YP/qloOSrs/iHUZJW/o/GCaCBFvPnIX0EZzOULLeGbg==
X-Received: by 2002:a05:600c:138d:b0:405:34e4:14e3 with SMTP id
 u13-20020a05600c138d00b0040534e414e3mr4508765wmf.3.1697644400258; 
 Wed, 18 Oct 2023 08:53:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600001d100b0032d8034724esm2365935wrx.94.2023.10.18.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:53:19 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:53:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/83] virtio,pc,pci: features, cleanups
Message-ID: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 49ca8f122f3e84d7d879f3b4d54a5294b39764d1:

  intel-iommu: Report interrupt remapping faults, fix return value (2023-10-18 11:44:22 -0400)

----------------------------------------------------------------
virtio,pc,pci: features, cleanups

lots of vhost-vdpa shadow work
piix south bridge rework
reconnect for vhost-user-scsi
dummy ACPI QTG DSM for cxl

tests, cleanups, fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (1):
      hw/i386/cxl: ensure maxram is greater than ram size for calculating cxl range

Bernhard Beschow (30):
      hw/i386/acpi-build: Remove build-time assertion on PIIX/ICH9 reset registers being identical
      hw/i386/pc: Merge two if statements into one
      hw/i386/pc_piix: Allow for setting properties before realizing PIIX3 south bridge
      hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
      hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
      hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs" property
      hw/i386/pc_piix: Remove redundant "piix3" variable
      hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
      hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its realize()
      hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
      hw/i386/pc: Wire RTC ISA IRQs in south bridges
      hw/isa/piix3: Create IDE controller in host device
      hw/isa/piix3: Create USB controller in host device
      hw/isa/piix3: Create power management controller in host device
      hw/isa/piix3: Drop the "3" from PIIX base class name
      hw/isa/piix4: Remove unused inbound ISA interrupt lines
      hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
      hw/isa/piix4: Rename reset control operations to match PIIX3
      hw/isa/piix4: Reuse struct PIIXState from PIIX3
      hw/isa/piix3: Merge hw/isa/piix4.c
      hw/isa/piix: Allow for optional PIC creation in PIIX3
      hw/isa/piix: Allow for optional PIT creation in PIIX3
      hw/isa/piix: Harmonize names of reset control memory regions
      hw/isa/piix: Share PIIX3's base class with PIIX4
      hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
      hw/isa/piix: Rename functions to be shared for PCI interrupt triggering
      hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
      hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
      hw/isa/piix: Implement multi-process QEMU support also for PIIX4
      hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine

Damien Zammit (1):
      timer/i8254: Fix one shot PIT mode

Dave Jiang (1):
      hw/cxl: Add QTG _DSM support for ACPI0017 device

David Woodhouse (1):
      intel-iommu: Report interrupt remapping faults, fix return value

Hanna Czenczek (1):
      vhost-user: Fix protocol feature bit conflict

Hawkins Jiawei (12):
      vdpa: Use iovec for vhost_vdpa_net_cvq_add()
      vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load()
      vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
      vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
      vdpa: Introduce cursors to vhost_vdpa_net_loadx()
      vhost: Expose vhost_svq_available_slots()
      vdpa: Send cvq state load commands in parallel
      vdpa: Restore hash calculation state
      vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
      vdpa: Add SetSteeringEBPF method for NetClientState
      vdpa: Restore receive-side scaling state
      vdpa: Allow VIRTIO_NET_F_RSS in SVQ

Ilya Maximets (1):
      memory: initialize 'fv' in MemoryRegionCache to make Coverity happy

Jonathan Cameron (2):
      tests/acpi: Allow update of DSDT.cxl
      tests/acpi: Update DSDT.cxl with QTG DSM

Laszlo Ersek (7):
      vhost-user: strip superfluous whitespace
      vhost-user: tighten "reply_supported" scope in "set_vring_addr"
      vhost-user: factor out "vhost_user_write_sync"
      vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
      vhost-user: hoist "write_sync", "get_features", "get_u64"
      vhost-user: allow "vhost_set_vring" to wait for a reply
      vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously

Li Feng (5):
      vhost-user-common: send get_inflight_fd once
      vhost: move and rename the conn retry times
      vhost-user-scsi: support reconnect to backend
      vhost-user-scsi: start vhost when guest kicks
      vhost-user: fix lost reconnect

Matheus Tavares Bernardino (1):
      hw/display: fix memleak from virtio_add_resource

Stefan Hajnoczi (3):
      vhost-user: do not send RESET_OWNER on device reset
      vhost-backend: remove vhost_kernel_reset_device()
      virtio: call ->vhost_reset_device() during reset

Thomas Huth (1):
      MAINTAINERS: Add include/hw/intc/i8259.h to the PC chip section

Zhao Liu (16):
      tests: test-smp-parse: Add the test for cores/threads per socket helpers
      tests: bios-tables-test: Prepare the ACPI table change for smbios type4 count test
      tests: bios-tables-test: Add test for smbios type4 count
      tests: bios-tables-test: Add ACPI table binaries for smbios type4 count test
      tests: bios-tables-test: Prepare the ACPI table change for smbios type4 core count test
      tests: bios-tables-test: Add test for smbios type4 core count
      tests: bios-tables-test: Add ACPI table binaries for smbios type4 core count test
      tests: bios-tables-test: Prepare the ACPI table change for smbios type4 core count2 test
      tests: bios-tables-test: Extend smbios core count2 test to cover general topology
      tests: bios-tables-test: Update ACPI table binaries for smbios core count2 test
      tests: bios-tables-test: Prepare the ACPI table change for smbios type4 thread count test
      tests: bios-tables-test: Add test for smbios type4 thread count
      tests: bios-tables-test: Add ACPI table binaries for smbios type4 thread count test
      tests: bios-tables-test: Prepare the ACPI table change for smbios type4 thread count2 test
      tests: bios-tables-test: Add test for smbios type4 thread count2
      tests: bios-tables-test: Add ACPI table binaries for smbios type4 thread count2 test

 hw/i386/intel_iommu_internal.h            |   1 +
 hw/virtio/vhost-shadow-virtqueue.h        |   1 +
 include/exec/memory.h                     |   2 +
 include/hw/acpi/cxl.h                     |   1 +
 include/hw/i386/pc.h                      |   2 +
 include/hw/southbridge/piix.h             |  30 +-
 include/hw/virtio/vhost-scsi-common.h     |   2 +-
 include/hw/virtio/vhost-user-scsi.h       |   6 +
 include/hw/virtio/vhost-user.h            |   6 +-
 include/hw/virtio/vhost.h                 |  12 +
 subprojects/libvhost-user/libvhost-user.h |   3 +-
 hw/acpi/cxl.c                             |  69 +++++
 hw/block/vhost-user-blk.c                 |   6 +-
 hw/display/virtio-dmabuf.c                |  12 +-
 hw/i386/acpi-build.c                      |   6 +-
 hw/i386/intel_iommu.c                     | 150 ++++++---
 hw/i386/pc.c                              |  19 +-
 hw/i386/pc_piix.c                         | 123 ++++++--
 hw/i386/pc_q35.c                          |  14 +-
 hw/isa/lpc_ich9.c                         |   9 +-
 hw/isa/{piix3.c => piix.c}                | 281 ++++++++++++-----
 hw/isa/piix4.c                            | 302 ------------------
 hw/mips/malta.c                           |   5 +-
 hw/scsi/vhost-scsi-common.c               |  47 +--
 hw/scsi/vhost-scsi.c                      |   6 +-
 hw/scsi/vhost-user-scsi.c                 | 254 +++++++++++++---
 hw/timer/i8254_common.c                   |   4 +-
 hw/virtio/vhost-backend.c                 |   6 -
 hw/virtio/vhost-shadow-virtqueue.c        |   2 +-
 hw/virtio/vhost-user-gpio.c               |   5 +-
 hw/virtio/vhost-user.c                    | 239 ++++++++-------
 hw/virtio/vhost.c                         |   9 +
 hw/virtio/virtio.c                        |   4 +
 net/vhost-vdpa.c                          | 489 ++++++++++++++++++++++--------
 tests/qtest/bios-tables-test.c            | 116 ++++++-
 tests/unit/test-smp-parse.c               |  67 +++-
 MAINTAINERS                               |   7 +-
 docs/interop/vhost-user.rst               |  11 +
 docs/system/target-i386-desc.rst.inc      |   8 +
 hw/i386/Kconfig                           |   3 +-
 hw/isa/Kconfig                            |   8 +-
 hw/isa/meson.build                        |   3 +-
 hw/mips/Kconfig                           |   2 +-
 meson.build                               |   1 +
 tests/data/acpi/q35/APIC.core-count       | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.core-count2      | Bin 2478 -> 3238 bytes
 tests/data/acpi/q35/APIC.thread-count     | Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.thread-count2    | Bin 0 -> 7398 bytes
 tests/data/acpi/q35/APIC.type4-count      | Bin 0 -> 1072 bytes
 tests/data/acpi/q35/DSDT.core-count       | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.core-count2      | Bin 32495 -> 33770 bytes
 tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9713 bytes
 tests/data/acpi/q35/DSDT.thread-count     | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.thread-count2    | Bin 0 -> 63671 bytes
 tests/data/acpi/q35/DSDT.type4-count      | Bin 0 -> 18589 bytes
 tests/data/acpi/q35/FACP.core-count       | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count     | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count2    | Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.type4-count      | Bin 0 -> 244 bytes
 59 files changed, 1503 insertions(+), 850 deletions(-)
 rename hw/isa/{piix3.c => piix.c} (52%)
 delete mode 100644 hw/isa/piix4.c
 create mode 100644 tests/data/acpi/q35/APIC.core-count
 create mode 100644 tests/data/acpi/q35/APIC.thread-count
 create mode 100644 tests/data/acpi/q35/APIC.thread-count2
 create mode 100644 tests/data/acpi/q35/APIC.type4-count
 create mode 100644 tests/data/acpi/q35/DSDT.core-count
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count
 create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
 create mode 100644 tests/data/acpi/q35/DSDT.type4-count
 create mode 100644 tests/data/acpi/q35/FACP.core-count
 create mode 100644 tests/data/acpi/q35/FACP.thread-count
 create mode 100644 tests/data/acpi/q35/FACP.thread-count2
 create mode 100644 tests/data/acpi/q35/FACP.type4-count


