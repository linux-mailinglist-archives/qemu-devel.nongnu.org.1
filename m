Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879CF81F269
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:20:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcF5-0006xl-EK; Wed, 27 Dec 2023 17:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcF2-0006xP-VT
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:19:09 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcF1-0007S0-ES
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:19:08 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9bec20980so784377b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703715546; x=1704320346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ubOJege1Z61R1R1/YN94sPs6PJRX9iqv30pYobkbYBg=;
 b=aGRxqc4Ma8joSmzrgmdUD2Jw3wALInlaLwk5IuSlvpfHIR+g32aj+8oLLi28oqJomw
 qkE2gZjSWVnPzGl6Bqv5cprFxQfb6M9X8cu016KxShG7dYRkPPFCZwscBCOQR5zYPOjC
 r9CFfXDL1HfQnk/u5unEcgsQ89bkfFM3aeALf3bp2BHlbw+4hSSCc4wFsGnFiD67uK8S
 lVX1v0y2jlh137jjcqI3nHvUO3CdTCGOGdxFPZjj2g3sjd+ofCmON9Y5/+njXzuLjq1F
 KQRBLQ+N8SI8OZdTG5SE6ARpkZWEF1q+Z4GFbQAaV0uAUXoukIafTudevAT1FJjsYfof
 djIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703715546; x=1704320346;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubOJege1Z61R1R1/YN94sPs6PJRX9iqv30pYobkbYBg=;
 b=pbxRD1uWGBDX+Snv9q/PbNG83bk6B52cNfOyWHnEx78iSIXj0niDOZl0fnpKDDnIbO
 PlAgIMoucJ2MAvHnBtfR15LDaUIKOeEXlJAY9HSLUSkl8cJkWa3V+2S+VQemM9nCGOEX
 6Cn/FO5xjcUL1hcGrNnYElvcsGQhqqtqFV5soUNi8viKchdFeetiwt7qhA64MZaQ0+xY
 BlU22Iv3pp14Tu+QWF1DPmO6qEK9wAah1N/Nd5e5nrm+D3ZLGH7N7UszGxGK9r3VdAlk
 HN9dn+p2+eBXH0VZ8hfZeR82Dc52AW7KMMYGtkyTamoASbx8db4RpLC6ZnYjvCOKsVAI
 Z9gg==
X-Gm-Message-State: AOJu0Ywb7iKOKUj78P6mAGnbIyOsIYWVPdxLh1nyadvAYVBJzGStXYYk
 JOKDhrU0a5DeC8YJcSAdHtJiJ+0CGrmpzg==
X-Google-Smtp-Source: AGHT+IGoWMDu2qYnHelGQnS4GeHS8wGZXcwb5lJwBJkuy81TmnB7GuPzOdVywAlXFykkIv3GryG04A==
X-Received: by 2002:a05:6a00:d0:b0:6d9:aa6d:e3d3 with SMTP id
 e16-20020a056a0000d000b006d9aa6de3d3mr2666937pfj.66.1703715545903; 
 Wed, 27 Dec 2023 14:19:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa781cd000000b006d9fd64fdcasm1938353pfn.37.2023.12.27.14.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:19:05 -0800 (PST)
Message-ID: <3ef462b3-e54b-4f85-8c38-ef72e30e3a60@linaro.org>
Date: Thu, 28 Dec 2023 09:18:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/35] target/arm: Always honour HCR_EL2.TSC when
 HCR_EL2.NV is set
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> The HCR_EL2.TSC trap for trapping EL1 execution of SMC instructions
> has a behaviour change for FEAT_NV when EL3 is not implemented:
> 
>   * in older architecture versions TSC was required to have no
>     effect (i.e. the SMC insn UNDEFs)
>   * with FEAT_NV, when HCR_EL2.NV == 1 the trap must apply
>     (i.e. SMC traps to EL2, as it already does in all cases when
>     EL3 is implemented)
>   * in newer architecture versions, the behaviour either without
>     FEAT_NV or with FEAT_NV and HCR_EL2.NV == 0 is relaxed to
>     an IMPDEF choice between UNDEF and trap-to-EL2 (i.e. it is
>     permitted to always honour HCR_EL2.TSC) for AArch64 only
> 
> Add the condition to honour the trap bit when HCR_EL2.NV == 1.  We
> leave the HCR_EL2.NV == 0 case with the existing (UNDEF) behaviour,
> as our IMPDEF choice (both because it avoids a behaviour change
> for older CPU models and because we'd have to distinguish AArch32
> from AArch64 if we opted to trap to EL2).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

