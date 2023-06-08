Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA66728991
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 22:35:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ML9-00078k-48; Thu, 08 Jun 2023 16:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7ML5-00078N-Ex
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 16:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7ML3-0006CW-RK
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 16:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686256472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fa7qnj0rc3OElxUWOxj/SO4e9Y4cPIK1q7TJeeGITkM=;
 b=Xud6v0AhrWAJgmPQFJNKFyGTBqSZgaW4loQTnUdXDbKEGIXqvNDGDbcTuWZ7fuX0YnFQKP
 N2+m24BvUxAeUEjg4iDXhlA8CfE8lBpseAgLE42/pIcI0146OxIXnQOMn/y/KoL8vQmMxb
 vePtdC7xit/uTQgkHQyQD4E3m71utWA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-OtYDGM9pO1-fvU-pW3oShA-1; Thu, 08 Jun 2023 16:34:30 -0400
X-MC-Unique: OtYDGM9pO1-fvU-pW3oShA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75b147a2548so22113585a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686256470; x=1688848470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fa7qnj0rc3OElxUWOxj/SO4e9Y4cPIK1q7TJeeGITkM=;
 b=H/0n2SOffL2/SrR+0VbeH9jnE+lgfrzpjuDCzDh7hdvpf9sg//DV/bNC8qqYyoox9n
 5LchQAFo36S7lt48ykUT1Tpe5JP2sl9+RuZ+Qtg9oYLt3T9uHWB2r69eIJ0IPLf+CYhj
 /f7Gx5sJwU4T5bEvAHE0BpEer82nk/dv8SgLtY+i5fC1Q0cOE86GLLN26vxZcjsOebAL
 3sW3bUZGXdYaHSI66doL3tU5m4CfLyFJZKF0RirGivA1pZJW5SoAqVRQ+FBxjd05dp5b
 r/35sO3JsOkQC9Kjs28aSQ80OGgnZKXjShuYXggdpVArZvlyC8D88Wv3bdHj/HDRwUnT
 +57A==
X-Gm-Message-State: AC+VfDxTmg0Wb60chJ9rxzJCBkUrg//NUDLv5SnUET3eW4fjRS+Hd6DP
 tNR/bzYXXrW9SdR967WKcvHUImCroR1xrJ7lCzWlPzfrZmUH1r/m9LwmMB40jhSJwt+0RbfmfeI
 49Be0CrBhvZY83Zc=
X-Received: by 2002:a05:620a:4722:b0:75e:b9ab:2690 with SMTP id
 bs34-20020a05620a472200b0075eb9ab2690mr7838968qkb.6.1686256470328; 
 Thu, 08 Jun 2023 13:34:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a7MaBG/LDOKcaepf8v7PYHTSbJRp+HL7F0ZuddIdLT527SonIWU3/ghgphKbdKm7a/iAlMQ==
X-Received: by 2002:a05:620a:4722:b0:75e:b9ab:2690 with SMTP id
 bs34-20020a05620a472200b0075eb9ab2690mr7838952qkb.6.1686256470115; 
 Thu, 08 Jun 2023 13:34:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m24-20020ae9e718000000b007578622c861sm564465qka.108.2023.06.08.13.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 13:34:29 -0700 (PDT)
Date: Thu, 8 Jun 2023 16:34:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZII7UyaKrArIM5Qg@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-6-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 08, 2023 at 05:52:31PM +0800, Zhenzhong Duan wrote:
>      while (remain >= VTD_PAGE_SIZE) {
> -        IOMMUTLBEvent event;
>          uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
>          uint64_t size = mask + 1;
>  
>          assert(size);
>  
> -        event.type = IOMMU_NOTIFIER_UNMAP;
> -        event.entry.iova = start;
> -        event.entry.addr_mask = mask;
> -        event.entry.target_as = &address_space_memory;
> -        event.entry.perm = IOMMU_NONE;
> -        /* This field is meaningless for unmap */
> -        event.entry.translated_addr = 0;
> -
> -        memory_region_notify_iommu_one(n, &event);
> +        map.iova = start;
> +        map.size = mask;
> +        if (iova_tree_find(as->iova_tree, &map)) {
> +            event.entry.iova = start;
> +            event.entry.addr_mask = mask;
> +            memory_region_notify_iommu_one(n, &event);
> +        }

Ah one more thing: I think this path can also be triggered by notifiers
without MAP event registered, whose iova tree will always be empty.  So we
may only do this for MAP, then I'm not sure whether it'll be worthwhile..

-- 
Peter Xu


