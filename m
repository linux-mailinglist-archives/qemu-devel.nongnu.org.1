Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6F723921
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 09:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6REW-0000tq-UU; Tue, 06 Jun 2023 03:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6REM-0000tO-TY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6REK-0003bM-AD
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686036945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lBX1PkZXXr2nYSKSlPo3Y5u0CEXGneoY7NdwwEr4sIU=;
 b=WHMUdgLGRCu5CI9lEKL2QeyRrPLFwWTZsoCiy/F3XUIIJ7XOQsKDTXWi5yYNti2Bj+9jfa
 9NhaKiclpz/USo15srnNdzOkOCYhCw6qudcyaX6ktFtCOmXHJBCPszyz4fxxx1vrCwrq/B
 VNzPup+ogQUZkFnQqBoYuYgCw9dDysw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-9DRsUjoOOXKs1QR-7G2qEw-1; Tue, 06 Jun 2023 03:35:44 -0400
X-MC-Unique: 9DRsUjoOOXKs1QR-7G2qEw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-514b05895f7so4293298a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 00:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686036943; x=1688628943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBX1PkZXXr2nYSKSlPo3Y5u0CEXGneoY7NdwwEr4sIU=;
 b=I+pngj/V8nuRPxVNyc2XtaYsnrvXuBDB2Xh+DHXa6Rab7nsRnaY00C0cWGeYi0KlNn
 w0dGNfiu+NFEltthBP596Hh350lLhEf9zii/b63Kq7zJvJvfgdIzslWK3+/wq5zYdNDf
 L2Fu5Y6dAgihIjk+ZGyD+4Hw2XX0SiYhG/L/Li0PPFc7MMrfXih/ZW9OKdDTahwlvd1R
 NhKZa6LOog06YqLm0irhaziZD4o+3NTWvrEC83SueGI8NPwau0cBsPUwgwvzTp6q70TJ
 oDpGBrcf0M0xTsNGki5jqbY2n4N7R8AsNpVBxeAPuklJANNjQysbn89H2YFOLtO2sKVe
 CqvA==
X-Gm-Message-State: AC+VfDyX3dDJ9clEWutyI537Gyp1S0w1qFfZ98Ixt+b1kcQU00lqEkMv
 +kgnmaAbWHQxZdQD2uQmyc47QlV5GfhHwZULMORGR7msaswrJ2qvUvYvfuub0uLsax+KbKfazOg
 g2urtfYpKW4m/d1o=
X-Received: by 2002:a05:6402:1299:b0:505:4f7:8a50 with SMTP id
 w25-20020a056402129900b0050504f78a50mr1342769edv.5.1686036942870; 
 Tue, 06 Jun 2023 00:35:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RUgPIz6gvwpNSDqYE5E35r9rMy++BRGwMWiVnhq+lGVX6uR35q9IiPi3fliu73htzwCccKQ==
X-Received: by 2002:a05:6402:1299:b0:505:4f7:8a50 with SMTP id
 w25-20020a056402129900b0050504f78a50mr1342748edv.5.1686036942547; 
 Tue, 06 Jun 2023 00:35:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i9-20020a05640200c900b0050bce352dc5sm4802718edu.85.2023.06.06.00.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 00:35:42 -0700 (PDT)
Date: Tue, 6 Jun 2023 09:35:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v4 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
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

On Mon, 5 Jun 2023 16:39:05 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

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
>  hw/i386/pc.c         | 14 +++++++++++++-
>  hw/i386/pc_piix.c    |  5 +++++
>  hw/i386/pc_q35.c     |  5 +++++
>  include/hw/i386/pc.h |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 8fc34f5454..5a87b82185 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -786,6 +786,14 @@ void pc_machine_done(Notifier *notifier, void *data)
>          if (pcmc->smbios_defaults) {
>              MachineClass *mc = MACHINE_GET_CLASS(pcms);
>  
> +            /*
> +             * Check if user has specified a command line option
> +             * to override the SMBIOS default entry point type.
> +             */
> +            if (!pcms->smbios_use_cmdline_ep_type) {
> +                pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
> +            }

why pcms->smbios_entry_point_type that we already have is not enough
we need to add extra pcms->smbios_use_cmdline_ep_type field?

> +
>              /* These values are guest ABI, do not change */
>              smbios_set_defaults("QEMU", mc->desc,
>                                  mc->name, pcmc->smbios_legacy_mode,
> @@ -1782,7 +1790,10 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
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
> @@ -1992,6 +2003,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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


