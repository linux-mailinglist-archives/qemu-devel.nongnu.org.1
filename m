Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F97263E9
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6usx-0004Sn-Tw; Wed, 07 Jun 2023 11:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6uso-0004SV-AV
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6usm-0005TI-GG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686150931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUd7jAdVN6HaoPWAilZVZ+tfg4lvlv+8hdlN7G2XfRY=;
 b=Ao8aFxA4IlRppryhoSEQdIJ9vklJigcAZSvi7a2gUuZ3hoICC+vdW+I7eqeRdpBQRz15dL
 ydhRzq75IJMlNZMbjgG/SD2TnzYWBnOc817143BQeijZoSFzgy91ocYqFXTqI3k2s5u6El
 T7EBPvrFRCou4NC8tBd6FAsvcApxfVY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-6hXxnr-LO_e3CjNNcuHIjg-1; Wed, 07 Jun 2023 09:49:17 -0400
X-MC-Unique: 6hXxnr-LO_e3CjNNcuHIjg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-977cf886f17so324397966b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686145755; x=1688737755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUd7jAdVN6HaoPWAilZVZ+tfg4lvlv+8hdlN7G2XfRY=;
 b=PQq/e8lbLm3oKGVQQufVKwqC6GUFXssO8zJT5szhh8bcMxysU+fG6T+6g8UoLqB2Zw
 WaWWFxX3ptjwRdHUNL+/dd3dRXfI7HQWonJeJDF4IvxZgShaxSpHHPVtOaqCkK6xJvsU
 ljUU2tPIAhkfHn+r1WBHBSt+yhqPBZWIT3wWGgO2YwgXg64Sc3cNqKVAxg7FZTeeP/7o
 SBRCQmKK0+ZAnbfSHXVv4m6Xc3s05aQCTnvAGt8UFH97Nff28IjHnMI2Xbj0je+ENxRh
 3h/UjixLmy0fvV/UR91C/sgwvxt26PKY/PTdYiiTLwrEaF9E6953vpsA6zy196S7qZD+
 419w==
X-Gm-Message-State: AC+VfDwFEA/6/TfjisIx5ZCrN1KijE5MTMgBEVHr9LhBPddZ98qUKEDy
 eNJhLGZKp6Hha7W19t8HHBSIu7Hu7FHdha6cwihyY241BYORowzy9UgSAarvVHbTUvDXJ0Z6Q7X
 UFpYtoZ7VrsHlk3M=
X-Received: by 2002:a17:907:72cc:b0:973:940e:a00f with SMTP id
 du12-20020a17090772cc00b00973940ea00fmr5340411ejc.6.1686145755540; 
 Wed, 07 Jun 2023 06:49:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KSUIhGHZMFD2ptxbY9NkXxY1dg3JdfshfNwhLqwEBgGSPEoA0Hi2B31i8uipWzHEZ3/q56Q==
X-Received: by 2002:a17:907:72cc:b0:973:940e:a00f with SMTP id
 du12-20020a17090772cc00b00973940ea00fmr5340389ejc.6.1686145755209; 
 Wed, 07 Jun 2023 06:49:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 g6-20020a170906594600b009745e1b6226sm6837276ejr.125.2023.06.07.06.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:49:14 -0700 (PDT)
Date: Wed, 7 Jun 2023 15:49:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v5 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230607154913.2a1cb2f8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230607024939.703991-3-suravee.suthikulpanit@amd.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-3-suravee.suthikulpanit@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Jun 2023 21:49:38 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
> (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
> supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
> models. This is necessary to avoid the following message when launching
> a VM with large number of vcpus.
> 
>    "SMBIOS 2.1 table length 66822 exceeds 65535"
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/pc.c         | 6 +++++-
>  hw/i386/pc_piix.c    | 5 +++++
>  hw/i386/pc_q35.c     | 5 +++++
>  include/hw/i386/pc.h | 1 +
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b720dc67b6..b5c585579a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1765,6 +1765,8 @@ static void pc_machine_init_smbios(PCMachineState *pcms)
>          return;
>      }
>  
> +    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
> +
>      /* These values are guest ABI, do not change */
>      smbios_set_defaults("QEMU", mc->desc,
>                          mc->name, pcmc->smbios_legacy_mode,
> @@ -1786,11 +1788,12 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
>  {
>      SmbiosEntryPointType ep_type;
>      PCMachineState *pcms = PC_MACHINE(obj);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>  
>      if (!visit_type_SmbiosEntryPointType(v, name, &ep_type, errp)) {
>          return;
>      }
> -    pcms->smbios_entry_point_type = ep_type;
> +    pcmc->default_smbios_ep_type = ep_type;

class field is supposed to be constant, not something modified by property
drop all of above hunks


>      pc_machine_init_smbios(pcms);
>  }

and use this with the rest of your patch

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b3d826a83a..c5bab28e9c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1859,7 +1859,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->vmport = ON_OFF_AUTO_OFF;
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
-    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
 
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
@@ -1979,6 +1979,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
+    mc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,


>  
> @@ -2002,6 +2005,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      mc->nvdimm_supported = true;
>      mc->smp_props.dies_supported = true;
>      mc->default_ram_id = "pc.ram";
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  
>      object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
>          pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index da6ba4eeb4..1a2bb25c75 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -467,11 +467,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
>  
>  static void pc_i440fx_8_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_i440fx_8_1_machine_options(m);
>      m->alias = NULL;
>      m->is_default = false;
>      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
> +
> +    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>  }
>  
>  DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index a58cd1d3ea..371cca7484 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -379,10 +379,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
>  
>  static void pc_q35_8_0_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_q35_8_1_machine_options(m);
>      m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
> +
> +    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>  }
>  
>  DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c661e9cc80..6eec0fc51d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -110,6 +110,7 @@ struct PCMachineClass {
>      bool smbios_defaults;
>      bool smbios_legacy_mode;
>      bool smbios_uuid_encoded;
> +    SmbiosEntryPointType default_smbios_ep_type;
>  
>      /* RAM / address space compat: */
>      bool gigabyte_align;


