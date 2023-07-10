Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5874E1A3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIztu-0002oi-Ty; Mon, 10 Jul 2023 19:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztt-0002oK-1n
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztq-00046D-Lt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/nnpqxXhKaeFf610SnA2ND0N2GJgdbhulbvJeHa+7w=;
 b=iCDiU2lpZoS8/1QLP6NUQgDvA+C+enl+azs2h+uihJbgJRixawB8xDleLqgIOc37rJv6xT
 rG1GvLGQRmVaqnyv4miMLxt5GGWKzyhL30u3nBOgVkoACmvHKf7Qhm3xspjL36zSB2b6Gy
 d0m7OpK1FovPeGKmLRrzGmfaDylJvdQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-sASy7TfmNIOf1arduy_Z5w-1; Mon, 10 Jul 2023 19:02:31 -0400
X-MC-Unique: sASy7TfmNIOf1arduy_Z5w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fb416d7731so28697295e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030149; x=1691622149;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/nnpqxXhKaeFf610SnA2ND0N2GJgdbhulbvJeHa+7w=;
 b=LBZU8AVWVwjP/7fB8YTYt8LsrdJEGIRQaUEboK5lsj/2kLE7Ozi4evPiqyJmo0UTxD
 b/+v9hElG8y0hjNFXUmhxpCIB50IRMHoy5HtYMJl4a7Z8q2gKfP/Ziz/AmezvoeWokov
 ixvX1/UXDNroxT2FT0VF00jY3z2dlObQs1fCWqsKt1mi++CmfVv2Bt0kFcfJKY288+Hy
 j0Bvc5HVeD6lAQu3tkWAwwhGArnkuugusWSaOTyrCnXyDQoT+oeP5XLSO7H5Fi9bQRuz
 QZMicjbeLFSUbvIapfDyjK05RmBf64+Bxab8URzGcC1qf3F0RQIvpwG4lR0jKsfW4Rig
 PbKg==
X-Gm-Message-State: ABy/qLan/UF0TVwX+juGbwKPjGpOZZWyrFsReNyy+AVikZr1KmwLivM7
 HNrLpYJJ4hdT4WgKzELkGIg03edNJZf1BzE/3pl32TH5ybgc1unDC1Zc5Su+WgDklAE4qg4RW7t
 teVroXV+ZaUaxQjqWlMhmTzal8/iYJWaWPSNhvPSzFXzTcHXxQbZzxwvlPoxNbkLIQtYJ
X-Received: by 2002:a7b:c8c9:0:b0:3fc:8a0:3eaa with SMTP id
 f9-20020a7bc8c9000000b003fc08a03eaamr6989137wml.34.1689030149274; 
 Mon, 10 Jul 2023 16:02:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYSqoJD6LvFUMfcpJo1NWRTnDsk1lZrqwpwabCQ1rjhjYUSeaj3w8/GiFcLGa8jshqKgssvw==
X-Received: by 2002:a7b:c8c9:0:b0:3fc:8a0:3eaa with SMTP id
 f9-20020a7bc8c9000000b003fc08a03eaamr6989114wml.34.1689030148781; 
 Mon, 10 Jul 2023 16:02:28 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b0031438e42599sm576341wrt.82.2023.07.10.16.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:28 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/66] pc,pci,virtio: cleanups, fixes, features
Message-ID: <cover.1689030052.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:

  Merge tag 'pull-vfio-20230710' of https://github.com/legoater/qemu into staging (2023-07-10 09:17:06 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d669b7bba22d45cb9e5926d63541e52bde1655dd:

  vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ (2023-07-10 18:59:32 -0400)

----------------------------------------------------------------
pc,pci,virtio: cleanups, fixes, features

vhost-user-gpu: edid
vhost-user-scmi device
vhost-vdpa: _F_CTRL_RX and _F_CTRL_RX_EXTRA support for svq

cleanups, fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (3):
      pcie: Release references of virtual functions
      pcie: Use common ARI next function number
      pcie: Specify 0 for ARI next function numbers

