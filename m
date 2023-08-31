Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678CF78EE9B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:27:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhgZ-0004rn-4t; Thu, 31 Aug 2023 09:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgP-0004cl-JM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgJ-0007L9-QQ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ChPjbICG22oISTLdoZBu20p3DiMRw4EY8JI0c9BFGJs=;
 b=Bpue9hgMgaaGpSlGzwi4qtWOrr4Y9cKBO0yuEtmpWYn1cPu7dvEA0uhAx0R9Q15JToLACd
 OhFzZtvzVK2VOFK7DYAvD+wOfKIrKNd+/w19AK5Mxw/weqtqDteAXluOeSHvJORCGnsNmR
 Lziscwgm71gP/HsRlryYGNOzJxVle2E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-7l0Kjf4tPbm-G8T1mwim1w-1; Thu, 31 Aug 2023 09:25:49 -0400
X-MC-Unique: 7l0Kjf4tPbm-G8T1mwim1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFC401C0726F;
 Thu, 31 Aug 2023 13:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDEBAC15BAE;
 Thu, 31 Aug 2023 13:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B418921E690D; Thu, 31 Aug 2023 15:25:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 0/7] Steps towards enabling -Wshadow=local
Date: Thu, 31 Aug 2023 15:25:39 +0200
Message-ID: <20230831132546.3525721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: PATCH 1.

Enabling -Wshadow would prevent bugs like this one.  But we'd have to
clean up all the offenders first.  We got a lot of them.

Enabling -Wshadow=local should be less work for almost as much gain.
I took a stab at it.  There's a small, exciting part, and a large,
boring part.

The exciting part is dark preprocessor sorcery to let us nest macro
calls without shadowing: PATCH 7.

The boring part is cleaning up all the other warnings.  I did some
[PATCH 2-6], but ran out of steam long before finishing the job.  Some
160 unique warnings remain.

To see them, enable -Wshadow=local like so:

diff --git a/meson.build b/meson.build
index 98e68ef0b1..9fc4c7ac9d 100644
--- a/meson.build
+++ b/meson.build
@@ -466,6 +466,9 @@ warn_flags = [
   '-Wno-tautological-type-limit-compare',
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
+  '-Wshadow=local',
+  '-Wno-error=shadow=local',
+  '-Wno-error=shadow=compatible-local',
 ]
 
 if targetos != 'darwin'

You may want to drop the -Wno-error lines.

Subsystems with -Wshadow=local warnings:

    virtio-gpu
    virtio
    Device Tree
    Overall TCG CPUs
    Overall Audio backends
    Open Sound System (OSS) Audio backend
    vhost
    vhost-user-gpu
    Cryptography
    M68K TCG CPUs
    Dump
    ACPI/SMBIOS
    Allwinner-a10
    ARM TCG CPUs
    MPS2
    ASPEED BMCs
    ARM SMMU
    Virt
    Machine core
    PC Chipset
    X86 TCG CPUs
    PC
    VT-d Emulation
    IDE
    ARM cores
    OpenPIC interrupt controller
    q800
    petalogix_ml605
    MicroBlaze TCG CPUs
    Versatile PB
    Network devices
    NiosII TCG CPUs
    nvme
    PowerNV (Non-Virtualized)
    sPAPR (pseries)
    OpenTitan
    RISC-V TCG CPUs
    SCSI
    USB
    Linux user
    Network packet abstractions
    Network device backends
    Network Block Device (NBD)
    Semihosting
    Memory API
    Seccomp
    Main loop
    Hexagon TCG CPUs
    X86 KVM CPUs
    MIPS TCG CPUs
    PowerPC TCG CPUs
    TriCore TCG CPUs
    Common TCG code
    qtest
    Throttling infrastructure
    Vhost-user block device backend server

