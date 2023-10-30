Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA37DB6BF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOww-0001s1-3C; Mon, 30 Oct 2023 05:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxOwu-0001rt-GI
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:52:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxOws-0000mq-RM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:52:44 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso8787661a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698659561; x=1699264361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBupKdDYd7/M7+TcrdF896J+H3uMDigsIgVmdFb1wSM=;
 b=jcTTBruAF0arex2XJFhh8UQMQC4v/urhkXVp6fqyv1fHbCNbpaKx3u4GcPulUHUYFD
 JibujI4yekyw2+j2n/bpj5FgK2FSKkKycqwe/WUXbK+u/RYUqq3wIVh8r7Hw/KfQ/5HL
 QU+kHLj/X/+OghNGQdcBfOI63zUKncHyavT3cuoqfgJ9hs/L3OCxKnPUcb3hUuAq7S08
 PWQUwQU/n93rKOiTq4Q+I5tqExXnbias1+tnxLUzR8L5a4y+FYH+ewTwp2RmHpEGlVii
 7RN5ovCYplm4dQFF5cQaiRt0NVZMkYPuxW4C/G3FbmglNmkdUigLIxbqGxLzEs3HQVVB
 JPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698659561; x=1699264361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBupKdDYd7/M7+TcrdF896J+H3uMDigsIgVmdFb1wSM=;
 b=ungF0GY0XQCTcveFuR6Mt1Mxnaw5i4QAsqSA8B83NVygn+eWr2gcckKyqk/0qgsA6K
 DHaoPtQVCve9/zbVxCUhHtNRjV08S/ITM2FOaTCKvTC8avg1kXspapjaz0gGGYcAaui+
 yzaTkszjZGElipbOzWi5qt69rkwX/O76Ac8i78xVnmohKjIz5hWRs9GCNBQYeN1SgYrQ
 3kqT8AOEFxdm5u9/hGNuzlHm5s9mT5AXsJDe8xe2GA/VTXoWFc9VR2yJZcFGfBqBnlGX
 ixddzsjrGPCnFQKu0r8l1uDs13vGAuxK2Hov/70bJqWoYGWiZfdU/u2fQIPDnLIj1snM
 FYMw==
X-Gm-Message-State: AOJu0YyUCyGoD9tlFlrD9PrdDDeX+VDZcHah9VsjkHofjFCrjB/uXtr9
 h7dXMhJBTWo4fuWmdla2dH/DJ0dXuxpyZcw1zno9VA==
X-Google-Smtp-Source: AGHT+IGTllja0ukEXtmPeEUcNM9RMDF6n0e7YUmmANqW6W5a2UfKacBAntYnF8nzKDXJyI4/qNwnkYTLbw2nRJ+JpmU=
X-Received: by 2002:a05:6402:1d95:b0:540:911b:72b1 with SMTP id
 dk21-20020a0564021d9500b00540911b72b1mr8221943edb.7.1698659560920; Mon, 30
 Oct 2023 02:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231029210058.38986-1-marielle@novastrider.com>
In-Reply-To: <20231029210058.38986-1-marielle@novastrider.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2023 09:52:30 +0000
Message-ID: <CAFEAcA8ELCiGy3jDKjJhAd9Zn7Sse9ZSoJ6uQ=u4ROvV3rNcyQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
To: Marielle Novastrider <marielle@novastrider.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 29 Oct 2023 at 21:01, Marielle Novastrider
<marielle@novastrider.com> wrote:
>
> Specifically DIT, LSE2, and MTE3.
>
> We already expose detection of these via the CPUID interface, but
> missed these from ELF hwcaps.
>
> Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
> ---
>  linux-user/elfload.c | 3 +++
>  target/arm/cpu.h     | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 2e3809f03c..d9683809a1 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -768,12 +768,14 @@ uint32_t get_elf_hwcap(void)
>      GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
>      GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
>      GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
> +    GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
>      GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
>      GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
>      GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
>      GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
>      GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
>      GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
> +    GET_FEATURE_ID(aa64_dit, ARM_HWCAP_A64_DIT);
>      GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
>      GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
>      GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
> @@ -807,6 +809,7 @@ uint32_t get_elf_hwcap2(void)

These two are correct...

>      GET_FEATURE_ID(aa64_rndr, ARM_HWCAP2_A64_RNG);
>      GET_FEATURE_ID(aa64_bti, ARM_HWCAP2_A64_BTI);
>      GET_FEATURE_ID(aa64_mte, ARM_HWCAP2_A64_MTE);
> +    GET_FEATURE_ID(aa64_mte3, ARM_HWCAP2_A64_MTE3);
>      GET_FEATURE_ID(aa64_sme, (ARM_HWCAP2_A64_SME |
>                                ARM_HWCAP2_A64_SME_F32F32 |
>                                ARM_HWCAP2_A64_SME_B16F32 |
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 76d4cef9e3..7605d6ee3a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -4073,6 +4073,11 @@ static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
>  }
>
> +static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 3;
> +}

...but we don't implement FEAT_MTE3 yet. We would add this feature test
function, and the GET_FEATURE_ID() line, when we do, but we don't
need it until then.

>  static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
> --
> 2.39.3 (Apple Git-145)

thanks
-- PMM

