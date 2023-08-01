Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86076B5BC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpLz-0000wd-Q9; Tue, 01 Aug 2023 09:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpLy-0000wV-QS
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:23:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpLx-0005V3-6D
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:23:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso52193265e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690896235; x=1691501035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPIo81mAT5oT0Nih6AHDW0cgsYR1ogCHDnh6OKn5pzo=;
 b=S0V9OEOHeNC2LPFhBwKwgxTKsv92AxZi7Wqp5L2c3uexjp93RAQqx9h3HobxWsuMB4
 FAPnKbIFKtUKxf+kglCrNMHDCd2kBVGmeCB3x+JL/3N/QAxZrem3+3CugcesdGt3++8p
 5xNAZ8akrxt8i95xFc3D1wb+1LHMUSGmwDbKCQLjsLNzf3hrmrfzMXI93YvjuYgJFqHt
 5RIiY2Xn+wFyxH9ZATnEz/oP5fXKAlmkdYuJ1yLuDYkFkm6ugAh1Vj9a0wKi6getNlPC
 ueMdYsMlXZs9ewLXEFl4v0Rj770c+vh/Wn6shXVgOH96qQSVww81pEJrb9SSDjylbISu
 nQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690896235; x=1691501035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPIo81mAT5oT0Nih6AHDW0cgsYR1ogCHDnh6OKn5pzo=;
 b=cq0cFTv36HWJ8VQYjtGJ5C27Gdsc55JMcC3IF8TDwnTqSJlRwRMZ9UOIpaxG5a3BDQ
 QQcCpqNVL0vLjV1dJq8sIjL0MGCh3SVS7QwV2CZAr7zFwZqr+qzopsfVJutiDkHDA+vD
 kISr2QXgxydy9OqnhYzn7hCsUHsfcuS2TjPszFH7er2VCk00KbjfB5G87hVfTA6wdCSZ
 sNxmXvQwEtDNaHUg16XWhobFvzt6zZvgwDqqgF8BXhkd+OaQRP227XUyTQlTYbE2z5ZZ
 uCEmBJJBDbnlMeFmvX6KqdsyRqD4wNVpUfJYE0zVltwWXwg2Axb0ciBR0f/h5kloYb2e
 7N7w==
X-Gm-Message-State: ABy/qLbtxqwP/E1swwotroKHlMXsxukHjikz7xoauMwiHDAQtYAd5eTn
 lnuWo8sxS0jNiym66bhEX1bYpQ==
X-Google-Smtp-Source: APBJJlEKCvM/JM4ltCnz9uaIKZog6D0qAT+Cp6uvBQP0JR9EdrOXYfLpftUeraDHEgQggeQhQXGotg==
X-Received: by 2002:a05:600c:22da:b0:3fc:e00:5282 with SMTP id
 26-20020a05600c22da00b003fc0e005282mr2385368wmg.0.1690896234836; 
 Tue, 01 Aug 2023 06:23:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfec88000000b0031773a8e5c4sm16072375wrn.37.2023.08.01.06.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 06:23:54 -0700 (PDT)
Message-ID: <d5fac15f-3ab9-42d4-ad39-95c500c4417a@linaro.org>
Date: Tue, 1 Aug 2023 15:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/nios2: Fix semihost lseek offset computation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
References: <20230731235245.295513-1-keithp@keithp.com>
 <CAFEAcA8Q_qjJV55v0M4LwuK-2tuM4DaBVsmP5vAVogt8Hq98vg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8Q_qjJV55v0M4LwuK-2tuM4DaBVsmP5vAVogt8Hq98vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 14:06, Peter Maydell wrote:
> On Tue, 1 Aug 2023 at 00:53, Keith Packard via <qemu-devel@nongnu.org> wrote:
>>
>> The arguments for deposit64 are (value, start, length, fieldval); this
>> appears to have thought they were (value, fieldval, start,
>> length). Reorder the parameters to match the actual function.
>>
>> Signed-off-by: Keith Packard <keithp@keithp.com>
>> ---
>>   target/nios2/nios2-semi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
>> index ffd1f095f6..fc1df1dfeb 100644
>> --- a/target/nios2/nios2-semi.c
>> +++ b/target/nios2/nios2-semi.c
>> @@ -170,7 +170,7 @@ void do_nios2_semihosting(CPUNios2State *env)
>>           GET_ARG64(2);
>>           GET_ARG64(3);
>>           semihost_sys_lseek(cs, nios2_semi_u64_cb, arg0,
>> -                           deposit64(arg2, arg1, 32, 32), arg3);
>> +                           deposit64(arg2, 32, 32, arg1), arg3);
>>           break;
>>
>>       case HOSTED_RENAME:
> 
> Fixes: d1e23cbaa403b2d ("target/nios2: Use semihosting/syscalls.h")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Commit 950272506d ("target/m68k: Use semihosting/syscalls.h") has the
same issue.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


