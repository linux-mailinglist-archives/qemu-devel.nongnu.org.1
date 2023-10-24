Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25B7D594E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKnx-0004GF-VD; Tue, 24 Oct 2023 13:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKnV-0003VW-GA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:02:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKnO-0003ia-Hr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:02:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so37036755e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166940; x=1698771740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQIax2Mz5cX5N+RLCjRimcxzVsgA8PBK6STadh2qKyo=;
 b=rfvjlrUNB6WX4Acp/RmbAeoRNqOGg7NHpPFN2SAHYMK/jzUOyupMt8jV9cRZnjtEk7
 +653ZY2jI7yrGoI+ZT9urUhtmyZJsC5YHwZ8Q+LkTU4pvtEAwj9hc3qCEVsM4F9vtnez
 IlHCAqKty0IhKsoEG20tlc3ZEp4Hw/RUHdVsbAlD7IcoAWvaJ/yCDHvapOmYNbe/Nr2d
 sVR0GJs8+T/fjuBICaJ9afkYCY/MCu5z+UtiYHAZhTjwTScSJk37yp5t4DYtodofa8FN
 p1KRKbEz8lzLBihGIk1EGLvK5x2uqJI4V52NxasXyRyUZE1IjSqUJCb8wywxOLpM3hfl
 c59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166940; x=1698771740;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HQIax2Mz5cX5N+RLCjRimcxzVsgA8PBK6STadh2qKyo=;
 b=QV7VFnH/IkbKOc6Ws6o/ieDVSWwBLJr8UatcJelbTVGSiItWV9Ak9DP+x2hxP1Bufz
 zed3G0DYP2GYqPqvalCGe2pbPfXs8bdB9WqW4BCD2ifAQMt39IyL/KTniWSaGm4Sd9vQ
 JMOFwMboo7kI6OiNqTcgQXifGdNNZQQX8xiNmI/dsnJrTgaMOgVCpXo3vsua5SStFrHg
 qaKRt9MvA6bD65HQu6FaisqxZtwyduqgycrd6cW9nDu8J24OgC/v/ZgWJUD+PyKjQFx+
 D7JTPtRuHwJyTuIelssymFhaHgWtgEjvUjHGxu+GSa9eie/0PzX9XLuKuAtp08d8GlFg
 Giag==
X-Gm-Message-State: AOJu0YwD9OE+M11IkB/plaUI7H+VM0lfL/Hj3H+m999l+ajjkdiLTACq
 5YEjCWXddjo8miudGXhiMdCUWMtf8QshkWz7poM=
X-Google-Smtp-Source: AGHT+IGYhyETg8E6VOaAslp1RkrKjuAxt8wv1i7TjNk8idDvUN4uodpqda3Ey+UWPfhEna293amPvA==
X-Received: by 2002:a05:600c:3b0c:b0:407:612b:91fb with SMTP id
 m12-20020a05600c3b0c00b00407612b91fbmr10426887wms.30.1698166940270; 
 Tue, 24 Oct 2023 10:02:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c481200b00407b93d8085sm16948484wmo.27.2023.10.24.10.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:02:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 513CA1FFBB;
 Tue, 24 Oct 2023 18:02:19 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-17-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH v14 16/18] plugins: Use different helpers when reading
 registers
