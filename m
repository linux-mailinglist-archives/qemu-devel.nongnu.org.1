Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E657264D5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vFO-0000eV-Ns; Wed, 07 Jun 2023 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6vFN-0000eE-8f
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6vFL-0001UO-I2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnEIEAhTUtyD38xTJ/Gt6IncnmWjuJL7UTJjq2sd9Dw=;
 b=R97fIgRx8/BkADgGlJ1FJWeQHUIaL7s1OucYVbJKr+xXj3dGkm2CpRcjPyoyD/BE/VQjK7
 mywuFZvcQWfD06lIpAdyQQgDgzepOgoXh3mNfrV+KeMCxH5AnvgIX54RPyEC0yaSmmEXnD
 p3jBqTgLbKzfCNuTcxuls9rfuefFjGI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652--6Dq7A7LONi51EB-Uip6sw-1; Wed, 07 Jun 2023 09:54:37 -0400
X-MC-Unique: -6Dq7A7LONi51EB-Uip6sw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9744659b7b5so664539866b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146075; x=1688738075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnEIEAhTUtyD38xTJ/Gt6IncnmWjuJL7UTJjq2sd9Dw=;
 b=WzWEkZ4PW5T66KG9b5HGSP0uJ3J2zYJtgxQENBWyVXroWzUjwvmDK9gFyruDMo1UMt
 +UGH0EFMDLmyWkQqtg1WHkuKHpNRgSERrbU34EjE5vzDmxd80q9FenOaCjM5fDWyl5Uo
 lKEGEc/7wHqY7VIOlXZ3Ge5ounPjAWEBeUT0z+3ywa1xl97sdvOIU7/zbU3kLH2ykfDP
 gS8fi3klRpO4HPTRtsK6xrkauGLcPJmEzAsT3jgEdy94RpX5uyPGcoYwDiepVcQgEf/z
 yhhHiIQ6e0lbeSAV/U/LI/ZX0iTGd4i62IxllV8vU2DeARTeMgnIiX7dhE2NBF4SO036
 HHGw==
X-Gm-Message-State: AC+VfDzdN3UjRf3faUF1NrQ54gWsH2zkaIZwe2O78lo+Nv9XCY2lGc6G
 gsQdAjRbAQ+PkmVL5jZupmR3DWueXzHsU0y4OqRSvtKrTy0QpaklPQ4xd07bPfKEZPfMKZVuy2F
 KWF2Xg4uwRml/E8UYeDb0+d8=
X-Received: by 2002:a17:907:2d91:b0:8b1:7de3:cfaa with SMTP id
 gt17-20020a1709072d9100b008b17de3cfaamr6820600ejc.3.1686146075576; 
 Wed, 07 Jun 2023 06:54:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xHA4d4geWF6yYqq5V+jInnPHdcx2X46NyHV1+7hMR6NLLyakoufYbMBG/2LTfqYZJqSFIoA==
X-Received: by 2002:a17:907:2d91:b0:8b1:7de3:cfaa with SMTP id
 gt17-20020a1709072d9100b008b17de3cfaamr6820580ejc.3.1686146075296; 
 Wed, 07 Jun 2023 06:54:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 e2-20020a1709062c0200b0094e7d196aa4sm6894919ejh.160.2023.06.07.06.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:54:34 -0700 (PDT)
Date: Wed, 7 Jun 2023 15:54:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Message-ID: <20230607155433.4a03afb5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
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

On Tue, 6 Jun 2023 21:49:37 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Into a helper function pc_machine_init_smbios() in preparation for
> subsequent code to upgrade default SMBIOS entry point type.
> 
> Then, call the helper function from the pc_machine_initfn() to eliminate
> duplicate code in pc_q35.c and pc_pixx.c. However, this changes the
> ordering of when the smbios_set_defaults() is called to before
> pc_machine_set_smbios_ep() (i.e. before handling the user specified
> QEMU option "-M ...,smbios-entry-point-type=[32|64]" to override
> the default type.)
> 
> Therefore, also call the helper function in pc_machine_set_smbios_ep()
> to update the defaults.
> 
> There is no functional change.

with 2/3 amended as suggested, this patch is not necessary 
and 2/3 and 3/3 would do the job just fine

> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/pc.c      | 24 +++++++++++++++++++++++-
>  hw/i386/pc_piix.c |  9 ---------
>  hw/i386/pc_q35.c  |  8 --------
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb62c994fa..b720dc67b6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1756,6 +1756,22 @@ static void pc_machine_set_default_bus_bypass_iommu(Object *obj, bool value,
>      pcms->default_bus_bypass_iommu = value;
>  }
>  
> +static void pc_machine_init_smbios(PCMachineState *pcms)
> +{
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    MachineClass *mc = MACHINE_GET_CLASS(pcms);
> +
> +    if (!pcmc->smbios_defaults) {
> +        return;
> +    }
> +
> +    /* These values are guest ABI, do not change */
> +    smbios_set_defaults("QEMU", mc->desc,
> +                        mc->name, pcmc->smbios_legacy_mode,
> +                        pcmc->smbios_uuid_encoded,
> +                        pcms->smbios_entry_point_type);
> +}
> +
>  static void pc_machine_get_smbios_ep(Object *obj, Visitor *v, const char *name,
>                                       void *opaque, Error **errp)
>  {
> @@ -1768,9 +1784,14 @@ static void pc_machine_get_smbios_ep(Object *obj, Visitor *v, const char *name,
>  static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
>                                       void *opaque, Error **errp)
>  {
> +    SmbiosEntryPointType ep_type;
>      PCMachineState *pcms = PC_MACHINE(obj);
>  
> -    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
> +    if (!visit_type_SmbiosEntryPointType(v, name, &ep_type, errp)) {
> +        return;
> +    }
> +    pcms->smbios_entry_point_type = ep_type;
> +    pc_machine_init_smbios(pcms);
>  }
>  
>  static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
> @@ -1878,6 +1899,7 @@ static void pc_machine_initfn(Object *obj)
>      object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>                                OBJECT(pcms->pcspk), "audiodev");
>      cxl_machine_init(obj, &pcms->cxl_devices_state);
> +    pc_machine_init_smbios(pcms);
>  }
>  
>  int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d5b0dcd1fe..da6ba4eeb4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -198,15 +198,6 @@ static void pc_init1(MachineState *machine,
>  
>      pc_guest_info_init(pcms);
>  
> -    if (pcmc->smbios_defaults) {
> -        MachineClass *mc = MACHINE_GET_CLASS(machine);
> -        /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc,
> -                            mc->name, pcmc->smbios_legacy_mode,
> -                            pcmc->smbios_uuid_encoded,
> -                            pcms->smbios_entry_point_type);
> -    }
> -
>      /* allocate ram and load rom/bios */
>      if (!xen_enabled()) {
>          pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6155427e48..a58cd1d3ea 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -198,14 +198,6 @@ static void pc_q35_init(MachineState *machine)
>  
>      pc_guest_info_init(pcms);
>  
> -    if (pcmc->smbios_defaults) {
> -        /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc,
> -                            mc->name, pcmc->smbios_legacy_mode,
> -                            pcmc->smbios_uuid_encoded,
> -                            pcms->smbios_entry_point_type);
> -    }
> -
>      /* create pci host bus */
>      q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
>  


