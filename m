Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0F7ABE11
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 08:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjvqq-0006la-1t; Sat, 23 Sep 2023 02:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjvqn-0006lR-Tk
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjvql-0004M1-QV
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695449442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTf+8QUgJIgNjdjmoyFiNadUaUzLp89sXj7/a6shB88=;
 b=LEOreJqYeNdwI2LifgoZpjgd2KbesiikGUmoUtR8bskbpsGEm5rEVKoG/ralxrmO/0lNDP
 UrUVnndFUl4c5IHLFGI9hSaY2aT/qhTnXZAppFP5y4e2NLcvzuamoKZjY5ArZsQwhqN3VG
 yPSSLLWQ59DLqZPZFWz6JZsuDxE6yMs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-IXTsEiRgPE-Kah5HfQ6Bmw-1; Sat, 23 Sep 2023 02:10:38 -0400
X-MC-Unique: IXTsEiRgPE-Kah5HfQ6Bmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F06685A5A8;
 Sat, 23 Sep 2023 06:10:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDBAC2156701;
 Sat, 23 Sep 2023 06:10:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB1B921E6900; Sat, 23 Sep 2023 08:10:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Alberto Garcia <berto@igalia.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Andrew Jeffery <andrew@aj.id.au>,
 Ani Sinha <anisinha@redhat.com>,  Brian Cain <bcain@quicinc.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Daniel P. Berrange <berrange@redhat.com>,  David
 Gibson <david@gibson.dropbear.id.au>,  Eduardo Habkost
 <eduardo@habkost.net>,  Eric Auger <eric.auger@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Fan Ni
 <fan.ni@samsung.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Joel Stanley
 <joel@jms.id.au>,  Jonathan Cameron <jonathan.cameron@huawei.com>,  Keith
 Busch <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,  Laurent
 Vivier <laurent@vivier.eu>,  Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Michael S. Tsirkin <mst@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Peter Xu <peterx@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: Help wanted for enabling -Wshadow=local
