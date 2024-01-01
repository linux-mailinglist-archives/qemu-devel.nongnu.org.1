Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B48212CA
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 02:44:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK7L9-0002p7-AX; Sun, 31 Dec 2023 20:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK7L6-0002oy-Cx
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 20:43:37 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rK7L4-0004Ea-Tb
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 20:43:36 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28bc870c540so6481036a91.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704073413; x=1704678213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmAlPdp1doHYz0XPA+SGLQe6SFOQwQYjFX2j0fxSf6E=;
 b=Q3rWjcqnJAsB59CGkVVSkHXaobh2WeNbsCw64E9d+5cWWyMWHKCyerANs/tyZW0XWF
 hbszvkz76vfzGl4/iEa9TJXlLMO2T+82fJuX1GyOIiNu2WW2jjCg6IL3sL24xPg1jiss
 YUvC17vjtzPWuLRyn/xO6kzthG6yuZ7KhUVvcpG+DQsV94jI9sieJF2vXW40WV4rbKOo
 B8IbIupaj9E9nXTCSiV3NfBPeIk0+cELSaL9JrvHoRC5/1Uz8X83UV59m7NCYgE26vpQ
 ZORCvdQ/JciqeYv5evtFpvqpFxOZKL9Pg2fJpaB46/9n3RBIxxiO28XXZEozbifUEEig
 XiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704073413; x=1704678213;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmAlPdp1doHYz0XPA+SGLQe6SFOQwQYjFX2j0fxSf6E=;
 b=PETJxEoNWnAAEZRvaUJWX8SePiEZqZBn6GMW1VnBkc6ofNxTmQYyWDW+m/5RKy851K
 B+x60LIdzlC1mxL/ZFaJMCDd8k6HFmIQ2Z8V51eHwyjsr/D1Vflndg44SLTxgfBazi9s
 SgaSMbsoapbP5vW/X+MXkt/w8CT+BVtu8epeBpw/Gt251vw8v+zKJJCoWv7XHbIzoCBd
 3RPu+BtRjLAHYnGRLvQk142+rmvQCzzX11te4nukXVwiN+nBNH4gzGZxcxP5CDlQUdjk
 JwpGycAUW+M34IvPWjxCVu/F4wcD1Rz03xtkB2ClgeaNShIAOONy1TjnAJj/gTv+PXJc
 xfaA==
X-Gm-Message-State: AOJu0Yx7qgBEJX5jFzSeXJArSpV+RWKdjTZob0iJXOY01Gvb9FlxXfUF
 27fWA1DIUYRDmljzJGT5VZ0zW0kGcixf2F5V5CMjlaDo7Pj9nw==
X-Google-Smtp-Source: AGHT+IEiDnlvR0Mluen2Geup7U3JYroKRIR6fe9+K99GVlhm0HfXaQO57sa23wt3qm5qWVDMjsY9Ig==
X-Received: by 2002:a17:902:e5c7:b0:1d4:35d6:f999 with SMTP id
 u7-20020a170902e5c700b001d435d6f999mr17108337plf.139.1704073413044; 
 Sun, 31 Dec 2023 17:43:33 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a170902778d00b001d403f12739sm19033419pll.263.2023.12.31.17.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Dec 2023 17:43:32 -0800 (PST)
Message-ID: <8fc61441-a87a-4c78-85ff-d00b7889fc8b@linaro.org>
Date: Mon, 1 Jan 2024 12:43:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/i386: use 8-bit OR or XOR for unsigned 8-bit
 immediates
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231228120524.70239-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231228120524.70239-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 12/28/23 23:05, Paolo Bonzini wrote:
> In the case where OR or XOR has an 8-bit immediate between 128 and 255, we can
> operate on a low-byte register and shorten the output by two or three bytes
> (two if a prefix byte is needed for REX.B).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/i386/tcg-target.c.inc | 7 +++++++
>   1 file changed, 7 insertions(+)

Queued.  I adjusted the function a bit to use a switch.


r~

> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 1791b959738..a24a23f43b1 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -244,6 +244,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
>   #define P_VEXL          0x80000         /* Set VEX.L = 1 */
>   #define P_EVEX          0x100000        /* Requires EVEX encoding */
>   
> +#define OPC_ARITH_EbIb	(0x80)
>   #define OPC_ARITH_EvIz	(0x81)
>   #define OPC_ARITH_EvIb	(0x83)
>   #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
> @@ -1366,6 +1367,12 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
>           tcg_out8(s, val);
>           return;
>       }
> +    if (val == (uint8_t)val && (c == ARITH_OR || c == ARITH_XOR) &&
> +        (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
> +        tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_RM, c, r0);
> +        tcg_out8(s, val);
> +        return;
> +    }
>       if (rexw == 0 || val == (int32_t)val) {
>           tcg_out_modrm(s, OPC_ARITH_EvIz + rexw, c, r0);
>           tcg_out32(s, val);


