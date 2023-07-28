Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99127766E7A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNV4-0002hu-73; Fri, 28 Jul 2023 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNUj-0002hI-Uv
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNUi-0008Hc-4p
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690550819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsGlaP1kJrkmTBAYnSYp8J76UU1KYDV6msPqR21kILE=;
 b=Oj1noSb4njR2NNBVl0CYrZmSCtJDAXgsn7BD+1xgI8nO7VrkBU/el1zODedEZq0qPtnoRD
 tss63wUkR9I6It+MMByfkw2vBZ7Y9XLpK88WnH0OXRMktTrrhJSk6pqZt7qF5j5eG5AiFS
 JkGMlOAahjYhAiKbYIjKOY4uDNjc8O4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-LvAiwjmvNE2LH-2TxqNLDQ-1; Fri, 28 Jul 2023 09:26:58 -0400
X-MC-Unique: LvAiwjmvNE2LH-2TxqNLDQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso134345466b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550817; x=1691155617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsGlaP1kJrkmTBAYnSYp8J76UU1KYDV6msPqR21kILE=;
 b=ISiKI4F+xLM7a0aXfZojZlfESu5Fdv/ByrFiYMdtk5mqxrekbNU16uAfC0/PgdGkXF
 H8TpL/Q4D1fO4SK0wyZCz0EktMQL9yfPlbMytF3rQa0i6HjCRcZ559C67FqSbQmp2xWp
 Y1gWczkUT5rTDJExEYfCtvHq6aLj7OlI1FeCNAM6N7Ml9fPFPXJ7upK/KC9pl1Stm7nM
 HyKAaO4vl4PYM4qE5vJnGTj4Mdwr1gljkwGAFz3tNCt3AKg3x5sEqIAEe16lU64qjAA5
 YqX54X3jc1k0EvsgALW5dlHsweKJ7Tdx4Y+e2+w2eZxXsvmtK+k1ZJ67N4FwfEFV475o
 ctwA==
X-Gm-Message-State: ABy/qLZc53QTOGtsM7LbvDjPJkGghTQ7EvVqhIQMXoLOMGu0wZdff5kV
 m8154g4dTSM3T6FMsAtPIyZLCwl0hFu77IkgPZA2JmnETnPiMBCsUkdxALkXhmIjUC/IWJMGesW
 Z0x+ba6GKvFeM8uk=
X-Received: by 2002:a17:906:845c:b0:99b:465c:fb9f with SMTP id
 e28-20020a170906845c00b0099b465cfb9fmr2359650ejy.8.1690550816956; 
 Fri, 28 Jul 2023 06:26:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4Cr+9jLFqwD7Kq37urPBirtacUEC7mpc3jswmGS459nJz9J/PXGwU8AS4URsmzjjA1+pOhQ==
X-Received: by 2002:a17:906:845c:b0:99b:465c:fb9f with SMTP id
 e28-20020a170906845c00b0099b465cfb9fmr2359642ejy.8.1690550816634; 
 Fri, 28 Jul 2023 06:26:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 dc26-20020a170906c7da00b00988e953a586sm2065189ejb.61.2023.07.28.06.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:26:56 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:26:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 7/8] Update the ACPI table for the Loongarch CPU
Message-ID: <20230728152655.1b941ee4@imammedo.users.ipa.redhat.com>
In-Reply-To: <c5caccd85916783d4682b34d6c4011aaa342d73a.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <c5caccd85916783d4682b34d6c4011aaa342d73a.1689837093.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 20 Jul 2023 15:15:12 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> 1.Create a new GED device type for Loongarch,
> mount cpu_madt function to update the ACPI table

madt changes should be its own patch

