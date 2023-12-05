Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA580486B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 05:07:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAMh2-00081P-3j; Mon, 04 Dec 2023 23:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1rAMgv-0007zJ-6F; Mon, 04 Dec 2023 23:05:49 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1rAMgs-0001Wx-Sl; Mon, 04 Dec 2023 23:05:48 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7c44f5f3ca2so1180228241.0; 
 Mon, 04 Dec 2023 20:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701749145; x=1702353945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RGRQdKV++7TWtTYNQD7DT9S9FhfWdvD6kVbYXYnoNN0=;
 b=UnXWbQZbn40uHXi9au26pNmk5WqUb5RPfXA7nXdf0DS3HGO25vzJa3uSlFj6RJwTFZ
 vfRMjFOTWOBFw/Kj2/Ba6Lif0BmcX23in0cSJ9RLAr2d0+dwvie6QmmYTc+eIta9PvQT
 Ysg23sx4H3pqEbvz2vTx561LhRlxgzc2yxe7NvtHT0ptLC+HWGWMTQmUzaTVtECAgi0+
 yapAnLoLuxtLb+2PFuOpONSid/4jWk3CkRsE4N6oqH4PmtuV3JvSuj4yCNitYdD/FPVe
 mLBGWLVMxF7rNDSvflboiJFqlq/QmR8934wkD1EpJVPbjgRa5eFATVSbI78pau0l7QkM
 0dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701749145; x=1702353945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RGRQdKV++7TWtTYNQD7DT9S9FhfWdvD6kVbYXYnoNN0=;
 b=nSGz/S0wJOaLmwNFCRjjYQgNMhUq4ogHZipfScfyDrHaCquk7e/aE33oi4YipsMUMi
 2VbpSNtBticQkbbNJTMsMSyqSaOEPfD0IzzQEzdff5RrHlLbXdILPgdN5yg/Utrt0jdI
 nWbCycvJu4R1Woq7ksGn/PPEMmTf8QG8ziHmai0Vizr1qSxnxdpvg5BMr5po9/lfW4R5
 lGbCqJJukPAFf6jSE0lFj1O2EoQYRWDJ69i3IAfiz5ZIrV5MEuLvbttWTRL2xIZPS5aj
 8Xw3EyEnagf75o4hEZIulWfBXrX7PXNgdZUOI7mMJhoMVNH87t5UCK5rPhWJ4KeA9BRX
 2+NA==
X-Gm-Message-State: AOJu0YxXmbrnqggx+260oWYBWfbYl3yK2Xzm/ncycfVTy80zCf7M6aFx
 SZFj3fSX1I5MiHMUt2JtLN6cBGNq+z4AUNFtJLrOGqLF
X-Google-Smtp-Source: AGHT+IHjVvMfIZn+eXXupeKcLpWXVB9134wVl/RFtRVBLhcVT0PKZHT3ZgRknee/PQF7xuW9AoHFFQSE0LkNl8RIW7w=
X-Received: by 2002:a67:b449:0:b0:464:8174:9b4d with SMTP id
 c9-20020a67b449000000b0046481749b4dmr2479188vsm.32.1701749144916; Mon, 04 Dec
 2023 20:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20231202044846.258855-1-arorajai2798@gmail.com>
In-Reply-To: <20231202044846.258855-1-arorajai2798@gmail.com>
From: JAI ARORA <arorajai2798@gmail.com>
Date: Tue, 5 Dec 2023 09:35:31 +0530
Message-ID: <CA+9mx632wGOa2egPZBKLnr5UZLzeX74V8wF0=pkfO+jQg0dM2A@mail.gmail.com>
Subject: Re: [PATCH v5] accel/kvm: Turn DPRINTF macro use into tracepoints
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, philmd@linaro.org, Jai Arora <arorajai2798@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000047972c060bbb5946"
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=arorajai2798@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000047972c060bbb5946
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

This is a friendly ping.
Are there any other review comments for this patch?


Thanks,
Jai Arora

On Sat, 2 Dec 2023 at 10:19, Jai Arora <arorajai2798@gmail.com> wrote:

