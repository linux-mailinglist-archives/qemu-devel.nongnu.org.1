Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A6577B6C3
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 12:34:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVUsT-0002qz-Eb; Mon, 14 Aug 2023 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUsQ-0002pV-Fv
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:32:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUsM-0004Ou-5A
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:32:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe490c05c9so29453235e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692009160; x=1692613960;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FNWtGpb3cBNBN0kx9zlXVs0kNtqViwXMiWqEqn81OY=;
 b=R+Z1xOkgknGXlLdnFcywLXHNCx0uC9b9j3J+jvcdG/qlJ7nBAPPDoZydWw3q04jLk9
 1YdsYx5lwxjiMgrGddCXF2crLeDF3n4z9N+eKgNCx6jifOa8wjderLuD443cmgZQFw8Y
 U2xiKU0/b6WfY7Oz8rUkKOsmyyqFAHdAItBbK1W/FQt/j2lJv1hvPKxL7AwQ8zhWlIW6
 le4OnkCxusKR/RAaANh3Eh0iKidhDjWd31pGnY+kdgveubdWaIlAcRlzCU8HQh/DOp/F
 YF7E0JZVQ5k+f/HWPlA/xIKWKqWMDPZbRhYMIwYaCiDZoDJ0r/bedeyg+/9cSavde32p
 +GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692009160; x=1692613960;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3FNWtGpb3cBNBN0kx9zlXVs0kNtqViwXMiWqEqn81OY=;
 b=fKrIWY2xyNT4bX73OFXCg/RmOaUuGRft1SZW1AV0dwDKbS5pwCWncuPFhyEvrgWLee
 mH4MMXxhE5oNfQDbfoQaxyMDshT3J+gQ1sgJGGTBC3ff7LbyWk9zt6dd7/fWmjLmkLF/
 0fuebVWKGKRp9t58TX04+5zIiEADZ3VucIaDpF9JcF+r3mVcsEAglQGkolA84Gt9izk1
 PA1gHDBD54RV8nCNBslQNSQuq2evJ2W6Hag29p5uWpZBqEznEeE9s1KyNHMfTI1ciIGG
 f12daUg2CAN4/iM+3HlU2alnxsILp27Jg03ASpUJFzwxMGYYLsrDgRkZ31s2p8+374Xd
 +O0g==
X-Gm-Message-State: AOJu0Yx062ZBn9cuGBMH52VgF+MKAjkykh5Nl6K98O4LOjNy1P3hMQbv
 7yDA00d8+VUaynr6HJO2Hg5Hjw==
X-Google-Smtp-Source: AGHT+IHHVBdpTefk/hV81oXaf/dxNl+8MlFGHYdgD47aLJJxptsqEu7tqr9YiqJcJzaMaNHSfy0MKQ==
X-Received: by 2002:a7b:cbc7:0:b0:3fb:af9a:bf30 with SMTP id
 n7-20020a7bcbc7000000b003fbaf9abf30mr7104797wmi.2.1692009160236; 
 Mon, 14 Aug 2023 03:32:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b003fe17e04269sm13874958wmj.40.2023.08.14.03.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 03:32:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35F941FFBB;
 Mon, 14 Aug 2023 11:32:39 +0100 (BST)
References: <20230803112551.14803-1-m.tyutin@yadro.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Mikhail Tyutin <m.tyutin@yadro.com>
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, Aleksandr Anenkov
 <a.anenkov@yadro.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] Add api to read CPU registers in TCG plugins
Date: Mon, 14 Aug 2023 11:22:59 +0100
In-reply-to: <20230803112551.14803-1-m.tyutin@yadro.com>
Message-ID: <87ttt1sym0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Mikhail Tyutin <m.tyutin@yadro.com> writes:

> From: Aleksandr Anenkov <a.anenkov@yadro.com>
>
> This commit:
> - adds a plugin API to read the registers of the current CPU
> - introduces qemu_plugin_reg_ctx structure for faster data gathering of
>   a set of registers without memory reallocation
> - adds an example plugin showing how to work with this API
> - fixes for GDB that read wrong register 'eflags' value
> - minor performance improvements when reading registers from GDB

You've managed to submit a patch at the same time as another independent
implementation:

  Message-ID: <20230731084354.115015-1-akihiko.odaki@daynix.com>
  Date: Mon, 31 Jul 2023 17:43:27 +0900
  Subject: [RFC PATCH 00/24] plugins: Allow to read registers
  From: Akihiko Odaki <akihiko.odaki@daynix.com>

I'm going to review his series now as it looks more complete and is
better structured. However should you want to re-submit a few notes:

  - please split patches into separate chunks to aid review, for
    example:
     - core gdbstub changes
     - plugin api
     - example plugin
     - expand register set for one architecture at a time

>
> In this commit, we rely on the already written register
> reading code that QEMU for GDB has.
>
> Why is the GDB code used
> Each CPU architecture contains its own set of registers.
> At the same time, QEMU does not contain a unified code architecture
> for working with registers in various CPU architectures.
> Each implementation of the CPU architecture in QEMU locates, reads,
> and writes registers differently. In addition, each register has
> its own specifics for reading and writing. Fortunately,
> the GDB part of QEMU code already contains something unified
> and complete. So in terms of simplicity and minimal code
> changes of QEMU, we're just reusing what's already in GDB.
> It works without having to run the GDB server.

I've been trying to avoid exposing GDB register numbers to the plugin
API because they are fairly arbitrary. The long term plan was to
abstract all the various users in QEMU and have a common sub-system to
deal with this but as that work is blocked on time I'm willing to
consider short cutting this and using the gdb backend directly inside
QEMU. However I don't want the API exposed to the plugins to expose
these details so I'd rather that we have anonymous handles to registers
rather than gdb register numbers exposed to the plugins. That way if we
ever do get QEMU's internals in order we don't have to tweak the plugin
API.

