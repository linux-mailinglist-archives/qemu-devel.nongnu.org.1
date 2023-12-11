Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2280C88A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:54:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeqS-0006wd-49; Mon, 11 Dec 2023 06:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rCeqI-0006w2-KW
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:52:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rCeqG-0007nT-CK
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:52:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d2f1cecf89so10016355ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702295574; x=1702900374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTUMTo32ysqKVpCg4PP/v6//6zL2/m9jsa91bjnhdZM=;
 b=J+q+3y6/jM7tm71vLA4tLl/rFKVVoP1TglKnWmUgB6ObrX23ZN+VWrQ2l2kHDCAipo
 lwC/R43cShmPkZE9NOIwWXguVyD4P4d5MFsljB1xtY8XR6gJXd2LHBtHPYg2gMJH20E+
 oGavt/w6QLTLfhn4CC4oGDKSY8zcTr4vze0ftqXqeK732s8HZVXBcynAySS4GwnThzAH
 q5OfIkOCwd2I8HCgh+Cw4bDHGwIbkgAg2cMz5AnJOS3yxKxpaSmTGhyQoqp4sUh1CIDd
 NIOHtxfMwKmK01OqrDcaynoHjDKrXsN8p2+G3JUvpv1ZLOEnTFnxYZ+4XhfKP4shyfOS
 3r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702295574; x=1702900374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTUMTo32ysqKVpCg4PP/v6//6zL2/m9jsa91bjnhdZM=;
 b=K5sLCJFxRLEJmkHCgizG4xTPXAQpsv4znM0DOvV/hS21lUpee0mglTa8GkPELVFQjB
 YJv/ly6w1fjVk34P4qiUOGqfpWW3s11i9toUSjfEbcQ3dpoPRSqZkQ84gJ0MpRRUOiYR
 cDuoecnUpkrgYpV7Mj3UimNB7eZMwgSd/qJtfzRnqo7oJcbX/7E8bcAB1s7cohjqbP11
 3S3x3BtLz6Sfk9KTDhDeamEZ57n4ruDDJqe916EmtwgvYIvgdWBzSqjEfJCZiqSLAC+3
 97Sd/FkGlj5rNXYTfs9fzA71q4XxcWJSpK9vpKX/+Vx9gYH+Aw1sn9hzGK/TvnPZarRJ
 Ki+Q==
X-Gm-Message-State: AOJu0Yz3KpusHsSVnnX0Mzdo2AKpuE+yc4OzmW5e02IRHMBwgZAjpgxL
 FrWVhi7xy1B4jXBT5Yy5Slhsww==
X-Google-Smtp-Source: AGHT+IG31AC7BzuPsBKUau+8F6s2EknL7wQdmcOfQ+cboC2AcpQ02m+tATRTa2QBKiZFHlgLL4F6JQ==
X-Received: by 2002:a17:903:22cc:b0:1d0:a53e:263a with SMTP id
 y12-20020a17090322cc00b001d0a53e263amr1688280plg.109.1702295574659; 
 Mon, 11 Dec 2023 03:52:54 -0800 (PST)
Received: from [192.168.68.110] ([152.234.124.8])
 by smtp.gmail.com with ESMTPSA id
 iz17-20020a170902ef9100b001cfc170c0cfsm6457401plb.119.2023.12.11.03.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 03:52:54 -0800 (PST)
Message-ID: <6afcdc38-fd02-4c90-b773-7185513c5962@ventanamicro.com>
Date: Mon, 11 Dec 2023 08:52:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] disas/riscv: Add amocas.[w,d,q] instructions
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20231207153842.32401-1-rbradford@rivosinc.com>
 <20231207153842.32401-3-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231207153842.32401-3-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 12/7/23 12:32, Rob Bradford wrote:
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>   disas/riscv.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e9458e574b..8a546d5ea5 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -903,6 +903,9 @@ typedef enum {
>       rv_op_vwsll_vv = 872,
>       rv_op_vwsll_vx = 873,
>       rv_op_vwsll_vi = 874,
> +    rv_op_amocas_w = 875,
> +    rv_op_amocas_d = 876,
> +    rv_op_amocas_q = 877,
>   } rv_op;
>   
>   /* register names */
> @@ -2090,6 +2093,9 @@ const rv_opcode_data rvi_opcode_data[] = {
>       { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
>       { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
>       { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
> +    { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>   };
>   
>   /* CSR names */
> @@ -2841,6 +2847,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               case 34: op = rv_op_amoxor_w; break;
>               case 35: op = rv_op_amoxor_d; break;
>               case 36: op = rv_op_amoxor_q; break;
> +            case 42: op = rv_op_amocas_w; break;
> +            case 43: op = rv_op_amocas_d; break;
> +            case 44: op = rv_op_amocas_q; break;

scripts/checkpatch.pl will complain about this change:

2/2 Checking commit 9bddd6d4337d (disas/riscv: Add amocas.[w,d,q] instructions)
ERROR: trailing statements should be on next line
#40: FILE: disas/riscv.c:2850:
+            case 42: op = rv_op_amocas_w; break;

ERROR: trailing statements should be on next line
#41: FILE: disas/riscv.c:2851:
+            case 43: op = rv_op_amocas_d; break;

ERROR: trailing statements should be on next line
#42: FILE: disas/riscv.c:2852:
+            case 44: op = rv_op_amocas_q; break;

total: 3 errors, 0 warnings, 27 lines checked


This is an existing style problem thus I'm ignoring it. We can drop a separated patch
to fix the coding style.

Patch LGTM.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>



>               case 66: op = rv_op_amoor_w; break;
>               case 67: op = rv_op_amoor_d; break;
>               case 68: op = rv_op_amoor_q; break;

