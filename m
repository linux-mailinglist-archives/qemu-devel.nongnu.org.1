Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBF73A7F7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 20:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOlh-0006Ko-6B; Thu, 22 Jun 2023 14:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCOle-0006KJ-Sw
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:10:50 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCOlc-00027c-VL
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:10:50 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-39ecbb4c7d3so3757819b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687457448; x=1690049448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pQ+++coWpXmi0zO8+dIEZlodBa584/Hr7pw5kQztVlM=;
 b=Yb6ZqF2uw3lW+VDn06MrtruGt8UZdpsqIZtFUJEAqqtYdx7fG12m/ivD2DUVwz7vIK
 gR4Wevj9O27/Ftp5FL9vsZNxZu8XdF9Q6LatTL8EPlss1N0Jl1pfuPhWISpAGbWGew8C
 Ul/nnulIqz264S4WIwhLUMWqg6VuMQL6euRQ6yYAOecS8F8yL9IYNpn3ebRD2Ly5feVb
 8+xmnoxkcqFJ/d/n47NWdQblTjtwKI/ShVWuLudrzIQpY5yzyQuA+fPa8s5vdW0IYpBm
 koso++TjRI3Z6BZIb6UkIPyb7RpzAn7UCltB0r4Sn0T/p118mXmtc5Oz9JtKIlbM0DHS
 L8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687457448; x=1690049448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ+++coWpXmi0zO8+dIEZlodBa584/Hr7pw5kQztVlM=;
 b=VnhqlG5UcI/KRJKziJs7sLtHRY/A6P9rKNDwKo2rdT+ey81bZH26pWv8NWa8D1ImPo
 s4tAU/XkRZps9cJN7Npoi7A2Dc4GT2r+xvsyqTxEEw+vhxn6iSl6+eSGkfBowftPaO3h
 gQEcY4rx8/oeggVsv3s3QjuKaVLNNeze4uqDob4VIWrXgU0Lczjl1iMY22fqKx9172vG
 AlH9B8wjsZJ4+1S9Ua7vafQwYFHVGGpqGARHg3DLXZITOX59HfAlfcbG20/EXVx8XZbo
 NoUb/srkQ5I+aScPdF5lp7LR3JW4MTxzLqvbu/8B7lics0fO6wim641sPg0oO6p7GxRY
 zO9g==
X-Gm-Message-State: AC+VfDxnwAs8LvaJ/Lyy26K95DBjEqjw5o9xk1VS/Y36qXAIO0PvK5Z6
 6aGhNAr9qHciXk5IBsAfZ5RezA==
X-Google-Smtp-Source: ACHHUZ7ar5Z053BB4PZYN6wFcVlijH/M6ZRun/BxrrHvd2V5XaFjiDcNNzbUX8En2TQxRy9vNK0ilg==
X-Received: by 2002:a05:6808:2224:b0:398:4ad8:5ce6 with SMTP id
 bd36-20020a056808222400b003984ad85ce6mr23926784oib.30.1687457447838; 
 Thu, 22 Jun 2023 11:10:47 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 u7-20020a056808114700b0039ea3942c33sm3443878oiu.3.2023.06.22.11.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 11:10:47 -0700 (PDT)
Message-ID: <3226dc15-c94f-24c7-f19d-2ff0e27194b6@ventanamicro.com>
Date: Thu, 22 Jun 2023 15:10:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 13/17] target/riscv: Add Zvkg ISA extension support
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 William Salmon <will.salmon@codethink.co.uk>
References: <20230622161646.32005-1-max.chou@sifive.com>
 <20230622161646.32005-14-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230622161646.32005-14-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/22/23 13:16, Max Chou wrote:
