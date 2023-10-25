Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F757D702E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfJ9-0006Bc-ME; Wed, 25 Oct 2023 10:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qvfJ7-00068B-B0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qvfJ5-0008Fh-Ox
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698245786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FfH2Lw7QFprV6jRke4NQBfhfarGMO6DhB9vcxNJhhvk=;
 b=YtXdoq5F92YczwolZkzznDYs4jxTK63wVQVo398G7sI7AAZEVDMAKgnSVNXJ+1KfOYObH0
 H876cNM5MtXk6ssekyd6UGbxpRI21+BKTOZ5Zd8YmHEc5gRp9xbyMoMmRK0ROFa4UCky3g
 UWc/WbRoc77qUlJ50yf6Zju+netlqU4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-3s5W5DtCODiQjFZsYdkfZA-1; Wed, 25 Oct 2023 10:56:25 -0400
X-MC-Unique: 3s5W5DtCODiQjFZsYdkfZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so27804655e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698245784; x=1698850584;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfH2Lw7QFprV6jRke4NQBfhfarGMO6DhB9vcxNJhhvk=;
 b=CAUpkEkz39bQpPv/itOYGpIAIO33rjYvP9vNKDP+SDlcD9Ij+7h2Pae3fbOxqFmg0E
 SPAmvjYMXR+5V19NO8KxZZIeZCDw1tneqQM91UUTp+/JCSrFmTPec7uu7Sg9f7ncr5Xm
 IsKhDIKA1lfnCVtP1Oxg57uzhtgSbT86qrqR9bs2HvXz5aEGc4M8Pl45cfuMvn3BvEa6
 2CUYl2TA1AKZwyupNOCLQpOMJ5Itvxq+DRFdo6GYOS/Jx7GCMgEd8G4M4R9tNsWeMS6g
 r22xLgz40yq1f/HrCXEzvn0mqDzYhHksooJS6S3eXyNXyDdPprnHn1L0e7QeehScvQBj
 Xfyw==
X-Gm-Message-State: AOJu0YyLpqEKjQGW6xyc5mxTOqy95MAjaqvz9JyjjWPmjP4N4TUfRZGM
 JJtkALVUbu3bE/ES1QSOPE861/DZqPzffgK+vB+M+zH4BvvCcME8GCrh6NR3mjZT76qSpxHxuVy
 1osCyt64bvWvx80s=
X-Received: by 2002:a05:600c:3502:b0:405:3e5e:6698 with SMTP id
 h2-20020a05600c350200b004053e5e6698mr13048480wmq.27.1698245783924; 
 Wed, 25 Oct 2023 07:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyuxYq9j0WkCf76htZCOAvGk5EMJ8DURy+hXCMdG6susjmLa8h4sY/kEHiUJeDkD0jogZueQ==
X-Received: by 2002:a05:600c:3502:b0:405:3e5e:6698 with SMTP id
 h2-20020a05600c350200b004053e5e6698mr13048465wmq.27.1698245783465; 
 Wed, 25 Oct 2023 07:56:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8100:1fcd:5169:391e:99af?
 (p200300cbc70881001fcd5169391e99af.dip0.t-ipconnect.de.
 [2003:cb:c708:8100:1fcd:5169:391e:99af])
 by smtp.gmail.com with ESMTPSA id
 n10-20020adffe0a000000b003200c918c81sm12250421wrr.112.2023.10.25.07.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 07:56:23 -0700 (PDT)
Message-ID: <babd9eb7-1f9c-478a-b288-96606795fc8b@redhat.com>
Date: Wed, 25 Oct 2023 16:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] exec/memory: Introduce the translate_size function
 within the IOMMU class
Content-Language: en-US
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231025051430.493079-1-ethan84@andestech.com>
 <20231025051430.493079-2-ethan84@andestech.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231025051430.493079-2-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 25.10.23 07:14, Ethan Chen wrote:
> IOMMU have size information during translation.
> 

Can you add some more information why we would want this and how the 
backend can do "better" things with the size at hand?

Note that I was not CCed on the cover letter.

> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>   include/exec/memory.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9087d02769..5520b7c8c0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -396,6 +396,25 @@ struct IOMMUMemoryRegionClass {
>        */
>       IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>                                  IOMMUAccessFlags flag, int iommu_idx);
> +    /**
> +     * @translate_size:
> +     *
> +     * Return a TLB entry that contains a given address and size.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     *
> +     * @hwaddr: address to be translated within the memory region
> +     *
> +     * @size: size to indicate the scope of the entire transaction
> +     *
> +     * @flag: requested access permission
> +     *
> +     * @iommu_idx: IOMMU index for the translation
> +     */
> +    IOMMUTLBEntry (*translate_size)(IOMMUMemoryRegion *iommu, hwaddr addr,
> +                                    hwaddr size, IOMMUAccessFlags flag,
> +                                    int iommu_idx);
> +
>       /**
>        * @get_min_page_size:
>        *

-- 
Cheers,

David / dhildenb


