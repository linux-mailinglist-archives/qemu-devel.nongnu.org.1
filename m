Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D527A0C4A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqpw-0007D1-2s; Thu, 14 Sep 2023 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgqpn-0007Cc-9S
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:12:59 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgqpk-0004ve-4l
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:12:58 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bceb02fd2bso19952051fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694715174; x=1695319974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gznKYiSpHo/Z+hSE48kjokgVIfMW7Y69cdDSITGTNos=;
 b=xtCYE3g/sGwROsAq5gpe5K8S/O4ErBqirWzvDUcCqBw0IS6dGjg7gYCUERjpFiR78y
 ygIF0TXjutW+e6R64nz5+JlhZIfiWUjCDYJYA1cPWLacdhb3dX7gyAumP3o8dk8TVb1u
 J+x8D0tTLQ5bDTNv9qaDWIdnpSJBzmSSF+Yt1tkFPluslg1r35mzGiYMMRgwJErn4SHT
 O5Su5iWtBEYgqXoHV2pCJkVfA//5d26MfWvH+S2yT87i0Rbh3mEwEyk+Do13D1QLmXpg
 qDZOh8QVFUyY4mpCoVdiOTUNu4XmF4O9AgUZmEnTV+vv9+zVi3Ygp3C2q5gAOMOZmSZx
 5SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694715174; x=1695319974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gznKYiSpHo/Z+hSE48kjokgVIfMW7Y69cdDSITGTNos=;
 b=TFJAFUJ+QmcYZS+x9vruiBJsvf8l6Rqn3datKvdQsiOELnekzRkFhYPs/MpPXqXR/W
 luwVY4k88wPPJb8kHI3B3ATwIsx2hbIamFeZl5qENBKKtIE5w49cO7WskWVLy1+NmG/o
 TeoiGAi/j5b3dkHV7WkhigDGG3FmMXBFbVToa4Du5L3ge8YnIRqYm0mOJXP22jaePikq
 e5pQg3TjPjEkB78VCkvU/I8VD5DSuxElruBovGGbZb3jYD82E98kyxUWSy39GXdIb0/G
 Rs9CH1A1ALeE7vovXM/pYTRnwMjpSdD9LoGlMOcttQpSi8j09ZCd78c3+Ik5zdH4A3f9
 q3cg==
X-Gm-Message-State: AOJu0YyIuCtLEfBW1ZZuLJGGSDfDGOZzK6JRPuFKE1CExCDvtrUn8ZuC
 qxOmBrhjsh5gacVj8AOA5SbM6Q==
X-Google-Smtp-Source: AGHT+IE5PQcYQgIlS3BeqAulvgtXgykznyewl1Lzyy5YPqXvO/ule4yqNm+qXQFlffoisXABFiVu8w==
X-Received: by 2002:a2e:901a:0:b0:2bc:c89e:d8df with SMTP id
 h26-20020a2e901a000000b002bcc89ed8dfmr5682321ljg.48.1694715173915; 
 Thu, 14 Sep 2023 11:12:53 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170906718900b0099bc80d5575sm1305724ejk.200.2023.09.14.11.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 11:12:53 -0700 (PDT)
Message-ID: <c606e0d9-c164-11da-8ae1-9a602459961c@linaro.org>
Date: Thu, 14 Sep 2023 20:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 13/24] accel/tcg: Replace CPUState.env_ptr with
 cpu_env()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h               |  1 -
