Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401EBBC14F4
	for <lists+qemu-devel@lfdr.de>; Tue, 07 Oct 2025 14:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66T0-0004Pk-DM; Tue, 07 Oct 2025 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v66Sr-0004Of-MG
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v66Sf-0002dK-CH
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759838783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sqg0lIYXAGYR+a02nHb3cUWYTCxW8vubx8DOTT1agjA=;
 b=S79ps14xshQSpTvPguh79AMeT8GgBPGLyG0OwvDYJTP+YMTBxmYk8iOgH4a8at05rbn8cO
 hr1P8c2yAmTeU6+uJRw07UyeyW8RShV5iePjAnb25hyGjKuFuvw9Uv5ITDM5CaP/valucj
 b1t6S9e6ReGiQNI1mqZLjsS3xssPeiM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306--XizuUgkNv6kygBLOiaHlA-1; Tue, 07 Oct 2025 08:06:21 -0400
X-MC-Unique: -XizuUgkNv6kygBLOiaHlA-1
X-Mimecast-MFC-AGG-ID: -XizuUgkNv6kygBLOiaHlA_1759838780
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso3421128f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 05:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838780; x=1760443580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sqg0lIYXAGYR+a02nHb3cUWYTCxW8vubx8DOTT1agjA=;
 b=BY3gW2MYLPmEKWiMYGVP4kSxfLIpRSnq4tUP4aWWTityHGg9XXrlPKVOo2g79RbRw9
 kaeGXXFSPgLdCikIzdWk+Il+8wb3ncd9+IteVpA8LQnt2UIIgQtn0Z/p4b7nz+RQSF59
 CM0+0bf6IJY76WSoeGTbIsaNFcYX0Fnqk8dGSWtXgXe3o2baJ7LgCKv6PyvxghMBmuCc
 BLbz3oD97q1uFzjQSG3PFuRh1mHSV5fTqx9JbKIQTpjshRwBRffAMbMih6bfDXWobtJa
 REq7UPealSN5O1r9WMEQ9XU7XlMF4kXT3gUUzMKLupvAwJ8+hbNji+PGwLLnZJBVtBiS
 kgxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxqs4rx0Ir2Xv54rZ7sGooBkvjF6etsOgohLn/JnWry8VC/qsExSlOuyChHH3lD/zbH/RqIYkXBYoe@nongnu.org
X-Gm-Message-State: AOJu0Yx11UJ9k05pEU+JiXa86rIT9Cel1CAkzaKKzhNzMdYbhT4uNUvX
 GMU/+uqoyQ8n98Swxe2gY/O3j1QLsW4CvmSHfEBeCWUUSwuSqJ/vTAbzsyevHRSiDh5xfuYlBFh
 b/mrMVaQkspjqxPKPlyEQhq1Fy12dzkqFHNyoenjweqANzEbyH+cjgp9y
X-Gm-Gg: ASbGncshZJHkrU0ZiEF5MHdUpccJBlqD/tq6kMXWslhNBnRoaTChAl7hp1/hzdb2x05
 A+f8GGLSoDJqB5y56XOgM+k1HwkhCYkjUNwmj27CvB6qj0u/GmAeqfyaZhILS+f/lTqYpo9B23F
 baSr0KvAL0Eje+eque0d5JgyjVaa01GU1PH3DUHRv4oJ9HhHXwoxM291c0u0gTtBGmRh/dhEw28
 kCrQIKB7z7POtF0JS3DRJaz880mMqC89/BzEY7GDDJ9BXF4GvN79CuOanwQI7QwegwXHN7JXTbG
 Hm80SHP6h0tzIVvlS8KSb79wqBkZ1gts+tRv
X-Received: by 2002:a5d:5d85:0:b0:3e3:24c3:6d71 with SMTP id
 ffacd0b85a97d-42567158018mr8652985f8f.1.1759838779265; 
 Tue, 07 Oct 2025 05:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAquwys3RLZHp/SS1eQVYIFQ16NrQfetZSWjwcEIEp9ktitvcImR8zGT/1/X51QjrEEWikKw==
X-Received: by 2002:a5d:5d85:0:b0:3e3:24c3:6d71 with SMTP id
 ffacd0b85a97d-42567158018mr8652911f8f.1.1759838778354; 
 Tue, 07 Oct 2025 05:06:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4ab0sm25249410f8f.52.2025.10.07.05.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:06:17 -0700 (PDT)
Date: Tue, 7 Oct 2025 14:06:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 14/24] arm/acpi: Introduce dedicated CPU OSPM
 interface for ARM-like platforms
Message-ID: <20251007140613.5916df08@fedora>
In-Reply-To: <7da6a9c470684754810414f0abd23a62@huawei.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-15-salil.mehta@opnsrc.net>
 <20251003165816.53821040@fedora>
 <7da6a9c470684754810414f0abd23a62@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 7 Oct 2025 11:15:47 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
>=20
> Thanks for the reviews and sorry for the late reply. Please find my repli=
es inline.
>=20
>=20
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Friday, October 3, 2025 3:58 PM
> >=20
> > On Wed,  1 Oct 2025 01:01:17 +0000
> > salil.mehta@opnsrc.net wrote:
> >  =20
> > > From: Salil Mehta <salil.mehta@huawei.com>
> > >
> > > The existing ACPI CPU hotplug interface is built for x86 platforms
> > > where CPUs can be inserted or removed and resources are allocated
> > > dynamically. On ARM, CPUs are never hotpluggable: resources are
> > > allocated at boot and QOM vCPU objects always exist. Instead, CPUs are
> > > administratively managed by toggling ACPI _STA to enable or disable
> > > them, which gives a hotplug-like effect but does not match the x86 mo=
del.
> > >
> > > Reusing the x86 hotplug AML code would complicate maintenance since
> > > much of its logic relies on toggling the _STA.Present bit to notify
> > > OSPM about CPU insertion or removal. Such usage is not architecturally
> > > valid on ARM, where CPUs cannot appear or disappear at runtime. Mixing
> > > both models in one interface would increase complexity and make the
> > > AML harder to extend. A separate path is therefore required. The new
> > > design is heavily inspired by the CPU hotplug interface but avoids it=
s =20
> > unsuitable semantics.
> >=20
> > Let me ask how much existing CPUHP AML code will become, if you reuse it
> > and add handling of 'enabled' bit there?
> >=20
> > Would it be the same 700LOC as in this patch, which is basically duplic=
ation of
> > existing CPUHP ACPI interface? =20
>=20
>=20
> It is by design as we have adopted non-hotplug approach now and closely a=
ligned
> ourselves with what PSCI standard perceives to be the definition of CPU h=
otplug on ARM
> platforms - at least, as of today! And it is *NOT* what 'CPU hotplug' mea=
ns on x86 platform.=20

There is no argument that they are different but,
Could you point to PSCI specific parts in this patch?

> In crux, this means,
> 1. Dropping any hotplug/unplug infrastructure and its related paraphernal=
ia from the
>     ARM implementation till the time the meaning of physical CPU hotplug =
is not clear as
>     per the specification. We do not want to model in Qemu something whic=
h does not
>     exist or defined, especially for the CPU hotplug case.

there is 'opts' config struct that lets user to opt in/out from specific AML
being generated. You could use that to disable some hotplug only bits of AM=
L.
Other bits that are more generic/reusable, just refactor/rename them to a m=
ore
generic names.

> 2. This also means *NOT* enabling the  ACPI_CPU_HOTPLUG compilation switc=
h to=20
>      preserve the sanctity of the clean design.

that's semantics, I'd suggest renaming that to ACPI_CPU.

> 3. Yes, there is a code duplicity for now but that=E2=80=99s a case of fu=
rther optimization and
>     cleanup not a design issue. Some of them are:
>     (1)  ACPI device-check and eject-request  handling code can be extrac=
ted and
>     made generic for all devices not just for CPUs.

