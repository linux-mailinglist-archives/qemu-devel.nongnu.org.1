Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A479AC09
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfpNp-0006Uh-Hg; Mon, 11 Sep 2023 18:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfpNn-0006UU-6P
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:27:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfpNk-0003JD-5R
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:27:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so10793235ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694471265; x=1695076065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3yxz6fBxv5W5iYEh5kN6JRdUW7q5qR6xKRPmkoh4zqg=;
 b=NhaqwxixLU+LMTQsS/J9S1BMlHPuK62tUpy+6/A0U3vwF36AgSECNH9RGXRXN8WWPJ
 p8U4Zijh+NjHppZJZ0YebjVzuOxegYka+KBFnMCmC/OGK/fw7Ay3B1BtZIGx4PHgoCb3
 wERZcnMBZtL9Yyrtk/EBJBdC0gwECK3GYhtYy9OAIpz4FyZ4pQD8BTs4tvND5TaaxMBX
 UvlvgTrhOMUguqhgGEVAV0VGgKiDkkoHF5OQJwj8RjxkerwyJVjMS7dq3ajEAaFRJCmS
 DwULOEHCRGj/CujqDQj7n3kzzhfY8D6VSry8kBknrJaxKKOgRLhrbyVQ0ur9fOf81mYh
 vu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694471265; x=1695076065;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3yxz6fBxv5W5iYEh5kN6JRdUW7q5qR6xKRPmkoh4zqg=;
 b=rne9VLn5DdTKSk5pKss//MthQO6zP0pWp/PGBCQMSbDjzbpCqOOb0xuMsjX4Aj/gwT
 /DXXszPPU7/kL+xYFey6MKlSBFaQTvCfPzfS2GWcHcck//tDvC/eFhhvv6Mc/TNJIEb8
 FCGnZdkjHJnL47iWjIHVhRnpUoBZUDDICW5plHpPiJgMO1wTM+f8nVY2M88OslNutGEd
 a6xm/Kyt9/bAskxdiZQcKmMTBBPvElEQQKNu6e+tTWTN1oJfNkjeFNnOZAvF7bZX2wLm
 MSjLMse84MeIfAHzeqfy9SiCoSdI9WRr/mveMMt9TIVfTedALYHUL3O4WGw5wyvAG/h8
 8mXA==
X-Gm-Message-State: AOJu0YyXd23EnnM0n5U06cPL1nvo7ZhVVg8ipm2sBzN0UOPCDhZxesUW
 aLEms7MLMrfpDv48nCFAz43o5w==
X-Google-Smtp-Source: AGHT+IFUQphCLpwaJIh16daq9Vm5FewdqFpCIO+I0yLdfGDuxBVea/FtbSzJadlsaWMNUInXzTCI+w==
X-Received: by 2002:a17:902:ce81:b0:1bb:a125:f831 with SMTP id
 f1-20020a170902ce8100b001bba125f831mr11991718plg.58.1694471265418; 
 Mon, 11 Sep 2023 15:27:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jd13-20020a170903260d00b001c3bc7b8816sm2130810plb.284.2023.09.11.15.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 15:27:44 -0700 (PDT)
Message-ID: <2b3210ad-a8ca-5efd-d6a2-7639e6e5ad7a@linaro.org>
Date: Mon, 11 Sep 2023 15:27:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 51/57] target/loongarch: Implement xvinsgr2vr
 xvpickve2gr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-52-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-52-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> +static bool trans_xvinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
> +{
> +    if (!avail_LASX(ctx)) {
> +        return false;
> +    }
> +    return trans_vinsgr2vr_w(ctx, a);
> +}

Using the other translator doesn't help.

> static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
> {
>     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
> 
>     if (!avail_LSX(ctx)) {
>         return false;
>     }
> 
>     CHECK_SXE;

This portion doesn't apply, and you miss the check_vec for the larger LASX.

>     tcg_gen_st32_i64(src, cpu_env,
>                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
>     return true;
> }

The only thing that is left is this one line, so I'm not sure it's worth splitting out a 
common helper function.


r~

