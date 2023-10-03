Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DA7B68F9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneWM-00070n-Ku; Tue, 03 Oct 2023 08:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneWG-00070b-AQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneWE-0007AJ-Lq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWx3ew8HnV9bynxAEyI0N7u2urcO+wLsiwMh3WVsW1k=;
 b=U6DE7RPawarRCNsWpJr4CQfgHfMs/dhJeP88aMhdZoUdggSGDbfR1fiDV7m2r3yaNibSdn
 FaAYBMMn3k3iW/yE+og8mV2R5fzqDbEBcXa5ARRgldsomsb97DOO5DAmWKdqJW5Qm7td22
 aMDybK2wfRA3X5wNU7uJvKZBvVzG+5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-IzsQfB3kOdK5FFyCa8Tb0w-1; Tue, 03 Oct 2023 08:28:52 -0400
X-MC-Unique: IzsQfB3kOdK5FFyCa8Tb0w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405334b0873so6011195e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336131; x=1696940931;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWx3ew8HnV9bynxAEyI0N7u2urcO+wLsiwMh3WVsW1k=;
 b=wtx1UQp0kvpdN4tTlE0eItcOVTCaRXBif7gxlWaDURyhIL2yljMk+bujSd79Ywl8NB
 k/3u/YqrVFpTTXlQS21jhZ8taobdwORX1x4q8nVhG+RasOmMCJ/VNjkJJ3AhqG+FRhk5
 rfK9JFn2cHsvKvCH2bylmpN+vlDY1b8qs7pCErkExXgf6BTufg3jY5tB35DgCcJ6SjKW
 zdn+wmTR3GPnBcSGCavGDo3eLJc/chnizsBeD4o8ABLvdf8W5WDdA1SEKzrz0cd6Bxnx
 g5CqguYm91N4YOTV6o7ySE97sP3SJ2ySYaxjNm1yIQVxNTTggrGAIl41kIcU0mHIh7o8
 REXw==
X-Gm-Message-State: AOJu0YwLsFNV5kszlhLwnLSZeEl2PyuDhUqNvK6afAYmzjlprJRtsogE
 WNtLobtC5uFBUwgY3T9lBrxvYAP5bwYDQv56JLsGjEwomF/UIjgYchGKyrtaIr2MilHr4v0G5uH
 2jFWr7W9szZRqh7g=
X-Received: by 2002:a05:600c:3d99:b0:406:5396:9f9e with SMTP id
 bi25-20020a05600c3d9900b0040653969f9emr12271481wmb.32.1696336131216; 
 Tue, 03 Oct 2023 05:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAqBiCVBG44m5ogq6gLFYcC+R23re35aO+H4Dsqul0A0WMeMUzF9pbWhwBuOrIO4lkaf/ysQ==
X-Received: by 2002:a05:600c:3d99:b0:406:5396:9f9e with SMTP id
 bi25-20020a05600c3d9900b0040653969f9emr12271463wmb.32.1696336130783; 
 Tue, 03 Oct 2023 05:28:50 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c205100b004064ac107cfsm1193066wmg.39.2023.10.03.05.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:28:50 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:28:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
Message-ID: <20231003082821-mutt-send-email-mst@kernel.org>
References: <20231003054306.4372-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003054306.4372-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Oct 03, 2023 at 11:13:06AM +0530, Ani Sinha wrote:
> Code changes that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds
> bugs that are difficult to catch.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to move with the rest of these changes.


> ---
>  hw/i386/acpi-microvm.c | 4 ++--
>  hw/i386/intel_iommu.c  | 8 ++++----
>  hw/i386/pc.c           | 1 -
>  hw/i386/x86.c          | 2 --
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> changelog:
> v2: addressed suggestion from mst.
> 
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index a075360d85..6ddcfb0419 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>  
>      bus = sysbus_get_default();
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
> -        DeviceState *dev = kid->child;
> -        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
> +        Object *obj = object_dynamic_cast(OBJECT(kid->child),
> +                                          TYPE_VIRTIO_MMIO);
>  
>          if (obj) {
>              VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..2c832ab68b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> -    hwaddr size, remain;
> +    hwaddr total, remain;
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> @@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = remain = end - start + 1;
> +    total = remain = end - start + 1;
>  
>      while (remain >= VTD_PAGE_SIZE) {
>          IOMMUTLBEvent event;
> @@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                               VTD_PCI_SLOT(as->devfn),
>                               VTD_PCI_FUNC(as->devfn),
> -                             n->start, size);
> +                             n->start, total);
>  
>      map.iova = n->start;
> -    map.size = size - 1; /* Inclusive */
> +    map.size = total - 1; /* Inclusive */
>      iova_tree_remove(as->iova_tree, map);
>  }
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3db0743f31..e7a233e886 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      if (machine->device_memory) {
>          uint64_t *val = g_malloc(sizeof(*val));
> -        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>          uint64_t res_mem_end = machine->device_memory->base;
>  
>          if (!pcmc->broken_reserved_end) {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f034df8bf6..b3d054889b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
> -        MachineState *ms = MACHINE(x86ms);
> -
>          x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> -- 
> 2.42.0


