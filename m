Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881C70ED5C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 07:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hP0-0000EA-Ay; Wed, 24 May 2023 01:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1hOe-0000DP-7C
 for qemu-devel@nongnu.org; Wed, 24 May 2023 01:50:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1hOZ-0007xE-NS
 for qemu-devel@nongnu.org; Wed, 24 May 2023 01:50:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so356035b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684907446; x=1687499446;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bwy6UMomBO9pHOQo+8cPP0jl7jpjLEnKrykM8K5teqY=;
 b=s6QzVdIbHyN8XHOgqMrIxim7NF/0CkT3teKGU8cK+GXoob+tC/YbtGaOADBBGyF1Op
 H6rBcWVZqeVs+igqpWpEGJPPKIr/7wZQEktakX4WrkY/u9I6iDDJOPSrCop3O1jGLj9/
 NykiSFM0LCiOnXM33BFl55Wl2d33tBbvhm3o3SwRMH+rqDLAb3v/MwFDUSsHrFQaSLcP
 dGdczRf/maD+F9dFIV/0ynwy7XUu18A9MDJDkh81t548Eme1Hr5cvN4jwBQEBO+ytsKl
 O2oNdtupyaxjLzmX7EfydxeAE7hDDL2nD9Qqp3sTyfg+17/MrMGvMvPeIy531BEu5pwQ
 SNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684907446; x=1687499446;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwy6UMomBO9pHOQo+8cPP0jl7jpjLEnKrykM8K5teqY=;
 b=CxbvEKABBvIJ2dL7TlAVH8OsHHgNgWoU605zMkRc1VQohLISO+KYpUDYrBa+vJ2Czm
 ho3sWJV/3cRzEiJY14peJuPnutWjWk6Wb2DpsZXDOeAYiG6PWasZigjX3T+A39HmAW2x
 Ll+qT1opTSWlQDmqp3YEIVwrDlnAdyikZvmjbYepTmxGWyQBZD8X8YIusgZA6zItHgK8
 EZRwnA5RVkGYFepEPq71Qm0qJ9Cdvw693zkljh/6uNDCznhzUOoaaDclGrhN+jsvSNBL
 MgzYm++tyaG3hPdO4kDr5wgxIE/D2f06cyl/esMJdM4QitsSmk2TeK8LVsrtD8ZL4SEj
 SYXg==
X-Gm-Message-State: AC+VfDx6j5HJeZh5Gbg2TMdUEs39z+vslIDLoR6RnFH2ILbku40Fh+kK
 VVFI8pF/dFQK4t8+bsLUSqLPCVeryHh2W5xZrYs=
X-Google-Smtp-Source: ACHHUZ5Vlgz0BAaQsVIZQmqrUNvimodBAab8ySwfns/0s+zERR/y4hjvgda3n6BmgIUeRekjhRHf4A==
X-Received: by 2002:a05:6a21:328a:b0:10c:2fce:96cb with SMTP id
 yt10-20020a056a21328a00b0010c2fce96cbmr7143414pzb.37.1684907445934; 
 Tue, 23 May 2023 22:50:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 i184-20020a6387c1000000b0053ba104c113sm4157001pge.72.2023.05.23.22.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 22:50:45 -0700 (PDT)
Message-ID: <fa83ba4a-0d85-a923-a3d7-089c4d7c4be2@linaro.org>
Date: Tue, 23 May 2023 22:50:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user/i386: Properly align signal frame
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fanwj@mail.ustc.edu.cn, laurent@vivier.eu
References: <20230524054647.1093758-1-richard.henderson@linaro.org>
In-Reply-To: <20230524054647.1093758-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 22:46, Richard Henderson wrote:
> The beginning of the structure, with pretaddr, should be just below
> 16-byte alignment.  Disconnect fpstate from sigframe, just like the
> kernel does.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/i386/signal.c         | 104 +++++++++++++++++--------------
>   tests/tcg/x86_64/sigstack.c      |  33 ++++++++++
>   tests/tcg/x86_64/Makefile.target |   1 +
>   3 files changed, 90 insertions(+), 48 deletions(-)
>   create mode 100644 tests/tcg/x86_64/sigstack.c

Oops, meant to add

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1648

r~

