Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C107D137C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:02:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrwo-0006sl-Jf; Fri, 20 Oct 2023 12:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtrvj-00062F-Tg
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:00:56 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtrvc-0000Pf-N6
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:00:55 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5842a7fdc61so186308eaf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697817646; x=1698422446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybzK6tYNMymjhRKKHA9VoHc7e1IbOGYvoEkSuz0DuMU=;
 b=LjakePwb61VUZZDPXg9gKagSoyWKkNesXPTmOQ/5FnN/tgqwICowqXVyZgd9Wx/LuA
 BbsmJvLZ6N0pn5fZ94CJECQj2mtTU4uV1uhQQ+NLXIPPUWg92ARDFA5IKdAy7Jc1SQww
 AUoiWYx94/p1Fh3LqR/qMGjiPEABFDPAzLDZMFPEYdJOaOjVzwPpizfeCxlPMPavxibW
 eqp36IjSGCYOo+C3WbM4KWlRzCaed6sHwjTTQPEKSGQbd0eAPnNH9N4Dfq41YTCVl2b0
 FIlNq7wqAbGVpXhYq6lHPR97wMZF/vFWtVBwxWqywUJfuG0k6coNKZDqHctN66v/TH81
 1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697817646; x=1698422446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybzK6tYNMymjhRKKHA9VoHc7e1IbOGYvoEkSuz0DuMU=;
 b=hcMnqmNuxPXvSJzxBUyYayeitrOMaHmbf5GgGvJjz+OVmq1VWuDIRtIuie+txCzM+b
 Zmg7p1BoP1JEIc5F+7iAZoJ03nO1zM7qsNzJ+dQeR0lMLh+6vcVKlopsBtsWPWHljORl
 RJi1IoZAPqngrGZ4vyooEnglrNslUCnqJFCd9IQ+oKGg1D/v8XXQQpD7C8tsyG8eehRL
 E8AZwfYVtwqoDjRY/Zdn8muILI2FcbgVN0fltYoDSWrD0Nju3cRdHKlhWCG6el7TmJOt
 AzJvY3gGOsoNTXnhtfPZG6PR8LPEYRUDFsR1BYNhnPofsh65Gci4kjbjW6hnwT1lrbzt
 nQUQ==
X-Gm-Message-State: AOJu0YzHRtMoFC2k0kOrSH1AusTOGWABONdzp3d+MhTHIsuf0/Icr382
 foftbaROBpjLUZx7MxnB+Z3cc/tRe5om2lx1FkQ=
X-Google-Smtp-Source: AGHT+IFnNMek+PafUyBK1nX+CtqOyapKJ7la74YJWPfE1lh4mKn/omb/MuhWf/rMWyomSWqc8malLLGAZoNvk8dzam8=
X-Received: by 2002:a4a:bb0f:0:b0:582:99ae:ca4c with SMTP id
 f15-20020a4abb0f000000b0058299aeca4cmr2753014oop.8.1697817645778; Fri, 20 Oct
 2023 09:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697739629.git.mst@redhat.com>
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Oct 2023 09:00:33 -0700
Message-ID: <CAJSP0QVTPz4i6WgsNxrOS+M6JqakM8i7eROWg0XAraFcRYajgQ@mail.gmail.com>
Subject: Re: [PULL v2 00/78] virtio,pc,pci: features, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

