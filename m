Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C264F73FC7F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Q0-0002bR-3Y; Tue, 27 Jun 2023 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8Pn-0002UH-4F
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:07:27 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8Pl-0008E3-6h
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:07:26 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fa16c6a85cso4445351e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687871241; x=1690463241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99AGN/nDDAi9/TDws1Ylgg7Lo32U3DDT0cXDr+AKKZs=;
 b=tqPfCdNpmDk5nj8+w/lb6xeJ4FxLC4HC5demRpKsrYo/BpoCha63yCiCAZ1Nu+cscm
 4TQ9z/wKQyTpq9YrRHPMeeFgsUl2nBILmCaQ6Pz2pH6LxGTPKOXSQNa60OFmJt5z/yl/
 yqLh396jSzEJOa6Ql6G7qeQX7XBAP7tD3ruHSkADc7JuKkfdnSQB7Ujv59c0bppMItZd
 8AvMWjFVoX4p/lMn2fyQZ0Bg3Po5Qpfx0FNNSrLUDSoBV5vbLt5gvVizekDHqsotEZEp
 GLkq+GrIWZF0byNlAymPu1vDwmrUTVtZNwh51CNT/VjGArmGlxbPG4AcKfJjapOwebzx
 rI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687871241; x=1690463241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99AGN/nDDAi9/TDws1Ylgg7Lo32U3DDT0cXDr+AKKZs=;
 b=PAEb1XoRJXD2/QW37LUJ500z6+HTyrZpet3p/5F1IDmwc2ATkN+086Y6ceJCWFk44d
 E/+SQTX0ql8iS4pJ5efyXmNUqnwfeRRHCc1KsPxK46q2ShSR0ZXl93E/t89UQWGDLHO9
 1ILGGmvhqHHLqhL/mZ7et19cDDWr3R6tkPgyL6MgOAkKUeELSJBcisQ3K6IqBafPNQSB
 vP9MeaWOEQb6+2Uj9+uEvnDH55yiIkfU2QQcgHXQLJXXmne5JOjlcGe6SYXI3zTBXV5A
 VzJgAjrRozmTkf4wrOLr5lXzxDmmUWMk3vozu85dqJltRfJ6K1K9AAgYYLcThDwnRS+r
 HtiQ==
X-Gm-Message-State: AC+VfDzipT8wBQrgNKOg5gbEhylccgTrzizYv0lH6l2x97bLXjZjtCSy
 uVFrOPJNnlXHHh5KF3QQZt/SIJ509+rwtq9kKp0gGA==
X-Google-Smtp-Source: ACHHUZ5XVYvQgHjTUWJvjCOjEgktKCy0i9mkdpKBulBB0av125OkYz7F4mmsBeVmgUy6tg3zrJ2QOp2FAKgl/HAYtpg=
X-Received: by 2002:a05:6512:23a5:b0:4fb:780c:fce9 with SMTP id
 c37-20020a05651223a500b004fb780cfce9mr4266562lfv.58.1687871241324; Tue, 27
 Jun 2023 06:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <20230622151201.1578522-4-richard.henderson@linaro.org>
