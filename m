Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B450F749F26
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQ5J-0001Mp-Oo; Thu, 06 Jul 2023 10:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHQ5I-0001MQ-1X
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:35:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHQ53-0001Em-IB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:35:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so8324055e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688654135; x=1691246135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eyiUSaebPET6ayqOPUfohu6nN2Lek0YUQPyQxh6i/zI=;
 b=vg8NmG1FAxdS566eWwh69uVFpo9Z0Me0T2LEmsPbWIlio1dROA4XZAaGASnys8xag9
 VamEb0xe86hWSvZ6TEuBn9SYnauW4V8NYDwNFlUJJZ8tNkIx4dWCXmkajbHcVPxPs5yH
 xOIrhV/5Jjtwn1N1QR92+OMMaX+jUtAy+eSmO4HvWhKdyGMVciTQMvxCn3npgw0O1vg6
 b5YCiUw0DXxxklHZA4ksA3urZPztJe2iDL8zLqY2iyXq56MApcw7Tk30T1AjbV2blt4X
 uPq9sG2C2zTixmODC4WR8Bk0a5Eyis2b9AAxnkN94BMb29SHQ+0AYYfPYQRNMB5cYeSm
 LOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688654135; x=1691246135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyiUSaebPET6ayqOPUfohu6nN2Lek0YUQPyQxh6i/zI=;
 b=Yy8pJBslBwqMGzdiCNEVRUoorc54zTerjvjxya2YqiATyhbXx7hEevJBtUEHMvf0rD
 +DAWhhuPDWc+jkf/H7RXzK1gus7uS0FU5AOu3FCx+DofFzAri5rsRi7I1u7V3wUYODTI
 2NwyI9frtBSyMd496M8fPU0fkN5E9FGWuRwzFv77uBVfymxegNBOKZjMrm6gcKuX0pxl
 hsXptlzvLPzFCG1ewMKCqdcyDb5RlVQJ9uU+xfqbII/J0O5eRpbWVKqUgo1uNCfuL/G+
 duB7t3161+sdI8WL0FGTyQsQSQTtQezaZi5a2nekKx2EXhHRPXe/09V/RpVPfvOXr6rL
 NzFQ==
X-Gm-Message-State: ABy/qLYm6V70NQYGzkZCSkSggma6m3PS+hsVdHDJcrv28jQWbWBaMEgO
 SQ7BLRGmi7PRKLpRbbe0m39HpXN8lxeg0ldzKpE=
X-Google-Smtp-Source: APBJJlEqf4RiBAawczyxwkToWivdWzoCjP9WqbP3dQJ784KkZ7bVZhEmfLfQt0eJir0qWDTNaFFVaA==
X-Received: by 2002:a7b:c849:0:b0:3f7:aad8:4e05 with SMTP id
 c9-20020a7bc849000000b003f7aad84e05mr1497644wml.11.1688654135267; 
 Thu, 06 Jul 2023 07:35:35 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 n3-20020a5d51c3000000b00313f7b077fesm2012410wrv.59.2023.07.06.07.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:35:35 -0700 (PDT)
Date: Thu, 6 Jul 2023 15:35:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Message-ID: <20230706143535.GA2570588@myrica>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
 <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744AEDC41BE576A59908A30922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 05, 2023 at 03:16:31PM +0200, Eric Auger wrote:
> >>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> >>> 1eaf81bab5..0d9f7196fe 100644
> >>> --- a/hw/virtio/virtio-iommu.c
> >>> +++ b/hw/virtio/virtio-iommu.c
> >>> @@ -1101,29 +1101,24 @@ static int
> >>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> >>>                                           new_mask);
> >>>
> >>>     if ((cur_mask & new_mask) == 0) {
> >>> -        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
> >>> -                   " is incompatible with mask 0x%"PRIx64, cur_mask, new_mask);
> >>> +        error_setg(errp, "virtio-iommu %s reports a page size mask 0x%"PRIx64
> >>> +                   " incompatible with currently supported mask 0x%"PRIx64,
> >>> +                   mr->parent_obj.name, new_mask, cur_mask);
> >>>         return -1;
> >>>     }
> >>>
> >>>     /*
> >>>      * Once the granule is frozen we can't change the mask anymore. If by
> >>>      * chance the hotplugged device supports the same granule, we can still
> >>> -     * accept it. Having a different masks is possible but the guest will use
> >>> -     * sub-optimal block sizes, so warn about it.
> >>> +     * accept it.
> >>>      */
> >>>     if (s->granule_frozen) {
> >>> -        int new_granule = ctz64(new_mask);
> >>>         int cur_granule = ctz64(cur_mask);
> >>>
> >>> -        if (new_granule != cur_granule) {
> >>> -            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
> >>> -                       " is incompatible with mask 0x%"PRIx64, cur_mask,
> >>> -                       new_mask);
> >>> +        if (!(BIT(cur_granule) & new_mask)) {
> > Sorry, I read this piece code again and got a question, if new_mask has finer
> > granularity than cur_granule, should we allow it to pass even though
> > BIT(cur_granule) is not set?
> I think this should work but this is not straightforward to test.
> virtio-iommu would use the current granule for map/unmap. In map/unmap
> notifiers, this is split into pow2 ranges and cascaded to VFIO through
> vfio_dma_map/unmap. The iova and size are aligned with the smaller
> supported granule.
> 
> Jean, do you share this understanding or do I miss something.

Yes, I also think that would work. The guest would only issue mappings
with the larger granularity, which can be applied by VFIO with a finer
granule. However I doubt we're going to encounter this case, because
seeing a cur_granule larger than 4k here means that a VFIO device has
already been assigned with a large granule like 64k, and we're trying to
add a new device with 4k. This indicates two HW IOMMUs supporting
different granules in the same system, which seems unlikely.

Hopefully by the time we actually need this (if ever) we will support
per-endpoint probe properties, which allow informing the guest about
different hardware properties instead of relying on one global property in
the virtio config.

Thanks,
Jean

