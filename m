Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5473DF28
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlK4-0000m0-6X; Mon, 26 Jun 2023 08:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlK2-0000kv-8M
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlJz-0002Wm-V9
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QQ+RfgosE+mQmXsVbzxSBFhDToj/4Aei5xcx9C9DDDE=;
 b=S98AKzJ1xlvM49kmcQLQ7vx5AxPdLiWz6r4TftR5dTRJpadMHRm6qDAGx4YREVFMSUn8R2
 HUAZFwkxH/OyE7s2ELQ+e/c45/QBOCrFl1GYrPP6wxKKrHP+amwRx2FAV0ORF9wcCuq/aa
 ZEIQTeoV0J/q9lSqJiHXiptWsbsJxto=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-qKRO9eqAOwSmjjiX-hdipA-1; Mon, 26 Jun 2023 08:27:51 -0400
X-MC-Unique: qKRO9eqAOwSmjjiX-hdipA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so12960815e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782470; x=1690374470;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQ+RfgosE+mQmXsVbzxSBFhDToj/4Aei5xcx9C9DDDE=;
 b=Z8Bc6DKWMQNpbqjJEgemjTHfXYySL3FwB9fWblLc9jroTQJHSLo9eWLFzsQrknk45s
 Sot/CLlYWMSFlN5Ki2H9AiVeAM3zju8/Whc9CBfKJkQrTUMdOgxLhUOKjWuiI5HrnKSo
 sAHYCyIVqjpQYh33vWmSAq6jfjn0+ve2tgonkplxKmnS8+XHn+qlm5wp6/ToB7HDSziZ
 0Jj1aEbrH+dpvm7MCTfFb/avGdOdT+qV+9KG0MuLSK9Pi99Cmzu3d79dOz5rj3T9kb4M
 VXGXBmrsui1zgx8sdFLBjm/88cre9cq+jYfvqjETXBjxRRkrDigcyzUqpb54kOP/bqnG
 FRCA==
X-Gm-Message-State: AC+VfDxjpx3FAkGxkE3hrHURHFPSFcrBXw1kXGEhKhG+JAD5AtK2i93F
 mvuwicXme28xgADjbZIRHe1Tjj/7LEbk3gAVJkh4mQSn0HkyQJKRX2wlf6qBpmSyq7OQSRMLjxa
 WgzAHvwmC0LnPGm5OVwdpUVHNXJEkPNk1RSM4QisMNBK6fCzDyNVVl5gfAdy4duMUh+Mh
X-Received: by 2002:a1c:740e:0:b0:3fa:984d:7e9f with SMTP id
 p14-20020a1c740e000000b003fa984d7e9fmr1126275wmc.6.1687782469880; 
 Mon, 26 Jun 2023 05:27:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Lhr/gTZIO6Mg/Q8FyOYCzJhXjNDpYT0H2SQxhlIG5y1koztnOWkkjsIoLBjw/z2eSM6O1dw==
X-Received: by 2002:a1c:740e:0:b0:3fa:984d:7e9f with SMTP id
 p14-20020a1c740e000000b003fa984d7e9fmr1126260wmc.6.1687782469489; 
 Mon, 26 Jun 2023 05:27:49 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 p8-20020a7bcc88000000b003fb225d414fsm1224710wma.21.2023.06.26.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:27:49 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/53] virtio,pc,pci: fixes, features, cleanups
Message-ID: <cover.1687782442.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:

  Merge tag 'q800-for-8.1-pull-request' of https://github.com/vivier/qemu-m68k into staging (2023-06-22 10:18:32 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 3d90d47995b83bd1edf6e756c00e74fd5ec16aee:

  vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present (2023-06-26 08:26:40 -0400)

----------------------------------------------------------------
virtio,pc,pci: fixes, features, cleanups

asymmetric crypto support for cryptodev-vhost-user
rom migration when rom size changes
poison get, inject, clear; mock cxl events and irq support for cxl
shadow virtqueue offload support for vhost-vdpa
vdpa now maps shadow vrings with MAP_SHARED
max_cpus went up to 1024 and we default to smbios 3.0 for pc

Fixes, cleanups all over the place. In particular
    hw/acpi: Fix PM control register access
works around a very long standing bug in memory core.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (2):
      vhost_net: add an assertion for TAP client backends
      vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present

BALATON Zoltan (1):
      hw/acpi: Fix PM control register access

David Hildenbrand (1):
      virtio-mem: Simplify bitmap handling and virtio_mem_set_block_state()

Eugenio Pérez (7):
      vdpa: return errno in vhost_vdpa_get_vring_group error
      vdpa: move CVQ isolation check to net_init_vhost_vdpa
      vdpa: do not block migration if device has cvq and x-svq=on
      vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function
      vdpa: map shadow vrings with MAP_SHARED
      vdpa: mask _F_CTRL_GUEST_OFFLOADS for vhost vdpa devices
      vdpa: fix not using CVQ buffer in case of error

Gowrishankar Muthukrishnan (1):
      cryptodev-vhost-user: add asymmetric crypto support

Hawkins Jiawei (6):
      include/hw/virtio: make some VirtIODevice const
      vdpa: reuse virtio_vdev_has_feature()
      hw/net/virtio-net: make some VirtIONet const
      virtio-net: expose virtio_net_supported_guest_offloads()
      vdpa: Add vhost_vdpa_net_load_offloads()
      vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ

Ira Weiny (5):
      bswap: Add the ability to store to an unaligned 24 bit field
      hw/cxl/events: Add event status register
      hw/cxl/events: Wire up get/clear event mailbox commands
      hw/cxl/events: Add event interrupt support
      hw/cxl/events: Add injection of General Media Events

