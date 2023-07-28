Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82935766D6E
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPM4D-00031t-Cv; Fri, 28 Jul 2023 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPM47-0002zv-3B
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPM45-0005rh-FV
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690545324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmGQdmvbTXPy2IvvNwKB1S/WlEOM5jHjjN/6v3R1bT8=;
 b=WPpE2w/WpYX70M2Joyi4j/yGDKJwNaXgGkTr2SPD8UqaivWK3l+ojZIkRtV2TiNE9+wZBX
 bHRDUdJmyqBuPrCVK7ASh1gvqjEGK+0i/nj6HHrMxULyMrtGG9X2ndV5GNcCxfWlKlmfKO
 liOpoQjoKcHzOukoZMPwttrjkAuUIew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-RvxxFuoVNAyj6lYyeBW4tg-1; Fri, 28 Jul 2023 07:55:23 -0400
X-MC-Unique: RvxxFuoVNAyj6lYyeBW4tg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bb3a2c781so123234466b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 04:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690545322; x=1691150122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmGQdmvbTXPy2IvvNwKB1S/WlEOM5jHjjN/6v3R1bT8=;
 b=axl77jU20J6iul0FPWNGg/5zwanvb68tSTQDTeJMYQ3yB/SRcJB33bbih+eyH/mKKE
 pcsYeGN/Cab4buJZCVLLm0RQzK9IrQiy63AERmOsjqJKRNlEyEy3rUmDl42/ZsuQ8W45
 A9VVu2KNfWLW9qAV6jUEv7LjrgWYZvmIueMiOG9Q+bV82HLv5XGCSQTI5er52eBm3de/
 T0VI4I/IXrlSJCJhe9XhKsj1ouuf6ePxy8wgm/plysllSH77QRUbgAsW1gLh8kFHfhWV
 Hsh/oV52NlcImS8u7YlV0Iu5lCobt5aU6T2MaZj8FnHfneNocWLF0jUFF40A2ldsy/06
 8DDQ==
X-Gm-Message-State: ABy/qLbBqMgONsT+94itfJtm6eZOiM5LDR5UmRJBnNt3Kf4RqkryRJRM
 JvsVBI3THkRURTBnm695nABaoRvRxydX4kEeczJ0vzLlYRCSBF0iacmt+x32a0FoEd9GmPNVqQO
 UP2u3AEcu2AIlgHo=
X-Received: by 2002:a17:906:31c3:b0:994:54ff:10f6 with SMTP id
 f3-20020a17090631c300b0099454ff10f6mr1754550ejf.30.1690545322383; 
 Fri, 28 Jul 2023 04:55:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHyZ/3IvIKxqdT05EBVgVbtYZ3IcQS5K4f2tmOiPxdbsbFTgkg0kUpTLcsxkfQdrcT3dsjgiA==
X-Received: by 2002:a17:906:31c3:b0:994:54ff:10f6 with SMTP id
 f3-20020a17090631c300b0099454ff10f6mr1754529ejf.30.1690545322128; 
 Fri, 28 Jul 2023 04:55:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 u27-20020a1709063b9b00b0098e42bef732sm1933226ejf.183.2023.07.28.04.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 04:55:21 -0700 (PDT)
Date: Fri, 28 Jul 2023 13:55:20 +0200
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
Subject: Re: [PATCH 2/8] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230728135520.3c79fae7@imammedo.users.ipa.redhat.com>
In-Reply-To: <d40ea40fe8290160f95a79515bebc20c4fbfe48f.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <d40ea40fe8290160f95a79515bebc20c4fbfe48f.1689837093.git.lixianglai@loongson.cn>
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

On Thu, 20 Jul 2023 15:15:07 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is ba=
sed on
> PCI and is IO port based and hence existing cpus AML code assumes _CRS ob=
jects
> would evaluate to a system resource which describes IO Port address. But =
on LOONGARCH
> arch CPUs control device(\\_SB.PRES) register interface is memory-mapped =
hence
> _CRS object should evaluate to system resource which describes memory-map=
ped
> base address.
>=20
> This cpus AML code change updates the existing inerface of the build cpus=
 AML
                                                 ^^^ typo
> function to accept both IO/MEMORY type regions and update the _CRS object
> correspondingly.

try to reformat commit message  to less than 80 character per line

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
>  hw/acpi/cpu.c         | 30 +++++++++++++++++++++++-------
>  hw/i386/acpi-build.c  |  2 +-
>  include/hw/acpi/cpu.h |  5 +++--
>  3 files changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 6897c8789a..3b945a1a40 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -5,6 +5,7 @@
>  #include "qapi/qapi-events-acpi.h"
>  #include "trace.h"
>  #include "sysemu/numa.h"
> +#include "hw/acpi/cpu_hotplug.h"
> =20
>  #define OVMF_CPUHP_SMI_CMD 4
> =20
> @@ -331,9 +332,10 @@ const VMStateDescription vmstate_cpu_hotplug =3D {
>  #define CPU_FW_EJECT_EVENT "CEJF"
> =20
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeature=
s opts,
> -                    hwaddr io_base,
> +                    hwaddr mmap_io_base,
>                      const char *res_root,
> -                    const char *event_handler_method)
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs)
>  {
>      Aml *ifctx;
>      Aml *field;
> @@ -360,14 +362,28 @@ void build_cpus_aml(Aml *table, MachineState *machi=
ne, CPUHotplugFeatures opts,
>          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> =20
>          crs =3D aml_resource_template();
> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> +        if (rs =3D=3D AML_SYSTEM_IO) {
> +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base, mmap_io_b=
ase, 1,
>                                 ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else {
> +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE)=
);
> +        }
>          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> =20
> -        /* declare CPU hotplug MMIO region with related access fields */
> -        aml_append(cpu_ctrl_dev,
> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> -                                 ACPI_CPU_HOTPLUG_REG_LEN));
> +        if (rs =3D=3D AML_SYSTEM_IO) {
> +            /* declare CPU hotplug MMIO region with related access field=
s */
> +            aml_append(cpu_ctrl_dev,
> +                aml_operation_region("PRST", AML_SYSTEM_IO,
> +                                             aml_int(mmap_io_base),
> +                                             ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else {
> +            aml_append(cpu_ctrl_dev,
> +                aml_operation_region("PRST", AML_SYSTEM_MEMORY,
> +                                             aml_int(mmap_io_base),
> +                                             ACPI_CPU_HOTPLUG_REG_LEN));
> +        }


to reduce duplication, following could be better way to spell it:
 g_assert(rs =3D=3D foo1 || rs =3D=3D foo2)
 ... aml_operation_region("PRST", rs, aml_int(io_base), ...

> =20
>          field =3D aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
>                            AML_WRITE_AS_ZEROS);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c74fa17ad..5d02690593 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1548,7 +1548,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              .fw_unplugs_cpu =3D pm->smi_on_cpu_unplug,
>          };
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
> -                       "\\_SB.PCI0", "\\_GPE._E02");
> +                       "\\_SB.PCI0", "\\_GPE._E02", AML_SYSTEM_IO);
>      }
> =20
>      if (pcms->memhp_io_base && nr_mem) {
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 999caaf510..cddea78333 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -56,9 +56,10 @@ typedef struct CPUHotplugFeatures {
>  } CPUHotplugFeatures;
> =20
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeature=
s opts,
> -                    hwaddr io_base,
> +                    hwaddr mmap_io_base,
>                      const char *res_root,
> -                    const char *event_handler_method);
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs);
> =20
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***li=
st);
> =20


