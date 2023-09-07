Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C8797803
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeI0p-0006NS-Bv; Thu, 07 Sep 2023 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeI0n-0006MV-Lo
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:37:45 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeI0l-0008NC-GV
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:37:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-573e67cc6eeso885735a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694104661; x=1694709461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/yekGlmmff8OPwX3D/FPVoCuYu7ovjrpojKTkbkGj4=;
 b=JVnjbtn4AH70FjHWw8Y/D9+11ugJuktDbNiZCDHg7b1ZopFmkjV7c/KFLD6DnXdgXB
 /EZxK/kOHzxeghPhRTrImramonUf490dK0uWfX5FiyThN6bg0vfbDqmNE2V+DUOFLpVZ
 O/mR66U9+MIFP5HwMEtvD6Q8wD/Ydj5m3joonz53ZLDhJLPY4TsRi6qQV+Az6peewjT7
 dq41yU0Jp7hbtTeVDm5RWJbUAK1bB6lOU3xegw72mHx8dzBtRmihy00RdX96I3SrKjLD
 NRe2O8+f04MSrwJycyOUTjf55SotQshk1uvYFxVh8kc5uAirTSIQdzSQstWvje8MWQWB
 UpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694104661; x=1694709461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/yekGlmmff8OPwX3D/FPVoCuYu7ovjrpojKTkbkGj4=;
 b=quOvdKdNBqXxoR6V7XUrMr0KrzGimHFVn5BfVY9r2MWtI7P5NnEoC1GWnt5gtCvgV7
 m5bT6+yiosi34aqvCbTPvB3OMboN2NI7cv0iljKLY7OJmeus44mP5K5P5uKCgg5bB0OR
 5LBnddorCooMv0hzNhtZOZv/VoezjUIC8cgQ+0Xp85op7sJM6rWzz1HnnTMfRnCD+v7a
 x3QrFa9xLi9eQ7aTGqt25YyBf2CR6J2jBaqlVl+Tu3Vi9+1tzBjOaErky7bord5Ge1BQ
 7XAPYmKZ4NYakN5bcZr5urQdxleVYEbPSkymBk7Y8VokIMlRG5u0J6bB1XxRyo1/BKk0
 l/nw==
X-Gm-Message-State: AOJu0YwsfyHpBn9Ku2oBg6EIxQ/9Ag1c85CwdNT8M3EkDTDXuZfKcVFy
 YYgwqbObCaFq/3T/myNwTDA0Qv6WkSCeqKPUjeE=
X-Google-Smtp-Source: AGHT+IHNoz7PqFdicnqwj8O0L0VtW6EvCyTsQ+97HeYGApovD9RKDdFM23PRqGXt6B9nB7Lw0zqx0g==
X-Received: by 2002:a05:6a21:789c:b0:135:110c:c6e1 with SMTP id
 bf28-20020a056a21789c00b00135110cc6e1mr309221pzc.7.1694104661603; 
 Thu, 07 Sep 2023 09:37:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c1-20020aa78801000000b006877ec47f82sm12540551pfo.66.2023.09.07.09.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 09:37:41 -0700 (PDT)
Message-ID: <f89b124e-c881-8a9d-1ace-845fcf4d7957@linaro.org>
Date: Thu, 7 Sep 2023 09:37:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 01/57] target/loongarch: Renamed lsx*.c to vec*
 .c
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-2-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
> Renamed lsx_helper.c to vec_helper.c and trans_lsx.c.inc to trans_vec.c.inc
> So LASX can used them.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/translate.c                                    | 2 +-
>   target/loongarch/{lsx_helper.c => vec_helper.c}                 | 2 +-
>   .../loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc}   | 2 +-
>   target/loongarch/meson.build                                    | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>   rename target/loongarch/{lsx_helper.c => vec_helper.c} (99%)
>   rename target/loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc} (99%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

