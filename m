Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A307E5FE6
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:19:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pwI-0006UG-Ej; Wed, 08 Nov 2023 16:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pwG-0006U8-Fu
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:18:16 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pwE-0001mi-2X
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:18:16 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso155778e87.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 13:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699478292; x=1700083092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SpVt77XOaITVfrZ5G2w5L7Gj4gphmLK9T/4LL8lJTY0=;
 b=BPE2T75I0hSiTQFiFgFxjJhXj2Z0z9QJ6JSXEBiasrkyyoy7LQK5mb98nphKz8Claf
 e9n1SPoWam837Eu0ELlzXY+AXVgSCub79wIpx5ecc62F/lE3wHH0hLzJm9diEU/krESZ
 14mhv3d6INonO9iSJ8Ph9rlQH4X6mOutxqH2g0x/sjGjU0iAhmnfNn6CzWOFPWsEYOqV
 FHgxL2V7lV47Isg1uYSfo5Zs4kPmFl+sZXCUmB7pSkSBfrWL3Oir4M/JADjo4e9SVeZ2
 d1c/j0zM65C2N26lEEDPQlTZgN72gfKD6TuQxpnOUEGaGOLWt4gsQUuySydOCHp1A4EW
 z1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699478292; x=1700083092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SpVt77XOaITVfrZ5G2w5L7Gj4gphmLK9T/4LL8lJTY0=;
 b=l6ycU0GmrB4WskkepCOxPXTHCYkJ+mYcsVvOekzLQPOZSVslkQCbltOW2Fl0x2LwiF
 wj8fyYrucdWJPp6UltyPNvQMXOJ76TwH6Wcj0FcE0opHl1sjVtadTjaVYxawwNyBD+dF
 Y6ODAdN0uQVU+NVI3o7exyzVSGhcsh2arnVOpv0xz2dC321CxTRQYL0MHDMx6KEGlHms
 klXAc4b7AiYsdMHv4lFO8TL7aTbg9pgexFODj9w+TmBN6KJjRri5n6I5sk/M2etebKJt
 WUcXIUBylly+q1hYc9YhGJzdXs4A822uF/gbg+p0CIh1A47yt+/tEEpAleHye9jnuble
 EISQ==
X-Gm-Message-State: AOJu0Yx4h2V4O2giNWD02XCningU16U+1Ulu94h5aH7IlKn/jHQS9O8w
 vvfyfqn50vmnL/E0n8I9eblfpg==
X-Google-Smtp-Source: AGHT+IHBrui8AIgsJj33GptnoAnv2j295XnOYNmyLDUQQXeQqYsGnPJrSzz3fxcQc3nh8k0y8HwWdg==
X-Received: by 2002:a05:6512:6d3:b0:509:494d:c3d2 with SMTP id
 u19-20020a05651206d300b00509494dc3d2mr2644553lff.32.1699478291859; 
 Wed, 08 Nov 2023 13:18:11 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 q26-20020a50c35a000000b00536031525e5sm7293544edb.91.2023.11.08.13.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 13:18:11 -0800 (PST)
Message-ID: <e8c242c8-471d-4375-86f1-60c23c64369c@linaro.org>
Date: Wed, 8 Nov 2023 22:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/sparc: Fix RETURN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231108204739.279972-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108204739.279972-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 8/11/23 21:47, Richard Henderson wrote:
> Perform window restore before pc update. Required in order
> to recognize any window underflow trap with the current pc.
> 
> Fixes: 86b82fe021f4 ("target/sparc: Move JMPL, RETT, RETURN to decodetree")
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 6fc333a6b8..9387299559 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -4096,12 +4096,12 @@ TRANS(RETT, 32, do_add_special, a, do_rett)
>   static bool do_return(DisasContext *dc, int rd, TCGv src)
>   {
>       gen_check_align(dc, src, 3);
> +    gen_helper_restore(tcg_env);
>   
>       gen_mov_pc_npc(dc);
>       tcg_gen_mov_tl(cpu_npc, src);
>       gen_address_mask(dc, cpu_npc);
>   
> -    gen_helper_restore(tcg_env);

Ahah! I noticed that earlier in a late review, wondered why you moved
that gen_helper_restore() call after updating $nPC, but my SPARC is now
rusty so I was sure I was missing something. Too shy to ask :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       dc->npc = DYNAMIC_PC_LOOKUP;
>       return true;
>   }


