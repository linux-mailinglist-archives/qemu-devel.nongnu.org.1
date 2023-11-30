Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C17FEF22
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 13:31:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gCY-0000aI-6H; Thu, 30 Nov 2023 07:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8gCV-0000Zv-J9
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 07:31:27 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8gCT-0002Id-1l
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 07:31:26 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9d2ca9a96so3522811fa.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701347483; x=1701952283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1vnyrbzpKffAd4KjWGfwAaW96aIqsNKwUfFh121ujM=;
 b=U3hSXzwLxLI37d3xTKNRly2sKVBr7id+q261DS0yf98vXDOZcoJBemXgIGNdHWsiSJ
 FFEC/TLvAdGQ5K4zRsTd9biEk9PjUaySK1AAAiJr3khTst0rszhpEZkT2HV476dPoFbw
 2i31+hSq72YoskOH2ogLLQCQjPET1tOuoKGRFSLpBiw4jcXBi+O32V02svAFtEVygbIY
 0YYmxu6SLXe5+zsQ8a85oG/+/rRjb0xWMg435AnLtUC7W5NWO6D73YYvHJc2SOMOIw16
 K+2StCPC/b0m8dvvpHXe5f4ZzbpJacrudFU4uGjOHAejzWRGjvSJEuhDjvyXFiCu1g5B
 VbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701347483; x=1701952283;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1vnyrbzpKffAd4KjWGfwAaW96aIqsNKwUfFh121ujM=;
 b=bakx5mzvrYWIxa1ezHwVP3Wcupf3CVjh7yRoWyymxdoKG5DFYhsf6ok5qD7k5jOxld
 Uh3zrEAGbaDYxAPcDOyGuBwSWQzetiYQ/ki5X8eCqLpgr6thdf5TfRh6p1P84b/KQ5IL
 3bPwpz84dLuAxOrfr8TfYsO94Bz4+zuh7bumHjC2uiQ0Ndhrs5akR4U56QBSGdSobE1L
 ZnGItxNO4TyEwdPVduMYRf/8DjYWU957AfsmVNZCdmXG9HdJxppLvq3EfdfKaW9J2DkC
 0BPY5Zib2BdFMyyrpM7hcjqe4q6XnziYT7Ne86K3MPCy69PvQiOsEytS4wvk8jnodn0i
 3nOw==
X-Gm-Message-State: AOJu0YwWtP0sgVetCA99+yTt8Te+AlK0D4YQ5pmPAchP2bXqn3wOuDRB
 d3F8q7Wd1kvkhdmj3/Pfu2r2Gw==
X-Google-Smtp-Source: AGHT+IEnutz0tG2j4qe4VNcraJF2sTD3MCnwDGKlNwdfwqR3ormPnEwKZ4iXox9/j75qUROWK6/JQA==
X-Received: by 2002:a2e:9144:0:b0:2c9:bc46:7efc with SMTP id
 q4-20020a2e9144000000b002c9bc467efcmr4218437ljg.35.1701347482812; 
 Thu, 30 Nov 2023 04:31:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h7-20020adf9cc7000000b0032d8eecf901sm1444008wre.3.2023.11.30.04.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 04:31:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12C3A5F794;
 Thu, 30 Nov 2023 12:31:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jai Arora <arorajai2798@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  pbonzini@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2] accel/kvm: Turn DPRINTF macro use into tracepoints
In-Reply-To: <20231129172109.207516-1-arorajai2798@gmail.com> (Jai Arora's
 message of "Wed, 29 Nov 2023 22:51:10 +0530")
References: <20231129172109.207516-1-arorajai2798@gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 30 Nov 2023 12:31:22 +0000
Message-ID: <87plzr778l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
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
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827
>
> Signed-off-by: Jai Arora <arorajai2798@gmail.com>
> ---
>  accel/kvm/kvm-all.c    | 33 +++++++++++----------------------
>  accel/kvm/trace-events |  8 +++++++-
>  2 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..0801ca7933 100644
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
> @@ -2900,7 +2889,7 @@ int kvm_cpu_exec(CPUState *cpu)
>          trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);

As we trace the ->exit_reason here I think the individual legs that just
echo a static string don't add much value. Maybe delete them rather than
convert them?

>          switch (run->exit_reason) {
>          case KVM_EXIT_IO:
> -            DPRINTF("handle_io\n");
> +            trace_kvm_run_exit_reason("handle_io\n");
>              /* Called outside BQL */
>              kvm_handle_io(run->io.port, attrs,
>                            (uint8_t *)run + run->io.data_offset,
> @@ -2910,7 +2899,7 @@ int kvm_cpu_exec(CPUState *cpu)
>              ret =3D 0;
>              break;
>          case KVM_EXIT_MMIO:
> -            DPRINTF("handle_mmio\n");
> +            trace_kvm_run_exit_reason("handle_mmio\n");
>              /* Called outside BQL */
>              address_space_rw(&address_space_memory,
>                               run->mmio.phys_addr, attrs,
> @@ -2920,11 +2909,11 @@ int kvm_cpu_exec(CPUState *cpu)
>              ret =3D 0;
>              break;
>          case KVM_EXIT_IRQ_WINDOW_OPEN:
> -            DPRINTF("irq_window_open\n");
> +            trace_kvm_run_exit_reason("irq_window_open\n");
>              ret =3D EXCP_INTERRUPT;
>              break;
>          case KVM_EXIT_SHUTDOWN:
> -            DPRINTF("shutdown\n");
> +            trace_kvm_run_exit_reason("shutdown\n");
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              ret =3D EXCP_INTERRUPT;
>              break;
> @@ -2976,14 +2965,14 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret =3D 0;
>                  break;
>              default:
> -                DPRINTF("kvm_arch_handle_exit\n");
> +                trace_kvm_exit_system_event("kvm_arch_handle_exit\n");

Instead of this it would be more useful trace run->system_event.type in
the leg above.

>                  ret =3D kvm_arch_handle_exit(cpu, run);
>                  break;
>              }
>              break;
>          default:
> -            DPRINTF("kvm_arch_handle_exit\n");
>              ret =3D kvm_arch_handle_exit(cpu, run);
> +            trace_kvm_run_exit_reason("kvm_arch_handle_exit\n");

I think this can be deleted as we'll know the path it takes based on exit_r=
eason/system_event.type

>              break;
>          }
>      } while (ret =3D=3D 0);
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 399aaeb0ec..e7b9e9bcc1 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -25,4 +25,10 @@ kvm_dirty_ring_reaper(const char *s) "%s"
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
> +kvm_run_exit_reason(const char *s) "%s"
> +kvm_exit_system_event(const char *s) "%s"

Otherwise it looks like a good clean-up.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

