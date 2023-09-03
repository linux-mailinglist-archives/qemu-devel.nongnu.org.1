Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BB790A6C
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 02:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcbNs-00062e-W7; Sat, 02 Sep 2023 20:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbNq-00062O-SN
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 20:54:34 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbNo-0004uA-IK
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 20:54:34 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bdc27e00a1so320130a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 17:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693702471; x=1694307271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDdXf56dWR6qLxH8Wm58Pk+/Ja5RVjkcUj0MAjKJcGo=;
 b=MlY6ew43BlJXWhEtnqryK9zzlpLOWIFZYZdRuHK7HY1n1IFuaFNSUBw1qBE94r6mG3
 oCfACig+Ot8VPp9Y7r9V0rtaqH/bxd6pNQGbzeeAlm+qr23ReeMzHZk81pzzVNMheye4
 vvSZybKf/5EP50SlEZT+e0kMXev3m3lGpKxLiuo9KmTw2sNnJcicKR9OtLpruCKAw25A
 My/2aqrerg9jDgQpKiOZRdAZOXMo8bf2ZN7bDJmULwj1YSrGIIgGTscW+UgK1sZ6O+wN
 9kVfI7P3cPONnb0bWpayYwMgkiLctcDCceeCs0BIijm0sgPCwOZgJXq5YyDxamzTe1li
 /zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693702471; x=1694307271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDdXf56dWR6qLxH8Wm58Pk+/Ja5RVjkcUj0MAjKJcGo=;
 b=L3noL8bVzmw0Ibbkmn4vD36NxEV/IvCS+C11wtdyy5ROAFTUiQGR5Vk/YE63BtaiK6
 9cSE35FxnxFfKo9xhkhWEq/H3TK4v4CS44I0Iq9lPEtqtjzX/9t58lTY6eCAfBB+zcSH
 CAqCpaX0zll3VxhPRXqqOP0RydhOBuQ0VLujaeDrTNlyW0Ap8azTUUz+LgEqPkRD1qzS
 2JcyWkR0wh0dn+d0OoD1r+tDZSlarU4336IXuHdhaV3iiud5tpi37G87dkNunNLbtuIM
 jCmgAFWFNuqpwFa9H7pNIrlZuBzfFn5ht6PQ6i8jPAS/EYuZjDltFqWM49Y5+ATBKw8d
 C5Jg==
X-Gm-Message-State: AOJu0YwFYc+OyzlrTsCn1jikLHuXokP8TZ+oggW6MnhvmqqiHu8IPBVP
 7TeYgdUcQbtx7LaMvu+8eFlh1A==
X-Google-Smtp-Source: AGHT+IF4oYGyt9cDP+JB3l110KBEmDeCHbuWrYpz2xoMm9buPt+J+TLmSt4rlpFBa4K93vzRnfOFzA==
X-Received: by 2002:a05:6358:339b:b0:130:e0a9:a7b4 with SMTP id
 i27-20020a056358339b00b00130e0a9a7b4mr7002009rwd.13.1693702471403; 
 Sat, 02 Sep 2023 17:54:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068664ace38asm5213323pfo.19.2023.09.02.17.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 17:54:30 -0700 (PDT)
Message-ID: <03f6765c-1a19-e525-e75f-c7d31b73f79b@linaro.org>
Date: Sat, 2 Sep 2023 17:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/16] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230902050415.1832700-1-c@jia.je>
 <20230902050415.1832700-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230902050415.1832700-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/1/23 22:02, Jiajie Chen wrote:
> Lower the following ops:
> 
> - add_vec
> - sub_vec
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target-con-str.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 60 ++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
> index 8c8ea5d919..2d5dce75c3 100644
> --- a/tcg/loongarch64/tcg-target-con-set.h
> +++ b/tcg/loongarch64/tcg-target-con-set.h
> @@ -32,4 +32,5 @@ C_O1_I2(r, rZ, ri)
>   C_O1_I2(r, rZ, rJ)
>   C_O1_I2(r, rZ, rZ)
>   C_O1_I2(w, w, wM)
> +C_O1_I2(w, w, wA)
>   C_O1_I4(r, rZ, rJ, rZ, rZ)
> diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
> index a8a1c44014..2ba9c135ac 100644
> --- a/tcg/loongarch64/tcg-target-con-str.h
> +++ b/tcg/loongarch64/tcg-target-con-str.h
> @@ -27,3 +27,4 @@ CONST('Z', TCG_CT_CONST_ZERO)
>   CONST('C', TCG_CT_CONST_C12)
>   CONST('W', TCG_CT_CONST_WSZ)
>   CONST('M', TCG_CT_CONST_VCMP)
> +CONST('A', TCG_CT_CONST_VADD)
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 129dd92910..0edcf5be35 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -177,6 +177,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_C12   0x1000
>   #define TCG_CT_CONST_WSZ   0x2000
>   #define TCG_CT_CONST_VCMP  0x4000
> +#define TCG_CT_CONST_VADD  0x8000
>   
>   #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
>   #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
> @@ -214,6 +215,9 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
>       if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
>           return true;
>       }
> +    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
> +        return true;
> +    }
>       return false;
>   }
>   
> @@ -1646,6 +1650,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
>       };
>       LoongArchInsn insn;
> +    static const LoongArchInsn add_vec_insn[4] = {
> +        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
> +    };
> +    static const LoongArchInsn add_vec_imm_insn[4] = {
> +        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
> +    };
> +    static const LoongArchInsn sub_vec_insn[4] = {
> +        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
> +    };
> +    static const LoongArchInsn sub_vec_imm_insn[4] = {
> +        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
> +    };
>   
>       a0 = args[0];
>       a1 = args[1];
> @@ -1712,6 +1728,44 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           }
>           tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>           break;
> +    case INDEX_op_add_vec:
> +        if (const_args[2]) {
> +            int64_t value = sextract64(a2, 0, 8 << vece);
> +            /* Try vaddi/vsubi */
> +            if (0 <= value && value <= 0x1f) {
> +                tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
> +                                                 a1, value));
> +                break;
> +            } else if (-0x1f <= value && value < 0) {
> +                tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
> +                                                 a1, -value));
> +                break;
> +            }
> +
> +            /* constraint TCG_CT_CONST_VADD ensures unreachable */
> +            g_assert_not_reached();
> +        }
> +        tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
> +        break;
> +    case INDEX_op_sub_vec:
> +        if (const_args[2]) {
> +            int64_t value = sextract64(a2, 0, 8 << vece);
> +            /* Try vaddi/vsubi */
> +            if (0 <= value && value <= 0x1f) {
> +                tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
> +                                                 a1, value));
> +                break;
> +            } else if (-0x1f <= value && value < 0) {
> +                tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
> +                                                 a1, -value));
> +                break;
> +            }
> +
> +            /* constraint TCG_CT_CONST_VADD ensures unreachable */
> +            g_assert_not_reached();
> +        }
> +        tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));

It would be nice to share code here.  Perhaps

     case INDEX_op_sub_vec:
        if (!const_args[2]) {
            tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
            break;
        }
        a2 = -a2;
        goto do_addi_vec;
    case INDEX_op_add_vec:
        if (!const_args[2]) {
            tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
            break;
        }
    do_addi_vec:
        ...

or a helper function.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