make it more generic in acpi/cpu.c, instead of copying.
I don't have any objections to refactoring existing code if it makes sense =
and
we can share the code.

>     (2)  Right now, acpi/cpu.c is assuming that resources and templates s=
hould be
>      same for all the CPUs using CPUs AML described in it. There is no ne=
ed for
>      such a restriction. Every platform should be free to choose the way =
it wants to
>      manage the resources and the interpretation of the fields inside it.

be more specific why you'd need different resources/MMIO layout for this se=
ries?

The thing is if we copied every time when we needed something that's a bit =
different,
we would end up with unsupportable/bloated QEMU.

>     (3) Call backs used with GED  makes an assumption of HOTPLUG interfac=
e etc.
>     (4) In fact, the prototype of the GED event handler makes a similar m=
istake of
>      assuming that GED is only meant for devices supporting hotplug when =
this is not
>      the case even as per the ACPI specification.
please be more specific and point to problematic code.

current acpi/cpu.c might be compiled under ACPI_CPU_HOTPLUG knob but it's n=
ot really
limited to hotplug, the reason for being compiled as such is that hotplug w=
as
the sole reason for building CPUs AML at all.

What I see in the patch is simplifying current code somewhat by dropping
some hotplug related bits and a bunch of renaming.
Otherwise it's pretty much duplicating current acpi/cpu.c.

Beside that simplification, I don't see any reason why duplicating such amo=
unt is good idea.
Consider making exiting acpi/cpu.c more generic instead.

> RFC V5 was an attempt to implement this feature using the hotplug infrast=
ructure
> and this RFC V6 is a deviation from previous approach towards non-hotplug=
. We do
> not want a hotchpotch approach because that=E2=80=99s a recipe for future=
 disaster.
