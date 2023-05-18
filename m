Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC09708891
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 21:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjZ9-0002aH-K5; Thu, 18 May 2023 15:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzjZ6-0002Y4-Oy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzjZ5-0001g0-67
 for qemu-devel@nongnu.org; Thu, 18 May 2023 15:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684439128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAJXAt6feLr6gmEqt6qqxD2HpFOWj88j7GCSTBVyu6Y=;
 b=LCWq8zFHa43VjHj5Pn84cyCpBrEBgL0DLBWVhQ0W3kQDUtxcg3jHFzwwodmVwRa0KHDfUL
 MhtLbFKCHD0Hha+yN+NiJOyD+0Ustcb6Y5nHyCa956iv8qdHNbs0WfTNOkegNqBUhGBi7y
 p2r1kk/AqYWhNSeffooXfp7jVvh10Jg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-dXLICYFvOFiKDm0FiD2NYQ-1; Thu, 18 May 2023 15:45:27 -0400
X-MC-Unique: dXLICYFvOFiKDm0FiD2NYQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-61b5f341341so3081946d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 12:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684439127; x=1687031127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAJXAt6feLr6gmEqt6qqxD2HpFOWj88j7GCSTBVyu6Y=;
 b=Ql0URBh4v19izS821iQpl7QHZkRj0r6ud1d/wNZfPVqHOtNlxnPCWSLUBq37Dcnjc1
 C+SxfO6reKvctq72ap01uklqoYUjT1EZVXsdB0dafIxOkGW5hgQoVW6HYX6h05KeDBrN
 XqZkuC0T6sAIqy0LI1jCIptuS/MzXJVI3lSfeSalypiU17A5n1yVEArz6h+ey0F6LP8+
 9zBphJ/L9tL4klFpHrZVwfl9E0ZWg6sBuuSnOODlqO/1uob1BT8ZW3I92ubUvYQznZwq
 +E1Ytlcb9hCx7+ynG5T3q09dsupTJUJMTgb2JEB60ou1GlqMGASBJo2/k+ehR+RiZP4G
 qKfw==
X-Gm-Message-State: AC+VfDwEDl+dVDXVlwkAmBLW5Rl52zjU1vjMpTuB9Ud/kgYRzFWUyKgz
 XpnpGX/1tR7obGAg2T2X0ciMKmK9m6ay6nmSI2GjsSmx/VFIHRm33Xrhtbf1gzrn2Yad7NrfczD
 tPxMl/Z2DmgdtZq8=
X-Received: by 2002:a05:6214:5011:b0:621:cef:f270 with SMTP id
 jo17-20020a056214501100b006210ceff270mr300254qvb.5.1684439126789; 
 Thu, 18 May 2023 12:45:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ682Vy5Ut/nKL2aSfEFYZCxgm41y4YT6/7r+VwCP2fAV8EfDAj8R4Vp9Vi+06WNmfvVz7xQEw==
X-Received: by 2002:a05:6214:5011:b0:621:cef:f270 with SMTP id
 jo17-20020a056214501100b006210ceff270mr300224qvb.5.1684439126516; 
 Thu, 18 May 2023 12:45:26 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s19-20020ac87593000000b003ee08d3e073sm739674qtq.42.2023.05.18.12.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 12:45:25 -0700 (PDT)
Date: Thu, 18 May 2023 15:45:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, yi.l.liu@intel.com, kevin.tian@intel.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGaAVAI9u4K4vy1/@x1n>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
 <ZGYzOEhdTA6sWKjP@x1n> <ZGY8rj9hRxGLpFdH@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGY8rj9hRxGLpFdH@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 11:56:46AM -0300, Jason Gunthorpe wrote:
> On Thu, May 18, 2023 at 10:16:24AM -0400, Peter Xu wrote:
> 
> > What you mentioned above makes sense to me from the POV that 1 vIOMMU may
> > not suffice, but that's at least totally new area to me because I never
> > used >1 IOMMUs even bare metal (excluding the case where I'm aware that
> > e.g. a GPU could have its own IOMMU-like dma translator).
> 
> Even x86 systems are multi-iommu, one iommu per physical CPU socket.

I tried to look at a 2-node system on hand and I indeed got two dmars:

[    4.444788] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    4.459673] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df

Though they do not seem to be all parallel on attaching devices.  E.g.,
most of the devices on this host are attached to dmar1, while there're only
two devices attached to dmar0:

80:05.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors (rev 01)
80:05.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management (rev 01)

> 
> I'm not sure how they model this though - Kevin do you know? Do we get
> multiple iommu instances in Linux or is all the broadcasting of
> invalidates and sharing of tables hidden?
> 
> > What's the system layout of your multi-vIOMMU world?  Is there still a
> > centric vIOMMU, or multi-vIOMMUs can run fully in parallel, so that e.g. we
> > can have DEV1,DEV2 under vIOMMU1 and DEV3,DEV4 under vIOMMU2?
> 
> Just like physical, each viommu is parallel and independent. Each has
> its own caches, ASIDs, DIDs/etc and thus invalidation domains.
> 
> The seperated caches is the motivating reason to do this as something
> like vCMDQ is a direct command channel for invalidations to only the
> caches of a single IOMMU block.

From cache invalidation pov, shouldn't the best be per-device granule (like
dev-iotlb in VT-d? No idea for ARM)?

But that's two angles I assume - currently dev-iotlb is still emulated at
least in QEMU.  Having a hardware accelerated queue is definitely another
thing.

> 
> > Is it a common hardware layout or nVidia specific?
> 
> I think it is pretty normal, you have multiple copies of the IOMMU and
> its caches for physical reasons.
> 
> The only choice is if the platform HW somehow routes invalidations to
> all IOMMUs or requires SW to route/replicate invalidates.
> 
> ARM's IP seems to be designed toward the latter so I expect it is
> going to be common on ARM.

Thanks for the information, Jason.

I see that Intel is already copied here (at least Yi and Kevin) so I assume
there're already some kind of synchronizations on multi-vIOMMU vs recent
works on Intel side, which is definitely nice and can avoid work conflicts.

We should probably also copy Jason Wang and mst when there's any formal
proposal.  I've got them all copied here too.

-- 
Peter Xu


