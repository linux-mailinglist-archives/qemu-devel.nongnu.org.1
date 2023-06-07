Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F53725709
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oGz-0002Mq-1P; Wed, 07 Jun 2023 04:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6oGx-0002M1-0A
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6oGv-00084d-5K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686125520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jSXuuLH5bBb2v46IY1Wqd9jjTkIDuwuDUnGm+FYfBbc=;
 b=Km9JHIzjdpXmmcPfYvc/2ouLSyH/6DjkZhbY+XO3KTYNF5A9ZwIb+CLLEm0IaO4aK0tOwJ
 vi/4jhY/DGQTs43IbVEiChgFU4kFhHOPAiJz+MpTJ6OPW27tfed62DPbwMDTpjPLkrcpHw
 krGKOGs8btoVt+RJvKKa3rSHLstS/tI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-bU-SBpNFMNeGlnYqTCPUcg-1; Wed, 07 Jun 2023 04:11:56 -0400
X-MC-Unique: bU-SBpNFMNeGlnYqTCPUcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 272CD811E7F;
 Wed,  7 Jun 2023 08:11:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFE22026D49;
 Wed,  7 Jun 2023 08:11:53 +0000 (UTC)
Date: Wed, 7 Jun 2023 09:11:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com, jusual@redhat.com,
 dfaggioli@suse.com, joao.m.martins@oracle.com, jon.grimm@amd.com,
 santosh.Shukla@amd.com
Subject: Re: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Message-ID: <ZIA7x5cYNr99mhzd@redhat.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 06, 2023 at 09:49:37PM -0500, Suravee Suthikulpanit wrote:
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

This is unsafe - smbios_set_defaults is only intended to be called
once. Calling it twice leads to a SEGV due to double-free

$  ./build/qemu-system-x86_64 -machine pc,smbios-entry-point-type=64 -smbios file=/tmp/smbios_entry_point
Segmentation fault (core dumped)

IMHO we should just not do this refactoring. The existing duplicated
code is not a significant burden, and thus is better than having to
workaround calling pc_machine_set_smbios_ep too early in startup.

> 
> There is no functional change.
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
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


