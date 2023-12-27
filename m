Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930981F241
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 22:44:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIbg2-00083k-Ud; Wed, 27 Dec 2023 16:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIbg1-00083Y-RC
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:42:57 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIbg0-0003I1-5V
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:42:57 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-594c253f037so859366eaf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 13:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703713375; x=1704318175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VmdyWbZtc844E440P2xTgzkhKdKUHFYrBtvlgi14z0=;
 b=um1aHK7qL9ozmCpmB6P4jgJ2eSzACGpz/b+5gunMp0GfPGxclWTkb2ZHKOupdL9jP/
 EwzHaDc55d6RyUhitdOwAn98nd5PsFdpCVgXIMgCCcfw2FHGL2IaOK9lskEB3WJd3uE4
 YUHwOQPkrkc6Q0TVRk/nhafGK3x4ORDsS8nnR4G7q7y9P+R4v71YqsXFMTbmr4ayteTe
 Z0fJZIxxINPBWGg2Sds9ejC8pWc4E9hrKGe6dAD9pYwjki5WQ6uYzUS3lIxAWDdtbv10
 QD7OH0onUZ+0enB9zeZ7BpR/JaKxx/dATSVlJFy7vBs6lYDIozBqJVdTrVoyn9doPC2F
 siHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703713375; x=1704318175;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VmdyWbZtc844E440P2xTgzkhKdKUHFYrBtvlgi14z0=;
 b=l/tiI02AzCLAtqJXugUFXeLU5MnnEBDuLhZxswM/G4DQ5zZ81pJ3yV6sP35mAQLQNK
 Y8myUAyf4AB2HYejg3gICiRvJM0/Z9LtJBIiMj1lAkn3zm82hK8ojfFDikdFQhV8HdM3
 duljY14tkWX+GRgv2IHOqqsPD31iYeoyM3sDaFnjR9w1kaiSnMgf9f/cvrcUzhtvmHgf
 IkFI0HxsbsHkl9SUZVhbCMsw93pqx9f0ez6vqE3AfjBwETCLDIM3bTj5STrghyzhbdbI
 MvOzt3Tnsle4ohdgmT29oydxFGzQ+zu2d70HrEuBZxqBA0dCNvoIdsY0LQSTJF4Tloni
 Mkfg==
X-Gm-Message-State: AOJu0Yyg2daQg5vg/m/1cAjnWjFNecTeA1ZNkgPXWK58t5SA43ubzxN1
 ZqKnIWDzVTdvKR9w5bkJ6cblISI+HkYi1w==
X-Google-Smtp-Source: AGHT+IEEXmX/q3tfCWeEqmkaH3aickI0SX5Hw5zLVwHbiEzxcMqmD4UYsjoKRoeirLdAe0+Zi9bBIA==
X-Received: by 2002:a05:6358:63a7:b0:175:42:e60b with SMTP id
 k39-20020a05635863a700b001750042e60bmr2571461rwh.5.1703713374681; 
 Wed, 27 Dec 2023 13:42:54 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a056a000b8a00b006d9b30b33b0sm6683592pfj.196.2023.12.27.13.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 13:42:54 -0800 (PST)
Message-ID: <9d289bc2-d050-4348-98ca-cf86140be5e5@linaro.org>
Date: Thu, 28 Dec 2023 08:42:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/35] target/arm: Handle HCR_EL2 accesses for bits
 introduced with FEAT_NV
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> FEAT_NV defines three new bits in HCR_EL2: NV, NV1 and AT.  When the
> feature is enabled, allow these bits to be written, and flush the
> TLBs for the bits which affect page table interpretation.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   target/arm/helper.c       | 6 +++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

