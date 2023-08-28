Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B340B78B605
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafjC-00047q-ST; Mon, 28 Aug 2023 13:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafix-00046g-BN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:08:27 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafis-0004ai-Bo
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:08:21 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5657add1073so2238560a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693242495; x=1693847295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkMgUOGEh4RlpqBQFGPCdFzqgORkKvmbCqvJGsMxeT0=;
 b=XUhGK5kGwtRMzg9AcDQ1rsPecwh22ChH4zUWxHcySTqY8YYADLtdK8JO1y2b7IV4JZ
 wYyET8ARvl37riqLHYCimTypqMqIHQjfVS+h5HjRnLMPcfa/2t7sjHXFquEpH3Z9LXA1
 MHqY5jOw5JPceSIY8TJTd0j7tr/oZk+x7QRjqhuimuNVsOqiLc7bO0iZM9SoULnLF3gk
 lmVebJBJmWwDelrXyyCNeEQj9Jf2B0gOBXy4f9tBjoQbfFiDNAE0GOrxWkyNgGunIksm
 EO7uvvZRJkrsOUHH0zU/NCfJOeGNdBsHYegd06yy9G8WJnn72ZUV4wSc7/mGfEbe9LKj
 F6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693242495; x=1693847295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkMgUOGEh4RlpqBQFGPCdFzqgORkKvmbCqvJGsMxeT0=;
 b=IrQEACDtDxYXfcoMvtFJSGAq8vCiUz3w+ruza+AhfbwwXbP5nmm35oFiLyiBnGZyhj
 eKkVWFkNy3S/bnpizLS9lnTKv/jYFoGGI2Bj/lE1hTEB/fH0HXav7tTQJ6g82t83VTpd
 FygZuWhcaV4juNeaQSER3GlmzGSFNkfXMw63TtNRa6QDzRp34gYogFFtW0bsPfDmYnqA
 7b9VJa86qIKp2li6GFbDKizef8sS0+4TNffHmTQw5xRkXapC8tqYRyOINmohCQILJHXE
 B5FxTT4LxlGH1obfe+sWJXPqEVvu7QyDauE2RwSviHNU0WJnhXR26aFtPQ2HVpPedpBe
 CIlw==
X-Gm-Message-State: AOJu0YzItjfHbNBHCXsI3qnvxzQWR5d0S1KpU21EYNdkm/VFUwMcXH9f
 rNi7Ccbms8qUmYP/Gvjy6Wc9y7GbYyqmaNDXQ8E=
X-Google-Smtp-Source: AGHT+IFe9xSXOMtAu+mX/Q/S3Q7jIgqxV2CLqW/FyWg8K/Klyb0zCcy0y4OfT8pEZ9juyJc5ofVVJg==
X-Received: by 2002:a17:90a:eac9:b0:263:f521:da3e with SMTP id
 ev9-20020a17090aeac900b00263f521da3emr349851pjb.2.1693242495353; 
 Mon, 28 Aug 2023 10:08:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ne11-20020a17090b374b00b0026fb228fafasm3818607pjb.18.2023.08.28.10.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:08:14 -0700 (PDT)
Message-ID: <a09cfedb-98b0-acb5-a395-0edee1a7b2ea@linaro.org>
Date: Mon, 28 Aug 2023 10:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/11] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-4-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -1624,6 +1624,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       TCGReg temp = TCG_REG_TMP0;
>       int32_t offset;
>   
> +    static const LoongArchInsn cmp_vec_insn[16][4] = {
> +        [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
> +        [TCG_COND_LE] = {OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D},
> +        [TCG_COND_LEU] = {OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU},
> +        [TCG_COND_LT] = {OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D},
> +        [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
> +    };
> +    LoongArchInsn insn;
> +
>       a0 = args[0];
>       a1 = args[1];
>       a2 = args[2];
> @@ -1656,6 +1665,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           }
>           tcg_out_opc_vld(s, a0, base, offset);
>           break;
> +    case INDEX_op_cmp_vec:
> +        TCGCond cond = args[3];
> +        insn = cmp_vec_insn[cond][vece];
> +        if (insn == 0) {
> +            TCGArg t;
> +            t = a1, a1 = a2, a2 = t;
> +            cond = tcg_swap_cond(cond);
> +            insn = cmp_vec_insn[cond][vece];
> +            tcg_debug_assert(insn != 0);
> +        }
> +        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
> +        break;
>       case INDEX_op_dupm_vec:
>           tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
>           break;
> @@ -1671,6 +1692,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
>       case INDEX_op_st_vec:
>       case INDEX_op_dup_vec:
>       case INDEX_op_dupm_vec:
> +    case INDEX_op_cmp_vec:
>           return 1;
>       default:
>           return 0;
> @@ -1832,6 +1854,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_st_vec:
>           return C_O0_I2(w, r);
>   
> +    case INDEX_op_cmp_vec:
> +        return C_O1_I2(w, w, w);

Further improvement can be done with VS*I, and its 5-bit signed immediate.
While you can't swap operands for GT/GE in that case, you can invert, e.g.
GT -> LE, then invert the result using VNOR.

Comparing vs zero is especially common...


r~

