Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4974A3ED
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU6E-0007Tt-Rf; Thu, 06 Jul 2023 14:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHU69-0007Sx-OF
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHU64-0005Iu-4C
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688669566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyb1Eugswk0N8xQj1J2WKT9qenfubXqukG75R08xjmw=;
 b=E0tK+x9W5q+l6MgtQp2IYPUjgKIX3qBLWFF6n91vwLVPXwZf0yPhXnXfX5wQanDTKBSt8t
 FV8TT6vAovWyO/y0XA/e843S0z20KI34vnOGAGm5LPy+h5uln+evuabdsWaL0pc43qSFhU
 sba9wsJAji5ZUToqRpGD67EZQ02WCSc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Rq1u3gQ5PaS39xIKdvlHlw-1; Thu, 06 Jul 2023 14:52:44 -0400
X-MC-Unique: Rq1u3gQ5PaS39xIKdvlHlw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313e6020882so1098428f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688669563; x=1691261563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyb1Eugswk0N8xQj1J2WKT9qenfubXqukG75R08xjmw=;
 b=X3BHyVCxbdzX9MnR9bbfrAz+U8OWD4OeqD9fvneK1tRu0omMt+7TzRlquJw1jHzjdP
 9TkdIKJ+beXI0C3nwDxYKQLnPqqERCc6Ei9JBHTUfqaDkf79Sp3vlF7i1KgwJ+JwOqqK
 qqrM+MfHVROT8XD0MqdGfezy439SQB7GpH65op4cAK3Bhz8cozXWFl61nJYWoCi0qggk
 b3dshr5JHNrSrkGlLgclB0ZTa0BfujwUXtJRhnGsf9GCJuJCUncx5vnKCjVIshgWTrA9
 EQAuipw/kZTFrjIUGGBUcx2RtceJy+NOfyQRiyJ2QREqUtJFLquNLmgZZ9Kg6KSQXWTO
 P+oA==
X-Gm-Message-State: ABy/qLY3R9pxcTIWNCMW4gunUL4dQceVdJa3dYZR/kB2Sgrj9a3wJkfV
 hBkS2LIqRKYvWVvP7gqGAzz9cLSdwSTZp7e4rbN/ow5Rub/TVxDns133I4mjrtKa4pwmNNpQ4QV
 F9c3j1w6Rw2H8cZ0=
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id
 s6-20020a5d4ec6000000b00313e391e492mr2726172wrv.17.1688669563481; 
 Thu, 06 Jul 2023 11:52:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwSNt4MFlDgHyuBRmB6xKL5Al9H/CwXZiWNux3P0QspUUa9w4ZcMGG1GJybeakmwZ8NpZgQA==
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id
 s6-20020a5d4ec6000000b00313e391e492mr2726163wrv.17.1688669562977; 
 Thu, 06 Jul 2023 11:52:42 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b0031434936f0dsm2511835wrs.68.2023.07.06.11.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:52:42 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:52:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Message-ID: <20230706145221-mutt-send-email-mst@kernel.org>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
 <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744AEDC41BE576A59908A30922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jul 05, 2023 at 03:16:31PM +0200, Eric Auger wrote:
> Hi Zhenghong,
> 
> On 7/5/23 10:17, Duan, Zhenzhong wrote:
> >
> >> -----Original Message-----
> >> From: Duan, Zhenzhong
> >> Sent: Wednesday, July 5, 2023 12:56 PM
> >> Subject: RE: [PATCH 2/2] virtio-iommu: Rework the trace in
> >> virtio_iommu_set_page_size_mask()
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Eric Auger <eric.auger@redhat.com>
> >>> Sent: Tuesday, July 4, 2023 7:15 PM
> >>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> >>> devel@nongnu.org; qemu-arm@nongnu.org; mst@redhat.com; jean-
> >>> philippe@linaro.org; Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >>> Cc: alex.williamson@redhat.com; clg@redhap.com;
> >> bharat.bhushan@nxp.com;
> >>> peter.maydell@linaro.org
> >>> Subject: [PATCH 2/2] virtio-iommu: Rework the trace in
> >>> virtio_iommu_set_page_size_mask()
> >>>
> >>> The current error messages in virtio_iommu_set_page_size_mask() sound
> >>> quite similar for different situations and miss the IOMMU memory region
> >>> that causes the issue.
> >>>
> >>> Clarify them and rework the comment.
> >>>
> >>> Also remove the trace when the new page_size_mask is not applied as the
> >>> current frozen granule is kept. This message is rather confusing for
> >>> the end user and anyway the current granule would have been used by the
> >>> driver
> >>>
> >>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>> ---
> >>> hw/virtio/virtio-iommu.c | 19 +++++++------------
> >>> 1 file changed, 7 insertions(+), 12 deletions(-)
> >>>
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


Maybe add a comment down the road. Not urgent.

> Jean, do you share this understanding or do I miss something.
> 
> Nevertheless the current code would have rejected that case and nobody
> complained at that point ;-)
> 
> thanks
> 
> Eric
> 
> >
> > Thanks
> > Zhenzhong
> >
> >> Good catch.
> >>
> >> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>
> >> Thanks
> >> Zhenzhong
> >>
> >>> +            error_setg(errp, "virtio-iommu %s does not support frozen
> >>> + granule
> >>> 0x%"PRIx64,
> >>> +                       mr->parent_obj.name, BIT(cur_granule));
> >>>             return -1;
> >>> -        } else if (new_mask != cur_mask) {
> >>> -            warn_report("virtio-iommu page mask 0x%"PRIx64
> >>> -                        " does not match 0x%"PRIx64, cur_mask, new_mask);
> >>>         }
> >>>         return 0;
> >>>     }
> >>> --
> >>> 2.38.1


