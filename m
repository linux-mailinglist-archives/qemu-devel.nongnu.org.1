Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD97666AD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPICa-0003cg-E7; Fri, 28 Jul 2023 03:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPICY-0003cS-OV
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:47:54 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPICW-0004uU-VN
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:47:54 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a425ef874dso1491515b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690530472; x=1691135272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MMQFu/gMC2oZ2PpZP1iQJImmfvVCtzU/hGKfgdPRKpA=;
 b=lFpqAqGnOyGpHWnVMV3Uv4xakcjjCVdTwwiU0mda2+ZE52wbMHADY9YDCJ6XALJrja
 4kWapCbcFb8/5k6HBVxKkQT+Ml8QXwOiOCWucK61PBBuY9iLQ1tkHZ2AbjRE0KAAie2j
 g622cKj81vVrgmYG+F2JBaC6hnpQqcuIsm5y2CWmp3WjxCsv5c5bKVXYJOrHsuzH0Qsw
 5UOLA0JJLQOeyjMvmfazVB4RsBc2Ij7kvFp1oQ6GLXQaWiYOmKpGcz7MSAPRSl4/bcRk
 symlEGVbDVdxywzb3+/CJRzv/3OjSHkejENmaSWuO0G8+zmVfwNVrmlEAV15qqlOVPmZ
 C1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690530472; x=1691135272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MMQFu/gMC2oZ2PpZP1iQJImmfvVCtzU/hGKfgdPRKpA=;
 b=J7yO7mF1TfqVZPTqn5QJInGVuwYX2yRYlh1MlzqdSoO25bZ85KRCGaHxCzpx4rsNw0
 DF3n2cN/iS1a2nN+Il8XM7ySQpwc6sIzCtKmRONaFe5lXe2V05cg0pcPka1Wy7omMwd2
 BY9msQFP9tfRvJ9uDCRAbBwcPmWMS56ZRajgPqT07r/eqPn1eJQzq98MVFbGqZ1Ba5Q3
 YHJ4MnNpk5YNrAkEwqHh7L9k4e80zKjoFhforOwaH5zDDy4igGo8QH0ygNHvycuaeOpP
 8nNOYQNseyvViSEZoWKLWJBLbG3JsIZZr7l+RO5CMd1P268RuueNH2H8TQROF5syi7sg
 wp+w==
X-Gm-Message-State: ABy/qLbDwFb9TmI0uIGsYO2NcVIT4rLgb//JKCoxbZcHHF2UP5O3f0fV
 F0NU2rmjV9ciojOMENV871hRAA==
X-Google-Smtp-Source: APBJJlGmnoHWUUdp9sO2U1N1XcRY2IImvZJ2jh0RrMSYRPMULGQO1kmIqfLxHn+PEWKip/8SQLSmvQ==
X-Received: by 2002:a05:6808:bd4:b0:3a5:ca93:fb69 with SMTP id
 o20-20020a0568080bd400b003a5ca93fb69mr2711299oik.55.1690530471578; 
 Fri, 28 Jul 2023 00:47:51 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 z2-20020a056808048200b003a422b6ff4csm1402054oid.49.2023.07.28.00.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 00:47:51 -0700 (PDT)
Message-ID: <27b8fef7-7850-d99c-ae7b-110fa18ccaa9@ventanamicro.com>
Date: Fri, 28 Jul 2023 04:47:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv: Fix zfa fleq.d and fltq.d
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, qemu-riscv@nongnu.org
References: <20230728003906.768-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230728003906.768-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 7/27/23 21:39, LIU Zhiwei wrote:
> Commit a47842d ("riscv: Add support for the Zfa extension") implemented the zfa extension.
> However, it has some typos for fleq.d and fltq.d. Both of them misused the fltq.s
> helper function.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvzfa.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/insn_trans/trans_rvzfa.c.inc
> index 2c715af3e5..0fdd2698f6 100644
> --- a/target/riscv/insn_trans/trans_rvzfa.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfa.c.inc
> @@ -470,7 +470,7 @@ bool trans_fleq_d(DisasContext *ctx, arg_fleq_d *a)
>       TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
>       TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
>   
> -    gen_helper_fltq_s(dest, cpu_env, src1, src2);
> +    gen_helper_fleq_d(dest, cpu_env, src1, src2);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
>   }
> @@ -485,7 +485,7 @@ bool trans_fltq_d(DisasContext *ctx, arg_fltq_d *a)
>       TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
>       TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
>   
> -    gen_helper_fltq_s(dest, cpu_env, src1, src2);
> +    gen_helper_fltq_d(dest, cpu_env, src1, src2);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
>   }

