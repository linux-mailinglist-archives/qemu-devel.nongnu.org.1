Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C46949E47
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Aug 2024 05:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXKr-0007hz-MS; Tue, 06 Aug 2024 23:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXKp-0007et-ID
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:27:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXKn-000131-Om
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:27:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7105043330aso1194056b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723001251; x=1723606051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9GDiYt8wBPuH2d5BM5Hm6euRsLfv5RX4BNwG1Zbmuo=;
 b=cnV07Ub76L+98tihOVyb4iR9PA8Kd7SyJvD5JAhUxsIaRz1O8edRvwRCsAxO3LTNMb
 gf54Y/mUw2vEi8D+3QeTo+A+xqYoWH8+QqWLz1nhCCWlyd0uCen1Qn4Md5V43UAWQd5+
 NSAgPA6cVonumFSKudzc3MRtO4RJqkFMXzBRo1Dox/7yn2Z72QHmGeML/1f7PUjXBjSY
 G1Vg5Puz3h0wtOGd6rlbw0baV85Gg5F4lVFCVjtBGFmU//TARvhBxfTtWA7ay8gU6yum
 uG7Q0IAktBk5TyNnVOLAceCVBbtHKB7xFtepq/H4IFcUNqKGrcrQ9IfQZTtDvuNXtaCS
 Qtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723001251; x=1723606051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9GDiYt8wBPuH2d5BM5Hm6euRsLfv5RX4BNwG1Zbmuo=;
 b=XiLZxFm8YByFPwCMQFL8vzCZ074YJFKSkPOwyrn5a1ADhiCoWi3gCDNUq+p/zl2PF4
 m763pUJXtMQG2vuJ2ClZ6CEIEIaEDYOIfgAj6WY6nFjY/AjpNVjN05wQUtwOkhxNzkCG
 JVifRRvD3tig34OHOrVqZgAooVGMtlxiE+aapaYaSgC+ImkHFnoZEHWAVbCeCfsBWTJo
 YQGJrjDw9r9j+speMI4xD/i1hmhkd7dVOE53TPzJcPE2SO/rVYzATQ3nmA4u4astYSbn
 vWvY4LuoAC2k7aDufeBvacJ/f8PLRoJwdJ8c21KV+/rkMnoWXcf60a2d4XyWW33LGyBh
 mqFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXAH0PoDKD13MBQpw+eWo9IHPwboo6lMQsmP25lrq8GktdGXcWLXkZvc17HQkWCSOwHBHgDhDzPV3D@nongnu.org
X-Gm-Message-State: AOJu0Yxl4AhiGiGMu3i+1O96fizqppRRzi0Qk11C61MYzTIj2ywssfN4
 R/gXrLLs6eic73C6DboPowNcfQPDwWYlNLZGomV1A/wdumqdI8I4oPY2FLIybX4=
X-Google-Smtp-Source: AGHT+IHLOSHPwZWnRPUK4Nt0YJWL1E96O/4KXawh/F1jIKp8NxbrtbkXSoISJWK1/M21ccxeW9nRmQ==
X-Received: by 2002:a05:6a20:3d87:b0:1c3:b20e:8bbf with SMTP id
 adf61e73a8af0-1c69957003amr20137005637.14.1723001251230; 
 Tue, 06 Aug 2024 20:27:31 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b36a72e0sm295783a91.9.2024.08.06.20.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:27:30 -0700 (PDT)
Message-ID: <a8105f82-9324-478b-960b-b387c261999f@linaro.org>
Date: Wed, 7 Aug 2024 13:27:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] target/riscv: add trace-hooks for each case of
 sw-check exception
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-19-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-19-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 10:06, Deepak Gupta wrote:
> Violations to control flow rules setup by zicfilp and zicfiss lead to
> software check exceptions. To debug and fix such sw check issues in guest
> , add trace-hooks for each case.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++--
>   target/riscv/op_helper.c                | 24 ++++++++++++++++++++++++
>   target/riscv/trace-events               |  6 ++++++
>   target/riscv/translate.c                |  2 +-
>   4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index cbd7d5c395..0f5d5def60 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -65,7 +65,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>                */
>               gen_helper_raise_sw_check_excep(tcg_env,
>                   tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -                tcg_constant_tl(MISALIGNED_LPAD), tcg_constant_tl(0));
> +                tcg_constant_tl(MISALIGNED_LPAD),
> +                tcg_constant_tl(ctx->base.pc_next));
>               return true;
>           }
>       }
> @@ -81,7 +82,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>           tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm_cfi20, skip);
>           gen_helper_raise_sw_check_excep(tcg_env,
>               tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -            tcg_constant_tl(LABEL_MISMATCH_LPAD), tcg_constant_tl(0));
> +            tcg_constant_tl(LABEL_MISMATCH_LPAD),
> +            tcg_constant_tl(a->imm_cfi20));
>           gen_set_label(skip);
>       }
>   
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 3b47fb34ea..07990e6589 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/exec-all.h"
>   #include "exec/cpu_ldst.h"
>   #include "exec/helper-proto.h"
> +#include "trace.h"
>   
>   /* Exceptions processing helpers */
>   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> @@ -262,6 +263,29 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>   void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code,
>                                    target_ulong arg1, target_ulong arg2)
>   {
> +    switch (swcheck_code) {
> +    case RISCV_EXCP_SW_CHECK_FCFI_TVAL:
> +        switch (arg1) {
> +        case MISSING_LPAD:
> +            trace_zicfilp_missing_lpad_instr(arg2);
> +            break;
> +        case MISALIGNED_LPAD:
> +            trace_zicfilp_unaligned_lpad_instr(arg2);
> +            break;
> +        case LABEL_MISMATCH_LPAD:
> +            trace_zicfilp_lpad_reg_mismatch(arg2);
> +            break;
> +        }
> +        break;
> +    case RISCV_EXCP_SW_CHECK_BCFI_TVAL:
> +        trace_zicfiss_sspopchk_reg_mismatch(arg1, arg2);
> +        break;
> +    default:
> +        /* any other value of swcheck_code is asserted */
> +        assert(swcheck_code || (swcheck_code == 0));
> +        break;
> +    }

I think this is a mistake.
Better to have 4 different helpers and eliminate MISSING_LPAD, etc entirely.

> @@ -1302,7 +1302,7 @@ static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>           tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
>           gen_helper_raise_sw_check_excep(tcg_env,
>               tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(0));
> +            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(ctx->base.pc_first));

You certainly don't need to pass pc_first, since if lp_expected is set that is always 
env->pc in the helper.


r~

