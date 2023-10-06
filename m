Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815027BB8A3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokaK-0000Mt-6q; Fri, 06 Oct 2023 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qokaF-0000Ec-01
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qokaA-0007fL-S3
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696597770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mwh3tk5iPVoDnR7KjsrQoJI9XswsvbuAGwJPZzOo1m4=;
 b=clC0HPeDNEysGyhCjK//q2/tKFob27s32gylfUetjIgM8FKFLAOymOsW7Vd/fPq8m6cea1
 juusHUf+5RvRerlFo27mja5ZN1zy7nBv113wY/QGeNboq1N5b35DTjI7J4R6N3efEGwLyX
 CQ/1GLa8/mPo2Yib6iq2kf8tDz1FD9I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-uieUTgsOPJyF2CpiRFyPBw-1; Fri, 06 Oct 2023 09:09:18 -0400
X-MC-Unique: uieUTgsOPJyF2CpiRFyPBw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77576c78c11so213206785a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696597758; x=1697202558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwh3tk5iPVoDnR7KjsrQoJI9XswsvbuAGwJPZzOo1m4=;
 b=qECt9m+mzhDAmWeTUZvFajFG7GM0l45tYNxBAp4aptb+MGd2hLScfIVjFK1Xb5eY81
 yR5IE2MpKiXjhjHjXtNKLkxqv6xjIR3SPvXUcXbkAuowKU3jd/sNvgB0VzQyrAJT9XYG
 tUxpzm2lXsI8w2guO08FMwLTv0iZxzlc6jKtyoklfnMoY3FQNLE8hj4AeMyWrjlYxVm+
 n9rWT3i8DzYwV0vRaVFWO4PEu71CIPCjO2W0DuUpQge+PdxoalEYdLBNODGMe1Aqoh42
 4Aun92QNbVCmZLXAacPxACxVNzk5cLJm4ow3RH5SDQRVuMzr4FdIxZ80ULhdHD2Sb1yA
 4UDw==
X-Gm-Message-State: AOJu0Yz7CxeL7xcw53gk8qcQqr+7pxCSGMRAESKKN6LiIsnMFR386FkO
 smaFBybC0BbHjLeG3nzWaAESfFsc6g3DF5R9gjabUVsI2chGUjewwVU/d73HOyVShRi0JI1D2Xp
 Div6vbQ4Ae5U9Dv8=
X-Received: by 2002:a05:620a:2089:b0:76e:8403:8b2 with SMTP id
 e9-20020a05620a208900b0076e840308b2mr7698768qka.42.1696597757921; 
 Fri, 06 Oct 2023 06:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuKSu5D3NyqorNCUFKiPeellxc4b69nybww7ni1ITWxSvFfW2rUEJQz3Ml0CZpt6cEchJCNA==
X-Received: by 2002:a05:620a:2089:b0:76e:8403:8b2 with SMTP id
 e9-20020a05620a208900b0076e840308b2mr7698744qka.42.1696597757553; 
 Fri, 06 Oct 2023 06:09:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 pa25-20020a05620a831900b00772662b7804sm1281124qkn.100.2023.10.06.06.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 06:09:15 -0700 (PDT)
Message-ID: <97129e06-3d00-463d-2edf-eb064a54232e@redhat.com>
Date: Fri, 6 Oct 2023 15:09:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/15] vfio/common: Track whether DMA Translation is
 enabled on the vIOMMU
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
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-8-joao.m.martins@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230622214845.3980-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
> vfio_get_group() allocates and fills the group/container/space on
> success which will store the AddressSpace inside the VFIOSpace struct.
VFIOAddressSpace
> Use the newly added pci_device_iommu_get_attr() to see if DMA
> translation is enabled or not. Assume that by default it is enabled.
> 
> Today, this means only intel-iommu supports it.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/pci.c                 | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..f41860988d6b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -70,6 +70,7 @@ typedef struct VFIOMigration {
>  
>  typedef struct VFIOAddressSpace {
>      AddressSpace *as;
> +    bool no_dma_translation;
>      QLIST_HEAD(, VFIOContainer) containers;
>      QLIST_ENTRY(VFIOAddressSpace) list;
>  } VFIOAddressSpace;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de12..8a98e6ffc480 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2900,6 +2900,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>      VFIODevice *vbasedev = &vdev->vbasedev;
>      VFIODevice *vbasedev_iter;
> +    VFIOAddressSpace *space;
>      VFIOGroup *group;
>      char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>      Error *err = NULL;
> @@ -2907,7 +2908,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      struct stat st;
>      int groupid;
>      int i, ret;
> -    bool is_mdev;
> +    bool is_mdev, dma_translation;
>      char uuid[UUID_FMT_LEN];
>      char *name;
>  
> @@ -2961,6 +2962,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> +    space = group->container->space;
> +
> +    /*
> +     * Support for toggling DMA translation is optional.
> +     * By default, DMA translation is assumed to be enabled i.e.
> +     * space::no_dma_translation is 0.
> +     */
> +    dma_translation = true;
nit can be set at init.
> +    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_DMA_TRANSLATION,
> +                              &dma_translation);> +    space->no_dma_translation = !dma_translation;
> +
>      QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>          if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>              error_setg(errp, "device is already attached");

Thanks

Eric


