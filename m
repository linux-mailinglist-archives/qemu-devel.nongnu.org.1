Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A8D7B865A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5YP-0006kL-7n; Wed, 04 Oct 2023 13:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo5YN-0006jw-0Q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo5YK-0004e8-TL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696440051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXS2JKUXrpNa9miJV5sw7HOuk2L9AwT3Duum8an8Rqw=;
 b=Hge6krACWtJgoRqIc4frL1ViiPsyzyeYw7ScW7yzKkr+ZnuALWw84RCuAEqfN2PgrI5CrX
 82f09QdKIhHmuzISFOtsmTxfPQr845bgRMxwal78kF55uC7dYb/xbnPyUharMO7yoACKOc
 I/u36EFnUNre+gGYloq7OLDgFiqa/ZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643--AOoPSNiNcuGlHydV7s-aw-1; Wed, 04 Oct 2023 13:20:50 -0400
X-MC-Unique: -AOoPSNiNcuGlHydV7s-aw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso150355e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440048; x=1697044848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXS2JKUXrpNa9miJV5sw7HOuk2L9AwT3Duum8an8Rqw=;
 b=sZWIKnEwMoMWlkBENu+fBcnr9+YoivQT2loCH+b0JGHvSzU5YjAbwsSFTBiv8y62UB
 yDojKYdumbsiYqEz25lncvFn0wjjSdm5uTijQG1hvQ8eI7SIwwc2STuq5xuUcJFZYGHl
 pTXNZx7QJf3naoVq4YRIjs1UkuRLnpcT745aSxP8rcQ7jtkVxoohyy7rm/2x3QGE8y5N
 TUVxY6yz9Evud9lpWt5/bN9K4PRrPPEtl+xpGvLqnTLpRVYYzYdJIBmeU33/cofkKeAs
 wkOGKm6FV0tKf6VLmMaZ3Agh8OboF08/wzUvEpCM4+OSkoWyOI+sobof5GrFkdXG3Q9e
 V9MA==
X-Gm-Message-State: AOJu0Yw645FLZkZL1lrvE3F3MdTC12gW4plAa1uSyz/UaF9F7PLDlkJF
 h4tid2TiNV5lxy9jDGbTRTXeuITgIbvNqOApgJ6pjCRB+CSiitLJPnvtQYo+T+JwpoqFP+X/dEy
 zyTpz1eZhOJ/ZN/Q=
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr2788664wmi.10.1696440047879; 
 Wed, 04 Oct 2023 10:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEqfbr+xCNToUApBNry7wtqshV4M7iE9TCh/Db+/LmiQHvkeIkDKP5D9k8T5UO0UZjdmdhOQ==
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id
 n21-20020a7bcbd5000000b003ffca80eda3mr2788647wmi.10.1696440047484; 
 Wed, 04 Oct 2023 10:20:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a1ced14000000b004065d67c3c9sm2004529wmh.8.2023.10.04.10.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:20:45 -0700 (PDT)
Date: Wed, 4 Oct 2023 13:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pci: features, cleanups
Message-ID: <20231004131751-mutt-send-email-mst@kernel.org>
References: <cover.1696408966.git.mst@redhat.com>
 <CAJSP0QVfn__LKXVO5puOs4h5AV9FWGNKiJXUnSe-K+ANP+=wCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVfn__LKXVO5puOs4h5AV9FWGNKiJXUnSe-K+ANP+=wCg@mail.gmail.com>
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

