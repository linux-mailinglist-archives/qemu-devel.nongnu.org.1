Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174873BA6A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qChxq-0006xb-Mo; Fri, 23 Jun 2023 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qChxo-0006wy-39
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qChxm-0008L9-As
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687531237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6frrvCMXlNg2lguItaqDZdw1Rzf7SPKZakf/cLg89c0=;
 b=O6oNQq2WP8Jjkk1f5TeCHij4/82wYvywp3zCAuIQsJWe5/Ea6gW9iAKNN0c3rWb6Amnopm
 ZzriINjYuBviN0KIGL0dXTE5dPovgshH4LojOM+9cuzyDkY4WXNNzMB9uHoO2k6iZz+S/E
 vGlq46ilwkE8peiy5tcjvaXEIU+HnXU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-8STPHbdFO8qYSj0wqB4Bqw-1; Fri, 23 Jun 2023 10:40:34 -0400
X-MC-Unique: 8STPHbdFO8qYSj0wqB4Bqw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7623a4864c2so75909985a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687531233; x=1690123233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6frrvCMXlNg2lguItaqDZdw1Rzf7SPKZakf/cLg89c0=;
 b=DxLme05vGafxcObx95WA/04oJXdYQqT3iDipT0RmK09zj2m5IufeloMOxHGpq077gA
 Z/S/hLSM+vTUe37RdX+iTTRLQQRsGsLCThRefNJoLE4CrnY06U4q0Q7zwv8Sd5xLQWPy
 CgNTkcbFxRj8ZWqfggJfZFboftY78WSthVzJcRPSLkEbo5UJpZB2WUYdqN/tyqvDLc5b
 G1pAkcU5zMsz0XlunuEVHh2o3uY2OXa9tsPv9unYLImDtakZC+tMtuS79cXhwRH6E5sd
 gwJjmVc2n2o2isnIXTuR+TduyGA1Ad3PmNC5+HLee13eKHJY3/oVMiiYKTaezRUgt213
 90vA==
X-Gm-Message-State: AC+VfDypyPHq55O/qeGkS0jF1XY6uvql05GwO4aw+g6Ybn0q5JQGjAp3
 BUwQJwO40phL4U/6TnR6zV6LgeLtt0vrQtMxK4qH0VBkrgeE7jToN4lZGMDQ2vGnO1DE0enEuTg
 IsVwTsxMVXcBp17U=
X-Received: by 2002:a05:620a:2405:b0:765:3cee:865d with SMTP id
 d5-20020a05620a240500b007653cee865dmr5020783qkn.27.1687531233547; 
 Fri, 23 Jun 2023 07:40:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sGMlZknoI82/3DFWkRgOm3X6zsuR8ea0zVTPo37+R9hjaF7X8EoH6UsrMKtAM5rnqWEYB7g==
X-Received: by 2002:a05:620a:2405:b0:765:3cee:865d with SMTP id
 d5-20020a05620a240500b007653cee865dmr5020756qkn.27.1687531233207; 
 Fri, 23 Jun 2023 07:40:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 g16-20020ac85810000000b003e635f80e72sm1252429qtg.48.2023.06.23.07.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 07:40:32 -0700 (PDT)
Date: Fri, 23 Jun 2023 16:40:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 jusual@redhat.com, dfaggioli@suse.com, joao.m.martins@oracle.com,
 jon.grimm@amd.com, santosh.Shukla@amd.com
