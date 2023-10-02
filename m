Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4E7B5637
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:24:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKlq-0005Pe-93; Mon, 02 Oct 2023 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKlo-0005P7-Bh
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKlm-0000Rt-SR
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696260214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rz6tLNbgb8jZYWjfQRKVstnNq9q6iaUL2LSQrhTU20s=;
 b=Gu90DapRwxobRUoVRzag0500AJ3WiY+AJeFa2NpGpHurM41YdbdjkDzp6579YlSN1lXGIr
 Qn0ZYAvujO4TlR6Aj2bJkSQ3sya9kIrdkz/pz6H9h+I47ssrGzaoiA+ey0zzlGPOIMb14w
 b4HpLS389z6C0EI3oFU5fvdxpsbjhvc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186--urSuXnqPnu-C4VCeewq2w-1; Mon, 02 Oct 2023 11:23:33 -0400
X-MC-Unique: -urSuXnqPnu-C4VCeewq2w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65b08994e15so32392316d6.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696260212; x=1696865012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rz6tLNbgb8jZYWjfQRKVstnNq9q6iaUL2LSQrhTU20s=;
 b=FQMOq7F9b7d6iXFwQU88c4sjmO+s2gph70Q0ioKeAmOLpcpFP/kEshvOiahaKF7eU5
 dyXZfJLelAprL6hf7WTVArCsQ3PZlruhmkvQolguY3STMCC1Lgwn+4a+w2IEE3GnHZUF
 ABPpnwTqG7o3mXN6A6ZoLm8NMn5Ljz10eVyMxPYI0J/fxOoBXFqArdePCTf4EWeksLx3
 PHQZ2qP7CmdyfSE6NaeJDhTyn1/wSAVHWxTVKrqkIqWJ4kBitrvjDkiH4QAVbuPXRDtD
 l5I/wdS6Y7yuxOa/qCH9Qu/SZVVft8YW6+Uh4BccglwJ6edJ1YxFxFj9R/nWnNHU51RV
 l7LA==
X-Gm-Message-State: AOJu0YzURIeWu4aWOYTUjr9LpGL2aLsN54+1Zd2cUP/Te4MFBqEvLVtT
 mqnTBndDjZQQ79WhzfBONyMvxMdu4nCaV///TY2lqMdIvBS/NH0/qmjXWKh65tf2uQgnWFWtnLu
 O/KumAI3A+kgaF14=
X-Received: by 2002:a0c:e451:0:b0:65b:2cca:4196 with SMTP id
 d17-20020a0ce451000000b0065b2cca4196mr12533674qvm.29.1696260212711; 
 Mon, 02 Oct 2023 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgMHf1dfGfWzoqlW1N8KRqgOtD9fUQSlM06m55V02tg9yfarUKiYOC0PJAgjo/95FAlSWpMw==
X-Received: by 2002:a0c:e451:0:b0:65b:2cca:4196 with SMTP id
 d17-20020a0ce451000000b0065b2cca4196mr12533650qvm.29.1696260212477; 
 Mon, 02 Oct 2023 08:23:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a0cf28c000000b0065d0a4262e0sm3652379qvl.70.2023.10.02.08.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:23:32 -0700 (PDT)
Message-ID: <2f279132-7d76-835e-c662-baa0c7f8de58@redhat.com>
Date: Mon, 2 Oct 2023 17:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 06/15] intel-iommu: Implement get_attr() method
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-7-joao.m.martins@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230622214845.3980-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/22/23 23:48, Joao Martins wrote:
> Implement IOMMU MR get_attr() method and use the dma_translation
> property to report the IOMMU_ATTR_DMA_TRANSLATION attribute.
> Additionally add the necessary get_iommu_attr into the PCIIOMMUOps to
> support pci_device_iommu_get_attr().
> 
> The callback in there acts as a IOMMU-specific address space walker
> which will call get_attr in the IOMMUMemoryRegion backing the device to
> fetch the desired attribute.

This looks like two patches to me and the previous should be merged with
the one introducing vtd_iommu_get_attr().

Thanks,

C.

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1606d1b952d0..ed2a46e008df 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3861,6 +3861,29 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>       return;
>   }
>   
> +static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
> +                              enum IOMMUMemoryRegionAttr attr, void *data)
> +{
> +    VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    int ret = 0;
> +
> +    switch (attr) {
> +    case IOMMU_ATTR_DMA_TRANSLATION:
> +    {
> +        bool *enabled = (bool *)(uintptr_t) data;
> +
> +        *enabled = s->dma_translation;
> +        break;
> +    }
> +    default:
> +        ret = -EINVAL;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
>   /* Do the initialization. It will also be called when reset, so pay
>    * attention when adding new initialization stuff.
>    */
> @@ -4032,8 +4055,24 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>       return &vtd_as->as;
>   }
>   
> +static int vtd_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
> +                              enum IOMMUMemoryRegionAttr attr, void *data)
> +{
> +    IntelIOMMUState *s = opaque;
> +    VTDAddressSpace *vtd_as;
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
> +    if (!vtd_as)
> +	return -EINVAL;
> +
> +    return memory_region_iommu_get_attr(&vtd_as->iommu, attr, data);
> +}
> +
>   static PCIIOMMUOps vtd_iommu_ops = {
>       .get_address_space = vtd_host_dma_iommu,
> +    .get_iommu_attr = vtd_get_iommu_attr,
>   };
>   
>   static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> @@ -4197,6 +4236,7 @@ static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
>       imrc->translate = vtd_iommu_translate;
>       imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
>       imrc->replay = vtd_iommu_replay;
> +    imrc->get_attr = vtd_iommu_get_attr;
>   }
>   
>   static const TypeInfo vtd_iommu_memory_region_info = {


