Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F77D3851
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvCs-0000g8-S7; Mon, 23 Oct 2023 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvCq-0000em-C5
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:42:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quvCo-0007Mp-3r
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:42:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso26692655e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698068572; x=1698673372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsALRE6RrHu0YAN38jhq5z9ZVAL7fyhPR2ahdfibRCE=;
 b=IvS7sykEjFLy9K+44zxQJx6oM+SEciHawu9d/fjowRDbZ5+TZV45NowTkfCLMXULwU
 Bp0cx3CTjanHpeVy8Rr0PUu9Q1NEgWDLNQgVVuRGizZV1pZCdmVbcOBVin3+U5IyFmTb
 ptUAd+V4dvd/yBV1PmgqTvNbqRsqetNqTCfiAviJUEgdlXaLbLqpG+F/8gW6k8Ic7yC5
 QxWvBBoWSsCaViLjY5yyuwwLZXFiTVSSxqBHwQh7KKmtCOrh7FRapXaCTGxsDRBtxygh
 aXPiDKiWNe34ZswtY6ANgBYR7SSjUVaF82sRc+tM0ns0+GL2E92UJJlPlIUvQKcoVNWt
 e/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068572; x=1698673372;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tsALRE6RrHu0YAN38jhq5z9ZVAL7fyhPR2ahdfibRCE=;
 b=ZcgnEOv7oiQdURdgSeedUfCGsSf0SyDCrzP3qUSHYEHALmugliX4+suIZTt4Jx2ndP
 ojxZIqsXKSTj3fd7aZOyoYJet1n+oh1FbyxWXFfN2Dyl5R6egTOCKX5TbNrizbix8KXB
 TZW0GvX2jjYnoKqNt7TsH9P9QewfjTYT/5mQqncCFs/HPd+5aRYMh6HX8E/pj8SdIZkp
 aBLw5xawVeeCEdyVSyaGM49DkOVoAZ6+viDNkdgZ/Jc0JdifoX9DE8o7dNQ7fYDsV/IC
 UxbKB4x+hYiqOHCs3Nzu3L2Oy0TPGUL++GolUPVywPlNwdMJFLrx2DTY07BYebcy+2zu
 kiBw==
X-Gm-Message-State: AOJu0YyWsdp3zkvSO8qB504wZ9NoFLm07you1VSkrVHd5s0Gmopyr2+9
 Dmv8IwSYdwatcwufPcQ8BRZREA==
X-Google-Smtp-Source: AGHT+IHqMFLS4s2K/d99tsW0qhpkEpKeuUDwt/W8h+T5hDpvZSxSJojtO9xlPqxwe0Igiv/lKDox7Q==
X-Received: by 2002:a05:600c:1f8d:b0:407:8ee2:9986 with SMTP id
 je13-20020a05600c1f8d00b004078ee29986mr6486852wmb.26.1698068571902; 
 Mon, 23 Oct 2023 06:42:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a05600c339800b0040303a9965asm14191489wmp.40.2023.10.23.06.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:42:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF0F61FFBB;
 Mon, 23 Oct 2023 14:42:50 +0100 (BST)
References: <20231021122502.26746-1-neither@nut.email>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] tcg-plugins: add a hook for interrupts, exceptions and
 traps
Date: Mon, 23 Oct 2023 14:08:51 +0100
In-reply-to: <20231021122502.26746-1-neither@nut.email>
Message-ID: <87v8ax4fqd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> interrupts. For example, we may need to handle the execution of a new
> translation block differently if it is not the result of normal program
> flow but of an interrupt.

I can see the benefit for plugins knowing the context - for QEMU itself
there is no real difference in how it handles blocks that are part of an
interrupt.

> Even with the existing interfaces, it is more or less possible to
> discern these situations using some heuristice. For example, the PC
> landing in a trap vector is a strong indicator that a trap, i.e. an
> interrupt or event occured. However, such heuristics require knowledge
> about the architecture and may be prone to errors.

Does this requirement go away if you can query the current execution
state via registers?

