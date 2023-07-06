Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6195749F10
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPyY-0000w6-2T; Thu, 06 Jul 2023 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHPyR-0000vc-Bm
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:28:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHPyP-0006YC-6U
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:28:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51e344efd75so974844a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688653723; x=1691245723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qLS1hwBQH5ErHG6O5e6dliXGtwv264wz9BRHClS/Nuo=;
 b=ZZkQh+bTR0BRdeUEf2KPPRezN6Q31G4PlHV0w7d74bPonnOHcBXpohpCxKzI4cD+c8
 JnXWUcqKzj5e7vuPYiXZupkF5N1D+wMHcjDU96tFDXUyGOzxzZQoQi2WnTyCC5owPOMg
 j9yORUnDbtELcX5bhR7gDMwGlaHcQdWo0CeNGYB8WG9rmzQQPMijkMhKl5nmhPJ3lTUw
 O8hj9yD+vDQhu6iiD02GmJeccai2fbMcA1yr79Fhk/W+rkML+pLRxA9TogvOTwF3mRzo
 IfsdRbzM0CzanQfC0dr47mA7G4lNzkhj19LRnwLSrCJD3pHBHnYSbwIrviC0Jlr7aVpR
 bd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688653723; x=1691245723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLS1hwBQH5ErHG6O5e6dliXGtwv264wz9BRHClS/Nuo=;
 b=YwjJYpiFw6q5L2BcAxvwH2Vq4RLncUfDLh0GCUlXnle0bCJwKB84KpwXTuBiTvVlz/
 FAdkTb7qZDRTpT4eS7oCjTmYDqcYyGhrt6fsBh0XpSYR7/Ov2dTc+crxN8LYrWDZAbU9
 jmxazxO17E0a5dMhywrJRcNaB3nUyi0ZFKaWhJ2RH9zrkwYE0oh+LDL/OQG8enxKii9Z
 IRBAgb/rELWe3t6tr3AZ2JuhKEIYDQun8xiduZKtq7JXfqEt/rmOzxPeuCD2fVuD+zyh
 06sl7oVWhJsIAxD1zIhVdYSmvT0UzTaZVcL03SkuKh5uiP5P9AvK/x5doRjdi0WGhT1s
 czlA==
X-Gm-Message-State: ABy/qLYH1Rlk16BO9FI0H1pCsr0dRZF+CPrJ6drndPppfar5o6dlahaY
 g4uyoK4BeOP60Zwi/G507QIO1cXCPVBkFSiIQLbmPQ==
X-Google-Smtp-Source: APBJJlFL1guKJxRESHMrVAiXfs3e0CzLMG1gI3KftrTbMENO7WtfdfNXNJ/E2HZ0lolyZc9WcqosfgyeDWkqPjtzZU4=
X-Received: by 2002:a05:6402:1355:b0:51e:fb9:7615 with SMTP id
 y21-20020a056402135500b0051e0fb97615mr2522636edw.13.1688653723095; Thu, 06
 Jul 2023 07:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230706140850.3007762-2-jean-philippe@linaro.org>
In-Reply-To: <20230706140850.3007762-2-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 15:28:32 +0100
Message-ID: <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 6 Jul 2023 at 15:12, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Arm TF-A fails to boot via semihosting following a recent change to the
> MMU code. Semihosting attempts to read parameters passed by TF-A in
> secure RAM via cpu_memory_rw_debug(). While performing the S1
> translation, we call S1_ptw_translate() on the page table descriptor
> address, with an MMU index of ARMMMUIdx_Phys_S. At the moment
> S1_ptw_translate() doesn't interpret this as a secure access, and as a
> result we attempt to read the page table descriptor from the non-secure
> address space, which fails.
>
> Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> I'm not entirely sure why the semihosting parameters are accessed
> through stage-1 translation rather than directly as physical addresses,
> but I'm not familiar with semihosting.

The semihosting ABI says the guest code should pass "a pointer
to the parameter block". It doesn't say explicitly, but the
straightforward interpretation is "a pointer that the guest
itself could dereference to read/write the values", which means
a virtual address, not a physical one. It would be pretty
painful for the guest to have to figure out "what is the
physaddr for this virtual address" to pass it to the semihosting
call.

Do you have a repro case for this bug? Did it work
before commit fe4a5472ccd6 ?

> ---
>  target/arm/ptw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 9aaff1546a..e3a738c28e 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -465,10 +465,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
>          S1Translate s2ptw = {
>              .in_mmu_idx = s2_mmu_idx,
>              .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
> -            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
> -            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
> -                         : space == ARMSS_Realm ? ARMSS_Realm
> -                         : ARMSS_NonSecure),
> +            .in_secure = is_secure,
> +            .in_space = space,

If the problem is fe4a5472ccd6 then this seems an odd change to
be making, because in_secure and in_space were set that way
before that commit too...

>              .in_debug = true,
>          };
>          GetPhysAddrResult s2 = { };

thanks
-- PMM

