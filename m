Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9920F75B499
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWdK-0007Ot-Dh; Thu, 20 Jul 2023 12:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWdI-0007No-8N
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:36:04 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWdG-0007I6-N9
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:36:04 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so1625734e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689870960; x=1690475760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1te5QnsGdqFFgJE8Ufpgh1r9/Gv8HuA5cGaTx2tb6/k=;
 b=v97+vKq+RLntxc3OCeriVEI71u83ToMUoKrqfiA56avpm7YC+GVfnjtKZx0zqhNYJ1
 VSP+HaH/PsgJ4iSsJkR5V6zE5+OdAW0HKLc8NAgAY1II3JsuWeSWuL4l7F+zaBqoNpLk
 mpBBLexoP/1ziAPLsQyitcsmy+DpfQ2Fu2LhASnhD8G3/d53miS5uIJEvWuQXSrSjh5E
 fhcIQsf+9TVSzIYboal8uRbeHozxFdNJI8GjcCK7i8jlyb1Z2fpbjJpSzWEAPdLGq6Qn
 u8mSiFXY/oxmx9o93P4ydyPOXAM+2wWZpzJPWOifsDhwZ0L2tTnTQCEI8ZnDlMtfbP8l
 EZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689870960; x=1690475760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1te5QnsGdqFFgJE8Ufpgh1r9/Gv8HuA5cGaTx2tb6/k=;
 b=QAJmqkKYxPV0uAqf/cPdkwR+ap654baTUSIZCuzgGQiZE6V7kB5tSyL88RpsXJtDCY
 h2SB1YPEwE84LCjgIYvg1FJXyISdd17eXKGmbSRzpmwA5xjvjHg8lOHX+X4DKbR150kU
 b4dLAbLkwikVD8HDb9bE19tjo5HcBtnSt4g6m4b38l5HMNk96SNSRsPEvLp+iwvtNKie
 pn4SZYpLhzvqGoqMmMinADXXTpvCdBhh1grEFwpoXO9XsuhmEgwdibSIF1+Ieud7DhtY
 5rNeXdJZCwwqYLPygnQ6C0ETGrNj5kJb2JRudRGTIncsIk9pVCZgLwcBZi50RItTcIqX
 NVFg==
X-Gm-Message-State: ABy/qLYS/zjpA4hUWJw5ktmHOsnRLRbPy458qaTiBsJXdwP3CpVP3KBy
 1Ig7rgH5b9/oD6YkdFufE2d2N2fmc/ByLVtnBzTO8Q==
X-Google-Smtp-Source: APBJJlHKEgQaW/7ONB6lat/PEdO3jK2kt6W8p8Z/lVpjcbbq9h4s7RZEUQ3UTnaA8LgROymshngBgOPwtRlkd05ZWPo=
X-Received: by 2002:ac2:5dea:0:b0:4fb:89e3:5ac6 with SMTP id
 z10-20020ac25dea000000b004fb89e35ac6mr1846981lfq.62.1689870960297; Thu, 20
 Jul 2023 09:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-4-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-4-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:35:49 +0100
Message-ID: <CAFEAcA9Wc00X3oqN2aLP1QeVbv4Ji+8x0a8nDUtgkA3fjyNWQg@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/arm/helper: Fix vae2_tlbmask()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When HCR_EL2.E2H is enabled, TLB entries are formed using the EL2&0
> translation regime, instead of the EL2 translation regime. The TLB VAE2*
> instructions invalidate the regime that corresponds to the current value
> of HCR_EL2.E2H.
>
> At the moment we only invalidate the EL2 translation regime. This causes
> problems with RMM, which issues TLBI VAE2IS instructions with
> HCR_EL2.E2H enabled. Update vae2_tlbmask() to take HCR_EL2.E2H into
> account.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/helper.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e1b3db6f5f..07a9ac70f5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4663,6 +4663,21 @@ static int vae1_tlbmask(CPUARMState *env)
>      return mask;
>  }
>
> +static int vae2_tlbmask(CPUARMState *env)
> +{
> +    uint64_t hcr = arm_hcr_el2_eff(env);
> +    uint16_t mask;
> +
> +    if (hcr & HCR_E2H) {
> +        mask = ARMMMUIdxBit_E20_2 |
> +               ARMMMUIdxBit_E20_2_PAN |
> +               ARMMMUIdxBit_E20_0;
> +    } else {
> +        mask = ARMMMUIdxBit_E2;
> +    }
> +    return mask;
> +}
> +
>  /* Return 56 if TBI is enabled, 64 otherwise. */
>  static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
>                                uint64_t addr)

> @@ -4838,11 +4853,11 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     uint64_t value)
>  {
>      CPUState *cs = env_cpu(env);
> +    int mask = vae2_tlbmask(env);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>      int bits = tlbbits_for_regime(env, ARMMMUIdx_E2, pageaddr);

Shouldn't the argument to tlbbits_for_regime() also change
if we're dealing with the EL2&0 regime rather than EL2 ?

>
> -    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                  ARMMMUIdxBit_E2, bits);
> +    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
>  }

thanks
-- PMM

