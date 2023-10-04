Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E5A7B7A97
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTW-00021P-Od; Wed, 04 Oct 2023 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTU-000211-5r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTS-0000sF-8q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696408997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8RmnVhSSVHqFXDsXl2j35mgfP6B0hmBEW404jmKZTBI=;
 b=HmJkI/sV1dzFVCzdo85gHe2oml1hf1wv56JfcfG1os8gofb90Ajt3Ek5fu6XQeV1J5p+Oq
 +V36RBvvLujmd6yIbKOficVaI/TUaikB86FbCqvMVg4uBw3XwIAo7/AXPy3vhxlCyW0Ohv
 LKS+5wAU61fQzD4IS5ZWrPYWdOboRUs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-O5UjXObaMJmyI5jjOzphQQ-1; Wed, 04 Oct 2023 04:43:15 -0400
X-MC-Unique: O5UjXObaMJmyI5jjOzphQQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5047e8f812bso1796279e87.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696408993; x=1697013793;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RmnVhSSVHqFXDsXl2j35mgfP6B0hmBEW404jmKZTBI=;
 b=uQKHqEtXpi98FQBIBEWbMS0zfvx2dE6UvpN7fuyvRt1Lm4CVsXHL+Gl4Ek1YzGLdNd
 sHi4X0O4l7blOcJgPIRVX9OcSvioaXHY+1ehAoFe40x19n3SuJSB+/EeZeF+T/8fTHMM
 5c7UnaGy8GI/2L4LBrXprWqKtuCRHc1yJ++9hBLhfxFMiyLIGNL453Ti89bG0boTME/c
 3pCk7+KIX2PNlvVXwWba6/1pkEHbLkWIWR1oek2vnkDWSA/QfdNMkmS0ZfV+mhGwaLLm
 jqLzso1pdms89BMeqf+B2bAWo7wiJRjR7tQyrVoo8+oGbYiR+2ciDnvpbwHCOEI5l6aP
 RqLg==
X-Gm-Message-State: AOJu0Yx25wABQkw0lGf3aGVh1GwfSrh8ukwBXmVdGgGnWG/DhfuNupOt
 BfQ5q+X3Dge/q1Lw4jzt4JzVopiyyasfEMoOptDhSWUg4/5eoSEy9eNf8VbKv8AJt21CLJiH+YO
 4LEXpUbJJ5z2JmTyC9k5K0BoRE/lIstR7jKB+oTMLb/d2PYyZrQEFsTbRU1odJwsquzyZ
X-Received: by 2002:a19:5f1a:0:b0:503:6b8:a84a with SMTP id
 t26-20020a195f1a000000b0050306b8a84amr1542117lfb.54.1696408993495; 
 Wed, 04 Oct 2023 01:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElB1tVINwBAip61opNNTzvN89HOaZMH/K/xYCyHlAiFykEbLBr4KjlGIknJx1jaccQRHGwVg==
X-Received: by 2002:a19:5f1a:0:b0:503:6b8:a84a with SMTP id
 t26-20020a195f1a000000b0050306b8a84amr1542100lfb.54.1696408993045; 
 Wed, 04 Oct 2023 01:43:13 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143867d2ebsm3440205wrw.63.2023.10.04.01.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:12 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/63] virtio,pci: features, cleanups
Message-ID: <cover.1696408966.git.mst@redhat.com>
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

