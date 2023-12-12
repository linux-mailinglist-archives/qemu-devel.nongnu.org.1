Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC580EB29
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:01:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1R9-0007zp-JL; Tue, 12 Dec 2023 07:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD1R5-0007zU-A4
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:00:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD1R3-00015Z-99
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:00:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so31244425e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702382422; x=1702987222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjPlR4Pb5I/jCFcb9HNZhXNjABdthiorh+ZS/7aobU8=;
 b=uTfQVglakc913yiFaRDi9xU984TVRxTngi9HKf/VsGc4SmZJzU/3kkwNRZ61+vhZt0
 gsP2W60l7tpyyCIldeGsNWOpAe5dbRq+YTjSq0joGvecLEG71h/fUlKlGmZHCZyRoSDl
 fnUh2OPpgdN+GDNrxIPsKTGG7x16MuwXRqShbLU/M6QZcwgDgKnzNytZr9aelBeSIPKt
 udUL0tElD5yL86OFerhHN8dMCzcU7CrFRlTep6GzAqvPeYt6yaV5Rs1HuvtU9Honh/nj
 bXEe2sG127ronQ37AuvnQ6l6WwUB+S8d02q8iTU+PFMBIBGUDb4Z18vouV2EbNInRVFH
 Gwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702382422; x=1702987222;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjPlR4Pb5I/jCFcb9HNZhXNjABdthiorh+ZS/7aobU8=;
 b=tRY/TSFu68PMbx555JQPdX13KUUE13ws+gUp4JHCQHe3jPBdSyuUfge4ENsTgpr0Vz
 9MXMx1oBrz+mhod8GH2ucWnj0azsq2k3VkSI81xUBuCIaReegASFuh2h66GajTRVsqUE
 7cb81Bd/piyTqTNkRBO5ib3ajKMVWFm+k44oF5DQNsPOH9pOkvzluuMcQZdYL40p0Qf0
 Tz/4rHUPDvFvMiR0kq6/Fau4vHZyLwmHuok5nx5ueoEP1YUp19xlwQ6UJ9IJKmdIyenR
 Ae5UmvImoRpaQCg9dS5+mUeAP7OX9VBsnWnJHT26Tua8TpJfxGo2MlLGduy1EQuopEcL
 FUkQ==
X-Gm-Message-State: AOJu0Yz0hRnjXJ4lZZtU0AThh2ndDbW/E5FWRwkfqrSp5Ulxki9rV9BL
 RNKdPc2SJ8Cl/72lrCvDv4bcYQ==
X-Google-Smtp-Source: AGHT+IGMozUI7yuB68K75mp0iAvwaIxm8F18e7+izwsOTyWIwzk9DAOzZkzg0Bgw7MjSeCLj3Nk/hg==
X-Received: by 2002:a05:600c:4d0d:b0:40c:2c48:bdc0 with SMTP id
 u13-20020a05600c4d0d00b0040c2c48bdc0mr3148588wmp.136.1702382421681; 
 Tue, 12 Dec 2023 04:00:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c348b00b0040b400711f5sm18746516wmq.7.2023.12.12.04.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 04:00:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA96F5F7D3;
 Tue, 12 Dec 2023 12:00:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: <qemu-devel@nongnu.org>,  <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/tcg: TCG Plugin callback on a vCpu interrupt
In-Reply-To: <20231122121741.21087-1-m.tyutin@yadro.com> (Mikhail Tyutin's
 message of "Wed, 22 Nov 2023 15:17:41 +0300")
References: <20231122121741.21087-1-m.tyutin@yadro.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 12:00:20 +0000
Message-ID: <87jzpjd417.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

> TCG Plugin callback to notify plugins when interrupt is triggered for
> a vCpu. The plugin can optionally use this notification to see reason
> of aborted instruction execution.
>
> Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
> ---
>  accel/tcg/cpu-exec.c         |  5 +++++
>  include/qemu/plugin-event.h  |  1 +
>  include/qemu/plugin.h        |  4 ++++
>  include/qemu/qemu-plugin.h   | 12 +++++++++++-
>  plugins/core.c               | 12 ++++++++++++
>  plugins/qemu-plugins.symbols |  1 +
>  6 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index c938eb96f8..9110f7e290 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c

