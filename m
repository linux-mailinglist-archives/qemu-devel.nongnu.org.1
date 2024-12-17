Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD69F5790
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 21:21:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe3g-0007CO-C3; Tue, 17 Dec 2024 15:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3a-00077f-JP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:38 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3X-0000Yb-4m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166022c5caso46016935ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466832; x=1735071632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JPR4qZSbuycXuWd71gEnMXZl3JggaD0Qc0cVlw9EpKM=;
 b=Mwuz8Y5K1L0LJDQ76O4IchTm7nkOgIm8kF8Cd+/mZW84C1H0gXGMqrO+moyHZvfuWw
 GiP9U9pT2YwtnMfGp+BTacopKaLy3pSyUTAuSznJmT/TIWhFFs1luuFt0gVYk1r/ErmX
 6lqdTW9wLuqL0s99SZoonf90xAeWew2+kFjQW8SUvlFvrVZpP2LI2bncrLqm2xM9hjOy
 y2dcd7HbrRcj9O+P54qT+pSNnBmXo61ELVwzQO9iJBkpdldBlEb7GrOli0gL263/TZlx
 GDXZLxQLsHDy/lmS9F+4rht/gy/09lgdV9k3qmo1kZBhw6YLPpDZzbPfwsDj23LQvHPR
 r0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466832; x=1735071632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPR4qZSbuycXuWd71gEnMXZl3JggaD0Qc0cVlw9EpKM=;
 b=nAUvxXcssM541ERPwmxE/qO6yR1JpWfLg/TtsLt6v0gO50DFHeboiDowMdNRDzO+pz
 HwrR4uwLsngVnvmB/OYX9V1dD9A0xUCbmPI1usyllziPFyW0T7jiwQ2niVNGmKB3ahR4
 VnVBaBVzhldLQQmCsBLWGWMaBxl5u2G+yO63qcJuKsAagg9UdZsedTKOy70J5t1uPrfr
 f/PVeMd5RM+PWM4B0NFGD6NvG/IL/FxCYwjCpxQxeARIla+88ib2uVyKGrGWkWqTcItR
 5GarBJ5kMCKwrpcEiMiHWQHHtBAHs7nPbH7RAP/rFLypzGJJD+fLF7IWQv6zM/zqQ1xK
 jRhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVigdRMqy8gvQjWllHWlF+32LAtFR8Bn1AIPsAqaB9JIrzPgyR79tCCWbK/XNEY+2Sl0Me5S3a4sIMV@nongnu.org
X-Gm-Message-State: AOJu0YyKUqTXMI/maKxnR/aJH0ZeB7+Y5K/ECc2hR5WNn3kpG4b/hyvI
 6Vr8epa+OE+wun4B6g8yy/uisx1WRSm54zIyA6n/FljXNEIe2N9G2HVu7lNwlIr5cPgPBcncrbl
 a0y/1MQ==
X-Gm-Gg: ASbGnctFft0Ii6RN5Cxu/Xs87vzsIpjaIv7WNSXwewcxdmCBgf+dKP5uAswmRJs9OxK
 boBfKLSrpanSaBb/3vaNKM4X+NQwlA57JQJ4AjE7zsfd3YE1WFoU2bd3p4OVRACdBoim3sRMbrd
 T67T5oILHb2O3v/5g78vt8p/Mm4/D8kuNrhq7jK9i42VuHKf36di2s/DLXSrj7Xb3NQNidhCb3y
 jDQZVHGgggXdBKPeB8mzY8lpn7g40v5yVO+5qIGiJW/Y3PfGMdXPliacDH2Fli2lKyguQ==
X-Google-Smtp-Source: AGHT+IFO1JQ2iYC0AFC4AvWCYDxKBm2SXZTp/HhYSoumCy3g3oXgwaerE0H+1jJYclPE4plyRv1SUg==
X-Received: by 2002:a17:90a:1208:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2f2e9303915mr315120a91.19.1734466832507; 
 Tue, 17 Dec 2024 12:20:32 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142fa218bsm10369928a91.35.2024.12.17.12.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:20:32 -0800 (PST)
Message-ID: <2a239db5-1362-4cd6-81f8-c6552eaddb47@linaro.org>
Date: Tue, 17 Dec 2024 12:20:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/46] tcg/optimize: Use finish_folding in fold_divide
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 4d5fa04199..59f510b49a 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1671,7 +1671,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
>           fold_xi_to_x(ctx, op, 1)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_dup(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