In-Reply-To: <20230622151201.1578522-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 14:07:10 +0100
Message-ID: <CAFEAcA973XpMRtbEQiz_jx9V6AEwmpZZi3jjEe9oRW5HR34tAw@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/arm: Support reading ZA[] from gdbstub
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Luis Machado <luis.machado@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Thu, 22 Jun 2023 at 16:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Mirror the existing support for SVE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -247,6 +247,61 @@ int aarch64_gdb_set_pauth_reg(CPUARMState *env, uint8_t *buf, int reg)
>      return 0;
>  }
>
> +static int max_svq(ARMCPU *cpu)
> +{
> +    return 32 - clz32(cpu->sme_vq.map);
> +}
> +
> +int aarch64_gdb_get_za_reg(CPUARMState *env, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    int max_vq = max_svq(cpu);
> +    int cur_vq = EX_TBFLAG_A64(env->hflags, SVL) + 1;
> +    int i;
> +
> +    if (reg >= max_vq * 16) {
> +        return 0;
> +    }
> +
> +    /* If ZA is unset, or reg out of range, the contents are zero. */
> +    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
> +        for (i = 0; i < cur_vq; i++) {
> +            gdb_get_reg128(buf, env->zarray[reg].d[i * 2 + 1],
> +                           env->zarray[reg].d[i * 2]);
> +        }
> +    } else {
> +        cur_vq = 0;
> +    }
> +
> +    for (i = cur_vq; i < max_vq; i++) {
> +        gdb_get_reg128(buf, 0, 0);
> +    }
> +
> +    return max_vq * 16;
> +}
> +
> +int aarch64_gdb_set_za_reg(CPUARMState *env, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    uint64_t *p = (uint64_t *) buf;
> +    int max_vq = max_svq(cpu);
> +    int cur_vq = EX_TBFLAG_A64(env->hflags, SVL) + 1;
> +    int i;
> +
> +    if (reg >= max_vq * 16) {
> +        return 0;
> +    }
> +
> +    /* If ZA is unset, or reg out of range, the contents are zero. */
> +    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
> +        for (i = 0; i < cur_vq; i++) {
> +            env->zarray[reg].d[i * 2 + 1] = *p++;
> +            env->zarray[reg].d[i * 2 + 0] = *p++;

This looks like it won't do the right thing on a big-endian
system. (And the existing SVE code also looks wrong.)
The gdb_get_reg*() functions handle endianness conversion
from the gdb data buffer; there are no equivalent gdb_set_reg*()
functions so you have to do the byte-swapping yourself.
(This is pretty bug-prone so maybe we should design a better
API here :-))

Compare aarch64_gdb_get/set_fpu_reg() where a gdb_get_reg128()
is matched with a pair of ldq_le_p() and so on.

> +        }
> +    }
> +    return max_vq * 16;
> +}
> +
>  static void output_vector_union_type(GString *s, int reg_width,
>                                       const char *name)
>  {
> @@ -379,3 +434,36 @@ int arm_gen_dynamic_svereg_xml(CPUState *cs, int orig_base_reg)
>      info->num = base_reg - orig_base_reg;
>      return info->num;
>  }
> +
> +/*
> + * Generate the xml for SME, with matrix size set to the maximum
> + * for the cpu.  Returns the number of registers generated.
> + */
> +int arm_gen_dynamic_zareg_xml(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    GString *s = g_string_new(NULL);
> +    int vq = max_svq(cpu);
> +    int row_count = vq * 16;
> +    int row_width = vq * 128;
> +    int i;
> +
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.za\">");

The patches on the GDB end are still under review, but they
use the feature name org.gnu.gdb.aarch64.sme:

https://inbox.sourceware.org/gdb-patches/20230519102508.14020-18-luis.machado@arm.com/
We should follow that (and only commit our end when the GDB
spec for the XML layout is finalized.

Luis kindly gave me a dump of some example XML to save us
from trying to parse it out of the patch:

  <feature name="org.gnu.gdb.aarch64.sme">
    <flags id="svcr_flags" size="8">
      <field name="SM" start="0" end="0" type="bool"/>
      <field name="ZA" start="1" end="1" type="bool"/>
    </flags>
    <vector id="sme_bv" type="uint8" count="32"/>
    <vector id="sme_bvv" type="sme_bv" count="32"/>
    <reg name="svg" bitsize="64" type="int" regnum="91"/>
    <reg name="svcr" bitsize="64" type="svcr_flags" regnum="92"/>
    <reg name="za" bitsize="8192" type="sme_bvv" regnum="93"/>
  </feature>

> +
> +    output_vector_union_type(s, row_width, "zav");
> +
> +    for (i = 0; i < row_count; i++) {
> +        g_string_append_printf(s,
> +                               "<reg name=\"za%d\" bitsize=\"%d\""
> +                               " regnum=\"%d\" type=\"zav\"/>",
> +                               i, row_width, base_reg + i);
> +    }
> +
> +    g_string_append_printf(s, "</feature>");
> +
> +    cpu->dyn_zareg_xml.num = row_count;
> +    cpu->dyn_zareg_xml.desc = g_string_free(s, false);
> +    return row_count;
> +}

thanks
-- PMM

