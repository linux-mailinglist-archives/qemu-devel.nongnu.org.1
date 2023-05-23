Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C570E0F8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TbS-0003f5-PB; Tue, 23 May 2023 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TbR-0003eE-3V
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:07:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TbH-0004sc-Og
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:07:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d24136685so3573847b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684854418; x=1687446418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lW9xQv8xulvNT3ualI5bXLvKL6jYRlufzWXpR40u2Ro=;
 b=VoGcbxGCyat8iFRqnUKHej+lqQMlqmMfiYECVCxrlgYwyJbRj85osN17Ay6iTYTNsf
 pyyFSSeL5BfD2NbswWAdunXy8j2FUzhAcCsybKjq+LjTP6CP2xQFC3EboqyVy0LFoOey
 cUqDqte5xj36Z/KBH3cRXXf5qpLpKnPIK6cnr+mBjoRmswPncyz9GNusujZWO8fNXiOZ
 Bx8pfidTPTdan5ZRkZLunFEPToR4BnSgDr+j18H0IYaUT0QsWmES8rLV/qMuBRYFU3kR
 yJFQI5ICUQ2mbvg2KJyDPQXRbhIGFY+JFkMz1hIa33JJ4Fz653fOFXF918Skuua27cES
 hoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684854418; x=1687446418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lW9xQv8xulvNT3ualI5bXLvKL6jYRlufzWXpR40u2Ro=;
 b=AwozzGhfYuewkifNuOaOXwT6cFjN6x+VqmgtZIv2tylavBvabT1cYKHTPGB77+ZWi6
 4e6GXOqUWhNY2Rt7mdFLrdpezSsP9LTYAwqkJ3+wA8rTqanJM01+Px0DxEgDOBuagcPE
 MfCUhkavIBCm1wKss8QwMgkYyuTSRm4/NwebS8FE2+4erIsvyWfEdyfIaTHUgUQq9+Ut
 fZFVmBz+VH4p8KjfttUhSV4v1uXu7jIerGn6loWYDjZO+b/hfgXnJaciFObqSfZfimF8
 KqKghun5VXwdhe0cVVuiY0VmIc/+VdChNG2xMjKZUymqxR/pNYJdAX9ZmEtPTTl1Ljz0
 vHAA==
X-Gm-Message-State: AC+VfDznfpW5Mk6PJbvyW/xjD2k74sR5DWI8XU9vDzp+cQCcve4G4rIa
 J5lnJpabk5HgD5wje+yYo3fBxA==
X-Google-Smtp-Source: ACHHUZ4Avfkf8Xx6zD6AE/YSJp6uEgKK4mij/U/0ytw7TDNY/Yjh4q8nQXDvyAkg0szpQMIwTmexUQ==
X-Received: by 2002:a05:6a20:7d8d:b0:105:3e47:7504 with SMTP id
 v13-20020a056a207d8d00b001053e477504mr14539840pzj.11.1684854418112; 
 Tue, 23 May 2023 08:06:58 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a62e218000000b00642f1e03dc1sm6043897pfi.174.2023.05.23.08.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:06:57 -0700 (PDT)
Message-ID: <e8952655-60bb-a257-5fb6-334b9c07c4ca@linaro.org>
Date: Tue, 23 May 2023 08:06:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Explicitly select short-format FSR for
 M-profile
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230523131726.866635-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523131726.866635-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:17, Peter Maydell wrote:
> For M-profile, there is no guest-facing A-profile format FSR, but we
> still use the env->exception.fsr field to pass fault information from
> the point where a fault is raised to the code in
> arm_v7m_cpu_do_interrupt() which interprets it and sets the M-profile
> specific fault status registers.  So it doesn't matter whether we
> fill in env->exception.fsr in the short format or the LPAE format, as
> long as both sides agree.  As it happens arm_v7m_cpu_do_interrupt()
> assumes short-form.
> 
> In compute_fsr_fsc() we weren't explicitly choosing short-form for
> M-profile, but instead relied on it falling out in the wash because
> arm_s1_regime_using_lpae_format() would be false.  This was broken in
> commit 452c67a4 when we added v8R support, because we said "PMSAv8 is
> always LPAE format" (as it is for v8R), forgetting that we were
> implicitly using this code path on M-profile. At that point we would
> hit a g_assert_not_reached():
>   ERROR:../../target/arm/internals.h:549:arm_fi_to_lfsc: code should not be reached
> 
> #7  0x0000555555e055f7 in arm_fi_to_lfsc (fi=0x7fffecff9a90) at ../../target/arm/internals.h:549
> #8  0x0000555555e05a27 in compute_fsr_fsc (env=0x555557356670, fi=0x7fffecff9a90, target_el=1, mmu_idx=1, ret_fsc=0x7fffecff9a1c)
>      at ../../target/arm/tlb_helper.c:95
> #9  0x0000555555e05b62 in arm_deliver_fault (cpu=0x555557354800, addr=268961344, access_type=MMU_INST_FETCH, mmu_idx=1, fi=0x7fffecff9a90)
>      at ../../target/arm/tlb_helper.c:132
> #10 0x0000555555e06095 in arm_cpu_tlb_fill (cs=0x555557354800, address=268961344, size=1, access_type=MMU_INST_FETCH, mmu_idx=1, probe=false, retaddr=0)
>      at ../../target/arm/tlb_helper.c:260
> 
> The specific assertion changed when commit fcc7404eff24b4c added
> "assert not M-profile" to arm_is_secure_below_el3(), because the
> conditions being checked in compute_fsr_fsc() include
> arm_el_is_aa64(), which will end up calling arm_is_secure_below_el3()
> and asserting before we try to call arm_fi_to_lfsc():
> 
> #7  0x0000555555efaf43 in arm_is_secure_below_el3 (env=0x5555574665a0) at ../../target/arm/cpu.h:2396
> #8  0x0000555555efb103 in arm_is_el2_enabled (env=0x5555574665a0) at ../../target/arm/cpu.h:2448
> #9  0x0000555555efb204 in arm_el_is_aa64 (env=0x5555574665a0, el=1) at ../../target/arm/cpu.h:2509
> #10 0x0000555555efbdfd in compute_fsr_fsc (env=0x5555574665a0, fi=0x7fffecff99e0, target_el=1, mmu_idx=1, ret_fsc=0x7fffecff996c)
> 
> Avoid the assertion and the incorrect FSR format selection by
> explicitly making M-profile use the short-format in this function.
> 
> Fixes: 452c67a42704 ("target/arm: Enable TTBCR_EAE for ARMv8-R AArch32")a
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1658
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