> 
> diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> index 60fa07d6f9..c49467de78 100644
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -191,16 +191,7 @@ struct sigframe {
>       struct target_fpstate fpstate_unused;
>       abi_ulong extramask[TARGET_NSIG_WORDS-1];
>       char retcode[8];
> -
> -    /*
> -     * This field will be 16-byte aligned in memory.  Applying QEMU_ALIGNED
> -     * to it ensures that the base of the frame has an appropriate alignment
> -     * too.
> -     */
> -    struct target_fpstate fpstate QEMU_ALIGNED(8);
>   };
> -#define TARGET_SIGFRAME_FXSAVE_OFFSET (                                    \
> -    offsetof(struct sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
>   
>   struct rt_sigframe {
>       abi_ulong pretcode;
> @@ -210,27 +201,21 @@ struct rt_sigframe {
>       struct target_siginfo info;
>       struct target_ucontext uc;
>       char retcode[8];
> -    struct target_fpstate fpstate QEMU_ALIGNED(8);
>   };
> -#define TARGET_RT_SIGFRAME_FXSAVE_OFFSET (                                 \
> -    offsetof(struct rt_sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
>   #else
> -
>   struct rt_sigframe {
>       abi_ulong pretcode;
>       struct target_ucontext uc;
>       struct target_siginfo info;
> -    struct target_fpstate fpstate QEMU_ALIGNED(16);
>   };
> -#define TARGET_RT_SIGFRAME_FXSAVE_OFFSET (                                 \
> -    offsetof(struct rt_sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
>   #endif
>   
>   /*
>    * Set up a signal frame.
>    */
>   
> -static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
> +static void xsave_sigcontext(CPUX86State *env,
> +                             struct target_fpstate_fxsave *fxsave,
>                                abi_ulong fxsave_addr)
>   {
>       if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
> @@ -266,8 +251,9 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
>   }
>   
>   static void setup_sigcontext(struct target_sigcontext *sc,
> -        struct target_fpstate *fpstate, CPUX86State *env, abi_ulong mask,
> -        abi_ulong fpstate_addr)
> +                             struct target_fpstate *fpstate,
> +                             CPUX86State *env, abi_ulong mask,
> +                             abi_ulong fpstate_addr)
>   {
>       CPUState *cs = env_cpu(env);
>   #ifndef TARGET_X86_64
> @@ -347,10 +333,11 @@ static void setup_sigcontext(struct target_sigcontext *sc,
>    * Determine which stack to use..
>    */
>   
> -static inline abi_ulong
> -get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t fxsave_offset)
> +static abi_ulong get_sigframe(struct target_sigaction *ka, CPUX86State *env,
> +                              size_t *frame_size, abi_ulong *fpsave_addr)
>   {
> -    unsigned long esp;
> +    abi_ulong esp, orig;
> +    size_t fpsave_size;
>   
>       /* Default to using normal stack */
>       esp = get_sp_from_cpustate(env);
> @@ -371,16 +358,23 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t fxsave_offset
>           }
>   #endif
>       }
> +    orig = esp;
>   
> -    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
> -        return (esp - (fxsave_offset + TARGET_FXSAVE_SIZE)) & -8ul;
> -    } else if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
> -        return ((esp - TARGET_FXSAVE_SIZE) & -16ul) - fxsave_offset;
> +    if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
> +        fpsave_size = TARGET_FXSAVE_SIZE;
> +        esp = ROUND_DOWN(esp - fpsave_size, 16);
>       } else {
> -        size_t xstate_size =
> -               xsave_area_size(env->xcr0, false) + TARGET_FP_XSTATE_MAGIC2_SIZE;
> -        return ((esp - xstate_size) & -64ul) - fxsave_offset;
> +        fpsave_size = xsave_area_size(env->xcr0, false)
> +                      + TARGET_FP_XSTATE_MAGIC2_SIZE;
> +        esp = ROUND_DOWN(esp - fpsave_size, 64);
>       }
> +    *fpsave_addr = esp;
> +
> +    esp = esp - *frame_size + sizeof(abi_ulong);
> +    esp = ROUND_DOWN(esp, 16) - sizeof(abi_ulong);
> +
> +    *frame_size = orig - esp;
> +    return esp;
>   }
>   
>   #ifndef TARGET_X86_64
> @@ -405,26 +399,34 @@ void setup_frame(int sig, struct target_sigaction *ka,
>                    target_sigset_t *set, CPUX86State *env)
>   {
>       abi_ulong frame_addr;
> +    abi_ulong fpstate_addr;
> +    size_t frame_size;
>       struct sigframe *frame;
> +    struct target_fpstate *fpstate;
>       int i;
>   
> -    frame_addr = get_sigframe(ka, env, TARGET_SIGFRAME_FXSAVE_OFFSET);
> +    frame_size = sizeof(struct sigframe);
> +    frame_addr = get_sigframe(ka, env, &frame_size, &fpstate_addr);
>       trace_user_setup_frame(env, frame_addr);
>   
> -    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
> +    frame = lock_user(VERIFY_WRITE, frame_addr, frame_size, false);
> +    if (!frame) {
>           goto give_sigsegv;
> +    }
> +    fpstate = (void *)frame + (fpstate_addr - frame_addr);
>   
>       __put_user(sig, &frame->sig);
>   
> -    setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
> -            frame_addr + offsetof(struct sigframe, fpstate));
> +    setup_sigcontext(&frame->sc, fpstate, env, set->sig[0], fpstate_addr);
>   
> -    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
> +    for (i = 1; i < TARGET_NSIG_WORDS; i++) {
>           __put_user(set->sig[i], &frame->extramask[i - 1]);
>       }
>   
> -    /* Set up to return from userspace.  If provided, use a stub
> -       already in userspace.  */
> +    /*
> +     * Set up to return from userspace.
> +     * If provided, use a stub already in userspace.
> +     */
>       if (ka->sa_flags & TARGET_SA_RESTORER) {
>           __put_user(ka->sa_restorer, &frame->pretcode);
>       } else {
> @@ -443,11 +445,10 @@ void setup_frame(int sig, struct target_sigaction *ka,
>       cpu_x86_load_seg(env, R_CS, __USER_CS);
>       env->eflags &= ~TF_MASK;
>   
> -    unlock_user_struct(frame, frame_addr, 1);
> -
> +    unlock_user(frame, frame_addr, frame_size);
>       return;
>   
> -give_sigsegv:
> + give_sigsegv:
>       force_sigsegv(sig);
>   }
>   #endif
> @@ -458,17 +459,24 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>                       target_sigset_t *set, CPUX86State *env)
>   {
>       abi_ulong frame_addr;
> +    abi_ulong fpstate_addr;
> +    size_t frame_size;
>   #ifndef TARGET_X86_64
>       abi_ulong addr;
>   #endif
>       struct rt_sigframe *frame;
> +    struct target_fpstate *fpstate;
>       int i;
>   
> -    frame_addr = get_sigframe(ka, env, TARGET_RT_SIGFRAME_FXSAVE_OFFSET);
> +    frame_size = sizeof(struct rt_sigframe);
> +    frame_addr = get_sigframe(ka, env, &frame_size, &fpstate_addr);
>       trace_user_setup_rt_frame(env, frame_addr);
>   
> -    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
> +    frame = lock_user(VERIFY_WRITE, frame_addr, frame_size, false);
> +    if (!frame) {
>           goto give_sigsegv;
> +    }
> +    fpstate = (void *)frame + (fpstate_addr - frame_addr);
>   
>       /* These fields are only in rt_sigframe on 32 bit */
>   #ifndef TARGET_X86_64
> @@ -490,10 +498,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       }
>       __put_user(0, &frame->uc.tuc_link);
>       target_save_altstack(&frame->uc.tuc_stack, env);
> -    setup_sigcontext(&frame->uc.tuc_mcontext, &frame->fpstate, env,
> -            set->sig[0], frame_addr + offsetof(struct rt_sigframe, fpstate));
> +    setup_sigcontext(&frame->uc.tuc_mcontext, fpstate, env,
> +                     set->sig[0], fpstate_addr);
>   
> -    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
> +    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
>           __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
>       }
>   
> @@ -533,15 +541,15 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       cpu_x86_load_seg(env, R_SS, __USER_DS);
>       env->eflags &= ~TF_MASK;
>   
> -    unlock_user_struct(frame, frame_addr, 1);
> -
> +    unlock_user(frame, frame_addr, frame_size);
>       return;
>   
> -give_sigsegv:
> + give_sigsegv:
>       force_sigsegv(sig);
>   }
>   
> -static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
> +static int xrstor_sigcontext(CPUX86State *env,
> +                             struct target_fpstate_fxsave *fxsave,
>                                abi_ulong fxsave_addr)
>   {
>       if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
> diff --git a/tests/tcg/x86_64/sigstack.c b/tests/tcg/x86_64/sigstack.c
> new file mode 100644
> index 0000000000..06cb847569
> --- /dev/null
> +++ b/tests/tcg/x86_64/sigstack.c
> @@ -0,0 +1,33 @@
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <signal.h>
> +#include <stdint.h>
> +
> +void __attribute__((noinline)) bar(void)
> +{
> +    exit(EXIT_SUCCESS);
> +}
> +
> +void __attribute__((noinline, ms_abi)) foo(void)
> +{
> +    /*
> +     * With ms_abi, there are call-saved xmm registers, which are forced
> +     * to the stack around the call to sysv_abi bar().  If the signal
> +     * stack frame is not properly aligned, movaps will raise #GP.
> +     */
> +    bar();
> +}
> +
> +void sighandler(int num)
> +{
> +    void* sp = __builtin_dwarf_cfa();
> +    assert((uintptr_t)sp % 16 == 0);
> +    foo();
> +}
> +
> +int main(void)
> +{
> +    signal(SIGUSR1, sighandler);
> +    raise(SIGUSR1);
> +    abort();
> +}
> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
> index e64aab1b81..d961599f64 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -13,6 +13,7 @@ X86_64_TESTS += vsyscall
>   X86_64_TESTS += noexec
>   X86_64_TESTS += cmpxchg
>   X86_64_TESTS += adox
> +X86_64_TESTS += sigstack
>   TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
>   else
>   TESTS=$(MULTIARCH_TESTS)


