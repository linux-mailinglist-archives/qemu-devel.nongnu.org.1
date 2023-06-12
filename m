Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886172C602
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hdj-0003jQ-Fp; Mon, 12 Jun 2023 09:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8hdM-0003Qh-Po
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:31:04 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8hdJ-0004Hi-Ub
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:31:00 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f629ccb8ebso5023147e87.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686576656; x=1689168656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vtm2dqomgP00nhnh5YSvjSebLnxbRokqgf/Wg0TGa80=;
 b=Dpj52mM/Hr2o4HcrpeK/6ZrriruuomhMBb4MINLshR1KhKPSX5R7qa0RxIIXt7mnZi
 Ojzthrm4AQEkzUyk7WhgcrqoUu6F3Yn10IfMRSpwK+rPiV5ijXm03zYAOHuF9QZzQPsC
 mlSx1robcxC4FmNbtwXey29jeCEuFvFLM6IFeuP8b+AQ1aPu9liwW/6QmgsuiQpO6crF
 MbzjEQi3ErKKBDS5QrP5aEqf/0atJDckUJYxw74j8ZSyZYVfNzspjWoIIwu4bnmCP8jd
 bQ4ZpTHh+9vm3b1ChdRr/HcGD7/FDQQoJrfQRdtsJO3+0MQ+TU3qGWTsBZq/whRV1sHa
 0Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686576656; x=1689168656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vtm2dqomgP00nhnh5YSvjSebLnxbRokqgf/Wg0TGa80=;
 b=Xgl32wxrzCXyeo05sMiZANtMR0NhVmyzZlglzRBCKCGGGaTh+7w5ekv/nLx334f4pg
 BceloHv5pWkdoqTkXNEQ2nUiTdSmcxnGAcqI3b0yPHTd6/GHommEU0Vn+k1/TyAR8LaI
 1Ly9i0jB0lb6IKYsESnE108JV8e1v4PDtve0nvADfr0g1+qnBuM18EFopqpP3EZNAc4t
 3HFLjR/LTgRKqrTtIwvPyKYTVAGSNe27mdlgxLyNBzuBk70/DPAKWu5Fka2Nn1tGvhLZ
 tuJN++LT07JNyJ0PhAotZTyEnybzq3N3ZkHWF5db6Xp/uhdjWLZdhIeGbSDTu+H1nP7k
 IXPg==
X-Gm-Message-State: AC+VfDzh2A9Ph1l1jCDoqwY0M4tTEM9+4csIR8eStes22vCU/+VSIjsV
 zeWuNT1DDpT2nA4EaT+zGw6gYOCEdwYca70uEcs=
X-Google-Smtp-Source: ACHHUZ4xaZMo55Jfuilzueg+FNd5cHQiW3zJL681eytFu7zW1/nIGzMxFs1RJWoFSZjDVxazC3zcREc2X1EkYVNQyRw=
X-Received: by 2002:a2e:b24d:0:b0:2b0:2976:172d with SMTP id
 n13-20020a2eb24d000000b002b02976172dmr2939117ljm.9.1686576655666; Mon, 12 Jun
 2023 06:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230510160441.1249170-1-pbonzini@redhat.com>
 <20230510160441.1249170-2-pbonzini@redhat.com>
In-Reply-To: <20230510160441.1249170-2-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 15:30:40 +0200
Message-ID: <CAJ+F1CKJCU07WsLcQ4w9_oWekfEpjcOz6OXOyGHYj9tm0Z2_NA@mail.gmail.com>
Subject: Re: [PATCH] coroutine-asm: add x86 CET shadow stack support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="00000000000072951c05fdeeba5a"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000072951c05fdeeba5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

On Wed, May 10, 2023 at 6:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

patch looks generally good, but does not apply anymore.

Are you planning to update it later to support the more secure "
map_shadow_stack" syscall, if/when it is added?

