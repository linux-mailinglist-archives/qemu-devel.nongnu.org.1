Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33779E888
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPVK-0008Ck-J1; Wed, 13 Sep 2023 09:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPVH-0008Bb-B2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPVE-0006AA-S4
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694610115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYNreKuk0giHOCMhnF6SwgdipUdGOF8LAlJfpbKMjKo=;
 b=fSznql9hQof3H/lBs9kVF73X9SkiFVYswLLYLMcbstxkvRZysb9o2RbVXe70Eg0t8ets99
 CIOYDHJwi7DnXPEFRWSD0TCoW6xUNTrheVc9lYsywc+TNP2enefyLutdbt/4NE+7Y3Do1r
 0obba1frQpQxir5feGRX3WQRcdR9CZo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-tgv4KeKONQSCp9rtNWLRbw-1; Wed, 13 Sep 2023 09:01:53 -0400
X-MC-Unique: tgv4KeKONQSCp9rtNWLRbw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-770ef1f4511so545317085a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 06:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694610112; x=1695214912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYNreKuk0giHOCMhnF6SwgdipUdGOF8LAlJfpbKMjKo=;
 b=TVkCUYwFqvc+smKthaFXb4zg85/5W2THfKaCICUpuVmQLYIvZOX1nnoh1/5Vn4O6SZ
 pK1VeQAbSWGGYYpkdtmXc0T1ZG6WLjTkMOjUvXlOLqYxOdkj56/U+SFXbhLfz7GtIoh0
 lSrIO3QyLuxgNnApVX7uW7QIAr1nd13oRBkgP4L7EsJJeEVUAfBrzhc+HzeN8KeCFOTk
 s9qOmil0KeMTvP2VpkxxivY/hD58zxFN1BeazemFlzYlbhBGd25bW5M1Isfd+9MLQm51
 8IhSKjUIMstD/sQOHi5NHgiBgGdP3dBX8r+xM53pe6Obk4kZsq08OGeHUGSqfXbZN0p+
 p2sQ==
X-Gm-Message-State: AOJu0Yx6w9GFIDYLjGykp6jsPkn1B+sSfVdWR3fpMTP/lyaM5dZHCklr
 FkEARxe0xvdVKpH/VyRMaX17LmEPUeO5iVlFfnneALSPoQgDMlh/Ul3/6EGyHtUKhrwEYJQlK+g
 gY1/IzKvLV6dfIXs=
X-Received: by 2002:a05:620a:404b:b0:76f:13ba:ca40 with SMTP id
 i11-20020a05620a404b00b0076f13baca40mr3041369qko.6.1694610112125; 
 Wed, 13 Sep 2023 06:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHJVAEcqqHOtu/kpuRvefGLobpWPkd8SPX3J32U+kDej7Ip3nWOsWa2tbsygNZi+O+fBGHHg==
X-Received: by 2002:a05:620a:404b:b0:76f:13ba:ca40 with SMTP id
 i11-20020a05620a404b00b0076f13baca40mr3041337qko.6.1694610111840; 
 Wed, 13 Sep 2023 06:01:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a16b000b0076d0312b8basm3844414qkj.131.2023.09.13.06.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 06:01:51 -0700 (PDT)
Message-ID: <b5ad656f-9b8e-ab39-7ee1-d844f464911b@redhat.com>
Date: Wed, 13 Sep 2023 15:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/12] virtio-iommu: Rename reserved_regions into
 prop_resv_regions
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-5-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230913080423.523953-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/13/23 10:01, Eric Auger wrote:
> Rename VirtIOIOMMU (nb_)reserved_regions fields with the "prop_" prefix
> to highlight those fields are set through a property, at machine level.
> They are IOMMU wide.
> 
> A subsequent patch will introduce per IOMMUDevice reserved regions
> that will include both those IOMMU wide property reserved
> regions plus, sometimes, host reserved regions, if the device is
> backed by a host device protected by a physical IOMMU. Also change
> nb_ prefix by nr_.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/virtio/virtio-iommu.h |  4 ++--
>   hw/virtio/virtio-iommu-pci.c     |  8 ++++----
>   hw/virtio/virtio-iommu.c         | 15 ++++++++-------
>   3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index a93fc5383e..eea4564782 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -55,8 +55,8 @@ struct VirtIOIOMMU {
>       GHashTable *as_by_busptr;
>       IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>       PCIBus *primary_bus;
> -    ReservedRegion *reserved_regions;
> -    uint32_t nb_reserved_regions;
> +    ReservedRegion *prop_resv_regions;
> +    uint32_t nr_prop_resv_regions;
>       GTree *domains;
>       QemuRecMutex mutex;
>       GTree *endpoints;
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index 7ef2f9dcdb..9459fbf6ed 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -37,7 +37,7 @@ struct VirtIOIOMMUPCI {
>   static Property virtio_iommu_pci_properties[] = {
>       DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>       DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
> -                      vdev.nb_reserved_regions, vdev.reserved_regions,
> +                      vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
>                         qdev_prop_reserved_region, ReservedRegion),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> @@ -54,9 +54,9 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>                            "for the virtio-iommu-pci device");
>           return;
>       }
> -    for (int i = 0; i < s->nb_reserved_regions; i++) {
> -        if (s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
> -            s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
> +    for (int i = 0; i < s->nr_prop_resv_regions; i++) {
> +        if (s->prop_resv_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
> +            s->prop_resv_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
>               error_setg(errp, "reserved region %d has an invalid type", i);
>               error_append_hint(errp, "Valid values are 0 and 1\n");
>               return;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index e5e46e1b55..979cdb5648 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -631,22 +631,23 @@ static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>       size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
>       int i;
>   
> -    total = size * s->nb_reserved_regions;
> +    total = size * s->nr_prop_resv_regions;
>   
>       if (total > free) {
>           return -ENOSPC;
>       }
>   
> -    for (i = 0; i < s->nb_reserved_regions; i++) {
> -        unsigned subtype = s->reserved_regions[i].type;
> +    for (i = 0; i < s->nr_prop_resv_regions; i++) {
> +        unsigned subtype = s->prop_resv_regions[i].type;
> +        Range *range = &s->prop_resv_regions[i].range;
>   
>           assert(subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
>                  subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
>           prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
>           prop.head.length = cpu_to_le16(length);
>           prop.subtype = subtype;
> -        prop.start = cpu_to_le64(range_lob(&s->reserved_regions[i].range));
> -        prop.end = cpu_to_le64(range_upb(&s->reserved_regions[i].range));
> +        prop.start = cpu_to_le64(range_lob(range));
> +        prop.end = cpu_to_le64(range_upb(range));
>   
>           memcpy(buf, &prop, size);
>   
> @@ -894,8 +895,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>           goto unlock;
>       }
>   
> -    for (i = 0; i < s->nb_reserved_regions; i++) {
> -        ReservedRegion *reg = &s->reserved_regions[i];
> +    for (i = 0; i < s->nr_prop_resv_regions; i++) {
> +        ReservedRegion *reg = &s->prop_resv_regions[i];
>   
>           if (range_contains(&reg->range, addr)) {
>               switch (reg->type) {


