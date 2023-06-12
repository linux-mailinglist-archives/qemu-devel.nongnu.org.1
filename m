Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E816172B57A
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 04:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Xdn-0003AT-Ao; Sun, 11 Jun 2023 22:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8Xdk-00039o-5C
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 22:50:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8Xdh-0001ea-2m
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 22:50:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7bso27143025e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 19:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686538239; x=1689130239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BEyQH+NFfC/dy7TubVU0uIXRa76l7FxIbM3xjsde0y0=;
 b=vLLvjExpj+buvuygUG2a5zzBx4rursfhBZc1MjRwuPqRbPIsdGD+U+pag3lHIsAYyy
 f3+S8t+GKRpRHcnk1MFjnOP8QUh3b+H/0/fIHa2dnKt32ecP4IqbUPdanfvCgcRztFR8
 JXk/txJl+LF5GpX7qYBWNU5XP4BX6NuQnGospHleAnR6lwDUhQayT6iUF/yIxLGEA62e
 a3wNlgf9cisXdZHA6nRe1zYUN4SpNJJOvJTo46YgemFNZOE4BsswJiqkDK6Lq2HYYsz+
 CsiPX8KpdFVg4R2J4yctzApCv4o6QPiaWC3GBkozS3/LZZPq1BzFxr6bLLE0s1N8Dz3u
 iopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686538239; x=1689130239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BEyQH+NFfC/dy7TubVU0uIXRa76l7FxIbM3xjsde0y0=;
 b=kRAmWa9D0nYYq1hI1oCp44b04HKM3vzcPDC0w2vaAxGaaxrLZXDvMUl5eHJ1oli03I
 tDTZhY/11uVfoHGAwN4fA7LVBYc4O9KLqn64lecI8sD4N3EwCc6oINDYrY1UkdCKvZmX
 GBl9P2/UmQn8TjvLvvzmBr9SiLfVcmFfC7TWDf0KDsTfnCSNqH4B5HCsqF5Rt+A/MhA0
 uyMAo4mkO9rWDPDYb3lU2T+mUxApaJPvh+lBL2b2mJRBbtVD8iIPJQySsItP1cLM7jfv
 kdQTZ7kh+Ca7UEcJ+fCrLkOwSgJ20bS+0SEl602z1QjvUoAoS0hoBOuRuCVbhazF+5iH
 V/+g==
X-Gm-Message-State: AC+VfDyA/Q6JtOABBPVhPsnCb8Hg1X7LKZCZ51mGM6gA5Bby+/eU0WY/
 o5uXUVRvfu3sif47Q3DwGQOXIQ==
X-Google-Smtp-Source: ACHHUZ4pQd38dHSp6jF3bRFfsq5Nsi/qzxQFSKtnZuI6dAcnEwhMev+koQEB+1JqCz1G83f4TavRow==
X-Received: by 2002:a7b:ce08:0:b0:3f8:11ec:7c0a with SMTP id
 m8-20020a7bce08000000b003f811ec7c0amr3387988wmc.23.1686538239001; 
 Sun, 11 Jun 2023 19:50:39 -0700 (PDT)
Received: from [192.168.85.227] (212-186-246-242.static.upcbusiness.at.
 [212.186.246.242]) by smtp.gmail.com with ESMTPSA id
 v5-20020a05600c214500b003f819faff24sm2631590wml.40.2023.06.11.19.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jun 2023 19:50:38 -0700 (PDT)
Message-ID: <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
Date: Sun, 11 Jun 2023 19:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230610171959.928544-1-richard.henderson@linaro.org>
 <87ttvee4tf.fsf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ttvee4tf.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/11/23 02:14, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> This is a perfectly natural occurrence for x86 "rep movb",
>> where the "rep" prefix forms a counted loop of the one insn.
>>
>> During the tests/tcg/multiarch/memory test, this logging is
>> triggered over 350000 times.  Within the context of cross-i386-tci
>> build, which is already slow by nature, the logging is sufficient
>> to push the test into timeout.
> 
> How does this get triggered because I added these:
> 
> # non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
> run-plugin-%-with-libinsn.so:
> 	$(call run-test, $@, \
> 	  $(QEMU) -monitor none -display none \
> 		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
>                    -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
> 	    	  -d plugin -D $*-with-libinsn.so.pout \
> 		  $(QEMU_OPTS) $*)
> 
> to prevent the callback versions from being called for x86. The original
> intent of the check was to detect failures due to cpu_io_recompile, see
> e025d799af (tests/plugin: expand insn test to detect duplicate instructions)

I have no idea how, but it's happening.


>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Irritatingly, it doesn't timeout locally, so I used staging to double-check:
>>
>> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
>> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108

Note that in the pass case, we don't even log that the test ran.


r~