> 2.Update the APIC table for loongarch based on
> CPU information to support CPU hot-(un)plug
>=20
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c               |  9 +++++
>  hw/loongarch/acpi-build.c                     | 35 ++++++++++++++++--
>  hw/loongarch/generic_event_device_loongarch.c | 36 +++++++++++++++++++
>  hw/loongarch/meson.build                      |  2 +-
>  4 files changed, 79 insertions(+), 3 deletions(-)
>  create mode 100644 hw/loongarch/generic_event_device_loongarch.c
>=20
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-s=
tub.c
> index 2aec90d968..af9fda2cf4 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,15 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent=
, Object *owner,
>      return;
>  }
> =20
> +void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeature=
s opts,
> +                    hwaddr mmap_io_base,
> +                    const char *res_root,
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***li=
st)
>  {
>      return;
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 0b62c3a2f7..312908fb2f 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -46,6 +46,23 @@
>  #define ACPI_BUILD_DPRINTF(fmt, ...)
>  #endif
> =20
> +void virt_madt_cpu_entry(int uid,
> +                         const CPUArchIdList *apic_ids,
> +                         GArray *entry, bool force_enabled)
> +{
> +    uint32_t apic_id =3D apic_ids->cpus[uid].arch_id;
> +    /* Flags =E2=80=93 Local APIC Flags */
> +    uint32_t flags =3D apic_ids->cpus[uid].cpu !=3D NULL || force_enable=
d ?
> +                     1 /* Enabled */ : 0;
> +
> +    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
> +    build_append_int_noprefix(entry, 0, 1);       /* Type */
> +    build_append_int_noprefix(entry, 8, 1);       /* Length */
> +    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
> +    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */
> +    build_append_int_noprefix(entry, flags, 4); /* Flags */
> +}
> +
>  /* build FADT */
>  static void init_common_fadt_data(AcpiFadtData *data)
>  {
> @@ -121,15 +138,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, =
LoongArchMachineState *lams)
>      build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Fl=
ags */
> =20
>      for (i =3D 0; i < arch_ids->len; i++) {
> +        uint32_t flags;
> +
>          /* Processor Core Interrupt Controller Structure */
>          arch_id =3D arch_ids->cpus[i].arch_id;
> +        flags =3D arch_ids->cpus[i].cpu ? 1 : 0;
> =20
>          build_append_int_noprefix(table_data, 17, 1);    /* Type */
>          build_append_int_noprefix(table_data, 15, 1);    /* Length */
>          build_append_int_noprefix(table_data, 1, 1);     /* Version */
> -        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Process=
or ID */
> +        build_append_int_noprefix(table_data, i, 4);     /* ACPI Process=
or ID */
>          build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
> -        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
> +        build_append_int_noprefix(table_data, flags, 4);   /* Flags */
>      }
> =20
>      /* Extend I/O Interrupt Controller Structure */
> @@ -292,6 +312,17 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>                                   AML_SYSTEM_MEMORY,
>                                   VIRT_GED_MEM_ADDR);
>      }
> +
> +    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
> +        CPUHotplugFeatures opts =3D {
> +            .acpi_1_compatible =3D false,
> +            .has_legacy_cphp =3D false
> +        };
> +
> +        build_cpus_aml(dsdt, machine, opts, VIRT_GED_CPUHP_ADDR,
> +                       "\\_SB", "\\_GPE._E01", AML_SYSTEM_MEMORY);
> +
> +    }
>      acpi_dsdt_add_power_button(dsdt);
>  }
> =20
> diff --git a/hw/loongarch/generic_event_device_loongarch.c b/hw/loongarch=
/generic_event_device_loongarch.c
> new file mode 100644
> index 0000000000..1fe550239b
> --- /dev/null
> +++ b/hw/loongarch/generic_event_device_loongarch.c
> @@ -0,0 +1,36 @@
> +/*
> + * loongarch variant of the generic event device for hw reduced acpi
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/loongarch/virt.h"
> +
> +static void acpi_ged_loongarch_class_init(ObjectClass *class, void *data)
> +{
> +    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_CLASS(class);
> +
> +    adevc->madt_cpu =3D virt_madt_cpu_entry;
> +}
> +
> +static const TypeInfo acpi_ged_loongarch_info =3D {
> +    .name          =3D TYPE_ACPI_GED_LOONGARCH,
> +    .parent        =3D TYPE_ACPI_GED,
> +    .class_init    =3D acpi_ged_loongarch_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void acpi_ged_loongarch_register_types(void)
> +{
> +    type_register_static(&acpi_ged_loongarch_info);
> +}
> +
> +type_init(acpi_ged_loongarch_register_types)
> diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
> index c0421502ab..8d21addee3 100644
> --- a/hw/loongarch/meson.build
> +++ b/hw/loongarch/meson.build
> @@ -3,6 +3,6 @@ loongarch_ss.add(files(
>      'fw_cfg.c',
>  ))
>  loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'=
), fdt])
> -loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
> +loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c', 'ge=
neric_event_device_loongarch.c'))
> =20
>  hw_arch +=3D {'loongarch': loongarch_ss}