Jonathan Cameron (6):
      hw/cxl: QMP based poison injection support
      hw/cxl: Add poison injection via the mailbox.
      hw/cxl: Add clear poison mailbox command support.
      hw/cxl: Move CXLRetCode definition to cxl_device.h
      hw/cxl/events: Add injection of DRAM events
      hw/cxl/events: Add injection of Memory Module Events

Laurent Vivier (1):
      vhost: fix vhost_dev_enable_notifiers() error case

Manos Pitsidianakis (1):
      vhost-user: fully use new backend/frontend naming

Michael S. Tsirkin (1):
      tests/data/acpi: update after SMBIOS 2.0 change

Philippe Mathieu-Daudé (10):
      softmmu: Introduce qemu_target_page_mask() helper
      hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
      hw/scsi: Rearrange meson.build
      hw/scsi: Rename target-specific source set as 'specific_virtio_scsi_ss'
      hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in Kconfig
      hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
      hw/virtio/vhost-vsock: Include missing 'virtio/virtio-bus.h' header
      hw/virtio/virtio-iommu: Use target-agnostic qemu_target_page_mask()
      hw/virtio: Remove unnecessary 'virtio-access.h' header
      hw/virtio: Build various target-agnostic objects just once

Prasad J Pandit (2):
      vhost: release memory_listener object in error path
      vhost: release virtqueue objects in error path

Stefan Hajnoczi (1):
      virtio-scsi: avoid dangling host notifier in ->ioeventfd_stop()

Suravee Suthikulpanit (3):
      hw/i386/pc: Default to use SMBIOS 3.0 for newer machine models
      pc: q35: Bump max_cpus to 1024
      hw/i386/pc: Clean up pc_machine_initfn

Vladimir Sementsov-Ogievskiy (1):
      pci: ROM preallocation for incoming migration

Zhenwei Pi (1):
      cryptodev: fix memory leak during stats query

Zhenzhong Duan (3):
      intel_iommu: Fix a potential issue in VFIO dirty page sync
      intel_iommu: Fix flag check in replay
      intel_iommu: Fix address space unmap

 qapi/cxl.json                             | 209 ++++++++++++++++
 include/exec/target_page.h                |   1 +
 include/hw/cxl/cxl.h                      |   1 +
 include/hw/cxl/cxl_device.h               | 101 +++++++-
 include/hw/cxl/cxl_events.h               | 168 +++++++++++++
 include/hw/i386/pc.h                      |   1 +
 include/hw/virtio/vhost-backend.h         |   2 +-
 include/hw/virtio/virtio-net.h            |   1 +
 include/hw/virtio/virtio.h                |   2 +-
 include/qemu/bswap.h                      |  25 ++
 subprojects/libvhost-user/libvhost-user.h |  20 +-
 backends/cryptodev-vhost-user.c           |   9 +-
 backends/cryptodev.c                      |   2 +-
 block/export/vhost-user-blk-server.c      |   2 +-
 contrib/vhost-user-blk/vhost-user-blk.c   |   2 +-
 hw/acpi/core.c                            |  56 ++---
 hw/block/dataplane/virtio-blk.c           |   1 -
 hw/block/vhost-user-blk.c                 |   2 +-
 hw/cxl/cxl-device-utils.c                 |  43 +++-
 hw/cxl/cxl-events.c                       | 248 +++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c                | 382 +++++++++++++++++++++++++----
 hw/display/vhost-user-gpu.c               |   2 +-
 hw/i386/intel_iommu.c                     |  13 +-
 hw/i386/pc.c                              |   6 +-
 hw/i386/pc_piix.c                         |   5 +
 hw/i386/pc_q35.c                          |   8 +-
 hw/input/vhost-user-input.c               |   2 +-
 hw/mem/cxl_type3.c                        | 385 +++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c                  |  41 ++++
 hw/net/vhost_net.c                        |   1 +
 hw/net/virtio-net.c                       |   6 +-
 hw/pci/pci.c                              |  79 +++---
 hw/s390x/virtio-ccw.c                     |   1 -
 hw/scsi/vhost-scsi.c                      |   1 -
 hw/scsi/vhost-user-scsi.c                 |   1 -
 hw/scsi/virtio-scsi-dataplane.c           |   1 -
 hw/scsi/virtio-scsi.c                     |  20 +-
 hw/virtio/vdpa-dev.c                      |   3 +-
 hw/virtio/vhost-shadow-virtqueue.c        |  18 +-
 hw/virtio/vhost-user.c                    | 127 +++++++---
 hw/virtio/vhost-vdpa.c                    |   1 -
 hw/virtio/vhost-vsock-common.c            |   2 +-
 hw/virtio/vhost.c                         |  72 +++---
 hw/virtio/virtio-crypto.c                 |   1 -
 hw/virtio/virtio-iommu.c                  |   4 +-
 hw/virtio/virtio-mem.c                    | 115 +++++----
 hw/virtio/virtio-qmp.c                    |   2 +-
 net/vhost-vdpa.c                          | 269 +++++++++++++++------
 softmmu/physmem.c                         |   5 +
 subprojects/libvhost-user/libvhost-user.c |  54 ++---
 docs/devel/loads-stores.rst               |   2 +
 hw/block/dataplane/meson.build            |   2 +-
 hw/cxl/meson.build                        |   1 +
 hw/scsi/Kconfig                           |   6 +
 hw/scsi/meson.build                       |  20 +-
 hw/virtio/Kconfig                         |   6 +
 hw/virtio/meson.build                     |  14 +-
 tests/data/acpi/q35/SSDT.dimmpxm          | Bin 1815 -> 1815 bytes
 58 files changed, 2166 insertions(+), 408 deletions(-)
 create mode 100644 include/hw/cxl/cxl_events.h
 create mode 100644 hw/cxl/cxl-events.c