Files with -Wshadow=local warnings:

    accel/tcg/tb-maint.c
    audio/audio.c
    audio/ossaudio.c
    contrib/vhost-user-gpu/vhost-user-gpu.c
    contrib/vhost-user-gpu/vugpu.h
    crypto/cipher-gnutls.c.inc
    crypto/tls-cipher-suites.c
    disas/m68k.c
    dump/dump.c
    hw/acpi/cpu_hotplug.c
    hw/arm/allwinner-r40.c
    hw/arm/armsse.c
    hw/arm/armv7m.c
    hw/arm/aspeed_ast2600.c
    hw/arm/smmuv3-internal.h
    hw/arm/smmuv3.c
    hw/arm/virt.c
    hw/core/machine.c
    hw/i2c/aspeed_i2c.c
    hw/i2c/pm_smbus.c
    hw/i386/acpi-build.c
    hw/i386/acpi-microvm.c
    hw/i386/intel_iommu.c
    hw/i386/pc.c
    hw/i386/x86.c
    hw/ide/ahci.c
    hw/intc/arm_gicv3_its.c
    hw/intc/openpic.c
    hw/loongarch/virt.c
    hw/m68k/bootinfo.h
    hw/microblaze/petalogix_ml605_mmu.c
    hw/misc/arm_sysctl.c
    hw/misc/aspeed_i3c.c
    hw/net/vhost_net.c
    hw/nios2/10m50_devboard.c
    hw/nvme/ns.c
    hw/ppc/pnv_psi.c
    hw/ppc/spapr.c
    hw/ppc/spapr_drc.c
    hw/ppc/spapr_pci.c
    hw/riscv/opentitan.c
    hw/scsi/mptsas.c
    hw/smbios/smbios.c
    hw/usb/desc.c
    hw/usb/dev-hub.c
    hw/usb/dev-storage.c
    hw/usb/hcd-xhci.c
    hw/usb/host-libusb.c
    hw/virtio/vhost.c
    hw/virtio/virtio-pci.c
    include/hw/cxl/cxl_device.h
    include/hw/ppc/fdt.h
    include/hw/virtio/virtio-gpu.h
    include/sysemu/device_tree.h
    linux-user/flatload.c
    linux-user/mmap.c
    linux-user/strace.c
    linux-user/syscall.c
    net/eth.c
    qemu-nbd.c
    semihosting/arm-compat-semi.c
    softmmu/device_tree.c
    softmmu/memory.c
    softmmu/physmem.c
    softmmu/qemu-seccomp.c
    softmmu/vl.c
    target/arm/tcg/mve_helper.c
    target/arm/tcg/translate-m-nocp.c
    target/hexagon/helper_funcs_generated.c.inc
    target/hexagon/mmvec/macros.h
    target/hexagon/op_helper.c
    target/hexagon/translate.c
    target/i386/cpu.c
    target/i386/kvm/kvm.c
    target/i386/tcg/seg_helper.c
    target/i386/tcg/sysemu/svm_helper.c
    target/i386/tcg/translate.c
    target/m68k/translate.c
    target/mips/tcg/msa_helper.c
    target/mips/tcg/nanomips_translate.c.inc
    target/mips/tcg/translate.c
    target/ppc/int_helper.c
    target/riscv/cpu.c
    target/riscv/vector_helper.c
    target/tricore/translate.c
    tcg/tcg.c
    tests/qtest/m48t59-test.c
    tests/qtest/pflash-cfi02-test.c
    tests/unit/test-throttle.c
    util/vhost-user-server.c

Markus Armbruster (7):
  migration/rdma: Fix save_page method to fail on polling error
  migration: Clean up local variable shadowing
  ui: Clean up local variable shadowing
  block/dirty-bitmap: Clean up local variable shadowing
  block/vdi: Clean up local variable shadowing
  block: Clean up local variable shadowing
  qobject atomics osdep: Make a few macros more hygienic

 include/qapi/qmp/qobject.h      |  8 +++++---
 include/qemu/atomic.h           | 11 ++++++-----
 include/qemu/osdep.h            | 34 ++++++++++++++++++---------------
 block.c                         |  7 ++++---
 block/monitor/bitmap-qmp-cmds.c |  2 +-
 block/qcow2-bitmap.c            |  3 +--
 block/rbd.c                     |  2 +-
 block/stream.c                  |  1 -
 block/vdi.c                     |  7 +++----
 block/vvfat.c                   | 34 ++++++++++++++++-----------------
 hw/block/xen-block.c            |  6 +++---
 migration/block.c               |  4 ++--
 migration/ram.c                 |  8 +++-----
 migration/rdma.c                | 14 +++++++++-----
 migration/vmstate.c             |  2 +-
 ui/gtk.c                        | 14 +++++++-------
 ui/spice-display.c              |  9 +++++----
 ui/vnc-palette.c                |  2 --
 ui/vnc.c                        | 12 ++++++------
 ui/vnc-enc-zrle.c.inc           |  9 ++++-----
 20 files changed, 97 insertions(+), 92 deletions(-)

-- 
2.41.0


