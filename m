Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9278425E
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRl1-0000kV-P1; Tue, 22 Aug 2023 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRl0-0000kG-1C
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:49:18 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRkx-00089D-N5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:49:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-525597d891fso5746571a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692712154; x=1693316954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2zx7mmYxs/GKR2bE2kJH4FYODToxIqrK/bwseHFpLPQ=;
 b=NHow5o8RwCKwF/SoHR6VkrjUPCLT/jvi3ZF+TSXdwxEZIyWu21krKlV9DunjkMvgLf
 CotQXsCCL51Zsk1wU/VhfAYv5Uzpx9qSfY1H+kWbt7yNs9psRe8QMelzsm1ZP8CauoeU
 uw6sM6BwIYhfRE2oCl5yHghZjuCN+qdseSb6CS1Q47Ib6LPf1TPbnZZ+VHwgwDuX0H8q
 odpjrvg1dMp3IZe7oHck+TpTk2LoJn8GwxD2jslYnBJHmwXJvGDJDBJUUAHqDNuUOgCs
 OV2WBdFJk/Q0ag0aP4cRfz6y7L/uw8geBccZnK209RAgLdqzFn41QzukRC6Gf0LSXxNh
 XcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692712154; x=1693316954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2zx7mmYxs/GKR2bE2kJH4FYODToxIqrK/bwseHFpLPQ=;
 b=dVpV9z9nt/VH9/hGYLuYHOQv4A60Xgo6eaBs/kDJV0Regn1FBc1a884UgVc+IwFFOj
 7/po9sIQQYkMM2UQ61FPmlU110ClJ1P//myre4MgmCOVIGu2odtrahvRnvBAyXq3F4dl
 mh7O/jfTI/s6X5RHCW3+rEMOORl/wQNMxnOtNIKU2o61zqC96v7lrGJ4790Gjykj+gY7
 aw0FUaDv0pp4GCwCX/GyNimiwimEmAIn1xqEDqqGqC84odjZyODfC8KqU8McyDv+9wWH
 Nx08pyJDHDrXUsUBnYxepcq2ol2fgMzvpeiXi1YeGXnvEvzg3TWi/3B9FC3CYEvRItfI
 gcbg==
X-Gm-Message-State: AOJu0YzWeu978ibUEPqMcJfwUHN70cEblaQYLIFkDkQzaJhHlRbZIeLn
 6UKA7IzWUROGrCSRJ2Dn2dW3qt8Flj7OV3HYc1yFuw==
X-Google-Smtp-Source: AGHT+IFDBRGyplK7ExN6lbXjBHLC5zm22tJ76azSCEatwT6A32/+pHllRI5R0E1DxiQYdEQ5yQ09aQ==
X-Received: by 2002:adf:f892:0:b0:314:1560:cc68 with SMTP id
 u18-20020adff892000000b003141560cc68mr7090152wrp.56.1692712133768; 
 Tue, 22 Aug 2023 06:48:53 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 f13-20020adff44d000000b003197efd1e7bsm15826494wrp.114.2023.08.22.06.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:48:53 -0700 (PDT)
Message-ID: <255f4589-7b8a-e323-7f66-ab3abecb7c2b@linaro.org>
Date: Tue, 22 Aug 2023 15:48:50 +0200
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
 <09dd2dc9-edc2-a9d2-e91a-a5eb07f96ca0@linaro.org>
 <CAFEAcA_k27aUdMZaONwVx-R4KvmPA_naUjF8DwuXMvVH2vfjYw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_k27aUdMZaONwVx-R4KvmPA_naUjF8DwuXMvVH2vfjYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 22/8/23 15:27, Peter Maydell wrote:
> On Tue, 22 Aug 2023 at 14:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 22/8/23 13:44, Peter Maydell wrote:
>>> On Tue, 22 Aug 2023 at 12:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
>>>> introduced the generic hswap_i32(). Use it instead of open-coding
>>>> it as t_gen_swapw().
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    target/cris/translate.c         | 14 +-------------
>>>>    target/cris/translate_v10.c.inc |  2 +-
>>>>    2 files changed, 2 insertions(+), 14 deletions(-)
>>
>>
>>>> diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
>>>> index b7b0517982..0ff15769ec 100644
>>>> --- a/target/cris/translate_v10.c.inc
>>>> +++ b/target/cris/translate_v10.c.inc
>>>> @@ -506,7 +506,7 @@ static void dec10_reg_swap(DisasContext *dc)
>>>>        if (dc->dst & 8)
>>>>            tcg_gen_not_tl(t0, t0);
>>>>        if (dc->dst & 4)
>>>> -        t_gen_swapw(t0, t0);
>>>> +        tcg_gen_hswap_i32(t0, t0);
>>>
>>> Both these are operating on TCGv, not TCGv_i32, so I think this
>>> should be tcg_gen_hswap_tl(). (Compare the tcg_gen_not_tl()
>>> calls.)
>>
>> You are correct, if someone copies part of this code to a new
>> function compiled for a 64-bit target, this won't build.
>>
>> We know cris is a 32-bit only target.
>>
>> When implementing tcg_gen_foo_tl(), should we implement both
>> corresponding tcg_gen_foo_i32/i64() even if one is never used
>> (thus not tested)?
>>
>> I like completeness, but I'm a bit reluctant to commit unused
>> code (mostly for maintenance burden).
>>
>> Maybe I can go mid-way and only add tcg_gen_hswap_tl() ->
>> tcg_gen_hswap_i32() here. If tcg_gen_hswap_tl() were used on
>> a 64-bit target then we'd get a build failure. Does that
>> sound reasonable?
> 
> We already have tcg_gen_hswap_tl (it's a #define like all the
> _tl symbols), so I'm just asking that you use it rather than
> the _i32 version. If we were writing the cris target code
> from scratch these days we'd probably write it to use _i32
> throughout, but since it's not written that way I think
> it's better to continue the pattern rather than deviate
> from it.

Doh I missed commit 46be8425ff also added tcg_gen_hswap_tl()...

Thanks!

Phil.


