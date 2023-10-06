Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF57BB8A2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokZG-00081o-BF; Fri, 06 Oct 2023 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qokZC-00081Z-HN
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qokZ9-0007PY-IX
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696597705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oF+QsCevutKS0A5KEnso/3IIWQhH4w1bBYWU9Z/O3w=;
 b=Li3l88l4j1wi/xgj332mibz915WgSHFQ56ir5D+0jwrCEi6QZQVear45y9qNNF8P8nsrUb
 yGGhwA4FwDWcbsFXA5ZCL2ht2BRqOO1qZovw6SdHjZ2mIDkETEeUhbPpOYtsECEqNgiagJ
 2PRqTsJD3FUIgJPi9YWZBMb3oE1UJqA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ldXRjd5JMbmTZCDa71GLkA-1; Fri, 06 Oct 2023 09:08:12 -0400
X-MC-Unique: ldXRjd5JMbmTZCDa71GLkA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740c0e88ffso233964485a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696597692; x=1697202492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oF+QsCevutKS0A5KEnso/3IIWQhH4w1bBYWU9Z/O3w=;
 b=tTQSTNQpqpgCzKw8EEZ4CccYjuB1zxhpHGkIxEQARI29rrownSxwc8COwdHJGTl91H
 mIPjRoFRFJV0xJaf1CDUcFLY8UiSVDkqmzufbISxYaZ3z827Feb/58yLlUke5Et32dHV
 kDtJUOJ6z7/i+rvfjzU08XgbRqq42jK9GGf47H6oO8kNM9yuGHZv08Mx3E0H0fDNx0pe
 X0L3Ie9oIE+tClxqcC6GSw3SVesZG64WdSHIySR24I3NCM+xdIPqwMNSiHHykIXxSoZk
 yTbTDTTzgucdPcLwuml0nWhpimDcGXFY0yh9HDJM9u5JRiqXRinb1QdV56V/WNWBditO
 FD1A==
X-Gm-Message-State: AOJu0YyovDAQPseYvQm/HtqGXwsBstappr9llROBk/BpWZIac01j9h2T
 HQ9h72vjdwat/hzoBCyOmFBsKUj/vX5YaAayu4kUl2VPbDFEwYTuMT6mX4ZxEUA7u6ye9YD+p09
 H7Pm7hlN3/pa0eZA=
X-Received: by 2002:a05:620a:31a6:b0:775:7996:3431 with SMTP id
 bi38-20020a05620a31a600b0077579963431mr9014358qkb.52.1696597692441; 
 Fri, 06 Oct 2023 06:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO3MBtITq/5iGzZzRHF0iM6A7uV3o0oJi73Z/TAQesp2A6Xy+YfQ2yZPMgFEbBVYCkRVF/Ag==
X-Received: by 2002:a05:620a:31a6:b0:775:7996:3431 with SMTP id
 bi38-20020a05620a31a600b0077579963431mr9014332qkb.52.1696597692140; 
 Fri, 06 Oct 2023 06:08:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ow28-20020a05620a821c00b007749dc7881dsm1290342qkn.48.2023.10.06.06.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 06:08:11 -0700 (PDT)
Message-ID: <d76d6e9e-06be-d127-61f6-208763fbaa6b@redhat.com>
Date: Fri, 6 Oct 2023 15:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/15] memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION
 attribute
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
 <20230622214845.3980-6-joao.m.martins@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230622214845.3980-6-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
> Add a new IOMMU attribute IOMMU_ATTR_DMA_TRANSLATION which indicates
> whether the IOMMU supports DMA Translation.
doesn't it return whether the DMA translation is enabled instead?
> 
> This attribute will be used by VFIO device dirty page tracking so it can
> restrict the IOVA under tracking to the memory map when vIOMMU is
> enabled only for interrupt remapping without dma translation enabled.
The above sentence sounds a bit cryptic to me. Knowing whether DMAR is
enabled allows you to restrict the scope of dirty page tracking, is that
a correct understand?

Thanks

Eric
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/exec/memory.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 47c2e0221c35..5d6c2ab1f397 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -319,7 +319,8 @@ typedef struct MemoryRegionClass {
>  
>  
>  enum IOMMUMemoryRegionAttr {
> -    IOMMU_ATTR_SPAPR_TCE_FD
> +    IOMMU_ATTR_SPAPR_TCE_FD,
> +    IOMMU_ATTR_DMA_TRANSLATION,
>  };
>  
>  /*


