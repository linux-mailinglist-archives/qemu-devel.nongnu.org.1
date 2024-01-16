Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F582FC78
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:20:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrmg-0002CS-ES; Tue, 16 Jan 2024 17:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrmd-0002By-VR
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:19:48 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrmc-00057g-7g
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:19:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso3146187a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705443584; x=1706048384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlQjOKZRTFt3hGU3td2nrCYtvliNazlg+zyWgr/k18o=;
 b=X9EPkHDjJUrc6YGdGeHvpcwCF17TA44XQLGCQ9hUN99eS+H8WKYvQhT4eeGRpANjy/
 Y6QffHI3UgC3tUsrTpwN2CP5dmOqX5jV5ptT6zi/M217b256SvgeWu/fCNdsnd6crNEY
 39SVlwECVYEnsvzRpLH/re88Fceqn+8tzfKlpVbP6eBt2EAWoxdUf7XbhgSZpeBZGey0
 vE2qQsDxhehRM8bCwF3sL9Vsn/iT6OOozXI2oBy+6hnQefaLiFQ1CpFk0dU+iGVuxi0G
 yuRRjjSGjp+RGlwhqfjX0MmyFTNH1V3M+LAjPxkCQo2JysMYA/rVggtib5e75Xs2ux9O
 3i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705443584; x=1706048384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlQjOKZRTFt3hGU3td2nrCYtvliNazlg+zyWgr/k18o=;
 b=BMl3KXt9CrokAxa5enE4hCTxQq2mAjH/MVe73sIx7FNoGf8e6Q/F00vOd2cvCt1+FM
 buomC6bu2eVwVIwOY1Xu5/5zv/uirGuuUujaiyiiQ/6hUvMmX9kFTZfE6cqRSM/SJBF1
 AdtitWA8N2lRT/BZqNaC463R4UOOxyOJpj4cdBYmPAAXOhjSdxe77jyTsoFDWDCf5jc0
 JIBHx2k0GzY/tCssLcZ0muGvpj8hkIPUNf/umIj1hE642xh+TnfYg1WDFJ2yyRP0qbaa
 FiErtuVKYEfHfoplZm/ckQgfDwE/1o3j/IClxOAnEJkdlNwUZQUrUqh5z+R//BXTz9zy
 ztDw==
X-Gm-Message-State: AOJu0YxkwAgxiIJjBDEXptpf+W4ecTELU6IS32479nAiCFjXMQ+av72J
 DOsOQ1yVO0PEZufm1XcJfWmvx7Eck5uQlw==
X-Google-Smtp-Source: AGHT+IFehbfIF1lbvhznqX4nwpnGzhMAhqRGIgh5rjgkJXHjSeePv1ZnrXVHgRrf97csfBDx8trU6g==
X-Received: by 2002:a17:907:a805:b0:a2c:4ce0:7a17 with SMTP id
 vo5-20020a170907a80500b00a2c4ce07a17mr4588664ejc.80.1705443584236; 
 Tue, 16 Jan 2024 14:19:44 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a170906688300b00a26aa734349sm6936219ejr.39.2024.01.16.14.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:19:43 -0800 (PST)
Message-ID: <b6a05a23-9f83-4a62-9f60-1ac5234cde31@linaro.org>
Date: Tue, 16 Jan 2024 23:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] target/s390x: Improve general case of disas_jcc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Hi Richard,