The biggest problem I have with this approach is we are adding to an
already overly complex exception/interrupt code in the main loop.

> @@ -750,6 +750,7 @@ static inline bool cpu_handle_exception(CPUState *cpu=
, int *ret)
>          if (replay_exception()) {
>              CPUClass *cc =3D CPU_GET_CLASS(cpu);
>              qemu_mutex_lock_iothread();
> +            qemu_plugin_vcpu_interrupt_cb(cpu);
>              cc->tcg_ops->do_interrupt(cpu);

This is at least what we think of as a traditional IRQ. Something that
interrupts the flow of the processor and after some target specific
processing goes somewhere else.

>              qemu_mutex_unlock_iothread();
>              cpu->exception_index =3D -1;
> @@ -829,6 +830,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              /* Do nothing */
>          } else if (interrupt_request & CPU_INTERRUPT_HALT) {
>              replay_interrupt();
> +            qemu_plugin_vcpu_interrupt_cb(cpu);
>              cpu->interrupt_request &=3D ~CPU_INTERRUPT_HALT;
>              cpu->halted =3D 1;

This isn't really an interrupt - its used by a selection of the various
architectures to bring the vCPU to a halted state. However it's not the
only way to halt the CPU as grepping for "->halted =3D 1;" will show you.
If we successfully halt we'll eventually end up calling:

  qemu_plugin_vcpu_idle_cb()=20

>              cpu->exception_index =3D EXCP_HLT;
> @@ -840,6 +842,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              X86CPU *x86_cpu =3D X86_CPU(cpu);
>              CPUArchState *env =3D &x86_cpu->env;
>              replay_interrupt();
> +            qemu_plugin_vcpu_interrupt_cb(cpu);
>              cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
>              do_cpu_init(x86_cpu);
>              cpu->exception_index =3D EXCP_HALTED;

This is some x86 specific hack that we've not managed to find a sensible
way to excise out of the common code.=20

> @@ -849,6 +852,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>  #else
>          else if (interrupt_request & CPU_INTERRUPT_RESET) {
>              replay_interrupt();
> +            qemu_plugin_vcpu_interrupt_cb(cpu);
>              cpu_reset(cpu);

This again is not an IRQ really but another (minority) method for
generating a cold reset in the vCPU. There may be an argument to add a
plugin hook in cpu_reset() but I suspect most of the calls to it would
be artificial artefacts of the way to start and configure vCPUS as we
bring objects up.

>              qemu_mutex_unlock_iothread();
>              return true;
> @@ -866,6 +870,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>                  if (need_replay_interrupt(interrupt_request)) {
>                      replay_interrupt();
>                  }
> +                qemu_plugin_vcpu_interrupt_cb(cpu);

This may be an interrupt but we also may have restarted the loop via
cpu_loop_exit() so missing the rest of the logic. Some of these handlers
will also call cc->tcg_ops->do_interrupt(cpu) like above.

<snip>
>=20=20
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
> +{
> +    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT);
> +}
> +
>  void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>                                         qemu_plugin_vcpu_simple_cb_t cb)
>  {
> @@ -411,6 +417,12 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin=
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
> index 71f6c90549..c8621f9950 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -30,6 +30,7 @@
>    qemu_plugin_register_vcpu_mem_cb;
>    qemu_plugin_register_vcpu_mem_inline;
>    qemu_plugin_register_vcpu_resume_cb;
> +  qemu_plugin_register_vcpu_interrupt_cb;
>    qemu_plugin_register_vcpu_syscall_cb;
>    qemu_plugin_register_vcpu_syscall_ret_cb;
>    qemu_plugin_register_vcpu_tb_exec_cb;

When we add new callbacks we should at least use them in one of the
plugins to check they work.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

