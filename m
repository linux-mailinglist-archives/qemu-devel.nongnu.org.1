Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9E7AFBDF
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 09:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOq6-0002Kp-88; Wed, 27 Sep 2023 03:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlOq3-0002KT-Sj
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlOq0-0006fk-SU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695799199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38nXhEHoPqW7YImaQj8Zb5esM5iek+Y1L7C3ErZ9hLI=;
 b=B82jvivlO/81UvukdtP5NXnoIm4THerlU+zyw+FSIukZnttyzjAYk2LKQhg350tfqPDw+O
 nhYQi/jP8RO5I3sOT6NvnTI4DDPhcW5n/ZmvnjkS8uyQ49R6FEGipzzLNKDVN0aiGKMYUU
 AH65kqv0nhP5kSo+1AdvVVfG98lhGvo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-DY6-sQFEPa6nNSadfzVqjQ-1; Wed, 27 Sep 2023 03:19:58 -0400
X-MC-Unique: DY6-sQFEPa6nNSadfzVqjQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c5fa742182so96036835ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 00:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695799197; x=1696403997;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38nXhEHoPqW7YImaQj8Zb5esM5iek+Y1L7C3ErZ9hLI=;
 b=dfkRTEXyfWIVlelaKW3554RwV46Ku8vZ/SBtWauxyFzQgCDCeezoe+hSOecWbl1a10
 a6yzjxTMp4WPNDqhPguVHAk6G4wwYqw/uoBEZQvTj4Xw9+o673MTIO5YzcfYC97Cq8Mh
 SXJ6yz3BNyXhiQK18pGj3ondKIv1nqAHaBE1pV0PvxRfmYSjuezoG0vfHK9ROo3GhOql
 bFdV59Uk47K3TlqJ86MpVt+8cc/m55PimX+x8nM8bshjyj6aRoD3SFdGKs9DxZZny/ja
 6xOTU8dur3Td4W2scWeoYDFwTgrC1tvq9UNqryYeHqwMUCHPwIJ9ieHj4uKnScWP3Dcf
 PO3Q==
X-Gm-Message-State: AOJu0Yy219bRhdEWJrp7KZNj+MordaXe1HmX9S7IFvD/jf04Ij3m/H8K
 zYlNx4l1P6jmpU9Hw2W817MfnJL7F8oI/nyC82yWpPKsQUJqPfhZ480DKNJmFVdXkzex3v3wH+w
 Gf/B2JcUe/8p/4xM=
X-Received: by 2002:a17:903:11c9:b0:1c7:2697:ec09 with SMTP id
 q9-20020a17090311c900b001c72697ec09mr799336plh.59.1695799197192; 
 Wed, 27 Sep 2023 00:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1wEXXKPuAnv5eSpdrI/OBQGRiQf2DHxBCi4MUp8ciPwPGyX+cXrpuMQjxXT0nNu6BumHs6g==
X-Received: by 2002:a17:903:11c9:b0:1c7:2697:ec09 with SMTP id
 q9-20020a17090311c900b001c72697ec09mr799327plh.59.1695799196830; 
 Wed, 27 Sep 2023 00:19:56 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a1709029b9200b001b8a897cd26sm12240489plp.195.2023.09.27.00.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 00:19:56 -0700 (PDT)
Message-ID: <b52f83ec-e8ee-88ad-15d6-78dc7f8a6f35@redhat.com>
Date: Wed, 27 Sep 2023 17:19:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm/kvm64.c: Remove unused include
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230925110429.3917202-1-peter.maydell@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230925110429.3917202-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/25/23 21:04, Peter Maydell wrote:
> The include of hw/arm/virt.h in kvm64.c is unnecessary and also a
> layering violation since the generic KVM code shouldn't need to know
> anything about board-specifics.  The include line is an accidental
> leftover from commit 15613357ba53a4763, where we cleaned up the code
> to not depend on virt board internals but forgot to also remove the
> now-redundant include line.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/kvm64.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 5e95c496bb9..3ea9f1d6743 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -30,7 +30,6 @@
>   #include "internals.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ghes.h"
> -#include "hw/arm/virt.h"
>   
>   static bool have_guest_debug;
>   


