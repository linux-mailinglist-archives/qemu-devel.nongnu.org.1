Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE970B9A223
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 15:58:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pzy-00043d-Sb; Wed, 24 Sep 2025 09:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Pzj-0003x0-CP
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Pzb-0007Zm-FL
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758722222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hJ6aunHCCFJQQ0UYPmcMC7mUQSIVcobFj3gEBWe6sV8=;
 b=DBlel69CY90Ye9Z1AF/X0DQf3TNJOWRnWZMt8ZMIyNpT7QX5+OMmUfg1mH2dZCgxZJJS7y
 no1QLA8eP20BRYNvKxdncse10tGSZffUfqPN8/etA0/JkmPcQj/UAhOvgn1aEIspKJqdSA
 7fhBqKy8oqqv/i1fyDkhYoZI42Gxw4w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-R2BgLNvwP0mfk3Bv8ufdiQ-1; Wed, 24 Sep 2025 09:57:00 -0400
X-MC-Unique: R2BgLNvwP0mfk3Bv8ufdiQ-1
X-Mimecast-MFC-AGG-ID: R2BgLNvwP0mfk3Bv8ufdiQ_1758722219
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so3486669f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 06:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758722219; x=1759327019;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJ6aunHCCFJQQ0UYPmcMC7mUQSIVcobFj3gEBWe6sV8=;
 b=YrgQs+a3dkmWkqhhOLlAsMB1h7U7cn2k6nrcNjrJbHew8RXOklUDPE2tFVKEROKhIB
 hof57l//moTwF/YaQjqPErR2oQI3nhoy79oiOfa257LraR/DFExgBvYRO9zB+TchTH7E
 e/ztd5VSpCH/hrPkL9LT2ciwMW6tJRUSu7wpbHQEMoyZaJEqN0DQsjfIQPNunF63CL9J
 Gn1jVeGS2hhM/ayfvgggWQhn6vtcJmCJApGalRRy4pkaFdBZUOnweecbUZpA2RxnUZQk
 yEL92jpGwC3TRwBnebsvoVnpELipC/oiHNJqOHuioW+TTDyqLGHId4utuFXnUxhp8bmG
 BKig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+PwJu5WGzDBvxc1PU2sj3H0uLR044njEf0aizY/K4yDntsq5yKOoHW1fAsqZUDx8LZiFV2CDdXSEc@nongnu.org
X-Gm-Message-State: AOJu0Yz1nQQmVq+UyAhH/7qgRaejV2rWWSULMkwSs2XssBsGgXX/lttJ
 iEEn0iwhIGleb16D4EpbAC5SXwKaoKUXDMaOpXUWV0znHJ/nxpuxQOKXv8EaqOz9Nb6rB0DyboF
 CWhA0nVdUNPHiGk1LdI/W/wrLe7OG8VSpBvvYnIzPs0zfyA9sGNujkuQt
X-Gm-Gg: ASbGncsdzWWrGF3Na2IcmDt/pfTgzRiQLeQl/hxpkCxKNRBVeGnhguao2Agxi2xIxGh
 KTYrnhTHQ76rM8IB4vPNuNTbZARVP1if9hXhk87Dh/1VlRN1JvNUyf2ET58Nj7oa4biyRG1haD2
 rNQ9BMI8oFXcUQ8a/ZzBdiTzGbiDWuNnX9mcKHv0Im5J1kjnp/ot0EjXlT4PWIn+Sq0ZOdP2PpG
 R9gwmAIKO8M0oEmI3/uUh3N77gnFJO6p/sJ3b+5865zmJ06HSdfWtAm10xt4dxyUz3L8IHNa38p
 gcX2SSVk65zYuUyDK1RKNns+d860Lq2nnWsflFPANNwSRm92a4kVTjYYOG8KKBsNyIZv9CEudWy
 QPCM=
X-Received: by 2002:a05:6000:1a85:b0:3d6:212b:9ae2 with SMTP id
 ffacd0b85a97d-40e50f5734bmr18610f8f.63.1758722219241; 
 Wed, 24 Sep 2025 06:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6gEuWSLW8HwUf5qNN3ct4O6cBAElQkWl1jGdlRF7G+PP8+rhB71qIYnNABYPZ1/6uWxIWw==
X-Received: by 2002:a05:6000:1a85:b0:3d6:212b:9ae2 with SMTP id
 ffacd0b85a97d-40e50f5734bmr18575f8f.63.1758722218705; 
 Wed, 24 Sep 2025 06:56:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-408a9057b87sm3998902f8f.3.2025.09.24.06.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 06:56:58 -0700 (PDT)
Message-ID: <f79e92b9-dd75-4241-97ec-ae87dd5f2b88@redhat.com>
Date: Wed, 24 Sep 2025 15:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/27] vfio/vfio-iommufd.h: rename VFIOContainer
 bcontainer field to parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-10-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> Now that nothing accesses the bcontainer field directly, rename bcontainer to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/vfio-iommufd.h | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
> index 13f412aad7..6b28e1ff7b 100644
> --- a/hw/vfio/vfio-iommufd.h
> +++ b/hw/vfio/vfio-iommufd.h
> @@ -22,12 +22,13 @@ typedef struct VFIOIOASHwpt {
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
>   
> -typedef struct VFIOIOMMUFDContainer {
> -    VFIOContainer bcontainer;
> +struct VFIOIOMMUFDContainer {
> +    VFIOContainer parent_obj;
> +
>       IOMMUFDBackend *be;
>       uint32_t ioas_id;
>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> -} VFIOIOMMUFDContainer;
> +};
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



