Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1F7AD735
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkk3r-0006aW-BS; Mon, 25 Sep 2023 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkk3j-0006aJ-IN
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkk3g-0005MM-KS
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695642443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaa1AiBwUJNk42ND/1EZg3N0ICEb0iYAxy6Kud8MDh0=;
 b=BcJM7s7Xl/I/F1cfR61keSmHrZ4hniP0d/4IOrCwaodBud3HPVyDkoxCfOft77J58RxXkl
 DCNkzHIUltT4KvcTa1ajIbFGjNCK0ERAnCFpL7V/srwjGYG8tjiXcqOoDfBJvs+5JalZkn
 4LMceZC33xsc0iFz2vDEPyFF36G0NCI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-4VBJUciUP6G1HVMbGdZZsg-1; Mon, 25 Sep 2023 07:47:22 -0400
X-MC-Unique: 4VBJUciUP6G1HVMbGdZZsg-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-452aa2f2f43so2209126137.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695642441; x=1696247241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zaa1AiBwUJNk42ND/1EZg3N0ICEb0iYAxy6Kud8MDh0=;
 b=ZMSBfyseYkviI0ATPXMRcAfTi8YraR6XQlxGY3ovSXKjKU+Nyb74VlLGjXjBDotQmh
 xrZ+RqeQANIzWh/qeC2IxLjhIw5v2ihzdwVkKjszb9OioCK4AcBjxvomtbMJjQm5jR+5
 r2P67cuZRLXV3kJ6y7EYm+6Johxvm56tcKtBsI3wMDQEDSszxj1Aly0OrQFwG9Mdhzic
 o20eGc9fylvOOhV9Nm3QUmX2kWwieC+FzOyTSWLNYPk6b9/GbWPnU0RY3RK5jbdcft1F
 420aDcIaYlDJkd8cJyCpy3wK8d/8d8U2q/+IW4SvyPQ+t0/EwNg6AwCn6tRz6NFYOr92
 SGTg==
X-Gm-Message-State: AOJu0YzRBANRUjYEffSNX6nQAIstMZE8vzhtxutWzAxT/mktcDwBNG0b
 RzsrLsIB+BMUlPxEvsVxSTtTVdYC+RbkkRm1gAOqnSll1q2G0+X2PPPbSBE+oA5suXAZYW4jvRA
 QJDEJjwT6BiPGeATVb3aERLBRg2dS0eE=
X-Received: by 2002:a67:fc48:0:b0:44e:b77e:f976 with SMTP id
 p8-20020a67fc48000000b0044eb77ef976mr2323953vsq.20.1695642441536; 
 Mon, 25 Sep 2023 04:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH73AevOt10GU0dp8Kyz8QNKM2/t34gjPkTr7Go3FuvifP6TTwsfNLfdwdTE7XuuZwjT3qlgCHmjg7KA9Vhxd0=
X-Received: by 2002:a67:fc48:0:b0:44e:b77e:f976 with SMTP id
 p8-20020a67fc48000000b0044eb77ef976mr2323906vsq.20.1695642441148; Mon, 25 Sep
 2023 04:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Sep 2023 13:47:09 +0200
Message-ID: <CABgObfbF=7pkCDLwre0BfrYD9=k_6SA2fonwkCcDzorNx6F46w@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Andrew Jeffery <andrew@aj.id.au>, 
 Ani Sinha <anisinha@redhat.com>, Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Fan Ni <fan.ni@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005f002606062d85db"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

--0000000000005f002606062d85db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 22 set 2023, 11:37 Markus Armbruster <armbru@redhat.com> ha scritto:

> If you are in To:, we need your help to enable -Wshadow=3Dlocal.
>

Ok, I am looking at mine except for hw/i386.

Paolo

Local variables shadowing other local variables or parameters make the
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
>
> In my local build with -Wshadow=3Dlocal, warnings remain in just 56 files=
.
>
> Sorted by subsystems, files covered by multiple subsystems marked
> "(*NUMBER*)", files not covered in MAINTAINERS marked (*guess*):
>
> Guest CPU cores (TCG)
> ---------------------
> ARM TCG CPUs
> M: Peter Maydell <peter.maydell@linaro.org>
>     hw/arm/smmuv3-internal.h(*2*)
>     hw/arm/smmuv3.c(*2*)
>
> ARM SMMU
> M: Eric Auger <eric.auger@redhat.com>
>     hw/arm/smmuv3-internal.h(*2*)
>     hw/arm/smmuv3.c(*2*)
>
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
>     hw/i386/acpi-microvm.c(*2*)
>     hw/i386/intel_iommu.c(*3*)
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
>
> Versatile PB
> M: Peter Maydell <peter.maydell@linaro.org>
>     hw/misc/arm_sysctl.c
>
> ASPEED BMCs
> M: C=C3=A9dric Le Goater <clg@kaod.org>
> M: Peter Maydell <peter.maydell@linaro.org>
> R: Andrew Jeffery <andrew@aj.id.au>
> R: Joel Stanley <joel@jms.id.au>
>     hw/i2c/aspeed_i2c.c
>     hw/misc/aspeed_i3c.c
>
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
>     hw/i386/acpi-microvm.c(*2*)
>     hw/i386/intel_iommu.c(*3*)
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
>
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
>
> Seccomp
> M: Daniel P. Berrange <berrange@redhat.com>
>     softmmu/qemu-seccomp.c
>
> Cryptography
> M: Daniel P. Berrange <berrange@redhat.com>
>     crypto/tls-cipher-suites.c
>
> Throttling infrastructure
> M: Alberto Garcia <berto@igalia.com>
>     tests/unit/test-throttle.c
>
> VT-d Emulation
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Peter Xu <peterx@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
>     hw/i386/intel_iommu.c(*3*)
>
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
>
>

