Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDD7728D7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1uv-0007TG-CC; Mon, 07 Aug 2023 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT1ut-0007T3-3a
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:13:07 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT1ur-0001Dr-Lb
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:13:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6873a30d02eso2970925b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691421184; x=1692025984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CijsUzyJer1o6s3GPCrUqEQRxih7oH7IeTdAKaSmapg=;
 b=m+03eOOYtSBNxsk3w6EenHPr9bQe3ifTPOmdhvfnrwrUZYPxRZPCV/2T63Q0+/TIhD
 /TyCLRQm5bzDfm1miIJMszf2P4Xf8IB4sqwkJoJuFX5aqqOElQUdmkoBBSoGyxwlWdz7
 JVaJlkZQqjf5rSwIoR4uPdzoh9U7CaoCeSro/kyHAj1w1dwtPn8iV8jtvairhhKE+T4E
 rp70NFEgX9vhqwPxtHV9AbLDyWqcvSg+BSN+qG0cFldL+HeUPAF3aiZXS5bYR/6V3oAr
 sKqIXhhD7tbVTM1pC2on4tjNQFuRF0/OA+DPkAqJuXdu0Yw6xJ9lwuyATBOdlrRr4Lqi
 KZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691421184; x=1692025984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CijsUzyJer1o6s3GPCrUqEQRxih7oH7IeTdAKaSmapg=;
 b=hY0+RZTmddV3AEFOHNOX29OxIIM/ERaZjbF44KS6qVc43OP1gbDw7J4vwREKRIDeTl
 pj5o09ChTZpulzxOf+l/R0uVZs5qiygZg9FFt8bzicAnb51iVw8yqshgIVpHh20YLpui
 t8jwV5ij2/y7CPhxm9iTgZT4ZT/VB3BEfzTVPPcbDB1L7rAdoOx3oezoZgZPc0+ql0Bv
 Bgre7bQJRkn//wQgGy0DaawZvejB6lOToFs0AV/yXFdAGW56q5n/Ro3rTpIeXwfMaBOG
 qmrUgaOWiH2pgs235Cz5nqMP727MfH+EJdSQ/5M8reTqjRuuxgc2TTH/lWQna0i7VMcf
 xXkw==
X-Gm-Message-State: AOJu0YzK4OZ+j49J871H97JHgjWXy1eLrRTGj+4rNeH3XnUwlf9OjwFH
 /NtiFLosbn39wNHgiaDTRqGkZA==
X-Google-Smtp-Source: AGHT+IFIa2/aprZZsAKmpvYOwql4zC05eUbMG2TkWHkiQOS7ZiR/SmgeyiLFcgZyc/CvdrAbKWYHGg==
X-Received: by 2002:a05:6a00:21d0:b0:681:6169:e403 with SMTP id
 t16-20020a056a0021d000b006816169e403mr8728541pfj.8.1691421183707; 
 Mon, 07 Aug 2023 08:13:03 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 x8-20020aa79188000000b0068743cab196sm6292292pfa.186.2023.08.07.08.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:13:03 -0700 (PDT)
Message-ID: <ddc0fa77-0d44-58a0-86a0-6f2343c0fade@linaro.org>
Date: Mon, 7 Aug 2023 08:13:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/6] target/loongarch: Add loongarch32 mode for
 loongarch64-softmmu
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-2-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:45, Jiajie Chen wrote:
> This commit adds loongarch32 mode to loongarch64-softmmu.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index fa371ca8ba..43c73e6363 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -272,9 +272,16 @@ struct LoongArchTLB {
>   };
>   typedef struct LoongArchTLB LoongArchTLB;
>   
> +/* Current LoongArch mode */
> +typedef enum LoongArchMode {
> +    LA32 = 0,
> +    LA64 = 1,
> +} LoongArchMode;
> +
>   typedef struct CPUArchState {
>       uint64_t gpr[32];
>       uint64_t pc;
> +    LoongArchMode mode;

This is not how the hardware works.
This data is stored in CPUCFG.1.ARCH.


r~

