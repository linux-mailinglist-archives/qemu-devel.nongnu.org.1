Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F3727A32
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 10:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7BCe-0003qZ-7l; Thu, 08 Jun 2023 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7BCb-0003qP-Fl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7BCZ-0005yD-PI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686213662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=207WCJxsiMVhadsl1Xs1hFvc7tXR727IwCou2dKzeCQ=;
 b=LTnRiz4K+kDnbmHVL1W8U0uUemvrjgE1hpDaIlMcDzD2P11AC9lq2ECZ0keQZ8O2vH/27+
 MwncKZC+MQDUa/eTyGbp/YOWqweakAeBcpYmSniHT9k4KLJU/XhdgpzD/NRiHSjeLaCeK8
 CgU5nmRhycRRfLnq3F3Gblb9DWqhGsI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-3_Ryw5hNM_eFUZ2xnhm8Pw-1; Thu, 08 Jun 2023 04:41:00 -0400
X-MC-Unique: 3_Ryw5hNM_eFUZ2xnhm8Pw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a348facbbso56037766b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 01:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686213659; x=1688805659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=207WCJxsiMVhadsl1Xs1hFvc7tXR727IwCou2dKzeCQ=;
 b=J9Ybf6jfUfNNIWyc9Y6osKrM00T0Kk1x9RwbkSW8yBWItaJkFajVc4XQkoe89q1ZTu
 NXeAJa8ILrP4pRA4PAa90IYU0bNEAXNww8AAISgU1sH2ihYbVtgyfppfEXRc80o3IKXI
 6Y3fJq6u/HyUAC3GXve6u8fe4ewKCBhxL4WiY2uQfpmNVnRHr683UN/aDd+0K/gUHEUb
 gTHxelMPaWH62VN4/12pBLV8N10D/K0K1x8WLHKhx3jGIfKEOn4oC4EJw0+8P0Ov/Ypf
 T8caTz5BZGtIcv/fu7OzOpPzonHFyJf31k4R344z2AsvG/Je/2CuDSLftGzvQIp+QgMM
 LF5g==
X-Gm-Message-State: AC+VfDxA0iGJW1Q+9JnExqCeHooP3Wep3EetQLKTGaaYeh0Jgij3OnuU
 L6lumXe8EG4OEKmBn1b4VaUY6ytQJAMbFUkwjfA3Je6aRAsWkXvaJ1LKbLiOBeMCPvth+sv1tA8
 zFiVapO0T4l/PzWg=
X-Received: by 2002:a17:907:3f9a:b0:974:1e85:6a69 with SMTP id
 hr26-20020a1709073f9a00b009741e856a69mr9345220ejc.16.1686213659541; 
 Thu, 08 Jun 2023 01:40:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5auG2hP4MejL/TxilOgQl6D9TBbEJoCjarIoQpGezi9K6rFXyLb/xBVtoOBStHzLY0nrYtTw==
X-Received: by 2002:a17:907:3f9a:b0:974:1e85:6a69 with SMTP id
 hr26-20020a1709073f9a00b009741e856a69mr9345207ejc.16.1686213659265; 
 Thu, 08 Jun 2023 01:40:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z18-20020a170906945200b00978874d1083sm391463ejx.135.2023.06.08.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 01:40:58 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:40:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v6 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230608104057.4c0ac74b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
 <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed, 7 Jun 2023 15:57:16 -0500
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

Looks good to me (see comment below for extra cleanup possibility):

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c         | 4 +++-
>  hw/i386/pc_piix.c    | 5 +++++
>  hw/i386/pc_q35.c     | 5 +++++
>  include/hw/i386/pc.h | 1 +
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb62c994fa..33ffb03a32 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1853,6 +1853,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
>  static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);

since you introduce this local,
I suggest you to post an extra clean up patch on top of this series

here is a line to cleanup with 'pcmc'

    /* acpi build is enabled by default if machine supports it */                
    pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;  

>  
>  #ifdef CONFIG_VMPORT
>      pcms->vmport = ON_OFF_AUTO_AUTO;
> @@ -1860,7 +1861,7 @@ static void pc_machine_initfn(Object *obj)
>      pcms->vmport = ON_OFF_AUTO_OFF;
>  #endif /* CONFIG_VMPORT */
>      pcms->max_ram_below_4g = 0; /* use default */
> -    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
> +    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
>  
>      /* acpi build is enabled by default if machine supports it */
>      pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
> @@ -1980,6 +1981,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      mc->nvdimm_supported = true;
>      mc->smp_props.dies_supported = true;
>      mc->default_ram_id = "pc.ram";
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  
>      object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
>          pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d5b0dcd1fe..49462b0e29 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -476,11 +476,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
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
> index 6155427e48..6b9fd4d537 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -387,10 +387,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
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


