Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26AF7AAE52
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcbt-0004kU-Jk; Fri, 22 Sep 2023 05:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjcbp-0004ju-88
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjcbn-0004Ld-0F
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fz0tEF2D6BjuddKRMB8/HNV9+Ki8Dn3eRiusEq2TZbo=;
 b=N66NfWTK5oZNxq3eC/Zs4awqNgQ41jVjFNnpk7MK6KI2xT/tTFaZenIjnGHgqA0h/i2W/Z
 l+Qu7cLxxKfSxc9Xs+6RLK0emZ61vupBe4YqzTLDlIN9e+TFDU9N/EBkthVIXodZBtSFMz
 P+Zwi940PHDV+Mumpuk37m7AEJVQBxI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-Qs-NnyYrM3CpoC0ntAaOXg-1; Fri, 22 Sep 2023 05:37:52 -0400
X-MC-Unique: Qs-NnyYrM3CpoC0ntAaOXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 043393C11CCC;
 Fri, 22 Sep 2023 09:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6AEF40C2064;
 Fri, 22 Sep 2023 09:37:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C932021E6900; Fri, 22 Sep 2023 11:37:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel P. Berrange <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fan Ni <fan.ni@samsung.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Help wanted for enabling -Wshadow=local
Date: Fri, 22 Sep 2023 11:37:46 +0200
Message-ID: <87r0mqlf9x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If you are in To:, we need your help to enable -Wshadow=3Dlocal.

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
on polling error".

Enabling -Wshadow would prevent bugs like this one.  But we have to
clean up all the offenders first.