>   include/hw/core/cpu.h                |  9 ++++++---
>   target/arm/common-semi-target.h      |  2 +-
>   accel/tcg/cpu-exec.c                 |  8 ++++----
>   accel/tcg/cputlb.c                   | 18 +++++++++---------
>   accel/tcg/translate-all.c            |  4 ++--
>   gdbstub/gdbstub.c                    |  4 ++--
>   gdbstub/user-target.c                |  2 +-
>   hw/i386/kvm/clock.c                  |  2 +-
>   hw/intc/mips_gic.c                   |  2 +-
>   hw/intc/riscv_aclint.c               | 12 ++++++------
>   hw/intc/riscv_imsic.c                |  2 +-
>   hw/ppc/e500.c                        |  4 ++--
>   hw/ppc/spapr.c                       |  2 +-
>   linux-user/elfload.c                 |  4 ++--
>   linux-user/i386/cpu_loop.c           |  2 +-
>   linux-user/main.c                    |  4 ++--
>   linux-user/signal.c                  | 15 +++++++--------
>   monitor/hmp-cmds-target.c            |  2 +-
>   semihosting/arm-compat-semi.c        |  6 +++---
>   semihosting/syscalls.c               | 28 ++++++++++++++--------------
>   target/alpha/translate.c             |  4 ++--
>   target/arm/cpu.c                     |  8 ++++----
>   target/arm/helper.c                  |  2 +-
>   target/arm/tcg/translate-a64.c       |  4 ++--
>   target/arm/tcg/translate.c           |  6 +++---
>   target/avr/translate.c               |  2 +-
>   target/cris/translate.c              |  4 ++--
>   target/hexagon/translate.c           |  4 ++--
>   target/hppa/mem_helper.c             |  2 +-
>   target/hppa/translate.c              |  4 ++--
>   target/i386/tcg/sysemu/excp_helper.c |  2 +-
>   target/i386/tcg/tcg-cpu.c            |  2 +-
>   target/i386/tcg/translate.c          |  4 ++--
>   target/loongarch/translate.c         |  4 ++--
>   target/m68k/translate.c              |  4 ++--
>   target/microblaze/translate.c        |  2 +-
>   target/mips/tcg/sysemu/mips-semi.c   |  4 ++--
>   target/mips/tcg/translate.c          |  4 ++--
>   target/nios2/translate.c             |  4 ++--
>   target/openrisc/translate.c          |  2 +-
>   target/ppc/excp_helper.c             | 10 +++++-----
>   target/ppc/translate.c               |  4 ++--
>   target/riscv/translate.c             |  6 +++---
>   target/rx/cpu.c                      |  3 ---
>   target/rx/translate.c                |  2 +-
>   target/s390x/tcg/translate.c         |  2 +-
>   target/sh4/op_helper.c               |  2 +-
>   target/sh4/translate.c               |  4 ++--
>   target/sparc/translate.c             |  4 ++--
>   target/tricore/translate.c           |  4 ++--
>   target/xtensa/translate.c            |  4 ++--
>   target/i386/tcg/decode-new.c.inc     |  2 +-
>   53 files changed, 125 insertions(+), 127 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index ae0cb2ce50..40831122ce 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -433,7 +433,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
>    */
>   static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
>   {
> -    cpu->parent_obj.env_ptr = &cpu->env;
>   }
>   
>   /* Validate correct placement of CPUArchState. */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 99066da2f3..f3fa1ffa95 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -440,7 +440,6 @@ struct qemu_work_item;
>    * @num_ases: number of CPUAddressSpaces in @cpu_ases
>    * @as: Pointer to the first AddressSpace, for the convenience of targets which
>    *      only have a single AddressSpace
> - * @env_ptr: Pointer to subclass-specific CPUArchState field.
>    * @gdb_regs: Additional GDB registers.
>    * @gdb_num_regs: Number of total registers accessible to GDB.
>    * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
> @@ -511,8 +510,6 @@ struct CPUState {
>       AddressSpace *as;
>       MemoryRegion *memory;
>   
> -    CPUArchState *env_ptr;
> -
>       CPUJumpCache *tb_jmp_cache;
>   
>       struct GDBRegisterState *gdb_regs;
> @@ -594,6 +591,12 @@ struct CPUState {
>   QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) + sizeof(CPUNegativeOffsetState)
>                     != sizeof(CPUState));
>   
> +static inline CPUArchState *cpu_env(CPUState *cpu)
> +{
> +    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
> +    return (CPUArchState *)(cpu + 1);
> +}

Do we also need to remove this check?

-- >8 --
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 40831122ce..3d87548f9b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -437,7 +437,6 @@ static inline void cpu_set_cpustate_pointers(ArchCPU 
*cpu)

  /* Validate correct placement of CPUArchState. */
  QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));

  /**
   * env_archcpu(env)
---

I'm getting:

include/qemu/compiler.h:74:36: error: static assertion failed: "not 
expecting: offsetof(ArchCPU, env) != sizeof(CPUState)"
    74 | #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
       |                                    ^~~~~~~~~~~~~~
include/qemu/compiler.h:76:30: note: in expansion of macro 
‘QEMU_BUILD_BUG_MSG’
    76 | #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not 
expecting: " #x)
       |                              ^~~~~~~~~~~~~~~~~~
include/exec/cpu-all.h:440:1: note: in expansion of macro 
‘QEMU_BUILD_BUG_ON’
   440 | QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
       | ^~~~~~~~~~~~~~~~~
ninja: build stopped: subcommand failed.