> The callback introduced by this change provides a generic and
> easy-to-use interface for plugin authors. It allows them to register a
> callback in which they may alter some plugin-internal state to convey
> the firing of an interrupt for a given CPU, or perform some stand-alone
> analysis based on the interrupt and, for example, the CPU state.
>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  accel/tcg/cpu-exec.c         |  3 +++
>  include/qemu/plugin-event.h  |  1 +
>  include/qemu/plugin.h        |  4 ++++
>  include/qemu/qemu-plugin.h   | 11 +++++++++++
>  plugins/core.c               | 12 ++++++++++++
>  plugins/qemu-plugins.symbols |  1 +
>  6 files changed, 32 insertions(+)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 1a5bc90220..e094d9236d 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -754,6 +754,8 @@ static inline bool cpu_handle_exception(CPUState *cpu=
, int *ret)
>              qemu_mutex_unlock_iothread();
>              cpu->exception_index =3D -1;
>=20=20
> +            qemu_plugin_vcpu_interrupt_cb(cpu);
> +
>              if (unlikely(cpu->singlestep_enabled)) {
>                  /*
>                   * After processing the exception, ensure an EXCP_DEBUG =
is
> @@ -866,6 +868,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>                  if (need_replay_interrupt(interrupt_request)) {
>                      replay_interrupt();
>                  }
> +                qemu_plugin_vcpu_interrupt_cb(cpu);

My worry here is:

 a) we are conflating QEMU exceptions and interrupts as the same thing
 b) this is leaking internal implementation details of the translator

For example EXCP_SEMIHOST isn't actually an interrupt (we don't change
processor state or control flow). It's just the internal signalling we
use to handle our semihosting implementation. Similarly the
CPU_INTERRUPT_EXITTB interrupt isn't really changing state, just
ensuring we exit the run loop so house keeping is done.

The "correct" way for ARM for example would be to register a helper
function with arm_register_el_change_hook() and trigger the callbacks
that way. However each architecture does its own IRQ modelling so you
would need to work out where in the plumbing to do each callback.

>                  /*
>                   * After processing the interrupt, ensure an EXCP_DEBUG =
is
>                   * raised when single-stepping so that GDB doesn't miss =
the
> diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
> index 7056d8427b..d085bdda4e 100644
> --- a/include/qemu/plugin-event.h
> +++ b/include/qemu/plugin-event.h
> @@ -20,6 +20,7 @@ enum qemu_plugin_event {
>      QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
>      QEMU_PLUGIN_EV_FLUSH,
>      QEMU_PLUGIN_EV_ATEXIT,
> +    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
>      QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
>  };
>=20=20
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 7fdc3a4849..f942e45f41 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -190,6 +190,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
>  void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
>  void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
>  void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu);
>  void
>  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>                           uint64_t a2, uint64_t a3, uint64_t a4, uint64_t=
 a5,
> @@ -270,6 +271,9 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState =
*cpu)
>  static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>  { }
>=20=20
> +static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
> +{ }
> +
>  static inline void
>  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64=
_t a2,
>                           uint64_t a3, uint64_t a4, uint64_t a5, uint64_t=
 a6,
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 50a9957279..2eb4b325fe 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -206,6 +206,17 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_i=
d_t id,
>  void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>                                           qemu_plugin_vcpu_simple_cb_t cb=
);
>=20=20
> +/**
> + * qemu_plugin_register_vcpu_interrupt_cb() - register a vCPU interrupt =
callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU receives an interrupt, e=
xception
> + * or trap.

As discussed above you would trigger for a lot more than that. You would
also miss a lot of the other interesting transitions which don't need an
asynchronous signal. For example HELPER(exception_return) happily
changes control flow but doesn't need to use the exception mechanism to
do it.=20

> + */
> +void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
> +                                            qemu_plugin_vcpu_simple_cb_t=
 cb);
> +
>  /** struct qemu_plugin_tb - Opaque handle for a translation block */
>  struct qemu_plugin_tb;
>  /** struct qemu_plugin_insn - Opaque handle for a translated instruction=
 */
> diff --git a/plugins/core.c b/plugins/core.c
> index fcd33a2bff..3658bdef45 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -103,6 +103,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enu=
m qemu_plugin_event ev)
>      case QEMU_PLUGIN_EV_VCPU_EXIT:
>      case QEMU_PLUGIN_EV_VCPU_IDLE:
>      case QEMU_PLUGIN_EV_VCPU_RESUME:
> +    case QEMU_PLUGIN_EV_VCPU_INTERRUPT:
>          /* iterate safely; plugins might uninstall themselves at any tim=
e */
>          QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>              qemu_plugin_vcpu_simple_cb_t func =3D cb->f.vcpu_simple;
> @@ -400,6 +401,11 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>      plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
>  }
>=20=20
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
> +{
> +    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT);
> +}
> +
>  void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>                                         qemu_plugin_vcpu_simple_cb_t cb)
>  {
> @@ -412,6 +418,12 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin=
_id_t id,
>      plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
>  }
>=20=20
> +void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
> +                                            qemu_plugin_vcpu_simple_cb_t=
 cb)
> +{
> +    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
> +}
> +
>  void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>                                     qemu_plugin_simple_cb_t cb)
>  {
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index 71f6c90549..1fddb4b9fd 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -35,6 +35,7 @@
>    qemu_plugin_register_vcpu_tb_exec_cb;
>    qemu_plugin_register_vcpu_tb_exec_inline;
>    qemu_plugin_register_vcpu_tb_trans_cb;
> +  qemu_plugin_register_vcpu_interrupt_cb;
>    qemu_plugin_reset;
>    qemu_plugin_start_code;
>    qemu_plugin_tb_get_insn;

I'm not opposed to adding such a API hook to plugins but I don't think
the current approach does what you want. If we do add a new API it is
customary to either expand an existing plugin or add a new one to
demonstrate the use of the API.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