References: <87r0mqlf9x.fsf@pond.sub.org>
Date: Sat, 23 Sep 2023 08:10:32 +0200
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 22 Sep 2023 11:37:46 +0200")
Message-ID: <87jzsho1wn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> If you are in To:, we need your help to enable -Wshadow=3Dlocal.
>
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
>
> Enabling -Wshadow would prevent bugs like this one.  But we have to
> clean up all the offenders first.
>
> I collected the patches posted so far:
>
>     [PATCH v3 0/7] Steps towards enabling -Wshadow=3Dlocal
>     Message-ID: <20230921121312.1301864-1-armbru@redhat.com>
>
>     [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow
>     Message-ID: <20230904161235.84651-1-philmd@linaro.org>
>
>     [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 more]
>     Message-ID: <20230904162824.85385-1-philmd@linaro.org>
>
>     [PATCH 0/8] ppc: Clean up local variable shadowing
>     Message-ID: <20230918145850.241074-1-clg@kaod.org>
>
> Thanks, Philippe & Cedric!

Collected since:

      [PATCH] test-throttle: don't shadow 'index' variable in do_test_accou=
nting()
      Message-Id: <20230922105742.81317-1-berto@igalia.com>

      [PATCH] hw/acpi: changes towards enabling -Wshadow=3Dlocal
      Message-Id: <20230922124203.127110-1-anisinha@redhat.com>

      [PATCH 0/4] arm: fix some -Wshadow warnings
      Message-Id: <20230922152944.3583438-1-peter.maydell@linaro.org>

      [PATCH 0/4] aspeed: Clean up local variable shadowing
      Message-ID: <20230922155924.1172019-1-clg@kaod.org>

      [PATCH] intel_iommu: Fix shadow local variables on "size"
      Message-ID: <20230922160410.138786-1-peterx@redhat.com>

      [PATCH 0/2] remove some variable shadowing
      Message-ID: <20230922160644.438631-1-berrange@redhat.com>

      [PATCH] tests/qtest/m48t59-test: Silence compiler warning with -Wshad=
ow
      Message-ID: <20230922163742.149444-1-thuth@redhat.com>

Thanks Berto, Ani, Peter, C=C3=A9dric, Peter, Daniel, and Thomas!

> In my local build with -Wshadow=3Dlocal, warnings remain in just 56 files.

Down to 42.

> Sorted by subsystems, files covered by multiple subsystems marked
> "(*NUMBER*)", files not covered in MAINTAINERS marked (*guess*):
>
> Guest CPU cores (TCG)
> ---------------------
> ARM TCG CPUs
> M: Peter Maydell <peter.maydell@linaro.org>
>     hw/arm/smmuv3-internal.h(*2*)
>     hw/arm/smmuv3.c(*2*)

Subsystem appears clean now.

> ARM SMMU
> M: Eric Auger <eric.auger@redhat.com>
>     hw/arm/smmuv3-internal.h(*2*)
>     hw/arm/smmuv3.c(*2*)

Subsystem appears clean now.

> Hexagon TCG CPUs
> M: Brian Cain <bcain@quicinc.com>
>     target/hexagon/gen_helper_funcs.py
>     target/hexagon/mmvec/macros.h
>     target/hexagon/op_helper.c
>     target/hexagon/translate.c
>
> M68K TCG CPUs
> M: Laurent Vivier <laurent@vivier.eu>
>     disas/m68k.c
>
> PowerPC TCG CPUs
> M: Nicholas Piggin <npiggin@gmail.com>
> M: Daniel Henrique Barboza <danielhb413@gmail.com>
> R: C=C3=A9dric Le Goater <clg@kaod.org>
>     target/ppc/int_helper.c
>
> RISC-V TCG CPUs
>     hw/riscv/opentitan.c(*2*)
>     target/riscv/cpu.c
>     target/riscv/vector_helper.c
>
> X86 TCG CPUs
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Richard Henderson <richard.henderson@linaro.org>
> M: Eduardo Habkost <eduardo@habkost.net>
>     hw/i386/acpi-build.c(*3*)

File appears clean now.

>     hw/i386/acpi-microvm.c(*2*)
>     hw/i386/intel_iommu.c(*3*)

File appears clean now.

>     hw/i386/pc.c(*2*)
>     hw/i386/x86.c(*2*)
>     target/i386/cpu.c(*guess*)
>     target/i386/tcg/seg_helper.c
>     target/i386/tcg/sysemu/svm_helper.c
>     target/i386/tcg/translate.c
>
> Guest CPU Cores (KVM)
> ---------------------
> X86 KVM CPUs
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Marcelo Tosatti <mtosatti@redhat.com>
>     target/i386/kvm/kvm.c
>
> ARM Machines
> ------------
> ARM cores
> M: Peter Maydell <peter.maydell@linaro.org>
>     hw/intc/arm_gicv3_its.c

Subsystem appears clean now.

> Versatile PB
> M: Peter Maydell <peter.maydell@linaro.org>
>     hw/misc/arm_sysctl.c

Subsystem appears clean now.

> ASPEED BMCs
> M: C=C3=A9dric Le Goater <clg@kaod.org>
> M: Peter Maydell <peter.maydell@linaro.org>
> R: Andrew Jeffery <andrew@aj.id.au>
> R: Joel Stanley <joel@jms.id.au>
>     hw/i2c/aspeed_i2c.c
>     hw/misc/aspeed_i3c.c

Subsystem appears clean now.

> LoongArch Machines
> ------------------
> Virt
> M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> M: Song Gao <gaosong@loongson.cn>
>     hw/loongarch/virt.c
>
> RISC-V Machines
> ---------------
> OpenTitan
> M: Alistair Francis <Alistair.Francis@wdc.com>
>     hw/riscv/opentitan.c(*2*)
>
> X86 Machines
> ------------
> PC
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>     hw/i386/acpi-build.c(*3*)

File appears clean now.

>     hw/i386/acpi-microvm.c(*2*)
>     hw/i386/intel_iommu.c(*3*)

File appears clean now.

>     hw/i386/pc.c(*2*)
>     hw/i386/x86.c(*2*)
>
> PC Chipset
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Paolo Bonzini <pbonzini@redhat.com>
>     hw/i2c/pm_smbus.c
>
> Devices
> -------
> ACPI/SMBIOS
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Igor Mammedov <imammedo@redhat.com>
> R: Ani Sinha <anisinha@redhat.com>
>     hw/acpi/cpu_hotplug.c
>     hw/i386/acpi-build.c(*3*)
>     hw/smbios/smbios.c

Subsystem appears clean now.

> Network devices
> M: Jason Wang <jasowang@redhat.com>
>     hw/net/vhost_net.c(*2*)
>
> SCSI
> M: Paolo Bonzini <pbonzini@redhat.com>
> R: Fam Zheng <fam@euphon.net>
>     hw/scsi/mptsas.c
>
> USB
> M: Gerd Hoffmann <kraxel@redhat.com>
>     hw/usb/desc.c
>     hw/usb/dev-hub.c
>     hw/usb/dev-storage.c
>     hw/usb/hcd-xhci.c
>     hw/usb/host-libusb.c
>
> vhost
> M: Michael S. Tsirkin <mst@redhat.com>
>     contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>     contrib/vhost-user-gpu/vugpu.h(*2*)
>     hw/net/vhost_net.c(*2*)
>     hw/virtio/vhost.c
>
> virtio
> M: Michael S. Tsirkin <mst@redhat.com>
>     hw/virtio/virtio-pci.c
>     include/hw/virtio/virtio-gpu.h(*2*)
>
> nvme
> M: Keith Busch <kbusch@kernel.org>
> M: Klaus Jensen <its@irrelevant.dk>
>     hw/nvme/ns.c
>
> virtio-gpu
> M: Gerd Hoffmann <kraxel@redhat.com>
>     include/hw/virtio/virtio-gpu.h(*2*)
>
> vhost-user-gpu
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> R: Gerd Hoffmann <kraxel@redhat.com>
>     contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>     contrib/vhost-user-gpu/vugpu.h(*2*)
>
> Subsystems
> ----------
> Overall Audio backends
> M: Gerd Hoffmann <kraxel@redhat.com>
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     audio/audio.c
>
> Open Sound System (OSS) Audio backend
> M: Gerd Hoffmann <kraxel@redhat.com>
>     audio/ossaudio.c
>
> Compute Express Link
> M: Jonathan Cameron <jonathan.cameron@huawei.com>
> R: Fan Ni <fan.ni@samsung.com>
>     include/hw/cxl/cxl_device.h
>
> Device Tree
> M: Alistair Francis <alistair.francis@wdc.com>
> R: David Gibson <david@gibson.dropbear.id.au>
>     softmmu/device_tree.c
>
> Dump
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     dump/dump.c
>
> Main loop
> M: Paolo Bonzini <pbonzini@redhat.com>
>     softmmu/vl.c
>
> qtest
> M: Thomas Huth <thuth@redhat.com>
> M: Laurent Vivier <lvivier@redhat.com>
> R: Paolo Bonzini <pbonzini@redhat.com>
>     tests/qtest/m48t59-test.c

Subsystem appears clean now.

> Seccomp
> M: Daniel P. Berrange <berrange@redhat.com>
>     softmmu/qemu-seccomp.c
>
> Cryptography
> M: Daniel P. Berrange <berrange@redhat.com>
>     crypto/tls-cipher-suites.c

Subsystem appears clean now.

> Throttling infrastructure
> M: Alberto Garcia <berto@igalia.com>
>     tests/unit/test-throttle.c

Subsystem appears clean now.

> VT-d Emulation
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Peter Xu <peterx@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
>     hw/i386/intel_iommu.c(*3*)

Subsystem appears clean now.

> Usermode Emulation
> ------------------
> Linux user
> M: Laurent Vivier <laurent@vivier.eu>
>     linux-user/flatload.c
>     linux-user/mmap.c
>     linux-user/syscall.c
>
> Block drivers
> -------------
> Network Block Device (NBD)
> M: Eric Blake <eblake@redhat.com>
> M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>     qemu-nbd.c


