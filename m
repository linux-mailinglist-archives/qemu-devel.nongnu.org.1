Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86CAB884A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 15:42:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYqx-00059N-Th; Thu, 15 May 2025 09:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFYqv-00056v-3m
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFYqs-00067X-Qw
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747316539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gerI6pAQd3otOZeWKAxZKQLFGWPF2PevMlcAg8il2qo=;
 b=JEiCD8KMfSb5txeZ9CNJ1j1mj806u47vHK/Ty5e6+un1gMjMwXKukrn1ALKB0KXBH9uoYx
 njWy20gUrW3ibHrVXLKw+lO0IAzbu5P9lvJVSmK+RVVx7SKrV3bCRAYeYog4Jc+VTI4PCB
 IpKOYEyXZGM9865MPKt9PL+jaRM5L+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-BmvrNPxePleb3GaLb-aHkw-1; Thu, 15 May 2025 09:42:17 -0400
X-MC-Unique: BmvrNPxePleb3GaLb-aHkw-1
X-Mimecast-MFC-AGG-ID: BmvrNPxePleb3GaLb-aHkw_1747316536
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3561206b3so297492f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 06:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747316536; x=1747921336;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gerI6pAQd3otOZeWKAxZKQLFGWPF2PevMlcAg8il2qo=;
 b=WDixa0SONFx3yjeF73CeoT9ECD3Zp6vtVklAZm9DjEhJBtXleS0qNNgkUneIlRqhFg
 GYeqBQg1U53AZi1OijdGf0jNhcbKE6e1s412qynUYJ6QERz6i7F+xlAxxEMWi8jhYlcG
 c9QuJan9YaFFFrJoBfvqH9wU0LFn1ZcL64se/8lKhQyDR+UZfVPx9nqaKyCGOZxaaTxA
 /NIQgCSLehzr7mD2PHUXVm9M/CCt1vcjgG6v03C2l/5YqFM1iEPg/2d1ce7A8G/OG1fP
 RMB6W4Ef0BiwPpWdjwQ95jR97lwznDsvG0gH859CZOemB2LMjY444Mgwht16lripwfGg
 +WHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFl1ynhc25aMfG8jGhCR8T3ZRFBYidm2KsiioKvnX6SlrblyNrsQZz1p+IaK7QP+AR7v9861HcTMXK@nongnu.org
X-Gm-Message-State: AOJu0YyxxQwzAydmSCBNb9rm7E3xAzrF/GNZjiorhcsSRNd8NYZqLAEo
 acSmbhvewRgZQoy3y87IAz5bScjnG6x+kD/dG7CXN3V3kd+0WZsC5DrjimnDtc68DNGoDc3HHPU
 ZP3w6gepHpRREr4slK0/TkOnEnIUVtZWsom8xHCnRZAdjOjGfIKSL
X-Gm-Gg: ASbGncurcD1NPEWt1qjb3LEHEtV80VAQfPKJXnM78JMXAKNqQcNDVC2m3RQIMzX49hs
 Xf94N1CxALCaWbLniPrAYymXrRyRawKNmLAR9lYjq8UYcYPjgMw4KX238QDkAQTF/PChNTNWIAK
 /FmEWBeGQ7wawbiGMImWFiVApwpaeRBoHuXF3j/A7lU9ruIoPlZ7EpSEQUgiR4q7AJ9r6YrE5V1
 fIsd5+AtLsLVDnQlEDYvXABoANft/I/Z0GnNx1H4TrhD2qpSJVkpxgWGumrIaOG9CFZVztaEiCU
 AfU/kn907/T41NtP60WgVvJ3sLrRvblJI5Tas2/t379/DCovOg==
X-Received: by 2002:a05:6000:1786:b0:3a0:b733:f262 with SMTP id
 ffacd0b85a97d-3a3499528eemr5855189f8f.51.1747316536039; 
 Thu, 15 May 2025 06:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkjkOf/d3LtfKvn+IbKd+srJY9NHqHFGi9G7LjTQIQwtk9gb4ZbCjRIOCSOtxOfXUeBOHJxw==
X-Received: by 2002:a05:6000:1786:b0:3a0:b733:f262 with SMTP id
 ffacd0b85a97d-3a3499528eemr5855164f8f.51.1747316535712; 
 Thu, 15 May 2025 06:42:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35a51f816sm1082993f8f.36.2025.05.15.06.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 06:42:15 -0700 (PDT)
Message-ID: <45f4a597-f25c-4386-a410-e8892fd584ce@redhat.com>
Date: Thu, 15 May 2025 15:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/42] vfio/container: export vfio_legacy_dma_map
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-9-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Export vfio_legacy_dma_map so it may be referenced outside the file
> in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c                   | 4 ++--
>   include/hw/vfio/vfio-container-base.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 278a220..a554683 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -208,8 +208,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       return ret;
>   }
>   
> -static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool readonly)
> +int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> +                        ram_addr_t size, void *vaddr, bool readonly)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 1dc760f..a2f6c3a 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -186,4 +186,7 @@ struct VFIOIOMMUClass {
>   VFIORamDiscardListener *vfio_find_ram_discard_listener(
>       VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> +                        ram_addr_t size, void *vaddr, bool readonly);
> +
>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */

I don't think this export is necessary. See comment on patch 10.


Thanks,

C.



