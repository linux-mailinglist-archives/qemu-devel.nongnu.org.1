Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A459F81F26A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:20:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcG0-0007M8-W2; Wed, 27 Dec 2023 17:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcFy-0007LF-Rz
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:20:06 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcFx-0007kv-7B
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:20:06 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so1283138b6e.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703715603; x=1704320403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FmUHdkODkmAVcqBEkhPvnXi+rURTw5GQdE1Jd45GhVY=;
 b=MzKbxHDP23hCI9u1EXqPVPoTt2l2iRAZo6gOYn1xd6grsJ3CPHBC4uskcqkoq6fbFX
 ukQ7o7dObRW0Xg7NqIkpme8IWk1CaHem2XFKbBnq8O3k5HH56VvUvewqnP3TnC0WDvUP
 gkNLFSFRnu/sV9EbN/yBptbWqNgy+RPRHZaL/0L/LDpLo6NeJmp0LW/Ck5PZlqa9wZWe
 epHBEdUj8d73LGpt/IlJi52Tyan2izWrbIhOczUvkyVo1Pq+47/q7YUl+7cTr8F2Bp6/
 pOhIHwk6MkanC/pXIHLxPDXQlz3c68vVjkm/Ziunn3uEtvGT/oZZZFBJ6NZ6meF3a/MQ
 UDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703715603; x=1704320403;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FmUHdkODkmAVcqBEkhPvnXi+rURTw5GQdE1Jd45GhVY=;
 b=f7pT96g5sZ/XBonigb8bAfQpo8lAJiEYa6oTI9JxXKdE4oFEyFsbzoUxPtC59R3Yji
 K62hH5Dh6GPSXue4IzxnfiwoSiRKHFFZbK8n+OFErds3QztRvO/iA+8Tw26xgRQ8v+QF
 lt5WMQ8eU47Mc7lAUfeia2k0VPemsvalnvQl29nzj8vQr9xfcraNXoW1I+Z/z+qJCCLe
 +muUZfrda2lpUIDi1e+zEPEqztSBVzEfwdOfuIJmeVCVTevEZOwQpXkAxwkkhTrJbw2K
 4jxkDHTNlPUDgwKlLU/Ai3UreL1lFKRGviFYA+t+8MVWzd/JtlTTZTpFMlUFfYqbZhQX
 fLag==
X-Gm-Message-State: AOJu0YwYFjnIBdRIym5cVudg5iuS8uDSHS9uTvIzujI/e/vbcgCuNGhj
 f4PHo/WTot2tfxEuATlXKtqig6bBYFKxosd6aogPuSarNmVxcA==
X-Google-Smtp-Source: AGHT+IHVaYneJDh+yxiTVZEQg1uM341Bzw9KhWSsYTn9Ebm47R6yb90iXpHTNomN0xDGvKQ8sL4aBA==
X-Received: by 2002:a05:6358:f17:b0:174:c2e3:bca7 with SMTP id
 b23-20020a0563580f1700b00174c2e3bca7mr4038155rwj.12.1703715603376; 
 Wed, 27 Dec 2023 14:20:03 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa781cd000000b006d9fd64fdcasm1938353pfn.37.2023.12.27.14.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:20:02 -0800 (PST)
Message-ID: <7bae3b71-dbea-4fbf-8187-79d25069496d@linaro.org>
Date: Thu, 28 Dec 2023 09:20:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/35] target/arm: Allow use of upper 32 bits of TBFLAG_A64
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/18/23 22:32, Peter Maydell wrote:
> The TBFLAG_A64 TB flag bits go in flags2, which for AArch64 guests
> we know is 64 bits. However at the moment we use FIELD_EX32() and
> FIELD_DP32() to read and write these bits, which only works for
> bits 0 to 31. Since we're about to add a flag that uses bit 32,
> switch to FIELD_EX64() and FIELD_DP64() so that this will work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Oops, I hadn't intended this to be 32-bit from the start.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 167b3759ac9..91157db85ae 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3240,12 +3240,14 @@ FIELD(TBFLAG_A64, NAA, 30, 1)
>   FIELD(TBFLAG_A64, ATA0, 31, 1)
>   
>   /*
> - * Helpers for using the above.
> + * Helpers for using the above. Note that only the A64 accessors use
> + * FIELD_DP64() and FIELD_EX64(), because in the other cases the flags
> + * word either is or might be 32 bits only.
>    */
>   #define DP_TBFLAG_ANY(DST, WHICH, VAL) \
>       (DST.flags = FIELD_DP32(DST.flags, TBFLAG_ANY, WHICH, VAL))
>   #define DP_TBFLAG_A64(DST, WHICH, VAL) \
> -    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A64, WHICH, VAL))
> +    (DST.flags2 = FIELD_DP64(DST.flags2, TBFLAG_A64, WHICH, VAL))
>   #define DP_TBFLAG_A32(DST, WHICH, VAL) \
>       (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A32, WHICH, VAL))
>   #define DP_TBFLAG_M32(DST, WHICH, VAL) \
> @@ -3254,7 +3256,7 @@ FIELD(TBFLAG_A64, ATA0, 31, 1)
>       (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_AM32, WHICH, VAL))
>   
>   #define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32(IN.flags, TBFLAG_ANY, WHICH)
> -#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A64, WHICH)
> +#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64(IN.flags2, TBFLAG_A64, WHICH)
>   #define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A32, WHICH)
>   #define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
>   #define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)