The following changes since commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014:

  Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging (2023-09-25 10:10:30 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to dc1499091ca09db0ac7a5615a592e55f27d4965d:

  libvhost-user: handle shared_object msg (2023-10-04 04:28:35 -0400)

----------------------------------------------------------------
virtio,pci: features, cleanups

vdpa:
      shadow vq vlan support
      net migration with cvq
cxl:
     dummy ACPI QTG DSM
     support emulating 4 HDM decoders
     serial number extended capability
virtio:
      hared dma-buf

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      amd_iommu: Fix APIC address check

Albert Esteve (4):
      util/uuid: add a hash function
      hw/display: introduce virtio-dmabuf
      vhost-user: add shared_object msg
      libvhost-user: handle shared_object msg

Alex Bennée (2):
      virtio: add vhost-user-base and a generic vhost-user-device
      hw/virtio: add config support to vhost-user-device

Ani Sinha (1):
      hw/i386/pc: improve physical address space bound check for 32-bit x86 systems

Bernhard Beschow (8):
      hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
      hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn callback
      hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual method
      hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boards.h"
      hw/i386: Remove now redundant TYPE_ACPI_GED_X86
      hw/i386/acpi-build: Determine SMI command port just once
      hw/acpi: Trace GPE access in all device models, not just PIIX4
      hw/acpi/core: Trace enable and status registers of GPE separately

Dave Jiang (1):
      hw/cxl: Add QTG _DSM support for ACPI0017 device

David Woodhouse (1):
      hw/isa/ich9: Add comment on imperfect emulation of PIC vs. I/O APIC routing

Eugenio Pérez (9):
      vdpa: use first queue SVQ state for CVQ default
      vdpa: export vhost_vdpa_set_vring_ready
      vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load
      vdpa: move vhost_vdpa_set_vring_ready to the caller
      vdpa: remove net cvq migration blocker
      vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
      vdpa net: fix error message setting virtio status
      vdpa net: stop probing if cannot set features
      vdpa net: follow VirtIO initialization properly at cvq isolation probing

Hawkins Jiawei (5):
      virtio-net: do not reset vlan filtering at set_features
      virtio-net: Expose MAX_VLAN
      vdpa: Restore vlan filtering state
      vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
      vhost: Add count argument to vhost_svq_poll()

Ilya Maximets (4):
      virtio: don't zero out memory region cache for indirect descriptors
      virtio: use shadow_avail_idx while checking number of heads
      virtio: remove unnecessary thread fence while reading next descriptor
      virtio: remove unused next argument from virtqueue_split_read_next_desc()

Jonah Palmer (3):
      qmp: remove virtio_list, search QOM tree instead
      qmp: update virtio feature maps, vhost-user-gpio introspection
      vhost-user: move VhostUserProtocolFeature definition to header file

Jonathan Cameron (7):
      tests/acpi: Allow update of DSDT.cxl
      tests/acpi: Update DSDT.cxl with QTG DSM
      hw/cxl: Push cxl_decoder_count_enc() and cxl_decode_ig() into .c
      hw/cxl: Add utility functions decoder interleave ways and target count.
      hw/cxl: Fix and use same calculation for HDM decoder block size everywhere
      hw/cxl: Support 4 HDM decoders at all levels of topology
      hw/pci-bridge/cxl-upstream: Add serial number extended capability support

Laszlo Ersek (7):
      vhost-user: strip superfluous whitespace
      vhost-user: tighten "reply_supported" scope in "set_vring_addr"
      vhost-user: factor out "vhost_user_write_sync"
      vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
      vhost-user: hoist "write_sync", "get_features", "get_u64"
      vhost-user: allow "vhost_set_vring" to wait for a reply
      vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously

Michael S. Tsirkin (1):
      pci: SLT must be RO

Philippe Mathieu-Daudé (6):
      hw/virtio: Propagate page_mask to vhost_vdpa_listener_skipped_section()
      hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
      hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
      hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
      hw/virtio: Build vhost-vdpa.o once
      hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]

Stefan Hajnoczi (1):
      vdpa: fix gcc cvq_isolated uninitialized variable warning

