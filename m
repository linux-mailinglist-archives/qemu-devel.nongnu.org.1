Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E573722454
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q689q-0003dS-OU; Mon, 05 Jun 2023 07:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q689i-0003XR-1R; Mon, 05 Jun 2023 07:13:46 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q689f-0004QW-Le; Mon, 05 Jun 2023 07:13:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39aa825c299so1039851b6e.0; 
 Mon, 05 Jun 2023 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685963622; x=1688555622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fudhc+zvwRub03nNrqpw4klgWikX8tWyBKgh3dEKxJ0=;
 b=QrZoYvg5rzIIyb8s7LFrDHVetaU/jZVinXLx/Yi//jRlfmy19fLqHnP7YT9WfoYN54
 t/1M/vTPqjhE4cG7M1yaXCh/YGRlWtP9ca5hz3ctN1yI/U+boiC7Xa2P8NTM1520U+XL
 FUSb08pDFiZinspUZfaEHKLxdO/913bC3mli9dFrKEnUV2ADcjUqMH/eMazlK0Ks9KGC
 1YKW+l9XTu3+YhtAxFQXHwpV64kbYgO+p/RyNtKE+Ww5hLoZ9CHzTZjYr74ZZoZ6bESd
 bOjgG7TT24HT1cWs1OH3KJMNdXjDOaa4ShFVcQgpUOwAXcOGsTdp9voinGUCcj4+TQGG
 EA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963622; x=1688555622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fudhc+zvwRub03nNrqpw4klgWikX8tWyBKgh3dEKxJ0=;
 b=TnpxrPZV2fyE0wquUsMjkcXVvA1cFKojf/wzRjY9KT/v8i75K9W87CGt/4mkidzkHN
 Ph2wV/Ct8vDfpyA+IbwwkohM9ROp1UzPKLlvUNq8au81UUbmyD5pWgqqSDeAOMihtQKF
 gjOgU1Kxte7nPk+RTrL4OPAZYuRPTI44BgQ2oU07xJ5s9E2hTWXVw2jd75SIRGAH/den
 wfI0mUdahrW+sydBXM45DW1gLbYdt5EXNVJK+jq7vnbETIPDBaOmZ+8209j1BP51nKIf
 4vUorOoaG6PJ7KprDjvtB72j70cBTwNz97HVCH8dmUGZZLiW0jnQvHfzeu2MtbC2aVuQ
 jLXg==
X-Gm-Message-State: AC+VfDzSUQxbSu9lqi3P5VT5zsS6I8gigeZwNNU55wYuNRe3Ba0c85ij
 iIo4rEHNPl24LLQ0+kyxmzQSCMjSHyM=
X-Google-Smtp-Source: ACHHUZ4iLFv+nROhpTAebpm4Mu8YbBo8nidx2P/CDWPZl9K65Z2zxdtECUqx8eXV4ptphNUK2oyq5A==
X-Received: by 2002:aca:3b8a:0:b0:39a:2a32:2f3c with SMTP id
 i132-20020aca3b8a000000b0039a2a322f3cmr4119798oia.18.1685963621684; 
 Mon, 05 Jun 2023 04:13:41 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a4aa84d000000b0055afa62ecbcsm17907oom.48.2023.06.05.04.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:13:41 -0700 (PDT)
Message-ID: <0f428560-bb07-5ace-3b9c-dc08fe35dd55@gmail.com>
Date: Mon, 5 Jun 2023 08:13:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] target/ppc: Fix msgclrp interrupt type
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230530130714.373215-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530130714.373215-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/30/23 10:07, Nicholas Piggin wrote:
> msgclrp matches msgsndp and should clear PPC_INTERRUPT_DOORBELL.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   target/ppc/excp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index add2bc6bfe..c13f2afa04 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3068,7 +3068,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
>           return;
>       }
>   
> -    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
> +    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
>   }
>   
>   /*

