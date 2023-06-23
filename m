Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06B73B487
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:07:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdfk-0002Ct-2e; Fri, 23 Jun 2023 06:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCdfi-0002CT-6Q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCdfg-00062A-Hy
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687514739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WFBeiBz5RXk3fmAxV5I1x9qkSWgdQtXUQ63zdmhq9Y=;
 b=KA3cJgCpeLQ706/3iUpCRYwZ3DEwoBl03uSxOPSqHohiJBBUlBqgPdIy3PVzXxB25mFE1I
 pv3lmA9YqY0YCIt4kYpCp/T/dHtcmyuAOLzRoq4F7r4Q1cZok53eNl9ApoVQHgB7hX7QHF
 mEQa698jdLh4zZ3rLBp2fCjTeVFI9/k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--bqNVfB9Mh--CmiRrAQ4cw-1; Fri, 23 Jun 2023 06:05:38 -0400
X-MC-Unique: -bqNVfB9Mh--CmiRrAQ4cw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9885a936d01so31540666b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687514737; x=1690106737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WFBeiBz5RXk3fmAxV5I1x9qkSWgdQtXUQ63zdmhq9Y=;
 b=gHhGpaeevjz4UL9mVMnorok5z/K1h8fvCbJYYNODwIExKvEbF1V79CF5BoQoiRg3Kj
 wG85Ui7aTNQfztQD/hdJpOmAzOdTfT8i/IRmKlp3/bwhYgKkkLSpqqUYmuIQbHMtE9YB
 3WxmCo4wl1NaPWUw8u/4MUTnDx+IAYh1P3Y0bToY+6vdQmNGEFZKsswTEqqsturrCcCf
 KZLw+yMIZ971K8xPX59omAumiuVOKogiNXjwgLZBZxULdk3U9VMjurv+rRWInZST2/WQ
 w+WIiHopEBnD7dO096dhwyU8jwka6i/Kssgtv6VECTRhKzu+eEvxTar0ORW9M4cKQIrj
 MnZQ==
X-Gm-Message-State: AC+VfDzF2twHQ5wtH8FOpa+92+cauHV+E0UrQ5TDPA3sfKNZvVxi6Zds
 aOY7Q+Cml/Zu1c2DRpGAVv31aqB9pNebu2NJQAdomjWquOsykAo1V3TxGVhYlJsRytbt6yx4plD
 tMbfaA77ihbPsQe0=
X-Received: by 2002:a17:907:9603:b0:969:813c:9868 with SMTP id
 gb3-20020a170907960300b00969813c9868mr18762233ejc.18.1687514737146; 
 Fri, 23 Jun 2023 03:05:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ViNY6IgpqhPrQgLQ71SvAxH4141H7f9oF7EFHjgd9NkJ/Va9AyyhLAX0v38gi+GQZBsXqCg==
X-Received: by 2002:a17:907:9603:b0:969:813c:9868 with SMTP id
 gb3-20020a170907960300b00969813c9868mr18762214ejc.18.1687514736816; 
 Fri, 23 Jun 2023 03:05:36 -0700 (PDT)
Received: from redhat.com ([176.12.150.14]) by smtp.gmail.com with ESMTPSA id
 g6-20020a170906c18600b00982a92a849asm5844204ejz.91.2023.06.23.03.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 03:05:35 -0700 (PDT)
Date: Fri, 23 Jun 2023 06:05:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
Subject: Re: [PATCH v6 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230623060453-mutt-send-email-mst@kernel.org>
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
 <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 07, 2023 at 03:57:16PM -0500, Suravee Suthikulpanit wrote:
> Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
> (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
> supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
> models. This is necessary to avoid the following message when launching
> a VM with large number of vcpus.
> 
>    "SMBIOS 2.1 table length 66822 exceeds 65535"
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

For some reason this causes a diff in ACPI:

$ diff -u /tmp/asl-WQRZ61.dsl /tmp/asl-S25X61.dsl 
--- /tmp/asl-WQRZ61.dsl 2023-06-23 05:37:54.067525946 -0400
+++ /tmp/asl-S25X61.dsl 2023-06-23 05:37:54.073525987 -0400
@@ -5,13 +5,13 @@
  * 
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of /tmp/aml-IROZ61, Fri Jun 23 05:37:54 2023
+ * Disassembly of tests/data/acpi/q35/SSDT.dimmpxm, Fri Jun 23 05:37:54 2023
  *
  * Original Table Header:
  *     Signature        "SSDT"
  *     Length           0x00000717 (1815)
  *     Revision         0x01
- *     Checksum         0xBC
+ *     Checksum         0xAC
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "NVDIMM"
  *     OEM Revision     0x00000001 (1)
@@ -389,6 +389,6 @@
         }
     }
 
-    Name (MEMA, 0x07FFE000)
+    Name (MEMA, 0x07FFF000)
 }
 

Igor, any idea why?



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
> -- 
> 2.34.1


