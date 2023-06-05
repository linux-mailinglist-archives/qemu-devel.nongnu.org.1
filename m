Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 118377227A2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AQJ-0004Mw-IV; Mon, 05 Jun 2023 09:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6AQ9-0004H3-8n; Mon, 05 Jun 2023 09:38:53 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6AQ6-0000BD-0M; Mon, 05 Jun 2023 09:38:51 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-558a79941c6so1173479eaf.3; 
 Mon, 05 Jun 2023 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972328; x=1688564328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUR2yEZSVTNI77eBJe0mhhFej07BeHpbDdGo5Xbp2oY=;
 b=ZRdVBzQpOE8Ep0aUt9kk6VqRCWFeH5Ihc1vZG3kv5NT0/QIhWV8g7jjUw4HHY1KdhQ
 7CNcgxoM0Z9t6I07PnDP2NHg4fNM50dlOgjneAaLBovJ3iSni4XqMvBnJ2829w9pzzLO
 EorOGWC0e68xse51IOWKSMAAUa9KuVKCGtqXFUoUUbV9bAAO8qFfLxebM3rtxga+1f45
 6ORBZppjHmFd6kNAS9Y59q8mmO5SmJseZXZEJlnC+ocYQABZJank0jLCdSdJ/4NrjR4S
 R3DknfPsaVIxBylAb5hHtFT8jGdvHmreu0bKsCZDVp506WTTDGsmp/SE0Jfee1sMJMl2
 ogsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972328; x=1688564328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUR2yEZSVTNI77eBJe0mhhFej07BeHpbDdGo5Xbp2oY=;
 b=hXoP5Uwpz3nGVwu1gipe9N4sStTR/e+4r5EWGMXEfLqy0tmHyQoQHqJdL6N7ImhVVU
 toULzlkvI26rcMrkOrZK9N90HgrnhjDQ1SphnQH170iwRr7XxdPm3YayZoOAvcOtQgz8
 eAaYWPj1ViHETRezBTebYgUBldXNVnuuVLViJZdnCdDJDJZ6Ctk+zIF2eADJmNtvRHwg
 2MVCSa365mnAe4IlvEpJsOxukQlwOC/QRwx2osEKrGRCcyTaJHn+e0ytSBryWMb4aY2a
 Q/34+zZyhfQiHKeJJJmGldaJwC4k/ir8uNNf817qskWSjKHgTVmobveRZHQIXC0s1kTb
 EsKg==
X-Gm-Message-State: AC+VfDxowxfqqtStVGgzeGBm6CZ878HUBnjeZawi9LUq131tXRyIbh6O
 CAuHiF1FoZ8HANl7m79kkvg=
X-Google-Smtp-Source: ACHHUZ7qXURAxpv7mA0aKElGFy6B8DiSquJ4QXs5BW1WF975eu3svRF6ubYPej+Om9O4VL3ONJ5AwA==
X-Received: by 2002:a4a:e04a:0:b0:558:b224:ce9f with SMTP id
 v10-20020a4ae04a000000b00558b224ce9fmr3902786oos.7.1685972328335; 
 Mon, 05 Jun 2023 06:38:48 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 cg24-20020a056820099800b00545442d89b3sm3132553oob.23.2023.06.05.06.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:38:48 -0700 (PDT)
Message-ID: <3cfc94af-8abe-2fef-7cdd-c2c046901d56@gmail.com>
Date: Mon, 5 Jun 2023 10:38:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] target/ppc: Decrementer fix BookE semantics
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
References: <20230530131214.373524-1-npiggin@gmail.com>
 <20230530131214.373524-2-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530131214.373524-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc30.google.com
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



On 5/30/23 10:12, Nicholas Piggin wrote:
> The decrementer store function has logic that short-cuts the timer if a
> very small value is stored (0, 1, or 2) and raises an interrupt
> directly. There are two problem with this on BookE.
> 
> First is that BookE says a decrementer interrupt should not be raised
> on a store of 0, only of a decrement from 1. Second is that raising
> the irq directly will bypass the auto-reload logic in the booke decr
> timer function, breaking autoreload when 1 or 2 is stored.
> 
> Fix this by removing that small-value special case. It makes this
> tricky logic even more difficult to reason about, and it hardly matters
> for performance.
> 
> Cc: sdicaro@DDCI.com
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued.


Daniel


> These were some booke decrementer corner case issues I saw, probably
> a little less important than the first patch so could go later.
> 
> Thanks,
> Nick
> 
>   hw/ppc/ppc.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index d80b0adc6c..1b1220c423 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -811,11 +811,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>       }
>   
>       /*
> -     * Going from 2 -> 1, 1 -> 0 or 0 -> -1 is the event to generate a DEC
> -     * interrupt.
> -     *
> -     * If we get a really small DEC value, we can assume that by the time we
> -     * handled it we should inject an interrupt already.
> +     * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
>        *
>        * On MSB level based DEC implementations the MSB always means the interrupt
>        * is pending, so raise it on those.
> @@ -823,8 +819,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>        * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
>        * an edge interrupt, so raise it here too.
>        */
> -    if ((value < 3) ||
> -        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +    if (((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>           ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>             && signed_decr >= 0)) {
>           (*raise_excp)(cpu);

