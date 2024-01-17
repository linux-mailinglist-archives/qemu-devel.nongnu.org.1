Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389A8303C0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:39:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3KE-0004WS-P2; Wed, 17 Jan 2024 05:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3K8-0004Jz-G6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3K6-0004Bg-GJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487945;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIe+gNmEdxOf+u95EotlU01P40O0/9WLK/7Xbp89jrw=;
 b=GUkB4uWUHUxJrhZKhcVBT94b5JP5JBeh2IGHT/Vbn9gZUOe8gGRQg0P+qVLJAb5Dd62fpU
 b6rCdSOpIVcl98tDSw1or0aIwv63k1iFIqY5oZg62IVsspQZbUtjze9HsiHajZYN6V44e/
 I6m9CzenylbU7cZlj5qXrIXL0dimUJA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-HC0UGyqoOnKgEN2sxDh5ow-1; Wed, 17 Jan 2024 05:39:00 -0500
X-MC-Unique: HC0UGyqoOnKgEN2sxDh5ow-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7bb454e1d63so1184592439f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487939; x=1706092739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WIe+gNmEdxOf+u95EotlU01P40O0/9WLK/7Xbp89jrw=;
 b=xDdo/85p4mieEJ8jc7iGLbbYZ0rEvUNJiJY3y51HFXOj058JXvgRMs5wf9luTiXIc7
 AG+6gixddo06iSbQsswuYIbv3VcuEh6936ePK8gMhbpGMOQP60sguKIlYLj/X/NenmkQ
 wsTUgAY1g3sbouoAexxmrLQ99mDI6qW1kvQvAWI1pxHbgIWGTk9WlljEkQnnkulqNVeF
 bhrgk3dyfxnguPgCAntTmBgjDb6nFlufw/cbSknD9q9jMZjNweWykHMmWUrawkw26JFP
 GhypETngWguwd4Lw4528zqIwyu+nhs51YFoMgBqQfWlNrseOaNgX0bT+H4/J8ssT7Dr2
 AQyg==
X-Gm-Message-State: AOJu0YzyqeRAAgN1+FBfhPSi1GH7WNfHDHYCtiiow277Uw9IR5SpfSyS
 d9EIsCO1aOWYhiZdrFTUK12rQXT+AmrY6Q3PDQyH+b9IacWsJ3WBEayysiZXwLq61wj0/VDkktF
 60OJZJ4RMs0i/DH7T/rric2w=
X-Received: by 2002:a05:6602:160b:b0:7be:d959:68df with SMTP id
 x11-20020a056602160b00b007bed95968dfmr13511966iow.32.1705487939280; 
 Wed, 17 Jan 2024 02:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHaH1erkQYN4bf+1lqJAWHZ5RNY9GlvJaSjfiSzA8e3z+V222h8yT/vEQtM0c2vRdyPWyUOw==
X-Received: by 2002:a05:6602:160b:b0:7be:d959:68df with SMTP id
 x11-20020a056602160b00b007bed95968dfmr13511958iow.32.1705487938998; 
 Wed, 17 Jan 2024 02:38:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y63-20020a029545000000b0046e77bd393dsm361180jah.144.2024.01.17.02.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:38:58 -0800 (PST)
Message-ID: <55196d62-f4a1-4266-93f4-774ebfb22be2@redhat.com>
Date: Wed, 17 Jan 2024 11:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] intel_iommu: Reset vIOMMU at the last stage of system
 reset
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, YangHang Liu <yanghliu@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-5-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 1/17/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> We got report from Yanghang Liu on an unexpected host DMA error when system
> resets with VFIO attached to vIOMMU in the VM context.  Alex Williamson
> quickly spot that there can be ordering issues on resets.  A further test
> verified that the issue is indeed caused by such wrong ordering.
nit: not sure the commit msg should contain people info (cover letter
does it already + credits below)
>
> vIOMMU is a fundamentally infrustructural device, its reset is currently

infrastructural

