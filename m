Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56678483A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUt1-0005HY-B3; Tue, 22 Aug 2023 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUsq-0005FU-Tn
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:09:39 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUso-0003yi-DW
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:09:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a3e943762so2450331b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692724172; x=1693328972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVQ1pMXFPuIB8HiaNBzhQ9EaswKbgf5p8mTnIZnNsmc=;
 b=GzTu1xc2dNbsbYBc95SH1tMhxjIKSeD7dIYObxm/dQ0U+I6Sgs7Upx+aQIgj7VNBOx
 kmXRWqaG+jBrGPmPpfhnOgVgLWYWLH+arEDfMo8UtQry/fSwVlqcYIJoIIU0UwPR3arj
 +7PFsPiDS5NG7USBbVb9o3WiJHd2+sbW3VUtYX2+bRKQpl9Zc9aRz1oYB48wnJ52lBJG
 DjmLNCgvRTm/GjlXYdqFjdgAj6R0l6xtZQqnaPEf3ygRcdP8C8y/PJh3pjniA4Bv+EHd
 gdAUCizsvMOia1tTKgJHWEy45tAWkSSe3i3ETyhj3xpSE1GBdB1frIC52IPIokXcf9hU
 L1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724172; x=1693328972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVQ1pMXFPuIB8HiaNBzhQ9EaswKbgf5p8mTnIZnNsmc=;
 b=AQo+tcJh1hcyeL+81qbJ3Bfpucao8bhLf+zuSK6Bss4da1iVr637pwpbJSuRUT8dlP
 DTqoizY5GaPOa+gNiJClyuz3eIAfD1N+veyCb1R+TJFKJRDrKv0bT5GlSLLIL3R6S9Ec
 asbSVeqRbP5eTJgE+R5GJ1s3hfqhPw8UrBy6ZT5IltcQXvjG6LGszvrlmjPq+DGyrWx3
 cyN3A+nuDV7QFak5k+Hy+ZIrGFQyA6Pcb1XKm9WZXmEbcCY0BBX/Qhfr0T/Gy6+GX88N
 KSY/KrhSYOnqaexre62oMp1qLihSmPegI08P5hMTJWftxdvZhXW9Z5ZeEpK6KmPIIIka
 R3sw==
X-Gm-Message-State: AOJu0YyVTjnGb+DvttneUPZDlEqInweIC3Gj22Hblosqkb4mJni5UA52
 KyC2jzcOiReq/HlRmDPQEjWEYA==
X-Google-Smtp-Source: AGHT+IHknYPXl9qI1L8n78aHGbo2zVbvqbAdXXZNoJrDJs6RHyEQ2opYZdjLYzQ1gRMsBOKhSiZljQ==
X-Received: by 2002:a05:6a20:1585:b0:136:e26b:6401 with SMTP id
 h5-20020a056a20158500b00136e26b6401mr13830082pzj.16.1692724172526; 
 Tue, 22 Aug 2023 10:09:32 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm4652269pfd.38.2023.08.22.10.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:09:32 -0700 (PDT)
Message-ID: <50ec5299-6c01-aa68-14d7-86ab9351cbc5@linaro.org>
Date: Tue, 22 Aug 2023 10:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] target/loongarch: Sign-extend REVB.2H result
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20230822164750.72497-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822164750.72497-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 09:47, Philippe Mathieu-Daudé wrote:
> Per [*]:
> 
>    The REVB.2H instruction performs [...] and write the 32-bit
>    intermediate result sign extended to the general register 'rd'.
> 
> Add the missing sign extension.
> 
> [*] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_revb_2h4h2wd
> 
> Fixes: ad08cb3f97 ("target/loongarch: Add fixed point bit instruction translation")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Totally untested, only noticed during code review.
> ---
>   target/loongarch/insn_trans/trans_bit.c.inc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
> index 25b4d7858b..a98c46d8cb 100644
> --- a/target/loongarch/insn_trans/trans_bit.c.inc
> +++ b/target/loongarch/insn_trans/trans_bit.c.inc
> @@ -121,7 +121,8 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
>       tcg_gen_and_tl(t0, t0, mask);
>       tcg_gen_and_tl(t1, src1, mask);
>       tcg_gen_shli_tl(t1, t1, 8);
> -    tcg_gen_or_tl(dest, t0, t1);
> +    tcg_gen_or_tl(t0, t0, t1);
> +    tcg_gen_ext32s_tl(dest, t0);
>   }

Nack.  This is handled via EXT_SIGN in

TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)



r~


