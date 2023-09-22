Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125577ABAF3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 23:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjnV1-0000f8-Hy; Fri, 22 Sep 2023 17:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjnUz-0000ev-Nx
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 17:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjnUx-00084z-Md
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 17:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695417338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P54pBQCeTJShX2EL3ApIniN2rCE550cJC1NEGVviVQw=;
 b=gN4AKOyHOHyOZj9NpTYD7fSOOOstkXh80oHtll4EFchi1qHugI2POfCoveOQFy9QE0CI0s
 LnaznaHwEv07FmG5HKg7i5Z5p33jHbjyQUATMjeYsdlXXqTp8xl/QiearObZKVFG/w/sy3
 VnjkLXPShKAxDpk0Aqtcp2Xanup3uA4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-99H2JtIXPY6Pe0VfUwAPhA-1; Fri, 22 Sep 2023 17:15:36 -0400
X-MC-Unique: 99H2JtIXPY6Pe0VfUwAPhA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a621359127so219294866b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 14:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695417335; x=1696022135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P54pBQCeTJShX2EL3ApIniN2rCE550cJC1NEGVviVQw=;
 b=JC+Vzs9UkqXKmuJDGssgBz3FJ51Z0rY1j4xvarQnOJAHhOeGyXBnUyf8/pL2b9e/E8
 58LDXvOMleEDOjSq02Msm8imCn3whlpfo3sl2J8EkRtyIhjec4PswUjD96oPEUSOiC+R
 r4t8hIOGtP6aMSmBnOElk/FrVG1gKwD3z+5dPeRz7SuxEW76lXfGmRKHde4bpyH2jXtS
 ulgpt7Reixuqta38pGbgCNQnEP2OvoLHw3xKHroaHw9MoiwFt4mo7GhpCdspVRPo1SHF
 1KXSms6wnCcOzQsUDhX74pCuIg0dluCgwMi72swY00LFAp2gpClEUm/cNEYzHaj7Tfka
 jgbw==
X-Gm-Message-State: AOJu0Yz1WXrmcmkUxjsjMCoDH4ZgkbLHaumUcsKTEJznzYrIKpGZ5xTU
 R4hPOM6oHn0Lbcbej86ZkpGbgl1xUf+cXNJVsQZW+Yz6yz5vmWreHdhmZ67YJV24R5sUY+rKS3B
 7uiGibg83QgSbKXo=
X-Received: by 2002:a17:906:109:b0:9ae:72b8:4a84 with SMTP id
 9-20020a170906010900b009ae72b84a84mr381715eje.41.1695417335810; 
 Fri, 22 Sep 2023 14:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtUkGyBQfhVx3jl8GM0nMWwBs7Tc5mhM35aWBEKJUa5lkZi9iRaRqIYFEB8OiuUFWuocswsg==
X-Received: by 2002:a17:906:109:b0:9ae:72b8:4a84 with SMTP id
 9-20020a170906010900b009ae72b84a84mr381706eje.41.1695417335472; 
 Fri, 22 Sep 2023 14:15:35 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 cb25-20020a170906a45900b009ad778a68c5sm3222112ejb.60.2023.09.22.14.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:15:34 -0700 (PDT)
Date: Fri, 22 Sep 2023 17:15:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] intel_iommu: Fix shadow local variables on "size"
Message-ID: <20230922171523-mutt-send-email-mst@kernel.org>
References: <20230922160410.138786-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922160410.138786-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 22, 2023 at 12:04:10PM -0400, Peter Xu wrote:
> This patch fixes the warning of shadowed local variable:
> 
> ../hw/i386/intel_iommu.c: In function ‘vtd_address_space_unmap’:
> ../hw/i386/intel_iommu.c:3773:18: warning: declaration of ‘size’ shadows a previous local [-Wshadow=compatible-local]
>  3773 |         uint64_t size = mask + 1;
>       |                  ^~~~
> ../hw/i386/intel_iommu.c:3747:12: note: shadowed declaration is here
>  3747 |     hwaddr size, remain;
>       |            ^~~~
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/intel_iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c9961ef752..ae30c2b469 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> -    hwaddr size, remain;
> +    hwaddr total, remain;
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> @@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = remain = end - start + 1;
> +    total = remain = end - start + 1;
>  
>      while (remain >= VTD_PAGE_SIZE) {
>          IOMMUTLBEvent event;
> @@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                               VTD_PCI_SLOT(as->devfn),
>                               VTD_PCI_FUNC(as->devfn),
> -                             n->start, size);
> +                             n->start, total);
>  
>      map.iova = n->start;
> -    map.size = size - 1; /* Inclusive */
> +    map.size = total - 1; /* Inclusive */
>      iova_tree_remove(as->iova_tree, map);
>  }
>  
> -- 
> 2.41.0


