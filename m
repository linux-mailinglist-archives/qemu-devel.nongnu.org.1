Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED57E3874
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2I-00014z-Qr; Tue, 07 Nov 2023 05:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1b-0000yz-7e
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1Z-00029R-2Q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=sTqD/wwYPePxM415gmSCG828Dat4p/bMlztFGYoLZjE=;
 b=PbmZh/fyFyfuBjyVmGKoaGqaYvcTm3mJsVKAPS6UOoS1rLE0JOkBOOiiFfWW7LbUv/cir4
 QuuBbjTLTIoaegKOTjBHEtAe0efqCL9h9ERjFBuSi549kihEDu6soBdBXWUUFCliakFdw2
 WNYMwrG/AouO4QcEKVsiEFLUiO3JcK8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-K9MhQ3LaPs6o5892Ma7rvQ-1; Tue, 07 Nov 2023 05:09:30 -0500
X-MC-Unique: K9MhQ3LaPs6o5892Ma7rvQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32ddd6f359eso2826625f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351768; x=1699956568;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sTqD/wwYPePxM415gmSCG828Dat4p/bMlztFGYoLZjE=;
 b=nCH5bv7T8qa3kUFrSssil5JsJ+4ybGqME2g0YYcsERWbxMjV9Bj27VmtOM4quQ1x58
 ILIf1u1yRguiq3ns5TJY2y4ZKEZTP7Ea6yDN6X6ugnbHYlzXxwr/shWIXxmKh8phkkiF
 BXkpFojqUIxPfJ/1PjpP9QlyCZoSGIfp6Wk52+HKHcJR/z6fG8bOMgkmFWPSsjhs1sdo
 PnARF14SSZqNq9yX0c5ywkifIDOgkG9nUCSqMCvN8sUnOHN1NTF7F3GsazFDMSxWYCB2
 lCw44/TKL+wr9Vhmuct2/OtcFzySGaqoxhqm4xA0uZpfVTeUl+y8vtKBEt7OtFmDCwjI
 VmNQ==
X-Gm-Message-State: AOJu0Yz7Lntw/mYIe6wjN65c4Ir0QTTrR9OD+cG9ywwR3mah6fgsKzYx
 BTHbWoizySnM0/Jzie1oePi6hi44u3crgb5QJjY6N/4LBy4ilmB8mo0cT2MDI370Lgh3ZDyPWlT
 ajNGymJcWULT3jL7BdMM2Uq0t1FDr+Os0DipEpU4VEpV6hOukDvDDZoym1vFfzm9l3p0K
X-Received: by 2002:a5d:59af:0:b0:32f:7bb6:9695 with SMTP id
 p15-20020a5d59af000000b0032f7bb69695mr29020548wrr.44.1699351768559; 
 Tue, 07 Nov 2023 02:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1YBdp2EKKVmEILl6o33MiU2OI/aGAFNoDQgHsOTcI90MezkJnHyeP1GEo/bgxgYEmw2SqTg==
X-Received: by 2002:a5d:59af:0:b0:32f:7bb6:9695 with SMTP id
 p15-20020a5d59af000000b0032f7bb69695mr29020523wrr.44.1699351768050; 
 Tue, 07 Nov 2023 02:09:28 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d456f000000b0032fab28e9c9sm1900312wrc.73.2023.11.07.02.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:27 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/63] virtio,pc,pci: features, fixes
Message-ID: <cover.1699351720.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:

  Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 94cd94f1c0137b56000c01208e03d0907ad34910:

  acpi/tests/avocado/bits: enable console logging from bits VM (2023-11-07 03:39:11 -0500)

----------------------------------------------------------------
virtio,pc,pci: features, fixes

virtio sound card support

vhost-user: back-end state migration

cxl:
     line length reduction
     enabling fabric management

vhost-vdpa:
     shadow virtqueue hash calculation Support
     shadow virtqueue RSS Support

tests:
    CPU topology related smbios test cases

Fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (2):
      acpi/tests/avocado/bits: enforce 32-bit SMBIOS entry point
      acpi/tests/avocado/bits: enable console logging from bits VM

Davidlohr Bueso (3):
      hw/cxl/mbox: Add support for background operations
      hw/cxl/mbox: Wire up interrupts for background completion
      hw/cxl: Add support for device sanitation

Gregory Price (1):
      hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions

Hanna Czenczek (7):
      vhost-user.rst: Improve [GS]ET_VRING_BASE doc
      vhost-user.rst: Clarify enabling/disabling vrings
      vhost-user.rst: Introduce suspended state
      vhost-user.rst: Migrating back-end-internal state
      vhost-user: Interface for migration state transfer
      vhost: Add high-level state save/load functions
      vhost-user-fs: Implement internal migration

Hawkins Jiawei (5):
      vdpa: Restore hash calculation state
      vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
      vdpa: Add SetSteeringEBPF method for NetClientState
      vdpa: Restore receive-side scaling state
      vdpa: Allow VIRTIO_NET_F_RSS in SVQ

