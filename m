Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C7A81BDF
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 06:25:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Myp-0002bE-30; Wed, 09 Apr 2025 00:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2Myl-0002ab-RE
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2Myj-000717-VV
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744172635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sxOTkysThGTe6xnEUOZm2pS5mjwj/Qo2eulSJue78w=;
 b=frVhQhY4Iq+dOxIFqRqDvvLbokEsBDVJd/ita7M43bXzYfXOiZiJebhyarTkm879W0do75
 oO9O3busG21E2oSsujHybCNLGx6TtkDLq2AHiMuH40QuzCiycwOA6XmixJH4SP8yMbiHND
 Xwp752H9wC5X3Txhzaufc/lCUPrcFCo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-icZXDSlkOuyKa0KHK-qcqw-1; Wed, 09 Apr 2025 00:23:50 -0400
X-MC-Unique: icZXDSlkOuyKa0KHK-qcqw-1
X-Mimecast-MFC-AGG-ID: icZXDSlkOuyKa0KHK-qcqw_1744172629
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-227e2faab6dso53182675ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 21:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744172629; x=1744777429;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sxOTkysThGTe6xnEUOZm2pS5mjwj/Qo2eulSJue78w=;
 b=H99tv6u2x1aZGhYIdZHQobamjEB+EXWDsti6WUlkF0Pqd2hXKsxVNzEKXpp8jbblHK
 h2uVCM75wj4laRcP167tN5wkxA2JYPi2vn/RNGEKMrDmPrf1RqFEKaaALhKUf7+OT9R/
 NYt3aa73gajNW2am1NRXLK16n0T6JzqA5iBuqxj0SbSvGpIWvF5dkTD8cyjdYeqcEQOs
 zqHTdduxs/UIyVDX1c+1RRNvhhj5d5wpxAT42TB35/kLjAsgT/7WAV4jAJXAkYOyH4ap
 hizNeDMm8MsmFTPmyfI9bjfMbdfzcb+kKqZqmaz/76oXfZrIHwbvsTNolgZl9TIRWw7P
 86Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlBvbhIZUuu9N1GwVyRLcsRqf0/WIwO7IV1MwsPXbxK6b5cLzIBO3H8Mcu1yDBheLA0O3e2iDOQ3VM@nongnu.org
X-Gm-Message-State: AOJu0YwoAMlUnKhOpLhQhRIhg94uL8wUkR3VwwogjgtffWIwjtOEoG8O
 vvPCbC6xdjkvyPHTtOQXN5BoOZSJW0IjPreJhDm32EItQgmR8uOaUcSsTlFzQCA/GaSxywRbcic
 2sGltZsV3OSubfInQFjpSp9J9ZZ1GLGXMSHgUrOAN49Il4D75GXRM
X-Gm-Gg: ASbGncs8TsBeIsh5i4oeycZ8Q42/N6pTcvZRkWZEDQjM/PzzAQh9JqYJYxdpK5JPr1u
 kMrUGyt3RGimePg/dNWFfhFD4lpvG5nIVlHeclzCO6CfWnO6zwLwryfiDJkKfJE1ewZ1sXwv0vJ
 NsVQX5FguoquyTt9qBARqVONIX40bnkEqbvBKudl5wiTBnh7XGNSp3Hd1sInCr7Mg5rdc5vfxSX
 ny73T87MmpyZpgWaSNvxp+veGdvgf0MrannnWI5OYWhhMyHL/3Nu9tal444z59xo6meYnsqvymz
 wknVlRSXk/XchOepnX4G5QYP0uE0Eio=
X-Received: by 2002:a17:903:2284:b0:223:37ec:63d3 with SMTP id
 d9443c01a7336-22ac3f6fbe7mr13582615ad.18.1744172629001; 
 Tue, 08 Apr 2025 21:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOdcLnxVa6pFsGuZnhMu1ZQhUnM1Fgv3vN/7VcITNvkmQT2qDZQVPjd0MX7zxfQUOEtPyLBw==
X-Received: by 2002:a17:903:2284:b0:223:37ec:63d3 with SMTP id
 d9443c01a7336-22ac3f6fbe7mr13582325ad.18.1744172628406; 
 Tue, 08 Apr 2025 21:23:48 -0700 (PDT)
