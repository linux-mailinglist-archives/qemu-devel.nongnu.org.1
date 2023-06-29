Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0B741FE6
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 07:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEkDM-0000eU-9X; Thu, 29 Jun 2023 01:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEkDK-0000eH-Ox; Thu, 29 Jun 2023 01:29:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEkDI-0003Dd-Ln; Thu, 29 Jun 2023 01:29:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qs6SY5Prkz4whk;
 Thu, 29 Jun 2023 15:29:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qs6SW2SnSz4wgk;
 Thu, 29 Jun 2023 15:28:59 +1000 (AEST)
Message-ID: <8ba47cb9-00a8-8c22-ccda-b7dc1fefc5af@kaod.org>
Date: Thu, 29 Jun 2023 07:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/ppc: Simplify clock update arithmetic
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625122012.15503-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230625122012.15503-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/25/23 14:20, Nicholas Piggin wrote:
> The clock update logic reads the clock twice to compute the new clock
> value, with a value derived from the later time subtracted from a value
> derived from the earlier time. This can lead to an underflow in
> subtractions in bits that are intended to cancel exactly. This might
> not cause any real problem, but it is more complicated than necessary
> to reason about.
> 
> Simplify this by reading the clock once.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This patch has ben superseded by

  https://patchwork.ozlabs.org/project/qemu-ppc/patch/20230629020713.327745-1-npiggin@gmail.com/

It is nice to add a v2 prefix, even if you change the change the subject.

Thanks,

C.


> ---
>   hw/ppc/ppc.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index f4fe1767d6..5d0a09eb5e 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -536,23 +536,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
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
> @@ -585,23 +586,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
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
> @@ -623,14 +625,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
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


