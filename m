Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54CD756D9B
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLUBz-0006kM-16; Mon, 17 Jul 2023 15:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUBx-0006kB-Mi
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:47:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUBv-0007Fo-V0
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9kpXYcDD4gkcH/+xWPE+pJ3DzigS/su5DfAZl5KvnOU=; b=IqN/FLJt/MGws0xzqYfo3z9w/y
 Hn46XCTiYzUCJCvJ0fp05IwUS3/Mi0Pz1NdHHtRpiXWbUcCNTnLdHV0rptZA8nwFdFNuwpHRe8OEO
 jIOfGdBZc8EHQxy1EtzUUGF1jhxXajtc8kzNnnbikJYmWrS0uOVrEKuclKPYkYMLdHS0vPXwR2yX4
 KqoYsDm3ww2mUksN5mnyIx7Fht2ZNAbOSW2PTsQKwkc3cCc+pmUaltLyyPA8wvoWtGQoWVdPpvawC
 BihZjep0icKVEzCjSzimLmTIc26RAax+iMMO1duYbADlA0P5CnIoVBB7g7xqh0tNqD4j/Ue1txC5w
 j2d74+mKfz6LfhRSPSr5wz6Y6dTkDWGqpzkxTH07poOBlknxpWoceGmw4Jpsg0vl3WRydJHQbwuhL
 3s72dYOBbBfa8puezuyQFAMr3Oa/VIWB9SmS/GQTtl2wBp7Fqp/+KoypucXoCUl9ileZnT9Yl8T1r
 jAf05Ha1Z6+hSMB7bDqUVkDd2zA0+oUFcsFoQ5u+/9x67GTU3W96ZFMO4Zn2DKEUtKGsIn6Kp2fgn
 d/ZQyCDTBGgZ2GLdcZGD/7a4FBCgTyeZxCBFCiwEUhntMdh2ns/746YIwCaRdY0JPoEvIUqWSyxbJ
 iHxUHMDGYUfFxeHgnmnlQikRpEXvjV8vI9P3dGTCQ=;
Received: from [2a00:23c4:8bae:1c00:dfd7:380:3565:1db7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qLUBY-0000Ep-Sl; Mon, 17 Jul 2023 20:47:12 +0100
Message-ID: <5f723e3a-58f7-5514-94dd-ef219c35bae4@ilande.co.uk>
Date: Mon, 17 Jul 2023 20:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230717103544.637453-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230717103544.637453-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:1c00:dfd7:380:3565:1db7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/07/2023 11:35, Peter Maydell wrote:

> In CPUSparcState we define the fprs field as uint64_t.  However we
> then refer to it in translate.c via a TCGv_i32 which we set up with
> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> the guest does something to writo te the FPRS register this value
> ends up in the wrong half of the uint64_t, and the QEMU C code that
> refers to env->fprs sees the wrong value.  The effect of this is that
> guest code that enables the FPU crashes with spurious FPU Disabled
> exceptions.  In particular, this is why
>   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
> times out on an s390 host.
> 
> There are multiple ways we could fix this; since there are actually
> only three bits in the FPRS register and the code in translate.c
> would be a bit painful to convert to dealing with a TCGv_i64, change
> the type of the CPU state struct field to match what translate.c is
> expecting.
> 
> (None of the other fields referenced by the r32[] array in
> sparc_tcg_init() have the wrong type.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>   * drop unnecessary change to gdbstub.c
>   * put the vmstate fields the correct way around
> 
> NB: I believe the vmstate changes to be correct, but sparc64
> seems unable to successfully do a savevm/loadvm even before
> this change due to some other bug (the guest kernel panics
> immediately after the loadvm).
> ---
>   target/sparc/cpu.h     | 2 +-
>   target/sparc/cpu.c     | 4 ++--
>   target/sparc/machine.c | 3 ++-
>   target/sparc/monitor.c | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 95d2d0da71d..98044572f26 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -521,7 +521,7 @@ struct CPUArchState {
>       uint64_t igregs[8]; /* interrupt general registers */
>       uint64_t mgregs[8]; /* mmu general registers */
>       uint64_t glregs[8 * MAXTL_MAX];
> -    uint64_t fprs;
> +    uint32_t fprs;
>       uint64_t tick_cmpr, stick_cmpr;
>       CPUTimer *tick, *stick;
>   #define TICK_NPT_MASK        0x8000000000000000ULL
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index e329a7aece5..130ab8f5781 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -673,8 +673,8 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>                    "cleanwin: %d cwp: %d\n",
>                    env->cansave, env->canrestore, env->otherwin, env->wstate,
>                    env->cleanwin, env->nwindows - 1 - env->cwp);
> -    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
> -                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
> +    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: %016x\n",
> +                 env->fsr, env->y, env->fprs);
>   
>   #else
>       qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 44b9e7d75d6..274e1217dfb 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -168,7 +168,8 @@ const VMStateDescription vmstate_sparc_cpu = {
>           VMSTATE_UINT64_ARRAY(env.bgregs, SPARCCPU, 8),
>           VMSTATE_UINT64_ARRAY(env.igregs, SPARCCPU, 8),
>           VMSTATE_UINT64_ARRAY(env.mgregs, SPARCCPU, 8),
> -        VMSTATE_UINT64(env.fprs, SPARCCPU),
> +        VMSTATE_UNUSED(4), /* was unused high half of uint64_t fprs */
> +        VMSTATE_UINT32(env.fprs, SPARCCPU),
>           VMSTATE_UINT64(env.tick_cmpr, SPARCCPU),
>           VMSTATE_UINT64(env.stick_cmpr, SPARCCPU),
>           VMSTATE_CPU_TIMER(env.tick, SPARCCPU),
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 318413686aa..73f15aa272d 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
>       { "otherwin", offsetof(CPUSPARCState, otherwin) },
>       { "wstate", offsetof(CPUSPARCState, wstate) },
>       { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
> -    { "fprs", offsetof(CPUSPARCState, fprs) },
> +    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
>   #endif
>       { NULL },
>   };

To the best of my knowledge there is no-one actively requesting migration 
compatibility for SPARC, so I'm perfectly fine if any improvements here include a 
migration version bump if you think it makes life easier/cleaner. Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