On Thu, 19 Oct 2023 at 11:30, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v1:
>     dropped shadow vq patches
>
> The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c3=
59:
>
>   Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.=
quintela/qemu into staging (2023-10-17 10:06:21 -0400)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 16ef005ba922d5af498e9f0f2ee6b29a318821a8:
>
>   intel-iommu: Report interrupt remapping faults, fix return value (2023-=
10-19 14:11:17 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,pci: features, cleanups
>
> infrastructure for vhost-vdpa shadow work
> piix south bridge rework
> reconnect for vhost-user-scsi
> dummy ACPI QTG DSM for cxl
>
> tests, cleanups, fixes all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Hi Michael,
I think the following bios-tables-test failure is caused by this pull reque=
st:

>>> MALLOC_PERTURB_=3D158 QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_BINARY=3D.=
/qemu-system-x86_64 G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/db=
us-vmstate-daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qe=
mu-storage-daemon PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/bin/pytho=
n3.8 /builds/qemu-project/qemu/build/tests/qtest/bios-tables-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested
(260) exceeds the recommended cpus supported by KVM (240)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus
requested (260) exceeds the recommended cpus supported by KVM (240)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus
requested (520) exceeds the recommended cpus supported by KVM (240)
Number of hotpluggable cpus requested (520) exceeds the maximum cpus
supported by KVM (288)
socket_accept failed: Resource temporarily unavailable
**
ERROR:../tests/qtest/libqtest.c:496:qtest_init_internal: assertion
failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/5338513625

Please take a look. Thanks!

Stefan

> ----------------------------------------------------------------
> Ani Sinha (1):
>       hw/i386/cxl: ensure maxram is greater than ram size for calculating=
 cxl range
>
> Bernhard Beschow (30):
>       hw/i386/acpi-build: Remove build-time assertion on PIIX/ICH9 reset =
registers being identical
>       hw/i386/pc: Merge two if statements into one
>       hw/i386/pc_piix: Allow for setting properties before realizing PIIX=
3 south bridge
>       hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
>       hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
>       hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs" prop=
erty
>       hw/i386/pc_piix: Remove redundant "piix3" variable
>       hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
>       hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its real=
ize()
>       hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
>       hw/i386/pc: Wire RTC ISA IRQs in south bridges
>       hw/isa/piix3: Create IDE controller in host device
>       hw/isa/piix3: Create USB controller in host device
>       hw/isa/piix3: Create power management controller in host device
>       hw/isa/piix3: Drop the "3" from PIIX base class name
>       hw/isa/piix4: Remove unused inbound ISA interrupt lines
>       hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
>       hw/isa/piix4: Rename reset control operations to match PIIX3
>       hw/isa/piix4: Reuse struct PIIXState from PIIX3
>       hw/isa/piix3: Merge hw/isa/piix4.c
>       hw/isa/piix: Allow for optional PIC creation in PIIX3
>       hw/isa/piix: Allow for optional PIT creation in PIIX3
>       hw/isa/piix: Harmonize names of reset control memory regions
>       hw/isa/piix: Share PIIX3's base class with PIIX4
>       hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
>       hw/isa/piix: Rename functions to be shared for PCI interrupt trigge=
ring
>       hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
>       hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
>       hw/isa/piix: Implement multi-process QEMU support also for PIIX4
>       hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine
>
> Damien Zammit (1):
>       timer/i8254: Fix one shot PIT mode
>
> Dave Jiang (1):
>       hw/cxl: Add QTG _DSM support for ACPI0017 device
>
> David Woodhouse (1):
>       intel-iommu: Report interrupt remapping faults, fix return value
>
> Hanna Czenczek (1):
>       vhost-user: Fix protocol feature bit conflict
>
> Hawkins Jiawei (7):
>       vdpa: Use iovec for vhost_vdpa_net_cvq_add()
>       vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_lo=
ad()
>       vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
>       vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add=
()
>       vdpa: Introduce cursors to vhost_vdpa_net_loadx()
>       vhost: Expose vhost_svq_available_slots()
>       vdpa: Send cvq state load commands in parallel
>
> Ilya Maximets (1):
>       memory: initialize 'fv' in MemoryRegionCache to make Coverity happy
>
> Jonathan Cameron (2):
>       tests/acpi: Allow update of DSDT.cxl
>       tests/acpi: Update DSDT.cxl with QTG DSM
>
> Laszlo Ersek (7):
>       vhost-user: strip superfluous whitespace
>       vhost-user: tighten "reply_supported" scope in "set_vring_addr"
>       vhost-user: factor out "vhost_user_write_sync"
>       vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
>       vhost-user: hoist "write_sync", "get_features", "get_u64"
>       vhost-user: allow "vhost_set_vring" to wait for a reply
>       vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
>
> Li Feng (5):
>       vhost-user-common: send get_inflight_fd once
>       vhost: move and rename the conn retry times
>       vhost-user-scsi: support reconnect to backend
>       vhost-user-scsi: start vhost when guest kicks
>       vhost-user: fix lost reconnect
>
> Matheus Tavares Bernardino (1):
>       hw/display: fix memleak from virtio_add_resource
>
> Stefan Hajnoczi (3):
>       vhost-user: do not send RESET_OWNER on device reset
>       vhost-backend: remove vhost_kernel_reset_device()
>       virtio: call ->vhost_reset_device() during reset
>
> Thomas Huth (1):
>       MAINTAINERS: Add include/hw/intc/i8259.h to the PC chip section
>
> Zhao Liu (16):
>       tests: test-smp-parse: Add the test for cores/threads per socket he=
lpers
>       tests: bios-tables-test: Prepare the ACPI table change for smbios t=
ype4 count test
>       tests: bios-tables-test: Add test for smbios type4 count
>       tests: bios-tables-test: Add ACPI table binaries for smbios type4 c=
ount test
>       tests: bios-tables-test: Prepare the ACPI table change for smbios t=
ype4 core count test
>       tests: bios-tables-test: Add test for smbios type4 core count
>       tests: bios-tables-test: Add ACPI table binaries for smbios type4 c=
ore count test
>       tests: bios-tables-test: Prepare the ACPI table change for smbios t=
ype4 core count2 test
>       tests: bios-tables-test: Extend smbios core count2 test to cover ge=
neral topology
>       tests: bios-tables-test: Update ACPI table binaries for smbios core=
 count2 test
>       tests: bios-tables-test: Prepare the ACPI table change for smbios t=
ype4 thread count test
>       tests: bios-tables-test: Add test for smbios type4 thread count
>       tests: bios-tables-test: Add ACPI table binaries for smbios type4 t=
hread count test
>       tests: bios-tables-test: Prepare the ACPI table change for smbios t=
ype4 thread count2 test
>       tests: bios-tables-test: Add test for smbios type4 thread count2
>       tests: bios-tables-test: Add ACPI table binaries for smbios type4 t=
hread count2 test
>
>  hw/i386/intel_iommu_internal.h            |   1 +
>  hw/virtio/vhost-shadow-virtqueue.h        |   1 +
>  include/exec/memory.h                     |   2 +
>  include/hw/acpi/cxl.h                     |   1 +
>  include/hw/i386/pc.h                      |   2 +
>  include/hw/southbridge/piix.h             |  30 ++-
>  include/hw/virtio/vhost-scsi-common.h     |   2 +-
>  include/hw/virtio/vhost-user-scsi.h       |   6 +
>  include/hw/virtio/vhost-user.h            |   6 +-
>  include/hw/virtio/vhost.h                 |  12 +
>  subprojects/libvhost-user/libvhost-user.h |   3 +-
>  hw/acpi/cxl.c                             |  69 ++++++
>  hw/block/vhost-user-blk.c                 |   6 +-
>  hw/display/virtio-dmabuf.c                |  12 +-
>  hw/i386/acpi-build.c                      |   6 +-
>  hw/i386/intel_iommu.c                     | 150 ++++++++----
>  hw/i386/pc.c                              |  19 +-
>  hw/i386/pc_piix.c                         | 123 +++++++---
>  hw/i386/pc_q35.c                          |  14 +-
>  hw/isa/lpc_ich9.c                         |   9 +-
>  hw/isa/{piix3.c =3D> piix.c}                | 281 ++++++++++++++++------
>  hw/isa/piix4.c                            | 302 ------------------------
>  hw/mips/malta.c                           |   5 +-
>  hw/scsi/vhost-scsi-common.c               |  47 ++--
>  hw/scsi/vhost-scsi.c                      |   6 +-
>  hw/scsi/vhost-user-scsi.c                 | 254 +++++++++++++++++---
>  hw/timer/i8254_common.c                   |   4 +-
>  hw/virtio/vhost-backend.c                 |   6 -
>  hw/virtio/vhost-shadow-virtqueue.c        |   2 +-
>  hw/virtio/vhost-user-gpio.c               |   5 +-
>  hw/virtio/vhost-user.c                    | 239 ++++++++++---------
>  hw/virtio/vhost.c                         |   9 +
>  hw/virtio/virtio.c                        |   4 +
>  net/vhost-vdpa.c                          | 374 +++++++++++++++++++-----=
------
>  tests/qtest/bios-tables-test.c            | 116 ++++++++-
>  tests/unit/test-smp-parse.c               |  67 ++++--
>  MAINTAINERS                               |   7 +-
>  docs/interop/vhost-user.rst               |  11 +
>  docs/system/target-i386-desc.rst.inc      |   8 +
>  hw/i386/Kconfig                           |   3 +-
>  hw/isa/Kconfig                            |   8 +-
>  hw/isa/meson.build                        |   3 +-
>  hw/mips/Kconfig                           |   2 +-
>  meson.build                               |   1 +
>  tests/data/acpi/q35/APIC.core-count       | Bin 0 -> 544 bytes
>  tests/data/acpi/q35/APIC.core-count2      | Bin 2478 -> 3238 bytes
>  tests/data/acpi/q35/APIC.thread-count     | Bin 0 -> 544 bytes
>  tests/data/acpi/q35/APIC.thread-count2    | Bin 0 -> 7398 bytes
>  tests/data/acpi/q35/APIC.type4-count      | Bin 0 -> 1072 bytes
>  tests/data/acpi/q35/DSDT.core-count       | Bin 0 -> 12913 bytes
>  tests/data/acpi/q35/DSDT.core-count2      | Bin 32495 -> 33770 bytes
>  tests/data/acpi/q35/DSDT.cxl              | Bin 9655 -> 9713 bytes
>  tests/data/acpi/q35/DSDT.thread-count     | Bin 0 -> 12913 bytes
>  tests/data/acpi/q35/DSDT.thread-count2    | Bin 0 -> 63671 bytes
>  tests/data/acpi/q35/DSDT.type4-count      | Bin 0 -> 18589 bytes
>  tests/data/acpi/q35/FACP.core-count       | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.thread-count     | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.thread-count2    | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.type4-count      | Bin 0 -> 244 bytes
>  59 files changed, 1386 insertions(+), 852 deletions(-)
>  rename hw/isa/{piix3.c =3D> piix.c} (52%)
>  delete mode 100644 hw/isa/piix4.c
>  create mode 100644 tests/data/acpi/q35/APIC.core-count
>  create mode 100644 tests/data/acpi/q35/APIC.thread-count
>  create mode 100644 tests/data/acpi/q35/APIC.thread-count2
>  create mode 100644 tests/data/acpi/q35/APIC.type4-count
>  create mode 100644 tests/data/acpi/q35/DSDT.core-count
>  create mode 100644 tests/data/acpi/q35/DSDT.thread-count
>  create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
>  create mode 100644 tests/data/acpi/q35/DSDT.type4-count
>  create mode 100644 tests/data/acpi/q35/FACP.core-count
>  create mode 100644 tests/data/acpi/q35/FACP.thread-count
>  create mode 100644 tests/data/acpi/q35/FACP.thread-count2
>  create mode 100644 tests/data/acpi/q35/FACP.type4-count
>
>

