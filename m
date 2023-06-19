Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D37350F0
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBah-0007fY-Sr; Mon, 19 Jun 2023 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBBaN-0007eX-6A
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:54:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBBaL-0001kp-Dw
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:54:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-311394406d0so881245f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687168447; x=1689760447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bJC0ZOYLGGFywn0IevTM4EiGvprzqsGKkYPh8vZdReE=;
 b=u0tKBBx+xTt6DgsgNST+/7XmY/agvl745Opy0/9ZI+mmQVBLHZJ48WLMNU7H6qLm4X
 gJXc36SxNXT9OarsMf3+Xm0Yh3gJ9Z9nX2cRQOnRvYobsC2sqaURXHkCfr2NET1gSsR3
 kQ+9Bhal4BU2CB1u04qL3a63fSpi8Pve973FGKE+ZsTALQpTcvAQQ9eMJXPO54UlVLpP
 bZtUdm9p7TzIZLNfiCbAeyinTHhHVARbOrB2HLhPm4U02s1cW5/Pq8Ac5MRn1ZM+t/FU
 UwDFlxILURgtXZPutTg0FrppEoRPtlif3C0XtaA6dPPglWP93DDgRHweLpS5aUNDNXqy
 vFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687168447; x=1689760447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJC0ZOYLGGFywn0IevTM4EiGvprzqsGKkYPh8vZdReE=;
 b=PdTsxBq0Nj9z4e6DMjdP2dBPCfmFnLsqTYeIcl+jw9BWRBvQaFpU/xlJJXKYTOaSUO
 bFITKYwLbEeyJEHRYCR2ZPViXQxcsTuTJ3RPT/wScVkaY+0/KN1xeEOiKwwfS30vI8UM
 N6YR3rBK7qLDzVYAvaA+UZRS85B3823L/XAgQHInRPpn62ULfP8POoZ95l7rG87oMl0o
 ANBVrf1fA7cKH4bYi78ReOjQdeRhTg18juD/I9xYw5BT2WfKUY4e8LKeJNVf4y2iJGF5
 RIK+IwmCoeH37hNtW4CyVoI1BqxvuvUOPp1Sd6SY/rC26SzYNv+Bp7auQy4b7bdaAwqT
 UFLg==
X-Gm-Message-State: AC+VfDxgd1G1CsQS4ZgY40KTanSgDQoGh3UMuHuw2v8MUs/FDiA/Hhcp
 U9DocwT+/hNMKsnS8kTTFrHsaQ==
X-Google-Smtp-Source: ACHHUZ6czBey5t/K0wbwL/7GM06y+Ec6O/IdCguqg7uwaNGLqlrYXRbSQiMGSq9Rv5A/VhHMKAR3HA==
X-Received: by 2002:adf:f00f:0:b0:311:1120:f298 with SMTP id
 j15-20020adff00f000000b003111120f298mr5658059wro.1.1687168447515; 
 Mon, 19 Jun 2023 02:54:07 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 y3-20020a5d6203000000b003062c0ef959sm31037711wru.69.2023.06.19.02.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 02:54:07 -0700 (PDT)
Message-ID: <ece02116-0041-ca15-c958-eb989156d854@linaro.org>
Date: Mon, 19 Jun 2023 11:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] accel/tcg: Make probe_access() a generic TCG helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230619091901.51607-1-philmd@linaro.org>
 <20230619091901.51607-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619091901.51607-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 11:19, Philippe Mathieu-Daudé wrote:
> +
> +void HELPER(probe_access)(CPUArchState *env, uint64_t ptr,
> +                          uint32_t access_type, uint32_t mmu_idx,
> +                          uint32_t size)
> +{
> +    uint32_t in_page = -((uint32_t)ptr | TARGET_PAGE_SIZE);
> +    uintptr_t ra = GETPC();
> +
> +    if (likely(size <= in_page)) {
> +        probe_access(env, ptr, size, access_type, mmu_idx, ra);
> +    } else {
> +        probe_access(env, ptr, in_page, access_type, mmu_idx, ra);
> +        probe_access(env, ptr + in_page, size - in_page,
> +                     access_type, mmu_idx, ra);
> +    }
> +}

This works if and only if size is <= TARGET_PAGE_SIZE.
This should probably have been documented for Arm, but
should definitely be documented for its new location.

It looks like this could be used for

hexagon: HELPER(probe_noshuf_load)
s390x/tcg/mem_helper.c:void HELPER(probe_write_access)

Although s390x is written to handle much larger SIZE, the maximum that it will ever issue 
is 16 * 16 = 256 for op_vstm.  But it also handles target-specific address wrap at the end 
of the address space, which the above does not.

So perhaps it's not worth moving this after all?


r~