---
>  meson.build          | 16 +++++++--
>  util/coroutine-asm.c | 82 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 93 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0121ccab78dd..17e4a3bc582e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -328,6 +328,10 @@ elif coroutine_backend not in supported_backends
>          .format(coroutine_backend, ', '.join(supported_backends)))
>  endif
>
> +if cfi_mode =3D=3D 'hw' and coroutine_backend !=3D 'asm'
> +  error('Hardware control-flow integrity requires the "asm" coroutine
> backend.')
> +endif
> +
>  # Compiles if SafeStack *not* enabled
>  safe_stack_probe =3D '''
>    int main(void)
> @@ -469,16 +473,22 @@ if cfi_mode =3D=3D 'sw'
>      endif
>    endif
>  elif cfi_mode in ['hw', 'auto']
> -  if cfi_mode =3D=3D 'hw'
> -    error('Hardware CFI is not supported yet')
> +  if cpu in ['x86', 'x86_64']
> +    cfi_flags +=3D cc.get_supported_arguments('-fcf-protection=3Dfull')
> +    if cfi_mode =3D=3D 'hw'
> +      error('C compiler does not support -fcf-protection')
> +    endif
> +  elif cfi_mode =3D=3D 'hw'
> +    error('Hardware CFI is only supported on x86')
>    endif
>    if cfi_flags =3D=3D [] and cfi_mode =3D=3D 'auto'
>      cfi_mode =3D 'disabled'
>    endif
>  endif
> -if cpu in ['x86', 'x86_64']
> +if cpu in ['x86', 'x86_64'] and cfi_mode !=3D 'hw'
>    cfi_flags +=3D cc.get_supported_arguments('-fcf-protection=3Dbranch')
>  endif
> +
>  add_global_arguments(cfi_flags, native: false, language: all_languages)
>  add_global_link_arguments(cfi_flags, native: false, language:
> all_languages)
>
> diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
> index a06ecbcb0a07..771b1d4a0fc9 100644
> --- a/util/coroutine-asm.c
> +++ b/util/coroutine-asm.c
> @@ -22,6 +22,13 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/coroutine_int.h"
> +#include "qemu/error-report.h"
> +
> +#ifdef CONFIG_CF_PROTECTION
> +#include <asm/prctl.h>
> +#include <sys/prctl.h>
> +int arch_prctl(int code, unsigned long addr);
> +#endif
>
>  #ifdef CONFIG_VALGRIND_H
>  #include <valgrind/valgrind.h>
> @@ -39,10 +46,14 @@
>  typedef struct {
>      Coroutine base;
>      void *sp;
> +    void *ssp;
>
>      void *stack;
>      size_t stack_size;
>
> +    /* x86: CET shadow stack */
> +    void *sstack;
> +    size_t sstack_size;
>  #ifdef CONFIG_VALGRIND_H
>      unsigned int valgrind_stack_id;
>  #endif
> @@ -77,6 +88,35 @@ static void start_switch_fiber(void **fake_stack_save,
>  #endif
>  }
>
> +static bool have_sstack(void)
> +{
> +#if defined CONFIG_CF_PROTECTION && defined __x86_64__
> +    uint64_t ssp;
> +    asm ("xor %0, %0; rdsspq %0\n" : "=3Dr" (ssp));
> +    return !!ssp;
> +#else
> +    return 0;
> +#endif
> +}
> +
> +static void *alloc_sstack(size_t sz)
> +{
> +#if defined CONFIG_CF_PROTECTION && defined __x86_64__
> +#ifndef ARCH_X86_CET_ALLOC_SHSTK
> +#define ARCH_X86_CET_ALLOC_SHSTK 0x3004
> +#endif
> +
> +    uint64_t arg =3D sz;
> +    if (arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, (unsigned long) &arg) < 0) =
{
> +        abort();
> +    }
> +
> +    return (void *)arg;
> +#else
> +    abort();
> +#endif
> +}
> +
>  #ifdef __x86_64__
>  /*
>   * We hardcode all operands to specific registers so that we can write
> down all the
> @@ -88,6 +128,26 @@ static void start_switch_fiber(void **fake_stack_save=
,
>   * Note that push and call would clobber the red zone.  Makefile.objs
> compiles this
>   * file with -mno-red-zone.  The alternative is to subtract/add 128 byte=
s
> from rsp
>   * around the switch, with slightly lower cache performance.
> + *
> + * The RSTORSSP and SAVEPREVSSP instructions are intricate.  In a
> nutshell they are:
> + *
> + *      RSTORSSP(mem):    oldSSP =3D SSP
> + *                        SSP =3D mem
> + *                        *SSP =3D oldSSP
> + *
> + *      SAVEPREVSSP:      oldSSP =3D shadow_stack_pop()
> + *                        *(oldSSP - 8) =3D oldSSP       # "push" to old
> shadow stack
> + *
> + * Therefore, RSTORSSP(mem) followed by SAVEPREVSSP is the same as
> + *
> + *     shadow_stack_push(SSP)
> + *     SSP =3D mem
> + *     shadow_stack_pop()
> + *
> + * From the simplified description you can see that co->ssp, being store=
d
> before
> + * the RSTORSSP+SAVEPREVSSP sequence, points to the top actual entry of
> the shadow
> + * stack, not to the restore token.  Hence we use an offset of -8 in the
> operand
> + * of rstorssp.
>   */
>  #define CO_SWITCH(from, to, action, jump) ({
>             \
>      int action_ =3D action;
>              \
> @@ -100,7 +160,15 @@ static void start_switch_fiber(void **fake_stack_sav=
e,
>          "jmp 2f\n"                          /* switch back continues at
> label 2 */    \
>
>              \
>          "1: .cfi_adjust_cfa_offset 8\n"
>              \
> -        "movq %%rsp, %c[SP](%[FROM])\n"     /* save source SP */
>             \
> +        "xor %%rbp, %%rbp\n"                /* use old frame pointer as
> scratch reg */ \
> +        "rdsspq %%rbp\n"
>             \
> +        "test %%rbp, %%rbp\n"               /* if CET is enabled... */
>             \
> +        "jz 9f\n"
>              \
> +        "movq %%rbp, %c[SSP](%[FROM])\n"    /* ... save source shadow SP=
,
> */         \
> +        "movq %c[SSP](%[TO]), %%rbp\n"      /* restore destination shado=
w
> stack, */  \
> +        "rstorssp -8(%%rbp)\n"
>             \
> +        "saveprevssp\n"                     /* and save source shadow SP
> token */     \
> +        "9: movq %%rsp, %c[SP](%[FROM])\n"  /* save source SP */
>             \
>          "movq %c[SP](%[TO]), %%rsp\n"       /* load destination SP */
>              \
>          jump "\n"                           /* coroutine switch */
>             \
>
>              \
> @@ -108,7 +176,8 @@ static void start_switch_fiber(void **fake_stack_save=
,
>          "popq %%rbp\n"
>             \
>          ".cfi_adjust_cfa_offset -8\n"
>              \
>          : "+a" (action_), [FROM] "+b" (from_), [TO] "+D" (to_)
>             \
> -        : [SP] "i" (offsetof(CoroutineAsm, sp))
>              \
> +        : [SP] "i" (offsetof(CoroutineAsm, sp)),
>             \
> +          [SSP] "i" (offsetof(CoroutineAsm, ssp))
>              \
>          : "rcx", "rdx", "rsi", "r8", "r9", "r10", "r11", "r12", "r13",
> "r14", "r15",  \
>            "memory");
>             \
>      action_;
>             \
> @@ -141,6 +210,12 @@ Coroutine *qemu_coroutine_new(void)
>      co->stack =3D qemu_alloc_stack(&co->stack_size);
>      co->sp =3D co->stack + co->stack_size;
>
> +    if (have_sstack()) {
> +        co->sstack_size =3D COROUTINE_SHADOW_STACK_SIZE;
> +        co->sstack =3D alloc_sstack(co->sstack_size);
> +        co->ssp =3D co->sstack + co->sstack_size;
> +    }
> +
>  #ifdef CONFIG_VALGRIND_H
>      co->valgrind_stack_id =3D
>          VALGRIND_STACK_REGISTER(co->stack, co->stack + co->stack_size);
> @@ -186,6 +261,9 @@ void qemu_coroutine_delete(Coroutine *co_)
>  #endif
>
>      qemu_free_stack(co->stack, co->stack_size);
> +    if (co->sstack) {
> +        munmap(co->sstack, co->sstack_size);
> +    }
>      g_free(co);
>  }
>
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000072951c05fdeeba5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 6:05=
=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Signed-off-by: Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&g=
t;<br></blockquote><div><br></div><div>patch looks generally good, but does=
 not apply anymore.</div><div><br></div><div>Are you planning to update it =
later to support the more secure &quot;<span class=3D"gmail-il">map_shadow_=
stack&quot;</span> syscall, if/when it is added?</div><div><br> </div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 +++++++--<br>
=C2=A0util/coroutine-asm.c | 82 ++++++++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A02 files changed, 93 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 0121ccab78dd..17e4a3bc582e 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -328,6 +328,10 @@ elif coroutine_backend not in supported_backends<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.format(coroutine_backend, &#39;, &#39;.j=
oin(supported_backends)))<br>
=C2=A0endif<br>
<br>
+if cfi_mode =3D=3D &#39;hw&#39; and coroutine_backend !=3D &#39;asm&#39;<b=
r>
+=C2=A0 error(&#39;Hardware control-flow integrity requires the &quot;asm&q=
uot; coroutine backend.&#39;)<br>
+endif<br>
+<br>
=C2=A0# Compiles if SafeStack *not* enabled<br>
=C2=A0safe_stack_probe =3D &#39;&#39;&#39;<br>
=C2=A0 =C2=A0int main(void)<br>
@@ -469,16 +473,22 @@ if cfi_mode =3D=3D &#39;sw&#39;<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0endif<br>
=C2=A0elif cfi_mode in [&#39;hw&#39;, &#39;auto&#39;]<br>
-=C2=A0 if cfi_mode =3D=3D &#39;hw&#39;<br>
-=C2=A0 =C2=A0 error(&#39;Hardware CFI is not supported yet&#39;)<br>
+=C2=A0 if cpu in [&#39;x86&#39;, &#39;x86_64&#39;]<br>
+=C2=A0 =C2=A0 cfi_flags +=3D cc.get_supported_arguments(&#39;-fcf-protecti=
on=3Dfull&#39;)<br>
+=C2=A0 =C2=A0 if cfi_mode =3D=3D &#39;hw&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 error(&#39;C compiler does not support -fcf-protectio=
n&#39;)<br>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 elif cfi_mode =3D=3D &#39;hw&#39;<br>
+=C2=A0 =C2=A0 error(&#39;Hardware CFI is only supported on x86&#39;)<br>
=C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0if cfi_flags =3D=3D [] and cfi_mode =3D=3D &#39;auto&#39;<br>
=C2=A0 =C2=A0 =C2=A0cfi_mode =3D &#39;disabled&#39;<br>
=C2=A0 =C2=A0endif<br>
=C2=A0endif<br>
-if cpu in [&#39;x86&#39;, &#39;x86_64&#39;]<br>
+if cpu in [&#39;x86&#39;, &#39;x86_64&#39;] and cfi_mode !=3D &#39;hw&#39;=
<br>
=C2=A0 =C2=A0cfi_flags +=3D cc.get_supported_arguments(&#39;-fcf-protection=
=3Dbranch&#39;)<br>
=C2=A0endif<br>
+<br>
=C2=A0add_global_arguments(cfi_flags, native: false, language: all_language=
s)<br>
=C2=A0add_global_link_arguments(cfi_flags, native: false, language: all_lan=
guages)<br>
<br>
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c<br>
index a06ecbcb0a07..771b1d4a0fc9 100644<br>
--- a/util/coroutine-asm.c<br>
+++ b/util/coroutine-asm.c<br>
@@ -22,6 +22,13 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu-common.h&quot;<br>
=C2=A0#include &quot;qemu/coroutine_int.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+<br>
+#ifdef CONFIG_CF_PROTECTION<br>
+#include &lt;asm/prctl.h&gt;<br>
+#include &lt;sys/prctl.h&gt;<br>
+int arch_prctl(int code, unsigned long addr);<br>
+#endif<br>
<br>
=C2=A0#ifdef CONFIG_VALGRIND_H<br>
=C2=A0#include &lt;valgrind/valgrind.h&gt;<br>
@@ -39,10 +46,14 @@<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0Coroutine base;<br>
=C2=A0 =C2=A0 =C2=A0void *sp;<br>
+=C2=A0 =C2=A0 void *ssp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0void *stack;<br>
=C2=A0 =C2=A0 =C2=A0size_t stack_size;<br>
<br>
+=C2=A0 =C2=A0 /* x86: CET shadow stack */<br>
+=C2=A0 =C2=A0 void *sstack;<br>
+=C2=A0 =C2=A0 size_t sstack_size;<br>
=C2=A0#ifdef CONFIG_VALGRIND_H<br>
=C2=A0 =C2=A0 =C2=A0unsigned int valgrind_stack_id;<br>
=C2=A0#endif<br>
@@ -77,6 +88,35 @@ static void start_switch_fiber(void **fake_stack_save,<b=
r>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+static bool have_sstack(void)<br>
+{<br>
+#if defined CONFIG_CF_PROTECTION &amp;&amp; defined __x86_64__<br>
+=C2=A0 =C2=A0 uint64_t ssp;<br>
+=C2=A0 =C2=A0 asm (&quot;xor %0, %0; rdsspq %0\n&quot; : &quot;=3Dr&quot; =
(ssp));<br>
+=C2=A0 =C2=A0 return !!ssp;<br>
+#else<br>
+=C2=A0 =C2=A0 return 0;<br>
+#endif<br>
+}<br>
+<br>
+static void *alloc_sstack(size_t sz)<br>
+{<br>
+#if defined CONFIG_CF_PROTECTION &amp;&amp; defined __x86_64__<br>
+#ifndef ARCH_X86_CET_ALLOC_SHSTK<br>
+#define ARCH_X86_CET_ALLOC_SHSTK 0x3004<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 uint64_t arg =3D sz;<br>
+=C2=A0 =C2=A0 if (arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, (unsigned long) &am=
p;arg) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return (void *)arg;<br>
+#else<br>
+=C2=A0 =C2=A0 abort();<br>
+#endif<br>
+}<br>
+<br>
=C2=A0#ifdef __x86_64__<br>
=C2=A0/*<br>
=C2=A0 * We hardcode all operands to specific registers so that we can writ=
e down all the<br>
@@ -88,6 +128,26 @@ static void start_switch_fiber(void **fake_stack_save,<=
br>
=C2=A0 * Note that push and call would clobber the red zone.=C2=A0 Makefile=
.objs compiles this<br>
=C2=A0 * file with -mno-red-zone.=C2=A0 The alternative is to subtract/add =
128 bytes from rsp<br>
=C2=A0 * around the switch, with slightly lower cache performance.<br>
+ *<br>
+ * The RSTORSSP and SAVEPREVSSP instructions are intricate.=C2=A0 In a nut=
shell they are:<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 RSTORSSP(mem):=C2=A0 =C2=A0 oldSSP =3D SSP<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SSP =3D mem<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *SSP =3D oldSSP<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 SAVEPREVSSP:=C2=A0 =C2=A0 =C2=A0 oldSSP =3D shadow_=
stack_pop()<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *(oldSSP - 8) =3D oldSSP=C2=A0 =C2=A0 =C2=A0 =C2=A0# &quot;pu=
sh&quot; to old shadow stack<br>
+ *<br>
+ * Therefore, RSTORSSP(mem) followed by SAVEPREVSSP is the same as<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0shadow_stack_push(SSP)<br>
+ *=C2=A0 =C2=A0 =C2=A0SSP =3D mem<br>
+ *=C2=A0 =C2=A0 =C2=A0shadow_stack_pop()<br>
+ *<br>
+ * From the simplified description you can see that co-&gt;ssp, being stor=
ed before<br>
+ * the RSTORSSP+SAVEPREVSSP sequence, points to the top actual entry of th=
e shadow<br>
+ * stack, not to the restore token.=C2=A0 Hence we use an offset of -8 in =
the operand<br>
+ * of rstorssp.<br>
=C2=A0 */<br>
=C2=A0#define CO_SWITCH(from, to, action, jump) ({=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0int action_ =3D action;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -100,7 +160,15 @@ static void start_switch_fiber(void **fake_stack_save,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;jmp 2f\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sw=
itch back continues at label 2 */=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;1: .cfi_adjust_cfa_offset 8\n&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;movq %%rsp, %c[SP](%[FROM])\n&quot;=C2=
=A0 =C2=A0 =C2=A0/* save source SP */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;xor %%rbp, %%rbp\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use old frame pointer as scrat=
ch reg */ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rdsspq %%rbp\n&quot;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;test %%rbp, %%rbp\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if CET is enabled... */=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jz 9f\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;movq %%rbp, %c[SSP](%[FROM])\n&quot;=C2=
=A0 =C2=A0 /* ... save source shadow SP, */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;movq %c[SSP](%[TO]), %%rbp\n&quot;=C2=A0=
 =C2=A0 =C2=A0 /* restore destination shadow stack, */=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rstorssp -8(%%rbp)\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;saveprevssp\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* and save source s=
hadow SP token */=C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;9: movq %%rsp, %c[SP](%[FROM])\n&quot;=
=C2=A0 /* save source SP */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;movq %c[SP](%[TO]), %%rsp\n&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* load destination SP */=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0jump &quot;\n&quot;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* coroutine switch */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
@@ -108,7 +176,8 @@ static void start_switch_fiber(void **fake_stack_save,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;popq %%rbp\n&quot;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;.cfi_adjust_cfa_offset -8\n&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;+a&quot; (action_), [FROM] &quot;=
+b&quot; (from_), [TO] &quot;+D&quot; (to_)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [SP] &quot;i&quot; (offsetof(CoroutineAsm, s=
p))=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [SP] &quot;i&quot; (offsetof(CoroutineAsm, s=
p)),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [SSP] &quot;i&quot; (offsetof(Coroutine=
Asm, ssp))=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;rcx&quot;, &quot;rdx&quot;, &quot=
;rsi&quot;, &quot;r8&quot;, &quot;r9&quot;, &quot;r10&quot;, &quot;r11&quot=
;, &quot;r12&quot;, &quot;r13&quot;, &quot;r14&quot;, &quot;r15&quot;,=C2=
=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;memory&quot;);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0action_;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -141,6 +210,12 @@ Coroutine *qemu_coroutine_new(void)<br>
=C2=A0 =C2=A0 =C2=A0co-&gt;stack =3D qemu_alloc_stack(&amp;co-&gt;stack_siz=
e);<br>
=C2=A0 =C2=A0 =C2=A0co-&gt;sp =3D co-&gt;stack + co-&gt;stack_size;<br>
<br>
+=C2=A0 =C2=A0 if (have_sstack()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 co-&gt;sstack_size =3D COROUTINE_SHADOW_STACK_=
SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 co-&gt;sstack =3D alloc_sstack(co-&gt;sstack_s=
ize);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 co-&gt;ssp =3D co-&gt;sstack + co-&gt;sstack_s=
ize;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0#ifdef CONFIG_VALGRIND_H<br>
=C2=A0 =C2=A0 =C2=A0co-&gt;valgrind_stack_id =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALGRIND_STACK_REGISTER(co-&gt;stack, co-=
&gt;stack + co-&gt;stack_size);<br>
@@ -186,6 +261,9 @@ void qemu_coroutine_delete(Coroutine *co_)<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_free_stack(co-&gt;stack, co-&gt;stack_size);<br>
+=C2=A0 =C2=A0 if (co-&gt;sstack) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 munmap(co-&gt;sstack, co-&gt;sstack_size);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0g_free(co);<br>
=C2=A0}<br>
<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000072951c05fdeeba5a--

