Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AC7CC535
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:53:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskVG-0001kx-Sj; Tue, 17 Oct 2023 09:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskVE-0001g6-9M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:52:56 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qskVB-0006SV-VD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:52:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5aa7fdd1420so2392494a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697550772; x=1698155572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+gqpkmoNzA55+A6FkhRYnMzX7Zzs2XCMmSJs/H0RNU=;
 b=f4qFUys7Yc7OLVuh4vp28Sv21eo0v8fj7qmnATaVH0ioEhyUJL+OcgmubcJk1BGmMO
 8MQ/vMmic3aVestukfBKq+A0Uum1/LiU7ODqhnhoplYs6vag7rgmUKdOnLqjBdvK5TKL
 9SjcC0Ahh7u7K5WjqOdFtwF2CtNuJw2gu6TYlH28gX8ubiHlxleIrBPolMmrn9xZ+iRU
 RV7yJyXqkFsT4zxyYDpfV1hrc+7skiusEFh7Xly9yXx+/GDd8lZi3txyoxVE85bjqkP6
 uByz95NylFqdgKkGk20C/MH/ukR8rTokjBO4fvBGvI0ccjwC63osoNE5dyUqOw8rL2Rq
 H25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550772; x=1698155572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+gqpkmoNzA55+A6FkhRYnMzX7Zzs2XCMmSJs/H0RNU=;
 b=LoB3IdIsYKhYMWlMRGTHP2e/Suuk0NqofWRrdt6egt3m75NzTH+nK3wYoJkgBMjdUx
 dLu0iSeOaReyUTZpFbO9NQ1pPHX4jKqA6E3cRXi53Xc3wmok4tQKm+Dp4mAHdgF8YuuM
 acylxcJWl7Oo6zpdMr0WYS7XEgASl79eC0d7pVN+zbvjJKPX5Qsa7j1sJsneURt5xIr4
 +m3Zjw5FdflUg4sXO15QYAYAE8RzeTMAsvS/7EDn1hyJ9ffREM9LQbA3C7nDuin+wTAL
 UartBPAGcrhV/CTcAjAiMdrGNBuCgT3aOQ5FtE67tY80AuYJ9GnSx19ecnpTON1W/tJv
 4XQQ==
X-Gm-Message-State: AOJu0YxKytQ0SB5HqgwWwwVOvw0x/0vuRa0MeoV9ZxsjJEEGJqDD+tkG
 ne5SdhjZwYNPgICn+KtHR7dr8Umh+6JRCaSF68g=
X-Google-Smtp-Source: AGHT+IETujFsI0ujl/ReAozzo2gzSRHaAO1/aJ1kpG5HXddFeMWXrS3yrreVXT0Dik7vSCIZQM0VPw==
X-Received: by 2002:a05:6a20:7492:b0:158:1387:6a95 with SMTP id
 p18-20020a056a20749200b0015813876a95mr2184255pzd.19.1697550772621; 
 Tue, 17 Oct 2023 06:52:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a17090322ca00b001c5f77e23a8sm1554995plg.73.2023.10.17.06.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:52:52 -0700 (PDT)
Message-ID: <8c85fc54-3933-4330-a378-c1b444b0771f@linaro.org>
Date: Tue, 17 Oct 2023 06:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/m68k: Use i128 for 128-bit load/store in
 m68k_copy_line()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20231017122702.39311-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231017122702.39311-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/17/23 05:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231013175109.124308-1-richard.henderson@linaro.org>
>    tcg: Add tcg_gen_{ld,st}_i128
> 
> RFC because unsure and untested...
> ---
>   target/m68k/translate.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 4d0110de95..1e3d155bd9 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -4293,23 +4293,17 @@ DISAS_INSN(chk2)
>   
>   static void m68k_copy_line(TCGv dst, TCGv src, int index)
>   {
> +    MemOp mop = MO_128 | MO_TE;
> +    TCGv_i128 t = tcg_temp_new_i128();
>       TCGv addr;
> -    TCGv_i64 t0, t1;
>   
>       addr = tcg_temp_new();
>   
> -    t0 = tcg_temp_new_i64();
> -    t1 = tcg_temp_new_i64();
> -
>       tcg_gen_andi_i32(addr, src, ~15);
> -    tcg_gen_qemu_ld_i64(t0, addr, index, MO_TEUQ);
> -    tcg_gen_addi_i32(addr, addr, 8);
> -    tcg_gen_qemu_ld_i64(t1, addr, index, MO_TEUQ);
> +    tcg_gen_qemu_ld_i128(t, addr, index, mop);
>   
>       tcg_gen_andi_i32(addr, dst, ~15);
> -    tcg_gen_qemu_st_i64(t0, addr, index, MO_TEUQ);
> -    tcg_gen_addi_i32(addr, addr, 8);
> -    tcg_gen_qemu_st_i64(t1, addr, index, MO_TEUQ);
> +    tcg_gen_st_i128(t, addr, index);

Aside from the typo, the other thing you need to consider when introducing 16-byte 
operations is the atomicity.  Do you want or need this to be atomic?

For m68k, I strongly suspect that we don't need the entire read or write to be atomic.

The manual says "burst reads and writes" without defining those terms.  I suspect that 
MO_ATOM_NONE is sufficient, but MO_ATOM_IFALIGN_PAIR would preserve the atomicity of the 
current code.


r~