Jonathan Cameron (18):
      hw/cxl: Use a switch to explicitly check size in caps_reg_read()
      hw/cxl: Use switch statements for read and write of cachemem registers
      hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
      hw/cxl: Line length reductions
      hw/cxl: Fix a QEMU_BUILD_BUG_ON() in switch statement scope issue.
      hw/cxl/mbox: Pull the payload out of struct cxl_cmd and make instances constant
      hw/cxl/mbox: Split mailbox command payload into separate input and output
      hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState
      hw/cxl/mbox: Generalize the CCI command processing
      hw/pci-bridge/cxl_upstream: Move defintion of device to header.
      hw/cxl: Add a switch mailbox CCI function
      hw/cxl/mbox: Add Information and Status / Identify command
      hw/cxl/mbox: Add Physical Switch Identify command.
      hw/pci-bridge/cxl_downstream: Set default link width and link speed
      hw/cxl: Implement Physical Ports status retrieval
      hw/cxl/mbox: Add Get Background Operation Status Command
      hw/cxl: Add dummy security state get
      hw/cxl: Add tunneled command support to mailbox for switch cci.

Manos Pitsidianakis (11):
      Add virtio-sound device stub
      Add virtio-sound-pci device
      virtio-sound: handle control messages and streams
      virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
      virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
      virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
      virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
      virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
      virtio-sound: implement audio output (TX)
      virtio-sound: implement audio capture (RX)
      docs/system: add basic virtio-snd documentation

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

 include/hw/audio/virtio-snd.h             |  235 +++++
 include/hw/cxl/cxl.h                      |    6 +
 include/hw/cxl/cxl_component.h            |    6 +-
 include/hw/cxl/cxl_device.h               |  109 ++-
 include/hw/cxl/cxl_events.h               |    3 +-
 include/hw/cxl/cxl_pci.h                  |    6 +-
 include/hw/pci-bridge/cxl_upstream_port.h |   19 +
 include/hw/virtio/vhost-backend.h         |   24 +
 include/hw/virtio/vhost-user.h            |    1 +
 include/hw/virtio/vhost.h                 |  113 +++
 hw/audio/virtio-snd-pci.c                 |   93 ++
 hw/audio/virtio-snd.c                     | 1409 +++++++++++++++++++++++++++++
 hw/cxl/cxl-cdat.c                         |    3 +-
 hw/cxl/cxl-component-utils.c              |  130 ++-
 hw/cxl/cxl-device-utils.c                 |  143 ++-
 hw/cxl/cxl-events.c                       |   11 +-
 hw/cxl/cxl-mailbox-utils.c                | 1060 ++++++++++++++++++----
 hw/cxl/switch-mailbox-cci.c               |  111 +++
 hw/mem/cxl_type3.c                        |   63 +-
 hw/mem/cxl_type3_stubs.c                  |    5 +-
 hw/pci-bridge/cxl_downstream.c            |   20 +-
 hw/pci-bridge/cxl_root_port.c             |    2 +-
 hw/pci-bridge/cxl_upstream.c              |   13 +-
 hw/virtio/vhost-user-fs.c                 |  101 ++-
 hw/virtio/vhost-user.c                    |  146 +++
 hw/virtio/vhost.c                         |  241 +++++
 net/vhost-vdpa.c                          |  122 +++
 system/qdev-monitor.c                     |    2 +
 tests/qtest/bios-tables-test.c            |  116 ++-
 tests/unit/test-smp-parse.c               |   67 +-
 MAINTAINERS                               |    9 +
 docs/interop/vhost-user.rst               |  301 +++++-
 docs/system/device-emulation.rst          |    1 +
 docs/system/devices/virtio-snd.rst        |   49 +
 hw/audio/Kconfig                          |    5 +
 hw/audio/meson.build                      |    2 +
 hw/audio/trace-events                     |   20 +
 hw/cxl/meson.build                        |    1 +
 tests/avocado/acpi-bits.py                |   33 +-
 tests/data/acpi/q35/APIC.core-count       |  Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.core-count2      |  Bin 2478 -> 3238 bytes
 tests/data/acpi/q35/APIC.thread-count     |  Bin 0 -> 544 bytes
 tests/data/acpi/q35/APIC.thread-count2    |  Bin 0 -> 3238 bytes
 tests/data/acpi/q35/APIC.type4-count      |  Bin 0 -> 1072 bytes
 tests/data/acpi/q35/DSDT.core-count       |  Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.core-count2      |  Bin 32495 -> 33770 bytes
 tests/data/acpi/q35/DSDT.thread-count     |  Bin 0 -> 12913 bytes
 tests/data/acpi/q35/DSDT.thread-count2    |  Bin 0 -> 33770 bytes
 tests/data/acpi/q35/DSDT.type4-count      |  Bin 0 -> 18589 bytes
 tests/data/acpi/q35/FACP.core-count       |  Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count     |  Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.thread-count2    |  Bin 0 -> 244 bytes
 tests/data/acpi/q35/FACP.type4-count      |  Bin 0 -> 244 bytes
 53 files changed, 4477 insertions(+), 324 deletions(-)
 create mode 100644 include/hw/audio/virtio-snd.h
 create mode 100644 include/hw/pci-bridge/cxl_upstream_port.h
 create mode 100644 hw/audio/virtio-snd-pci.c
 create mode 100644 hw/audio/virtio-snd.c
 create mode 100644 hw/cxl/switch-mailbox-cci.c
 create mode 100644 docs/system/devices/virtio-snd.rst
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


