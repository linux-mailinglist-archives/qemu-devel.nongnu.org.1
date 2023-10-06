Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A7E7BB38C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogZa-0007fT-Cp; Fri, 06 Oct 2023 04:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogZX-0007f2-Hn
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogZV-0005LJ-Re
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696582353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7A/ElYGDVGTZwh7spRLEk0QOZ5c31DOxC/dh9PPkUs=;
 b=OEvMy2LBCenx81voPMgMu1MeP3v2HLwc3ZIrwCOo/vONyronYhuCxU+kDiLif2gztdos6k
 t0uVF815ZMaxS0tQ8GgB2T6bSZUFJNZYgTe0xKGrUpUeBHHVraZE/F/kXJobGwj+xMVgav
 h+BikIv73Jyt0ApPicizRk9rPGTvP3g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-MjhfyXaiMPyXsxs5F0dmLA-1; Fri, 06 Oct 2023 04:52:31 -0400
X-MC-Unique: MjhfyXaiMPyXsxs5F0dmLA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b0249818dso19495246d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696582351; x=1697187151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7A/ElYGDVGTZwh7spRLEk0QOZ5c31DOxC/dh9PPkUs=;
 b=CeadPbMhAhN0yaXoduqjVpZTaYxVMhV+FeVr9NhxUx1zlp6dnIkqRWhkjnly4p72SC
 z1dzqEUnnGk9szYzGlbXNFhlcWey/yDBZ4eWVMwuYtaL9DpsgrTttCSeKXXbIU2u1uHm
 /c65AD7sHfORhOf/1IQUjrgWgE4d3JCHAOX8zfnPkHHD0EF18ui9JivXD/W5yfjGAW94
 LHaiPT5r+5wcTDLRXrymouLNCwQXtMb9PUDq8fVbw/4Kw1btYA9seLvnmMHYI+twq1Zv
 JcLEZt5/AhfmBblcnBbr3n0v0Px4+oeTNfQXbHBRJp7GvwwrMjVlNP+w51etHPnCzqV3
 0Zdw==
X-Gm-Message-State: AOJu0YzNdodKBu00bKzC651Rh6Y5z9gaE7RJPikpR9lMs8qRm+JDJnQZ
 7w0MiiLmO0GuYJ30SBRUH4O2htraDne6r1DK6SVNC8v2aSpVakNYm9k8tWMXDogaJ4ivgR90iLn
 3ytTIZiWqkFBMhu8=
X-Received: by 2002:a05:6214:1907:b0:65b:1ad4:ca7e with SMTP id
 er7-20020a056214190700b0065b1ad4ca7emr6875822qvb.56.1696582351466; 
 Fri, 06 Oct 2023 01:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7u8Txd6Sghh6/Sp6cX++YiMkO06+5W00/bn4GhWdEP8y8fAhyY4ki9pDDO4iqU6AbKgN7Q==
X-Received: by 2002:a05:6214:1907:b0:65b:1ad4:ca7e with SMTP id
 er7-20020a056214190700b0065b1ad4ca7emr6875800qvb.56.1696582351184; 
 Fri, 06 Oct 2023 01:52:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 vv8-20020a05620a562800b007676f3859fasm1146403qkn.30.2023.10.06.01.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:52:30 -0700 (PDT)
Message-ID: <40b3bd8a-8c59-e61a-14d1-a45dba95a235@redhat.com>
Date: Fri, 6 Oct 2023 10:52:26 +0200
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

you may add:
no functional change intended.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> [joao: Commit message, and better splitting]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

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