> From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> 
> This commit adds support for the Zvkg vector-crypto extension, which
> consists of the following instructions:
> 
> * vgmul.vv
> * vghsh.vv
> 
> Translation functions are defined in
> `target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
> `target/riscv/vcrypto_helper.c`.
> 
> Co-authored-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
> [max.chou@sifive.com: Replaced vstart checking by TCG op]
> Signed-off-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                       |  5 +-
>   target/riscv/cpu_cfg.h                   |  1 +
>   target/riscv/helper.h                    |  3 +
>   target/riscv/insn32.decode               |  4 ++
>   target/riscv/insn_trans/trans_rvvk.c.inc | 30 ++++++++++
>   target/riscv/vcrypto_helper.c            | 72 ++++++++++++++++++++++++
>   6 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c9a9ff80cd..8e60a122d4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -118,6 +118,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>       ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
>       ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
>       ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
> @@ -1198,8 +1199,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>        * In principle Zve*x would also suffice here, were they supported
>        * in qemu
>        */
> -    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha ||
> -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
> +    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
> +         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
>           error_setg(errp,
>                      "Vector crypto extensions require V or Zve* extensions");
>           return;
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index f859d9e2f5..b125b0b33f 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -85,6 +85,7 @@ struct RISCVCPUConfig {
>       bool ext_zve64d;
>       bool ext_zvbb;
>       bool ext_zvbc;
> +    bool ext_zvkg;
>       bool ext_zvkned;
>       bool ext_zvknha;
>       bool ext_zvknhb;
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 9220af18e6..a4fe1ff5ca 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1241,3 +1241,6 @@ DEF_HELPER_5(vsha2cl_vv, void, ptr, ptr, ptr, env, i32)
>   
>   DEF_HELPER_5(vsm3me_vv, void, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
> +
> +DEF_HELPER_5(vghsh_vv, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 5ca83e8462..b10497afd3 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -957,3 +957,7 @@ vsha2cl_vv  101111 1 ..... ..... 010 ..... 1110111 @r_vm_1
>   # *** Zvksh vector crypto extension ***
>   vsm3me_vv   100000 1 ..... ..... 010 ..... 1110111 @r_vm_1
>   vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
> +
> +# *** Zvkg vector crypto extension ***
> +vghsh_vv    101100 1 ..... ..... 010 ..... 1110111 @r_vm_1
> +vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
> index af1fb74c38..e5ccb26c45 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -510,3 +510,33 @@ static inline bool vsm3c_check(DisasContext *s, arg_rmrr *a)
>   
>   GEN_VV_UNMASKED_TRANS(vsm3me_vv, vsm3me_check, ZVKSH_EGS)
>   GEN_VI_UNMASKED_TRANS(vsm3c_vi, vsm3c_check, ZVKSH_EGS)
> +
> +/*
> + * Zvkg
> + */
> +
> +#define ZVKG_EGS 4
> +
> +static bool vgmul_check(DisasContext *s, arg_rmr *a)
> +{
> +    int egw_bytes = ZVKG_EGS << s->sew;
> +    return s->cfg_ptr->ext_zvkg == true &&
> +           vext_check_isa_ill(s) &&
> +           require_rvv(s) &&
> +           MAXSZ(s) >= egw_bytes &&
> +           vext_check_ss(s, a->rd, a->rs2, a->vm) &&
> +           s->sew == MO_32;
> +}
> +
> +GEN_V_UNMASKED_TRANS(vgmul_vv, vgmul_check, ZVKG_EGS)
> +
> +static bool vghsh_check(DisasContext *s, arg_rmrr *a)
> +{
> +    int egw_bytes = ZVKG_EGS << s->sew;
> +    return s->cfg_ptr->ext_zvkg == true &&
> +           opivv_check(s, a) &&
> +           MAXSZ(s) >= egw_bytes &&
> +           s->sew == MO_32;
> +}
> +
> +GEN_VV_UNMASKED_TRANS(vghsh_vv, vghsh_check, ZVKG_EGS)
> diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
> index 06c8f4adc7..04e6374211 100644
> --- a/target/riscv/vcrypto_helper.c
> +++ b/target/riscv/vcrypto_helper.c
> @@ -851,3 +851,75 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
>       vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
>       env->vstart = 0;
>   }
> +
> +void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
> +                      CPURISCVState *env, uint32_t desc)
> +{
> +    uint64_t *vd = vd_vptr;
> +    uint64_t *vs1 = vs1_vptr;
> +    uint64_t *vs2 = vs2_vptr;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
> +
> +    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
> +        uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
> +        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
> +        uint64_t X[2] = {vs1[i * 2 + 0], vs1[i * 2 + 1]};
> +        uint64_t Z[2] = {0, 0};
> +
> +        uint64_t S[2] = {brev8(Y[0] ^ X[0]), brev8(Y[1] ^ X[1])};
> +
> +        for (uint j = 0; j < 128; j++) {
> +            if ((S[j / 64] >> (j % 64)) & 1) {
> +                Z[0] ^= H[0];
> +                Z[1] ^= H[1];
> +            }
> +            bool reduce = ((H[1] >> 63) & 1);
> +            H[1] = H[1] << 1 | H[0] >> 63;
> +            H[0] = H[0] << 1;
> +            if (reduce) {
> +                H[0] ^= 0x87;
> +            }
> +        }
> +
> +        vd[i * 2 + 0] = brev8(Z[0]);
> +        vd[i * 2 + 1] = brev8(Z[1]);
> +    }
> +    /* set tail elements to 1s */
> +    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
> +    env->vstart = 0;
> +}
> +
> +void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
> +                      uint32_t desc)
> +{
> +    uint64_t *vd = vd_vptr;
> +    uint64_t *vs2 = vs2_vptr;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
> +
> +    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
> +        uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
> +        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
> +        uint64_t Z[2] = {0, 0};
> +
> +        for (uint j = 0; j < 128; j++) {
> +            if ((Y[j / 64] >> (j % 64)) & 1) {
> +                Z[0] ^= H[0];
> +                Z[1] ^= H[1];
> +            }
> +            bool reduce = ((H[1] >> 63) & 1);
> +            H[1] = H[1] << 1 | H[0] >> 63;
> +            H[0] = H[0] << 1;
> +            if (reduce) {
> +                H[0] ^= 0x87;
> +            }
> +        }
> +
> +        vd[i * 2 + 0] = brev8(Z[0]);
> +        vd[i * 2 + 1] = brev8(Z[1]);
> +    }
> +    /* set tail elements to 1s */
> +    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
> +    env->vstart = 0;
> +}

