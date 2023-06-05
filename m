Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD4772279A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AOs-0002OT-7q; Mon, 05 Jun 2023 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6AOq-0002O9-V2; Mon, 05 Jun 2023 09:37:32 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6AOp-000869-BF; Mon, 05 Jun 2023 09:37:32 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-39aa4919a57so1710446b6e.0; 
 Mon, 05 Jun 2023 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972249; x=1688564249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ShlrajO+6907qohRS4My1KIYLyTLXEXpjqkMDM/q8HI=;
 b=mxrRG0TXN65SfD/VLmT9BqYRvFyc6rEtSqbEGbtvRMBq8UR9AGVaXdRJiFut3X1641
 XwG+WCsigdVHQ0xmBLU5FH3ypxvn3AxSmxnhPCsFATrChDt9oCf2T0gSjJB7VAWjbd4P
 bHhH351xpYJT1oLcztx0RCa2vgK1nKWYrbT/dYIlSlhA1aOTXjHx7G9vYTL+s5go64Jh
 +oc4xUzLFzjvtJa2vgDlx2ZRNDjcb7HTZYdwSobV1dwmGVBWbAhohZO71f9F7Wygmqcx
 kSelnED/4iTvnWB98exYbInffmU6yhEYDyhrJgQIYKpWBeIr9ZE9Y5iPw/CHdRjfRW5k
 v+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972249; x=1688564249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ShlrajO+6907qohRS4My1KIYLyTLXEXpjqkMDM/q8HI=;
 b=NavsEFS49FYL7P9Q53c7P0jq1MIGVwwB54Y8yAlQZKAid62/9MfcDyij7QInRRsjNK
 MCKTCr9/np31op9tDoXVC/Is2gLQtoegCDCi7kzbHARlLCKv8Xu7fGNZM/16gd6QulGW
 iPg1jqLrNAP3mXtom9ACOZE7nu+kNzB1qkhMn61WHwmW+IbVsGEvgFgFGn3+cwrAlT62
 wpTP+uJHpgPUEmlbWiEkurNHW4FxPMOg7DY5XWrNzzwJ9Gj0SiSOoNsLxtMGNc1Ie/9I
 ahWPVs/dbJkVKig9WykxaEb6RMlDhjWqTW+ISOQumxuktbiu/CR2bAZ8F7CUF3o84E4N
 tYLw==
X-Gm-Message-State: AC+VfDxYwW0w8yPf4Y6osmQyVezzZg9u41D1ozUaeaB+euA3yDMEVSgb
 j6NSLxm64kr1giXhm3W9WhA=
X-Google-Smtp-Source: ACHHUZ7CJnU3zezNVd4oaUpGEQW0HP1IBLrh3YlzIjm7PnxHWKgU+Tg97y/aU/x+MkFdrBeEVxIweQ==
X-Received: by 2002:a05:6808:44:b0:393:fb3e:6151 with SMTP id
 v4-20020a056808004400b00393fb3e6151mr7188400oic.50.1685972249273; 
 Mon, 05 Jun 2023 06:37:29 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05680808c600b0039aab5cee6csm1435069oij.11.2023.06.05.06.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:37:28 -0700 (PDT)
Message-ID: <cc967aa7-2c96-b091-cda2-7e290500e0d9@gmail.com>
Date: Mon, 5 Jun 2023 10:37:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] target/ppc: Eliminate goto in mmubooke_check_tlb()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <bd84d5f38af0ba2983ccd5c07635db49267c828f.1685448535.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <bd84d5f38af0ba2983ccd5c07635db49267c828f.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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



On 5/30/23 10:28, BALATON Zoltan wrote:
> Move out checking PID registers into a separate function which makes
> mmubooke_check_tlb() simpler and avoids using goto.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   target/ppc/mmu_common.c | 40 +++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index bd7d7d5257..ae1db6e348 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -601,37 +601,39 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>       return ret;
>   }
>   
> -static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                              hwaddr *raddr, int *prot, target_ulong address,
> -                              MMUAccessType access_type, int i)
> +static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                               hwaddr *raddr, target_ulong addr, int i)
>   {
> -    int prot2;
> -
> -    if (ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID], i)) {
> +    if (ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID], i)) {
>           if (!env->nb_pids) {
>               /* Extend the physical address to 36 bits */
>               *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
>           }
> -        goto found_tlb;
> +        return true;
> +    } else if (!env->nb_pids) {
> +        return false;
>       }
> -
>       if (env->spr[SPR_BOOKE_PID1] &&
> -        ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID1], i)) {
> -        goto found_tlb;
> +        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID1], i)) {
> +        return true;
>       }
> -
>       if (env->spr[SPR_BOOKE_PID2] &&
> -        ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID2], i)) {
> -        goto found_tlb;
> +        ppcemb_tlb_check(env, tlb, raddr, addr, env->spr[SPR_BOOKE_PID2], i)) {
> +        return true;
>       }
> +    return false;
> +}
>   
> -     qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
> -    return -1;
> +static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                              hwaddr *raddr, int *prot, target_ulong address,
> +                              MMUAccessType access_type, int i)
> +{
> +    int prot2;
>   
> -found_tlb:
> +    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
> +        return -1;
> +    }
>   
>       if (FIELD_EX64(env->msr, MSR, PR)) {
>           prot2 = tlb->prot & 0xF;

