Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FC77EBA6
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNxO-00076I-21; Wed, 16 Aug 2023 17:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWNxK-00075Y-UN
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:21:31 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWNxI-0001zT-JN
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:21:30 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so979515566b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692220886; x=1692825686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dI8M8E50TucM0b5tzWL6D3S9g3Wk9MstbRQeMn3cl68=;
 b=RaB+zezOxNTwNzKhL5EAY0JREIjwsN6yR3xkFkP08hd7VdeRwryAD4EcqqDl4FydB1
 RGbXBEt8eaVU+KpSsyhgSh9lWTyZbmA25oFzdn1h1GxrkzVkrIWiM17WcmzzxKEmSUHK
 gfe09Sxzd5THsdpMJiX+rOVa/7H6A6Ex+S7O7TRujUM4Qg3lQe8ICusX0TrFdd8qUG+3
 PdjTxwFZZbfvsF2HD2/I7uEA3PdCCBnHsMklQT0VaZTvJB8BoEdgh9Gg0JlEenDleUOO
 nt4Pmo45l/fUy9T9pqbsK2b+KEa1y4h4EebnhdLSuX/LQkVlf4kPpxgPCnwroDw315XP
 RNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692220886; x=1692825686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dI8M8E50TucM0b5tzWL6D3S9g3Wk9MstbRQeMn3cl68=;
 b=gsyZTRrg6dtteP4TCObzTxdcdBHe3ZT/VArlnnD1TYW305MMgaEkCW6idFqpIx1bs4
 8nE+QaXGiLDdnmGJeqJ8qr7IsOUgFS5nEBCCBh+cT9UZY32Ey+LJhJjYAzSbC/kJg3iW
 /Wcu0KZUZmEHvI+Kqh8b0NTMIkQZfcoOc82zjtGcBGobr/dfrPJP8QizSI7Nrb8oI7XB
 KKEOgcqIq0a/GSwwsAhsLsXObZXA3p33U0ctxw2FBH9bTI32/0Sq0lpaCpuiAI+I/rxb
 x4Y0ZprXe6idun9bk3DmHg+6LIYsqTsxJa58oraR6U1f128b2vO4eA8Yg0gmDrhV+hPl
 GHMQ==
X-Gm-Message-State: AOJu0YwhG8gHIE0KDHvhtmTlboD8Z08hQ0AcwJhWVMonokELEt9mE2gO
 0dEEucNyCNqqU2KlDc8tO0mIVw==
X-Google-Smtp-Source: AGHT+IGXGP2m19K7mN8WpgQNso5tORSuuB7qioOoVefvc2qq+96Qbu0vwjUGfja84+L+PF5w4VfW4g==
X-Received: by 2002:a17:907:7845:b0:99c:b0c9:4ec0 with SMTP id
 lb5-20020a170907784500b0099cb0c94ec0mr2336542ejc.30.1692220886084; 
 Wed, 16 Aug 2023 14:21:26 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 v26-20020a1709060b5a00b00985bdb7dd5fsm8931446ejg.201.2023.08.16.14.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 14:21:25 -0700 (PDT)
Message-ID: <037612bf-3773-d522-712d-d3cf50d946e0@linaro.org>
Date: Wed, 16 Aug 2023 23:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/riscv: Allocate itrigger timers only once
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20230816162717.44125-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816162717.44125-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 18:27, Akihiko Odaki wrote:
> riscv_trigger_init() had been called on reset events that can happen
> several times for a CPU and it allocated timers for itrigger. If old
> timers were present, they were simply overwritten by the new timers,
> resulting in a memory leak.
> 
> Divide riscv_trigger_init() into two functions, namely
> riscv_trigger_realize() and riscv_trigger_reset() and call them in
> appropriate timing. The timer allocation will happen only once for a
> CPU in riscv_trigger_realize().
> 
> Fixes: 5a4ae64cac ("target/riscv: Add itrigger support when icount is enabled")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/riscv/debug.h |  3 ++-
>   target/riscv/cpu.c   |  8 +++++++-
>   target/riscv/debug.c | 15 ++++++++++++---
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index c471748d5a..7edc31e7cc 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -143,7 +143,8 @@ void riscv_cpu_debug_excp_handler(CPUState *cs);
>   bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
>   bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
>   
> -void riscv_trigger_init(CPURISCVState *env);
> +void riscv_trigger_realize(CPURISCVState *env);
> +void riscv_trigger_reset(CPURISCVState *env);
>   
>   bool riscv_itrigger_enabled(CPURISCVState *env);
>   void riscv_itrigger_update_priv(CPURISCVState *env);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e12b6ef7f6..3bc3f96a58 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -904,7 +904,7 @@ static void riscv_cpu_reset_hold(Object *obj)
>   
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->cfg.debug) {
> -        riscv_trigger_init(env);
> +        riscv_trigger_reset(env);

Maybe name _reset_hold()? Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }


