Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D9722F34
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6FWi-0008JE-CH; Mon, 05 Jun 2023 15:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6FWb-0008Ip-5o
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:05:53 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6FWZ-0001rt-Ha
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:05:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-53f7bef98b7so4595904a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685991950; x=1688583950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qr9gdu60sgawXVa2lHv59tLBopPqLJMgpEnT0jxcE+E=;
 b=ozbNo+SOh+5+5kfaOIzD795xm9QaKzVtSEq+2WIe1Q6cn59ggxYOrlz5WkBwg7tksD
 sCqyuhwcaV233LJXzSS/roR1SjYzz+2HfA2us726181iC3kPIfiG78qwXi6VQ1nKxUaO
 niz1oGv+Yn7piz1KSsMR7NBAPngVX8CX/RLH0LPtqAQwIagc/P9zT02N4Tq1wdFnfnED
 DbDqlNw/gTkInPXplXr+YD000+etpoOaLzNxj9vJ5WGQlRt1AoMIVrSpXaH4poJqAs30
 GMtt4ObtzeE+fPSUx/aRDA+3vSR4mzosAp8fPZ/jseka6XxmYpt2rs2KouKbhPpiobMi
 5ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685991950; x=1688583950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qr9gdu60sgawXVa2lHv59tLBopPqLJMgpEnT0jxcE+E=;
 b=Uf54xcbmgYAEe2wzny52MB7VnQmU9gc1f+a8lSkZt0q+1KUm0WTl8fAKaPcSoer7oZ
 Ps9sK8b9+Oag8XVPPGXDgyA0cb79IpZoWDF0HenZBawQsEdQ/MtuxYQI9XB4AJsszMT7
 SS/CBVEA3a4SZMWAr61amY7WPxTXf4s4Tv20RDxmjt72L6ebX4ydJaRyX7hBExmHzcc/
 v6/8HE3SPWEMfeeL73kl8Ow0z4vPveFdc2Jp5P+XUdXKu52SXnww9p38b3cUzxY1ieKQ
 yqIlrhU1w0sKJjtW9wVR3jnSxP3vo/3UV5n9nV+cP5UPFiWjFGhbzT4aJLM7bYq6WvLx
 8U1Q==
X-Gm-Message-State: AC+VfDztt68iX1JNkwOkA8pHYrvITXNhiaeBBmev/99RAtREBt/RQGfx
 +g6PxmdF3tcjPkg4N2hAdi1ImUYhjmOYbKFTLpI=
X-Google-Smtp-Source: ACHHUZ4Qx8n/3tE1XsEnUyg1qwEoszkjpelenVWnFK4GIBeOx3HFDAW+PmOYVSZ7PPqHLHrIOzq5fQ==
X-Received: by 2002:a05:6a20:3d22:b0:10c:524e:a442 with SMTP id
 y34-20020a056a203d2200b0010c524ea442mr8340385pzi.25.1685991949820; 
 Mon, 05 Jun 2023 12:05:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 h19-20020aa786d3000000b0063b675f01a5sm5713933pfo.11.2023.06.05.12.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:05:49 -0700 (PDT)
Message-ID: <4619033e-1178-327d-9a62-f85c62aa8cb4@linaro.org>
Date: Mon, 5 Jun 2023 12:05:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/sh4: Emit insn_start for each insn in gUSA region
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
References: <20230603165530.1189588-1-richard.henderson@linaro.org>
 <6068e086-6596-a236-ce76-77b49d2caea5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6068e086-6596-a236-ce76-77b49d2caea5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/5/23 08:01, Philippe Mathieu-Daudé wrote:
> On 3/6/23 18:55, Richard Henderson wrote:
>> Fixes an assert in tcg_gen_code that we don't accidentally
>> eliminate an insn_start during optimization.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Test case is tests/tcg/multiarch/testthread.c; the assert for
>> equality is new with
>>
>> https://lore.kernel.org/qemu-devel/20230531040330.8950-26-richard.henderson@linaro.org/
>>
>>
>> r~
>> ---
>>   target/sh4/translate.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

queued to tcg-next.

r~

