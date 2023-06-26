Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3473D8D4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgyk-0001UP-GD; Mon, 26 Jun 2023 03:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDgyd-0001RH-MI; Mon, 26 Jun 2023 03:49:35 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDgyb-0002ul-4f; Mon, 26 Jun 2023 03:49:35 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id A40E044C100A;
 Mon, 26 Jun 2023 07:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A40E044C100A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1687765770;
 bh=gtdkfKoWG+fbtYKJlaeWCjxAp6pFWPNh0ibSILhOsok=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e2rXYXKSDgI2DYknJxJkWQ8J+8bHE/AX6LVvz10boybqKgiM4OkZsQytn9fLUj1BI
 wUU64xD2Up0vqEVtqRobYmBIwH0J/uG6wZzk1bjXP/d80dtF5LLqh8BEBEqnmYmchj
 7kJeQ/N56iCyjoQIyuiaGafzc2AxT3tqFKX+8Kkk=
Message-ID: <c09f759c-b8e8-b603-d6ae-85b003813b7a@ispras.ru>
Date: Mon, 26 Jun 2023 10:49:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] target/ppc: Fix CPU reservation migration for
 record-replay
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-2-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230623125707.323517-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 23.06.2023 15:57, Nicholas Piggin wrote:
> ppc only migrates reserve_addr, so the destination machine can get a
> valid reservation with an incorrect reservation value of 0. Prior to
> commit 392d328abe753 ("target/ppc: Ensure stcx size matches larx"),
> this could permit a stcx. to incorrectly succeed. That commit
> inadvertently fixed that bug because the target machine starts with an
> impossible reservation size of 0, so any stcx. will fail.
> 
> This behaviour is permitted by the ISA because reservation loss may
> have implementation-dependent cause. What's more, with KVM machines it
> is impossible save or reasonably restore reservation state. However if
> the vmstate is being used for record-replay, the reservation must be
> saved and restored exactly in order for execution from snapshot to
> match the record.
> 
> This patch deprecates the existing incomplete reserve_addr vmstate,
> and adds a new vmstate subsection with complete reservation state.
> The new vmstate is needed only when record-replay mode is active.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu.h       |  2 ++
>   target/ppc/machine.c   | 26 ++++++++++++++++++++++++--
>   target/ppc/translate.c |  2 ++
>   3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4138a25801..0087ce66e2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1119,7 +1119,9 @@ struct CPUArchState {
>       target_ulong reserve_addr;   /* Reservation address */
>       target_ulong reserve_length; /* Reservation larx op size (bytes) */
>       target_ulong reserve_val;    /* Reservation value */
> +#if defined(TARGET_PPC64)
>       target_ulong reserve_val2;
> +#endif
>   
>       /* These are used in supervisor mode only */
>       target_ulong msr;      /* machine state register */
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 134b16c625..a817532e5b 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -10,6 +10,7 @@
>   #include "qemu/main-loop.h"
>   #include "kvm_ppc.h"
>   #include "power8-pmu.h"
> +#include "sysemu/replay.h"
>   
>   static void post_load_update_msr(CPUPPCState *env)
>   {
> @@ -671,6 +672,27 @@ static const VMStateDescription vmstate_compat = {
>       }
>   };
>   
> +static bool reservation_needed(void *opaque)
> +{
> +    return (replay_mode != REPLAY_MODE_NONE);
> +}
> +
> +static const VMStateDescription vmstate_reservation = {
> +    .name = "cpu/reservation",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = reservation_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
> +        VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
> +        VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
> +#if defined(TARGET_PPC64)
> +        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
> +#endif
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   const VMStateDescription vmstate_ppc_cpu = {
>       .name = "cpu",
>       .version_id = 5,
> @@ -692,8 +714,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>           VMSTATE_UINTTL_ARRAY(env.spr, PowerPCCPU, 1024),
>           VMSTATE_UINT64(env.spe_acc, PowerPCCPU),
>   
> -        /* Reservation */
> -        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
> +        VMSTATE_UNUSED(sizeof(target_ulong)), /* was env.reserve_addr */
>   
>           /* Supervisor mode architected state */
>           VMSTATE_UINTTL(env.msr, PowerPCCPU),
> @@ -722,6 +743,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>           &vmstate_tlbemb,
>           &vmstate_tlbmas,
>           &vmstate_compat,
> +        &vmstate_reservation,
>           NULL
>       }
>   };
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c9fb7b40a5..eb278c2683 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -77,7 +77,9 @@ static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>   static TCGv cpu_reserve;
>   static TCGv cpu_reserve_length;
>   static TCGv cpu_reserve_val;
> +#if defined(TARGET_PPC64)
>   static TCGv cpu_reserve_val2;
> +#endif
>   static TCGv cpu_fpscr;
>   static TCGv_i32 cpu_access_type;
>   


