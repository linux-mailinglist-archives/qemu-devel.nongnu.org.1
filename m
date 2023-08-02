Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09B76D85B
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 22:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRI4b-0000ON-OZ; Wed, 02 Aug 2023 16:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRI4a-0000Mj-02
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:03:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRI4Y-00078Z-6c
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:03:55 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-267fc1d776eso77417a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691006632; x=1691611432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ofeM7SXhq/6L0y9Hve19kFbB8kPHlMknF8eYKIZbmgE=;
 b=oC/doiWUALLo1ccB0TiXPvNaNkdS1G2oTmY3hvGlZZhOaQlDr2BZNFAumZHZpDxWOP
 0t7dLZNezig+YbzWb+upPuc6Xir2qaf0YQ3xPCQUxSMbH4niJdcpIbOaY/9/Ac3TISbI
 DHl8vu4izfg7KxCF4BJ34LqLppSu2nBuW+3pEkUMST52lhjepZkYj2Py/W87bIAUtHER
 Qi7GdR7hl/oVWnCyZtsmxd3zoVHspr3jD1BjYmh19ikoHTyVllXgxtrDKWs6P6F9btT0
 tX+/TTqjagL0XzMo07c0Wr+Y+SRhIuWre06Dh8NoYmtkKJ23PgQcdtUoXnwprmbFdTI0
 aOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691006632; x=1691611432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ofeM7SXhq/6L0y9Hve19kFbB8kPHlMknF8eYKIZbmgE=;
 b=NkjMXu55kXvJOr4kJLNHFPv3aj2MRdQj4YVfahWx9Ojm6QmPX/2WFXy0NjDMTCMGRe
 6SEYLOzTRdNxWMPUa/h5TPJ2a8MGDhu3EXUxcAAeWkogkk4ZoVvScfMc6Z7mSFL2jsmK
 6OEK8rHM5/8e+sU3lQ29TeVYjqvTd5uAOwqhfcMENnY4aBKx/isjfWlyvxMryAySvUVU
 utq0uqiNdHq0SrRpVPPLTTyDsH5DbjQCc511bHbS74iXvorr43KP/GtMOeXjvoEHurXi
 Kkoy/J5kALdoZQaQ/KsOH1C8S+rExIX3YMGdJkVsCPUJM3bSDLvihwit/Wwn8SVr+4aI
 vtfA==
X-Gm-Message-State: ABy/qLYxqVo+lzFfWkMiyx7SLwutkzitmogXK2/W2oBbj4Ta6YizCbkm
 Fj7gy61papW+qqbEBawvzBqZcQ==
X-Google-Smtp-Source: APBJJlGSREArEXe+J1/n1Yjz9S/HjrbP+HRviBDOWmzX28biJK15X4JzOx5LHi33f4fs+TtGXnWE9Q==
X-Received: by 2002:a17:90a:c296:b0:263:4685:f9a5 with SMTP id
 f22-20020a17090ac29600b002634685f9a5mr15151327pjt.8.1691006632499; 
 Wed, 02 Aug 2023 13:03:52 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 ft13-20020a17090b0f8d00b002630c9d78aasm1437637pjb.5.2023.08.02.13.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 13:03:52 -0700 (PDT)
Message-ID: <9ce286f0-acac-da39-c765-5e784217e91e@linaro.org>
Date: Wed, 2 Aug 2023 13:03:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Wrong unpacked structure for epoll_event on qemu-or1k
 (openrisc user-space)
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Luca Bonissi <qemu@bonslack.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <750c569e-a922-d3bb-1f97-1698960d5b05@bonslack.org>
 <CAFEAcA9vkyO_kivpSGV7jPW+DCbSD1BNA+SsLixViamXRi61CQ@mail.gmail.com>
 <fa561a63-991a-329e-d9f2-5b334d94516b@bonslack.org>
 <29cd5218-a9be-1947-e075-b892023213e8@vivier.eu>
 <38f8621c-98e7-53c4-ac1b-7ff4c569ed18@bonslack.org>
 <f5fac2cd-04ee-f12d-fcf7-cd443016c957@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f5fac2cd-04ee-f12d-fcf7-cd443016c957@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/2/23 12:55, Thomas Huth wrote:
> On 19/07/2023 14.38, Luca Bonissi wrote:
>> On 19/07/23 10:49, Laurent Vivier wrote:
>>>
>>> According to linux/glibc sourced, epoll is only packed for x86_64.
>>
>> And, in recent glibc, also for i386, even it seems not necessary: even if the 
>> __alignof__(long long) is 8, structures like epoll_event are only 12 bytes, maybe 
>> "packed" for historical reasons. Ancient i386 gcc[s] (<3.0.0) have 4 bytes for 
>> __alignof__(long long).
>>
>>> Perhaps the default alignment of long is not correctly defined in qemu for openrisc?
>>
>> __alignof__(long long):
>> - 8 bytes: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa, x86
>> - 4 bytes: microblaze, nios2, or1k, sh4
>> - 2 bytes: m68k
>> - 1 byte : cris
>>
>> offsetof(struct epoll_event,data):
>> - 8: all 64 bit targets + arm, hppa, mips, ppc, sparc, xtensa
>> - 4: cris, m68k, microblaze, nios2, or1k, sh4, x86
>>
>> So, epoll_event is "naturally" packed on the following targets (checked in linux-user 
>> container and/or with cross-compiler):
>> - cris, m68k, microblaze, nios2, or1k, sh4, x86 (32bit)
>>
>>> See include/exec/user/abitypes.h to update the value.
>>
>> OK, abitypes.h should be updated with the following patch (discard the previous patch on 
>> syscall_defs.h):
>>
>> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
>> ---
>>
>> diff -up a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
>> --- a/include/exec/user/abitypes.h    2023-03-27 15:41:42.511916232 +0200
>> +++ b/include/exec/user/abitypes.h    2023-07-19 12:09:03.001687788 +0200
>> @@ -15,7 +15,15 @@
>>   #define ABI_LLONG_ALIGNMENT 2
>>   #endif
>>
>> +#ifdef TARGET_CRIS
>> +#define ABI_SHORT_ALIGNMENT 1
>> +#define ABI_INT_ALIGNMENT 1
>> +#define ABI_LONG_ALIGNMENT 1
>> +#define ABI_LLONG_ALIGNMENT 1
>> +#endif
>> +
>> -#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
>> +#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4) || \
>> +    defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) || defined(TARGET_MICROBLAZE)
>>   #define ABI_LLONG_ALIGNMENT 4
>>   #endif
> 
> Hi! Thanks for the patch - but could you please send this as a new patch mail with a 
> proper subject and patch description, so that it could be applied with "git am" ? Thanks!

The patch should be against master, because microblaze and nios2 are already fixed.


r~


