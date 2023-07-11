Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839074EC3A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 13:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJBBa-0007rO-8x; Tue, 11 Jul 2023 07:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qJBBY-0007qZ-2C
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:05:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qJBBW-0008VK-4R
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:05:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so56133925e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689073532; x=1691665532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VC4By7XtJAhNMlzzeJnWM3UmwzNBCdO6Wa8WUY/BA5U=;
 b=j6wfynPPvngXjj2YnafkHlLNE6kWtXZO0jisf6BCLiGqFlcLcZO8garNVvsgCaxS6w
 MkveB+iujpfAl8u8O3hM44lgD2shVcGhlN0l/xwoM2rfmsX2F+RxCeL0cxvnbEH5B5fV
 RZq2n7oF787LoHUpdRz67LmJWkLyubKBqNuCHU/R+2ieDdHmII/bPZ3mIgUp0HemM0s4
 ftQzTCDMBcJqIFZepxrwnDV2Hy/Ozc0Hf4Sa+nXW++Dr7aXxXocsc/wZZs0QllTfjyhT
 GxPTnSf0s66tFdooqawzPrBuQebsfsBVusASxVKG0gTs1tMQteGZyfugyS1z+NYJEVBV
 ilQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689073532; x=1691665532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VC4By7XtJAhNMlzzeJnWM3UmwzNBCdO6Wa8WUY/BA5U=;
 b=N1yFSMCA4e8Ph91GvLiRQXQtfUhascwmjYcZuGRL/54V47Ik3gL8K0oD/45ylf66If
 RAFSgq9qZqCC5MfiHaOi0HHFcKc6zHuoyc3tgDa/SRTDPnQ07Ez+7lzd+FvIHsDnhJUu
 aGI6s6KTTBZwhGv0OU7BZaMuQuxuYYx/Lcae1MWL9Ck9bJe8T0KMBEfbrTEVepI3FClv
 WYXrelFNEZwG6xOFigu9XEK8ofA+CqfY1kLsSxTk+XHZWe2KG3+nrJZo2nX2N7zXMxun
 s/8zQqmbp80qpaZSZ6boQpMSKaCAPta1Yx6jFSMm0zrxDKdtbSuT3tb+PKvhm88vcas7
 9Vzw==
X-Gm-Message-State: ABy/qLaRXGbb+kw+UVTnyYBQs/IlmBPqYIagpBjFuLiIH1ej7GmUB0X8
 r8ctSNgikCs1a1uXZferWgaoMg==
X-Google-Smtp-Source: APBJJlFh1wGLywIY4E/Wn//w3I0CvVnNcWEvOBxTqzJbh/uI2vhq9E4FE3Y5R2GhH6fv1P6i5GS3Sw==
X-Received: by 2002:a05:600c:3644:b0:3fc:627:ea31 with SMTP id
 y4-20020a05600c364400b003fc0627ea31mr9227415wmq.38.1689073532149; 
 Tue, 11 Jul 2023 04:05:32 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 h25-20020a1ccc19000000b003fbcf032c55sm12812935wmb.7.2023.07.11.04.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 04:05:31 -0700 (PDT)
Date: Tue, 11 Jul 2023 12:05:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-8.1 2/3] target/arm: Fix S1_ptw_translate() debug path
Message-ID: <20230711110531.GA201871@myrica>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
 <20230710152130.3928330-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710152130.3928330-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32e.google.com
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

On Mon, Jul 10, 2023 at 04:21:29PM +0100, Peter Maydell wrote:
> In commit XXX we rearranged the logic in S1_ptw_translate() so that
> the debug-access "call get_phys_addr_*" codepath is used both when S1
> is doing ptw reads from stage 2 and when it is doing ptw reads from
> physical memory.  However, we didn't update the calculation of
> s2ptw->in_space and s2ptw->in_secure to account for the "ptw reads
> from physical memory" case.  This meant that debug accesses when in
> Secure state broke.
> 
> Create a new function S2_security_space() which returns the
> correct security space to use for the ptw load, and use it to
> determine the correct .in_secure and .in_space fields for the
> stage 2 lookup for the ptw load.
> 
> Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, this fixes tf-a boot with semihosting

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  target/arm/ptw.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 21749375f97..c0b9cee5843 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -485,11 +485,39 @@ static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
>      }
>  }
>  
> +static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
> +                                          ARMMMUIdx s2_mmu_idx)
> +{
> +    /*
> +     * Return the security space to use for stage 2 when doing
> +     * the S1 page table descriptor load.
> +     */
> +    if (regime_is_stage2(s2_mmu_idx)) {
> +        /*
> +         * The security space for ptw reads is almost always the same
> +         * as that of the security space of the stage 1 translation.
> +         * The only exception is when stage 1 is Secure; in that case
> +         * the ptw read might be to the Secure or the NonSecure space
> +         * (but never Realm or Root), and the s2_mmu_idx tells us which.
> +         * Root translations are always single-stage.
> +         */
> +        if (s1_space == ARMSS_Secure) {
> +            return arm_secure_to_space(s2_mmu_idx == ARMMMUIdx_Stage2_S);
> +        } else {
> +            assert(s2_mmu_idx != ARMMMUIdx_Stage2_S);
> +            assert(s1_space != ARMSS_Root);
> +            return s1_space;
> +        }
> +    } else {
> +        /* ptw loads are from phys: the mmu idx itself says which space */
> +        return arm_phys_to_space(s2_mmu_idx);
> +    }
> +}
> +
>  /* Translate a S1 pagetable walk through S2 if needed.  */
>  static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
>                               hwaddr addr, ARMMMUFaultInfo *fi)
>  {
> -    ARMSecuritySpace space = ptw->in_space;
>      bool is_secure = ptw->in_secure;
>      ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
>      ARMMMUIdx s2_mmu_idx = ptw->in_ptw_idx;
> @@ -502,13 +530,12 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
>           * From gdbstub, do not use softmmu so that we don't modify the
>           * state of the cpu at all, including softmmu tlb contents.
>           */
> +        ARMSecuritySpace s2_space = S2_security_space(ptw->in_space, s2_mmu_idx);
>          S1Translate s2ptw = {
>              .in_mmu_idx = s2_mmu_idx,
>              .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
> -            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
> -            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
> -                         : space == ARMSS_Realm ? ARMSS_Realm
> -                         : ARMSS_NonSecure),
> +            .in_secure = arm_space_is_secure(s2_space),
> +            .in_space = s2_space,
>              .in_debug = true,
>          };
>          GetPhysAddrResult s2 = { };
> -- 
> 2.34.1
> 

