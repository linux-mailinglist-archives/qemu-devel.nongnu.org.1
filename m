Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41597AB576
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjidJ-0005jg-O5; Fri, 22 Sep 2023 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjid8-0005fG-Al
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjid5-0006se-SI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695398621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cD8SIe1x39yfwRlBv/yZdOZZV0kos4JswNNq4wOEygg=;
 b=KliE2JJz4KRoI3pYN7KpuRh0WXKf7MJHmIIE4cPH31JforDQSTeHSaXVRefDn0hWiD97CB
 Q2HcaGO8WXCluAi5pJySZCfltgQBHVM3Bgj4HpllcXR4GRS9iRlUhPCelhrer1+t9/XnLW
 Xz/ZA10ypcWXVj4OFMR3ZnKmVsND5k4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-kjIFuzjwN2u2qPlfoy0h1Q-1; Fri, 22 Sep 2023 12:03:40 -0400
X-MC-Unique: kjIFuzjwN2u2qPlfoy0h1Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c012f7ca56so31299201fa.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695398615; x=1696003415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD8SIe1x39yfwRlBv/yZdOZZV0kos4JswNNq4wOEygg=;
 b=mDEcg0K/SYUcD+50eR0jb0G6lCttWt4+m6p4Elp8O6yCmUCol/hdvJJu+QXE4csugP
 5URXnbP+orY7b9rH2c2J+oTmaQCgOBYm3xzPVIh3UCjZbudIPYbezAME2HvHBJzThUCq
 vYMI0lhQ5oZNyrgS8zIw3TPPb0iP2bDxV+a4Go/hxIVJVFqiukdr922whCH4R3hWpPCB
 QQxR9hKqjWNIujqRayLjt0aMyl+Kpe+UdmqsmiBmCqvnDz/Bfx1eZ+WEh8AHZnAbgwOS
 ImsADukfRPwMr+GXH0qjeJJI+Yf4/cAQOsapRIQ1aNuj33zlPIiRJNeKiAzgY8D8s3zQ
 DWjw==
X-Gm-Message-State: AOJu0Yx9KSZPl0FUnbFQ3Yy7yQUfWd367f/CU/GWYESo0qVxSlrjhxSM
 Zy/xENtNcp4sOX9AykZ0dgzL4pz0m1Uxd9GMpPQWskNzjPDOR0hV6Y8wBST2QzCHqgfOilQRXKU
 qgprMlFKfsQn7vO8=
X-Received: by 2002:a05:651c:144:b0:2bf:7fad:229b with SMTP id
 c4-20020a05651c014400b002bf7fad229bmr7113605ljd.37.1695398615441; 
 Fri, 22 Sep 2023 09:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFihekB3fI0JPc8suzqtlZSp95gyfnjYuCwd88P/A8G16dvu8UnFgh3pRXKdqm/W5dlfCkiFQ==
X-Received: by 2002:a05:651c:144:b0:2bf:7fad:229b with SMTP id
 c4-20020a05651c014400b002bf7fad229bmr7113570ljd.37.1695398615023; 
 Fri, 22 Sep 2023 09:03:35 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 g5-20020a17090670c500b009a13fdc139fsm2875615ejk.183.2023.09.22.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 09:03:33 -0700 (PDT)
