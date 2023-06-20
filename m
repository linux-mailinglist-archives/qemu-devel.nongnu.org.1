Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CC7364D1
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVtb-0000cP-Hq; Tue, 20 Jun 2023 03:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVtK-0000a1-O2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:35:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVtG-00015Q-Gc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:35:06 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso510349466b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687246495; x=1689838495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xN94Poz986YoqV8mAwwk+tgACOj5wxmAgpq2OTlPDyg=;
 b=RKkPqEHDH/sxS1LqTIkGKW89E1xd4SvHLwylBOR7H7VxmZLK2EVDM+NCeHX5qpDU7j
 rnOKImZ7aXskIQAatJB8F4BudXbE5rSlJx/TQPCLskyDc168BeBW9KbL4EtROaTau1KZ
 0QPtO+EZmR7NBNbhz5Aed9O8VXSCSSyQQiMAND+ADStp5GzfoIBd3rt1cXzqYtL0HTsW
 b80AFHM/eRevp1am3wnZ7hfAgi+bUbSOeih+FMnrXCT6gc1jEMjlKwWpVelYNJuQlvEW
 lq5CiihkdcuI40VuphkXKzNH0SZ3laSpToNJmd5RgsK9OoOplxkY/hm1OtJ7Ytzr6iay
 udbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687246495; x=1689838495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xN94Poz986YoqV8mAwwk+tgACOj5wxmAgpq2OTlPDyg=;
 b=lSlvNL6ivC+PwhXz2gUVSgqfFNRNEToxjg+lvtDB3F5LL6hNDC9d3pm0oB1Ay+kRs8
 R28OJzSaAjTcDHv3pscMDPNgJzq5/pqoC9s+kDQNxnqrP1Yf+oZHK/yuiSIHrZr+x+M4
 QhNg97B59aWW4tU5WXcIbob4KQM1UqmagZAqHuwXsGutRRuLhbi9xKqrDEtVyiHBDrgr
 LzHmRvC8yRhkWDdlSB43eaS1vTYK14k3Lgn3sNggkbZ1EmTxtzmk6RJkO0mwi1G/z+a9
 yTHhRubpdwv6rm74owIIReY8llKshQdmS7u/PjCrKbV7fgX2PtzWeMRYyjIMHXrCsClT
 tmGA==
X-Gm-Message-State: AC+VfDyYwOsoMckFvKeKUUTG9ioB3v/h4RJuieSb2Y/FWCkmXlnA9sOI
 eQomTJxhg8QPTWvAwoZuvLa8cA==
X-Google-Smtp-Source: ACHHUZ46cCzQY31xzlXxuNDiRRRhNJuIDacOp3brFCfilRWfNEkMbyqfU5MGHPOD9mp9Fh7qcMKldg==
X-Received: by 2002:a17:907:944c:b0:953:834d:899b with SMTP id
 dl12-20020a170907944c00b00953834d899bmr15750148ejc.29.1687246494769; 
 Tue, 20 Jun 2023 00:34:54 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a170906481700b00987258cf1f7sm844238ejq.154.2023.06.20.00.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 00:34:54 -0700 (PDT)
Message-ID: <d0641e1a-4461-71b1-c108-d226e1885906@linaro.org>
Date: Tue, 20 Jun 2023 09:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230610171959.928544-1-richard.henderson@linaro.org>
 <87ttvee4tf.fsf@linaro.org> <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
 <1199d248-8aee-4e93-95cd-ad8847ed2255@linaro.org> <87mt0vjqxi.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87mt0vjqxi.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 6/19/23 19:34, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 6/12/23 04:50, Richard Henderson wrote:
>>> On 6/11/23 02:14, Alex Bennée wrote:
>>>>
>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>
>>>>> This is a perfectly natural occurrence for x86 "rep movb",
>>>>> where the "rep" prefix forms a counted loop of the one insn.
>>>>>
>>>>> During the tests/tcg/multiarch/memory test, this logging is
>>>>> triggered over 350000 times.  Within the context of cross-i386-tci
>>>>> build, which is already slow by nature, the logging is sufficient
>>>>> to push the test into timeout.
>>>>
>>>> How does this get triggered because I added these:
>>>>
>>>> # non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
>>>> run-plugin-%-with-libinsn.so:
>>>>      $(call run-test, $@, \
>>>>        $(QEMU) -monitor none -display none \
>>>>            -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
>>>>                     -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
>>>>                -d plugin -D $*-with-libinsn.so.pout \
>>>>            $(QEMU_OPTS) $*)
>>>>
>>>> to prevent the callback versions from being called for x86. The original
>>>> intent of the check was to detect failures due to cpu_io_recompile, see
>>>> e025d799af (tests/plugin: expand insn test to detect duplicate instructions)
>>> I have no idea how, but it's happening.
>>>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> ---
>>>>> Irritatingly, it doesn't timeout locally, so I used staging to double-check:
>>>>>
>>>>> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
>>>>> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
>>> Note that in the pass case, we don't even log that the test ran.
>>
>> Any further thoughts on this?  Otherwise I'll merge it to get rid of
>> the cross-i386-tci failure...
>>
>>
>> r~
> 
> I'm happy to drop the feature from the plugin but the clean-up also
> needs to be applied to the run-plugin-%-with-libinsn.so: rules for i386
> and x86_64.

Pardon?  I don't know what you mean wrt changing the makefile.


r~

