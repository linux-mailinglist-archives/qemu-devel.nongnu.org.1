Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4C735B1F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBGnf-0006QA-PM; Mon, 19 Jun 2023 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBGnd-0006Po-LD
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:28:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBGnb-0005Ih-P5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:28:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f8ff5fe50aso19244665e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687188489; x=1689780489;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qumMv/rjFVKNnUcZJpYCxFOqg9uHsAkhQwc1iYJc0/w=;
 b=iV3lc1oLAa7oPByNDFO1XgCjnIpbjgivF/WT1mMRjbzbt09mJvVOBgQoHELl0mZ8qx
 gT6g0/noMubFFF3kAjmLF47UuIhvDI1yOUFPYX5WakHOu9im/vIvcv/4vFBIjx6jZgxN
 wdLO+9fyFIaBgUOIVDLdo5Yc3rv866Mt2c0sa7PtpX76q0TZAq9aonVQv3SGskyXHuYY
 +DGzMYmZwtNNIGnpDfYXetNGWf/zYJke1G4xihj7oCv2ZiqU4UHtEYWezn7UeaLqXqcI
 SMURXr8j5N6wKLOIHVvUA9MSV6SVnEgzAuKTnI/xU2BJU/SyOMizpyjF6+6ZQMAVa33d
 +erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687188489; x=1689780489;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qumMv/rjFVKNnUcZJpYCxFOqg9uHsAkhQwc1iYJc0/w=;
 b=cgfdhtwHbncgzs4rrn+KdWG0pyZDu9kotJGzo9HH8B+r9XF7cTUFaxhBYlILiVM+/t
 Y0aIu/SbkYKPkWE4jNJ1lW98Dg+NDuNJRTW8Zc7f2wiYgWfomLwjbf/lKvSc1WMVH9nb
 Qx8lbY0CSDKLR9uf1dEl+XOMQxhH0jd9zOfTPrrYjLCPxJcffmzDBcOWK+CPJnxb39ud
 fVBOKV9BNuWaj9E1tsIuxmO7imbMOBrigiyDhMyhiIozX1zGWyeqfsYf1uYqrw11SMGF
 iAIs18zfF3oocLY5kznJiTrjQnunn+/adJbghtrgFPqIjATuara/Fsnh4ZDnDGmi2U7V
 E0Ww==
X-Gm-Message-State: AC+VfDzZSQTBgskqUqHuAwSsbTCc9IL2mQuoKoSNKMGO2dnpQZCpCZav
 GOI/uaN4xYtgWVsPam2bnCgCOg==
X-Google-Smtp-Source: ACHHUZ42rCv5MsAB47PBiGY0ejtElcFUlR3mqbqW4qKSlM1FdggukGylEIKNiO1wgbjn9ex5oq+Gpg==
X-Received: by 2002:a05:600c:3b97:b0:3f9:b535:381a with SMTP id
 n23-20020a05600c3b9700b003f9b535381amr563287wms.10.1687188489116; 
 Mon, 19 Jun 2023 08:28:09 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 p3-20020a1c7403000000b003f8d80ecc5asm11101939wmc.12.2023.06.19.08.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 08:28:08 -0700 (PDT)
Message-ID: <1199d248-8aee-4e93-95cd-ad8847ed2255@linaro.org>
Date: Mon, 19 Jun 2023 17:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230610171959.928544-1-richard.henderson@linaro.org>
 <87ttvee4tf.fsf@linaro.org> <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
Content-Language: en-US
In-Reply-To: <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 6/12/23 04:50, Richard Henderson wrote:
> On 6/11/23 02:14, Alex Bennée wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> This is a perfectly natural occurrence for x86 "rep movb",
>>> where the "rep" prefix forms a counted loop of the one insn.
>>>
>>> During the tests/tcg/multiarch/memory test, this logging is
>>> triggered over 350000 times.  Within the context of cross-i386-tci
>>> build, which is already slow by nature, the logging is sufficient
>>> to push the test into timeout.
>>
>> How does this get triggered because I added these:
>>
>> # non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
>> run-plugin-%-with-libinsn.so:
>>     $(call run-test, $@, \
>>       $(QEMU) -monitor none -display none \
>>           -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
>>                    -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
>>               -d plugin -D $*-with-libinsn.so.pout \
>>           $(QEMU_OPTS) $*)
>>
>> to prevent the callback versions from being called for x86. The original
>> intent of the check was to detect failures due to cpu_io_recompile, see
>> e025d799af (tests/plugin: expand insn test to detect duplicate instructions)
> 
> I have no idea how, but it's happening.
> 
> 
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> Irritatingly, it doesn't timeout locally, so I used staging to double-check:
>>>
>>> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
>>> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
> 
> Note that in the pass case, we don't even log that the test ran.

Any further thoughts on this?  Otherwise I'll merge it to get rid of the cross-i386-tci 
failure...


r~