> problematic because no ordering is guaranteed against other PCI devices
> which may DMA through the vIOMMU device.
>
> The reset order is tricky, not only because it's current representation as
s/it's/its
> a normal "-device" (so it kind of follow the qdev tree depth-first reset,
> but at a wrong place in the qtree; ideally it should be the parent
> somewhere for all pci buses, or just part of pci host bridge), but also
> because customized device reset hooks registered over the system reset
> framework, so that the ordering of the vIOMMU reset is not guaranteed.
>
> For example, VFIO can register its reset hook with vfio_reset_handler() if
> some device does not support FLR.  That will not so far follow the
> depth-first travelsal reset mechanism provided by QEMU reset framework.
traversal
>
> To remedy both of the issues with limited code changes, leverage the newly
> introduced reset stage framework to reset vIOMMUs at the last stage of the
> rest devices.  More information can be found in the comments in the patch,
> which I decided to persist even with the code to make the problem even
> clearer (with potential TODOs for the future, if possible).
>
> Buglink: https://issues.redhat.com/browse/RHEL-7188
> Analyzed-by: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: YangHang Liu <yanghliu@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 54 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8b467cbbd2..5a8fbcad7a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/reset.h"
>  #include "hw/i386/apic_internal.h"
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
> @@ -4086,7 +4087,7 @@ static void vtd_init(IntelIOMMUState *s)
>  /* Should not reset address_spaces when reset because devices will still use
>   * the address space they got at first (won't ask the bus again).
>   */
> -static void vtd_reset(DeviceState *dev)
> +static void vtd_reset(void *dev)
>  {
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>  
> @@ -4242,7 +4243,6 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
>  
> -    dc->reset = vtd_reset;
>      dc->vmsd = &vtd_vmstate;
>      device_class_set_props(dc, vtd_properties);
>      dc->hotpluggable = false;
> @@ -4254,10 +4254,60 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
>  }
>  
> +static void vtd_instance_init(Object *obj)
> +{
> +    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(obj);
> +
> +    /*
> +     * vIOMMU reset may require proper ordering with other devices.  There
> +     * are two complexities so that normal DeviceState.reset() may not
> +     * work properly for vIOMMUs:
> +     *
> +     * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
> +     *     (reference: resettable_cold_reset_fn())
> +     *
> +     *     Currently, vIOMMU devices are created as normal '-device'
> +     *     cmdlines.  It means in many ways it has the same attributes with
s/with/as
> +     *     most of the rest devices, even if the rest devices should
s/rest/other
> +     *     logically be under control of the vIOMMU unit.
> +     *
> +     *     One side effect of it is vIOMMU devices will be currently put
> +     *     randomly under qdev tree hierarchy, which is the source of
> +     *     device reset ordering in current QEMU (depth-first traversal).
> +     *     It means vIOMMU now can be reset before some devices.  For fully
> +     *     emulated devices that's not a problem, because the traversal
> +     *     holds BQL for the whole process.  However it is a problem if DMA
> +     *     can happen without BQL, like VFIO, vDPA or remote device process.
> +     *
> +     *     TODO: one ideal solution can be that we make vIOMMU the parent
> +     *     of the whole pci host bridge.  Hence vIOMMU can be reset after
> +     *     all the devices are reset and quiesced.
in hw/pci/pci.c there is also the info iommu_bus? When resetting a pci
device know whether it is attached to a viommu. I don't know if we could
plug the reset priority mechanism at this level.
> +     *
> +     * (2) Some devices register its own reset functions
> +     *
> +     *     Even if above issue solved, if devices register its own reset
s/its/their
> +     *     functions for some reason via QEMU reset hooks, vIOMMU can still
> +     *     be reset before the device. One example is vfio_reset_handler()
> +     *     where FLR is not supported on the device.
> +     *
> +     *     TODO: merge relevant reset functions into the device tree reset
> +     *     framework.
> +     *
> +     * Neither of the above TODO may be trivial.  To make it work for now,
> +     * leverage reset stages and reset vIOMMU always at latter stage of the
> +     * default.  It means it needs to be reset after at least:
> +     *
> +     *   - resettable_cold_reset_fn(): machine qdev tree reset
> +     *   - vfio_reset_handler():       VFIO reset for !FLR
> +     */
> +    qemu_register_reset_one(vtd_reset, s, false, 1);
introducing enum values may be better ( just as we have for migration prio)
> +}
> +
>  static const TypeInfo vtd_info = {
>      .name          = TYPE_INTEL_IOMMU_DEVICE,
>      .parent        = TYPE_X86_IOMMU_DEVICE,
>      .instance_size = sizeof(IntelIOMMUState),
> +    .instance_init = vtd_instance_init,
>      .class_init    = vtd_class_init,
>  };
>  
Thanks

Eric


