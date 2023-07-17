Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025975636C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNi0-0003pj-KC; Mon, 17 Jul 2023 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLNhh-00033G-Ry
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:51:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLNhe-0000zT-9l
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:51:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so39735065e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598308; x=1692190308;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXkAaa+OPYwbDfKBazm5CN4sZ1VNfj1rMM5SFrk0MrU=;
 b=ndCGlKDKw/pYhosfAnvIKl+4scsc0QY3ssmn6p1NJMzSIH0Y9z8MLayguWVlz/t2Ua
 OlnhcLVtHovz3yuYLokOucwFPhYdgxU4PHpLDUCnQ1mo0jS7Fzhh97nbiFEfki5i8pfr
 Xp3CCGoCD2ocYOG5xy2EeloV5ATc7uJQY8JaN4+mByNFzlw9yYI7q7gsFGq5dxMrQTZR
 yAVTosDNvSZ32tk0Oe45pe0or+Hs0RUINcYhtu2mm8vG6HPlMYmb6q9Dfx2/4P9wditP
 pMy2SZ1AbdG0nvugopgqLeQkFmW9LzYKSdhR9wY8Sc96aP9Sz11l3tBW3deHNggIzLUx
 hG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598308; x=1692190308;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DXkAaa+OPYwbDfKBazm5CN4sZ1VNfj1rMM5SFrk0MrU=;
 b=J7veJIxADmBlFm8p4r75xFSOcdklwmohU1H5k7FpFz6MwzTuLaepsdfuE/aP9/Xwzv
 Ctb+qhoDv/tHENPOVEvTeNG+/fbKhsAGo1nV7d95Yiw2u/xsQSxPBiImFwvT8Bf8tRva
 hDBWbBuqlbneVIaIhobztq8ZsOUayY8eI2AjTIUhJOPZDPbnxSHULt4WXHVxt9543VXz
 ZOo4qrinFBK+31rAWvTFAEwIZH5jAF8k4ci+swGOUgHdVmVa/MS9jjNTlOxCw4YhbW8d
 DCiqlQLbyDUVC5ZEAIaFwFecv4dLSd5FWF+fIJHwJDcQVo0w45b1XlNvev/TWznO6YUp
 m/oA==
X-Gm-Message-State: ABy/qLbr4bCttgmt7Yi10PyiTj/dSVwz6JiuX9bqWsXG95OqUm0p/jEB
 k2ci1O127RKGQD4y8KJYNYtI8w==
X-Google-Smtp-Source: APBJJlFN2QIkZ+eUThDIYVGzjR2qxaooQ0NdBXSA/eMuWQQAhxITLMG969CUamrbi0NoWfvcaDbVLg==
X-Received: by 2002:a1c:7414:0:b0:3fb:ba04:6d5d with SMTP id
 p20-20020a1c7414000000b003fbba046d5dmr9636267wmc.12.1689598308670; 
 Mon, 17 Jul 2023 05:51:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c294800b003fbcdba1a63sm8033558wmd.12.2023.07.17.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:51:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D44721FFBB;
 Mon, 17 Jul 2023 13:51:47 +0100 (BST)
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Borgerson <contact@mborgerson.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
Date: Mon, 17 Jul 2023 13:49:50 +0100
In-reply-to: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
Message-ID: <874jm2ya3g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Matt Borgerson <contact@mborgerson.com> writes:

> Translation logic may partially decode an instruction, then abort and
> remove the instruction from the TB. This can happen for example when an
> instruction spans two pages. In this case, plugins may get an incorrect
> result when calling qemu_plugin_tb_n_insns to query for the number of
> instructions in the TB. This patch updates plugin_gen_tb_end to set the
> final instruction count.

For some reason this fails to apply cleanly:

  git am ./v2_20230714_contact_plugins_set_final_instruction_count_in_plugi=
n_gen_tb_end.mbx
  Applying: plugins: Set final instruction count in plugin_gen_tb_end
  error: corrupt patch at line 31=20=20=20=20=20=20=20=20=20=20=20
  Patch failed at 0001 plugins: Set final instruction count in plugin_gen_t=
b_end

>
> Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> ---
>  accel/tcg/plugin-gen.c    | 5 ++++-
>  accel/tcg/translator.c    | 2 +-
>  include/exec/plugin-gen.h | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 5c13615112..f18ecd6902 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -866,10 +866,13 @@ void plugin_gen_insn_end(void)
>   * do any clean-up here and make sure things are reset in
>   * plugin_gen_tb_start.
>   */
> -void plugin_gen_tb_end(CPUState *cpu)
> +void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
>  {
>      struct qemu_plugin_tb *ptb =3D tcg_ctx->plugin_tb;
>

I think it might be worth a:

  g_assert(num_insns <=3D ptb->n);

here to prevent misuse of the API.


> +    /* translator may have removed instructions, update final count */
> +    ptb->n =3D num_insns;
> +
>      /* collect instrumentation requests */
>      qemu_plugin_tb_trans_cb(cpu, ptb);
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 0fd9efceba..141f514886 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -215,7 +215,7 @@ void translator_loop(CPUState *cpu,
> TranslationBlock *tb, int *max_insns,
>      gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
>
>      if (plugin_enabled) {
> -        plugin_gen_tb_end(cpu);
> +        plugin_gen_tb_end(cpu, db->num_insns);
>      }
>
>      /* The disas_log hook may use these values rather than recompute.  */
> diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> index 52828781bc..c4552b5061 100644
> --- a/include/exec/plugin-gen.h
> +++ b/include/exec/plugin-gen.h
> @@ -20,7 +20,7 @@ struct DisasContextBase;
>
>  bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *d=
b,
>                           bool supress);
> -void plugin_gen_tb_end(CPUState *cpu);
> +void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
>  void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase =
*db);
>  void plugin_gen_insn_end(void);
>
> @@ -42,7 +42,7 @@ void plugin_gen_insn_start(CPUState *cpu, const
> struct DisasContextBase *db)
>  static inline void plugin_gen_insn_end(void)
>  { }
>
> -static inline void plugin_gen_tb_end(CPUState *cpu)
> +static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
>  { }
>
>  static inline void plugin_gen_disable_mem_helpers(void)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

