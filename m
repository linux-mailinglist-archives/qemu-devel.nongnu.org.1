Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D227B8944
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6XB-00007h-1t; Wed, 04 Oct 2023 14:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo6X1-00004t-9n
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:23:36 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qo6Wv-0003Lr-Kx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:23:35 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bb6a2481fso57770eaf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696443808; x=1697048608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPD4NqM88aAiplKkzkofTCm2yROaCLdjq5REV3kpVpk=;
 b=hBHYLBQpjrEbAcVFeUCb3Ctm1FNZ1o27psWfhkePl0T4CzRaqtfTj4iZgsg51vVTUf
 VK26tR2V7QsfE7odDU84mY2W24uqe4Eo2Ss5WAKzMYbDOBd+pSOOrXJO/h3q4NoYwX+Y
 VpPgXyWe6DGeN03XGyBZz3PO4dLHXUIUVGUa2s6jXhl9nGINFwiGgQLmMXZiD2CWtxh7
 V1+CILpTnZrm/54MBzsdWuB8GdmyuK7ToZy9Qyr0w3p9hFWwDd7tpyOmQSbH2S5Vk8WX
 SKZVXaxqQJC2RCeukhEpVhyM1KdbN8HPmG01zfzl/nVNJXIlx9qjkJUtkaxq1k40w530
 ac9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443808; x=1697048608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPD4NqM88aAiplKkzkofTCm2yROaCLdjq5REV3kpVpk=;
 b=tpaA8Q0PUM7BfEzNcMn4mjUmgBKPZR9r49rMBv5eQ11PtVgc/x4TlUi+kx1hh9wVMG
 PPNxrLxt8av+ww9iT++6jcgr4XEb67y+PRcyE+NLJOCp62p8CVShuEtO5A7IHTLSFWwA
 mTLAZLDBxGDV7d74cvCCLCl/u0dMSBgbdGP6DaZtO03+TTtUYO0bAlDBiVUl/lgpcx/a
 ZD3ttzixPvuksSxHc8kFxBVTzk7MvFk0bVHDSN+UpWxWAy/KXoS8ER5A8lRfTJcCcsvv
 eURNlVqZyHqAaFjiqRKkCi/60GjPSOYA8cZRmKwjwyWjMregZUoDlCyo56wFOOSAfj7u
 cK2w==
X-Gm-Message-State: AOJu0YxaRyhGVKBSsnQDME7TJ8IcK+QPX7oyY9VJBYynEKD4hol+falF
 VxhLsb5KN8XtpaF6SJbeXOJx1+Oah6yT7ugdGTIAucHhZys=
X-Google-Smtp-Source: AGHT+IFnQVYl5xsWj39iUR2SqJryJC0HQZBk3ZIBkX/68RJ/3VDc0EiPNhoY3S5Jndhx2f1655NxxsNj1fkobzH8ta8=
X-Received: by 2002:a4a:6c02:0:b0:57b:8f92:aefb with SMTP id
 q2-20020a4a6c02000000b0057b8f92aefbmr2937662ooc.7.1696443807788; Wed, 04 Oct
 2023 11:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696408966.git.mst@redhat.com>
 <CAJSP0QVfn__LKXVO5puOs4h5AV9FWGNKiJXUnSe-K+ANP+=wCg@mail.gmail.com>
 <20231004130205-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231004130205-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Oct 2023 14:23:15 -0400
Message-ID: <CAJSP0QUN5E0jZPw+qCvTrs-RmT1UXkKNFAMbWO=53HbfDQ0SGA@mail.gmail.com>
Subject: Re: [PULL 00/63] virtio,pci: features, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The link to the job is https://gitlab.com/qemu-project/qemu/-/jobs/52226933=
60.

The link to the pipeline is
https://gitlab.com/qemu-project/qemu/-/pipelines/1025613961.

