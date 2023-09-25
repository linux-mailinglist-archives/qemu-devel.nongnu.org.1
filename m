Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F907ADB10
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknGB-0004Xl-Cs; Mon, 25 Sep 2023 11:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qknG7-0004WP-SF
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qknG1-0005WG-Te
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695654740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FldODL6/GABCU+umkf6yJnQfuKLCwy37BuyNu/KesyI=;
 b=TyXWMtDL0Oqiapz79yqii96elLifErmrnyvcQ8nrm6yucIckMgi0N+u1k1pWZeqnf6Fi1v
 a5YTq8TOmuw08eurexVMk823ko0Y5f+Zd8iNmdamIPqILokU4S3MCMm8fR0tz+5uslrw6k
 qYULkwv50jbOhMyQHY4pB/XwdXj+gNs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MESlNu-fMHyQOlf02FUFUA-1; Mon, 25 Sep 2023 11:12:19 -0400
X-MC-Unique: MESlNu-fMHyQOlf02FUFUA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6561142fe06so22414866d6.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654739; x=1696259539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FldODL6/GABCU+umkf6yJnQfuKLCwy37BuyNu/KesyI=;
 b=NIgaQPgqbJZdQTs46oZsNLcbF4j/RRaam0oINDdsUEmhd1pxtleqGszuVFo2uq+rbl
 ohqvf24GVkvM3/9sUr+RWOdCLTF2uaJXM36SwHk5EMfugSpJCnuCR6fN0HT68BOhknMp
 ST3fNEOdMCPFASHhuzE18nrHalP3Hikn5niR8fZLXoWbu4JHA+9Jfu5/RwEh+JA6thmY
 GgizqmG+Rt1Kk4l2GDnWRa3sR95P393FsR94BcMe5WGPOAPESQ/RWzRQ2n31Il/Au6IU
 ABvFGWBILlc3Cyn5uqXJgMXQHGhLQ+7hYfn0wInP3SzvROHNsONBnyFTKmjd6dQrimfQ
 3AVA==
X-Gm-Message-State: AOJu0YxN98JMrHJRWPhlaJDRUA66S+Lj9w9VAgDB1Aqrzx7RPgNUzhzI
 9rup6Oil7ThdLs1CK6DjN5/70JuMdI4nORRZmxTnYjQEfahmxyK7IZf2rLszlQ4MsYDRVah1gr3
 iZ8T6ct5gz9u6lyE=
X-Received: by 2002:a05:6214:3d09:b0:65a:fc7b:e0c5 with SMTP id
 ol9-20020a0562143d0900b0065afc7be0c5mr5910096qvb.6.1695654739033; 
 Mon, 25 Sep 2023 08:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfsuxCFH8zZV9zPR6O3Thm4vpuoCq5siVPHP18fs0BRDQswP7oTCqKg7sNioAibC3OWcXGg==
X-Received: by 2002:a05:6214:3d09:b0:65a:fc7b:e0c5 with SMTP id
 ol9-20020a0562143d0900b0065afc7be0c5mr5910076qvb.6.1695654738624; 
 Mon, 25 Sep 2023 08:12:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x18-20020a0cb212000000b0064733ac9a9dsm4208661qvd.122.2023.09.25.08.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 08:12:18 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:12:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386: changes towards enabling -Wshadow=local
Message-ID: <ZRGjTzPqGZHTtNkg@x1n>
References: <20230923023334.41537-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923023334.41537-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Sep 23, 2023 at 08:03:34AM +0530, Ani Sinha wrote:
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..c1fb69170f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3770,9 +3770,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      while (remain >= VTD_PAGE_SIZE) {
>          IOMMUTLBEvent event;
>          uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
> -        uint64_t size = mask + 1;
> +        uint64_t sz = mask + 1;
>  
> -        assert(size);
> +        assert(sz);
>  
>          event.type = IOMMU_NOTIFIER_UNMAP;
>          event.entry.iova = start;
> @@ -3784,8 +3784,8 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  
>          memory_region_notify_iommu_one(n, &event);
>  
> -        start += size;
> -        remain -= size;
> +        start += sz;
> +        remain -= sz;
>      }
>  
>      assert(!remain);

Ani,

I've got a small patch for this hunk already:

https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com

Wouldn't hurt to merge both, though.. or just drop the other one.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