Vladimir Sementsov-Ogievskiy (2):
      pcie_sriov: unregister_vfs(): fix error path
      libvhost-user.c: add assertion to vu_message_read_default

 hw/acpi/hmat.h                            |   3 +-
 hw/i386/acpi-common.h                     |   3 +-
 hw/i386/amd_iommu.h                       |   2 -
 hw/virtio/vhost-shadow-virtqueue.h        |   2 +-
 hw/virtio/virtio-qmp.h                    |   7 -
 include/exec/memory.h                     |  16 +-
 include/hw/acpi/acpi_dev_interface.h      |   3 -
 include/hw/acpi/cpu.h                     |   6 +-
 include/hw/acpi/cxl.h                     |   1 +
 include/hw/acpi/generic_event_device.h    |   2 -
 include/hw/cxl/cxl_component.h            |  30 ++-
 include/hw/i386/pc.h                      |   6 +
 include/hw/pci/pci_bridge.h               |   3 +
 include/hw/virtio/vhost-backend.h         |   3 +
 include/hw/virtio/vhost-user-device.h     |  46 ++++
 include/hw/virtio/vhost-user.h            |  22 ++
 include/hw/virtio/vhost-vdpa.h            |   1 +
 include/hw/virtio/virtio-dmabuf.h         | 100 ++++++++
 include/hw/virtio/virtio-net.h            |   6 +
 include/qemu/uuid.h                       |   2 +
 subprojects/libvhost-user/libvhost-user.h |  55 +++-
 hw/acpi/acpi-x86-stub.c                   |   6 -
 hw/acpi/core.c                            |   9 +
 hw/acpi/cpu.c                             |   9 +-
 hw/acpi/cxl.c                             |  57 +++++
 hw/acpi/hmat.c                            |   1 +
 hw/acpi/memory_hotplug.c                  |   1 +
 hw/acpi/piix4.c                           |   5 -
 hw/core/machine.c                         |   5 +-
 hw/cxl/cxl-component-utils.c              |  92 ++++++-
 hw/cxl/cxl-host.c                         |  67 +++--
 hw/display/virtio-dmabuf.c                | 138 ++++++++++
 hw/i386/acpi-build.c                      |  14 +-
 hw/i386/acpi-common.c                     |   5 +-
 hw/i386/acpi-microvm.c                    |   3 +-
 hw/i386/amd_iommu.c                       |   9 +-
 hw/i386/generic_event_device_x86.c        |  36 ---
 hw/i386/microvm.c                         |   2 +-
 hw/i386/pc.c                              |  32 ++-
 hw/i386/pc_piix.c                         |   4 +
 hw/i386/pc_q35.c                          |   2 +
 hw/isa/lpc_ich9.c                         |  16 +-
 hw/mem/cxl_type3.c                        | 106 +++++---
 hw/net/virtio-net.c                       |   6 +-
 hw/pci-bridge/cxl_upstream.c              |  15 +-
 hw/pci/pci.c                              |   2 +-
 hw/pci/pci_bridge.c                       |  14 ++
 hw/pci/pcie_sriov.c                       |   9 +-
 hw/scsi/vhost-user-scsi.c                 |   4 -
 hw/virtio/vdpa-dev.c                      |   3 +
 hw/virtio/vhost-shadow-virtqueue.c        |  36 +--
 hw/virtio/vhost-user-device-pci.c         |  71 ++++++
 hw/virtio/vhost-user-device.c             | 380 ++++++++++++++++++++++++++++
 hw/virtio/vhost-user-gpio.c               |   7 +
 hw/virtio/vhost-user.c                    | 404 +++++++++++++++++++-----------
 hw/virtio/vhost-vdpa.c                    |  66 ++---
 hw/virtio/virtio-qmp.c                    | 139 +++++-----
 hw/virtio/virtio.c                        |  64 +++--
 net/vhost-vdpa.c                          | 153 +++++++----
 subprojects/libvhost-user/libvhost-user.c | 121 +++++++++
 tests/qtest/bios-tables-test.c            |  26 +-
 tests/qtest/numa-test.c                   |   7 +-
 tests/unit/test-uuid.c                    |  27 ++
 tests/unit/test-virtio-dmabuf.c           | 137 ++++++++++
 util/uuid.c                               |  14 ++
 MAINTAINERS                               |   7 +
 docs/interop/vhost-user.rst               |  57 +++++
 hw/acpi/trace-events                      |  10 +-
 hw/display/meson.build                    |   1 +
 hw/i386/meson.build                       |   1 -
 hw/virtio/meson.build                     |  28 ++-
 hw/virtio/trace-events                    |   2 +-
 tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9723 bytes
 tests/unit/meson.build                    |   1 +
 74 files changed, 2192 insertions(+), 558 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-device.h
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 hw/display/virtio-dmabuf.c
 delete mode 100644 hw/i386/generic_event_device_x86.c
 create mode 100644 hw/virtio/vhost-user-device-pci.c
 create mode 100644 hw/virtio/vhost-user-device.c
 create mode 100644 tests/unit/test-virtio-dmabuf.c