Received: from smtpclient.apple ([117.194.66.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd12b5c5sm478930a91.24.2025.04.08.21.23.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Apr 2025 21:23:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] hw/acpi: Remove legacy reset handling from vmclock
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <3d1b617f001b4ee989101748d120992c81a63a63.camel@infradead.org>
Date: Wed, 9 Apr 2025 09:53:30 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFB5981D-095A-4182-9570-77DB7CA2FE80@redhat.com>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
 <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
 <9097119d6e4c6a1f0a9c8fd3516b02008a1d8ffd.camel@infradead.org>
 <3d1b617f001b4ee989101748d120992c81a63a63.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On Feb 7, 2025, at 20:04, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The vmclock device only has a reset method in order to plug its memory
> region into the system memory. It was originally done this way in =
order
> to defer the memory_region_add_subregion_overlap() from =
vmclock_realize(),
> but that doesn't seem to be necessary (any longer?).
>=20
> Still, allowing the platform code to do this is cleaner because it =
lets
> the address be specified by the platform, easing the port to Arm and
> other platforms in future. And the platform has to be involved anyway
> because of the need to include the device in the ACPI tables (or DT).
>=20
> So drop the reset method and provide a vmclock_mmio_map() function
> instead, called from pc_machine_done().
>=20
> Shift the ACPI table build into #ifdef CONFIG_ACPI_VMCLOCK too while
> we're at it, since it looks like that wouldn't have built when vmclock
> wasn't enabled.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Ani Sinha <anisinha@redhat.com =
<mailto:anisinha@redhat.com>>

> ---
> hw/acpi/vmclock.c         | 18 ++++++------------
> hw/i386/acpi-build.c      | 16 ++++++++++------
> hw/i386/pc.c              | 10 ++++++++++
> include/hw/acpi/vmclock.h |  1 +
> 4 files changed, 27 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
> index 7387e5c9ca..36edfae0ed 100644
> --- a/hw/acpi/vmclock.c
> +++ b/hw/acpi/vmclock.c
> @@ -20,7 +20,6 @@
> #include "hw/qdev-properties.h"
> #include "hw/qdev-properties-system.h"
> #include "migration/vmstate.h"
> -#include "system/reset.h"
>=20
> #include "standard-headers/linux/vmclock-abi.h"
>=20
> @@ -107,15 +106,14 @@ static const VMStateDescription vmstate_vmclock =
=3D {
>     },
> };
>=20
> -static void vmclock_handle_reset(void *opaque)
> +void vmclock_mmio_map(Object *dev, hwaddr addr)
> {
> -    VmclockState *vms =3D VMCLOCK(opaque);
> +    VmclockState *vms =3D VMCLOCK(dev);
>=20
> -    if (!memory_region_is_mapped(&vms->clk_page)) {
> -        memory_region_add_subregion_overlap(get_system_memory(),
> -                                            vms->physaddr,
> -                                            &vms->clk_page, 0);
> -    }
> +    vms->physaddr =3D addr;
> +    memory_region_add_subregion_overlap(get_system_memory(),
> +                                        vms->physaddr,
> +                                        &vms->clk_page, 0);
> }
>=20
> static void vmclock_realize(DeviceState *dev, Error **errp)
> @@ -131,8 +129,6 @@ static void vmclock_realize(DeviceState *dev, =
Error **errp)
>         return;
>     }
>=20
> -    vms->physaddr =3D VMCLOCK_ADDR;
> -
>     e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
>=20
>     memory_region_init_ram(&vms->clk_page, OBJECT(dev), =
"vmclock_page",
> @@ -149,8 +145,6 @@ static void vmclock_realize(DeviceState *dev, =
Error **errp)
>     vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;
>     vms->clk->counter_id =3D VMCLOCK_COUNTER_INVALID;
>=20
> -    qemu_register_reset(vmclock_handle_reset, vms);
> -
>     vmclock_update_guest(vms);
> }
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53b7306b43..9db7b1f94e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2446,7 +2446,7 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>     uint8_t *u;
>     GArray *tables_blob =3D tables->table_data;
>     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
> -    Object *vmgenid_dev, *vmclock_dev;
> +    Object *vmgenid_dev;
>     char *oem_id;
>     char *oem_table_id;
>=20
> @@ -2519,12 +2519,16 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>                            tables->vmgenid, tables->linker, =
x86ms->oem_id);
>     }
>=20
> -    vmclock_dev =3D find_vmclock_dev();
> -    if (vmclock_dev) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, =
tables->linker,
> -                           x86ms->oem_id);
> +#ifdef CONFIG_ACPI_VMCLOCK
> +    {
> +        Object *vmclock_dev =3D find_vmclock_dev();
> +        if (vmclock_dev) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, =
tables->linker,
> +                               x86ms->oem_id);
> +        }
>     }
> +#endif
>=20
>     if (misc.has_hpet) {
>         acpi_add_table(table_offsets, tables_blob);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b46975c8a4..776c2c8a37 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -60,6 +60,7 @@
> #include "hw/i386/kvm/xen_gnttab.h"
> #include "hw/i386/kvm/xen_xenstore.h"
> #include "hw/mem/memory-device.h"
> +#include "hw/acpi/vmclock.h"
> #include "e820_memory_layout.h"
> #include "trace.h"
> #include "sev.h"
> @@ -635,6 +636,15 @@ void pc_machine_done(Notifier *notifier, void =
*data)
>     pci_bus_add_fw_cfg_extra_pci_roots(x86ms->fw_cfg, pcms->pcibus,
>                                        &error_abort);
>=20
> +#ifdef CONFIG_ACPI_VMCLOCK
> +    {
> +        Object *vmclock =3D find_vmclock_dev();
> +        if (vmclock) {
> +            vmclock_mmio_map(vmclock, VMCLOCK_ADDR);
> +        }
> +    }
> +#endif
> +
>     acpi_setup();
>     if (x86ms->fw_cfg) {
>         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, =
pcms->smbios_entry_point_type);
> diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
> index 5605605812..97f8a30c0e 100644
> --- a/include/hw/acpi/vmclock.h
> +++ b/include/hw/acpi/vmclock.h
> @@ -30,5 +30,6 @@ static inline Object *find_vmclock_dev(void)
>=20
> void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
>                         BIOSLinker *linker, const char *oem_id);
> +void vmclock_mmio_map(Object *dev, hwaddr addr);
>=20
> #endif
> --=20
> 2.48.1
>=20
>=20