Subject: Re: [PATCH v6 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230623164028.0ae36699@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230623060453-mutt-send-email-mst@kernel.org>
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
 <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
 <20230623060453-mutt-send-email-mst@kernel.org>
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

On Fri, 23 Jun 2023 06:05:28 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 07, 2023 at 03:57:16PM -0500, Suravee Suthikulpanit wrote:
> > Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
> > (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
> > supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
> > models. This is necessary to avoid the following message when launching
> > a VM with large number of vcpus.
> > 
> >    "SMBIOS 2.1 table length 66822 exceeds 65535"
> > 
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>  
> 
> For some reason this causes a diff in ACPI:
> 
> $ diff -u /tmp/asl-WQRZ61.dsl /tmp/asl-S25X61.dsl 
> --- /tmp/asl-WQRZ61.dsl 2023-06-23 05:37:54.067525946 -0400
> +++ /tmp/asl-S25X61.dsl 2023-06-23 05:37:54.073525987 -0400
> @@ -5,13 +5,13 @@
>   * 
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of /tmp/aml-IROZ61, Fri Jun 23 05:37:54 2023
> + * Disassembly of tests/data/acpi/q35/SSDT.dimmpxm, Fri Jun 23 05:37:54 2023
>   *
>   * Original Table Header:
>   *     Signature        "SSDT"
>   *     Length           0x00000717 (1815)
>   *     Revision         0x01
> - *     Checksum         0xBC
> + *     Checksum         0xAC
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "NVDIMM"
>   *     OEM Revision     0x00000001 (1)
> @@ -389,6 +389,6 @@
>          }
>      }
>  
> -    Name (MEMA, 0x07FFE000)
> +    Name (MEMA, 0x07FFF000)
>  }
>  
> 
> Igor, any idea why?

It should be due to smbios tables size difference, which causes ACPI blob
allocated differently => different patched pointer. 

one can verify by adding '-machine  smbios-entry-point-type=64'
to test_acpi_tcg_dimm_pxm()

> 
> 
> > ---
> >  hw/i386/pc.c         | 4 +++-
> >  hw/i386/pc_piix.c    | 5 +++++
> >  hw/i386/pc_q35.c     | 5 +++++
> >  include/hw/i386/pc.h | 1 +
> >  4 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index bb62c994fa..33ffb03a32 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1853,6 +1853,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> >  static void pc_machine_initfn(Object *obj)
> >  {
> >      PCMachineState *pcms = PC_MACHINE(obj);
> > +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> >  
> >  #ifdef CONFIG_VMPORT
> >      pcms->vmport = ON_OFF_AUTO_AUTO;
> > @@ -1860,7 +1861,7 @@ static void pc_machine_initfn(Object *obj)
> >      pcms->vmport = ON_OFF_AUTO_OFF;
> >  #endif /* CONFIG_VMPORT */
> >      pcms->max_ram_below_4g = 0; /* use default */
> > -    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
> > +    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
> >  
> >      /* acpi build is enabled by default if machine supports it */
> >      pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
> > @@ -1980,6 +1981,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >      mc->nvdimm_supported = true;
> >      mc->smp_props.dies_supported = true;
> >      mc->default_ram_id = "pc.ram";
> > +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
> >  
> >      object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
> >          pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d5b0dcd1fe..49462b0e29 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -476,11 +476,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
> >  
> >  static void pc_i440fx_8_0_machine_options(MachineClass *m)
> >  {
> > +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> > +
> >      pc_i440fx_8_1_machine_options(m);
> >      m->alias = NULL;
> >      m->is_default = false;
> >      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
> >      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
> > +
> > +    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
> > +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
> >  }
> >  
> >  DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 6155427e48..6b9fd4d537 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -387,10 +387,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
> >  
> >  static void pc_q35_8_0_machine_options(MachineClass *m)
> >  {
> > +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> > +
> >      pc_q35_8_1_machine_options(m);
> >      m->alias = NULL;
> >      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
> >      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
> > +
> > +    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
> > +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
> >  }
> >  
> >  DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index c661e9cc80..6eec0fc51d 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -110,6 +110,7 @@ struct PCMachineClass {
> >      bool smbios_defaults;
> >      bool smbios_legacy_mode;
> >      bool smbios_uuid_encoded;
> > +    SmbiosEntryPointType default_smbios_ep_type;
> >  
> >      /* RAM / address space compat: */
> >      bool gigabyte_align;
> > -- 
> > 2.34.1  
> 


