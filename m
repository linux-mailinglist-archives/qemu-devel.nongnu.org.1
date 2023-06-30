Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C274401C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:50:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHJN-00022I-4I; Fri, 30 Jun 2023 12:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHJJ-00021l-VE; Fri, 30 Jun 2023 12:49:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHJI-0002Th-7T; Fri, 30 Jun 2023 12:49:29 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b74791c948so1802206a34.3; 
 Fri, 30 Jun 2023 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143765; x=1690735765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AKBfE/lCzzsqroQioDFn3+wZcYbXA0Ucc6pGsiUD0A=;
 b=PizNKstDRv8sCgWpl185T6itk7rmMuv2y0o7cQ/EW8ruwRN9Tx+PeXVtPqOtFzAwSE
 DtqxQ8RecYZWPnvK3hPRPFE62ItxDcXTlYc6AIn2P+8tpi2WZfAo8BOMGzz/wkSMsk26
 ybnnhd08ifRxqqGxDtNjPxWCWbQ6Hecur8r+EFGgX1di+YSqkCTsKj1wSbDe1qvKZxub
 m3ts6GJOSp96SBowfTNRA4hiqT9doHlzYS5Tm1WkqZy07qE54onmsmnM78SmPI0qQmR/
 26qxaU5TRRdlPbsGIgawADMdIl8mTxg1icMc/nTvMZzwG+QcEXhGT3MJGqrD7GGxHJwZ
 1seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143765; x=1690735765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AKBfE/lCzzsqroQioDFn3+wZcYbXA0Ucc6pGsiUD0A=;
 b=WNkeaOMOp3lK1sJBQ0ZqrmT3CehtaHAUQ83+7+tyoxpzJYiZhXhzsGyM0rUF1eFghU
 4QeSGM4GslIKHdWTdyfiN0Z7KllnRbNofKs/+qqLubbiV1FUpZRSlIUcYGIqqsJYNHn/
 keqJkJAiXCASNvIaP5QVvbKlOrwpsJQSSjg3KyO8uySmwOTvXl/LiOfV0QpXEsJy2i+P
 KvYo5wmKR62/K6C7V26jKgNczweyzcDAB+Dy4EhcVMFeJSwS7cGBehCnenoOYsBd/Heu
 06kBn10gYP51DaeYCt62iZaaNDM9v0VBbBxwBpmat6qkaHGw/0sr+e1waTP6t1/KCYmj
 lePg==
X-Gm-Message-State: AC+VfDwu3I1csgohJE42sPOCJ8he5DP11cdxTo0rfg64LSKOQXfDnr2T
 Bq5R6bfA1FNuAG74KrBKHEgtJlR6tio=
X-Google-Smtp-Source: ACHHUZ4PITWerPsMDjXkfAgrAkMYKWY3W9QldrjidiMy/S227dbSWV3ElJwX1hMK4sVKzBJuRGNQ+A==
X-Received: by 2002:a9d:7412:0:b0:6b3:70ee:3055 with SMTP id
 n18-20020a9d7412000000b006b370ee3055mr3616011otk.13.1688143765544; 
 Fri, 30 Jun 2023 09:49:25 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 m23-20020a9d7ad7000000b006b74e370a10sm4898223otn.66.2023.06.30.09.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:49:25 -0700 (PDT)
Message-ID: <b4bd0fed-ffff-e4ec-1a04-991fffa7a057@gmail.com>
Date: Fri, 30 Jun 2023 13:49:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/ppc: Fix clock update drift
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org
References: <20230629020713.327745-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230629020713.327745-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/28/23 23:07, Nicholas Piggin wrote:
> The clock update logic reads the clock twice to compute the new clock
> value, with a value derived from the later time subtracted from a value
> derived from the earlier time. The delta causes time to be lost.
> 
> This can ultimately result in time becoming unsynchronized between CPUs
> and that can cause OS lockups, timeouts, watchdogs, etc. This can be
> seen running a KVM guest (that causes lots of TB updates) on a powernv
> SMP machine.
> 
> Fix this by reading the clock once.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next after adding the "Fixes"
tag Cedric mentioned. Thanks,


Daniel

> I also made a test case that can trigger this with kvm-unit-tests, but
> it's been taking me a while to get that upstreamed.
> 
> Thanks,
> Nick
> 
>   hw/ppc/ppc.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 82e4408c5c..6233f43c01 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -535,23 +535,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
>   void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0xFFFFFFFF00000000ULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, tb | (uint64_t)value);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb | (uint64_t)value);
>   }
>   
>   static inline void _cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0x00000000FFFFFFFFULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, ((uint64_t)value << 32) | tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset,
> +                     ((uint64_t)value << 32) | tb);
>   }
>   
>   void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value)
> @@ -584,23 +585,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
>   void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
>       tb &= 0xFFFFFFFF00000000ULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->atb_offset, tb | (uint64_t)value);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset, tb | (uint64_t)value);
>   }
>   
>   void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
>       tb &= 0x00000000FFFFFFFFULL;
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset,
> +                     ((uint64_t)value << 32) | tb);
>   }
>   
>   uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
> @@ -622,14 +624,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
>   void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
>   {
>       ppc_tb_t *tb_env = env->tb_env;
> +    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       uint64_t tb;
>   
> -    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                        tb_env->tb_offset);
> +    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
>       tb &= 0xFFFFFFUL;
>       tb |= (value & ~0xFFFFFFUL);
> -    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                     &tb_env->tb_offset, tb);
> +    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb);
>   }
>   
>   static void cpu_ppc_tb_stop (CPUPPCState *env)

