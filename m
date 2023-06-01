Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC071F414
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4p8i-0008KJ-KW; Thu, 01 Jun 2023 16:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4p8c-0008J0-P6; Thu, 01 Jun 2023 16:43:14 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4p8F-0005zB-EH; Thu, 01 Jun 2023 16:43:05 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af812703b6so843186a34.1; 
 Thu, 01 Jun 2023 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685652170; x=1688244170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBbqvzQ9PANoSxRwOwh2h1Q8ROC3TUBAnF4UJh7W6r4=;
 b=GQCG0YMjtjUJKzWLonX5AX5d5e1dJJhyfIedIg+9kUKXGTsWFEOb+5ntu+23SqPJH2
 1u6sBk0soNSPR27ZS8m+U1bOUye65o4D36XDqbtd8oGWsppWkI1X3dIB7WdZ7FddWFy+
 HTVOyWgpTmINo58xPYsGcIfGE6yM0mDeIkz7u4q2AyzdY1rDkHE045rGRVGhAnCUGimT
 eVfvj5lzASiFJD+eE4sHV1QArppma6jMDrL2bFj+uOVlk6BAP3m+MSahJ1QxzLNB8Wrv
 3QiLZDqDdEzZj90No3Q+8V9BRFgmszjtsvcc+vfPIgHf1dUOXom/BedLI0zFAoaTq+py
 TBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685652170; x=1688244170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBbqvzQ9PANoSxRwOwh2h1Q8ROC3TUBAnF4UJh7W6r4=;
 b=ZRrC8oZJUhC0Zh2SKIkEUHkWvy4ZJ1RmMqbeYcimxz/QRMD/uWIRHBbEPM/TOC43Fm
 g+3M++B5CQuU4tBbty6FZYK+pESB8vCO3z1O9PWsLG2ZBe+wp4eatB0t6n2GljLe/L+U
 QtWY0WHsNBRgwMdR2Fi1GF9nUq5U9wZdfKKUWHTHQ+R35EVQWQVc3asCD1VxztVOivH1
 pQdPiDA81yuBckNimb7JlBDPgKlb6dhvQyzyZJBAT4ixKBjusHzqPMwOJE9WZ7QzbLHM
 ByzD4jkFs0Ya+cisMeeiLu7o6kbuwkWo3tuCVn9sFq8OhAeuNLk2S4PiK8gWRzcNPHRo
 tIhg==
X-Gm-Message-State: AC+VfDwyQ5ggYzWy9Xn91b5pJRg22Bo3U17KhXG4PVOOqduKyWOpEbI9
 pugdGt9bIN0dorhs6NdZDSs=
X-Google-Smtp-Source: ACHHUZ73iWx29coWA3MIRPIJqV2AZix22D0SBhcZqx3tDJxj7Hfhu2h3cGU7TD99PfVePrIiDEuRpQ==
X-Received: by 2002:a05:6830:1e2b:b0:6af:a4b8:28d with SMTP id
 t11-20020a0568301e2b00b006afa4b8028dmr497864otr.21.1685652169673; 
 Thu, 01 Jun 2023 13:42:49 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 z23-20020a05683020d700b006abb3b660a9sm1899155otq.54.2023.06.01.13.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:42:49 -0700 (PDT)
Message-ID: <a1a2262d-5a1d-9779-6f26-99e02845636d@gmail.com>
Date: Thu, 1 Jun 2023 17:42:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] target/ppc: Fix nested-hv HEAI delivery
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, balaton@eik.bme.hu,
 Fabiano Rosas <farosas@suse.de>
References: <20230530132127.385001-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530132127.385001-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 5/30/23 10:21, Nicholas Piggin wrote:
> ppc hypervisors turn HEAI interrupts into program interrupts injected
> into the guest that executed the illegal instruction, if the hypervisor
> doesn't handle it some other way.
> 
> The nested-hv implementation failed to account for this HEAI->program
> conversion. The virtual hypervisor wants to see the HEAI when running
> a nested guest, so that interrupt type can be returned to its KVM
> caller.
> 
> Fixes: 7cebc5db2eba6 ("target/ppc: Introduce a vhyp framework for nested HV support")
> Cc: balaton@eik.bme.hu
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Address review comments style and typo fixes
> 
>   target/ppc/excp_helper.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d69bd0033a..0f7ed58673 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1387,9 +1387,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   
>       /*
>        * We don't want to generate a Hypervisor Emulation Assistance
> -     * Interrupt if we don't have HVB in msr_mask (PAPR mode).
> +     * Interrupt if we don't have HVB in msr_mask (PAPR mode),
> +     * unless running a nested-hv guest, in which case the L1
> +     * kernel wants the interrupt.
>        */
> -    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB)) {
> +    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB) &&
> +            !books_vhyp_handles_hv_excp(cpu)) {
>           excp = POWERPC_EXCP_PROGRAM;
>       }
>   