>
> How it works
> The existing GDB code in QEMU already knows how to read registers
> by register number, but cannot do it by register name.
> QEMU has xml files using GDB Target Description Format to describe
> targets sourceware.org/gdb/onlinedocs/gdb/Target-Description-Format.html
> from where GDB gets information about all registers. It only remained
> to "teach" QEMU to read register names from these files the way GDB
> itself does it and remember them in order to convert back to numbers
> from the user API.
>
> Signed-off-by: Aleksandr Anenkov <a.anenkov@yadro.com>
> ---
>  contrib/plugins/Makefile     |   1 +
>  contrib/plugins/registers.c  | 231 +++++++++++++++++++++++++++++
>  gdb-xml/i386-32bit.xml       |   9 ++
>  gdb-xml/i386-64bit.xml       |  17 +++
>  gdbstub/gdbstub.c            | 280 +++++++++++++++++++++++++++++++++--
>  include/exec/gdbstub.h       |  36 +++++
>  include/hw/core/cpu.h        |   3 +
>  include/qemu/qemu-plugin.h   | 105 ++++++++++++-
>  plugins/api.c                | 223 ++++++++++++++++++++++++++++
>  plugins/qemu-plugins.symbols |  10 ++
>  target/arm/cpu.c             |   2 +
>  target/arm/gdbstub.c         |   2 +-
>  target/i386/cpu.c            |   6 +-
>  target/i386/gdbstub.c        |  25 +++-
>  target/riscv/cpu.c           |   3 +
>  target/riscv/gdbstub.c       |   3 +-
>  16 files changed, 933 insertions(+), 23 deletions(-)
>  create mode 100644 contrib/plugins/registers.c
>
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index b2b9db9f51..e14c07ddcc 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -21,6 +21,7 @@ NAMES +=3D lockstep
>  NAMES +=3D hwprofile
>  NAMES +=3D cache
>  NAMES +=3D drcov
> +NAMES +=3D registers
>=20=20
>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>=20=20
> diff --git a/contrib/plugins/registers.c b/contrib/plugins/registers.c
> new file mode 100644
> index 0000000000..ae40a27f5f
> --- /dev/null
> +++ b/contrib/plugins/registers.c
> @@ -0,0 +1,231 @@
> +/*
> + * Log register states
> + *
> + * Copyright (c) 2022 YADRO.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <glib.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +/* Print report to file every N instructions */
> +#define REPORT_BUF_N_INSN 1000000
> +
> +typedef enum target_t {
> +    UNKNOWN_TARGET,
> +    X86_64_TARGET,
> +    RISCV64_TARGET
> +} target_t;
> +
> +target_t target =3D UNKNOWN_TARGET;
> +bool system_emulation =3D false;
> +
> +const char *const X86_64_REGS[] =3D { "rax", "rbx", "rcx", "rdx", "rsi",=
 "rdi",
> +                                    "rbp", "rsp", "rip", "eflags", "xmm0=
", "ymm0h" };
> +const char *const RISCV64_REGS[] =3D { "zero", "ra", "sp", "gp", "tp", "=
t0",
> +                                     "a0", "a1", "ft0", "vstart" };
> +
> +/*
> + * Each vcpu has its own independent data set, which is only initialized=
 once
> + */
> +typedef struct vcpu_cache {
> +    struct qemu_plugin_reg_ctx *reg_ctx;
> +    GString *report;
> +    size_t report_counter;
> +    unsigned int vcpu_index;
> +} vcpu_cache;
> +
> +vcpu_cache *caches =3D NULL;
> +
> +static void print_register_values(GString *report, const void *data, siz=
e_t size)
> +{
> +    if (size =3D=3D 4) {
> +        g_string_append_printf(report, "%08x", *(uint32_t *)data);
> +    }
> +    else if (size =3D=3D 8) {
> +        g_string_append_printf(report, "%016" PRIx64, *(uint64_t *)data);
> +    }
> +    else if (size % sizeof(uint64_t) =3D=3D 0) {
> +        const uint64_t *vec =3D (uint64_t *)data;
> +        int i, vec_length =3D size / sizeof(uint64_t);
> +        for (i =3D 0; i < vec_length; i++) {
> +            g_string_append_printf(report, "%016" PRIx64 " ", vec[i]);
> +        }
> +    }
> +    else {
> +        qemu_plugin_outs("Unknown register\n");
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +static void print_avail_register_names(vcpu_cache *cache)
> +{
> +    char *buf =3D NULL;
> +    size_t buf_size =3D 0, bytes_written =3D 0;
> +
> +    buf_size =3D qemu_plugin_get_available_reg_names(NULL, 0);
> +    g_assert(buf_size > 0);
> +
> +    buf =3D g_new0(char, buf_size);
> +    bytes_written =3D qemu_plugin_get_available_reg_names(buf, buf_size);
> +    g_assert(bytes_written =3D=3D buf_size);
> +
> +    g_string_append_printf(cache->report, "vcpu=3D%u, available register=
s: %s", cache->vcpu_index, buf);
> +    g_string_append_printf(cache->report, "\n");
> +    g_free(buf);
> +}
> +
> +static void init_vcpu_cache(unsigned int vcpu_index, vcpu_cache *cache)
> +{
> +    if (cache->reg_ctx !=3D NULL)
> +        return;
> +
> +    cache->report =3D g_string_new("");
> +    cache->report_counter =3D 0;
> +    cache->vcpu_index =3D vcpu_index;
> +
> +    print_avail_register_names(cache);
> +
> +    if (target =3D=3D X86_64_TARGET) {
> +        cache->reg_ctx =3D qemu_plugin_reg_create_context(X86_64_REGS,
> +            sizeof(X86_64_REGS) / sizeof(X86_64_REGS[0]));
> +    }
> +    else if (target =3D=3D RISCV64_TARGET) {
> +        cache->reg_ctx =3D qemu_plugin_reg_create_context(RISCV64_REGS,
> +            sizeof(RISCV64_REGS) / sizeof(RISCV64_REGS[0]));
> +    }
> +    else {
> +        g_assert_not_reached();
> +    }
> +
> +    if (cache->reg_ctx =3D=3D NULL) {
> +        qemu_plugin_outs("Failed to create context\n");
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +static void free_vcpu_cache(vcpu_cache *cache)
> +{
> +    if (cache =3D=3D NULL)
> +        return;
> +
> +    if (cache->report)
> +        g_string_free(cache->report, true);
> +    qemu_plugin_reg_free_context(cache->reg_ctx);
> +}
> +
> +/**
> + * Log registers on instruction execution
> + */
> +static void vcpu_insn_exec(unsigned int vcpu_index, void *udata)
> +{
> +    vcpu_cache *cache =3D &caches[vcpu_index];
> +    init_vcpu_cache(vcpu_index, cache);
> +
> +    qemu_plugin_regs_load(cache->reg_ctx);
> +
> +    size_t i, n_regs =3D qemu_plugin_n_regs(cache->reg_ctx);
> +    for (i =3D 0; i < n_regs; i++) {
> +        const void *data =3D qemu_plugin_reg_ptr(cache->reg_ctx, i);
> +        size_t size =3D qemu_plugin_reg_size(cache->reg_ctx, i);
> +        const char *name =3D qemu_plugin_reg_name(cache->reg_ctx, i);
> +        g_string_append_printf(cache->report, "vcpu=3D%u, %s=3D", vcpu_i=
ndex, name);
> +        print_register_values(cache->report, data, size);
> +        g_string_append_printf(cache->report, ", size=3D%ld\n", size);
> +    }
> +
> +    cache->report_counter++;
> +    if (cache->report_counter >=3D REPORT_BUF_N_INSN) {
> +        qemu_plugin_outs(cache->report->str);
> +        g_string_erase(cache->report, 0, cache->report->len);
> +        cache->report_counter =3D 0;
> +    }
> +}
> +
> +/**
> + * On translation block new translation
> + *
> + * QEMU converts code by translation block (TB). By hooking here we can =
then hook
> + * a callback on each instruction.
> + */
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    struct qemu_plugin_insn *insn;
> +
> +    size_t n =3D qemu_plugin_tb_n_insns(tb);
> +    for (size_t i =3D 0; i < n; i++) {
> +        insn =3D qemu_plugin_tb_get_insn(tb, i);
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> +                                               QEMU_PLUGIN_CB_R_REGS, NU=
LL);
> +    }
> +}
> +
> +static int get_n_max_vcpus(void)
> +{
> +    return (system_emulation) ? qemu_plugin_n_max_vcpus() : 1;
> +}
> +
> +/**
> + * On plugin exit, print report and free memory
> + */
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    if (caches !=3D NULL) {
> +        int n_cpus =3D get_n_max_vcpus();
> +        int i;
> +        for (i =3D 0; i < n_cpus; i++) {
> +            if (caches[i].report)
> +                qemu_plugin_outs(caches[i].report->str);
> +            free_vcpu_cache(&caches[i]);
> +        }
> +        g_free(caches);
> +    }
> +}
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    if (!system_emulation && vcpu_index > 0) {
> +        qemu_plugin_outs("Multithreading in user-mode is not supported\n=
");
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +/**
> + * Install the plugin
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int =
argc,
> +                                           char **argv)
> +{
> +    if (strcmp(info->target_name, "x86_64") =3D=3D 0)
> +        target =3D X86_64_TARGET;
> +    else if (strcmp(info->target_name, "riscv64") =3D=3D 0)
> +        target =3D RISCV64_TARGET;
> +    else {
> +        qemu_plugin_outs("Unknown architecture\n");
> +        return -1;
> +    }
> +    system_emulation =3D info->system_emulation;
> +
> +    caches =3D g_new0(vcpu_cache, get_n_max_vcpus());
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}
> diff --git a/gdb-xml/i386-32bit.xml b/gdb-xml/i386-32bit.xml
> index 7a66a02b67..84b872a329 100644
> --- a/gdb-xml/i386-32bit.xml
> +++ b/gdb-xml/i386-32bit.xml
> @@ -189,4 +189,13 @@
>    <reg name=3D"xmm7" bitsize=3D"128" type=3D"vec128"/>
>=20=20
>    <reg name=3D"mxcsr" bitsize=3D"32" type=3D"i386_mxcsr" group=3D"vector=
"/>
> +
> +  <reg name=3D"ymm0h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm1h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm2h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm3h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm4h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm5h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm6h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm7h" bitsize=3D"128" type=3D"uint128"/>
>  </feature>
> diff --git a/gdb-xml/i386-64bit.xml b/gdb-xml/i386-64bit.xml
> index 6d88969211..3b8f437ff2 100644
> --- a/gdb-xml/i386-64bit.xml
> +++ b/gdb-xml/i386-64bit.xml
> @@ -213,4 +213,21 @@
>    <reg name=3D"xmm15" bitsize=3D"128" type=3D"vec128"/>
>=20=20
>    <reg name=3D"mxcsr" bitsize=3D"32" type=3D"x64_mxcsr" group=3D"vector"=
/>
> +
> +  <reg name=3D"ymm0h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm1h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm2h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm3h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm4h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm5h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm6h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm7h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm8h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm9h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm10h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm11h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm12h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm13h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm14h" bitsize=3D"128" type=3D"uint128"/>
> +  <reg name=3D"ymm15h" bitsize=3D"128" type=3D"uint128"/>
>  </feature>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index ce8b42eb15..bf4d54f95e 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -351,12 +351,32 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t=
 tid)
>      }
>  }
>=20=20
> +static const char *get_feature_xml_from_cpu(CPUState *cpu, const char *x=
mlname)
> +{
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    size_t len =3D strlen(xmlname);
> +
> +    if (cc->gdb_get_dynamic_xml) {
> +        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
> +        if (xml) {
> +            return xml;
> +        }
> +    }
> +
> +    const char *name =3D NULL;
> +    int i;
> +    for (i =3D 0; ; i++) {
> +        name =3D xml_builtin[i][0];
> +        if (!name || (strncmp(name, xmlname, len) =3D=3D 0 && strlen(nam=
e) =3D=3D len))
> +            break;
> +    }
> +    return name ? xml_builtin[i][1] : NULL;
> +}
> +
>  static const char *get_feature_xml(const char *p, const char **newp,
>                                     GDBProcess *process)
>  {
>      size_t len;
> -    int i;
> -    const char *name;
>      CPUState *cpu =3D gdb_get_first_cpu_in_process(process);
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>=20=20
> @@ -365,7 +385,6 @@ static const char *get_feature_xml(const char *p, con=
st char **newp,
>          len++;
>      *newp =3D p + len;
>=20=20
> -    name =3D NULL;
>      if (strncmp(p, "target.xml", len) =3D=3D 0) {
>          char *buf =3D process->target_xml;
>          const size_t buf_sz =3D sizeof(process->target_xml);
> @@ -397,26 +416,257 @@ static const char *get_feature_xml(const char *p, =
const char **newp,
>          }
>          return buf;
>      }
> -    if (cc->gdb_get_dynamic_xml) {
> -        char *xmlname =3D g_strndup(p, len);
> -        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
>=20=20
> -        g_free(xmlname);
> -        if (xml) {
> -            return xml;
> +    char *xmlname =3D g_strndup(p, len);
> +    const char *xml =3D get_feature_xml_from_cpu(cpu, xmlname);
> +    g_free(xmlname);
> +    return xml;
> +}
> +
> +typedef struct reg_table_data {
> +    int bitsize;
> +    int regnum;
> +} reg_table_data;
> +
> +typedef struct xml_parser_data {
> +    CPUState *cpu;
> +    int next_regnum;
> +} xml_parser_data;
> +
> +#ifdef DEBUG
> +static void validate_regnums_in_reg_table(gpointer key,
> +                                          gpointer value,
> +                                          gpointer userdata)
> +{
> +    const int *regnum =3D userdata;
> +    const reg_table_data *reg_data =3D value;
> +    if (reg_data->regnum =3D=3D *regnum) {
> +        error_report("Error inserting register: \
> +                      table already contains register '%s' \
> +                      with the same register number %d", \
> +                      (const gchar *)key, reg_data->regnum);
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +#endif
> +
> +/*
> + * Handle the start of a <reg> element.
> + * Here we are parsing an XML file which is a Gdb Target description for=
mat
> +*/
> +static void xml_start_reg(GMarkupParseContext *context,
> +                          const gchar *elem_name,
> +                          const gchar **attr_names,
> +                          const gchar **attr_values,
> +                          gpointer user_data,
> +                          GError **error)
> +{
> +    if (strcmp(elem_name, "reg") !=3D 0)
> +        return;
> +
> +    const char *name;
> +    int regnum, bitsize =3D 0, i;
> +    int exist_regnum, exist_bitsize =3D 0;
> +
> +    xml_parser_data *parser_data =3D (xml_parser_data *)user_data;
> +    CPUClass *cc =3D parser_data->cpu->cc;
> +    regnum =3D parser_data->next_regnum;
> +
> +    i =3D 0;
> +    name =3D NULL;
> +    /* Each register has required attributes 'name' and 'bitsize',
> +       as well as an optional attribute 'regnum'.*/
> +    while (attr_names[i] !=3D NULL) {
> +        /* The register=E2=80=99s name; it must be unique within the tar=
get description */
> +        if (strcmp(attr_names[i], "name") =3D=3D 0) {
> +            name =3D attr_values[i];
>          }
> +        /* The register=E2=80=99s number. If omitted, a register=E2=80=
=99s number is one greater
> +        than that of the previous register (either in the current feature
> +        or in a preceding feature); the first register in the target des=
cription
> +        defaults to zero. This register number is used to read or write =
the register */
> +        else if (strcmp(attr_names[i], "regnum") =3D=3D 0) {
> +            // Should we set regnum as is or use base_regnum + regnum in=
stead?
> +            regnum =3D atoi(attr_values[i]);
> +        }
> +        else if (strcmp(attr_names[i], "bitsize") =3D=3D 0) {
> +            bitsize =3D atoi(attr_values[i]);
> +        }
> +        i++;
>      }
> -    for (i =3D 0; ; i++) {
> -        name =3D xml_builtin[i][0];
> -        if (!name || (strncmp(name, p, len) =3D=3D 0 && strlen(name) =3D=
=3D len))
> -            break;
> +
> +    if (name =3D=3D NULL || name[0] =3D=3D '\0') {
> +        error_report("Register in xml file does not contain a name");
> +        exit(EXIT_FAILURE);
>      }
> -    return name ? xml_builtin[i][1] : NULL;
> +
> +    if (regnum < parser_data->next_regnum) {
> +        error_report("Bad gdb register numbering for register '%s', "
> +                     "expected %d got %d", name, parser_data->next_regnu=
m, regnum);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (g_hash_table_contains(cc->gdb_reg_names, name)) {
> +        gdb_find_register_num_and_bitsize(parser_data->cpu, name, &exist=
_regnum, &exist_bitsize);
> +        error_report("Gdb register '%s' with num %d, already exists with=
 num %d", name, regnum, exist_regnum);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    parser_data->next_regnum =3D regnum + 1;
> +
> +#ifdef DEBUG
> +    /* Check that regnum is unique in table */
> +    g_hash_table_foreach(cc->gdb_reg_names, validate_regnums_in_reg_tabl=
e, &regnum);
> +#endif
> +
> +    /* memory will be freed automatically when table is destroyed */
> +    reg_table_data *reg_data =3D g_new0(reg_table_data, 1);
> +    reg_data->bitsize =3D bitsize;
> +    reg_data->regnum =3D regnum;
> +    g_hash_table_insert(cc->gdb_reg_names, g_strdup(name), reg_data);
> +}
> +
> +static void parse_target_xml(xml_parser_data *data, const char *xml)
> +{
> +    if (!xml)
> +        return;
> +
> +    GMarkupParser *parser;
> +    GMarkupParseContext *context;
> +    GError *error =3D NULL;
> +
> +    parser =3D g_new0(GMarkupParser, 1);
> +    parser->start_element =3D xml_start_reg;
> +
> +    context =3D g_markup_parse_context_new(parser, 0, data, 0);
> +    g_markup_parse_context_parse(context, xml, strlen(xml), &error);
> +    g_markup_parse_context_free(context);
> +    if (error !=3D NULL){
> +        error_report("Failed to parse xml file: %s", error->message);
> +        g_error_free(error);
> +    }
> +    g_free(parser);
> +}
> +
> +static const char *get_target_xml(CPUState *cpu)
> +{
> +    CPUClass *cc =3D cpu->cc;
> +    if (cc->gdb_core_xml_file =3D=3D NULL)
> +        return NULL;
> +    return get_feature_xml_from_cpu(cpu, cc->gdb_core_xml_file);
> +}
> +
> +/**
> + * Allocates the global @gdb_reg_names hash table only once
> + */
> +static void init_register_names_table(CPUState *cpu)
> +{
> +    CPUClass *cc =3D cpu->cc;
> +    if (cc->gdb_reg_names) {
> +        return;
> +    }
> +
> +    cc->gdb_reg_names =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                              g_free, g_free);
> +
> +    xml_parser_data *data =3D g_new0(xml_parser_data, 1);
> +    data->cpu =3D cpu;
> +    data->next_regnum =3D 0;
> +
> +    const char *xml =3D get_target_xml(cpu);
> +    if (xml) {
> +        parse_target_xml(data, xml);
> +    }
> +
> +    /* parse additional xml files */
> +    GDBRegisterState *r;
> +    for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> +        if (r && r->xml) {
> +            const char *xml =3D get_feature_xml_from_cpu(cpu, r->xml);
> +            if (xml) {
> +                parse_target_xml(data, xml);
> +            }
> +        }
> +    }
> +
> +    g_free(data);
>  }
>=20=20
> -static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
> +size_t gdb_get_available_reg_names(CPUState *cpu, char *buf, size_t buf_=
size)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    init_register_names_table(cpu);
> +
> +    size_t total_bytes =3D 0, table_size;
> +    guint keys_arr_len =3D 0, i;
> +    gpointer *keys_arr;
> +    const bool buf_exists =3D (buf && buf_size > 0);
> +
> +    table_size =3D g_hash_table_size(cc->gdb_reg_names);
> +    if (table_size =3D=3D 0)
> +        return total_bytes;
> +
> +    keys_arr =3D g_hash_table_get_keys_as_array(cc->gdb_reg_names, &keys=
_arr_len);
> +    for (i =3D 0; i < keys_arr_len; i++) {
> +        char *key;
> +        size_t key_len, bytes_needed;
> +
> +        key =3D keys_arr[i];
> +        key_len =3D strlen(key);
> +        if (key_len =3D=3D 0)
> +            continue;
> +
> +        bytes_needed =3D key_len + 1; // string + delimiter
> +
> +        if (!buf_exists) {
> +            total_bytes +=3D bytes_needed;
> +            continue; // just count how many bytes are needed
> +        }
> +
> +        if (total_bytes + bytes_needed > buf_size) {
> +            break; // not enough space for copying a new string + delimi=
ter
> +        }
> +
> +        memcpy(buf + total_bytes, key, key_len);
> +        buf[total_bytes + key_len] =3D ',';
> +        total_bytes +=3D bytes_needed;
> +    }
> +
> +    if (buf_exists) {
> +        buf[total_bytes - (total_bytes > 0)] =3D '\0';
> +    }
> +
> +    return total_bytes;
> +}
> +
> +bool gdb_find_register_num_and_bitsize(CPUState *cpu,
> +                                       const char *name,
> +                                       int *reg,
> +                                       int *bitsize)
> +{
> +    CPUClass *cc =3D cpu->cc;
> +    init_register_names_table(cpu);
> +
> +    if (!cc->gdb_reg_names)
> +        return false;
> +
> +    gpointer orig_key, val;
> +    bool res =3D g_hash_table_lookup_extended(cc->gdb_reg_names, name,
> +                                            &orig_key, &val);
> +    if (res =3D=3D false || val =3D=3D NULL) {
> +        return false;
> +    }
> +
> +    reg_table_data *data =3D (reg_table_data *)val;
> +    *reg =3D data->regnum;
> +    *bitsize =3D data->bitsize;
> +
> +    return true;
> +}
> +
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
> +{
> +    CPUClass *cc =3D cpu->cc;
>      CPUArchState *env =3D cpu->env_ptr;
>      GDBRegisterState *r;
>=20=20
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 7d743fe1e9..0b9a6168cc 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -41,4 +41,40 @@ extern bool gdb_has_xml;
>  /* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
>  extern const char *const xml_builtin[][2];
>=20=20
> +/**
> + * gdb_get_available_reg_names() - write the names of all
> + * available registers for the current CPU to destination buffer
> + * @cpu: CPU
> + * @buf: destination buffer to write data, can be NULL
> + * @buf_size: destination buffer size, can be 0
> + *
> + * The register names in the buffer are separated by commas
> + *=20
> + * Returns: the size of the data in bytes written to the buffer.
> + * Or if @buf is NULL, the size of the buffer needed to write data
> + */
> +size_t gdb_get_available_reg_names(CPUState *cpu, char *buf, size_t buf_=
size);
> +
> +/**
> + * gdb_find_register_num_and_bitsize: use to find CPU register by name
> + * @cpu: CPU
> + * @name: register name
> + * @reg: a pointer to store register number
> + * @bitsize: a pointer to store register bitsize
> + *
> + * Returns: true if found, false otherwise
> + */
> +bool gdb_find_register_num_and_bitsize(CPUState *cpu, const char *name,
> +                                       int *reg, int *bitsize);
> +
> +/**
> + * gdb_read_register: read register data
> + * @cpu: CPU
> + * @buf: a pointer to store register data
> + * @reg: register number according to the GDB Target Description Format
> + *
> + * Returns: register data size in bytes
> + */
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> +
>  #endif
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe87352..65fa6d54d7 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -164,6 +164,7 @@ struct CPUClass {
>      vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
>=20=20
>      const char *gdb_core_xml_file;
> +    GHashTable *gdb_reg_names;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
>      const char * (*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlna=
me);
>=20=20
> @@ -329,6 +330,8 @@ struct CPUState {
>      DeviceState parent_obj;
>      /* cache to avoid expensive CPU_GET_CLASS */
>      CPUClass *cc;
> +    /* cache to avoid expensive arch casts like X86_CPU */
> +    ArchCPU *arch;
>      /*< public >*/
>=20=20
>      int nr_cores;
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 50a9957279..fa3b1b6fb8 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -51,7 +51,7 @@ typedef uint64_t qemu_plugin_id_t;
>=20=20
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>=20=20
> -#define QEMU_PLUGIN_VERSION 1
> +#define QEMU_PLUGIN_VERSION 2
>=20=20
>  /**
>   * struct qemu_info_t - system information for plugins
> @@ -394,6 +394,109 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_p=
lugin_insn *insn);
>   */
>  void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
>=20=20
> +#define QEMU_PLUGIN_REGISTERS_ENABLED
> +
> +/**
> + * qemu_plugin_find_reg() - find register by name
> + * @name: register name
> + * @regnum: a pointer to store register number
> + *
> + * Returns: true if found, false otherwise
> + */
> +bool qemu_plugin_find_reg(const char *name, int *regnum);
> +
> +/**
> + * qemu_plugin_get_available_reg_names() - write the names of all
> + * available registers for the current CPU to destination buffer
> + * @buf: destination buffer to write data, can be NULL
> + * @buf_size: destination buffer size, can be 0
> + *
> + * The register names in the buffer are separated by commas
> + *=20
> + * Returns: the size of the data in bytes written to the buffer.
> + * Or if @buf is NULL, the size of the buffer needed to write data
> + */
> +size_t qemu_plugin_get_available_reg_names(char *buf, size_t buf_size);
> +
> +/**
> + * qemu_plugin_read_reg() - return register data
> + * @regnum: register number
> + * @size: a pointer to store allocated memory size
> + *
> + * Returns: allocated memory containing register data,
> + * memory must be freed manually using g_free()
> + */
> +const void *qemu_plugin_read_reg(int regnum, size_t *size);
> +
> +/** struct qemu_plugin_reg_ctx - Opaque handle for register context */
> +struct qemu_plugin_reg_ctx;
> +
> +/**
> + * qemu_plugin_n_regs() - query helper for number of registers in context
> + * @ctx: register context
> + *
> + * Returns: number of registers in context
> + */
> +size_t qemu_plugin_n_regs(const struct qemu_plugin_reg_ctx *ctx);
> +
> +/**
> + * qemu_plugin_reg_create_context() - create a context for working with =
registers
> + * @names: array with register names
> + * @len: array length
> + *
> + * Limitation: cannot be called from init_cpu callback
> + *=20
> + * Returns: opaque handle to register context
> + */
> +struct qemu_plugin_reg_ctx *
> +qemu_plugin_reg_create_context(const char *const *names,
> +                               size_t len);
> +
> +/**
> + * qemu_plugin_reg_free_context() - free the register context
> + * @ctx: register context
> + */
> +void qemu_plugin_reg_free_context(struct qemu_plugin_reg_ctx *ctx);
> +
> +/**
> + * qemu_plugin_reg_name() - query helper for register name in context
> + * @ctx: register context
> + * @idx: register index
> + *
> + * Returns: returns register name
> + */
> +const char *qemu_plugin_reg_name(const struct qemu_plugin_reg_ctx *ctx, =
size_t idx);
> +
> +/**
> + * qemu_plugin_reg_ptr() - query helper for a pointer to register data i=
n context
> + * @ctx: register context
> + * @idx: register index
> + *
> + * Returns: pointer to register data
> + */
> +const void *qemu_plugin_reg_ptr(const struct qemu_plugin_reg_ctx *ctx, s=
ize_t idx);
> +
> +/**
> + * qemu_plugin_reg_size() - query helper for register size in context
> + * @ctx: register context
> + * @idx: register index
> + *
> + * Returns: size of register data in bytes=20
> + */
> +size_t qemu_plugin_reg_size(const struct qemu_plugin_reg_ctx *ctx, size_=
t idx);
> +
> +/**
> + * qemu_plugin_regs_load() - load data from all registers
> + * and store them in context
> + * @ctx: register context
> + *
> + * This call does not require qemu_plugin_reg_ptr()
> + * or qemu_plugin_reg_size() to be called again,
> + * because the data will be overwritten in the context at the same posit=
ions.
> + * So it's just an update call
> + */
> +void qemu_plugin_regs_load(struct qemu_plugin_reg_ctx *ctx);
> +
>  /**
>   * typedef qemu_plugin_meminfo_t - opaque memory transaction handle
>   *
> diff --git a/plugins/api.c b/plugins/api.c
> index 2078b16edb..f758b491a6 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -39,9 +39,12 @@
>  #include "qemu/log.h"
>  #include "tcg/tcg.h"
>  #include "exec/exec-all.h"
> +#include "exec/gdbstub.h"
> +#include "exec/log.h"
>  #include "exec/ram_addr.h"
>  #include "disas/disas.h"
>  #include "plugin.h"
> +#include "sysemu/hw_accel.h"
>  #ifndef CONFIG_USER_ONLY
>  #include "qemu/plugin-memory.h"
>  #include "hw/boards.h"
> @@ -244,6 +247,226 @@ const char *qemu_plugin_insn_symbol(const struct qe=
mu_plugin_insn *insn)
>      return sym[0] !=3D 0 ? sym : NULL;
>  }
>=20=20
> +/*
> + * CPU registers
> + *
> + * These queries allow the plugin to retrieve information about current
> + * CPU registers
> + */
> +
> +static void check_reg_architecture_support(void) {
> +    if (strcmp(TARGET_NAME, "x86_64") !=3D 0 && strcmp(TARGET_NAME, "ris=
cv64") !=3D 0 &&
> +        strcmp(TARGET_NAME, "aarch64") !=3D 0) {
> +        error_report("Unsupported architecture: %s", TARGET_NAME);
> +        abort();
> +    }
> +}
> +
> +bool qemu_plugin_find_reg(const char *name, int *regnum)
> +{
> +    CPUState *cpu =3D current_cpu;
> +    if (name =3D=3D NULL || cpu =3D=3D NULL)
> +        return false;
> +
> +    check_reg_architecture_support();
> +
> +    int num =3D 0, bitsize =3D 0;
> +    bool found =3D gdb_find_register_num_and_bitsize(cpu, name,
> +                                                   &num, &bitsize);
> +    if (regnum)
> +        *regnum =3D num;
> +    return found;
> +}
> +
> +size_t qemu_plugin_get_available_reg_names(char *buf, size_t buf_size)
> +{
> +    check_reg_architecture_support();
> +    return gdb_get_available_reg_names(current_cpu, buf, buf_size);
> +}
> +
> +const void *qemu_plugin_read_reg(int regnum, size_t *size)
> +{
> +    CPUState *cpu =3D current_cpu;
> +    if (cpu =3D=3D NULL)
> +        return NULL;
> +
> +    check_reg_architecture_support();
> +
> +    cpu_synchronize_state(cpu);
> +    GByteArray *arr =3D g_byte_array_new();
> +    gdb_read_register(cpu, arr, regnum);
> +    if (size)
> +        *size =3D arr->len;
> +    return g_byte_array_free(arr, false);
> +}
> +
> +struct qemu_plugin_reg_ctx {
> +    CPUState *cpu;
> +
> +    size_t *regnums;
> +    size_t *bitsizes;
> +    gchar **names;
> +
> +    /* cache the initial position of the register data
> +    in the general data array */
> +    size_t *offsets;
> +
> +    /* the actual number of registers in the context.
> +       This number may be less than requested if any of the registers
> +       was not found */
> +    size_t n_regs;
> +
> +    /* contains registers one by one */
> +    GByteArray *data;
> +
> +    /* remember how much memory was actually allocated for the data.
> +       This value is used to check that the length of the array has not =
changed
> +       after reading the registers. it mustn't happen */
> +    size_t alloc_data_len;
> +};
> +
> +size_t qemu_plugin_n_regs(const struct qemu_plugin_reg_ctx *ctx)
> +{
> +    return (ctx) ? ctx->n_regs : 0;
> +}
> +
> +struct qemu_plugin_reg_ctx *
> +qemu_plugin_reg_create_context(const char *const *names, size_t len)
> +{
> +    size_t reqested_len, actual_len, total_bitsize, i;
> +    struct qemu_plugin_reg_ctx *ctx;
> +    CPUState *cpu =3D current_cpu;
> +    if (cpu =3D=3D NULL)
> +        return NULL;
> +
> +    check_reg_architecture_support();
> +
> +    reqested_len =3D len;
> +    ctx =3D g_new0(struct qemu_plugin_reg_ctx, 1);
> +    ctx->cpu =3D cpu;
> +    ctx->regnums =3D g_new0(size_t, reqested_len);
> +    ctx->bitsizes =3D g_new0(size_t, reqested_len);
> +    ctx->names =3D g_new0(gchar*, reqested_len);
> +    ctx->offsets =3D g_new0(size_t, reqested_len);
> +
> +    actual_len =3D 0;
> +    total_bitsize =3D 0;
> +    for (i =3D 0; i < reqested_len; i++) {
> +        int reg =3D 0, bitsize =3D 0;
> +        bool found =3D gdb_find_register_num_and_bitsize(ctx->cpu, names=
[i],
> +                                                       &reg, &bitsize);
> +        if (!found)
> +            continue;
> +
> +        ctx->regnums[actual_len] =3D reg;
> +        ctx->bitsizes[actual_len] =3D bitsize;
> +        ctx->names[actual_len] =3D g_strdup(names[i]);
> +        ctx->offsets[actual_len] =3D total_bitsize;
> +        actual_len++;
> +        total_bitsize +=3D bitsize;
> +    }
> +    ctx->n_regs =3D actual_len;
> +
> +    if (actual_len =3D=3D 0) {
> +        qemu_plugin_reg_free_context(ctx);
> +        return NULL;
> +    }
> +
> +    if ((total_bitsize % CHAR_BIT) !=3D 0) {
> +        error_report("Unexpected register bitsize: %ld", total_bitsize);
> +        abort();
> +    }
> +    ctx->alloc_data_len =3D total_bitsize / 8;
> +    ctx->data =3D g_byte_array_sized_new(ctx->alloc_data_len);
> +
> +    return ctx;
> +}
> +
> +void qemu_plugin_reg_free_context(struct qemu_plugin_reg_ctx *ctx)
> +{
> +    int i;
> +    if (ctx =3D=3D NULL)
> +        return;
> +
> +    if (ctx->data)
> +        g_byte_array_free(ctx->data, true);
> +
> +    g_free(ctx->offsets);
> +    for (i =3D 0; i < ctx->n_regs; i++) {
> +        g_free(ctx->names[i]);
> +    }
> +    g_free(ctx->names);
> +    g_free(ctx->bitsizes);
> +    g_free(ctx->regnums);
> +    g_free(ctx);
> +    ctx =3D NULL;
> +}
> +
> +static inline bool reg_context_is_valid(const struct qemu_plugin_reg_ctx=
 *ctx)
> +{
> +    return ctx && ctx->data;
> +}
> +
> +static inline bool reg_index_is_valid(const struct qemu_plugin_reg_ctx *=
ctx,
> +                                      size_t idx)
> +{
> +    return idx < ctx->n_regs && idx <=3D INT_MAX;
> +}
> +
> +const char *qemu_plugin_reg_name(const struct qemu_plugin_reg_ctx *ctx,
> +                                 size_t idx)
> +{
> +    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
> +        return NULL;
> +
> +    return ctx->names[idx];
> +}
> +
> +const void *qemu_plugin_reg_ptr(const struct qemu_plugin_reg_ctx *ctx,
> +                                size_t idx)
> +{
> +    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
> +        return NULL;
> +
> +    size_t offset =3D ctx->offsets[idx] / CHAR_BIT;
> +    return (uint8_t *)ctx->data->data + offset;
> +}
> +
> +size_t qemu_plugin_reg_size(const struct qemu_plugin_reg_ctx *ctx,
> +                            size_t idx)
> +{
> +    if (!reg_context_is_valid(ctx) || !reg_index_is_valid(ctx, idx))
> +        return 0;
> +
> +    if ((ctx->bitsizes[idx] % CHAR_BIT) !=3D 0) {
> +        error_report("Unexpected register bitsize: %ld", ctx->bitsizes[i=
dx]);
> +        abort();
> +    }
> +
> +    return ctx->bitsizes[idx] / CHAR_BIT;
> +}
> +
> +void qemu_plugin_regs_load(struct qemu_plugin_reg_ctx *ctx)
> +{
> +    g_byte_array_set_size(ctx->data, 0);
> +    cpu_synchronize_state(ctx->cpu);
> +    size_t i;
> +    for (i =3D 0; i < ctx->n_regs; i++) {
> +        int size =3D gdb_read_register(ctx->cpu, ctx->data, ctx->regnums=
[i]);
> +        int bitsize =3D size * 8;
> +        if (bitsize !=3D ctx->bitsizes[i]) {
> +            error_report("Expected data size after reading register %s: =
%ld, got %u",
> +                     ctx->names[i], ctx->bitsizes[i], bitsize);
> +            abort();
> +        }
> +    }
> +    if (ctx->data->len !=3D ctx->alloc_data_len) {
> +        error_report("Expected data size after reading registers: %ld, g=
ot %u",
> +                     ctx->alloc_data_len, ctx->data->len);
> +        abort();
> +    }
> +}
> +
>  /*
>   * The memory queries allow the plugin to query information about a
>   * memory access.
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index 71f6c90549..c6539888ac 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -20,6 +20,16 @@
>    qemu_plugin_n_vcpus;
>    qemu_plugin_outs;
>    qemu_plugin_path_to_binary;
> +  qemu_plugin_find_reg;
> +  qemu_plugin_get_available_reg_names;
> +  qemu_plugin_read_reg;
> +  qemu_plugin_n_regs;
> +  qemu_plugin_reg_create_context;
> +  qemu_plugin_reg_free_context;
> +  qemu_plugin_reg_name;
> +  qemu_plugin_reg_ptr;
> +  qemu_plugin_reg_size;
> +  qemu_plugin_regs_load;
>    qemu_plugin_register_atexit_cb;
>    qemu_plugin_register_flush_cb;
>    qemu_plugin_register_vcpu_exit_cb;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 93c28d50e5..b04c8b155f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1584,6 +1584,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>  {
>      CPUState *cs =3D CPU(dev);
>      ARMCPU *cpu =3D ARM_CPU(dev);
> +    /* cache the arch class for the hotpath */
> +    cs->arch =3D (struct ArchCPU *)cpu;
>      ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(dev);
>      CPUARMState *env =3D &cpu->env;
>      int pagebits;
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index f421c5d041..7f561655cf 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -39,7 +39,7 @@ typedef struct RegisterSysregXmlParam {
>=20=20
>  int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>  {
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> +    ARMCPU *cpu =3D (ARMCPU *)cs->arch;
>      CPUARMState *env =3D &cpu->env;
>=20=20
>      if (n < 16) {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..19e4c7722e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7210,6 +7210,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>  {
>      CPUState *cs =3D CPU(dev);
>      X86CPU *cpu =3D X86_CPU(dev);
> +    /* cache the arch class for the hotpath */
> +    cs->arch =3D (struct ArchCPU *)cpu;
>      X86CPUClass *xcc =3D X86_CPU_GET_CLASS(dev);
>      CPUX86State *env =3D &cpu->env;
>      Error *local_err =3D NULL;
> @@ -7964,10 +7966,10 @@ static void x86_cpu_common_class_init(ObjectClass=
 *oc, void *data)
>      cc->gdb_arch_name =3D x86_gdb_arch_name;
>  #ifdef TARGET_X86_64
>      cc->gdb_core_xml_file =3D "i386-64bit.xml";
> -    cc->gdb_num_core_regs =3D 66;
> +    cc->gdb_num_core_regs =3D 82;
>  #else
>      cc->gdb_core_xml_file =3D "i386-32bit.xml";
> -    cc->gdb_num_core_regs =3D 50;
> +    cc->gdb_num_core_regs =3D 58;
>  #endif
>      cc->disas_set_info =3D x86_disas_set_info;
>=20=20
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index ebb000df6a..47b96afa94 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -49,12 +49,13 @@ static const int gpr_map32[8] =3D { 0, 1, 2, 3, 4, 5,=
 6, 7 };
>  #define IDX_NB_SEG      (6 + 3)
>  #define IDX_NB_CTL      6
>  #define IDX_NB_FP       16
> +#define IDX_NB_YMM      16
>  /*
>   * fpu regs ----------> 8 or 16
>   */
>  #define IDX_NB_MXCSR    1
>  /*
> - *          total ----> 8+1+1+9+6+16+8+1=3D50 or 16+1+1+9+6+16+16+1=3D66
> + *          total ----> 8+1+1+9+6+16+8+1+8=3D58 or 16+1+1+9+6+16+16+1+16=
=3D82
>   */
>=20=20
>  #define IDX_IP_REG      CPU_NB_REGS
> @@ -64,6 +65,7 @@ static const int gpr_map32[8] =3D { 0, 1, 2, 3, 4, 5, 6=
, 7 };
>  #define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
>  #define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
>  #define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
> +#define IDX_YMM_REGS    (IDX_MXCSR_REG + IDX_NB_MXCSR)
>=20=20
>  #define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
>  #define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
> @@ -98,9 +100,10 @@ static int gdb_write_reg_cs64(uint32_t hflags, uint8_=
t *buf, target_ulong *val)
>=20=20
>  int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>  {
> -    X86CPU *cpu =3D X86_CPU(cs);
> +    X86CPU *cpu =3D (X86CPU *)cs->arch;
>      CPUX86State *env =3D &cpu->env;
>=20=20
> +    uint32_t eflags;
>      uint64_t tpr;
>=20=20
>      /* N.B. GDB can't deal with changes in registers or sizes in the mid=
dle
> @@ -134,6 +137,14 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>                                    env->xmm_regs[n].ZMM_Q(1),
>                                    env->xmm_regs[n].ZMM_Q(0));
>          }
> +    }
> +    else if (n >=3D IDX_YMM_REGS && n < IDX_YMM_REGS + IDX_NB_YMM) {
> +        n -=3D IDX_YMM_REGS;
> +        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS =3D=3D 64) {
> +            return gdb_get_reg128(mem_buf,
> +                                  env->xmm_regs[n].ZMM_Q(3),
> +                                  env->xmm_regs[n].ZMM_Q(2));
> +        }
>      } else {
>          switch (n) {
>          case IDX_IP_REG:
> @@ -147,7 +158,8 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>                  return gdb_get_reg32(mem_buf, env->eip);
>              }
>          case IDX_FLAGS_REG:
> -            return gdb_get_reg32(mem_buf, env->eflags);
> +            eflags =3D cpu_compute_eflags(env);
> +            return gdb_get_reg32(mem_buf, eflags);
>=20=20
>          case IDX_SEG_REGS:
>              return gdb_get_reg32(mem_buf, env->segs[R_CS].selector);
> @@ -285,6 +297,13 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t=
 *mem_buf, int n)
>              env->xmm_regs[n].ZMM_Q(1) =3D ldq_p(mem_buf + 8);
>              return 16;
>          }
> +    } else if (n >=3D IDX_YMM_REGS && n < IDX_YMM_REGS + IDX_NB_YMM) {
> +        n -=3D IDX_YMM_REGS;
> +        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS =3D=3D 64) {
> +            env->xmm_regs[n].ZMM_Q(2) =3D ldq_p(mem_buf);
> +            env->xmm_regs[n].ZMM_Q(3) =3D ldq_p(mem_buf + 8);
> +            return 32;
> +        }
>      } else {
>          switch (n) {
>          case IDX_IP_REG:
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b93b04453..4a549c9986 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1391,7 +1391,10 @@ static void riscv_cpu_validate_misa_priv(CPURISCVS=
tate *env, Error **errp)
>=20=20
>  static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
>  {
> +    CPUState *cs =3D CPU(dev);
>      RISCVCPU *cpu =3D RISCV_CPU(dev);
> +    /* cache the arch class for the hotpath */
> +    cs->arch =3D (struct ArchCPU *)cpu;
>      CPURISCVState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
>=20=20
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 524bede865..596df1931c 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -49,7 +49,7 @@ static const struct TypeSize vec_lanes[] =3D {
>=20=20
>  int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>  {
> -    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    RISCVCPU *cpu =3D (RISCVCPU *)cs->arch;
>      CPURISCVState *env =3D &cpu->env;
>      target_ulong tmp;
>=20=20
> @@ -169,6 +169,7 @@ static int riscv_gdb_get_csr(CPURISCVState *env, GByt=
eArray *buf, int n)
>              return gdb_get_regl(buf, val);
>          }
>      }
> +    g_assert_not_reached();
>      return 0;
>  }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