> Patch removes DPRINTF macro and adds multiple tracepoints
> to capture different kvm events.
>
> We also drop the DPRINTFs that don't add any additional
> information than trace_kvm_run_exit already does.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827
>
> Signed-off-by: Jai Arora <arorajai2798@gmail.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v5: Addressed review comments by Philippe Mathieu-Daud=C3=A9
> Corrects typo DRPINTF in commit message
> Changed %d to PRIu32 in kvm_run_exit_system_event
>
> I am not sure what you meant by keeping previous tag.
> I think you meant to keep version tag same,
> so I will keep patch tag as v5 again this time.
>
> Thank you for the feedback.
>
>  accel/kvm/kvm-all.c    | 28 ++++++----------------------
>  accel/kvm/trace-events |  7 ++++++-
>  2 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..80ac7b35b7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -69,16 +69,6 @@
>  #define KVM_GUESTDBG_BLOCKIRQ 0
>  #endif
>
> -//#define DEBUG_KVM
> -
> -#ifdef DEBUG_KVM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  struct KVMParkedVcpu {
>      unsigned long vcpu_id;
>      int kvm_fd;
> @@ -331,7 +321,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>      struct KVMParkedVcpu *vcpu =3D NULL;
>      int ret =3D 0;
>
> -    DPRINTF("kvm_destroy_vcpu\n");
> +    trace_kvm_destroy_vcpu();
>
>      ret =3D kvm_arch_destroy_vcpu(cpu);
>      if (ret < 0) {
> @@ -341,7 +331,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret =3D mmap_size;
> -        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
> +        trace_kvm_failed_get_vcpu_mmap_size();
>          goto err;
>      }
>
> @@ -443,7 +433,6 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>                                     PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET=
);
>          if (cpu->kvm_dirty_gfns =3D=3D MAP_FAILED) {
>              ret =3D -errno;
> -            DPRINTF("mmap'ing vcpu dirty gfns failed: %d\n", ret);
>              goto err;
>          }
>      }
> @@ -2821,7 +2810,7 @@ int kvm_cpu_exec(CPUState *cpu)
>      struct kvm_run *run =3D cpu->kvm_run;
>      int ret, run_ret;
>
> -    DPRINTF("kvm_cpu_exec()\n");
> +    trace_kvm_cpu_exec();
>
>      if (kvm_arch_process_async_events(cpu)) {
>          qatomic_set(&cpu->exit_request, 0);
> @@ -2848,7 +2837,7 @@ int kvm_cpu_exec(CPUState *cpu)
>
>          kvm_arch_pre_run(cpu, run);
>          if (qatomic_read(&cpu->exit_request)) {
> -            DPRINTF("interrupt exit requested\n");
> +           trace_kvm_interrupt_exit_request();
>              /*
>               * KVM requires us to reenter the kernel after IO exits to
> complete
>               * instruction emulation. This self-signal will ensure that =
we
> @@ -2878,7 +2867,7 @@ int kvm_cpu_exec(CPUState *cpu)
>
>          if (run_ret < 0) {
>              if (run_ret =3D=3D -EINTR || run_ret =3D=3D -EAGAIN) {
> -                DPRINTF("io window exit\n");
> +                trace_kvm_io_window_exit();
>                  kvm_eat_signals(cpu);
>                  ret =3D EXCP_INTERRUPT;
>                  break;
> @@ -2900,7 +2889,6 @@ int kvm_cpu_exec(CPUState *cpu)
>          trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
>          switch (run->exit_reason) {
>          case KVM_EXIT_IO:
> -            DPRINTF("handle_io\n");
>              /* Called outside BQL */
>              kvm_handle_io(run->io.port, attrs,
>                            (uint8_t *)run + run->io.data_offset,
> @@ -2910,7 +2898,6 @@ int kvm_cpu_exec(CPUState *cpu)
>              ret =3D 0;
>              break;
>          case KVM_EXIT_MMIO:
> -            DPRINTF("handle_mmio\n");
>              /* Called outside BQL */
>              address_space_rw(&address_space_memory,
>                               run->mmio.phys_addr, attrs,
> @@ -2920,11 +2907,9 @@ int kvm_cpu_exec(CPUState *cpu)
>              ret =3D 0;
>              break;
>          case KVM_EXIT_IRQ_WINDOW_OPEN:
> -            DPRINTF("irq_window_open\n");
>              ret =3D EXCP_INTERRUPT;
>              break;
>          case KVM_EXIT_SHUTDOWN:
> -            DPRINTF("shutdown\n");
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              ret =3D EXCP_INTERRUPT;
>              break;
> @@ -2959,6 +2944,7 @@ int kvm_cpu_exec(CPUState *cpu)
>              ret =3D 0;
>              break;
>          case KVM_EXIT_SYSTEM_EVENT:
> +            trace_kvm_run_exit_system_event(cpu->cpu_index,
> run->system_event.type);
>              switch (run->system_event.type) {
>              case KVM_SYSTEM_EVENT_SHUTDOWN:
>
>  qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> @@ -2976,13 +2962,11 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret =3D 0;
>                  break;
>              default:
> -                DPRINTF("kvm_arch_handle_exit\n");
>                  ret =3D kvm_arch_handle_exit(cpu, run);
>                  break;
>              }
>              break;
>          default:
> -            DPRINTF("kvm_arch_handle_exit\n");
>              ret =3D kvm_arch_handle_exit(cpu, run);
>              break;
>          }
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 399aaeb0ec..a25902597b 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -25,4 +25,9 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages
> (took %"PRIi64" us)"
>  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  kvm_dirty_ring_flush(int finished) "%d"
> -
> +kvm_destroy_vcpu(void) ""
> +kvm_failed_get_vcpu_mmap_size(void) ""
> +kvm_cpu_exec(void) ""
> +kvm_interrupt_exit_request(void) ""
> +kvm_io_window_exit(void) ""
> +kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index
> %d, system_even_type %"PRIu32
> --
> 2.25.1
>
>

--00000000000047972c060bbb5946
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello maintainers,</div><div><br></div><div>This is a=
 friendly ping.<br></div><div>Are there any other review comments for this =
patch?<br></div><br><div><br></div><div>Thanks, <br></div><div>Jai Arora<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sat, 2 Dec 2023 at 10:19, Jai Arora &lt;<a href=3D"mailto:aroraja=
i2798@gmail.com">arorajai2798@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Patch removes DPRINTF macro and adds=
 multiple tracepoints<br>
to capture different kvm events.<br>
<br>
We also drop the DPRINTFs that don&#39;t add any additional<br>
information than trace_kvm_run_exit already does.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1827" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/1827</a><br>
<br>
Signed-off-by: Jai Arora &lt;<a href=3D"mailto:arorajai2798@gmail.com" targ=
et=3D"_blank">arorajai2798@gmail.com</a>&gt;<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
v5: Addressed review comments by Philippe Mathieu-Daud=C3=A9<br>
Corrects typo DRPINTF in commit message<br>
Changed %d to PRIu32 in kvm_run_exit_system_event<br>
<br>
I am not sure what you meant by keeping previous tag.<br>
I think you meant to keep version tag same,<br>
so I will keep patch tag as v5 again this time.<br>
<br>
Thank you for the feedback.<br>
<br>
=C2=A0accel/kvm/kvm-all.c=C2=A0 =C2=A0 | 28 ++++++----------------------<br=
>
=C2=A0accel/kvm/trace-events |=C2=A0 7 ++++++-<br>
=C2=A02 files changed, 12 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
index e39a810a4e..80ac7b35b7 100644<br>
--- a/accel/kvm/kvm-all.c<br>
+++ b/accel/kvm/kvm-all.c<br>
@@ -69,16 +69,6 @@<br>
=C2=A0#define KVM_GUESTDBG_BLOCKIRQ 0<br>
=C2=A0#endif<br>
<br>
-//#define DEBUG_KVM<br>
-<br>
-#ifdef DEBUG_KVM<br>
-#define DPRINTF(fmt, ...) \<br>
-=C2=A0 =C2=A0 do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)<br>
-#else<br>
-#define DPRINTF(fmt, ...) \<br>
-=C2=A0 =C2=A0 do { } while (0)<br>
-#endif<br>
-<br>
=C2=A0struct KVMParkedVcpu {<br>
=C2=A0 =C2=A0 =C2=A0unsigned long vcpu_id;<br>
=C2=A0 =C2=A0 =C2=A0int kvm_fd;<br>
@@ -331,7 +321,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0struct KVMParkedVcpu *vcpu =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
<br>
-=C2=A0 =C2=A0 DPRINTF(&quot;kvm_destroy_vcpu\n&quot;);<br>
+=C2=A0 =C2=A0 trace_kvm_destroy_vcpu();<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D kvm_arch_destroy_vcpu(cpu);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
@@ -341,7 +331,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);<=
br>
=C2=A0 =C2=A0 =C2=A0if (mmap_size &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mmap_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;KVM_GET_VCPU_MMAP_SIZE failed\n&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_kvm_failed_get_vcpu_mmap_size();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -443,7 +433,6 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGE_SIZE * KVM_DIRTY_=
LOG_PAGE_OFFSET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu-&gt;kvm_dirty_gfns =3D=3D MAP_FAI=
LED) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -errno;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;mmap&#39;ing vcpu =
dirty gfns failed: %d\n&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2821,7 +2810,7 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0struct kvm_run *run =3D cpu-&gt;kvm_run;<br>
=C2=A0 =C2=A0 =C2=A0int ret, run_ret;<br>
<br>
-=C2=A0 =C2=A0 DPRINTF(&quot;kvm_cpu_exec()\n&quot;);<br>
+=C2=A0 =C2=A0 trace_kvm_cpu_exec();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kvm_arch_process_async_events(cpu)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qatomic_set(&amp;cpu-&gt;exit_request, 0)=
;<br>
@@ -2848,7 +2837,7 @@ int kvm_cpu_exec(CPUState *cpu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvm_arch_pre_run(cpu, run);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qatomic_read(&amp;cpu-&gt;exit_reques=
t)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;interrupt exit req=
uested\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_kvm_interrupt_exit_request(=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * KVM requires us to reent=
er the kernel after IO exits to complete<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * instruction emulation. T=
his self-signal will ensure that we<br>
@@ -2878,7 +2867,7 @@ int kvm_cpu_exec(CPUState *cpu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (run_ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (run_ret =3D=3D -EINTR |=
| run_ret =3D=3D -EAGAIN) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;io w=
indow exit\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_kvm_io_windo=
w_exit();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvm_eat_signa=
ls(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXCP_=
INTERRUPT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -2900,7 +2889,6 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_kvm_run_exit(cpu-&gt;cpu_index, run=
-&gt;exit_reason);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (run-&gt;exit_reason) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_IO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;handle_io\n&quot;)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Called outside BQL */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvm_handle_io(run-&gt;io.po=
rt, attrs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint8_t *)run + run-&gt;io.data_offset,<br>
@@ -2910,7 +2898,6 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_MMIO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;handle_mmio\n&quot=
;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Called outside BQL */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0address_space_rw(&amp;addre=
ss_space_memory,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run-&gt;mmio.phys_addr, attrs,<br>
@@ -2920,11 +2907,9 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_IRQ_WINDOW_OPEN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;irq_window_open\n&=
quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXCP_INTERRUPT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_SHUTDOWN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;shutdown\n&quot;);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_system_reset_request(S=
HUTDOWN_CAUSE_GUEST_RESET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXCP_INTERRUPT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -2959,6 +2944,7 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_SYSTEM_EVENT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_kvm_run_exit_system_event(=
cpu-&gt;cpu_index, run-&gt;system_event.type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (run-&gt;system_even=
t.type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KVM_SYSTEM_EVENT_SHUTD=
OWN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_system_s=
hutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);<br>
@@ -2976,13 +2962,11 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;kvm_=
arch_handle_exit\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kvm_a=
rch_handle_exit(cpu, run);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;kvm_arch_handle_ex=
it\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kvm_arch_handle_exi=
t(cpu, run);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events<br>
index 399aaeb0ec..a25902597b 100644<br>
--- a/accel/kvm/trace-events<br>
+++ b/accel/kvm/trace-events<br>
@@ -25,4 +25,9 @@ kvm_dirty_ring_reaper(const char *s) &quot;%s&quot;<br>
=C2=A0kvm_dirty_ring_reap(uint64_t count, int64_t t) &quot;reaped %&quot;PR=
Iu64&quot; pages (took %&quot;PRIi64&quot; us)&quot;<br>
=C2=A0kvm_dirty_ring_reaper_kick(const char *reason) &quot;%s&quot;<br>
=C2=A0kvm_dirty_ring_flush(int finished) &quot;%d&quot;<br>
-<br>
+kvm_destroy_vcpu(void) &quot;&quot;<br>
+kvm_failed_get_vcpu_mmap_size(void) &quot;&quot;<br>
+kvm_cpu_exec(void) &quot;&quot;<br>
+kvm_interrupt_exit_request(void) &quot;&quot;<br>
+kvm_io_window_exit(void) &quot;&quot;<br>
+kvm_run_exit_system_event(int cpu_index, uint32_t event_type) &quot;cpu_in=
dex %d, system_even_type %&quot;PRIu32<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--00000000000047972c060bbb5946--