On Wed, 4 Oct 2023 at 13:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 04, 2023 at 12:50:18PM -0400, Stefan Hajnoczi wrote:
> > On Wed, 4 Oct 2023 at 04:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > The following changes since commit 494a6a2cf7f775d2c20fd6df9601e30606=
cc2014:
> > >
> > >   Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qem=
u into staging (2023-09-25 10:10:30 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstr=
eam
> > >
> > > for you to fetch changes up to dc1499091ca09db0ac7a5615a592e55f27d496=
5d:
> > >
> > >   libvhost-user: handle shared_object msg (2023-10-04 04:28:35 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio,pci: features, cleanups
> > >
> > > vdpa:
> > >       shadow vq vlan support
> > >       net migration with cvq
> > > cxl:
> > >      dummy ACPI QTG DSM
> > >      support emulating 4 HDM decoders
> > >      serial number extended capability
> > > virtio:
> > >       hared dma-buf
> > >
> > > Fixes, cleanups all over the place.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> > > Akihiko Odaki (1):
> > >       amd_iommu: Fix APIC address check
> > >
> > > Albert Esteve (4):
> > >       util/uuid: add a hash function
> > >       hw/display: introduce virtio-dmabuf
> > >       vhost-user: add shared_object msg
> > >       libvhost-user: handle shared_object msg
> > >
> > > Alex Benn=C3=A9e (2):
> > >       virtio: add vhost-user-base and a generic vhost-user-device
> > >       hw/virtio: add config support to vhost-user-device
> > >
> > > Ani Sinha (1):
> > >       hw/i386/pc: improve physical address space bound check for 32-b=
it x86 systems
> > >
> > > Bernhard Beschow (8):
> > >       hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
> > >       hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn cal=
lback
> > >       hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual =
method
> > >       hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boar=
ds.h"
> > >       hw/i386: Remove now redundant TYPE_ACPI_GED_X86
> > >       hw/i386/acpi-build: Determine SMI command port just once
> > >       hw/acpi: Trace GPE access in all device models, not just PIIX4
> > >       hw/acpi/core: Trace enable and status registers of GPE separate=
ly
> > >
> > > Dave Jiang (1):
> > >       hw/cxl: Add QTG _DSM support for ACPI0017 device
> > >
> > > David Woodhouse (1):
> > >       hw/isa/ich9: Add comment on imperfect emulation of PIC vs. I/O =
APIC routing
> > >
> > > Eugenio P=C3=A9rez (9):
> > >       vdpa: use first queue SVQ state for CVQ default
> > >       vdpa: export vhost_vdpa_set_vring_ready
> > >       vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load
> > >       vdpa: move vhost_vdpa_set_vring_ready to the caller
> > >       vdpa: remove net cvq migration blocker
> > >       vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
> > >       vdpa net: fix error message setting virtio status
> > >       vdpa net: stop probing if cannot set features
> > >       vdpa net: follow VirtIO initialization properly at cvq isolatio=
n probing
> > >
> > > Hawkins Jiawei (5):
> > >       virtio-net: do not reset vlan filtering at set_features
> > >       virtio-net: Expose MAX_VLAN
> > >       vdpa: Restore vlan filtering state
> > >       vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
> > >       vhost: Add count argument to vhost_svq_poll()
> > >
> > > Ilya Maximets (4):
> > >       virtio: don't zero out memory region cache for indirect descrip=
tors
> > >       virtio: use shadow_avail_idx while checking number of heads
> > >       virtio: remove unnecessary thread fence while reading next desc=
riptor
> > >       virtio: remove unused next argument from virtqueue_split_read_n=
ext_desc()
> > >
> > > Jonah Palmer (3):
> > >       qmp: remove virtio_list, search QOM tree instead
> > >       qmp: update virtio feature maps, vhost-user-gpio introspection
> > >       vhost-user: move VhostUserProtocolFeature definition to header =
file
> > >
> > > Jonathan Cameron (7):
> > >       tests/acpi: Allow update of DSDT.cxl
> > >       tests/acpi: Update DSDT.cxl with QTG DSM
> > >       hw/cxl: Push cxl_decoder_count_enc() and cxl_decode_ig() into .=
c
> > >       hw/cxl: Add utility functions decoder interleave ways and targe=
t count.
> > >       hw/cxl: Fix and use same calculation for HDM decoder block size=
 everywhere
> > >       hw/cxl: Support 4 HDM decoders at all levels of topology
> > >       hw/pci-bridge/cxl-upstream: Add serial number extended capabili=
ty support
> > >
> > > Laszlo Ersek (7):
> > >       vhost-user: strip superfluous whitespace
> > >       vhost-user: tighten "reply_supported" scope in "set_vring_addr"
> > >       vhost-user: factor out "vhost_user_write_sync"
> > >       vhost-user: flatten "enforce_reply" into "vhost_user_write_sync=
"
> > >       vhost-user: hoist "write_sync", "get_features", "get_u64"
> > >       vhost-user: allow "vhost_set_vring" to wait for a reply
> > >       vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
> > >
> > > Michael S. Tsirkin (1):
> > >       pci: SLT must be RO
> > >
> > > Philippe Mathieu-Daud=C3=A9 (6):
> > >       hw/virtio: Propagate page_mask to vhost_vdpa_listener_skipped_s=
ection()
> > >       hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
> > >       hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
> > >       hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask=
()
> > >       hw/virtio: Build vhost-vdpa.o once
> > >       hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss=
[]
> > >
> > > Stefan Hajnoczi (1):
> > >       vdpa: fix gcc cvq_isolated uninitialized variable warning
> > >
> > > Vladimir Sementsov-Ogievskiy (2):
> > >       pcie_sriov: unregister_vfs(): fix error path
> > >       libvhost-user.c: add assertion to vu_message_read_default
> > >
> > >  hw/acpi/hmat.h                            |   3 +-
> > >  hw/i386/acpi-common.h                     |   3 +-
> > >  hw/i386/amd_iommu.h                       |   2 -
> > >  hw/virtio/vhost-shadow-virtqueue.h        |   2 +-
> > >  hw/virtio/virtio-qmp.h                    |   7 -
> > >  include/exec/memory.h                     |  16 +-
> > >  include/hw/acpi/acpi_dev_interface.h      |   3 -
> > >  include/hw/acpi/cpu.h                     |   6 +-
> > >  include/hw/acpi/cxl.h                     |   1 +
> > >  include/hw/acpi/generic_event_device.h    |   2 -
> > >  include/hw/cxl/cxl_component.h            |  30 ++-
> > >  include/hw/i386/pc.h                      |   6 +
> > >  include/hw/pci/pci_bridge.h               |   3 +
> > >  include/hw/virtio/vhost-backend.h         |   3 +
> > >  include/hw/virtio/vhost-user-device.h     |  46 ++++
> > >  include/hw/virtio/vhost-user.h            |  22 ++
> > >  include/hw/virtio/vhost-vdpa.h            |   1 +
> > >  include/hw/virtio/virtio-dmabuf.h         | 100 ++++++++
> > >  include/hw/virtio/virtio-net.h            |   6 +
> > >  include/qemu/uuid.h                       |   2 +
> > >  subprojects/libvhost-user/libvhost-user.h |  55 +++-
> > >  hw/acpi/acpi-x86-stub.c                   |   6 -
> > >  hw/acpi/core.c                            |   9 +
> > >  hw/acpi/cpu.c                             |   9 +-
> > >  hw/acpi/cxl.c                             |  57 +++++
> > >  hw/acpi/hmat.c                            |   1 +
> > >  hw/acpi/memory_hotplug.c                  |   1 +
> > >  hw/acpi/piix4.c                           |   5 -
> > >  hw/core/machine.c                         |   5 +-
> > >  hw/cxl/cxl-component-utils.c              |  92 ++++++-
> > >  hw/cxl/cxl-host.c                         |  67 +++--
> > >  hw/display/virtio-dmabuf.c                | 138 ++++++++++
> > >  hw/i386/acpi-build.c                      |  14 +-
> > >  hw/i386/acpi-common.c                     |   5 +-
> > >  hw/i386/acpi-microvm.c                    |   3 +-
> > >  hw/i386/amd_iommu.c                       |   9 +-
> > >  hw/i386/generic_event_device_x86.c        |  36 ---
> > >  hw/i386/microvm.c                         |   2 +-
> > >  hw/i386/pc.c                              |  32 ++-
> > >  hw/i386/pc_piix.c                         |   4 +
> > >  hw/i386/pc_q35.c                          |   2 +
> > >  hw/isa/lpc_ich9.c                         |  16 +-
> > >  hw/mem/cxl_type3.c                        | 106 +++++---
> > >  hw/net/virtio-net.c                       |   6 +-
> > >  hw/pci-bridge/cxl_upstream.c              |  15 +-
> > >  hw/pci/pci.c                              |   2 +-
> > >  hw/pci/pci_bridge.c                       |  14 ++
> > >  hw/pci/pcie_sriov.c                       |   9 +-
> > >  hw/scsi/vhost-user-scsi.c                 |   4 -
> > >  hw/virtio/vdpa-dev.c                      |   3 +
> > >  hw/virtio/vhost-shadow-virtqueue.c        |  36 +--
> > >  hw/virtio/vhost-user-device-pci.c         |  71 ++++++
> > >  hw/virtio/vhost-user-device.c             | 380 ++++++++++++++++++++=
++++++++
> > >  hw/virtio/vhost-user-gpio.c               |   7 +
> > >  hw/virtio/vhost-user.c                    | 404 +++++++++++++++++++-=
----------
> > >  hw/virtio/vhost-vdpa.c                    |  66 ++---
> > >  hw/virtio/virtio-qmp.c                    | 139 +++++-----
> > >  hw/virtio/virtio.c                        |  64 +++--
> > >  net/vhost-vdpa.c                          | 153 +++++++----
> > >  subprojects/libvhost-user/libvhost-user.c | 121 +++++++++
> > >  tests/qtest/bios-tables-test.c            |  26 +-
> > >  tests/qtest/numa-test.c                   |   7 +-
> > >  tests/unit/test-uuid.c                    |  27 ++
> > >  tests/unit/test-virtio-dmabuf.c           | 137 ++++++++++
> > >  util/uuid.c                               |  14 ++
> > >  MAINTAINERS                               |   7 +
> > >  docs/interop/vhost-user.rst               |  57 +++++
> > >  hw/acpi/trace-events                      |  10 +-
> > >  hw/display/meson.build                    |   1 +
> > >  hw/i386/meson.build                       |   1 -
> > >  hw/virtio/meson.build                     |  28 ++-
> > >  hw/virtio/trace-events                    |   2 +-
> > >  tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9723 bytes
> >
> > Hi Michael,
> > There is a CI failure, probably related to the DSDT.cxl change in this
> > pull request:
> >
> > QTEST_QEMU_BINARY=3D./qemu-system-x86_64 QTEST_QEMU_IMG=3D./qemu-img
> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> > MALLOC_PERTURB_=3D165
> > G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/FLaZkdt1/0/qemu-project=
/qemu/tests/dbus-vmstate-daemon.sh
> > /home/gitlab-runner/builds/FLaZkdt1/0/qemu-project/qemu/build/tests/qte=
st/bios-tables-test
> > --tap -k
> > =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
> > stderr:
> > acpi-test: Warning! DSDT binary file mismatch. Actual
> > [aml:/tmp/aml-O8CAC2], Expected [aml:tests/data/acpi/q35/DSDT.cxl].
> > See source file tests/qtest/bios-tables-test.c for instructions on how
> > to update expected files.
> > to see ASL diff between mismatched files install IASL, rebuild QEMU
> > from scratch and re-run tests with V=3D1 environment variable set**
> > ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion
> > failed: (all_tables_match)
> > (test program exited with status code -6)
> >
> > Please take a look:
> > https://gitlab.com/qemu-project/qemu/-/jobs/5222693360
> >
> > Stefan
>
> OK but .. CI seemed to pass for me. Interesting.
> Could you send the link to the pipeline please?
>
>
> > >  tests/unit/meson.build                    |   1 +
> > >  74 files changed, 2192 insertions(+), 558 deletions(-)
> > >  create mode 100644 include/hw/virtio/vhost-user-device.h
> > >  create mode 100644 include/hw/virtio/virtio-dmabuf.h
> > >  create mode 100644 hw/display/virtio-dmabuf.c
> > >  delete mode 100644 hw/i386/generic_event_device_x86.c
> > >  create mode 100644 hw/virtio/vhost-user-device-pci.c
> > >  create mode 100644 hw/virtio/vhost-user-device.c
> > >  create mode 100644 tests/unit/test-virtio-dmabuf.c
> > >
> > >
>