Date: Tue, 24 Oct 2023 17:48:54 +0100
In-reply-to: <20231019102657.129512-17-akihiko.odaki@daynix.com>
Message-ID: <87h6mg0x9g.fsf@linaro.org>
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This avoids optimizations incompatible when reading registers.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  accel/tcg/plugin-helpers.h |  3 ++-
>  include/exec/plugin-gen.h  |  4 ++--
>  include/hw/core/cpu.h      |  4 ++--
>  include/qemu/plugin.h      |  3 +++
>  plugins/plugin.h           |  5 +++--
>  accel/tcg/plugin-gen.c     | 41 ++++++++++++++++++++++++++++----------
>  accel/tcg/translator.c     |  2 +-
>  plugins/api.c              | 14 +++++++++++--
>  plugins/core.c             | 28 ++++++++++++++++----------
>  9 files changed, 72 insertions(+), 32 deletions(-)
>
> diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
> index 8e685e0654..11796436f3 100644
> --- a/accel/tcg/plugin-helpers.h
> +++ b/accel/tcg/plugin-helpers.h
> @@ -1,4 +1,5 @@
<snip>
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -437,7 +437,7 @@ struct qemu_work_item;
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
>   *                        to @trace_dstate).
>   * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
> - * @plugin_mask: Plugin event bitmap. Modified only via async work.
> + * @plugin_flags: Plugin flags. Modified only via async work.
>   * @ignore_memory_transaction_failures: Cached copy of the MachineState
>   *    flag of the same name: allows the board to suppress calling of the
>   *    CPU do_transaction_failed hook function.
> @@ -529,7 +529,7 @@ struct CPUState {
>      /* Use by accel-block: CPU is executing an ioctl() */
>      QemuLockCnt in_ioctl_lock;
>=20=20
> -    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
> +    unsigned long plugin_flags;

Why are we dropping DECLARE_BITMAP here? It does ensure we will always
have the right size.

>=20=20
>  #ifdef CONFIG_PLUGIN
>      GArray *plugin_mem_cbs;
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 7fdc3a4849..a534b9127b 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -16,6 +16,9 @@
>  #include "exec/memopidx.h"
>  #include "hw/core/cpu.h"
>=20=20
> +#define QEMU_PLUGIN_FLAG_TB_CB_READ QEMU_PLUGIN_EV_MAX
> +#define QEMU_PLUGIN_FLAG_INSN_CB_READ (QEMU_PLUGIN_EV_MAX + 1)
> +

OK this seems like bad code smell. Are we overloading what was
plugin_mask to indicate two different things? I can see we only really
use the flags to indicate syscalls should generate callbacks so maybe
this could be rationlised but at least split into two patches so the
change to original behaviour isn't mixed up with new added behaviour.

>  /*
>   * Option parsing/processing.
>   * Note that we can load an arbitrary number of plugins.
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 5eb2fdbc85..ba0417194f 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -16,6 +16,7 @@
>  #include "qemu/qht.h"
>=20=20
>  #define QEMU_PLUGIN_MIN_VERSION 0
> +#define QEMU_PLUGIN_FLAG_INSIN_CB_READ QEMU_PLUGIN_EV_MAX

Double definition.

>=20=20
>  /* global state */
>  struct qemu_plugin_state {
> @@ -31,7 +32,7 @@ struct qemu_plugin_state {
>       * but with the HT we avoid adding a field to CPUState.
>       */
>      GHashTable *cpu_ht;
> -    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
> +    unsigned long flags;
>      /*
>       * @lock protects the struct as well as ctx->uninstalling.
>       * The lock must be acquired by all API ops.
> @@ -86,7 +87,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu=
_plugin_event ev,
>  void
>  plugin_register_dyn_cb__udata(GArray **arr,
>                                qemu_plugin_vcpu_udata_cb_t cb,
> -                              enum qemu_plugin_cb_flags flags, void *uda=
ta);
> +                              unsigned int flags, void *udata);
>=20=20
>=20=20
>  void plugin_register_vcpu_mem_cb(GArray **arr,
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 78b331b251..3bddd4d3c5 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -90,7 +90,10 @@ enum plugin_gen_cb {
>   * These helpers are stubs that get dynamically switched out for calls
>   * direct to the plugin if they are subscribed to.
>   */
> -void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
> +void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
> +{ }
> +
> +void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
>  { }
>=20=20
>  void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
> @@ -98,7 +101,7 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_inde=
x,
>                                  void *userdata)
>  { }
>=20=20
> -static void gen_empty_udata_cb(void)
> +static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
>  {
>      TCGv_i32 cpu_index =3D tcg_temp_ebb_new_i32();
>      TCGv_ptr udata =3D tcg_temp_ebb_new_ptr();
> @@ -106,12 +109,22 @@ static void gen_empty_udata_cb(void)
>      tcg_gen_movi_ptr(udata, 0);
>      tcg_gen_ld_i32(cpu_index, tcg_env,
>                     -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_inde=
x));
> -    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
> +    gen_helper(cpu_index, udata);
>=20=20
>      tcg_temp_free_ptr(udata);
>      tcg_temp_free_i32(cpu_index);
>  }
>=20=20
> +static void gen_empty_udata_cb_no_wg(void)
> +{
> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
> +}
> +
> +static void gen_empty_udata_cb_no_rwg(void)
> +{
> +    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
> +}
> +
>  /*
>   * For now we only support addi_i64.
>   * When we support more ops, we can generate one empty inline cb for eac=
h.
> @@ -176,7 +189,7 @@ static void gen_wrapped(enum plugin_gen_from from,
>      tcg_gen_plugin_cb_end();
>  }
>=20=20
> -static void plugin_gen_empty_callback(enum plugin_gen_from from)
> +static void plugin_gen_empty_callback(CPUState *cpu, enum plugin_gen_fro=
m from)
>  {
>      switch (from) {
>      case PLUGIN_GEN_AFTER_INSN:
> @@ -190,9 +203,15 @@ static void plugin_gen_empty_callback(enum plugin_ge=
n_from from)
>           */
>          gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
>                      gen_empty_mem_helper);
> -        /* fall through */
> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
> +                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_INSN_CB_REA=
D) ?
> +                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg=
);
> +        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
> +        break;
>      case PLUGIN_GEN_FROM_TB:
> -        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
> +        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
> +                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_TB_CB_READ)=
 ?
