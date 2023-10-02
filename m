Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89F7B5636
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:24:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKlH-00052S-Db; Mon, 02 Oct 2023 11:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKlE-00052I-Cu
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKl9-0000NL-Bi
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696260176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aFJ+7l4ei6WeSC8UFpDGAB+WNUvodNJZNpdPVoG7ig=;
 b=YDT0rDL9h0GK9Oc+eXlcJcPERj7Io4+e3cIL2b+b5r2ulzwFEEJ5GPSpMcGpGa6VdPQIK+
 d8/fL0qAlcMYFMp+4RVcpHPolQfMr485eu4qjvcePf0fWBBe1BLC/j1D+c12Zl9hxWchsu
 kF0uedNz8xwF7r7y379THgibdLP+nmQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-mhFcSkz2P8adi8BTvoCxzA-1; Mon, 02 Oct 2023 11:22:55 -0400
X-MC-Unique: mhFcSkz2P8adi8BTvoCxzA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65af3fd7a55so203890976d6.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 08:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696260175; x=1696864975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2aFJ+7l4ei6WeSC8UFpDGAB+WNUvodNJZNpdPVoG7ig=;
 b=BAzQ1/gUg3kCoGjKDUfryy5pDave0L3qhm9iWQ+jHuwBowserBWkcRc3+qFIgnIPl2
 lC2I57loLLCKRQRdAwGI8Sc/WeRgBC8LZ9rVLg3pRb/kJPAwIl2hg8TIgxs+jv6TgEuL
 MBhVe08qJhPl/IHMd02Qh8KLcScn/hauX+cQxNpnS1PR6C0+DsAqCjKoKA3+ufBsMSqi
 7nZNefOvtjTz1uEAvJd/QnhJj+UOKWOnrSBCu9QmrIap6td1Y35kQYCt7u4v7FBlGJ9F
 tvk1TMfXLtMKMC0ZecLPlz6ivotR4x+lNR2RaeZY9aZzyWEd+0zgwdqeeNEMfh5xcPxb
 RA+Q==
X-Gm-Message-State: AOJu0YxVAdWKXOyYYC+VBeCKRtw7gaDcRV6jQ9aFzSNpHWwVrRCnlOH9
 3EzzKCvkOKWyMdhGZSkO6bpTlxs7rXLOjd65UqGv00LMdJEvDs0GoQ+cPaFVQ7Su8jtmzu+GQW0
 KW1v/aBOqdnXiJTA=
X-Received: by 2002:a0c:b45e:0:b0:656:3c00:dc92 with SMTP id
 e30-20020a0cb45e000000b006563c00dc92mr8558123qvf.31.1696260175129; 
 Mon, 02 Oct 2023 08:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2NiKFZ24m+l0EH57Vulcqn1vWx4zX/BDymKE0+KC4sck302kezBwPXYm1CnPoWk0Gi6btCw==
X-Received: by 2002:a0c:b45e:0:b0:656:3c00:dc92 with SMTP id
 e30-20020a0cb45e000000b006563c00dc92mr8558097qvf.31.1696260174740; 
 Mon, 02 Oct 2023 08:22:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a0ccd0b000000b0065aff6b49afsm7069420qvm.110.2023.10.02.08.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:22:54 -0700 (PDT)
Message-ID: <2380b011-eee6-252b-f523-9025cfdb16b6@redhat.com>
Date: Mon, 2 Oct 2023 17:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 02/15] hw/pci: Refactor pci_device_iommu_address_space()
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
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-3-joao.m.martins@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230622214845.3980-3-joao.m.martins@oracle.com>
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
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Refactor pci_device_iommu_address_space() and move the
> code that fetches the device bus and iommu bus into its
> own private helper pci_device_get_iommu_bus_devfn().
> 
> This is in preparation to introduce pci_device_iommu_get_attr()
> which will need to use it too.

Where is this routine used ?

Thanks,

C.


> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> [joao: Commit message, and better splitting]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> Splitted from v1:
> https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
> ---
>   hw/pci/pci.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4e32c09e81d6..90ae92a43d85 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2632,8 +2632,8 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>           assert(conventional || pcie || cxl);
>       }
>   }
> -
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **pdevbus,
> +                                           PCIBus **pbus, uint8_t *pdevfn)
>   {
>       PCIBus *bus = pci_get_bus(dev);
>       PCIBus *iommu_bus = bus;
> @@ -2686,6 +2686,18 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>   
>           iommu_bus = parent_bus;
>       }
> +
> +    *pdevbus = bus;
> +    *pbus = iommu_bus;
> +    *pdevfn = devfn;
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus, *iommu_bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
>       if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
>           if (iommu_bus->iommu_fn) {
>              return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);


