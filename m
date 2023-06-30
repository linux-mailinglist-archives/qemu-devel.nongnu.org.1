Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADF7434BF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7KT-0006vd-ON; Fri, 30 Jun 2023 02:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qF7KR-0006vF-3Z
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:09:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qF7KP-0003KZ-82
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:09:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76aaso2254145e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688105395; x=1690697395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lZKlzJ4ffFV7iEmBcslgp3jfMAQPxklQ3uo9LCDweiU=;
 b=ToBXrS7IxEX0jGf84sNNaKH9ShcRLCyfkmceeCow3YMn0aZ6rBJhOrqZvc9P54yKjO
 PVuauC5SfrBKq/P/qA0xVH4ephtZaTCD+rgCy3Y6o1w8rurS3vJoghvtXzHwzC6BVphz
 OJ/g0A4fRay/UYHjmeD+ACm2O1bnEKq0470EGrLP7nSLbv+L85hhdHlke5RhpOa6SKG9
 FsUGZA0dVpuv2y1zwNBEwfj+FpB0BbxbmJAfuVq9Yq5KSoL/NGLk1eYpl33+I2iaPvFt
 +50rX0K9Q4FzVDp8V3r5dNbZT0SXM/el58BryiauqwLfznhBVEk+fpm4d1q1bgvQcOdR
 o4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688105395; x=1690697395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZKlzJ4ffFV7iEmBcslgp3jfMAQPxklQ3uo9LCDweiU=;
 b=gurXehf0+iemXg1KcZP2vTgLRYTpin6iv8nSjAm3yjPs8Am4JYdc8lP2+9y16TN/RY
 5RWzmJ5CbpGz6QYoEQ6GojB5dUFUIF+DznDU+/7eE2AGsbnGDwJPJhQ1eB7lCRoMMS5l
 CGE9R4BnUVyBMo4iTJBD3TwRaoYMhpMReNNmgZ7fbY+Jrv9NrWBk5L4Hhno4BIav+xZ0
 gbyE20ahsKpzd8/iwu5IX+TKaiiCWjX7IyFZzsPelmpg1dqGu+gx7Sz6YTPneaBfL9T8
 K62zmz9XrarPiFZ84hqNhdfyoB+3kG+YPI8mNt1MloiGFyrQNByPbkpSGCCR719ZxPxu
 3fRQ==
X-Gm-Message-State: AC+VfDwVTVvrcwJwKBlU/bLFx35WcStxhdIALn2fikPivyrvcsI/iN0m
 Lhcb3uYkkkbNAmvIXBEhA1WSiQ==
X-Google-Smtp-Source: ACHHUZ79hI4vBUI0rl2RxziGtiGA0ag8cNaNlfb12ZHhE/DrqZLhszEJ5ephJIi+OKvNUULJ0+RXQA==
X-Received: by 2002:a05:600c:2253:b0:3fb:a5b3:4f02 with SMTP id
 a19-20020a05600c225300b003fba5b34f02mr1088319wmm.36.1688105395564; 
 Thu, 29 Jun 2023 23:09:55 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm21070184wmb.40.2023.06.29.23.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 23:09:55 -0700 (PDT)
Message-ID: <d66e6001-63d1-7307-66a8-4c48e11741ce@linaro.org>
Date: Fri, 30 Jun 2023 08:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gitlab: Disable plugins for cross-i386-tci
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230629130844.151453-1-richard.henderson@linaro.org>
 <d09e7410-6bf9-e15b-5759-e111f60e9f19@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d09e7410-6bf9-e15b-5759-e111f60e9f19@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/29/23 17:06, Thomas Huth wrote:
> On 29/06/2023 15.08, Richard Henderson wrote:
>> There are timeouts in the cross-i386-tci job that are related to plugins.
>> Restrict this job to basic TCI testing.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> E.g. most recent failure(s),
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4565517825
>> 4488: make[1]: *** [Makefile:189: run-plugin-memory-with-libbb.so] Error 124
>> 4497: make[1]: *** [Makefile:189: run-plugin-memory-with-libempty.so] Error 124
>> 4506: make[1]: *** [Makefile:189: run-plugin-memory-with-libinsn.so] Error 124
>> 4550: make[1]: *** [Makefile:189: run-plugin-memory-with-libmem.so] Error 124
>> 4558: make[1]: *** [Makefile:189: run-plugin-memory-with-libsyscall.so] Error 124
>>
>> We do tci+plugin testing with an x86_64 job, so I don't think it's
>> important that we cover plugins here.  Mostly we want to make sure
>> that TCI *builds* on a 32-bit host.
>>
>> Anyway, here's a pass with shared infrastructure,
>> https://gitlab.com/rth7680/qemu/-/jobs/4565547513
>>
>> There might well be different timings on the project k8s hosts.
>>
>>
>> r~
>>
>> ---
>>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
>> index 1e0e6c7f2c..b6ec99ecd1 100644
>> --- a/.gitlab-ci.d/crossbuilds.yml
>> +++ b/.gitlab-ci.d/crossbuilds.yml
>> @@ -57,7 +57,7 @@ cross-i386-tci:
>>     variables:
>>       IMAGE: fedora-i386-cross
>>       ACCEL: tcg-interpreter
>> -    EXTRA_CONFIGURE_OPTS: 
>> --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user
>> +    EXTRA_CONFIGURE_OPTS: 
>> --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
>>       MAKE_CHECK_ARGS: check check-tcg
>>   cross-mipsel-system:
> 
> FWIW,
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> I assume you'll apply this directly as a CI fix?

Yes.  Now done.


r~


