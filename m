Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5F7B3DF0
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 05:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmR4J-0000LG-MH; Fri, 29 Sep 2023 23:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qmR4H-0000Ku-3T
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qmR4E-0002sn-1G
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696046096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chxjfqJc9MG92DSaY3+WY/KLyyTp82e9dkM9AkhEsDM=;
 b=fuf6nKEotSSWc27ATuMtOPT7ixzXtbIZ7LalQSPsa6E8+2QikdZyQ1Qg2I4XiLhHiX5H/g
 s6/4vJi+Qau+riRS9gVY8FHiPyvdiltKFbiv67md47mVuyCfHXQa57gCc47qeyKvBS1Opk
 Xjcm2qp8KoO8SQv+41w3rOLAW60aSEo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-etZ9DINUNGewpNqPg4UWrQ-1; Fri, 29 Sep 2023 23:54:54 -0400
X-MC-Unique: etZ9DINUNGewpNqPg4UWrQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3ae5ee6624dso14136956b6e.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 20:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696046094; x=1696650894;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chxjfqJc9MG92DSaY3+WY/KLyyTp82e9dkM9AkhEsDM=;
 b=Y0hOax2Wz919POqyid2PSwcCSJeLCJCmkVpPxbEk96lptDaS9wXw+Xtmwv3uQ3nEJa
 8T4C8a5QtSQzv6efX/qbGJAriHUV1pBNEd/BBoxxla7KdSElkZUcJKf79ZnXV58RgIuw
 FNCo2AZHdinMdhYNUBKV2ytpPCyanaX+GfU+qwysxjPvtma3C6Js3yN4bhK3TLbVAxVC
 z1kl1o1VpydYNYSCZAxqpdXqQBUuHx2vIBibh8WSpVhxu7NO+YJxTxnU+7wlhRT8qxtd
 pWFgt46NAZRtd79SBwrBjjAz05kPy4LYQGH9ZpoqtXRGb+tzdALVwcD98STrEb/qnFBz
 6gaw==
X-Gm-Message-State: AOJu0YzrTMFUnSV0ZgY7tGbDkFf2ayFdOkFhs+FMVlsqLoMeMn6KsCnt
 O9p3dmv9Px8ytvFb8QrJB7Y6lF5bw5mxGJCdD6ZU/rYNQbAlJ5F+H9xWeCz3gF8PDJRODABKqDx
 OlCggWGPlMTId8ng=
X-Received: by 2002:a05:6808:3084:b0:3a8:5133:4832 with SMTP id
 bl4-20020a056808308400b003a851334832mr8117460oib.23.1696046094166; 
 Fri, 29 Sep 2023 20:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNmuSvBXHXmvtfdKdWh8GL6IVocplf8Wslwc0hS7C3qLCOn05vg3AR3iv/N+ahcSLG+RZo7g==
X-Received: by 2002:a05:6808:3084:b0:3a8:5133:4832 with SMTP id
 bl4-20020a056808308400b003a851334832mr8117447oib.23.1696046093900; 
 Fri, 29 Sep 2023 20:54:53 -0700 (PDT)
Received: from smtpclient.apple ([115.96.206.231])
 by smtp.gmail.com with ESMTPSA id
 jg6-20020a17090326c600b001c61df93afdsm10625338plb.59.2023.09.29.20.54.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Sep 2023 20:54:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PULL 38/56] hw/acpi: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230929085053.2789105-39-armbru@redhat.com>
Date: Sat, 30 Sep 2023 09:24:49 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, imammedo@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DAED4FD-46E5-461B-90C0-E14A3F83B137@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
 <20230929085053.2789105-39-armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 29-Sep-2023, at 2:20 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> From: Ani Sinha <anisinha@redhat.com>
>=20
> Code changes in acpi that addresses all compiler complaints coming =
from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
> other local variables or parameters. These makes the code confusing =
and/or adds
> bugs that are difficult to catch.  See also
>=20
>    Subject: Help wanted for enabling -Wshadow=3Dlocal
>    Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>    https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
>=20
> The code is tested to build with and without the flag turned on.
>=20
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> [Commit message tweaked]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks!
Are you not going to pick up "hw/i386: changes towards enabling =
-Wshadow=3Dlocal=E2=80=9D ?

