Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2390A260AA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 17:58:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezls-0004Pd-L1; Mon, 03 Feb 2025 11:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tezlp-0004PU-QG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tezln-0001FJ-GX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738601877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dp7iJ6huiRFjqOv6jVNjN1RhrtVgsPkkikV0CtCt72Y=;
 b=IO9jGU18LtZYOSlV8FSY08QyMEuoFwF7eH48ShE4+c4dBJ7yJ30si1h4WbSGDuccDXDngn
 ppxq5ukQbWDmUNT5sxGbh1kXCaWxdYeuRDmyDfRvnCNBxtriGaZrH7LJJ6Xhi68+FUhKWL
 j3tFoXm7ZOzu0fSmDdsybEEkruBmyek=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-vPLc-AztO3q4SYECzhgotg-1; Mon, 03 Feb 2025 11:57:56 -0500
X-MC-Unique: vPLc-AztO3q4SYECzhgotg-1
X-Mimecast-MFC-AGG-ID: vPLc-AztO3q4SYECzhgotg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6eeef7c38so1039980385a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601876; x=1739206676;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dp7iJ6huiRFjqOv6jVNjN1RhrtVgsPkkikV0CtCt72Y=;
 b=ciM0ajkspMiYYAdnGH3VuDGYB+PVD0IEqjY0jFhk6g8v1CPntYtXvOgL7pCEkVnp70
 6Z7LelTDDvDgC0MIr+3oUlemsj30kmxRUIMsXPFarLeHanCBeIb6djQuzUC+cIHy5Bbl
 xM5OURMHl0rG9Bu0Ib2+K7qJpH63RAjHmhXlATTg+G09TPYdCjSg++50z+n9qZP2Hm7S
 apQDrCPpGmNAmv4VLoXuBwvMwJ7hsnYrl2vFGz7CmKeQ22qVMHQ8XrnrHsDqykq/XcLh
 n4nE1G6oEEePZqDu7FGSqE11K0QnyDzrVvBWzCSUshzuSS6hkaB9arssF5T0p9PGbQPZ
 z0Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX+67hgGVgcRo3GEw4GK2AZFkLk3LpbaDqfVE/K/Fh+OWVa6wQrie/j63wx2GoNyCuyD9qkyTqSD75@nongnu.org
X-Gm-Message-State: AOJu0Yy2bFaxyNbi8NwFrwhjJxa05diTfj439o19yyspGP/uPO9UJGYy
 PMZj86MVN/SBXV1Futzlsu4qj8lJPATFU+YyJgFjxuL/LUmzSn/owzffo07jXyztHnH5gj83Vuo
 D5eCzxQcV+ABXbRC4txOQ15l9MDMSWLF0f/S6bYGqvu/Axg3mXLup49383Y2U
X-Gm-Gg: ASbGncsX4Fnap66cOOtYeybhwBpiN7Dw+odswk4MuPWHeexBnNq4mXPCXCTWgPrSjGS
 0XdQNPb25TLiMtRq9K2FHwa65mLnO4v8K+G7U7t0JivA8IiY4Z11sCMOHgGoOjKIzhUpItNNADI
 pE+o63RH1OfWK35FLip5YPj5/n9WuJdXIwbh+I0NXrNWP+GNdRB1/SFI4SFA2bc7Vq6rEpQaykB
 e4Exa7lAvIYwvoUTcTb/gYAqi/zPiH620zEGBD2qwf7ddog/M8a6vb7F+hudZIoAcJiDO8uNAMH
 wtE1lh9ymdzyY0yEYQ+wUV8y9huxJt+3rBEqXt8RFaI=
X-Received: by 2002:a05:620a:1720:b0:7b6:f110:43d5 with SMTP id
 af79cd13be357-7bffcce84a6mr3133812385a.18.1738601875787; 
 Mon, 03 Feb 2025 08:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHUwRAG1BJfNqrDLb/Cg1ARaUR0vWCuwbedQRwOiN0rfRfamjyEuRTvzGttA0OspQ562Z5ew==
X-Received: by 2002:a05:620a:1720:b0:7b6:f110:43d5 with SMTP id
 af79cd13be357-7bffcce84a6mr3133808185a.18.1738601875405; 
 Mon, 03 Feb 2025 08:57:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bc769sm546126185a.23.2025.02.03.08.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:57:54 -0800 (PST)
Message-ID: <42f0048b-acaf-4c21-af29-96552f38b2fa@redhat.com>
Date: Mon, 3 Feb 2025 17:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 03/26] vfio: vfio_find_ram_discard_listener
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/25 15:42, Steve Sistare wrote:
> Define vfio_find_ram_discard_listener as a subroutine so additional calls to
> it may be added in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 35 ++++++++++++++++++++++-------------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f7499a9..7370332 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -555,6 +555,26 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
>       return true;
>   }
>   
> +static VFIORamDiscardListener *vfio_find_ram_discard_listener(
> +    VFIOContainerBase *bcontainer, MemoryRegionSection *section)
> +{
> +    VFIORamDiscardListener *vrdl = NULL;
> +
> +    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
> +        if (vrdl->mr == section->mr &&
> +            vrdl->offset_within_address_space ==
> +            section->offset_within_address_space) {
> +            break;
> +        }
> +    }
> +
> +    if (!vrdl) {
> +        hw_error("vfio: Trying to sync missing RAM discard listener");
> +        /* does not return */
> +    }
> +    return vrdl;
> +}
> +
>   static void vfio_listener_region_add(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
> @@ -1266,19 +1286,8 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>                                               MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> -    VFIORamDiscardListener *vrdl = NULL;
> -
> -    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
> -        if (vrdl->mr == section->mr &&
> -            vrdl->offset_within_address_space ==
> -            section->offset_within_address_space) {
> -            break;
> -        }
> -    }
> -
> -    if (!vrdl) {
> -        hw_error("vfio: Trying to sync missing RAM discard listener");
> -    }
> +    VFIORamDiscardListener *vrdl =
> +        vfio_find_ram_discard_listener(bcontainer, section);
>   
>       /*
>        * We only want/can synchronize the bitmap for actually mapped parts -


