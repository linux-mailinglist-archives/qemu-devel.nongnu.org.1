Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C37B375B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmFnX-0003rI-VD; Fri, 29 Sep 2023 11:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmFnU-0003mh-BL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:52:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmFnO-0000l9-0b
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:52:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405524e6740so124916805e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696002767; x=1696607567; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sMovLiHflr0V27yCu0/wr0hCFIeYF3SXJ2+/XZ2rP5E=;
 b=AvUigX77o5B7j4xRHwsEvuU7QZvsJpOv1ThtQEBAjXqr5GE/h81d+1lUOTSNz0+gZS
 oHUSkbTnCwDj0CSdakxYeAMxGPIuTitn6Q/Mr57XC+LtJ2ODSh2BrEjq67e/iUdhCiA3
 eRcPA0+q+IPUlekU0G+FZC2b2YN6i0S+thvBl1bdAChXXOjm8njDnVqMDmMY2zHRKcQC
 KJalypPBqgpiFyX8U6h4Vo3fG/msM9ft/mwlLjtCIymYI4Knncta87NzQoizhW/nD1C9
 TvAzEJebUf4S4lRFn+d9uWeYEldIp4rwlN1fH3VBJt0TdPJ674GtBpyCS+EEnri0NEkC
 qDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696002767; x=1696607567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMovLiHflr0V27yCu0/wr0hCFIeYF3SXJ2+/XZ2rP5E=;
 b=X6IVMjamrx7lqEECVd0Q1xP5JSP4Zlle1F5rRK7KSWeBl8IiLXT4inFw7+odNIojS0
 Q94fiAFFKrGX/aVLf6bqsGadpQ3VDgp1zdhU2zM+UWTpVeT+YBngJH64thLTkx+yd6e5
 1MqJimBOMYwrybd0mVCp42x23MEAR8wwFPuNaI+WLlx2MwvNEDNw7vbbDKTU/mmCsFAz
 RO42+XWrpq2W/9E5R1uDqPa/bUrLnY0S/OFYx0OrPTvw0l85Z4kyYEcKMEIa4+4cxs7I
 kuonB15wznYXrFzOey7wc1Rc83tw3UxM9hFF181gWnD6p5im29IYGGPmef377zmsiRux
 GxRg==
X-Gm-Message-State: AOJu0YxBMjwviPY1YjeWuuToryZhtk0+yWp6dK/yyRV5oAZBmD4AlstP
 qKNoktQx0pbPQj8+4cCiq7+4ng==
X-Google-Smtp-Source: AGHT+IE7wQtWt+xiRNGNzLd8mS6NRoKImD1xxhClkf8rpvGKVLZcGtmyiAUTSPoAIP141cX1prc4+A==
X-Received: by 2002:a7b:c456:0:b0:401:eb0:a98d with SMTP id
 l22-20020a7bc456000000b004010eb0a98dmr4512224wmi.24.1696002766592; 
 Fri, 29 Sep 2023 08:52:46 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a5d634c000000b0031773a8e5c4sm21734556wrw.37.2023.09.29.08.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 08:52:46 -0700 (PDT)
Date: Fri, 29 Sep 2023 16:52:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 05/12] virtio-iommu: Introduce per IOMMUDevice
 reserved regions
Message-ID: <20230929155251.GA2957297@myrica>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913080423.523953-6-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On Wed, Sep 13, 2023 at 10:01:40AM +0200, Eric Auger wrote:
> For the time being the per device reserved regions are
> just a duplicate of IOMMU wide reserved regions. Subsequent
> patches will combine those with host reserved regions, if any.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/virtio/virtio-iommu.h |  1 +
>  hw/virtio/virtio-iommu.c         | 42 ++++++++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index eea4564782..70b8ace34d 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -39,6 +39,7 @@ typedef struct IOMMUDevice {
>      AddressSpace  as;
>      MemoryRegion root;          /* The root container of the device */
>      MemoryRegion bypass_mr;     /* The alias of shared memory MR */
> +    GList *resv_regions;
>  } IOMMUDevice;
>  
>  typedef struct IOMMUPciBus {
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 979cdb5648..ea359b586a 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -624,22 +624,48 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      return ret;
>  }
>  
> +static int consolidate_resv_regions(IOMMUDevice *sdev)
> +{
> +    VirtIOIOMMU *s = sdev->viommu;
> +    int i;
> +
> +    for (i = 0; i < s->nr_prop_resv_regions; i++) {
> +        ReservedRegion *reg = g_new0(ReservedRegion, 1);
> +
> +        *reg = s->prop_resv_regions[i];
> +        sdev->resv_regions = g_list_append(sdev->resv_regions, reg);
> +    }
> +    return 0;
> +}
> +
>  static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>                                                 uint8_t *buf, size_t free)
>  {
>      struct virtio_iommu_probe_resv_mem prop = {};
>      size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
> -    int i;
> +    IOMMUDevice *sdev;
> +    GList *l;
> +    int ret;
>  
> -    total = size * s->nr_prop_resv_regions;
> +    sdev = container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr);
> +    if (!sdev) {
> +        return -EINVAL;
> +    }
>  
> +    ret = consolidate_resv_regions(sdev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    total = size * g_list_length(sdev->resv_regions);
>      if (total > free) {
>          return -ENOSPC;
>      }
>  
> -    for (i = 0; i < s->nr_prop_resv_regions; i++) {
> -        unsigned subtype = s->prop_resv_regions[i].type;
> -        Range *range = &s->prop_resv_regions[i].range;
> +    for (l = sdev->resv_regions; l; l = l->next) {
> +        ReservedRegion *reg = l->data;
> +        unsigned subtype = reg->type;
> +        Range *range = &reg->range;
>  
>          assert(subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
>                 subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
> @@ -857,7 +883,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      bool bypass_allowed;
>      int granule;
>      bool found;
> -    int i;
> +    GList *l;
>  
>      interval.low = addr;
>      interval.high = addr + 1;
> @@ -895,8 +921,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto unlock;
>      }
>  
> -    for (i = 0; i < s->nr_prop_resv_regions; i++) {
> -        ReservedRegion *reg = &s->prop_resv_regions[i];
> +    for (l = sdev->resv_regions; l; l = l->next) {
> +        ReservedRegion *reg = l->data;

This means translate() now only takes reserved regions into account after
the guest issues a probe request, which only happens if the guest actually
supports the probe feature. It may be better to build the list earlier
(like when creating the IOMMUDevice), and complete it in
set_iova_ranges(). I guess both could call consolidate() which would
rebuild the whole list, for example

Thanks,
Jean

>  
>          if (range_contains(&reg->range, addr)) {
>              switch (reg->type) {
> -- 
> 2.41.0
> 