> ---
> hw/acpi/cpu_hotplug.c | 25 +++++++++++++------------
> hw/i386/acpi-build.c  | 24 ++++++++++++------------
> hw/smbios/smbios.c    | 37 +++++++++++++++++++------------------
> 3 files changed, 44 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index ff14c3f410..634bbecb31 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -265,26 +265,27 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, =
MachineState *machine,
>=20
>     /* build Processor object for each processor */
>     for (i =3D 0; i < apic_ids->len; i++) {
> -        int apic_id =3D apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id =3D apic_ids->cpus[i].arch_id;
>=20
> -        assert(apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
> +        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
>=20
> -        dev =3D aml_processor(i, 0, 0, "CP%.02X", apic_id);
> +        dev =3D aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
>=20
>         method =3D aml_method("_MAT", 0, AML_NOTSERIALIZED);
>         aml_append(method,
> -            aml_return(aml_call2(CPU_MAT_METHOD, aml_int(apic_id), =
aml_int(i))
> +            aml_return(aml_call2(CPU_MAT_METHOD,
> +                                 aml_int(cpu_apic_id), aml_int(i))
>         ));
>         aml_append(dev, method);
>=20
>         method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>         aml_append(method,
> -            aml_return(aml_call1(CPU_STATUS_METHOD, =
aml_int(apic_id))));
> +            aml_return(aml_call1(CPU_STATUS_METHOD, =
aml_int(cpu_apic_id))));
>         aml_append(dev, method);
>=20
>         method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>         aml_append(method,
> -            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(apic_id),
> +            aml_return(aml_call2(CPU_EJECT_METHOD, =
aml_int(cpu_apic_id),
>                 aml_arg(0)))
>         );
>         aml_append(dev, method);
> @@ -298,11 +299,11 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, =
MachineState *machine,
>     /* Arg0 =3D APIC ID */
>     method =3D aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
>     for (i =3D 0; i < apic_ids->len; i++) {
> -        int apic_id =3D apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id =3D apic_ids->cpus[i].arch_id;
>=20
> -        if_ctx =3D aml_if(aml_equal(aml_arg(0), aml_int(apic_id)));
> +        if_ctx =3D aml_if(aml_equal(aml_arg(0), =
aml_int(cpu_apic_id)));
>         aml_append(if_ctx,
> -            aml_notify(aml_name("CP%.02X", apic_id), aml_arg(1))
> +            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
>         );
>         aml_append(method, if_ctx);
>     }
> @@ -319,13 +320,13 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, =
MachineState *machine,
>                                         =
aml_varpackage(x86ms->apic_id_limit);
>=20
>     for (i =3D 0, apic_idx =3D 0; i < apic_ids->len; i++) {
> -        int apic_id =3D apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id =3D apic_ids->cpus[i].arch_id;
>=20
> -        for (; apic_idx < apic_id; apic_idx++) {
> +        for (; apic_idx < cpu_apic_id; apic_idx++) {
>             aml_append(pkg, aml_int(0));
>         }
>         aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
> -        apic_idx =3D apic_id + 1;
> +        apic_idx =3D cpu_apic_id + 1;
>     }
>     aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
>     aml_append(ctx, sb_scope);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4d2d40bab5..95199c8900 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1585,12 +1585,12 @@ build_dsdt(GArray *table_data, BIOSLinker =
*linker,
>             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>             if (pci_bus_is_cxl(bus)) {
> -                struct Aml *pkg =3D aml_package(2);
> +                struct Aml *aml_pkg =3D aml_package(2);
>=20
>                 aml_append(dev, aml_name_decl("_HID", =
aml_string("ACPI0016")));
> -                aml_append(pkg, aml_eisaid("PNP0A08"));
> -                aml_append(pkg, aml_eisaid("PNP0A03"));
> -                aml_append(dev, aml_name_decl("_CID", pkg));
> +                aml_append(aml_pkg, aml_eisaid("PNP0A08"));
> +                aml_append(aml_pkg, aml_eisaid("PNP0A03"));
> +                aml_append(dev, aml_name_decl("_CID", aml_pkg));
>                 build_cxl_osc_method(dev);
>             } else if (pci_bus_is_express(bus)) {
>                 aml_append(dev, aml_name_decl("_HID", =
aml_eisaid("PNP0A08")));
> @@ -1783,14 +1783,14 @@ build_dsdt(GArray *table_data, BIOSLinker =
*linker,
>         Object *pci_host =3D acpi_get_i386_pci_host();
>=20
>         if (pci_host) {
> -            PCIBus *bus =3D PCI_HOST_BRIDGE(pci_host)->bus;
> -            Aml *scope =3D aml_scope("PCI0");
> +            PCIBus *pbus =3D PCI_HOST_BRIDGE(pci_host)->bus;
> +            Aml *ascope =3D aml_scope("PCI0");
>             /* Scan all PCI buses. Generate tables to support hotplug. =
*/
> -            build_append_pci_bus_devices(scope, bus);
> -            if (object_property_find(OBJECT(bus), =
ACPI_PCIHP_PROP_BSEL)) {
> -                build_append_pcihp_slots(scope, bus);
> +            build_append_pci_bus_devices(ascope, pbus);
> +            if (object_property_find(OBJECT(pbus), =
ACPI_PCIHP_PROP_BSEL)) {
> +                build_append_pcihp_slots(ascope, pbus);
>             }
> -            aml_append(sb_scope, scope);
> +            aml_append(sb_scope, ascope);
>         }
>     }
>=20
> @@ -1842,10 +1842,10 @@ build_dsdt(GArray *table_data, BIOSLinker =
*linker,
>         bool has_pcnt;
>=20
>         Object *pci_host =3D acpi_get_i386_pci_host();
> -        PCIBus *bus =3D PCI_HOST_BRIDGE(pci_host)->bus;
> +        PCIBus *b =3D PCI_HOST_BRIDGE(pci_host)->bus;
>=20
>         scope =3D aml_scope("\\_SB.PCI0");
> -        has_pcnt =3D build_append_notfication_callback(scope, bus);
> +        has_pcnt =3D build_append_notfication_callback(scope, b);
>         if (has_pcnt) {
>             aml_append(dsdt, scope);
>         }
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index b753705856..2a90601ac5 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1423,13 +1423,14 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>             if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, =
errp)) {
>                 return;
>             }
> -            struct type8_instance *t;
> -            t =3D g_new0(struct type8_instance, 1);
> -            save_opt(&t->internal_reference, opts, =
"internal_reference");
> -            save_opt(&t->external_reference, opts, =
"external_reference");
> -            t->connector_type =3D qemu_opt_get_number(opts, =
"connector_type", 0);
> -            t->port_type =3D qemu_opt_get_number(opts, "port_type", =
0);
> -            QTAILQ_INSERT_TAIL(&type8, t, next);
> +            struct type8_instance *t8_i;
> +            t8_i =3D g_new0(struct type8_instance, 1);
> +            save_opt(&t8_i->internal_reference, opts, =
"internal_reference");
> +            save_opt(&t8_i->external_reference, opts, =
"external_reference");
> +            t8_i->connector_type =3D qemu_opt_get_number(opts,
> +                                                       =
"connector_type", 0);
> +            t8_i->port_type =3D qemu_opt_get_number(opts, =
"port_type", 0);
> +            QTAILQ_INSERT_TAIL(&type8, t8_i, next);
>             return;
>         case 11:
>             if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, =
errp)) {
> @@ -1452,27 +1453,27 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>             type17.speed =3D qemu_opt_get_number(opts, "speed", 0);
>             return;
>         case 41: {
> -            struct type41_instance *t;
> +            struct type41_instance *t41_i;
>             Error *local_err =3D NULL;
>=20
>             if (!qemu_opts_validate(opts, qemu_smbios_type41_opts, =
errp)) {
>                 return;
>             }
> -            t =3D g_new0(struct type41_instance, 1);
> -            save_opt(&t->designation, opts, "designation");
> -            t->kind =3D qapi_enum_parse(&type41_kind_lookup,
> -                                      qemu_opt_get(opts, "kind"),
> -                                      0, &local_err) + 1;
> -            t->kind |=3D 0x80;     /* enabled */
> +            t41_i =3D g_new0(struct type41_instance, 1);
> +            save_opt(&t41_i->designation, opts, "designation");
> +            t41_i->kind =3D qapi_enum_parse(&type41_kind_lookup,
> +                                          qemu_opt_get(opts, "kind"),
> +                                          0, &local_err) + 1;
> +            t41_i->kind |=3D 0x80;     /* enabled */
>             if (local_err !=3D NULL) {
>                 error_propagate(errp, local_err);
> -                g_free(t);
> +                g_free(t41_i);
>                 return;
>             }
> -            t->instance =3D qemu_opt_get_number(opts, "instance", 1);
> -            save_opt(&t->pcidev, opts, "pcidev");
> +            t41_i->instance =3D qemu_opt_get_number(opts, "instance", =
1);
> +            save_opt(&t41_i->pcidev, opts, "pcidev");
>=20
> -            QTAILQ_INSERT_TAIL(&type41, t, next);
> +            QTAILQ_INSERT_TAIL(&type41, t41_i, next);
>             return;
>         }
>         default:
> --=20
> 2.41.0
>=20


