Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDC7BB403
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogrq-0006VQ-QZ; Fri, 06 Oct 2023 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogrj-0006EF-Do
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogrh-000279-Fj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696583480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU72WPVbwEohSLYx07GbogAebiP94FcRJU9JD1+0nXc=;
 b=ayQfUAVJUp2UjfHkmuhIRZP+BV6OscByyj1oV+9zRCw2tgx84MyJ1BZRSxQcF7BZso37Nb
 w/AvE7XsdGcl5RrIXq9A67ehxvsL8KOpS/mSV1Mbx98NDsHDocu0QOKJB8d5iRJbDxeQbQ
 OmUQMZrkUWqccl8Ni8kS1JAzkGxEEGo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-OsKCFdXUN1ySt0SkjOu4uQ-1; Fri, 06 Oct 2023 05:11:14 -0400
X-MC-Unique: OsKCFdXUN1ySt0SkjOu4uQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77409676d7dso207286085a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696583473; x=1697188273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XU72WPVbwEohSLYx07GbogAebiP94FcRJU9JD1+0nXc=;
 b=XgBm/VWJ6fRM2FO6XJQcGzyTJbdqtm7eYYBO9DmdKYu3bxgiOU0yNujL6TsWn6qy6h
 pD/K1g1cCUW0vDdVhJx5bdYz4/ddztfrybYDKfzKs/Kd+JhTyJofecqSVt3wDMhTPsl4
 arBS2GI7uH+iENoyzvQs1KtCYzkiBffCsg/BFchv8ZTodPXCQPhxRSByfOzjBqrpIJuL
 8iVetLf5/1oms90xll61sH88H3kTpM22SBps1dJXJqlzdCjXDJBk6U8PHxb/t6SCpOPG
 0LH61+nu/zBxx2EuJ4kfXyXP1ch0bw7J+UxPaNTMwn66/5SZhL68LJ3o7f+G6vMsr01S
 pQCw==
X-Gm-Message-State: AOJu0YxfL85SV6NgbQvHQebPYEtvp8aVNviWEG0kcNoKPbqZpJ4kc9Lx
 mKr1EMeO+K0inYxC0KBlG88hXLPX5aOxq+d1KYf0m2lw7XRPBt8oVuVKXHGGyQF3llJL19Yyu+A
 DS/4wQUHzhiKPrcc=
X-Received: by 2002:ae9:e645:0:b0:76c:9884:4dce with SMTP id
 x5-20020ae9e645000000b0076c98844dcemr7176160qkl.63.1696583473504; 
 Fri, 06 Oct 2023 02:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD7xSR5K5d4oNSgID0Gl29hgMoPu/vYv/+OpgWt2vk9uEr//PUB4Sby9DAASYSG9jkZYO0sA==
X-Received: by 2002:ae9:e645:0:b0:76c:9884:4dce with SMTP id
 x5-20020ae9e645000000b0076c98844dcemr7176137qkl.63.1696583473243; 
 Fri, 06 Oct 2023 02:11:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a288100b0076768dfe53esm1148509qkp.105.2023.10.06.02.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:11:12 -0700 (PDT)
Message-ID: <609c41ef-ee1e-1996-9434-c3bc99889d62@redhat.com>
Date: Fri, 6 Oct 2023 11:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-3-joao.m.martins@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230622214845.3980-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Joao,

On 6/22/23 23:48, Joao Martins wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Refactor pci_device_iommu_address_space() and move the
> code that fetches the device bus and iommu bus into its
> own private helper pci_device_get_iommu_bus_devfn().
> 
> This is in preparation to introduce pci_device_iommu_get_attr()
> which will need to use it too.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> [joao: Commit message, and better splitting]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> Splitted from v1:
> https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
> ---
>  hw/pci/pci.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4e32c09e81d6..90ae92a43d85 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2632,8 +2632,8 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>          assert(conventional || pcie || cxl);
>      }
>  }
> -
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **pdevbus,
> +                                           PCIBus **pbus, uint8_t *pdevfn)
actually I would rename pbus arg to match what it is, ie the iommu_bus
also not sure the 'p' prefix is needed

By the way can the iommu_bus be null? I see it initialized to
pci_get_bus(dev);

What does characterize an iommu bus? It must have either iommu_fn or
iommu_ops set, right?

Eric

>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> @@ -2686,6 +2686,18 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
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
>      if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
>          if (iommu_bus->iommu_fn) {
>             return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);


