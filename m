Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB3784191
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:08:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYR60-0004JS-Rb; Tue, 22 Aug 2023 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYR5x-0004Ib-GG
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:06:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYR5v-0006Rj-2a
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:06:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb727cso43129575e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692709608; x=1693314408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUAENzJoVoQMmt0ZYd0xs5nFH+urfTe7izwNzCDht5k=;
 b=qMZwPciSOvk9D1vnliHtwAnaDRR9E1GR5bbX1+7aecQQd3PEOaRgUw/0l8BKY0olFo
 Qh0qwKGTqUqd9FUIUuP0xCqFIcldxcOMA65qzTpfpt73dropKh9TS4F+DDwy6flle/eg
 5xzlmkdm4uPSrKyq/ECUNb/bOVGCyk8mhM0Yg2XoEaYv6cBmPOYXwF1pkdqyl80dmJ5u
 FrrfBrR/XtjZnJrWzfdOyBF4jePAIxZWC5fjZ6F9mxXAKEKThBoNZFwWCg7JiH69GdIh
 USyhHGdG0XAO44r3vzPd0dI8omBcziOiRPKMhmutxiu9GotV1YvVKqeslMbf8EROwkfy
 4l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692709608; x=1693314408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUAENzJoVoQMmt0ZYd0xs5nFH+urfTe7izwNzCDht5k=;
 b=h54RpCnoXAYDFkBC5R7fIP/FsFgmCKum1HYSnSU0jPxBTSyTbymsvKH1SOamIjlJNw
 16Q7tX7eVJHGAFcgpBotRrB6QZrZHHmjQwT4LqLrnvJmtWc8Qp2o0HTibkrxj0o9+kpf
 F9r5AnlSObCYdOvJvOYBjCGIeX9tmyC6FjFwWi3wdPxVQhuUSrhI9dQ21ECMJB0kEph5
 KFQgkibj7xZFBQpADRBHLygBwQzLqGmmS0+slpNyxI9DHpe1rVPoWiFZc0b0x28s0KXR
 XjVUD+ztKVPsv99gk9TLn8I0Ap5u4DbaIw6mfK91ujLR5SWsMdZ69zuv/zjEQ9J5xWeB
 Tg/A==
X-Gm-Message-State: AOJu0YwlLsejWLd7j+QcpnJymgE/ADv3qVeJGVKpB5pA4RCoSqbHiW7Y
 pl2Aqz7hHqFLWLaKuGw2p8rjIw==
X-Google-Smtp-Source: AGHT+IF/rCp2TLJf6IHLjlvgLc7MRy6eM/Gfsx4DsNIo/+AVRkTc88M2G5lVnqmNkTKgQ4JJJGY02g==
X-Received: by 2002:a7b:cd14:0:b0:3fe:22a9:910 with SMTP id
 f20-20020a7bcd14000000b003fe22a90910mr7765512wmj.14.1692709608626; 
 Tue, 22 Aug 2023 06:06:48 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 g10-20020a7bc4ca000000b003fe29f6b61bsm15694943wmk.46.2023.08.22.06.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:06:48 -0700 (PDT)
Message-ID: <09dd2dc9-edc2-a9d2-e91a-a5eb07f96ca0@linaro.org>
Date: Tue, 22 Aug 2023 15:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/6] target/cris: Use hswap_i32() in SWAPW opcode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-3-philmd@linaro.org>
 <CAFEAcA-36XE-9ikSp0F4EMUKysz=ms2JyLCc8GOWcgJq3sb=hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-36XE-9ikSp0F4EMUKysz=ms2JyLCc8GOWcgJq3sb=hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/8/23 13:44, Peter Maydell wrote:
> On Tue, 22 Aug 2023 at 12:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
>> introduced the generic hswap_i32(). Use it instead of open-coding
>> it as t_gen_swapw().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/cris/translate.c         | 14 +-------------
>>   target/cris/translate_v10.c.inc |  2 +-
>>   2 files changed, 2 insertions(+), 14 deletions(-)


>> diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
>> index b7b0517982..0ff15769ec 100644
>> --- a/target/cris/translate_v10.c.inc
>> +++ b/target/cris/translate_v10.c.inc
>> @@ -506,7 +506,7 @@ static void dec10_reg_swap(DisasContext *dc)
>>       if (dc->dst & 8)
>>           tcg_gen_not_tl(t0, t0);
>>       if (dc->dst & 4)
>> -        t_gen_swapw(t0, t0);
>> +        tcg_gen_hswap_i32(t0, t0);
> 
> Both these are operating on TCGv, not TCGv_i32, so I think this
> should be tcg_gen_hswap_tl(). (Compare the tcg_gen_not_tl()
> calls.)

You are correct, if someone copies part of this code to a new
function compiled for a 64-bit target, this won't build.

We know cris is a 32-bit only target.

When implementing tcg_gen_foo_tl(), should we implement both
corresponding tcg_gen_foo_i32/i64() even if one is never used
(thus not tested)?

I like completeness, but I'm a bit reluctant to commit unused
code (mostly for maintenance burden).

Maybe I can go mid-way and only add tcg_gen_hswap_tl() ->
tcg_gen_hswap_i32() here. If tcg_gen_hswap_tl() were used on
a 64-bit target then we'd get a build failure. Does that
sound reasonable?

Thanks,

Phil.