On 10/1/24 23:43, Richard Henderson wrote:
> Avoid code duplication by handling 7 of the 14 cases
> by inverting the test for the other 7 cases.
> 
> Use TCG_COND_TSTNE for cc in {1,3}.
> Use (cc - 1) <= 1 for cc in {1,2}.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 82 +++++++++++++-----------------------
>   1 file changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index ae4e7b27ec..168974f2e6 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -885,67 +885,45 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
>       case CC_OP_STATIC:
>           c->is_64 = false;
>           c->u.s32.a = cc_op;
> -        switch (mask) {
> -        case 0x8 | 0x4 | 0x2: /* cc != 3 */
> -            cond = TCG_COND_NE;
> +
> +        /* Fold half of the cases using bit 3 to invert. */
> +        switch (mask & 8 ? mask ^ 0xf : mask) {
> +        case 0x1: /* cc == 3 */
> +            cond = TCG_COND_EQ;
>               c->u.s32.b = tcg_constant_i32(3);
>               break;
> -        case 0x8 | 0x4 | 0x1: /* cc != 2 */
> -            cond = TCG_COND_NE;
> -            c->u.s32.b = tcg_constant_i32(2);
> -            break;
> -        case 0x8 | 0x2 | 0x1: /* cc != 1 */
> -            cond = TCG_COND_NE;
> -            c->u.s32.b = tcg_constant_i32(1);
> -            break;
> -        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
> -            cond = TCG_COND_EQ;
> -            c->u.s32.a = tcg_temp_new_i32();
> -            c->u.s32.b = tcg_constant_i32(0);
> -            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
> -            break;
> -        case 0x8 | 0x4: /* cc < 2 */
> -            cond = TCG_COND_LTU;
> -            c->u.s32.b = tcg_constant_i32(2);
> -            break;
> -        case 0x8: /* cc == 0 */
> -            cond = TCG_COND_EQ;
> -            c->u.s32.b = tcg_constant_i32(0);
> -            break;
> -        case 0x4 | 0x2 | 0x1: /* cc != 0 */
> -            cond = TCG_COND_NE;
> -            c->u.s32.b = tcg_constant_i32(0);
> -            break;
> -        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
> -            cond = TCG_COND_NE;
> -            c->u.s32.a = tcg_temp_new_i32();
> -            c->u.s32.b = tcg_constant_i32(0);
> -            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
> -            break;
> -        case 0x4: /* cc == 1 */
> -            cond = TCG_COND_EQ;
> -            c->u.s32.b = tcg_constant_i32(1);
> -            break;
> -        case 0x2 | 0x1: /* cc > 1 */
> -            cond = TCG_COND_GTU;
> -            c->u.s32.b = tcg_constant_i32(1);
> -            break;
>           case 0x2: /* cc == 2 */
>               cond = TCG_COND_EQ;
>               c->u.s32.b = tcg_constant_i32(2);
>               break;
> -        case 0x1: /* cc == 3 */
> +        case 0x4: /* cc == 1 */
>               cond = TCG_COND_EQ;
> -            c->u.s32.b = tcg_constant_i32(3);
> +            c->u.s32.b = tcg_constant_i32(1);
> +            break;
> +        case 0x2 | 0x1: /* cc == 2 || cc == 3 => cc > 1 */
> +            cond = TCG_COND_GTU;
> +            c->u.s32.b = tcg_constant_i32(1);
> +            break;
> +        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
> +            cond = TCG_COND_TSTNE;
> +            c->u.s32.b = tcg_constant_i32(1);

Don't we need to AND?

               c->u.s32.a = tcg_temp_new_i32();
               tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);

> +            break;
> +        case 0x4 | 0x2: /* cc == 1 || cc == 2 => (cc - 1) <= 1 */
> +            cond = TCG_COND_LEU;
> +            c->u.s32.a = tcg_temp_new_i32();
> +            c->u.s32.b = tcg_constant_i32(1);
> +            tcg_gen_addi_i32(c->u.s32.a, cc_op, -1);
> +            break;
> +        case 0x4 | 0x2 | 0x1: /* cc != 0 */
> +            cond = TCG_COND_NE;
> +            c->u.s32.b = tcg_constant_i32(0);
>               break;
>           default:
> -            /* CC is masked by something else: (8 >> cc) & mask.  */
> -            cond = TCG_COND_NE;
> -            c->u.s32.a = tcg_temp_new_i32();
> -            c->u.s32.b = tcg_constant_i32(0);
> -            tcg_gen_shr_i32(c->u.s32.a, tcg_constant_i32(8), cc_op);
> -            tcg_gen_andi_i32(c->u.s32.a, c->u.s32.a, mask);
> -            break;
> +            /* case 0: never, handled above. */
> +            g_assert_not_reached();
> +        }
> +        if (mask & 8) {
> +            cond = tcg_invert_cond(cond);
>           }
>           break;
>   