On Wed, Oct 04, 2023 at 12:50:18PM -0400, Stefan Hajnoczi wrote:
> On Wed, 4 Oct 2023 at 04:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014:
> >
> >   Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging (2023-09-25 10:10:30 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to dc1499091ca09db0ac7a5615a592e55f27d4965d:
> >
> >   libvhost-user: handle shared_object msg (2023-10-04 04:28:35 -0400)
> >
> > ----------------------------------------------------------------
> > virtio,pci: features, cleanups
> >
> > vdpa:
> >       shadow vq vlan support
> >       net migration with cvq
> > cxl:
> >      dummy ACPI QTG DSM
> >      support emulating 4 HDM decoders
> >      serial number extended capability
> > virtio:
> >       hared dma-buf
> >
> > Fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Akihiko Odaki (1):
> >       amd_iommu: Fix APIC address check
> >
> > Albert Esteve (4):
> >       util/uuid: add a hash function
> >       hw/display: introduce virtio-dmabuf
> >       vhost-user: add shared_object msg
> >       libvhost-user: handle shared_object msg
> >
> > Alex Bennée (2):
> >       virtio: add vhost-user-base and a generic vhost-user-device
> >       hw/virtio: add config support to vhost-user-device
> >
> > Ani Sinha (1):
> >       hw/i386/pc: improve physical address space bound check for 32-bit x86 systems
> >
> > Bernhard Beschow (8):
> >       hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
> >       hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn callback
> >       hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual method
> >       hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boards.h"
> >       hw/i386: Remove now redundant TYPE_ACPI_GED_X86
> >       hw/i386/acpi-build: Determine SMI command port just once
> >       hw/acpi: Trace GPE access in all device models, not just PIIX4
> >       hw/acpi/core: Trace enable and status registers of GPE separately
> >
> > Dave Jiang (1):
> >       hw/cxl: Add QTG _DSM support for ACPI0017 device
> >
> > David Woodhouse (1):
> >       hw/isa/ich9: Add comment on imperfect emulation of PIC vs. I/O APIC routing
> >
> > Eugenio Pérez (9):
> >       vdpa: use first queue SVQ state for CVQ default
> >       vdpa: export vhost_vdpa_set_vring_ready
> >       vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load
> >       vdpa: move vhost_vdpa_set_vring_ready to the caller
> >       vdpa: remove net cvq migration blocker
> >       vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
> >       vdpa net: fix error message setting virtio status
> >       vdpa net: stop probing if cannot set features
> >       vdpa net: follow VirtIO initialization properly at cvq isolation probing
> >
> > Hawkins Jiawei (5):
> >       virtio-net: do not reset vlan filtering at set_features
> >       virtio-net: Expose MAX_VLAN
> >       vdpa: Restore vlan filtering state
> >       vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
> >       vhost: Add count argument to vhost_svq_poll()
> >
> > Ilya Maximets (4):
> >       virtio: don't zero out memory region cache for indirect descriptors
> >       virtio: use shadow_avail_idx while checking number of heads
> >       virtio: remove unnecessary thread fence while reading next descriptor
> >       virtio: remove unused next argument from virtqueue_split_read_next_desc()
> >
> > Jonah Palmer (3):
> >       qmp: remove virtio_list, search QOM tree instead
> >       qmp: update virtio feature maps, vhost-user-gpio introspection
> >       vhost-user: move VhostUserProtocolFeature definition to header file
> >
> > Jonathan Cameron (7):
> >       tests/acpi: Allow update of DSDT.cxl
> >       tests/acpi: Update DSDT.cxl with QTG DSM
> >       hw/cxl: Push cxl_decoder_count_enc() and cxl_decode_ig() into .c
> >       hw/cxl: Add utility functions decoder interleave ways and target count.
> >       hw/cxl: Fix and use same calculation for HDM decoder block size everywhere
> >       hw/cxl: Support 4 HDM decoders at all levels of topology
> >       hw/pci-bridge/cxl-upstream: Add serial number extended capability support
> >
> > Laszlo Ersek (7):
> >       vhost-user: strip superfluous whitespace
> >       vhost-user: tighten "reply_supported" scope in "set_vring_addr"
> >       vhost-user: factor out "vhost_user_write_sync"
> >       vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
> >       vhost-user: hoist "write_sync", "get_features", "get_u64"
> >       vhost-user: allow "vhost_set_vring" to wait for a reply
> >       vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
> >
> > Michael S. Tsirkin (1):
> >       pci: SLT must be RO
> >
> > Philippe Mathieu-Daudé (6):
> >       hw/virtio: Propagate page_mask to vhost_vdpa_listener_skipped_section()
> >       hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
> >       hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
> >       hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
> >       hw/virtio: Build vhost-vdpa.o once
> >       hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]
> >
> > Stefan Hajnoczi (1):
> >       vdpa: fix gcc cvq_isolated uninitialized variable warning
> >
> > Vladimir Sementsov-Ogievskiy (2):
> >       pcie_sriov: unregister_vfs(): fix error path
> >       libvhost-user.c: add assertion to vu_message_read_default
> >
> >  hw/acpi/hmat.h                            |   3 +-
> >  hw/i386/acpi-common.h                     |   3 +-
> >  hw/i386/amd_iommu.h                       |   2 -
> >  hw/virtio/vhost-shadow-virtqueue.h        |   2 +-
> >  hw/virtio/virtio-qmp.h                    |   7 -
> >  include/exec/memory.h                     |  16 +-
> >  include/hw/acpi/acpi_dev_interface.h      |   3 -
> >  include/hw/acpi/cpu.h                     |   6 +-
> >  include/hw/acpi/cxl.h                     |   1 +
> >  include/hw/acpi/generic_event_device.h    |   2 -
> >  include/hw/cxl/cxl_component.h            |  30 ++-
> >  include/hw/i386/pc.h                      |   6 +
> >  include/hw/pci/pci_bridge.h               |   3 +
> >  include/hw/virtio/vhost-backend.h         |   3 +
> >  include/hw/virtio/vhost-user-device.h     |  46 ++++
> >  include/hw/virtio/vhost-user.h            |  22 ++
> >  include/hw/virtio/vhost-vdpa.h            |   1 +
> >  include/hw/virtio/virtio-dmabuf.h         | 100 ++++++++
> >  include/hw/virtio/virtio-net.h            |   6 +
> >  include/qemu/uuid.h                       |   2 +
> >  subprojects/libvhost-user/libvhost-user.h |  55 +++-
> >  hw/acpi/acpi-x86-stub.c                   |   6 -
> >  hw/acpi/core.c                            |   9 +
> >  hw/acpi/cpu.c                             |   9 +-
> >  hw/acpi/cxl.c                             |  57 +++++
> >  hw/acpi/hmat.c                            |   1 +
> >  hw/acpi/memory_hotplug.c                  |   1 +
> >  hw/acpi/piix4.c                           |   5 -
> >  hw/core/machine.c                         |   5 +-
> >  hw/cxl/cxl-component-utils.c              |  92 ++++++-
> >  hw/cxl/cxl-host.c                         |  67 +++--
> >  hw/display/virtio-dmabuf.c                | 138 ++++++++++
> >  hw/i386/acpi-build.c                      |  14 +-
> >  hw/i386/acpi-common.c                     |   5 +-
> >  hw/i386/acpi-microvm.c                    |   3 +-
> >  hw/i386/amd_iommu.c                       |   9 +-
> >  hw/i386/generic_event_device_x86.c        |  36 ---
> >  hw/i386/microvm.c                         |   2 +-
> >  hw/i386/pc.c                              |  32 ++-
> >  hw/i386/pc_piix.c                         |   4 +
> >  hw/i386/pc_q35.c                          |   2 +
> >  hw/isa/lpc_ich9.c                         |  16 +-
> >  hw/mem/cxl_type3.c                        | 106 +++++---
> >  hw/net/virtio-net.c                       |   6 +-
> >  hw/pci-bridge/cxl_upstream.c              |  15 +-
> >  hw/pci/pci.c                              |   2 +-
> >  hw/pci/pci_bridge.c                       |  14 ++
> >  hw/pci/pcie_sriov.c                       |   9 +-
> >  hw/scsi/vhost-user-scsi.c                 |   4 -
> >  hw/virtio/vdpa-dev.c                      |   3 +
> >  hw/virtio/vhost-shadow-virtqueue.c        |  36 +--
> >  hw/virtio/vhost-user-device-pci.c         |  71 ++++++
> >  hw/virtio/vhost-user-device.c             | 380 ++++++++++++++++++++++++++++
> >  hw/virtio/vhost-user-gpio.c               |   7 +
> >  hw/virtio/vhost-user.c                    | 404 +++++++++++++++++++-----------
> >  hw/virtio/vhost-vdpa.c                    |  66 ++---
> >  hw/virtio/virtio-qmp.c                    | 139 +++++-----
> >  hw/virtio/virtio.c                        |  64 +++--
> >  net/vhost-vdpa.c                          | 153 +++++++----
> >  subprojects/libvhost-user/libvhost-user.c | 121 +++++++++
> >  tests/qtest/bios-tables-test.c            |  26 +-
> >  tests/qtest/numa-test.c                   |   7 +-
> >  tests/unit/test-uuid.c                    |  27 ++
> >  tests/unit/test-virtio-dmabuf.c           | 137 ++++++++++
> >  util/uuid.c                               |  14 ++
> >  MAINTAINERS                               |   7 +
> >  docs/interop/vhost-user.rst               |  57 +++++
> >  hw/acpi/trace-events                      |  10 +-
> >  hw/display/meson.build                    |   1 +
> >  hw/i386/meson.build                       |   1 -
> >  hw/virtio/meson.build                     |  28 ++-
> >  hw/virtio/trace-events                    |   2 +-
> >  tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9723 bytes
> 
> Hi Michael,
> There is a CI failure, probably related to the DSDT.cxl change in this
> pull request:
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_IMG=./qemu-img
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
> MALLOC_PERTURB_=165
> G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/FLaZkdt1/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh
> /home/gitlab-runner/builds/FLaZkdt1/0/qemu-project/qemu/build/tests/qtest/bios-tables-test
> --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> acpi-test: Warning! DSDT binary file mismatch. Actual
> [aml:/tmp/aml-O8CAC2], Expected [aml:tests/data/acpi/q35/DSDT.cxl].
> See source file tests/qtest/bios-tables-test.c for instructions on how
> to update expected files.
> to see ASL diff between mismatched files install IASL, rebuild QEMU
> from scratch and re-run tests with V=1 environment variable set**
> ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion
> failed: (all_tables_match)
> (test program exited with status code -6)
> 
> Please take a look:
> https://gitlab.com/qemu-project/qemu/-/jobs/5222693360
> 
> Stefan
> 
> >  tests/unit/meson.build                    |   1 +
> >  74 files changed, 2192 insertions(+), 558 deletions(-)
> >  create mode 100644 include/hw/virtio/vhost-user-device.h
> >  create mode 100644 include/hw/virtio/virtio-dmabuf.h
> >  create mode 100644 hw/display/virtio-dmabuf.c
> >  delete mode 100644 hw/i386/generic_event_device_x86.c
> >  create mode 100644 hw/virtio/vhost-user-device-pci.c
> >  create mode 100644 hw/virtio/vhost-user-device.c
> >  create mode 100644 tests/unit/test-virtio-dmabuf.c
> >
> >


Hmm something related to that (ubuntu on s390) environment and triggered
by fortify source somehow? Weird. My guess would be an uninitialized
variable somwhere, which if true would be serious enough. Unfortunately
IIRC IASL is not available on that platform. Is there a way to get the
binaries from that build to compare against expected files?

-- 
MST