Alex Bennée (6):
      include: attempt to document device_class_set_props
      include/hw: document the device_class_set_parent_* fns
      hw/virtio: fix typo in VIRTIO_CONFIG_IRQ_IDX comments
      include/hw/virtio: document virtio_notify_config
      include/hw/virtio: add kerneldoc for virtio_init
      include/hw/virtio: document some more usage of notifiers

Ani Sinha (5):
      tests/acpi: allow changes in DSDT.noacpihp table blob
      tests/acpi/bios-tables-test: use the correct slot on the pcie-root-port
      tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
      tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and simplify test
      hw/pci: warn when PCIe device is plugged into non-zero slot of downstream port

Bernhard Beschow (19):
      hw/i386/pc_q35: Resolve redundant q35_host variable
      hw/pci-host/q35: Fix double, contradicting .endianness assignment
      hw/pci-host/q35: Initialize PCMachineState::bus in board code
      hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU macro
      hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU property from board code
      hw/pci-host/q35: Make some property name macros reusable by i440fx
      hw/i386/pc_piix: Turn some local variables into initializers
      hw/pci-host/i440fx: Add "i440fx" child property in board code
      hw/pci-host/i440fx: Replace magic values by existing constants
      hw/pci-host/i440fx: Have common names for some local variables
      hw/pci-host/i440fx: Move i440fx_realize() into PCII440FXState section
      hw/pci-host/i440fx: Make MemoryRegion pointers accessible as properties
      hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property
      hw/pci-host/i440fx: Add PCI_HOST_{ABOVE, BELOW}_4G_MEM_SIZE properties
      hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE property
      hw/pci-host/i440fx: Resolve i440fx_init()
      hw/i386/pc_piix: Move i440fx' realize near its qdev_new()
      hw/pci/pci: Remove multifunction parameter from pci_create_simple_multifunction()
      hw/pci/pci: Remove multifunction parameter from pci_new_multifunction()

Eric Auger (2):
      virtio-iommu: Fix 64kB host page size VFIO device assignment
      virtio-iommu: Rework the traces in virtio_iommu_set_page_size_mask()

Erico Nunes (4):
      virtio-gpu: refactor generate_edid function to virtio_gpu_base
      docs: vhost-user-gpu: add protocol changes for EDID
      contrib/vhost-user-gpu: implement get_edid feature
      vhost-user-gpu: implement get_edid frontend feature

Eugenio Pérez (1):
      vdpa: Remove status in reset tracing

Hawkins Jiawei (13):
      vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
      vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
      vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()
      vdpa: Fix possible use-after-free for VirtQueueElement
      vdpa: Use iovec for vhost_vdpa_net_load_cmd()
      vdpa: Restore MAC address filtering state
      vdpa: Restore packet receive filtering state relative with _F_CTRL_RX feature
      vhost: Fix false positive out-of-bounds
      vdpa: Accessing CVQ header through its structure
      vdpa: Avoid forwarding large CVQ command failures
      vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
      vdpa: Restore packet receive filtering state relative with _F_CTRL_RX_EXTRA feature
      vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ

Laurent Vivier (1):
      vhost-vdpa: mute unaligned memory error report

Leonardo Bras (1):
      pcie: Add hotplug detect state register to cmask

Milan Zamazal (3):
      hw/virtio: Add boilerplate for vhost-user-scmi device
      hw/virtio: Add vhost-user-scmi-pci boilerplate
      tests/qtest: enable tests for virtio-scmi

Tom Lonergan (2):
      vhost-user: Change one_time to per_device request
      vhost-user: Make RESET_DEVICE a per device message

Viktor Prutyanov (2):
      vhost: register and change IOMMU flag depending on Device-TLB state
      virtio-net: pass Device-TLB enable/disable events to vhost

