Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21F7BA57A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoR2F-0005Yx-36; Thu, 05 Oct 2023 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR2C-0005YJ-Tn
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:17:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoR25-00043v-Kb
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:17:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-406402933edso10490015e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696522615; x=1697127415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HBNZ00LvTPPmvOlylRNOvdAi7zNQShbozqcQ2uxD+QM=;
 b=EgbveKWfaVArBnM8e2bJec7A+as5OR+VcQaPR7jRv/572S7mWoKIyBatN4tAuhUBfE
 QBNFLc8DFKV9068ATZaFZn5RuHnzuUR9ypTdFXWCi+uvszxwVw85/X9SD9ZWg2saDWP4
 LyrtbA9DJkBmtR/4I9cSjkQdoETiNHbbSafFKSDEGu9M64VinmZoU3GIdm2Ie3u8OiFI
 yXg3ASIZECftLbwDcz3mKuxCk6pO2tR3urjqUvnZITM/BPffQTG3CP9wPhBFquc8ZYi2
 u1bVwF6QXAz842ozdWwtWXqzoVfRi+taf5wmuh/IwEw7sM2aacmCmd+r/O+CvyUi2MbI
 tpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696522615; x=1697127415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HBNZ00LvTPPmvOlylRNOvdAi7zNQShbozqcQ2uxD+QM=;
 b=eyO/Q9Jju5Cb/I2eHamLRimY0m3qpcWWkMVMmP+aNPfHGJLZfmqnO8t7DK75Gc1LPU
 KWCgZJzyjbevo9fcxGezOwIzgC/LcYt9kFaTe+Sq/qJZsV84Ptd/8gfQVFYyXig6SgLQ
 bymF08IyGw7Wd5ssNHm9gnTXFkzalPAzAq2l7/TIrdl++GG9MnvAWPgtURX9O/RXMYym
 yn7UdC/p4j55sEdx/bNRXxZZQStQFpmCMk/KWuQ52FG4JnVBpw1Vhw4JR1uG9T6nHqCB
 qb4avbH3hpU0JITBwsUruJAN9NzLz3wCr0YHx8GRpu01pPtEzBpSEdg+nonre2f8iD0W
 ye1Q==
X-Gm-Message-State: AOJu0YzRVvASJBTas1zG932YJh4SYixiMSlEa1WFiE/hD0dScMEKNyP7
 5c3sstdVU3nigMR7QvXjmMygDg==
X-Google-Smtp-Source: AGHT+IH7IXGoQQuajp+sezc5uwBRt+Wg8B3kcFo0g8U0TlR17/5KYu1vbgP89aHtgwG+zlEj2/MuOg==
X-Received: by 2002:a05:600c:28c:b0:405:e492:8aef with SMTP id
 12-20020a05600c028c00b00405e4928aefmr5389465wmk.40.1696522615249; 
 Thu, 05 Oct 2023 09:16:55 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b00402ff8d6086sm1857238wmm.18.2023.10.05.09.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:16:54 -0700 (PDT)
Message-ID: <b4dc7d22-ff3e-12a2-97d6-ce9448f3f527@linaro.org>
Date: Thu, 5 Oct 2023 18:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 13/19] linux-user/hppa: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, Helge Deller <deller@gmx.de>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 30/9/23 04:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/hppa/vdso-asmoffset.h |  12 +++
>   linux-user/elfload.c             |   2 +
>   linux-user/hppa/signal.c         |  24 +++--
>   linux-user/hppa/Makefile.vdso    |  11 +++
>   linux-user/hppa/meson.build      |   5 +
>   linux-user/hppa/vdso.S           | 165 +++++++++++++++++++++++++++++++
>   linux-user/hppa/vdso.ld          |  77 +++++++++++++++
>   linux-user/hppa/vdso.so          | Bin 0 -> 2104 bytes
>   8 files changed, 286 insertions(+), 10 deletions(-)
>   create mode 100644 linux-user/hppa/vdso-asmoffset.h
>   create mode 100644 linux-user/hppa/Makefile.vdso
>   create mode 100644 linux-user/hppa/vdso.S
>   create mode 100644 linux-user/hppa/vdso.ld
>   create mode 100755 linux-user/hppa/vdso.so

The overall LGTM, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Cc'ing Helge who have better knowledge of HPPA.