Date: Fri, 22 Sep 2023 12:03:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
Message-ID: <20230922120201-mutt-send-email-mst@kernel.org>
References: <20230922124203.127110-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922124203.127110-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 22, 2023 at 06:12:02PM +0530, Ani Sinha wrote:
> Code changes in acpi that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds
> bugs that are difficult to catch.
> 
> The code is tested to build with and without the flag turned on.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> CC: imammedo@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/acpi/cpu_hotplug.c | 25 +++++++++++++------------
>  hw/i386/acpi-build.c  | 24 ++++++++++++------------
>  hw/smbios/smbios.c    | 37 +++++++++++++++++++------------------
>  3 files changed, 44 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index ff14c3f410..634bbecb31 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -265,26 +265,27 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
>  
>      /* build Processor object for each processor */
>      for (i = 0; i < apic_ids->len; i++) {
> -        int apic_id = apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>  
> -        assert(apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
> +        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
>  
> -        dev = aml_processor(i, 0, 0, "CP%.02X", apic_id);
> +        dev = aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
>  
>          method = aml_method("_MAT", 0, AML_NOTSERIALIZED);
>          aml_append(method,
> -            aml_return(aml_call2(CPU_MAT_METHOD, aml_int(apic_id), aml_int(i))
> +            aml_return(aml_call2(CPU_MAT_METHOD,
> +                                 aml_int(cpu_apic_id), aml_int(i))
>          ));
>          aml_append(dev, method);
>  
>          method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>          aml_append(method,
> -            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(apic_id))));
> +            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(cpu_apic_id))));
>          aml_append(dev, method);
>  
>          method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>          aml_append(method,
> -            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(apic_id),
> +            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(cpu_apic_id),
>                  aml_arg(0)))
>          );
>          aml_append(dev, method);
> @@ -298,11 +299,11 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
>      /* Arg0 = APIC ID */
>      method = aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
>      for (i = 0; i < apic_ids->len; i++) {
> -        int apic_id = apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>  
> -        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(apic_id)));
> +        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(cpu_apic_id)));
>          aml_append(if_ctx,
> -            aml_notify(aml_name("CP%.02X", apic_id), aml_arg(1))
> +            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
>          );
>          aml_append(method, if_ctx);
>      }
> @@ -319,13 +320,13 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
>                                          aml_varpackage(x86ms->apic_id_limit);
>  
>      for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
> -        int apic_id = apic_ids->cpus[i].arch_id;
> +        int cpu_apic_id = apic_ids->cpus[i].arch_id;
>  
> -        for (; apic_idx < apic_id; apic_idx++) {
> +        for (; apic_idx < cpu_apic_id; apic_idx++) {
>              aml_append(pkg, aml_int(0));
>          }
>          aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
> -        apic_idx = apic_id + 1;
> +        apic_idx = cpu_apic_id + 1;
>      }
>      aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
>      aml_append(ctx, sb_scope);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4d2d40bab5..95199c8900 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1585,12 +1585,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
> -                struct Aml *pkg = aml_package(2);
> +                struct Aml *aml_pkg = aml_package(2);
>  
>                  aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
> -                aml_append(pkg, aml_eisaid("PNP0A08"));
> -                aml_append(pkg, aml_eisaid("PNP0A03"));
> -                aml_append(dev, aml_name_decl("_CID", pkg));
> +                aml_append(aml_pkg, aml_eisaid("PNP0A08"));
> +                aml_append(aml_pkg, aml_eisaid("PNP0A03"));
> +                aml_append(dev, aml_name_decl("_CID", aml_pkg));
>                  build_cxl_osc_method(dev);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> @@ -1783,14 +1783,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          Object *pci_host = acpi_get_i386_pci_host();
>  
>          if (pci_host) {
> -            PCIBus *bus = PCI_HOST_BRIDGE(pci_host)->bus;
> -            Aml *scope = aml_scope("PCI0");
> +            PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
> +            Aml *ascope = aml_scope("PCI0");
>              /* Scan all PCI buses. Generate tables to support hotplug. */
> -            build_append_pci_bus_devices(scope, bus);
> -            if (object_property_find(OBJECT(bus), ACPI_PCIHP_PROP_BSEL)) {
> -                build_append_pcihp_slots(scope, bus);
> +            build_append_pci_bus_devices(ascope, pbus);
> +            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
> +                build_append_pcihp_slots(ascope, pbus);
>              }
> -            aml_append(sb_scope, scope);
> +            aml_append(sb_scope, ascope);
>          }
>      }
>  
> @@ -1842,10 +1842,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          bool has_pcnt;
>  
>          Object *pci_host = acpi_get_i386_pci_host();
> -        PCIBus *bus = PCI_HOST_BRIDGE(pci_host)->bus;
> +        PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>  
>          scope = aml_scope("\\_SB.PCI0");
> -        has_pcnt = build_append_notfication_callback(scope, bus);
> +        has_pcnt = build_append_notfication_callback(scope, b);
>          if (has_pcnt) {
>              aml_append(dsdt, scope);
>          }
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index b753705856..2a90601ac5 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1423,13 +1423,14 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
>                  return;
>              }
> -            struct type8_instance *t;
> -            t = g_new0(struct type8_instance, 1);
> -            save_opt(&t->internal_reference, opts, "internal_reference");
> -            save_opt(&t->external_reference, opts, "external_reference");
> -            t->connector_type = qemu_opt_get_number(opts, "connector_type", 0);
> -            t->port_type = qemu_opt_get_number(opts, "port_type", 0);
> -            QTAILQ_INSERT_TAIL(&type8, t, next);
> +            struct type8_instance *t8_i;
> +            t8_i = g_new0(struct type8_instance, 1);
> +            save_opt(&t8_i->internal_reference, opts, "internal_reference");
> +            save_opt(&t8_i->external_reference, opts, "external_reference");
> +            t8_i->connector_type = qemu_opt_get_number(opts,
> +                                                       "connector_type", 0);
> +            t8_i->port_type = qemu_opt_get_number(opts, "port_type", 0);
> +            QTAILQ_INSERT_TAIL(&type8, t8_i, next);
>              return;
>          case 11:
>              if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
> @@ -1452,27 +1453,27 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              type17.speed = qemu_opt_get_number(opts, "speed", 0);
>              return;
>          case 41: {
> -            struct type41_instance *t;
> +            struct type41_instance *t41_i;
>              Error *local_err = NULL;
>  
>              if (!qemu_opts_validate(opts, qemu_smbios_type41_opts, errp)) {
>                  return;
>              }
> -            t = g_new0(struct type41_instance, 1);
> -            save_opt(&t->designation, opts, "designation");
> -            t->kind = qapi_enum_parse(&type41_kind_lookup,
> -                                      qemu_opt_get(opts, "kind"),
> -                                      0, &local_err) + 1;
> -            t->kind |= 0x80;     /* enabled */
> +            t41_i = g_new0(struct type41_instance, 1);
> +            save_opt(&t41_i->designation, opts, "designation");
> +            t41_i->kind = qapi_enum_parse(&type41_kind_lookup,
> +                                          qemu_opt_get(opts, "kind"),
> +                                          0, &local_err) + 1;
> +            t41_i->kind |= 0x80;     /* enabled */
>              if (local_err != NULL) {
>                  error_propagate(errp, local_err);
> -                g_free(t);
> +                g_free(t41_i);
>                  return;
>              }
> -            t->instance = qemu_opt_get_number(opts, "instance", 1);
> -            save_opt(&t->pcidev, opts, "pcidev");
> +            t41_i->instance = qemu_opt_get_number(opts, "instance", 1);
> +            save_opt(&t41_i->pcidev, opts, "pcidev");
>  
> -            QTAILQ_INSERT_TAIL(&type41, t, next);
> +            QTAILQ_INSERT_TAIL(&type41, t41_i, next);
>              return;
>          }
>          default:
> -- 
> 2.39.1


