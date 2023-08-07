Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120C772DD7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 20:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT4uK-0007fm-Vr; Mon, 07 Aug 2023 14:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4uJ-0007fW-2c
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:24:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4uH-0003SB-8O
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:24:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc6bfc4b58so8055715ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691432679; x=1692037479;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYC+oAsG1o1E1C3M6snsqM8INrkC1a5IjUxeineQKZY=;
 b=ibBtP5y1fER9CoAL3cMMgdjeLicsBaxcNJYdnOEu/58IkGY/fjw1iPE8f4Hz4ZELIS
 iXRxnmxAVXkGBKBckD8R8nAddRVSOVoxsPqeL84SaykU9+46OoAIRuqwFPTBn8meT+ft
 lno8kDS/x62dwUZ/CcKal5cRb5QtAuNEXRym0R2KTpDmfl4JpBb+gkPbAZT/vOI1yD4/
 lcPpCz2z6Q8gcVBKV5wcwnEjfpCVPZPgsknYtgdzEa/MIX4zic2r3hv1ohQnROykmgRr
 mViXT17Lx5nXk762uRRQHb83uWWz6n1yAIORbW5Jfpibm6nt9pj0LrO0JqqGaWVWjLK7
 1Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691432679; x=1692037479;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYC+oAsG1o1E1C3M6snsqM8INrkC1a5IjUxeineQKZY=;
 b=IpBBYQxle3EYLKDJtEYNqWLsQVN6Zl3bL5fZTn385bWv2+nYrZjRQ9yKW7vo/Uf6sg
 72SCehQZf4bdbCewDAxl8w4u8zu95f9HqW41OxVIlcMW2RqGvFIcW9T3uxcDd3HFN8Ut
 cYy/kO8R9lgvL6Kfd810rX4qe69LxONP9vYyPuz9bSrxBfO3tBAdbAA4j7rdi/cd8YUY
 fRhQoTdFYNxELzvcvvjy8sIrkiuKaimVzaZWQOlla4WSAnsZcvEH2fTvZYejGtSWTVXy
 FzCzj20CzJy4zywIKJ7q3SSYkODVA/miZxiwB1l2CnpWjAOa5Z6cOIhSCjUkiVd2MrPQ
 cCXw==
X-Gm-Message-State: AOJu0Yw4SuZWNC9iewEs7IxSrbTsqUVplHZK4EOJrECJjZMxU3hmjR59
 xmVQDmYOR+0JGuCzZHYLONguqg==
X-Google-Smtp-Source: AGHT+IF7nJd4EcqLcPXexrLLGIjSpG3X0R1BMOxHqtElSJZXWGkq4quCdaXP3YyLQA8JWQFaIkLEFw==
X-Received: by 2002:a17:902:ab88:b0:1bb:9bc8:d230 with SMTP id
 f8-20020a170902ab8800b001bb9bc8d230mr7374862plr.23.1691432679235; 
 Mon, 07 Aug 2023 11:24:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902bd0700b001bc2831e1a8sm7222705pls.80.2023.08.07.11.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 11:24:38 -0700 (PDT)
Message-ID: <f5e8c9ce-6943-1f36-d450-e9905df826e0@linaro.org>
Date: Mon, 7 Aug 2023 11:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/15] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230807141514.19075-1-peter.maydell@linaro.org>
 <20230807141514.19075-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807141514.19075-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 07:15, Peter Maydell wrote:
> arm_hcr_el2_eff_secstate() takes a bool secure, which it uses to
> determine whether EL2 is enabled in the current security state.
> With the advent of FEAT_RME this is no longer sufficient, because
> EL2 can be enabled for Secure state but not for Root, and both
> of those will pass 'secure == true' in the callsites in ptw.c.
> 
> As it happens in all of our callsites in ptw.c we either avoid making
> the call or else avoid using the returned value if we're doing a
> translation for Root, so this is not a behaviour change even if the
> experimental FEAT_RME is enabled.  But it is less confusing in the
> ptw.c code if we avoid the use of a bool secure that duplicates some
> of the information in the ArmSecuritySpace argument.
> 
> Make arm_hcr_el2_eff_secstate() take an ARMSecuritySpace argument
> instead. Because we always want to know the HCR_EL2 for the
> security state defined by the current effective value of
> SCR_EL3.{NSE,NS}, it makes no sense to pass ARMSS_Root here,
> and we assert that callers don't do that.
> 
> To avoid the assert(), we thus push the call to
> arm_hcr_el2_eff_secstate() down into the cases in
> regime_translation_disabled() that need it, rather than calling the
> function and ignoring the result for the Root space translations.
> All other calls to this function in ptw.c are already in places
> where we have confirmed that the mmu_idx is a stage 2 translation
> or that the regime EL is not 3.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Changes v1->v2: instead of having arm_hcr_el2_eff_secstate()
> accept space == ARMSS_Root and return 0, have it assert that
> Root is not passed, and adjust regime_translation_disabled()
> accordingly.
> ---
>   target/arm/cpu.h    |  2 +-
>   target/arm/helper.c |  8 +++++---
>   target/arm/ptw.c    | 15 +++++++--------
>   3 files changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

