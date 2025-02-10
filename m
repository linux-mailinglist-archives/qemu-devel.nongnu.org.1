Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D08A2F80E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 20:00:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYzF-0006iZ-4b; Mon, 10 Feb 2025 13:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYz7-0006i6-GW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:58:22 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYz4-0001zV-Mw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:58:21 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so42217975ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739213896; x=1739818696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5gSkyYg+G3/mcfa/WWDARcMjN+vVz3xIBLyIwy7AhGg=;
 b=ps6hlTjFIdHkIRW5brDqKtTi40v6SqySp08DtuMNpx+SBCoDjlCBoEJp0asJJgt15x
 TAEFAqEFXdWWMlUYKII0q4fnWq4DeKNMt2VCZkPh2MxoCZRy/LrhSDqsyd9ApiDp8o++
 dJgJ/ndopzn0B+9G3F0AQ+LkyJCQBZ7Gr1D4pHvk+tO/YBxcq/2m4rsQ3ds6BY7M3dvT
 t755sqoez3aHKwZx1NkaItjFQDDBhsO9R8Gweq68//L0C2qRMB4mAaJPplzPWMoLEwcJ
 F+pDsJ/8a24eqKsFEOlCS3L3EqELbH+pEDIDQ9U2zWRN8l8LqjkWAthZoNa4YR7GnJ2n
 P4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739213896; x=1739818696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5gSkyYg+G3/mcfa/WWDARcMjN+vVz3xIBLyIwy7AhGg=;
 b=QfE9V4Ho9KDFPJas0cn2ubbysYVqZErUcOIe0+bnlxX7uZnsL5Hnhe/H1xewDGnQxD
 KXCZQI451ChIr8w0W8pRaqsGU208T9euFzrdWEIErFWtQRRvpx9iK6ZTbIZe2POxIM1x
 RnjijYH/GMId/Ie3kfximXp5rmgwe2qUguYdy/1p0RFUeSTPIPB0GDXGF2ZjCFFhGM56
 meTtHILT/HEJVCJ+Y6zDN5Oi/06TdqlT5AX7mv91FL/uDd5L+wbMG8UfPPdM7K2sN7LG
 rTDwtLFXKlrk4vmUKASlKpRPSNa3l1vfOTku3EnHdV73W1hN0pfgIXdG6hPgVH8R6Gto
 BvLg==
X-Gm-Message-State: AOJu0YwB9oVYNBS66DtSGZ7vfIvStAP9KFILhlM/RcuwSkkqwC3Rn8HB
 ek/IiSFEIiL5oOJJpmWfyTmryk/yNwKHkBBPhxfNrbY2yFzICkmc+6FBn42baPJXKpAFOSPaQY2
 W
X-Gm-Gg: ASbGncvlndno3j8Hs0BLS9oZNBscoTit3uX72U38hSvLKGJ6pZPW42KdNDtoSXVniS+
 fcoTqppMricGxvdAm37UvEOvhxPxjmFBHhhOIdRT6T7IRr3lt9mNnKdV3EtwV6e9S0IhcFFai+y
 uCuxo343RGA1PeHN9eoTTj3JL8qsrzu+MsAg6IXOjJriuL995umioa3+VTkmuL1HgLjuZ0I4feh
 m4g0MVSdSCO5MhxdxH8TbHvX/w6QajDfGexlAPuTWHF1jcXR6OSFukGdtNX+hMAgfFmZCLjn6Wc
 1xYLWERPWZDMPv3rUO8c2C7Lz+g2A59llPlUzTbk3bKsrlDx7OFKD8U=
X-Google-Smtp-Source: AGHT+IH6mM20vKsdcA8vPEWpXXcnFvU9nZE2zxdc1oRglvzxkwJ/ClMxU5kU80vUIwo+uOe+DQu80A==
X-Received: by 2002:a05:6a00:2e15:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-73218bdd264mr723801b3a.5.1739213896348; 
 Mon, 10 Feb 2025 10:58:16 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73094018bc3sm1809536b3a.150.2025.02.10.10.58.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 10:58:16 -0800 (PST)
Message-ID: <88f22be2-629b-4acc-9a13-c1860620de66@linaro.org>
Date: Mon, 10 Feb 2025 10:58:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/arm: Report correct syndrome for UNDEFINED
 S1E2 AT ops at EL3
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/30/25 10:22, Peter Maydell wrote:
> The pseudocode for AT S1E2R and AT S1E2W says that they should be
> UNDEFINED if executed at EL3 when EL2 is not enabled. We were
> incorrectly using CP_ACCESS_TRAP and reporting the wrong exception
> syndrome as a result. Use CP_ACCESS_TRAP_UNCATEGORIZED.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 2a47df953202e1 ("target-arm: Wire up AArch64 EL2 and EL3 address translation ops")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7ddeed0283f..74b556b6766 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3611,7 +3611,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
>   {
>       if (arm_current_el(env) == 3 &&
>           !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
> -        return CP_ACCESS_TRAP;
> +        return CP_ACCESS_TRAP_UNCATEGORIZED;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for the categorization fix.

BTW the line before seems like it would be clearer as arm_is_el2_enabled.  I think there 
no bug here because we don't register the cpreg unless EL2 is present, and EEL2 will not 
be set without FEAT_SEL2.  So all the checks have been done, but it's not obvious.


r~

