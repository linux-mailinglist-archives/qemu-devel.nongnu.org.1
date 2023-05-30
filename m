Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695C717071
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 00:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q47Su-0007f0-B5; Tue, 30 May 2023 18:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q47So-0007eb-NL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 18:05:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q47Se-0005eU-Hr
 for qemu-devel@nongnu.org; Tue, 30 May 2023 18:05:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30aa76048fbso3539083f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685484297; x=1688076297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUmT6vZ2zrai/GGSrWQD4roADO/JjerDQPKVZ5nXPbs=;
 b=d+EJ+djoezOpzvqEBiidWXoznst/KxAiTlQhcjELW1yKSlAwcsZBzppNDnwUmXnj78
 toagVPOcLdWx7Ta4vEgGLwwwDB58QF4bG9lmDkpLcjn1eNh8l4CQWNlWW3trnRjVRsk0
 BtxlSWj3Y6czlp2Awus4LA6B6B9pZ+74g6mK6TQrVuXTSp3MiNKusZs+2hvaxJ62TM7Q
 WJgzyq0Ve95svFuKwAAK+fsc/U4lVsAMF25ZHQW9Kcqm6SibIBsT18ESntxvK51+BgRj
 WDq2MO/cpmK4uYkkoB3DDX825n2bjhtsee4/lsymtAMo6xMNJ/Td02VnNx1Pn4rp1nu+
 QcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685484297; x=1688076297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HUmT6vZ2zrai/GGSrWQD4roADO/JjerDQPKVZ5nXPbs=;
 b=VBoxs+Y/iSJ+wv9gkWSc7QzpiTVwgkATBMjs0eX08oPCLIN5vsVWhWw8vNgoUIMPbI
 Isom0xxsjL7wwwmRcEffQQjl3KeiowOLbWTerdVWuBZznymXKTaEQrks0UHr1oyaBEG2
 atdXMhIFL8huR4rHGdStiRdZT9lv2oJF4AsIaBekxVth+T6/thdTz5evAsKradh0jplA
 aPzwaa0FgoQ8GzFvAuWZaL1MkE/2ywTpmQmHXtQSngW3YZjq9k2cYCe3SVGi9UeezsIV
 SzC2T7Tq3Xw4YIfYQI2li4K78cbhqYxrEqLKSV/Kw5v347I9lcuxXVCLeov/6X5UvWMH
 U+Fg==
X-Gm-Message-State: AC+VfDxiDXqLdCL+nQAw084Q+Ryy9unRaxkX7rJqLklEnxmdI/rzfsiV
 Q1u5Hue8R3iz7iAPGIjuftV9TQ==
X-Google-Smtp-Source: ACHHUZ4ei7C7GwDyBlXM5xVfvwU0UFb6gbQw2JX4e1dC4pL4+0EFgV4DF8H4KLsB+o+izE2g8woPgg==
X-Received: by 2002:a5d:4c8f:0:b0:30a:ecf3:c9e9 with SMTP id
 z15-20020a5d4c8f000000b0030aecf3c9e9mr2761122wrs.5.1685484297157; 
 Tue, 30 May 2023 15:04:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c210f00b003f42d8dd7d1sm22262127wml.7.2023.05.30.15.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 15:04:56 -0700 (PDT)
Message-ID: <ad557a25-0cca-518e-9d0f-f69f8bbd98c6@linaro.org>
Date: Wed, 31 May 2023 00:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-2-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530175937.24202-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Hi Joao,

On 30/5/23 19:59, Joao Martins wrote:
> Rename pci_device_iommu_address_space() into pci_device_iommu_info().
> In the new function return a new type PCIAddressSpace that encapsulates
> the AddressSpace pointer that originally was returned.
> 
> The new type is added in preparation to expanding it to include the IOMMU
> memory region as a new field, such that we are able to fetch attributes of
> the vIOMMU e.g. at vfio migration setup.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/pci/pci.c         |  9 ++++++---
>   include/hw/pci/pci.h | 21 ++++++++++++++++++++-

Please consider using scripts/git.orderfile.

>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1cc7c89036b5..ecf8a543aa77 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2633,11 +2633,12 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>       }
>   }
>   
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
>   {

This function is PCI specific, ...

>   }
>   
>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6d0574a2999..9ffaf47fe2ab 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -363,9 +363,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>   
>   void pci_device_deassert_intx(PCIDevice *dev);
>   
> +typedef struct PCIAddressSpace {
> +    AddressSpace *as;

... but here I fail to understand what is PCI specific in this
structure. You are just trying to an AS with a IOMMU MR, right?

> +} PCIAddressSpace;
> +
>   typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
> +static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
> +{
> +    PCIAddressSpace ret = { .as = as };
> +
> +    return ret;
> +}
> +static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
> +{
> +    return pci_as.as;
> +}
> +
> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
> +static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    return pci_as_to_as(pci_device_iommu_info(dev));
> +}
>   
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>   
>   pcibus_t pci_bar_address(PCIDevice *d,


