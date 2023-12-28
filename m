Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C311781FB3B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 21:46:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxFl-0003It-SR; Thu, 28 Dec 2023 15:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxFj-0003Ij-Qw
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:45:15 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxFf-0004YQ-Kc
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:45:15 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35fd902c6b5so51208765ab.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703796308; x=1704401108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UBQJzg8p67MT+cAHsjxUE3jbvJVSTss8oIknW148j+0=;
 b=zs59Yd5X+adGF9yjuVZ8goj9je9SJrAb8pKh5h6o+s9gyOO38p5uzoJjEwu/YBWLsp
 6M0AbsKH8LnMUNGTpgr5+9ywAn2T4rP83obcNgjKRUhSVGtAtYtNHUpuJnt0hrOjQqp9
 nsUSsBcTe77wpkbMbzSm8G1XQ+uRu18bR0c8NJv/pCmPdJIWVdj8ZBZStcYSQ+sQVEcN
 YkC76gZxuPFa1aAHLg11o0dc9TwA6/YGVNJq7u6sQeyYj+hGHVF6HvHUlRjpWfAhjLbC
 D/dAnQ+fpQEKKoyHwQk2Rl4hAbdDb0+TplEMQUfk4T+xz5nGbCi0LwiptJsr7Zn937dm
 zT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703796308; x=1704401108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBQJzg8p67MT+cAHsjxUE3jbvJVSTss8oIknW148j+0=;
 b=ZWYzwUKCNkgdBmVihsBSOA4YJc6RPPe8Ylxwp5y6KPmJfmIiKahsTOj8O7P/P8larZ
 JBIdCC112YpFp1c9nY0Ohl0/HrM3DdvoC/oGNigrrygRYEjtFiRODLIBmUZ7eZz8sYz3
 /fwwpYa6ILqzR3+pkcQADa2wfTUYTajC8mrmzw3V+hycWvX3ROlBqfGrpmAv0sfqPgx2
 NgjaD26XmwR9GuM431wIe1TTXP0t8ekdi+6gfc3HDSvJOUya58pqt0L9IwoOt8uL+XgZ
 VXKPF0avinuwd0MC1sInEA8WLiaFMY6gNQbopLhVclhmvaRdYdfsVJ+vtsJyWRy5KnP9
 jJGQ==
X-Gm-Message-State: AOJu0YxzzmHQwunKoco4Jh/brYPEg//WmdkmpY5qQj91tGv2jYzj4/hs
 t40+91M9zmXM45Ft0fNMAWORc/HBp6IOWQ==
X-Google-Smtp-Source: AGHT+IEgal7HXdIBTU0nHxEqXF/BlUxZeGHEo/Tzyo+zAyz9iWGHs2ky+hmpTLcFY1yijHLxo3NDNg==
X-Received: by 2002:a05:6e02:180d:b0:35d:5995:798f with SMTP id
 a13-20020a056e02180d00b0035d5995798fmr18342382ilv.41.1703796307902; 
 Thu, 28 Dec 2023 12:45:07 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 w62-20020a638241000000b005cdf9c8e922sm11239680pgd.85.2023.12.28.12.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 12:45:07 -0800 (PST)
Message-ID: <1623ee93-f676-49a3-837e-0438eeaeb0bd@linaro.org>
Date: Fri, 29 Dec 2023 07:44:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/i386: use 8-bit OR or XOR for unsigned 8-bit
 immediates
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231228120524.70239-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231228120524.70239-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
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

At least once upon a time the partial register stall like this was quite slow.  IIRC there 
have been improvements in the last couple of generations, but it's still slower.

Data to show this is worthwhile?


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