> diff --git a/linux-user/hppa/vdso-asmoffset.h b/linux-user/hppa/vdso-asmoffset.h
> new file mode 100644
> index 0000000000..c8b40c0332
> --- /dev/null
> +++ b/linux-user/hppa/vdso-asmoffset.h
> @@ -0,0 +1,12 @@
> +#define sizeof_rt_sigframe              584
> +#define offsetof_sigcontext             160
> +#define offsetof_sigcontext_gr          0x4
> +#define offsetof_sigcontext_fr          0x88
> +#define offsetof_sigcontext_iaoq        0x190
> +#define offsetof_sigcontext_sar         0x198
> +
> +/* arch/parisc/include/asm/rt_sigframe.h */
> +#define SIGFRAME                        64
> +#define FUNCTIONCALLFRAME               48
> +#define PARISC_RT_SIGFRAME_SIZE32 \
> +    (((sizeof_rt_sigframe) + FUNCTIONCALLFRAME + SIGFRAME) & -SIGFRAME)
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index a65401f8d5..ccf8a1dc78 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1921,6 +1921,8 @@ static inline void init_thread(struct target_pt_regs *regs,
>   #define STACK_GROWS_DOWN 0
>   #define STACK_ALIGNMENT  64
>   
> +#define VDSO_HEADER "vdso.c.inc"
> +
>   static inline void init_thread(struct target_pt_regs *regs,
>                                  struct image_info *infop)
>   {
> diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
> index bda6e54655..741dac79b6 100644
> --- a/linux-user/hppa/signal.c
> +++ b/linux-user/hppa/signal.c
> @@ -21,6 +21,7 @@
>   #include "user-internals.h"
>   #include "signal-common.h"
>   #include "linux-user/trace.h"
> +#include "vdso-asmoffset.h"
>   
>   struct target_sigcontext {
>       abi_ulong sc_flags;
> @@ -47,6 +48,19 @@ struct target_rt_sigframe {
>       /* hidden location of upper halves of pa2.0 64-bit gregs */
>   };
>   
> +QEMU_BUILD_BUG_ON(sizeof(struct target_rt_sigframe) != sizeof_rt_sigframe);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
> +                  != offsetof_sigcontext);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_gr)
> +                  != offsetof_sigcontext_gr);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_fr)
> +                  != offsetof_sigcontext_fr);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_iaoq)
> +                  != offsetof_sigcontext_iaoq);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_sar)
> +                  != offsetof_sigcontext_sar);
> +
> +
>   static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
>   {
>       int i;
> @@ -91,16 +105,6 @@ static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
>       __get_user(env->cr[CR_SAR], &sc->sc_sar);
>   }
>   
> -#if TARGET_ABI_BITS == 32
> -#define SIGFRAME                64
> -#define FUNCTIONCALLFRAME       48
> -#else
> -#define SIGFRAME                128
> -#define FUNCTIONCALLFRAME       96
> -#endif
> -#define PARISC_RT_SIGFRAME_SIZE32 \
> -    ((sizeof(struct target_rt_sigframe) + FUNCTIONCALLFRAME + SIGFRAME) & -SIGFRAME)
> -
>   void setup_rt_frame(int sig, struct target_sigaction *ka,
>                       target_siginfo_t *info,
>                       target_sigset_t *set, CPUArchState *env)
> diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
> new file mode 100644
> index 0000000000..f4537ae716
> --- /dev/null
> +++ b/linux-user/hppa/Makefile.vdso
> @@ -0,0 +1,11 @@
> +include $(BUILD_DIR)/tests/tcg/hppa-linux-user/config-target.mak
> +
> +SUBDIR = $(SRC_PATH)/linux-user/hppa
> +VPATH += $(SUBDIR)
> +
> +all: $(SUBDIR)/vdso.so
> +
> +$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> +	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso32.so.1 \
> +	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
> +	  -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/hppa/meson.build b/linux-user/hppa/meson.build
> index 4709508a09..aa2d9a87a6 100644
> --- a/linux-user/hppa/meson.build
> +++ b/linux-user/hppa/meson.build
> @@ -3,3 +3,8 @@ syscall_nr_generators += {
>                       arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
>                       output: '@BASENAME@_nr.h')
>   }
> +
> +vdso_inc = gen_vdso.process('vdso.so',
> +                            extra_args: [ '-r', '__kernel_sigtramp_rt' ])
> +
> +linux_user_ss.add(when: 'TARGET_HPPA', if_true: vdso_inc)
> diff --git a/linux-user/hppa/vdso.S b/linux-user/hppa/vdso.S
> new file mode 100644
> index 0000000000..5be14d2f70
> --- /dev/null
> +++ b/linux-user/hppa/vdso.S
> @@ -0,0 +1,165 @@
> +/*
> + * hppa linux kernel vdso replacement.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <asm/unistd.h>
> +#include "vdso-asmoffset.h"
> +
> +	.text
> +
> +
> +/*
> + * arch/parisc/kernel/vdso32/sigtramp.S:
> + * Gdb expects the trampoline is on the stack and the pc is offset from
> + * a 64-byte boundary by 0, 4 or 5 instructions. Since the vdso trampoline
> + * is not on the stack, we need a new variant with different offsets and
> + * data to tell gdb where to find the signal context on the stack.
> + *
> + * Here we put the offset to the context data at the start of the trampoline
> + * region and offset the first trampoline by 2 instructions. Please do
> + * not change the trampoline as the code in gdb depends on the following
> + * instruction sequence exactly.
> + */
> +
> +/* arch/parisc/kernel/asm-offsets.c */
> +#define SIGFRAME_CONTEXT_REGS32 \
> +    (offsetof_sigcontext - PARISC_RT_SIGFRAME_SIZE32)
> +
> +        .align	64
> +        .word	SIGFRAME_CONTEXT_REGS32
> +
> +/*
> + * All that said, we can provide a proper unwind record, which means that
> + * GDB should not actually need the offset magic.
> + *
> + * The return address that arrived here, from the inner frame, is
> + * not marked as a signal frame and so the unwinder still tries to
> + * subtract 1 to examine the presumed call insn.  Thus we must
> + * extend the unwind info to a nop before the start.
> + */
> +
> +	.cfi_startproc simple
> +	.cfi_signal_frame
> +
> +	/* Compare pa32_fallback_frame_state from libgcc. */
> +
> +	/*
> +	 * Place the CFA at the start of sigcontext for convenience.
> +	 * The previous CFA will be restored from the saved stack pointer.
> +	 */
> +	.cfi_def_cfa	30, -PARISC_RT_SIGFRAME_SIZE32 + offsetof_sigcontext
> +
> +	/* Record save offset of general registers. */
> +	.cfi_offset	1, offsetof_sigcontext_gr + 1 * 4
> +	.cfi_offset	2, offsetof_sigcontext_gr + 2 * 4
> +	.cfi_offset	3, offsetof_sigcontext_gr + 3 * 4
> +	.cfi_offset	4, offsetof_sigcontext_gr + 4 * 4
> +	.cfi_offset	5, offsetof_sigcontext_gr + 5 * 4
> +	.cfi_offset	6, offsetof_sigcontext_gr + 6 * 4
> +	.cfi_offset	7, offsetof_sigcontext_gr + 7 * 4
> +	.cfi_offset	8, offsetof_sigcontext_gr + 8 * 4
> +	.cfi_offset	9, offsetof_sigcontext_gr + 9 * 4
> +	.cfi_offset	10, offsetof_sigcontext_gr + 10 * 4
> +	.cfi_offset	11, offsetof_sigcontext_gr + 11 * 4
> +	.cfi_offset	12, offsetof_sigcontext_gr + 12 * 4
> +	.cfi_offset	13, offsetof_sigcontext_gr + 13 * 4
> +	.cfi_offset	14, offsetof_sigcontext_gr + 14 * 4
> +	.cfi_offset	15, offsetof_sigcontext_gr + 15 * 4
> +	.cfi_offset	16, offsetof_sigcontext_gr + 16 * 4
> +	.cfi_offset	17, offsetof_sigcontext_gr + 17 * 4
> +	.cfi_offset	18, offsetof_sigcontext_gr + 18 * 4
> +	.cfi_offset	19, offsetof_sigcontext_gr + 19 * 4
> +	.cfi_offset	20, offsetof_sigcontext_gr + 20 * 4
> +	.cfi_offset	21, offsetof_sigcontext_gr + 21 * 4
> +	.cfi_offset	22, offsetof_sigcontext_gr + 22 * 4
> +	.cfi_offset	23, offsetof_sigcontext_gr + 23 * 4
> +	.cfi_offset	24, offsetof_sigcontext_gr + 24 * 4
> +	.cfi_offset	25, offsetof_sigcontext_gr + 25 * 4
> +	.cfi_offset	26, offsetof_sigcontext_gr + 26 * 4
> +	.cfi_offset	27, offsetof_sigcontext_gr + 27 * 4
> +	.cfi_offset	28, offsetof_sigcontext_gr + 28 * 4
> +	.cfi_offset	29, offsetof_sigcontext_gr + 29 * 4
> +	.cfi_offset	30, offsetof_sigcontext_gr + 30 * 4
> +	.cfi_offset	31, offsetof_sigcontext_gr + 31 * 4
> +
> +	/* Record save offset of fp registers, left and right halves. */
> +	.cfi_offset	32, offsetof_sigcontext_fr + 4 * 8
> +	.cfi_offset	33, offsetof_sigcontext_fr + 4 * 8 + 4
> +	.cfi_offset	34, offsetof_sigcontext_fr + 5 * 8
> +	.cfi_offset	35, offsetof_sigcontext_fr + 5 * 8 + 4
> +	.cfi_offset	36, offsetof_sigcontext_fr + 6 * 8
> +	.cfi_offset	37, offsetof_sigcontext_fr + 6 * 8 + 4
> +	.cfi_offset	38, offsetof_sigcontext_fr + 7 * 8
> +	.cfi_offset	39, offsetof_sigcontext_fr + 7 * 8 + 4
> +	.cfi_offset	40, offsetof_sigcontext_fr + 8 * 8
> +	.cfi_offset	41, offsetof_sigcontext_fr + 8 * 8 + 4
> +	.cfi_offset	42, offsetof_sigcontext_fr + 9 * 8
> +	.cfi_offset	43, offsetof_sigcontext_fr + 9 * 8 + 4
> +	.cfi_offset	44, offsetof_sigcontext_fr + 10 * 8
> +	.cfi_offset	45, offsetof_sigcontext_fr + 10 * 8 + 4
> +	.cfi_offset	46, offsetof_sigcontext_fr + 11 * 8
> +	.cfi_offset	47, offsetof_sigcontext_fr + 11 * 8 + 4
> +	.cfi_offset	48, offsetof_sigcontext_fr + 12 * 8
> +	.cfi_offset	49, offsetof_sigcontext_fr + 12 * 8 + 4
> +	.cfi_offset	50, offsetof_sigcontext_fr + 13 * 8
> +	.cfi_offset	51, offsetof_sigcontext_fr + 13 * 8 + 4
> +	.cfi_offset	52, offsetof_sigcontext_fr + 14 * 8
> +	.cfi_offset	53, offsetof_sigcontext_fr + 14 * 8 + 4
> +	.cfi_offset	54, offsetof_sigcontext_fr + 15 * 8
> +	.cfi_offset	55, offsetof_sigcontext_fr + 15 * 8 + 4
> +	.cfi_offset	56, offsetof_sigcontext_fr + 16 * 8
> +	.cfi_offset	57, offsetof_sigcontext_fr + 16 * 8 + 4
> +	.cfi_offset	58, offsetof_sigcontext_fr + 17 * 8
> +	.cfi_offset	59, offsetof_sigcontext_fr + 17 * 8 + 4
> +	.cfi_offset	60, offsetof_sigcontext_fr + 18 * 8
> +	.cfi_offset	61, offsetof_sigcontext_fr + 18 * 8 + 4
> +	.cfi_offset	62, offsetof_sigcontext_fr + 19 * 8
> +	.cfi_offset	63, offsetof_sigcontext_fr + 19 * 8 + 4
> +	.cfi_offset	64, offsetof_sigcontext_fr + 20 * 8
> +	.cfi_offset	65, offsetof_sigcontext_fr + 20 * 8 + 4
> +	.cfi_offset	66, offsetof_sigcontext_fr + 21 * 8
> +	.cfi_offset	67, offsetof_sigcontext_fr + 21 * 8 + 4
> +	.cfi_offset	68, offsetof_sigcontext_fr + 22 * 8
> +	.cfi_offset	69, offsetof_sigcontext_fr + 22 * 8 + 4
> +	.cfi_offset	70, offsetof_sigcontext_fr + 23 * 8
> +	.cfi_offset	71, offsetof_sigcontext_fr + 23 * 8 + 4
> +	.cfi_offset	72, offsetof_sigcontext_fr + 24 * 8
> +	.cfi_offset	73, offsetof_sigcontext_fr + 24 * 8 + 4
> +	.cfi_offset	74, offsetof_sigcontext_fr + 25 * 8
> +	.cfi_offset	75, offsetof_sigcontext_fr + 25 * 8 + 4
> +	.cfi_offset	76, offsetof_sigcontext_fr + 26 * 8
> +	.cfi_offset	77, offsetof_sigcontext_fr + 26 * 8 + 4
> +	.cfi_offset	78, offsetof_sigcontext_fr + 27 * 8
> +	.cfi_offset	79, offsetof_sigcontext_fr + 27 * 8 + 4
> +	.cfi_offset	80, offsetof_sigcontext_fr + 28 * 8
> +	.cfi_offset	81, offsetof_sigcontext_fr + 28 * 8 + 4
> +	.cfi_offset	82, offsetof_sigcontext_fr + 29 * 8
> +	.cfi_offset	83, offsetof_sigcontext_fr + 29 * 8 + 4
> +	.cfi_offset	84, offsetof_sigcontext_fr + 30 * 8
> +	.cfi_offset	85, offsetof_sigcontext_fr + 30 * 8 + 4
> +	.cfi_offset	86, offsetof_sigcontext_fr + 31 * 8
> +	.cfi_offset	87, offsetof_sigcontext_fr + 31 * 8 + 4
> +
> +	/* Record save offset of %sar */
> +	.cfi_offset	88, offsetof_sigcontext_sar
> +
> +	/* Record save offset of return address, iaoq[0]. */
> +	.cfi_return_column 89
> +	.cfi_offset	89, offsetof_sigcontext_iaoq
> +
> +	nop
> +
> +__kernel_sigtramp_rt:
> +	ldi	0, %r25
> +	ldi	__NR_rt_sigreturn, %r20
> +	be,l	0x100(%sr2, %r0), %sr0, %r31
> +	nop
> +
> +	.cfi_endproc
> +	.size	__kernel_sigtramp_rt, . - __kernel_sigtramp_rt
> +	.type	__kernel_sigtramp_rt, @function
> +	.globl	__kernel_sigtramp_rt
> diff --git a/linux-user/hppa/vdso.ld b/linux-user/hppa/vdso.ld
> new file mode 100644
> index 0000000000..b17ad974f3
> --- /dev/null
> +++ b/linux-user/hppa/vdso.ld
> @@ -0,0 +1,77 @@
> +/*
> + * Linker script for linux hppa vdso.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +VERSION {
> +        /*
> +         * The kernel's vdso32.lds.S attempts to export
> +         *     __kernel_sigtramp_rt32
> +         *     __kernel_restart_syscall32
> +         * except that those symbols don't exist.  The actual symbols are
> +         *     __kernel_sigtramp_rt
> +         *     __kernel_restart_syscall
> +         * which means that nothing is exported at all.
> +         * QEMU handles syscall restart internally, so we don't
> +         * need to implement __kernel_restart_syscall at all.
> +         */
> +        LINUX_5.18 {
> +        local: *;
> +        };
> +}
> +
> +
> +PHDRS {
> +        phdr            PT_PHDR         FLAGS(4) PHDRS;
> +        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
> +        dynamic         PT_DYNAMIC      FLAGS(4);
> +        note            PT_NOTE         FLAGS(4);
> +        eh_frame_hdr    PT_GNU_EH_FRAME;
> +}
> +
> +SECTIONS {
> +        . = SIZEOF_HEADERS;
> +
> +        /* The following, including the FILEHDRS and PHDRS, are modified
> +           when we relocate the binary.  We want them to be initially
> +           writable for the relocation; we'll force them read-only after.  */
> +        .note           : { *(.note*) }         :load :note
> +        .dynamic        : { *(.dynamic) }       :load :dynamic
> +        .dynsym         : { *(.dynsym) }        :load
> +        .data           : {
> +                /* There ought not be any real read-write data.
> +                   But since we manipulated the segment layout,
> +                   we have to put these sections somewhere.  */
> +                *(.data*)
> +                *(.sdata*)
> +                *(.got.plt) *(.got)
> +                *(.gnu.linkonce.d.*)
> +                *(.bss*)
> +                *(.dynbss*)
> +                *(.gnu.linkonce.b.*)
> +        }
> +
> +        .rodata         : { *(.rodata) }
> +        .hash           : { *(.hash) }
> +        .gnu.hash       : { *(.gnu.hash) }
> +        .dynstr         : { *(.dynstr) }
> +        .gnu.version    : { *(.gnu.version) }
> +        .gnu.version_d  : { *(.gnu.version_d) }
> +        .gnu.version_r  : { *(.gnu.version_r) }
> +        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
> +        .eh_frame       : { *(.eh_frame) }      :load
> +
> +        .text           : { *(.text*) }         :load
> +}


