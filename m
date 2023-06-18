Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84D73473C
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 19:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAwGr-00055m-6e; Sun, 18 Jun 2023 13:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwGp-00055b-Pg
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:32:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwGo-00081a-5q
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:32:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f8ff5fe50aso10787605e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687109576; x=1689701576;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytX3YnWp8BOXLnxDChxXr+kdZhkVEHUXMhtvcFCbpVE=;
 b=hPG6LTF28Mw+Klv7Vfox15la1TqPxZaAa0a2JmCo1379LW3HwgCUWLq/V5dTE0h1yL
 WvmTkgWBKV+RPYdMziG+of2R335mMMY49rFRic++tv9LxYgzpaiSy+2sVhtGEuWLzptB
 7yY2dH5z0rW9vk6Xlox2sJ/QhYNyZ58s9Y75ANIt85B9q0AxP8IouwS4dpgAu79mJ/5B
 E06dWKd4KhkvPQa6V0u540nhDurA2kFZEExwWTasVxYBgkwZGjDotRKeoPGxGjmSfveq
 o+ryxH+pcIAHB7MN0TcsYY7M2Vmwu2jnb23AAAYiS4eclro/J/IIQrth/ijZ7Pv3B0GR
 SYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687109576; x=1689701576;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytX3YnWp8BOXLnxDChxXr+kdZhkVEHUXMhtvcFCbpVE=;
 b=h7y1z34iuUvVMqeLPyETAEIap6jQwdiaC0z4mlbVZ/YMCTjcfxZXiN42FKiGiV2Mq1
 yQonn7DcJuxd1QRMzfRTQr8RD/YpO7aIzaZE27V2oV1ZGBn0/BMGbSRtXyf8V+r9mJDM
 1KpF0HdHxPg0Yc6U6loCxKjrFVjbEO0qCg5Ho+OI2JXEYvFSq5BWbO3uW6VdnRste9Il
 JUnWYYcaERkle5N7R3waQyyubUo0mdAamiXttqzBJ58PZ9d5uZFT4pGLhE+joG1zAhz6
 o2PYSk1H0imtYolb3X/i7dhAedjOmeTKCVWXYSiRV7pK4hCnQua7UiAZKHvzoWdP/PJ5
 /9gg==
X-Gm-Message-State: AC+VfDy12FUI6C8swoiLtjw+ADvQdLdFDsyXeV5y6m7zDzLhGi7xIVZZ
 j3MbmedEvD+VICSK8SPeDYldPQ==
X-Google-Smtp-Source: ACHHUZ4ebDY46WTE6tuKJlDsNXxnCx/J6DP7hFZ0TOKFxBBwHgFjvvxW0N7CvTxErQ45/Vy/1S91FA==
X-Received: by 2002:a1c:cc07:0:b0:3f7:c92:57a0 with SMTP id
 h7-20020a1ccc07000000b003f70c9257a0mr6226597wmb.14.1687109576492; 
 Sun, 18 Jun 2023 10:32:56 -0700 (PDT)
Received: from [192.168.69.129] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 c25-20020a05600c0ad900b003f604793989sm8281009wmr.18.2023.06.18.10.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 10:32:56 -0700 (PDT)
Message-ID: <49c1036c-fa2b-a529-3bcb-44e36ab27fc1@linaro.org>
Date: Sun, 18 Jun 2023 19:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/8] target/tricore: ENABLE/DISABLE exit to main-loop
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
 <20230616152808.1499082-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152808.1499082-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/16/23 17:28, Bastian Koppelmann wrote:
> so we can recognize exceptions after re-enabling interrupts.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index d4f7415158..6164ba6539 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -38,6 +38,7 @@
>   #undef  HELPER_H
>   
>   #define DISAS_EXIT        DISAS_TARGET_0
> +#define DISAS_EXIT_UPDATE DISAS_TARGET_1
>   
>   /*
>    * TCG registers
> @@ -7880,11 +7881,13 @@ static void decode_sys_interrupts(DisasContext *ctx)
>           break;
>       case OPC2_32_SYS_DISABLE:
>           tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
> +        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>           break;
>       case OPC2_32_SYS_DISABLE_D:
>           if (has_feature(ctx, TRICORE_FEATURE_16)) {
>               tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR, ctx->icr_ie_offset, 1);
>               tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
> +            ctx->base.is_jmp = DISAS_EXIT_UPDATE;

Disable does not require this change, only enable and restore (which may enable interrupts).

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

>           } else {
>               generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
>           }
> @@ -7892,6 +7895,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
>           break;
>       case OPC2_32_SYS_ENABLE:
>           tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
> +        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>           break;
>       case OPC2_32_SYS_ISYNC:
>           break;
> @@ -8379,6 +8383,9 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>       case DISAS_TOO_MANY:
>           gen_goto_tb(ctx, 0, ctx->base.pc_next);
>           break;
> +    case DISAS_EXIT_UPDATE:
> +        gen_save_pc(ctx->base.pc_next);
> +        /* fall through */
>       case DISAS_EXIT:
>           tcg_gen_exit_tb(NULL, 0);
>           break;


