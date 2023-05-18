Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4D70832B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdaG-00086P-Dn; Thu, 18 May 2023 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzdaF-00085U-6V
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:22:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzdaD-0004f6-9z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:22:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-510d8d7f8eeso3008756a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684416135; x=1687008135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gzReDFAI8U0OgYjrEA/xMrw7X46h9aabT5CAO2Gr0o=;
 b=vP9tqT0JOyf37grVJJOJy/IIs3Vsn6UfhrvSZOGdxQJ9t+tQJeF+kfXi3YrmzRXvLB
 /wAHBi2VDR+sic74ULuRw0MGncGkubHxbhuHfcbqAyGGm5VH7aljKvEDdJd5ob6Ijw4n
 lXLuh4jVcfWxiBLp2alV6TZMtiKRcIBJKvrUn8j4NhZVvFYe88ftklVQ1vFnjtbDALXP
 4ieIXfAKjt/Y2VnCBhAE1BQ31Dt2UqIJKg5fUiefnwiAno956/DUacvmYl0c7y9Z6nyY
 20XeNzinjOYy5uy2BphQTqOV4nMtml280Wi5vjcXforq4xhVMbWV80pwTOHhtjgqXEOK
 7vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684416135; x=1687008135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gzReDFAI8U0OgYjrEA/xMrw7X46h9aabT5CAO2Gr0o=;
 b=D3Z88i/i9T/wZ2+Y1Wx/tl/RbN0t7cvtbjd51O/F/8qX3QiIzhYqP2VJwSH9WOnWG+
 5ec+YyKuei9MRr5nA0mfql5g9/7XlXXEal8zq8dVDI37FFmDhhcolngvJl44rLSNAKlz
 rtShaxuwBq658fOgI3eDqNO5AXmXnAvxphr7mboohEtl4LB6qUjiCKCgAWsdXJ/9+VEn
 w/56aD2ilm9B7Ibr3HKpDnNawR1d4ZLupcznqfA2wc53SZsfbEj75SAByWWBC/KzlSn0
 9O357g8WWdhTZ/gP9cDdoiSu8pRhfULZAWW+lfC5LOU4e0hSWH+13kYNkaNeEXOXktdO
 dgYQ==
X-Gm-Message-State: AC+VfDzBG3zb/LtXttk7tLuskFEdSe7Pv2pn+eAcoPWxuMEOaH2YnVnQ
 LK2GOYjErpy+TFDka7PgpiRbc+i5vhlAxk/qa6p7Vg==
X-Google-Smtp-Source: ACHHUZ65faitgT59th5Ravrlm4iTKYjZnfbfDPs27wd6DnyR5deYskM95OSdKDJK2YhxpTVc/RnK5W/ig/SlLg7Fv6k=
X-Received: by 2002:aa7:d849:0:b0:506:7304:15d3 with SMTP id
 f9-20020aa7d849000000b00506730415d3mr5780069eds.14.1684416135265; Thu, 18 May
 2023 06:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
 <20230516194145.1749305-63-richard.henderson@linaro.org>
In-Reply-To: <20230516194145.1749305-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 14:22:04 +0100
Message-ID: <CAFEAcA-ybW7T0O7PV56paGjO7DB-e7_L66R9DjVQ3ThngkqOsw@mail.gmail.com>
Subject: Re: [PULL 62/80] accel/tcg: Widen plugin_gen_empty_mem_callback to i64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 16 May 2023 at 20:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since we do this inside gen_empty_mem_cb anyway, let's
> do this earlier inside tcg expansion.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

The Avocado test tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_ic=
ount
has stopped working on my machine (it either times out or
errors). Bisection fingered this patch as the culprit, though
I can't see anything obviously wrong with it...

> ---
>  include/exec/plugin-gen.h |  4 ++--
>  accel/tcg/plugin-gen.c    |  9 +++------
>  tcg/tcg-op-ldst.c         | 28 ++++++++++++++++++++--------
>  3 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> index 5f5506f1cc..3af0168e65 100644
> --- a/include/exec/plugin-gen.h
> +++ b/include/exec/plugin-gen.h
> @@ -27,7 +27,7 @@ void plugin_gen_insn_start(CPUState *cpu, const struct =
DisasContextBase *db);
>  void plugin_gen_insn_end(void);
>
>  void plugin_gen_disable_mem_helpers(void);
> -void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info);
> +void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info);
>
>  static inline void plugin_insn_append(abi_ptr pc, const void *from, size=
_t size)
>  {
> @@ -69,7 +69,7 @@ static inline void plugin_gen_tb_end(CPUState *cpu)
>  static inline void plugin_gen_disable_mem_helpers(void)
>  { }
>
> -static inline void plugin_gen_empty_mem_callback(TCGv addr, uint32_t inf=
o)
> +static inline void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t=
 info)