>=20
>=20
> Many Thanks!
> Salil.
>=20
>=20
> >  =20
> > >
> > > This patch adds a dedicated CPU OSPM (Operating System Power
> > > Management) interface. It provides a memory-mapped control region with
> > > selector, flags, command, and data fields, and AML methods for
> > > device-check, eject request, and _OST reporting. OSPM is notified
> > > through GED events and can coordinate CPU events directly with QEMU.
> > > Other ARM-like architectures may also use this interface.
> > >
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >  hw/acpi/Kconfig                        |   3 +
> > >  hw/acpi/acpi-cpu-ospm-interface-stub.c |  41 ++
> > >  hw/acpi/cpu_ospm_interface.c           | 747 =20
> > +++++++++++++++++++++++++ =20
> > >  hw/acpi/meson.build                    |   2 +
> > >  hw/acpi/trace-events                   |  17 +
> > >  hw/arm/Kconfig                         |   1 +
> > >  include/hw/acpi/cpu_ospm_interface.h   |  78 +++
> > >  7 files changed, 889 insertions(+)
> > >  create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c
> > >  create mode 100644 hw/acpi/cpu_ospm_interface.c  create mode 100644
> > > include/hw/acpi/cpu_ospm_interface.h
> > >
> > > diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig index
> > > 1d4e9f0845..aa52f0468f 100644
> > > --- a/hw/acpi/Kconfig
> > > +++ b/hw/acpi/Kconfig
> > > @@ -21,6 +21,9 @@ config ACPI_ICH9
> > >  config ACPI_CPU_HOTPLUG
> > >      bool
> > >
> > > +config ACPI_CPU_OSPM_INTERFACE
> > > +    bool
> > > +
> > >  config ACPI_MEMORY_HOTPLUG
> > >      bool
> > >      select MEM_DEVICE
> > > diff --git a/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > b/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > new file mode 100644
> > > index 0000000000..f6f333f641
> > > --- /dev/null
> > > +++ b/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > @@ -0,0 +1,41 @@
> > > +/*
> > > + * ACPI CPU OSPM Interface Handling.
> > > + *
> > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > + *
> > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License as published
> > > +by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/acpi/cpu_ospm_interface.h"
> > > +
> > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, DeviceState =
=20
> > *dev, =20
> > > +                              uint32_t event_st, Error **errp) { }
> > > +
> > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st, =20
> > DeviceState *dev, =20
> > > +                               uint32_t event_st, Error **errp) { }
> > > +
> > > +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev,
> > > +Error **errp) { }
> > > +
> > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object =20
> > *owner, =20
> > > +                                        AcpiCpuOspmState *state,
> > > +                                        hwaddr base_addr) { }
> > > +
> > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st, =20
> > ACPIOSTInfoList =20
> > > +***list) { }
> > > diff --git a/hw/acpi/cpu_ospm_interface.c
> > > b/hw/acpi/cpu_ospm_interface.c new file mode 100644 index
> > > 0000000000..61aab8a793
> > > --- /dev/null
> > > +++ b/hw/acpi/cpu_ospm_interface.c
> > > @@ -0,0 +1,747 @@
> > > +/*
> > > + * ACPI CPU OSPM Interface Handling.
> > > + *
> > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > + *
> > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License as published
> > > +by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "migration/vmstate.h"
> > > +#include "hw/core/cpu.h"
> > > +#include "qapi/error.h"
> > > +#include "trace.h"
> > > +#include "qapi/qapi-events-acpi.h"
> > > +#include "hw/acpi/cpu_ospm_interface.h"
> > > +
> > > +/* CPU identifier and resource device */
> > > +#define CPU_NAME_FMT      "C%.03X" /* CPU name format (e.g., C001) =
=20
> > */ =20
> > > +#define CPU_RES_DEVICE    "CPUR" /* CPU resource device name */
> > > +#define CPU_DEVICE        "CPUS" /* CPUs device name */
> > > +#define CPU_LOCK          "CPLK" /* CPU lock object */
> > > +/* ACPI method(_STA, _EJ0, etc.) handlers */
> > > +#define CPU_STS_METHOD    "CSTA" /* CPU status method =20
> > (_STA.Enabled) */ =20
> > > +#define CPU_SCAN_METHOD   "CSCN" /* CPU scan method for =20
> > enumeration */ =20
> > > +#define CPU_NOTIFY_METHOD "CTFY" /* Notify method for CPU events =20
> > */ =20
> > > +#define CPU_EJECT_METHOD  "CEJ0" /* CPU eject method (_EJ0) */
> > > +#define CPU_OST_METHOD    "COST" /* OSPM status reporting (_OST) */
> > > +/* CPU MMIO region fields (in PRST region) */
> > > +#define CPU_SELECTOR      "CSEL" /* CPU selector index (WO) */
> > > +#define CPU_ENABLED_F     "CPEN" /* Flag: CPU enabled status(_STA) =
=20
> > (RO) */ =20
> > > +#define CPU_DEVCHK_F      "CDCK" /* Flag: Device-check event (RW) */
> > > +#define CPU_EJECTRQ_F     "CEJR" /* Flag: Eject-request event (RW)*/
> > > +#define CPU_EJECT_F       "CEJ0" /* Flag: Ejection trigger (WO) */
> > > +#define CPU_COMMAND       "CCMD" /* Command register (RW) */
> > > +#define CPU_DATA          "CDAT" /* Data register (RW) */
> > > +
> > > + /*
> > > + * CPU OSPM Interface MMIO Layout (Total: 16 bytes)
> > > + *
> > > + *
> > > + +--------+--------+--------+--------+--------+--------+--------+----
> > > + ----+
> > > + * |  0x00  |  0x01  |  0x02  |  0x03  |  0x04  |  0x05  |  0x06  |
> > > + 0x07  |
> > > + * +--------+--------+--------+--------+--------+--------+--------+-=
-------+
> > > + * |       Selector (DWord, write-only)         | Flags  |Command |R=
eserved|
> > > + * |                                            | (RO/RW)|  (WO)  |(=
2B pad)|
> > > + * |        4 bytes (32 bits)                   | 1B     |   1B   | =
2B     |
> > > + *
> > > + +-------------------------------------------------------------------
> > > + ----+
> > > + * |  0x08  |  0x09  |  0x0A  |  0x0B  |  0x0C  |  0x0D  |  0x0E  |
> > > + 0x0F  |
> > > + * +--------+--------+--------+--------+--------+--------+--------+-=
-------+
> > > + * |                        Data (QWord, read/write)                =
       |
> > > + * |               Used by CPU scan and _OST methods (64 bits)      =
       |
> > > + *
> > > + +-------------------------------------------------------------------
> > > + ----+
> > > + *
> > > + * Field Overview:
> > > + *
> > > + * - Selector: 4 bytes @0x00 (DWord, WO)
> > > + *               - Selects target CPU index for the current operatio=
n.
> > > + * - Flags:    1 byte  @0x04 (RO/RW)
> > > + *               - Bit 0: ENABLED  =E2=80=93 CPU is powered on (RO)
> > > + *               - Bit 1: DEVCHK   =E2=80=93 Device-check completed =
(RW)
> > > + *               - Bit 2: EJECTRQ  =E2=80=93 Guest requests CPU ejec=
t (RW)
> > > + *               - Bit 3: EJECT    =E2=80=93 Trigger CPU ejection (W=
O)
> > > + *               - Bits 4=E2=80=937: Reserved (write 0)
> > > + * - Command:  1 byte  @0x05 (WO)
> > > + *               - Specifies control operation (e.g., scan, _OST, ej=
ect).
> > > + * - Reserved: 2 bytes @0x06=E2=80=930x07
> > > + *               - Alignment padding; must be zero on write.
> > > + * - Data:     8 bytes @0x08 (QWord, RW)
> > > + *               - Input/output for command-specific data.
> > > + *               - Used by CPU scan or _OST.
> > > + */
> > > +
> > > +/*
> > > + * Macros defining the CPU MMIO region layout. Change field sizes
> > > +here to
> > > + * alter the overall MMIO region size.
> > > + */
> > > +/* Sub-Field sizes (in bytes) */
> > > +#define ACPI_CPU_MR_SELECTOR_SIZE  4 /* Write-only (DWord access) =20
> > */ =20
> > > +#define ACPI_CPU_MR_FLAGS_SIZE     1 /* Read-write (Byte access) */
> > > +#define ACPI_CPU_MR_RES_FLAGS_SIZE 0 /* Reserved padding */
> > > +#define ACPI_CPU_MR_CMD_SIZE       1 /* Write-only (Byte access) */
> > > +#define ACPI_CPU_MR_RES_CMD_SIZE   2 /* Reserved padding */
> > > +#define ACPI_CPU_MR_CMD_DATA_SIZE  8 /* Read-write (QWord =20
> > access) */ =20
> > > +
> > > +#define ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE \
> > > +    MAX_CONST(ACPI_CPU_MR_CMD_DATA_SIZE, \
> > > +    MAX_CONST(ACPI_CPU_MR_SELECTOR_SIZE, \
> > > +    MAX_CONST(ACPI_CPU_MR_CMD_SIZE, =20
> > ACPI_CPU_MR_FLAGS_SIZE))) =20
> > > +
> > > +/* Validate layout against exported total length */
> > > +_Static_assert(ACPI_CPU_OSPM_IF_REG_LEN =3D=3D
> > > +               (ACPI_CPU_MR_SELECTOR_SIZE +
> > > +                ACPI_CPU_MR_FLAGS_SIZE +
> > > +                ACPI_CPU_MR_RES_FLAGS_SIZE +
> > > +                ACPI_CPU_MR_CMD_SIZE +
> > > +                ACPI_CPU_MR_RES_CMD_SIZE +
> > > +                ACPI_CPU_MR_CMD_DATA_SIZE),
> > > +               "ACPI_CPU_OSPM_IF_REG_LEN mismatch with internal MMIO
> > > +layout");
> > > +
> > > +/* Sub-Field sizes (in bits) */
> > > +#define ACPI_CPU_MR_SELECTOR_SIZE_BITS \
> > > +    (ACPI_CPU_MR_SELECTOR_SIZE * BITS_PER_BYTE)  /* Write-only =20
> > (DWord =20
> > > +Acc) */ #define ACPI_CPU_MR_FLAGS_SIZE_BITS \
> > > +    (ACPI_CPU_MR_FLAGS_SIZE * BITS_PER_BYTE)     /* Read-write (Byte=
 =20
> > Acc) */ =20
> > > +#define ACPI_CPU_MR_RES_FLAGS_SIZE_BITS \
> > > +    (ACPI_CPU_MR_RES_FLAGS_SIZE * BITS_PER_BYTE) /* Reserved =20
> > padding =20
> > > +*/ #define ACPI_CPU_MR_CMD_SIZE_BITS \
> > > +    (ACPI_CPU_MR_CMD_SIZE * BITS_PER_BYTE)       /* Write-only (Byte=
 =20
> > Acc) */ =20
> > > +#define ACPI_CPU_MR_RES_CMD_SIZE_BITS \
> > > +    (ACPI_CPU_MR_RES_CMD_SIZE * BITS_PER_BYTE)   /* Reserved =20
> > padding */ =20
> > > +#define ACPI_CPU_MR_CMD_DATA_SIZE_BITS \
> > > +    (ACPI_CPU_MR_CMD_DATA_SIZE * BITS_PER_BYTE)  /* Read-write =20
> > (QWord =20
> > > +Acc) */
> > > +
> > > +/* Field offsets (in bytes) */
> > > +#define ACPI_CPU_MR_SELECTOR_OFFSET_WO  0 #define
> > > +ACPI_CPU_MR_FLAGS_OFFSET_RW \
> > > +    (ACPI_CPU_MR_SELECTOR_OFFSET_WO + \
> > > +     ACPI_CPU_MR_SELECTOR_SIZE)
> > > +#define ACPI_CPU_MR_CMD_OFFSET_WO \
> > > +    (ACPI_CPU_MR_FLAGS_OFFSET_RW + \
> > > +     ACPI_CPU_MR_FLAGS_SIZE + \
> > > +     ACPI_CPU_MR_RES_FLAGS_SIZE)
> > > +#define ACPI_CPU_MR_CMD_DATA_OFFSET_RW \
> > > +    (ACPI_CPU_MR_CMD_OFFSET_WO + \
> > > +     ACPI_CPU_MR_CMD_SIZE + \
> > > +     ACPI_CPU_MR_RES_CMD_SIZE)
> > > +
> > > +/* ensure all offsets are at their natural size alignment boundaries=
 */
> > > +#define STATIC_ASSERT_FIELD_ALIGNMENT(offset, type, field_name) =20
> > \ =20
> > > +    _Static_assert((offset) % sizeof(type) =3D=3D 0,                =
              \
> > > +                   field_name " is not aligned to its natural
> > > +boundary")
> > > +
> > > =20
> > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_SELECTOR_OFFSET_W
> > O, =20
> > > +                              uint32_t, "Selector");
> > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_FLAGS_OFFSET_RW,
> > > +                              uint8_t, "Flags");
> > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_OFFSET_WO,
> > > +                              uint8_t, "Command");
> > > =20
> > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_DATA_OFFSET_
> > RW, =20
> > > +                              uint64_t, "Command Data");
> > > +
> > > +/* Flag bit positions (used within 'flags' subfield) */ #define
> > > +ACPI_CPU_FLAGS_USED_BITS 4 #define =20
> > ACPI_CPU_MR_FLAGS_BIT_ENABLED =20
> > > +BIT(0) #define ACPI_CPU_MR_FLAGS_BIT_DEVCHK  BIT(1) #define
> > > +ACPI_CPU_MR_FLAGS_BIT_EJECTRQ BIT(2)
> > > +#define ACPI_CPU_MR_FLAGS_BIT_EJECT =20
> > BIT(ACPI_CPU_FLAGS_USED_BITS - 1) =20
> > > +
> > > +#define ACPI_CPU_MR_RES_FLAG_BITS (BITS_PER_BYTE -
> > > +ACPI_CPU_FLAGS_USED_BITS)
> > > +
> > > +enum {
> > > +    ACPI_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
> > > +    ACPI_OST_EVENT_CMD =3D 1,
> > > +    ACPI_OST_STATUS_CMD =3D 2,
> > > +    ACPI_CMD_MAX
> > > +};
> > > +
> > > +#define AML_APPEND_MR_RESVD_FIELD(mr_field, size_bits)       \
> > > +    do {                                                        \
> > > +        if ((size_bits) !=3D 0) {                                 \
> > > +            aml_append((mr_field), aml_reserved_field(size_bits)); \
> > > +        }                                                       \
> > > +    } while (0)
> > > +
> > > +#define AML_APPEND_MR_NAMED_FIELD(mr_field, name, size_bits)    \
> > > +    do {                                                        \
> > > +        if ((size_bits) !=3D 0) {                                 \
> > > +            aml_append((mr_field), aml_named_field((name), (size_bit=
s))); \
> > > +        }                                                       \
> > > +    } while (0)
> > > +
> > > +#define AML_CPU_RES_DEV(base, field) \
> > > +        aml_name("%s.%s.%s", (base), CPU_RES_DEVICE, (field))
> > > +
> > > +static ACPIOSTInfo *
> > > +acpi_cpu_ospm_ost_status(int idx, AcpiCpuOspmStateStatus *cdev) {
> > > +    ACPIOSTInfo *info =3D g_new0(ACPIOSTInfo, 1);
> > > +
> > > +    info->source =3D cdev->ost_event;
> > > +    info->status =3D cdev->ost_status;
> > > +    if (cdev->cpu) {
> > > +        DeviceState *dev =3D DEVICE(cdev->cpu);
> > > +        if (dev->id) {
> > > +            info->device =3D g_strdup(dev->id);
> > > +        }
> > > +    }
> > > +    return info;
> > > +}
> > > +
> > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st, =20
> > ACPIOSTInfoList =20
> > > +***list) {
> > > +    ACPIOSTInfoList ***tail =3D list;
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < cpu_st->dev_count; i++) {
> > > +        QAPI_LIST_APPEND(*tail, acpi_cpu_ospm_ost_status(i, &cpu_st-
> > >devs[i]));
> > > +    }
> > > +}
> > > +
> > > +static uint64_t
> > > +acpi_cpu_ospm_intf_mr_read(void *opaque, hwaddr addr, unsigned =20
> > size) =20
> > > +{
> > > +    AcpiCpuOspmState *cpu_st =3D opaque;
> > > +    AcpiCpuOspmStateStatus *cdev;
> > > +    uint64_t val =3D 0;
> > > +
> > > +    if (cpu_st->selector >=3D cpu_st->dev_count) {
> > > +        return val;
> > > +    }
> > > +    cdev =3D &cpu_st->devs[cpu_st->selector];
> > > +    switch (addr) {
> > > +    case ACPI_CPU_MR_FLAGS_OFFSET_RW:
> > > +        val |=3D qdev_check_enabled(DEVICE(cdev->cpu)) ?
> > > +                                  ACPI_CPU_MR_FLAGS_BIT_ENABLED : 0;
> > > +        val |=3D cdev->devchk_pending ? ACPI_CPU_MR_FLAGS_BIT_DEVCHK=
 : =20
> > 0; =20
> > > +        val |=3D cdev->ejrqst_pending ? ACPI_CPU_MR_FLAGS_BIT_EJECTR=
Q : =20
> > 0; =20
> > > +        trace_acpi_cpuos_if_read_flags(cpu_st->selector, val);
> > > +        break;
> > > +    case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:
> > > +        switch (cpu_st->command) {
> > > +        case ACPI_GET_NEXT_CPU_WITH_EVENT_CMD:
> > > +           val =3D cpu_st->selector;
> > > +           break;
> > > +        default:
> > > +           trace_acpi_cpuos_if_read_invalid_cmd_data(cpu_st->selecto=
r,
> > > +                                                     cpu_st->command=
);
> > > +           break;
> > > +        }
> > > +        trace_acpi_cpuos_if_read_cmd_data(cpu_st->selector, val);
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > > +    return val;
> > > +}
> > > +
> > > +static void
> > > +acpi_cpu_ospm_intf_mr_write(void *opaque, hwaddr addr, uint64_t =20
> > data, =20
> > > +                            unsigned int size) {
> > > +    AcpiCpuOspmState *cpu_st =3D opaque;
> > > +    AcpiCpuOspmStateStatus *cdev;
> > > +    ACPIOSTInfo *info;
> > > +
> > > +    assert(cpu_st->dev_count);
> > > +    if (addr) {
> > > +        if (cpu_st->selector >=3D cpu_st->dev_count) {
> > > +            trace_acpi_cpuos_if_invalid_idx_selected(cpu_st->selecto=
r);
> > > +            return;
> > > +        }
> > > +    }
> > > +
> > > +    switch (addr) {
> > > +    case ACPI_CPU_MR_SELECTOR_OFFSET_WO: /* current CPU selector =20
> > */ =20
> > > +        cpu_st->selector =3D data;
> > > +        trace_acpi_cpuos_if_write_idx(cpu_st->selector);
> > > +        break;
> > > +    case ACPI_CPU_MR_FLAGS_OFFSET_RW: /* set is_* fields  */
> > > +        cdev =3D &cpu_st->devs[cpu_st->selector];
> > > +        if (data & ACPI_CPU_MR_FLAGS_BIT_DEVCHK) {
> > > +            /* clear device-check pending event */
> > > +            cdev->devchk_pending =3D false;
> > > +            trace_acpi_cpuos_if_clear_devchk_evt(cpu_st->selector);
> > > +        } else if (data & ACPI_CPU_MR_FLAGS_BIT_EJECTRQ) {
> > > +            /* clear eject-request pending event */
> > > +            cdev->ejrqst_pending =3D false;
> > > +            trace_acpi_cpuos_if_clear_ejrqst_evt(cpu_st->selector);
> > > +        } else if (data & ACPI_CPU_MR_FLAGS_BIT_EJECT) {
> > > +            DeviceState *dev =3D NULL;
> > > +            if (!cdev->cpu || cdev->cpu =3D=3D first_cpu) {
> > > +                trace_acpi_cpuos_if_ejecting_invalid_cpu(cpu_st->sel=
ector);
> > > +                break;
> > > +            }
> > > +            /*
> > > +             * OSPM has returned with eject. Hence, it is now safe t=
o put the
> > > +             * cpu device on powered-off state.
> > > +             */
> > > +            trace_acpi_cpuos_if_ejecting_cpu(cpu_st->selector);
> > > +            dev =3D DEVICE(cdev->cpu);
> > > +            qdev_sync_disable(dev, &error_fatal);
> > > +        }
> > > +        break;
> > > +    case ACPI_CPU_MR_CMD_OFFSET_WO:
> > > +        trace_acpi_cpuos_if_write_cmd(cpu_st->selector, data);
> > > +        if (data < ACPI_CMD_MAX) {
> > > +            cpu_st->command =3D data;
> > > +            if (cpu_st->command =3D=3D =20
> > ACPI_GET_NEXT_CPU_WITH_EVENT_CMD) { =20
> > > +                uint32_t iter =3D cpu_st->selector;
> > > +
> > > +                do {
> > > +                    cdev =3D &cpu_st->devs[iter];
> > > +                    if (cdev->devchk_pending || cdev->ejrqst_pending=
) {
> > > +                        cpu_st->selector =3D iter;
> > > +                        trace_acpi_cpuos_if_cpu_has_events(cpu_st->s=
elector,
> > > +                            cdev->devchk_pending, cdev->ejrqst_pendi=
ng);
> > > +                        break;
> > > +                    }
> > > +                    iter =3D iter + 1 < cpu_st->dev_count ? iter + 1=
 : 0;
> > > +                } while (iter !=3D cpu_st->selector);
> > > +            }
> > > +        }
> > > +        break;
> > > +    case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:
> > > +        switch (cpu_st->command) {
> > > +        case ACPI_OST_EVENT_CMD: {
> > > +           cdev =3D &cpu_st->devs[cpu_st->selector];
> > > +           cdev->ost_event =3D data;
> > > +           trace_acpi_cpuos_if_write_ost_ev(cpu_st->selector, cdev-
> > >ost_event);
> > > +           break;
> > > +        }
> > > +        case ACPI_OST_STATUS_CMD: {
> > > +           cdev =3D &cpu_st->devs[cpu_st->selector];
> > > +           cdev->ost_status =3D data;
> > > +           info =3D acpi_cpu_ospm_ost_status(cpu_st->selector, cdev);
> > > +           qapi_event_send_acpi_device_ost(info);
> > > +           qapi_free_ACPIOSTInfo(info);
> > > +           trace_acpi_cpuos_if_write_ost_status(cpu_st->selector,
> > > +                                                cdev->ost_status);
> > > +           break;
> > > +        }
> > > +        default:
> > > +           trace_acpi_cpuos_if_write_invalid_cmd(cpu_st->selector,
> > > +                                                 cpu_st->command);
> > > +           break;
> > > +        }
> > > +        break;
> > > +    default:
> > > +        trace_acpi_cpuos_if_write_invalid_offset(cpu_st->selector, a=
ddr);
> > > +        break;
> > > +    }
> > > +}
> > > +
> > > +static const MemoryRegionOps cpu_common_mr_ops =3D {
> > > +    .read =3D acpi_cpu_ospm_intf_mr_read,
> > > +    .write =3D acpi_cpu_ospm_intf_mr_write,
> > > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > +    .valid =3D {
> > > +        .min_access_size =3D 1,
> > > +        .max_access_size =3D ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE,
> > > +    },
> > > +    .impl =3D {
> > > +        .min_access_size =3D 1,
> > > +        .max_access_size =3D ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE,
> > > +        .unaligned =3D false,
> > > +    },
> > > +};
> > > +
> > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object =20
> > *owner, =20
> > > +                                        AcpiCpuOspmState *state,
> > > +                                        hwaddr base_addr) {
> > > +    MachineState *machine =3D MACHINE(qdev_get_machine());
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > > +    const CPUArchIdList *id_list;
> > > +    int i;
> > > +
> > > +    assert(mc->possible_cpu_arch_ids);
> > > +    id_list =3D mc->possible_cpu_arch_ids(machine);
> > > +    state->dev_count =3D id_list->len;
> > > +    state->devs =3D g_new0(typeof(*state->devs), state->dev_count);
> > > +    for (i =3D 0; i < id_list->len; i++) {
> > > +        state->devs[i].cpu =3D  CPU(id_list->cpus[i].cpu);
> > > +        state->devs[i].arch_id =3D id_list->cpus[i].arch_id;
> > > +    }
> > > +    memory_region_init_io(&state->ctrl_reg, owner, =20
> > &cpu_common_mr_ops, state, =20
> > > +                          "ACPI CPU OSPM State Interface Memory Regi=
on",
> > > +                          ACPI_CPU_OSPM_IF_REG_LEN);
> > > +    memory_region_add_subregion(as, base_addr, &state->ctrl_reg); }
> > > +
> > > +static AcpiCpuOspmStateStatus *
> > > +acpi_get_cpu_status(AcpiCpuOspmState *cpu_st, DeviceState *dev) {
> > > +    CPUClass *k =3D CPU_GET_CLASS(dev);
> > > +    uint64_t cpu_arch_id =3D k->get_arch_id(CPU(dev));
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < cpu_st->dev_count; i++) {
> > > +        if (cpu_arch_id =3D=3D cpu_st->devs[i].arch_id) {
> > > +            return &cpu_st->devs[i];
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> > > +
> > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, DeviceState =
=20
> > *dev, =20
> > > +                              uint32_t event_st, Error **errp) {
> > > +    AcpiCpuOspmStateStatus *cdev;
> > > +    cdev =3D acpi_get_cpu_status(cpu_st, dev);
> > > +    if (!cdev) {
> > > +        return;
> > > +    }
> > > +    assert(cdev->cpu);
> > > +
> > > +    /*
> > > +     * Tell OSPM via GED IRQ(GSI) that a powered-off cpu is being po=
wered- =20
> > on. =20
> > > +     * Also, mark 'device-check' event pending for this cpu. This wi=
ll
> > > +     * eventually result in OSPM evaluating the ACPI _EVT method and=
 scan =20
> > of =20
> > > +     * cpus
> > > +     */
> > > +    cdev->devchk_pending =3D true;
> > > +    acpi_send_event(cpu_st->acpi_dev, event_st); }
> > > +
> > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st, =20
> > DeviceState *dev, =20
> > > +                              uint32_t event_st, Error **errp) {
> > > +    AcpiCpuOspmStateStatus *cdev;
> > > +    cdev =3D acpi_get_cpu_status(cpu_st, dev);
> > > +    if (!cdev) {
> > > +        return;
> > > +    }
> > > +    assert(cdev->cpu);
> > > +
> > > +    /*
> > > +     * Tell OSPM via GED IRQ(GSI) that a cpu wants to power-off or g=
o on =20
> > standby =20
> > > +     * Also,mark 'eject-request' event pending for this cpu. (gracef=
ul =20
> > shutdown) =20
> > > +     */
> > > +    cdev->ejrqst_pending =3D true;
> > > +    acpi_send_event(cpu_st->acpi_dev, event_st); }
> > > +
> > > +void
> > > +acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev, Error
> > > +**errp) {
> > > +    /* TODO: possible handling here */ }
> > > +
> > > +static const VMStateDescription vmstate_cpu_ospm_state_sts =3D {
> > > +    .name =3D "CPU OSPM state status",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (const VMStateField[]) {
> > > +        VMSTATE_BOOL(devchk_pending, AcpiCpuOspmStateStatus),
> > > +        VMSTATE_BOOL(ejrqst_pending, AcpiCpuOspmStateStatus),
> > > +        VMSTATE_UINT32(ost_event, AcpiCpuOspmStateStatus),
> > > +        VMSTATE_UINT32(ost_status, AcpiCpuOspmStateStatus),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +const VMStateDescription vmstate_cpu_ospm_state =3D {
> > > +    .name =3D "CPU OSPM state",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (const VMStateField[]) {
> > > +        VMSTATE_UINT32(selector, AcpiCpuOspmState),
> > > +        VMSTATE_UINT8(command, AcpiCpuOspmState),
> > > +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, =20
> > AcpiCpuOspmState, =20
> > > +                                             dev_count,
> > > +                                             vmstate_cpu_ospm_state_=
sts,
> > > +                                             AcpiCpuOspmStateStatus),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, const char =20
> > *root, =20
> > > +                         const char *event_handler_method) {
> > > +    MachineState *machine =3D MACHINE(qdev_get_machine());
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > > +    const CPUArchIdList *arch_ids =3D mc->possible_cpu_arch_ids(mach=
ine);
> > > +    Aml *sb_scope =3D aml_scope("_SB"); /* System Bus Scope */
> > > +    Aml *ifctx, *field, *method, *cpu_res_dev, *cpus_dev;
> > > +    Aml *zero =3D aml_int(0);
> > > +    Aml *one =3D aml_int(1);
> > > +
> > > +    cpu_res_dev =3D aml_device("%s.%s", root, CPU_RES_DEVICE);
> > > +    {
> > > +        Aml *crs;
> > > +
> > > +        aml_append(cpu_res_dev,
> > > +            aml_name_decl("_HID", aml_eisaid("PNP0A06")));
> > > +        aml_append(cpu_res_dev,
> > > +            aml_name_decl("_UID", aml_string("CPU OSPM Interface =20
> > resources"))); =20
> > > +        aml_append(cpu_res_dev, aml_mutex(CPU_LOCK, 0));
> > > +
> > > +        crs =3D aml_resource_template();
> > > +        aml_append(crs, aml_memory32_fixed(base_addr, =20
> > ACPI_CPU_OSPM_IF_REG_LEN, =20
> > > +                   AML_READ_WRITE));
> > > +
> > > +        aml_append(cpu_res_dev, aml_name_decl("_CRS", crs));
> > > +
> > > +        /* declare CPU OSPM Interface MMIO region related access fie=
lds */
> > > +        aml_append(cpu_res_dev,
> > > +                   aml_operation_region("PRST", AML_SYSTEM_MEMORY,
> > > +                                        aml_int(base_addr),
> > > +                                        ACPI_CPU_OSPM_IF_REG_LEN));
> > > +
> > > +        /*
> > > +         * define named fields within PRST region with 'Byte' access=
 widths
> > > +         * and reserve fields with other access width
> > > +         */
> > > +        field =3D aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK, =20
> > AML_PRESERVE); =20
> > > +        /* reserve CPU 'selector' field (size in bits) */
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_SELECTOR_SIZE_BITS); =20
> > > +        /* Flag::Enabled Bit(RO) - Read '1' if enabled */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_ENABLED_F, 1);
> > > +        /* Flag::Devchk Bit(RW) - Read '1', has a event. Write '1', =
to clear */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_DEVCHK_F, 1);
> > > +        /* Flag::Ejectrq Bit(RW) - Read 1, has event. Write 1 to cle=
ar */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_EJECTRQ_F, 1);
> > > +        /* Flag::Eject Bit(WO) - OSPM evals _EJx, initiates CPU Ejec=
t in =20
> > Qemu*/ =20
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_EJECT_F, 1);
> > > +        /* Flag::Bit(ACPI_CPU_FLAGS_USED_BITS)-Bit(7) - Reserve left=
 over =20
> > bits*/ =20
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_RES_FLAG_BITS); =20
> > > +        /* Reserved space: padding after flags */
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_RES_FLAGS_SIZE_BITS); =20
> > > +        /* Command field written by OSPM */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_COMMAND,
> > > +                                  ACPI_CPU_MR_CMD_SIZE_BITS);
> > > +        /* Reserved space: padding after command field */
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_RES_CMD_SIZE_BITS); =20
> > > +        /* Command data: 64-bit payload associated with command */
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_CMD_DATA_SIZE_BITS); =20
> > > +        aml_append(cpu_res_dev, field);
> > > +
> > > +        /*
> > > +         * define named fields with 'Dword' access widths and reserv=
e fields
> > > +         * with other access width
> > > +         */
> > > +        field =3D aml_field("PRST", AML_DWORD_ACC, AML_NOLOCK, =20
> > AML_PRESERVE); =20
> > > +        /* CPU selector, write only */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_SELECTOR,
> > > +                                  ACPI_CPU_MR_SELECTOR_SIZE_BITS);
> > > +        aml_append(cpu_res_dev, field);
> > > +
> > > +        /*
> > > +         * define named fields with 'Qword' access widths and reserv=
e fields
> > > +         * with other access width
> > > +         */
> > > +        field =3D aml_field("PRST", AML_QWORD_ACC, AML_NOLOCK, =20
> > AML_PRESERVE); =20
> > > +        /*
> > > +         * Reserve space: selector, flags, reserved flags, command, =
reserved
> > > +         * command for Qword alignment.
> > > +         */
> > > +        AML_APPEND_MR_RESVD_FIELD(field, =20
> > ACPI_CPU_MR_SELECTOR_SIZE_BITS + =20
> > > +                                            ACPI_CPU_MR_FLAGS_SIZE_B=
ITS +
> > > +                                            ACPI_CPU_MR_RES_FLAGS_SI=
ZE_BITS +
> > > +                                            ACPI_CPU_MR_CMD_SIZE_BIT=
S +
> > > +                                            ACPI_CPU_MR_RES_CMD_SIZE=
_BITS);
> > > +        /* Command data accessible via Qword */
> > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_DATA,
> > > +                                  ACPI_CPU_MR_CMD_DATA_SIZE_BITS);
> > > +        aml_append(cpu_res_dev, field);
> > > +    }
> > > +    aml_append(sb_scope, cpu_res_dev);
> > > +
> > > +    cpus_dev =3D aml_device("%s.%s", root, CPU_DEVICE);
> > > +    {
> > > +        Aml *ctrl_lock =3D AML_CPU_RES_DEV(root, CPU_LOCK);
> > > +        Aml *cpu_selector =3D AML_CPU_RES_DEV(root, CPU_SELECTOR);
> > > +        Aml *is_enabled =3D AML_CPU_RES_DEV(root, CPU_ENABLED_F);
> > > +        Aml *dvchk_evt =3D AML_CPU_RES_DEV(root, CPU_DEVCHK_F);
> > > +        Aml *ejrq_evt =3D AML_CPU_RES_DEV(root, CPU_EJECTRQ_F);
> > > +        Aml *ej_evt =3D AML_CPU_RES_DEV(root, CPU_EJECT_F);
> > > +        Aml *cpu_cmd =3D AML_CPU_RES_DEV(root, CPU_COMMAND);
> > > +        Aml *cpu_data =3D AML_CPU_RES_DEV(root, CPU_DATA);
> > > +        int i;
> > > +
> > > +        aml_append(cpus_dev, aml_name_decl("_HID", =20
> > aml_string("ACPI0010"))); =20
> > > +        aml_append(cpus_dev, aml_name_decl("_CID",
> > > + aml_eisaid("PNP0A05")));
> > > +
> > > +        method =3D aml_method(CPU_NOTIFY_METHOD, 2, =20
> > AML_NOTSERIALIZED); =20
> > > +        for (i =3D 0; i < arch_ids->len; i++) {
> > > +            Aml *cpu =3D aml_name(CPU_NAME_FMT, i);
> > > +            Aml *uid =3D aml_arg(0);
> > > +            Aml *event =3D aml_arg(1);
> > > +
> > > +            ifctx =3D aml_if(aml_equal(uid, aml_int(i)));
> > > +            {
> > > +                aml_append(ifctx, aml_notify(cpu, event));
> > > +            }
> > > +            aml_append(method, ifctx);
> > > +        }
> > > +        aml_append(cpus_dev, method);
> > > +
> > > +        method =3D aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
> > > +        {
> > > +            Aml *idx =3D aml_arg(0);
> > > +            Aml *sta =3D aml_local(0);
> > > +            Aml *else_ctx;
> > > +
> > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > +            aml_append(method, aml_store(idx, cpu_selector));
> > > +            aml_append(method, aml_store(zero, sta));
> > > +            ifctx =3D aml_if(aml_equal(is_enabled, one));
> > > +            {
> > > +                /* cpu is present and enabled */
> > > +                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> > > +            }
> > > +            aml_append(method, ifctx);
> > > +            else_ctx =3D aml_else();
> > > +            {
> > > +                /* cpu is present but disabled */
> > > +                aml_append(else_ctx, aml_store(aml_int(0xD), sta));
> > > +            }
> > > +            aml_append(method, else_ctx);
> > > +            aml_append(method, aml_release(ctrl_lock));
> > > +            aml_append(method, aml_return(sta));
> > > +        }
> > > +        aml_append(cpus_dev, method);
> > > +
> > > +        method =3D aml_method(CPU_EJECT_METHOD, 1, AML_SERIALIZED);
> > > +        {
> > > +            Aml *idx =3D aml_arg(0);
> > > +
> > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > +            aml_append(method, aml_store(idx, cpu_selector));
> > > +            aml_append(method, aml_store(one, ej_evt));
> > > +            aml_append(method, aml_release(ctrl_lock));
> > > +        }
> > > +        aml_append(cpus_dev, method);
> > > +
> > > +        method =3D aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
> > > +        {
> > > +            Aml *has_event =3D aml_local(0); /* Local0: Loop control=
 flag */
> > > +            Aml *uid =3D aml_local(1); /* Local1: Current CPU UID */
> > > +            /* Constants */
> > > +            Aml *dev_chk =3D aml_int(1); /* Notify: device check to =
enable */
> > > +            Aml *eject_req =3D aml_int(3); /* Notify: eject for remo=
val */
> > > +            Aml *next_cpu_cmd =3D
> > > + aml_int(ACPI_GET_NEXT_CPU_WITH_EVENT_CMD);
> > > +
> > > +            /* Acquire CPU lock */
> > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > +
> > > +            /* Initialize loop */
> > > +            aml_append(method, aml_store(zero, uid));
> > > +            aml_append(method, aml_store(one, has_event));
> > > +
> > > +            Aml *while_ctx =3D aml_while(aml_land(
> > > +                aml_equal(has_event, one),
> > > +                aml_lless(uid, aml_int(arch_ids->len))
> > > +            ));
> > > +            {
> > > +                aml_append(while_ctx, aml_store(zero, has_event));
> > > +                /*
> > > +                 * Issue scan cmd: QEMU will return next CPU with ev=
ent in
> > > +                 * cpu_data
> > > +                 */
> > > +                aml_append(while_ctx, aml_store(uid, cpu_selector));
> > > +                aml_append(while_ctx, aml_store(next_cpu_cmd,
> > > + cpu_cmd));
> > > +
> > > +                /* If scan wrapped around to an earlier UID, exit lo=
op */
> > > +                Aml *wrap_check =3D aml_if(aml_lless(cpu_data, uid));
> > > +                aml_append(wrap_check, aml_break());
> > > +                aml_append(while_ctx, wrap_check);
> > > +
> > > +                /* Set UID to scanned result */
> > > +                aml_append(while_ctx, aml_store(cpu_data, uid));
> > > +
> > > +                /* send CPU device-check(resume) event to OSPM */
> > > +                Aml *if_devchk =3D aml_if(aml_equal(dvchk_evt, one));
> > > +                {
> > > +                    aml_append(if_devchk,
> > > +                        aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
> > > +                    /* clear local device-check event sent flag */
> > > +                    aml_append(if_devchk, aml_store(one, dvchk_evt));
> > > +                    aml_append(if_devchk, aml_store(one, has_event));
> > > +                }
> > > +                aml_append(while_ctx, if_devchk);
> > > +
> > > +                /*
> > > +                 * send CPU eject-request event to OSPM to gracefull=
y handle
> > > +                 * OSPM related tasks running on this CPU
> > > +                 */
> > > +                Aml *else_ctx =3D aml_else();
> > > +                Aml *if_ejrq =3D aml_if(aml_equal(ejrq_evt, one));
> > > +                {
> > > +                    aml_append(if_ejrq,
> > > +                        aml_call2(CPU_NOTIFY_METHOD, uid, eject_req)=
);
> > > +                    /* clear local eject-request event sent flag */
> > > +                    aml_append(if_ejrq, aml_store(one, ejrq_evt));
> > > +                    aml_append(if_ejrq, aml_store(one, has_event));
> > > +                }
> > > +                aml_append(else_ctx, if_ejrq);
> > > +                aml_append(while_ctx, else_ctx);
> > > +
> > > +                /* Increment UID */
> > > +                aml_append(while_ctx, aml_increment(uid));
> > > +            }
> > > +            aml_append(method, while_ctx);
> > > +
> > > +            /* Release cpu lock */
> > > +            aml_append(method, aml_release(ctrl_lock));
> > > +        }
> > > +        aml_append(cpus_dev, method);
> > > +
> > > +        method =3D aml_method(CPU_OST_METHOD, 4, AML_SERIALIZED);
> > > +        {
> > > +            Aml *uid =3D aml_arg(0);
> > > +            Aml *ev_cmd =3D aml_int(ACPI_OST_EVENT_CMD);
> > > +            Aml *st_cmd =3D aml_int(ACPI_OST_STATUS_CMD);
> > > +
> > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > +            aml_append(method, aml_store(uid, cpu_selector));
> > > +            aml_append(method, aml_store(ev_cmd, cpu_cmd));
> > > +            aml_append(method, aml_store(aml_arg(1), cpu_data));
> > > +            aml_append(method, aml_store(st_cmd, cpu_cmd));
> > > +            aml_append(method, aml_store(aml_arg(2), cpu_data));
> > > +            aml_append(method, aml_release(ctrl_lock));
> > > +        }
> > > +        aml_append(cpus_dev, method);
> > > +
> > > +        /* build Processor object for each processor */
> > > +        for (i =3D 0; i < arch_ids->len; i++) {
> > > +            Aml *dev;
> > > +            Aml *uid =3D aml_int(i);
> > > +
> > > +            dev =3D aml_device(CPU_NAME_FMT, i);
> > > +            aml_append(dev, aml_name_decl("_HID", =20
> > aml_string("ACPI0007"))); =20
> > > +            aml_append(dev, aml_name_decl("_UID", uid));
> > > +
> > > +            method =3D aml_method("_STA", 0, AML_SERIALIZED);
> > > +            aml_append(method, aml_return(aml_call1(CPU_STS_METHOD, =
=20
> > uid))); =20
> > > +            aml_append(dev, method);
> > > +
> > > +            if (CPU(arch_ids->cpus[i].cpu) !=3D first_cpu) {
> > > +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > > +                aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
> > > +                aml_append(dev, method);
> > > +            }
> > > +
> > > +            method =3D aml_method("_OST", 3, AML_SERIALIZED);
> > > +            aml_append(method,
> > > +                aml_call4(CPU_OST_METHOD, uid, aml_arg(0),
> > > +                          aml_arg(1), aml_arg(2))
> > > +            );
> > > +            aml_append(dev, method);
> > > +            aml_append(cpus_dev, dev);
> > > +        }
> > > +    }
> > > +    aml_append(sb_scope, cpus_dev);
> > > +    aml_append(table, sb_scope);
> > > +
> > > +    method =3D aml_method(event_handler_method, 0, =20
> > AML_NOTSERIALIZED); =20
> > > +    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> > > +    aml_append(table, method);
> > > +}
> > > diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build index
> > > 73f02b9691..6d83396ab4 100644
> > > --- a/hw/acpi/meson.build
> > > +++ b/hw/acpi/meson.build
> > > @@ -8,6 +8,8 @@ acpi_ss.add(files(
> > >  ))
> > >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c',
> > > 'cpu_hotplug.c'))
> > >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false:
> > > files('acpi-cpu-hotplug-stub.c'))
> > > +acpi_ss.add(when: 'CONFIG_ACPI_CPU_OSPM_INTERFACE', if_true:
> > > +files('cpu_ospm_interface.c'))
> > > +acpi_ss.add(when: 'CONFIG_ACPI_CPU_OSPM_INTERFACE', if_false:
> > > +files('acpi-cpu-ospm-interface-stub.c'))
> > >  acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true:
> > > files('memory_hotplug.c'))
> > >  acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false:
> > > files('acpi-mem-hotplug-stub.c'))
> > >  acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
> > > diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events index
> > > edc93e703c..c0ecbdd48f 100644
> > > --- a/hw/acpi/trace-events
> > > +++ b/hw/acpi/trace-events
> > > @@ -40,6 +40,23 @@ cpuhp_acpi_fw_remove_cpu(uint32_t idx) =20
> > "0x%"PRIx32 =20
> > > cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"]
> > > OST EVENT: 0x%"PRIx32  cpuhp_acpi_write_ost_status(uint32_t slot,
> > > uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
> > >
> > > +#cpu_ospm_interface.c
> > > +acpi_cpuos_if_invalid_idx_selected(uint32_t idx) "selector =20
> > idx[0x%"PRIx32"]" =20
> > > +acpi_cpuos_if_read_flags(uint32_t idx, uint8_t flags) "cpu
> > > +idx[0x%"PRIx32"] flags: 0x%"PRIx8 acpi_cpuos_if_write_idx(uint32_t
> > > +idx) "set active cpu idx: 0x%"PRIx32 acpi_cpuos_if_write_cmd(uint32_t
> > > +idx, uint8_t cmd) "cpu idx[0x%"PRIx32"] cmd: 0x%"PRIx8
> > > +acpi_cpuos_if_write_invalid_cmd(uint32_t idx, uint8_t cmd) "cpu
> > > +idx[0x%"PRIx32"] invalid cmd: 0x%"PRIx8
> > > +acpi_cpuos_if_write_invalid_offset(uint32_t idx, uint64_t addr) "cpu
> > > +idx[0x%"PRIx32"] invalid offset: 0x%"PRIx64 =20
> > acpi_cpuos_if_read_cmd_data(uint32_t idx, uint32_t data) "cpu
> > idx[0x%"PRIx32"] data: 0x%"PRIx32
> > acpi_cpuos_if_read_invalid_cmd_data(uint32_t idx, uint8_t cmd) "cpu
> > idx[0x%"PRIx32"] invalid cmd: 0x%"PRIx8
> > acpi_cpuos_if_cpu_has_events(uint32_t idx, bool devchk, bool ejrqst) "c=
pu
> > idx[0x%"PRIx32"] device-check pending: %d, eject-request pending: %d" =
=20
> > > +acpi_cpuos_if_clear_devchk_evt(uint32_t idx) "cpu idx[0x%"PRIx32"]"
> > > +acpi_cpuos_if_clear_ejrqst_evt(uint32_t idx) "cpu idx[0x%"PRIx32"]"
> > > +acpi_cpuos_if_ejecting_invalid_cpu(uint32_t idx) "invalid cpu =20
> > idx[0x%"PRIx32"]" =20
> > > +acpi_cpuos_if_ejecting_cpu(uint32_t idx) "cpu idx[0x%"PRIx32"]"
> > > +acpi_cpuos_if_write_ost_ev(uint32_t idx, uint32_t ev) "cpu
> > > +idx[0x%"PRIx32"] OST Event: 0x%"PRIx32
> > > +acpi_cpuos_if_write_ost_status(uint32_t idx, uint32_t st) "cpu
> > > +idx[0x%"PRIx32"] OST Status: 0x%"PRIx32
> > > +
> > >  # pcihp.c
> > >  acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot: %u"
> > >  acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
> > > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> > > 2aa4b5d778..c9991e00c7 100644
> > > --- a/hw/arm/Kconfig
> > > +++ b/hw/arm/Kconfig
> > > @@ -39,6 +39,7 @@ config ARM_VIRT
> > >      select VIRTIO_MEM_SUPPORTED
> > >      select ACPI_CXL
> > >      select ACPI_HMAT
> > > +    select ACPI_CPU_OSPM_INTERFACE
> > >
> > >  config CUBIEBOARD
> > >      bool
> > > diff --git a/include/hw/acpi/cpu_ospm_interface.h
> > > b/include/hw/acpi/cpu_ospm_interface.h
> > > new file mode 100644
> > > index 0000000000..5dda327a34
> > > --- /dev/null
> > > +++ b/include/hw/acpi/cpu_ospm_interface.h
> > > @@ -0,0 +1,78 @@
> > > +/*
> > > + * ACPI CPU OSPM Interface Handling.
> > > + *
> > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > + *
> > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License as published
> > > +by
> > > + * the ree Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +#ifndef CPU_OSPM_INTERFACE_H
> > > +#define CPU_OSPM_INTERFACE_H
> > > +
> > > +#include "qapi/qapi-types-acpi.h"
> > > +#include "hw/qdev-core.h"
> > > +#include "hw/acpi/acpi.h"
> > > +#include "hw/acpi/aml-build.h"
> > > +#include "hw/boards.h"
> > > +
> > > +/**
> > > + * Total size (in bytes) of the ACPI CPU OSPM Interface MMIO region.
> > > + *
> > > + * This region contains control and status fields such as CPU
> > > +selector,
> > > + * flags, command register, and data register. It must exactly match
> > > +the
> > > + * layout defined in the AML code and the memory region =20
> > implementation. =20
> > > + *
> > > + * Any mismatch between this definition and the AML layout may result
> > > +in
> > > + * runtime errors or build-time assertion failures (e.g.,
> > > +_Static_assert),
> > > + * breaking correct device emulation and guest OS coordination.
> > > + */
> > > +#define ACPI_CPU_OSPM_IF_REG_LEN 16
> > > +
> > > +typedef struct  {
> > > +    CPUState *cpu;
> > > +    uint64_t arch_id;
> > > +    bool devchk_pending; /* device-check pending */
> > > +    bool ejrqst_pending; /* eject-request pending */
> > > +    uint32_t ost_event;
> > > +    uint32_t ost_status;
> > > +} AcpiCpuOspmStateStatus;
> > > +
> > > +typedef struct AcpiCpuOspmState {
> > > +    DeviceState *acpi_dev;
> > > +    MemoryRegion ctrl_reg;
> > > +    uint32_t selector;
> > > +    uint8_t command;
> > > +    uint32_t dev_count;
> > > +    AcpiCpuOspmStateStatus *devs;
> > > +} AcpiCpuOspmState;
> > > +
> > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, DeviceState =
=20
> > *dev, =20
> > > +                              uint32_t event_st, Error **errp);
> > > +
> > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st, =20
> > DeviceState *dev, =20
> > > +                               uint32_t event_st, Error **errp);
> > > +
> > > +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev,
> > > +                       Error **errp);
> > > +
> > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object =20
> > *owner, =20
> > > +                                        AcpiCpuOspmState *state,
> > > +                                        hwaddr base_addr);
> > > +
> > > +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, const char =20
> > *root, =20
> > > +                         const char *event_handler_method);
> > > +
> > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,
> > > +                           ACPIOSTInfoList ***list);
> > > +
> > > +extern const VMStateDescription vmstate_cpu_ospm_state; #define
> > > +VMSTATE_CPU_OSPM_STATE(cpuospm, state) \
> > > +    VMSTATE_STRUCT(cpuospm, state, 1, \
> > > +                   vmstate_cpu_ospm_state, AcpiCpuOspmState) #endif
> > > +/* CPU_OSPM_INTERFACE_H */ =20
> >  =20
>=20