I collected the patches posted so far:

    [PATCH v3 0/7] Steps towards enabling -Wshadow=3Dlocal
    Message-ID: <20230921121312.1301864-1-armbru@redhat.com>

    [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow
    Message-ID: <20230904161235.84651-1-philmd@linaro.org>

    [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 more]
    Message-ID: <20230904162824.85385-1-philmd@linaro.org>

    [PATCH 0/8] ppc: Clean up local variable shadowing
    Message-ID: <20230918145850.241074-1-clg@kaod.org>

Thanks, Philippe & Cedric!

In my local build with -Wshadow=3Dlocal, warnings remain in just 56 files.

Sorted by subsystems, files covered by multiple subsystems marked
"(*NUMBER*)", files not covered in MAINTAINERS marked (*guess*):

Guest CPU cores (TCG)
---------------------
ARM TCG CPUs
M: Peter Maydell <peter.maydell@linaro.org>
    hw/arm/smmuv3-internal.h(*2*)
    hw/arm/smmuv3.c(*2*)

ARM SMMU
M: Eric Auger <eric.auger@redhat.com>
    hw/arm/smmuv3-internal.h(*2*)
    hw/arm/smmuv3.c(*2*)

Hexagon TCG CPUs
M: Brian Cain <bcain@quicinc.com>
    target/hexagon/gen_helper_funcs.py
    target/hexagon/mmvec/macros.h
    target/hexagon/op_helper.c
    target/hexagon/translate.c

M68K TCG CPUs
M: Laurent Vivier <laurent@vivier.eu>
    disas/m68k.c

PowerPC TCG CPUs
M: Nicholas Piggin <npiggin@gmail.com>
M: Daniel Henrique Barboza <danielhb413@gmail.com>
R: C=C3=A9dric Le Goater <clg@kaod.org>
    target/ppc/int_helper.c

RISC-V TCG CPUs
    hw/riscv/opentitan.c(*2*)
    target/riscv/cpu.c
    target/riscv/vector_helper.c

X86 TCG CPUs
M: Paolo Bonzini <pbonzini@redhat.com>
M: Richard Henderson <richard.henderson@linaro.org>
M: Eduardo Habkost <eduardo@habkost.net>
    hw/i386/acpi-build.c(*3*)
    hw/i386/acpi-microvm.c(*2*)
    hw/i386/intel_iommu.c(*3*)
    hw/i386/pc.c(*2*)
    hw/i386/x86.c(*2*)
    target/i386/cpu.c(*guess*)
    target/i386/tcg/seg_helper.c
    target/i386/tcg/sysemu/svm_helper.c
    target/i386/tcg/translate.c

Guest CPU Cores (KVM)
---------------------
X86 KVM CPUs
M: Paolo Bonzini <pbonzini@redhat.com>
M: Marcelo Tosatti <mtosatti@redhat.com>
    target/i386/kvm/kvm.c

ARM Machines
------------
ARM cores
M: Peter Maydell <peter.maydell@linaro.org>
    hw/intc/arm_gicv3_its.c

Versatile PB
M: Peter Maydell <peter.maydell@linaro.org>
    hw/misc/arm_sysctl.c

ASPEED BMCs
M: C=C3=A9dric Le Goater <clg@kaod.org>
M: Peter Maydell <peter.maydell@linaro.org>
R: Andrew Jeffery <andrew@aj.id.au>
R: Joel Stanley <joel@jms.id.au>
    hw/i2c/aspeed_i2c.c
    hw/misc/aspeed_i3c.c

LoongArch Machines
------------------
Virt
M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
M: Song Gao <gaosong@loongson.cn>
    hw/loongarch/virt.c

RISC-V Machines
---------------
OpenTitan
M: Alistair Francis <Alistair.Francis@wdc.com>
    hw/riscv/opentitan.c(*2*)

X86 Machines
------------
PC
M: Michael S. Tsirkin <mst@redhat.com>
M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
    hw/i386/acpi-build.c(*3*)
    hw/i386/acpi-microvm.c(*2*)
    hw/i386/intel_iommu.c(*3*)
    hw/i386/pc.c(*2*)
    hw/i386/x86.c(*2*)

PC Chipset
M: Michael S. Tsirkin <mst@redhat.com>
M: Paolo Bonzini <pbonzini@redhat.com>
    hw/i2c/pm_smbus.c

Devices
-------
ACPI/SMBIOS
M: Michael S. Tsirkin <mst@redhat.com>
M: Igor Mammedov <imammedo@redhat.com>
R: Ani Sinha <anisinha@redhat.com>
    hw/acpi/cpu_hotplug.c
    hw/i386/acpi-build.c(*3*)
    hw/smbios/smbios.c

Network devices
M: Jason Wang <jasowang@redhat.com>
    hw/net/vhost_net.c(*2*)

SCSI
M: Paolo Bonzini <pbonzini@redhat.com>
R: Fam Zheng <fam@euphon.net>
    hw/scsi/mptsas.c

USB
M: Gerd Hoffmann <kraxel@redhat.com>
    hw/usb/desc.c
    hw/usb/dev-hub.c
    hw/usb/dev-storage.c
    hw/usb/hcd-xhci.c
    hw/usb/host-libusb.c

vhost
M: Michael S. Tsirkin <mst@redhat.com>
    contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
    contrib/vhost-user-gpu/vugpu.h(*2*)
    hw/net/vhost_net.c(*2*)
    hw/virtio/vhost.c

virtio
M: Michael S. Tsirkin <mst@redhat.com>
    hw/virtio/virtio-pci.c
    include/hw/virtio/virtio-gpu.h(*2*)

nvme
M: Keith Busch <kbusch@kernel.org>
M: Klaus Jensen <its@irrelevant.dk>
    hw/nvme/ns.c

virtio-gpu
M: Gerd Hoffmann <kraxel@redhat.com>
    include/hw/virtio/virtio-gpu.h(*2*)

vhost-user-gpu
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
R: Gerd Hoffmann <kraxel@redhat.com>
    contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
    contrib/vhost-user-gpu/vugpu.h(*2*)

Subsystems
----------
Overall Audio backends
M: Gerd Hoffmann <kraxel@redhat.com>
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    audio/audio.c

Open Sound System (OSS) Audio backend
M: Gerd Hoffmann <kraxel@redhat.com>
    audio/ossaudio.c

Compute Express Link
M: Jonathan Cameron <jonathan.cameron@huawei.com>
R: Fan Ni <fan.ni@samsung.com>
    include/hw/cxl/cxl_device.h

Device Tree
M: Alistair Francis <alistair.francis@wdc.com>
R: David Gibson <david@gibson.dropbear.id.au>
    softmmu/device_tree.c

Dump
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    dump/dump.c

Main loop
M: Paolo Bonzini <pbonzini@redhat.com>
    softmmu/vl.c

qtest
M: Thomas Huth <thuth@redhat.com>
M: Laurent Vivier <lvivier@redhat.com>
R: Paolo Bonzini <pbonzini@redhat.com>
    tests/qtest/m48t59-test.c

Seccomp
M: Daniel P. Berrange <berrange@redhat.com>
    softmmu/qemu-seccomp.c

Cryptography
M: Daniel P. Berrange <berrange@redhat.com>
    crypto/tls-cipher-suites.c

Throttling infrastructure
M: Alberto Garcia <berto@igalia.com>
    tests/unit/test-throttle.c

VT-d Emulation
M: Michael S. Tsirkin <mst@redhat.com>
M: Peter Xu <peterx@redhat.com>
R: Jason Wang <jasowang@redhat.com>
    hw/i386/intel_iommu.c(*3*)

Usermode Emulation
------------------
Linux user
M: Laurent Vivier <laurent@vivier.eu>
    linux-user/flatload.c
    linux-user/mmap.c
    linux-user/syscall.c

Block drivers
-------------
Network Block Device (NBD)
M: Eric Blake <eblake@redhat.com>
M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
    qemu-nbd.c


