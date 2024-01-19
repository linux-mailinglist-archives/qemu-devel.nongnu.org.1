Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27477833082
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:55:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwpV-0006O6-Mr; Fri, 19 Jan 2024 16:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwpI-0006L7-Gm
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:55:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwpG-0005oC-PZ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:55:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e884de7b9so15517065e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705701297; x=1706306097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ENtX6X2Rrk+pPMxvQVq/kQ/7LFJE8pXTiGKyoYQlBQ=;
 b=ApQfexGOriX6J2L5cJdwJaVa/g4c7tk3P+IJPIAVP0vPXzXoJnDRUc8gycqtvZFFzR
 ftyASGDODP3Xa7vTBy0TC5hJqa3jIypVsz86JtgBRKbmHxrdrVr1etkSzhm+i+bCevO0
 U9u5rljkw7y3funh8gCtP0szeBNrknTPoxYBYaKPp+ZSlMkTiWjNULtwyTggLvPVeaTr
 3k4YucylKLlSjwobO6SM1fjd83rczcVw1+NTCRIJSyGgS4U4U4Tl6ixGNLr18vi7krXo
 6EMuHBLgvDMh/YGz6ERoFj5o7jCVjJJ4PP+XiOdi3Z2CT4N8vLFubaxFr77LtLXAo/A+
 0n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705701297; x=1706306097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ENtX6X2Rrk+pPMxvQVq/kQ/7LFJE8pXTiGKyoYQlBQ=;
 b=rVIvhcHT1dxHbQoUFVd7LLjuQ0hHI93r2zZ9kjf3XfkD7GUZDLDCwnWP7dgr9KdUDV
 e4zWYr8YDuS9nV+1XAcxfm22+e2VGgnsI9QSYLb+DDyw8CiVlLv5JvJHtHpJ0373SRdu
 vzmFIHr1MTKRhlGlW1xpPqeQeflyL3MdJXXhars1JaN1Jty+/PixtIKUimX4ti3nwqQ3
 vBv/B+bLeBbdqpbIdHqaYbB5In3QugcOr4B6j4/H4yMd+x18r9GKKtBK55eK4bMTsPYs
 41kO1EHTV6sku+zoXbUzkVeNKHysOiYjzF8LXRScaq7DnjzO4DrgN36fbz3TC6cTPQLo
 xabQ==
X-Gm-Message-State: AOJu0YzjnJeuPbfLHK07SE4IA5gYIwQrErfvs9bc2JfMeNQBBwTyp/Hq
 NsUM8WF/W/PUIHuA11FRt4Kv9dyLTt6FUfLJEN2XoG373EIxm3n8nev4t50dFqw=
X-Google-Smtp-Source: AGHT+IFpNR+gXx7j4xjS+OeHZNmmUmul5u/PDNZdp6MLeyN5xnDVs44BFIKh4fHCfbI8VAYPWXamkw==
X-Received: by 2002:a05:600c:3396:b0:40e:4d66:d282 with SMTP id
 o22-20020a05600c339600b0040e4d66d282mr228868wmp.164.1705701297260; 
 Fri, 19 Jan 2024 13:54:57 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a05600c1c1500b0040e9f7308f4sm2749617wms.10.2024.01.19.13.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 13:54:56 -0800 (PST)
Message-ID: <78531ef8-127c-42da-8d32-6944ed2ad8f7@linaro.org>
Date: Fri, 19 Jan 2024 22:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, david@redhat.com,
 mjt@tls.msk.ru, qemu-stable@nongnu.org
References: <20240117213646.159697-1-richard.henderson@linaro.org>
 <20240117213646.159697-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117213646.159697-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 17/1/24 22:36, Richard Henderson wrote:
> While the format names the second vector register 'v3',
> it is still in the second position (bits 12-15) and
> the argument to RXB must match.
> 
> Example error:
>   -   e7 00 00 10 2a 33       verllf  %v16,%v0,16
>   +   e7 00 00 10 2c 33       verllf  %v16,%v16,16
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 22cb37b4172 ("tcg/s390x: Implement vector shift operations")
> Fixes: 79cada8693d ("tcg/s390x: Implement tcg_out_dup*_vec")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index fbee43d3b0..7f6b84aa2c 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -683,7 +683,7 @@ static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
>       tcg_debug_assert(is_vector_reg(v3));
>       tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
>       tcg_out16(s, i2);
> -    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
> +    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));

🎩 Chapeau.