Zhao Liu (4):
      machine: Add helpers to get cores/threads per socket
      hw/smbios: Fix smbios_smp_sockets caculation
      hw/smbios: Fix thread count in type4
      hw/smbios: Fix core count in type4

 docs/pcie_sriov.txt                     |   4 +-
 contrib/vhost-user-gpu/vugpu.h          |  11 +
 include/hw/boards.h                     |   2 +
 include/hw/i386/pc.h                    |   4 +
 include/hw/pci-host/i440fx.h            |  16 +-
 include/hw/pci-host/q35.h               |   5 -
 include/hw/pci/pci.h                    |   6 +-
 include/hw/pci/pci_host.h               |   2 +
 include/hw/pci/pcie.h                   |   2 +-
 include/hw/qdev-core.h                  |  36 +++
 include/hw/virtio/vhost-user-scmi.h     |  30 +++
 include/hw/virtio/vhost.h               |   1 +
 include/hw/virtio/virtio-gpu.h          |   2 +
 include/hw/virtio/virtio-iommu.h        |   2 +
 include/hw/virtio/virtio.h              |  21 ++
 tests/qtest/libqos/virtio-scmi.h        |  34 +++
 contrib/vhost-user-gpu/vhost-user-gpu.c |  73 +++++-
 contrib/vhost-user-gpu/virgl.c          |   3 +
 hw/core/machine-smp.c                   |  10 +
 hw/core/machine.c                       |   1 +
 hw/display/vhost-user-gpu.c             |  36 ++-
 hw/display/virtio-gpu-base.c            |  17 ++
 hw/display/virtio-gpu.c                 |  20 +-
 hw/i386/pc_piix.c                       |  62 +++--
 hw/i386/pc_q35.c                        |  41 +--
 hw/mips/boston.c                        |   3 +-
 hw/mips/fuloong2e.c                     |   2 +-
 hw/mips/malta.c                         |   2 +-
 hw/net/igb.c                            |   2 +-
 hw/net/igbvf.c                          |   2 +-
 hw/net/virtio-net.c                     |   5 +-
 hw/nvme/ctrl.c                          |   2 +-
 hw/pci-host/i440fx.c                    | 128 ++++-----
 hw/pci-host/q35.c                       |  13 +-
 hw/pci-host/sabre.c                     |   6 +-
 hw/pci/pci.c                            |  40 ++-
 hw/pci/pci_host.c                       |   2 +-
 hw/pci/pcie.c                           |   8 +-
 hw/pci/pcie_sriov.c                     |   1 +
 hw/ppc/pegasos2.c                       |   2 +-
 hw/smbios/smbios.c                      |  16 +-
 hw/sparc64/sun4u.c                      |   5 +-
 hw/virtio/vhost-shadow-virtqueue.c      |   2 +-
 hw/virtio/vhost-stub.c                  |   4 +
 hw/virtio/vhost-user-fs.c               |   4 +-
 hw/virtio/vhost-user-gpio.c             |   2 +-
 hw/virtio/vhost-user-scmi-pci.c         |  68 +++++
 hw/virtio/vhost-user-scmi.c             | 306 ++++++++++++++++++++++
 hw/virtio/vhost-user.c                  |  19 +-
 hw/virtio/vhost-vdpa.c                  |  10 +-
 hw/virtio/vhost-vsock-common.c          |   4 +-
 hw/virtio/vhost.c                       |  38 ++-
 hw/virtio/virtio-crypto.c               |   4 +-
 hw/virtio/virtio-iommu.c                |  50 +++-
 net/vhost-vdpa.c                        | 451 +++++++++++++++++++++++++++++++-
 tests/qtest/bios-tables-test.c          |   4 +-
 tests/qtest/hd-geo-test.c               |  18 +-
 tests/qtest/libqos/virtio-scmi.c        | 174 ++++++++++++
 tests/qtest/vhost-user-test.c           |  44 ++++
 MAINTAINERS                             |   7 +
 docs/interop/vhost-user-gpu.rst         |  28 +-
 hw/virtio/Kconfig                       |   5 +
 hw/virtio/meson.build                   |   2 +
 hw/virtio/trace-events                  |   5 +-
 tests/data/acpi/q35/DSDT.noacpihp       | Bin 8248 -> 8241 bytes
 tests/qtest/libqos/meson.build          |   1 +
 66 files changed, 1662 insertions(+), 268 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-scmi.h
 create mode 100644 tests/qtest/libqos/virtio-scmi.h
 create mode 100644 hw/virtio/vhost-user-scmi-pci.c
 create mode 100644 hw/virtio/vhost-user-scmi.c
 create mode 100644 tests/qtest/libqos/virtio-scmi.c


