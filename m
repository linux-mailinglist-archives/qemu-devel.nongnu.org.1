Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7217FFD4E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:13:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8oJw-0004GX-Hs; Thu, 30 Nov 2023 16:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8oJr-0004ET-UP
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:11:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8oJp-0004yJ-On
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:11:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3316bb1303bso1032634f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701378689; x=1701983489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6DpIPM9dgtNKIIK4PxEbwWzfaC12DsR6qNFu+Tq0ks=;
 b=ZtRweszGZxR5NiB2ebQQqy9a9pzXzrt3IZ+Y3ErCvIAQoth1fVLnuXGEYqknm2ylTT
 vWtJTIE3FBVS7FD7ux+qQioCQEG3JU8I4Uy5mSJ2oEKdAo2cK2BMPdVaBUZQ2xO7oFf9
 pJ6DM7Y0q7z3QOx8699cD5c4QnRlKPGPACYwcBPNCt9Htp0yiOp59q0KzX6a6TtXPWRD
 8Y/5huWVEjYQEokm489/ZspBh4nA03fuq7Py09P1AihaxyfdlSztJQWwEe9f2J1BF3Vp
 8n3+Lhh4TfnScUjCFearyoYmuf29aahJG3U8sQ+xGWpNjYH91Y09HMMAV6CpjnmAauwM
 PIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701378689; x=1701983489;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D6DpIPM9dgtNKIIK4PxEbwWzfaC12DsR6qNFu+Tq0ks=;
 b=H8MMPtQS0RMJKIzlChCQW3HFM0JeSSaW55rzkhaxTKA2J79NJQvLxsY6ZoKjN9sgEv
 ArYoqBgqrtzS6YkD8G6RZ+PUp+taUsPa4bSrqASxN9KsBCiMzxkX6DA2gYHz8i2j4ZtO
 PmHd+vq/S6uEy/NjzdJH2TnbyNfueX91zBm+10j/RR1FTKu083UcA6gTj/58NMkF7IjP
 4sgevaxC4sehFuJfuh4iq+yISQY7EAHVuSlYmwuO0jf4A9AnyAv7epiKRd+4pU82X64J
 3tVH17Ho6YTw5sYXHMmdp/UrEgT0df3PyhO+QkemuNU9zEn8e7ERVqp6zUC/MpgAXAhx
 YaHQ==
X-Gm-Message-State: AOJu0YxiFJ8R6zJN9dByI/1OzcHiGgZqsyQsC11o3LaxUCUAHlHxzIZe
 fP8yJcd1AFu7LfmuO4sbV6fPkA==
X-Google-Smtp-Source: AGHT+IGobIhznsLZI0meAuoDJeZV6clqOOZJoaUfsbHIfNrEDaILCELOq0STZoZnABddHrdVvF7P6A==
X-Received: by 2002:adf:db49:0:b0:333:2fd2:812d with SMTP id
 f9-20020adfdb49000000b003332fd2812dmr109002wrj.74.1701378689474; 
 Thu, 30 Nov 2023 13:11:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i9-20020adffc09000000b00333083a20e5sm2451760wrr.113.2023.11.30.13.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 13:11:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFEC75FB51;
 Thu, 30 Nov 2023 21:11:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jai Arora <arorajai2798@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  pbonzini@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v4] accel/kvm: Turn DPRINTF macro use into tracepoints
In-Reply-To: <2e454e52639560c4768006ec2a93dcf6ba02b210.1701373822.git.arorajai2798@gmail.com>
 (Jai Arora's message of "Fri, 1 Dec 2023 01:32:36 +0530")
References: <2e454e52639560c4768006ec2a93dcf6ba02b210.1701373822.git.arorajai2798@gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 30 Nov 2023 21:11:28 +0000
Message-ID: <87zfyv54lb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Jai Arora <arorajai2798@gmail.com> writes:

> Patch removes DRPINTF macro and adds multiple tracepoints
> to capture different kvm events.
>
> We also drop the DPRINTFs that don't add any additional
> information than trace_kvm_run_exit already does.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827
>
> Signed-off-by: Jai Arora <arorajai2798@gmail.com>

But you didn't add my reviewed-by tag ;-)

Tools like b4 will do the collection of tags for you if you want.

> ---
> v4: Adds changes in commit message requested by Alex Bennee
>
> ps.
>
> I tried using git notes for the change log
> May be it did not reflect. Thanks for the feedback and review
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
>=20=20
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
>=20=20
> -    DPRINTF("kvm_destroy_vcpu\n");
> +    trace_kvm_destroy_vcpu();
>=20=20
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
>=20=20
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
>=20=20
> -    DPRINTF("kvm_cpu_exec()\n");
> +    trace_kvm_cpu_exec();
>=20=20
>      if (kvm_arch_process_async_events(cpu)) {
>          qatomic_set(&cpu->exit_request, 0);
> @@ -2848,7 +2837,7 @@ int kvm_cpu_exec(CPUState *cpu)
>=20=20
>          kvm_arch_pre_run(cpu, run);
>          if (qatomic_read(&cpu->exit_request)) {
> -            DPRINTF("interrupt exit requested\n");
> +	    trace_kvm_interrupt_exit_request();
>              /*
>               * KVM requires us to reenter the kernel after IO exits to c=
omplete
>               * instruction emulation. This self-signal will ensure that =
we
> @@ -2878,7 +2867,7 @@ int kvm_cpu_exec(CPUState *cpu)
>=20=20
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
> +            trace_kvm_run_exit_system_event(cpu->cpu_index, run->system_=
event.type);
>              switch (run->system_event.type) {
>              case KVM_SYSTEM_EVENT_SHUTDOWN:
>                  qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
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
> index 399aaeb0ec..f61a21019a 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -25,4 +25,9 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (=
took %"PRIi64" us)"
>  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  kvm_dirty_ring_flush(int finished) "%d"
> -
> +kvm_destroy_vcpu(void) ""
> +kvm_failed_get_vcpu_mmap_size(void) ""
> +kvm_cpu_exec(void) ""
> +kvm_interrupt_exit_request(void) ""
> +kvm_io_window_exit(void) ""
> +kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index=
 %d, system_even_type %d"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