> +                    gen_empty_udata_cb_no_wg :
> gen_empty_udata_cb_no_rwg);

What stops us from generating two empty callbacks (one no_wg one no_rwg)
and just discarding the unused ones after the instrumentation pass?

>          gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
>          break;
>      default:
> @@ -796,7 +815,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasCo=
ntextBase *db,
>  {
>      bool ret =3D false;
>=20=20
> -    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
> +    if (cpu->plugin_flags & BIT(QEMU_PLUGIN_EV_VCPU_TB_TRANS)) {
>          struct qemu_plugin_tb *ptb =3D tcg_ctx->plugin_tb;
>          int i;
>=20=20
> @@ -817,7 +836,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasCo=
ntextBase *db,
>          ptb->mem_only =3D mem_only;
>          ptb->mem_helper =3D false;
>=20=20
> -        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
> +        plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_TB);
>      }
>=20=20
>      tcg_ctx->plugin_insn =3D NULL;
> @@ -832,7 +851,7 @@ void plugin_gen_insn_start(CPUState *cpu, const Disas=
ContextBase *db)
>=20=20
>      pinsn =3D qemu_plugin_tb_insn_get(ptb, db->pc_next);
>      tcg_ctx->plugin_insn =3D pinsn;
> -    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
> +    plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_INSN);
>=20=20
>      /*
>       * Detect page crossing to get the new host address.
> @@ -852,9 +871,9 @@ void plugin_gen_insn_start(CPUState *cpu, const Disas=
ContextBase *db)
>      }
>  }
>=20=20
> -void plugin_gen_insn_end(void)
> +void plugin_gen_insn_end(CPUState *cpu)
>  {
> -    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
> +    plugin_gen_empty_callback(cpu, PLUGIN_GEN_AFTER_INSN);
>  }
>=20=20
>  /*
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 575b9812ad..bec58dd93f 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -189,7 +189,7 @@ void translator_loop(CPUState *cpu, TranslationBlock =
*tb, int *max_insns,
>           * to accurately track instrumented helpers that might access me=
mory.
>           */
>          if (plugin_enabled) {
> -            plugin_gen_insn_end();
> +            plugin_gen_insn_end(cpu);
>          }
>=20=20
>          /* Stop translation if translate_insn so indicated.  */
> diff --git a/plugins/api.c b/plugins/api.c
> index 5521b0ad36..326e37cb73 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -89,8 +89,13 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_=
plugin_tb *tb,
>                                            void *udata)
>  {
>      if (!tb->mem_only) {
> +        bool read =3D flags =3D=3D QEMU_PLUGIN_CB_R_REGS ||
> +                    flags =3D=3D QEMU_PLUGIN_CB_RW_REGS;
> +
>          plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
> -                                      cb, flags, udata);
> +                                      cb,
> +                                      read ? BIT(QEMU_PLUGIN_FLAG_TB_CB_=
READ) : 0,
> +                                      udata);
>      }
>  }
>=20=20
> @@ -109,8 +114,13 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct q=
emu_plugin_insn *insn,
>                                              void *udata)
>  {
>      if (!insn->mem_only) {
> +        bool read =3D flags =3D=3D QEMU_PLUGIN_CB_R_REGS ||
> +                    flags =3D=3D QEMU_PLUGIN_CB_RW_REGS;
> +
>          plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_=
CB_REGULAR],
> -                                      cb, flags, udata);
> +                                      cb,
> +                                      read ? BIT(QEMU_PLUGIN_FLAG_INSN_C=
B_READ) : 0,
> +                                      udata);
>      }
>  }
>=20=20
> diff --git a/plugins/core.c b/plugins/core.c
> index fcd33a2bff..f461e84473 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -55,19 +55,19 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_=
plugin_id_t id)
>=20=20
>  static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
>  {
> -    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
> +    cpu->plugin_flags =3D data.host_ulong;
>      tcg_flush_jmp_cache(cpu);
>  }
>=20=20
>  static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer u=
data)
>  {
>      CPUState *cpu =3D container_of(k, CPUState, cpu_index);
> -    run_on_cpu_data mask =3D RUN_ON_CPU_HOST_ULONG(*plugin.mask);
> +    run_on_cpu_data flags =3D RUN_ON_CPU_HOST_ULONG(plugin.flags);
>=20=20
>      if (DEVICE(cpu)->realized) {
> -        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
> +        async_run_on_cpu(cpu, plugin_cpu_update__async, flags);
>      } else {
> -        plugin_cpu_update__async(cpu, mask);
> +        plugin_cpu_update__async(cpu, flags);
>      }
>  }
>=20=20
> @@ -83,7 +83,7 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ct=
x *ctx,
>      g_free(cb);
>      ctx->callbacks[ev] =3D NULL;
>      if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
> -        clear_bit(ev, plugin.mask);
> +        plugin.flags &=3D ~BIT(ev);
>          g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, N=
ULL);
>      }
>  }
> @@ -186,8 +186,8 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_=
plugin_event ev,
>              cb->udata =3D udata;
>              ctx->callbacks[ev] =3D cb;
>              QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
> -            if (!test_bit(ev, plugin.mask)) {
> -                set_bit(ev, plugin.mask);
> +            if (!(plugin.flags & BIT(ev))) {
> +                plugin.flags |=3D BIT(ev);
>                  g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__l=
ocked,
>                                       NULL);
>              }
> @@ -296,15 +296,20 @@ void plugin_register_inline_op(GArray **arr,
>=20=20
>  void plugin_register_dyn_cb__udata(GArray **arr,
>                                     qemu_plugin_vcpu_udata_cb_t cb,
> -                                   enum qemu_plugin_cb_flags flags,
> +                                   unsigned int flags,
>                                     void *udata)
>  {
>      struct qemu_plugin_dyn_cb *dyn_cb =3D plugin_get_dyn_cb(arr);
>=20=20
>      dyn_cb->userp =3D udata;
> -    /* Note flags are discarded as unused. */
>      dyn_cb->f.vcpu_udata =3D cb;
>      dyn_cb->type =3D PLUGIN_CB_REGULAR;
> +
> +    if (flags) {
> +        QEMU_LOCK_GUARD(&plugin.lock);
> +        plugin.flags |=3D flags;
> +        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, N=
ULL);
> +    }
>  }
>=20=20
>  void plugin_register_vcpu_mem_cb(GArray **arr,
> @@ -357,7 +362,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, =
uint64_t a1, uint64_t a2,
>      struct qemu_plugin_cb *cb, *next;
>      enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_SYSCALL;
>=20=20
> -    if (!test_bit(ev, cpu->plugin_mask)) {
> +    if (!(cpu->plugin_flags & BIT(ev))) {
>          return;
>      }
>=20=20
> @@ -379,7 +384,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int6=
4_t num, int64_t ret)
>      struct qemu_plugin_cb *cb, *next;
>      enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
>=20=20
> -    if (!test_bit(ev, cpu->plugin_mask)) {
> +    if (!(cpu->plugin_flags & BIT(ev))) {
>          return;
>      }
>=20=20
> @@ -428,6 +433,7 @@ void qemu_plugin_flush_cb(void)
>  {
>      qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
>      qht_reset(&plugin.dyn_cb_arr_ht);
> +    plugin.flags &=3D ~BIT(QEMU_PLUGIN_FLAG_INSIN_CB_READ);
>=20=20
>      plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
>  }


I'm a bit confused about what we are trying to achieve here. I think
split the changes and some better commentary would help.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