--0000000000005f002606062d85db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 22 set 2023, 11:37 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">If you are in To:, we need your help to e=
nable -Wshadow=3Dlocal.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Ok, I am looking at mine except for hw/i386.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
Local variables shadowing other local variables or parameters make the<br>
code needlessly hard to understand.=C2=A0 Bugs love to hide in such code.<b=
r>
Evidence: &quot;[PATCH v3 1/7] migration/rdma: Fix save_page method to fail=
<br>
on polling error&quot;.<br>
<br>
Enabling -Wshadow would prevent bugs like this one.=C2=A0 But we have to<br=
>
clean up all the offenders first.<br>
<br>
I collected the patches posted so far:<br>
<br>
=C2=A0 =C2=A0 [PATCH v3 0/7] Steps towards enabling -Wshadow=3Dlocal<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20230921121312.1301864-1-ar=
mbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">20230921121312.130186=
4-1-armbru@redhat.com</a>&gt;<br>
<br>
=C2=A0 =C2=A0 [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow<b=
r>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20230904161235.84651-1-phil=
md@linaro.org" target=3D"_blank" rel=3D"noreferrer">20230904161235.84651-1-=
philmd@linaro.org</a>&gt;<br>
<br>
=C2=A0 =C2=A0 [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 mor=
e]<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20230904162824.85385-1-phil=
md@linaro.org" target=3D"_blank" rel=3D"noreferrer">20230904162824.85385-1-=
philmd@linaro.org</a>&gt;<br>
<br>
=C2=A0 =C2=A0 [PATCH 0/8] ppc: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20230918145850.241074-1-clg=
@kaod.org" target=3D"_blank" rel=3D"noreferrer">20230918145850.241074-1-clg=
@kaod.org</a>&gt;<br>
<br>
Thanks, Philippe &amp; Cedric!<br>
<br>
In my local build with -Wshadow=3Dlocal, warnings remain in just 56 files.<=
br>
<br>
Sorted by subsystems, files covered by multiple subsystems marked<br>
&quot;(*NUMBER*)&quot;, files not covered in MAINTAINERS marked (*guess*):<=
br>
<br>
Guest CPU cores (TCG)<br>
---------------------<br>
ARM TCG CPUs<br>
M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"=
_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0 =C2=A0 hw/arm/smmuv3-internal.h(*2*)<br>
=C2=A0 =C2=A0 hw/arm/smmuv3.c(*2*)<br>
<br>
ARM SMMU<br>
M: Eric Auger &lt;<a href=3D"mailto:eric.auger@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">eric.auger@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/arm/smmuv3-internal.h(*2*)<br>
=C2=A0 =C2=A0 hw/arm/smmuv3.c(*2*)<br>
<br>
Hexagon TCG CPUs<br>
M: Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com" target=3D"_blank" re=
l=3D"noreferrer">bcain@quicinc.com</a>&gt;<br>
=C2=A0 =C2=A0 target/hexagon/gen_helper_funcs.py<br>
=C2=A0 =C2=A0 target/hexagon/mmvec/macros.h<br>
=C2=A0 =C2=A0 target/hexagon/op_helper.c<br>
=C2=A0 =C2=A0 target/hexagon/translate.c<br>
<br>
M68K TCG CPUs<br>
M: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank=
" rel=3D"noreferrer">laurent@vivier.eu</a>&gt;<br>
=C2=A0 =C2=A0 disas/m68k.c<br>
<br>
PowerPC TCG CPUs<br>
M: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">npiggin@gmail.com</a>&gt;<br>
M: Daniel Henrique Barboza &lt;<a href=3D"mailto:danielhb413@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">danielhb413@gmail.com</a>&gt;<br>
R: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_bla=
nk" rel=3D"noreferrer">clg@kaod.org</a>&gt;<br>
=C2=A0 =C2=A0 target/ppc/int_helper.c<br>
<br>
RISC-V TCG CPUs<br>
=C2=A0 =C2=A0 hw/riscv/opentitan.c(*2*)<br>
=C2=A0 =C2=A0 target/riscv/cpu.c<br>
=C2=A0 =C2=A0 target/riscv/vector_helper.c<br>
<br>
X86 TCG CPUs<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
M: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</a>&gt;<br>
M: Eduardo Habkost &lt;<a href=3D"mailto:eduardo@habkost.net" target=3D"_bl=
ank" rel=3D"noreferrer">eduardo@habkost.net</a>&gt;<br>
=C2=A0 =C2=A0 hw/i386/acpi-build.c(*3*)<br>
=C2=A0 =C2=A0 hw/i386/acpi-microvm.c(*2*)<br>
=C2=A0 =C2=A0 hw/i386/intel_iommu.c(*3*)<br>
=C2=A0 =C2=A0 hw/i386/pc.c(*2*)<br>
=C2=A0 =C2=A0 hw/i386/x86.c(*2*)<br>
=C2=A0 =C2=A0 target/i386/cpu.c(*guess*)<br>
=C2=A0 =C2=A0 target/i386/tcg/seg_helper.c<br>
=C2=A0 =C2=A0 target/i386/tcg/sysemu/svm_helper.c<br>
=C2=A0 =C2=A0 target/i386/tcg/translate.c<br>
<br>
Guest CPU Cores (KVM)<br>
---------------------<br>
X86 KVM CPUs<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
M: Marcelo Tosatti &lt;<a href=3D"mailto:mtosatti@redhat.com" target=3D"_bl=
ank" rel=3D"noreferrer">mtosatti@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 target/i386/kvm/kvm.c<br>
<br>
ARM Machines<br>
------------<br>
ARM cores<br>
M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"=
_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0 =C2=A0 hw/intc/arm_gicv3_its.c<br>
<br>
Versatile PB<br>
M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"=
_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0 =C2=A0 hw/misc/arm_sysctl.c<br>
<br>
ASPEED BMCs<br>
M: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_bla=
nk" rel=3D"noreferrer">clg@kaod.org</a>&gt;<br>
M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"=
_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
R: Andrew Jeffery &lt;<a href=3D"mailto:andrew@aj.id.au" target=3D"_blank" =
rel=3D"noreferrer">andrew@aj.id.au</a>&gt;<br>
R: Joel Stanley &lt;<a href=3D"mailto:joel@jms.id.au" target=3D"_blank" rel=
=3D"noreferrer">joel@jms.id.au</a>&gt;<br>
=C2=A0 =C2=A0 hw/i2c/aspeed_i2c.c<br>
=C2=A0 =C2=A0 hw/misc/aspeed_i3c.c<br>
<br>
LoongArch Machines<br>
------------------<br>
Virt<br>
M: Xiaojuan Yang &lt;<a href=3D"mailto:yangxiaojuan@loongson.cn" target=3D"=
_blank" rel=3D"noreferrer">yangxiaojuan@loongson.cn</a>&gt;<br>
M: Song Gao &lt;<a href=3D"mailto:gaosong@loongson.cn" target=3D"_blank" re=
l=3D"noreferrer">gaosong@loongson.cn</a>&gt;<br>
=C2=A0 =C2=A0 hw/loongarch/virt.c<br>
<br>
RISC-V Machines<br>
---------------<br>
OpenTitan<br>
M: Alistair Francis &lt;<a href=3D"mailto:Alistair.Francis@wdc.com" target=
=3D"_blank" rel=3D"noreferrer">Alistair.Francis@wdc.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/riscv/opentitan.c(*2*)<br>
<br>
X86 Machines<br>
------------<br>
PC<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
M: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">marcel.apfelbaum@gmail.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/i386/acpi-build.c(*3*)<br>
=C2=A0 =C2=A0 hw/i386/acpi-microvm.c(*2*)<br>
=C2=A0 =C2=A0 hw/i386/intel_iommu.c(*3*)<br>
=C2=A0 =C2=A0 hw/i386/pc.c(*2*)<br>
=C2=A0 =C2=A0 hw/i386/x86.c(*2*)<br>
<br>
PC Chipset<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/i2c/pm_smbus.c<br>
<br>
Devices<br>
-------<br>
ACPI/SMBIOS<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
M: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">imammedo@redhat.com</a>&gt;<br>
R: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/acpi/cpu_hotplug.c<br>
=C2=A0 =C2=A0 hw/i386/acpi-build.c(*3*)<br>
=C2=A0 =C2=A0 hw/smbios/smbios.c<br>
<br>
Network devices<br>
M: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">jasowang@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/net/vhost_net.c(*2*)<br>
<br>
SCSI<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
R: Fam Zheng &lt;<a href=3D"mailto:fam@euphon.net" target=3D"_blank" rel=3D=
"noreferrer">fam@euphon.net</a>&gt;<br>
=C2=A0 =C2=A0 hw/scsi/mptsas.c<br>
<br>
USB<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/usb/desc.c<br>
=C2=A0 =C2=A0 hw/usb/dev-hub.c<br>
=C2=A0 =C2=A0 hw/usb/dev-storage.c<br>
=C2=A0 =C2=A0 hw/usb/hcd-xhci.c<br>
=C2=A0 =C2=A0 hw/usb/host-libusb.c<br>
<br>
vhost<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vugpu.h(*2*)<br>
=C2=A0 =C2=A0 hw/net/vhost_net.c(*2*)<br>
=C2=A0 =C2=A0 hw/virtio/vhost.c<br>
<br>
virtio<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/virtio/virtio-pci.c<br>
=C2=A0 =C2=A0 include/hw/virtio/virtio-gpu.h(*2*)<br>
<br>
nvme<br>
M: Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org" target=3D"_blank" r=
el=3D"noreferrer">kbusch@kernel.org</a>&gt;<br>
M: Klaus Jensen &lt;<a href=3D"mailto:its@irrelevant.dk" target=3D"_blank" =
rel=3D"noreferrer">its@irrelevant.dk</a>&gt;<br>
=C2=A0 =C2=A0 hw/nvme/ns.c<br>
<br>
virtio-gpu<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 include/hw/virtio/virtio-gpu.h(*2*)<br>
<br>
vhost-user-gpu<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<=
br>
R: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vugpu.h(*2*)<br>
<br>
Subsystems<br>
----------<br>
Overall Audio backends<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<=
br>
=C2=A0 =C2=A0 audio/audio.c<br>
<br>
Open Sound System (OSS) Audio backend<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 audio/ossaudio.c<br>
<br>
Compute Express Link<br>
M: Jonathan Cameron &lt;<a href=3D"mailto:jonathan.cameron@huawei.com" targ=
et=3D"_blank" rel=3D"noreferrer">jonathan.cameron@huawei.com</a>&gt;<br>
R: Fan Ni &lt;<a href=3D"mailto:fan.ni@samsung.com" target=3D"_blank" rel=
=3D"noreferrer">fan.ni@samsung.com</a>&gt;<br>
=C2=A0 =C2=A0 include/hw/cxl/cxl_device.h<br>
<br>
Device Tree<br>
M: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" target=
=3D"_blank" rel=3D"noreferrer">alistair.francis@wdc.com</a>&gt;<br>
R: David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au" target=
=3D"_blank" rel=3D"noreferrer">david@gibson.dropbear.id.au</a>&gt;<br>
=C2=A0 =C2=A0 softmmu/device_tree.c<br>
<br>
Dump<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<=
br>
=C2=A0 =C2=A0 dump/dump.c<br>
<br>
Main loop<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 softmmu/vl.c<br>
<br>
qtest<br>
M: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
M: Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">lvivier@redhat.com</a>&gt;<br>
R: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 tests/qtest/m48t59-test.c<br>
<br>
Seccomp<br>
M: Daniel P. Berrange &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 softmmu/qemu-seccomp.c<br>
<br>
Cryptography<br>
M: Daniel P. Berrange &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 crypto/tls-cipher-suites.c<br>
<br>
Throttling infrastructure<br>
M: Alberto Garcia &lt;<a href=3D"mailto:berto@igalia.com" target=3D"_blank"=
 rel=3D"noreferrer">berto@igalia.com</a>&gt;<br>
=C2=A0 =C2=A0 tests/unit/test-throttle.c<br>
<br>
VT-d Emulation<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
M: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">peterx@redhat.com</a>&gt;<br>
R: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">jasowang@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/i386/intel_iommu.c(*3*)<br>
<br>
Usermode Emulation<br>
------------------<br>
Linux user<br>
M: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank=
" rel=3D"noreferrer">laurent@vivier.eu</a>&gt;<br>
=C2=A0 =C2=A0 linux-user/flatload.c<br>
=C2=A0 =C2=A0 linux-user/mmap.c<br>
=C2=A0 =C2=A0 linux-user/syscall.c<br>
<br>
Block drivers<br>
-------------<br>
Network Block Device (NBD)<br>
M: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">eblake@redhat.com</a>&gt;<br>
M: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov@yandex-tea=
m.ru" target=3D"_blank" rel=3D"noreferrer">vsementsov@yandex-team.ru</a>&gt=
;<br>
=C2=A0 =C2=A0 qemu-nbd.c<br>
<br>
</blockquote></div></div></div>

--0000000000005f002606062d85db--


