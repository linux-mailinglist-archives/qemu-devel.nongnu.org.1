Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE2711B22
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LHc-0008Qp-9V; Thu, 25 May 2023 20:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LHY-0008LC-UD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:26:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LHX-0002as-6z
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:26:12 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5343c3daff0so114261a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060769; x=1687652769;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5iYVFD4xjCoxpyNmRp34Na7zCHgDnCe5kA6pwu6G20=;
 b=PZTr2z4741eQNRjPU3FGspamkgWqXZENxyodzY3a1veLn/BD3NTb6SF/q/c8t2Gb+R
 7DMg95eH883SGqOcE1d+UCT0jeDWjwmp5q/eGejJC6YLLaopxOx2pD+PNcOTdwntWxAv
 YhpOWz9YHf1w/khFTvx956s13hSzlH0kN7/1Owa57P2EpiMxzaT9Ylc8LxFW3wLg/dW7
 zluE6GUd0CEfeNbfhKdo4EzFD7sfujTl+n8DmBDAH51DWrPIC0HQtFTZ3Ef9BIz+zFsg
 YfLGPCM7/tFu/XiiDV8+lx33v+NL9NnylAzQiwd6Ln3piGK8Ecuf9Hs5mKufda2RrA5q
 khoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060769; x=1687652769;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5iYVFD4xjCoxpyNmRp34Na7zCHgDnCe5kA6pwu6G20=;
 b=FWBRt+pfxs3vQoVzz3Q0GxuVk1GMceF+g5jZs+y+2NS+5hqjXpEfzxJd+/FSO+q66J
 CPCHybEmxHrDfzIQyT0K5Hh1X5W9XR+iuvk9Ty2dcwJJZr7HRtcgiUJSFX8Jc/dz8Akt
 zqN+COKY8DG+SPiIwBKqvIzMRy+ZxRFreWqp9BxEfs4UIvaWwf8luUVe4ctGM8V3qv1M
 0+eGMXHSxuazgjBggJiw5uuArP46hAQXw7qcW+xFt1BIkJwywDlpHpaKyl9rECBaqUnj
 VKEDj4T2fmsEYuyGWe0BEOhJ+4ICuhIHoRsq43xBHuHUqCIJgjEIYWtbNX/h0T7zrwRy
 Zh6Q==
X-Gm-Message-State: AC+VfDwKEPpmLJZUjUkUQ+OK+9+0oK1f4CZOA2YVLPEYRP6TTYKsGFHV
 i7ci/bybSrYCPLE7YgqcYTPafRH4SPkMekBZqOo=
X-Google-Smtp-Source: ACHHUZ6X8lcB9xIMSSVFE6aZS7bVZkVHjUVExHP2xncOup6nd52UjS1+0QPrRytzC2RPfAiNvI/dfg==
X-Received: by 2002:a05:6a21:3299:b0:101:4348:3e4e with SMTP id
 yt25-20020a056a21329900b0010143483e4emr27266764pzb.42.1685060769514; 
 Thu, 25 May 2023 17:26:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a635a12000000b0051b4a163ccdsm1665195pgb.11.2023.05.25.17.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 17:26:09 -0700 (PDT)
Message-ID: <1aca0a9d-a0a0-0345-fbe6-ff4990aece18@linaro.org>
Date: Thu, 25 May 2023 17:26:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230525235112.1759488-1-richard.henderson@linaro.org>
In-Reply-To: <20230525235112.1759488-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/25/23 16:51, Richard Henderson wrote:
> PAGE_WRITE is current writability, as modified by TB protection;
> PAGE_WRITE_ORG is the original page writability.
> 
> Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/ldst_atomicity.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index 0f6b3f8ab6..57163f5ca2 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>        * another process, because the fallback start_exclusive solution
>        * provides no protection across processes.
>        */
> -    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
> +    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
>           return *p;
>       }
>   #endif

Superseded by
Message-Id: <20230526002334.1760495-1-richard.henderson@linaro.org>

r~

