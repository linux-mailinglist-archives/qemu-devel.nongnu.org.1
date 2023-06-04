Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8603372171A
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 14:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nHD-0000hX-WA; Sun, 04 Jun 2023 08:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q5nHC-0000hP-1W
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 08:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q5nH7-0006dB-Bv
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685883359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zDq+6/Yjb4Y/HSVRBepfa6GW+EirOaQtwIIHEjGaHE=;
 b=H8xH+vji3ATpasoOgnRbu6PGeAsl/p5l4dTv8igYQaNZ0lSTP1DfnZlKpWuivrbdWD0sbX
 MblkC7OMJlZYKSo2a1KrYxfhHEzNwyMGMLwVGalyuHor0FVIkZUPjulhaqHGxMOj0Y3R3L
 DrjuGy9at47hpRnw8sCZcsjspAZpEeQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-mJOowo9dOw6EVvTfk9bK_g-1; Sun, 04 Jun 2023 08:55:57 -0400
X-MC-Unique: mJOowo9dOw6EVvTfk9bK_g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7005d4a85so16832235e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 05:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685883356; x=1688475356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zDq+6/Yjb4Y/HSVRBepfa6GW+EirOaQtwIIHEjGaHE=;
 b=Jg38SEnDgkGbeZVm7gYgIzV4fp6q997SKVmLjqDAXvDSo7smqNfSghX96YKyCHVITS
 VgYp3RxrGclTKCeYNJUNdrg+6c88YOvggZ79FF8+W8JCkJcNFQqtCE2UiXREsV7CEXzd
 QLBTKoM9C0/4o78QZOWNCWw74ElvOe0fm7JBDfm767ks673zs4e5R2P4EuyBm+uOKYNJ
 5zd/ezV/PY18aHGCVi+5kpIGQWClIuPR/X5W5u14kGehHf8pkRv7brs2y8Aml+rUn8Ba
 +SbVr9fgYuv2vUYUXvKqdeXSSpTXsRrq/o3lI/7yud5azlIeRMOobbCOR75LysrnrajO
 2B9g==
X-Gm-Message-State: AC+VfDwWBBf3Nv9aRdhzonDyDqhFretBuA4XqdoV5bN8rdKtFxxZxcoh
 WZSmPV7knSZ7BLuu+KJA5AAPG8LoVG/PN/w1v6tjdFzaaG9f1lJ4mbzutsDx2xcO/6zQAMk7cXC
 ukfpZiuZY5UhQ6w0=
X-Received: by 2002:a1c:4c1a:0:b0:3f4:24c8:f7c6 with SMTP id
 z26-20020a1c4c1a000000b003f424c8f7c6mr5086609wmf.16.1685883356186; 
 Sun, 04 Jun 2023 05:55:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4l+Zm6uCohZxBZ+jjvJO4cc+bChfef2o2MzdQACiTRvEROEZRY6czrjrLmqIniuwrm9MmxgA==
X-Received: by 2002:a1c:4c1a:0:b0:3f4:24c8:f7c6 with SMTP id
 z26-20020a1c4c1a000000b003f424c8f7c6mr5086595wmf.16.1685883355873; 
 Sun, 04 Jun 2023 05:55:55 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 p6-20020a056000018600b0030aefd11892sm6967191wrx.41.2023.06.04.05.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 05:55:55 -0700 (PDT)
Date: Sun, 4 Jun 2023 08:55:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
Subject: Re: [PATCH v3 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230604085221-mutt-send-email-mst@kernel.org>
References: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
 <20230603032255.517970-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603032255.517970-2-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jun 02, 2023 at 10:22:54PM -0500, Suravee Suthikulpanit wrote:
> Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
> (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
> supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
> models. This is necessary to avoid the following message when launching
> a VM with large number of vcpus.
> 
>    "SMBIOS 2.1 table length 66822 exceeds 65535"
> 
> Note that user can still override the entry point tyme w/ QEMU option
> "-M ..., smbios-entry-point-type=[32|64].
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/pc.c         |  5 ++++-
>  hw/i386/pc_piix.c    | 14 ++++++++++++++
>  hw/i386/pc_q35.c     | 14 ++++++++++++++
>  include/hw/i386/pc.h |  2 ++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb62c994fa..fced0ab0eb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1770,7 +1770,10 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
>  
> -    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
> +    pcms->smbios_use_cmdline_ep_type =
> +        visit_type_SmbiosEntryPointType(v, name,
> +                                        &pcms->smbios_entry_point_type,
> +                                        errp);
>  }
>  
>  static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d5b0dcd1fe..2905b26666 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -199,6 +199,14 @@ static void pc_init1(MachineState *machine,
>      pc_guest_info_init(pcms);
>  
>      if (pcmc->smbios_defaults) {
> +        /*
> +         * Check if user has specified command line option to override

a command line

> +         * the default SMBIOS default entry point type.

default twice

> +         */
> +        if (!pcms->smbios_use_cmdline_ep_type) {
> +            pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
> +        }
> +
>          MachineClass *mc = MACHINE_GET_CLASS(machine);
>          /* These values are guest ABI, do not change */
>          smbios_set_defaults("QEMU", mc->desc,
> @@ -453,6 +461,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pcmc->pci_root_uid = 0;
>      pcmc->default_cpu_version = 1;
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
> @@ -476,11 +485,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
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
> index 6155427e48..2d1bb5fde5 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -199,6 +199,14 @@ static void pc_q35_init(MachineState *machine)
>      pc_guest_info_init(pcms);
>  
>      if (pcmc->smbios_defaults) {
> +        /*
> +         * Check if user has specified command line option to override
> +         * the default SMBIOS default entry point type.

same

> +         */
> +        if (!pcms->smbios_use_cmdline_ep_type) {
> +            pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
> +        }
> +
>          /* These values are guest ABI, do not change */
>          smbios_set_defaults("QEMU", mc->desc,
>                              mc->name, pcmc->smbios_legacy_mode,
> @@ -359,6 +367,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pcmc->pci_root_uid = 0;
>      pcmc->default_cpu_version = 1;
> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  
>      m->family = "pc_q35";
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
> @@ -387,10 +396,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
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
> index c661e9cc80..f754da5a38 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -50,6 +50,7 @@ typedef struct PCMachineState {
>      bool i8042_enabled;
>      bool default_bus_bypass_iommu;
>      uint64_t max_fw_size;
> +    bool smbios_use_cmdline_ep_type;
>  
>      /* ACPI Memory hotplug IO base address */
>      hwaddr memhp_io_base;
> @@ -110,6 +111,7 @@ struct PCMachineClass {
>      bool smbios_defaults;
>      bool smbios_legacy_mode;
>      bool smbios_uuid_encoded;
> +    SmbiosEntryPointType default_smbios_ep_type;
>  
>      /* RAM / address space compat: */
>      bool gigabyte_align;


Can't we avoid this code duplication?

E.g. can't we use the pc_compat_8_0 machinery?

> -- 
> 2.34.1