>  { }
>
>  static inline void plugin_insn_append(abi_ptr pc, const void *from, size=
_t size)
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 907c5004a4..34be1b940c 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -124,23 +124,20 @@ static void gen_empty_inline_cb(void)
>      tcg_temp_free_i64(val);
>  }
>
> -static void gen_empty_mem_cb(TCGv addr, uint32_t info)
> +static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
>  {
>      TCGv_i32 cpu_index =3D tcg_temp_ebb_new_i32();
>      TCGv_i32 meminfo =3D tcg_temp_ebb_new_i32();
> -    TCGv_i64 addr64 =3D tcg_temp_ebb_new_i64();
>      TCGv_ptr udata =3D tcg_temp_ebb_new_ptr();
>
>      tcg_gen_movi_i32(meminfo, info);
>      tcg_gen_movi_ptr(udata, 0);
>      tcg_gen_ld_i32(cpu_index, cpu_env,
>                     -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_inde=
x));
> -    tcg_gen_extu_tl_i64(addr64, addr);
>
> -    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr64, udata);
> +    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr, udata);
>
>      tcg_temp_free_ptr(udata);
> -    tcg_temp_free_i64(addr64);
>      tcg_temp_free_i32(meminfo);
>      tcg_temp_free_i32(cpu_index);
>  }
> @@ -197,7 +194,7 @@ static void plugin_gen_empty_callback(enum plugin_gen=
_from from)
>      }
>  }
>
> -void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
> +void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
>  {
>      enum qemu_plugin_mem_rw rw =3D get_plugin_meminfo_rw(info);
>
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index b695d2954e..2d5e98971d 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -115,13 +115,13 @@ static void tcg_gen_req_mo(TCGBar type)
>  }
>
>  /* Only required for loads, where value might overlap addr. */
> -static TCGv plugin_maybe_preserve_addr(TCGv vaddr)
> +static TCGv_i64 plugin_maybe_preserve_addr(TCGv vaddr)
>  {
>  #ifdef CONFIG_PLUGIN
>      if (tcg_ctx->plugin_insn !=3D NULL) {
>          /* Save a copy of the vaddr for use after a load.  */
> -        TCGv temp =3D tcg_temp_new();
> -        tcg_gen_mov_tl(temp, vaddr);
> +        TCGv_i64 temp =3D tcg_temp_ebb_new_i64();
> +        tcg_gen_extu_tl_i64(temp, vaddr);
>          return temp;
>      }
>  #endif
> @@ -129,16 +129,28 @@ static TCGv plugin_maybe_preserve_addr(TCGv vaddr)
>  }
>
>  static void
> -plugin_gen_mem_callbacks(TCGv copy_addr, TCGv orig_addr, MemOpIdx oi,
> +plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGv orig_addr, MemOpIdx oi=
,
>                           enum qemu_plugin_mem_rw rw)
>  {
>  #ifdef CONFIG_PLUGIN
>      if (tcg_ctx->plugin_insn !=3D NULL) {
>          qemu_plugin_meminfo_t info =3D make_plugin_meminfo(oi, rw);
> -        plugin_gen_empty_mem_callback(copy_addr ? : orig_addr, info);
> +
> +#if TARGET_LONG_BITS =3D=3D 64
>          if (copy_addr) {
> -            tcg_temp_free(copy_addr);
> +            plugin_gen_empty_mem_callback(copy_addr, info);
> +            tcg_temp_free_i64(copy_addr);
> +        } else {
> +            plugin_gen_empty_mem_callback(orig_addr, info);
>          }
> +#else
> +        if (!copy_addr) {
> +            copy_addr =3D tcg_temp_ebb_new_i64();
> +            tcg_gen_extu_tl_i64(copy_addr, orig_addr);
> +        }
> +        plugin_gen_empty_mem_callback(copy_addr, info);
> +        tcg_temp_free_i64(copy_addr);
> +#endif
>      }
>  #endif
>  }
> @@ -147,7 +159,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, MemOp memop)
>  {
>      MemOp orig_memop;
>      MemOpIdx oi;
> -    TCGv copy_addr;
> +    TCGv_i64 copy_addr;
>
>      tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
>      memop =3D tcg_canonicalize_memop(memop, 0, 0);
> @@ -223,7 +235,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, MemOp memop)
>  {
>      MemOp orig_memop;
>      MemOpIdx oi;
> -    TCGv copy_addr;
> +    TCGv_i64 copy_addr;
>
>      if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
>          tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
> --
> 2.34.1

-- PMM

