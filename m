Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1617A31A6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 19:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhYvT-0001Vn-FX; Sat, 16 Sep 2023 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYvS-0001VK-5u
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:17:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYvQ-0001EU-Kb
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:17:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-577fb90bbebso2210127a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694884663; x=1695489463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GFX+4MUrtMyFfoysHq0o8ja8syqSW5ztv9bkn8/4BjU=;
 b=ruiRA4Bhw2KFYCi314sAz7vXnbPhdSwVSHpSAFUbveCbfea6QvqJ1hkM7Bg7sb71FT
 rrg0Ml+sxdONaNuUn8hVWyH12OxajECgQTdp9S2OdHoLLPwLfJmKscndi0kSSwx1ed0d
 KIUuMAhpSyFN26QlmezUg8CJ7D+i7JyWHr2NSid05VxxuU7xm42c0U/iYC6UsFsRIWQD
 EPJUKRgsPw9RwRCkOM0kDGTOFvq/sGCTacz8wqcBOPDaKwojDSOZz8+32eGgBS7KrJCL
 qvD4ilOF62VaQ2TlSJcnCw9cd/J+N2R03GunmVhkemHknlcuDKfz0T28T1pIrb6ypynQ
 1r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694884663; x=1695489463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFX+4MUrtMyFfoysHq0o8ja8syqSW5ztv9bkn8/4BjU=;
 b=FkBzuIMGGY9CYHfXKtFL8BaYPTVS8Qc+ha1UvjReMjS5XRPgsX2j0AXRYcmfE3kUHa
 nx9G+ivAx+HKxLLrdjDj+ZXFINHZuPUtCj9JktRsTtshO9jqSQcpjVvGCpS+mr4RwzKA
 P9FHpIIfLqzzyHL7zQccU9NE9zqzFRBdo93yi1xRpB6x6wRK58mlurO1WeQNjZQA69mT
 0KW+xv/zhA1agwssKjBpsKN47aephPpQHbmP2XiFKavi+5Fy3E9HZjCnaBfsvp6jXAZk
 uCFbrUu+ouJ61seyf4uqi1eYd9xOhoXjRFXWZZBev4n4TwlZalMVlKsvby3Q3pex5SP2
 IGxg==
X-Gm-Message-State: AOJu0YzVFWqz/P1CyqUV2a41Khh9SoAUbM2HGQXR22gcb1kC1UdUrYTa
 1AO/Lxr8t7molV16GfN9AuY/4w==
X-Google-Smtp-Source: AGHT+IE5bh6dPIhfLMiadredeuTH4Cv9TmaVrpdxEzN0iemn4jCjU+l5NG1UOXpCPlfySllZWFwOuw==
X-Received: by 2002:a05:6a21:8185:b0:14c:def0:db07 with SMTP id
 pd5-20020a056a21818500b0014cdef0db07mr4043990pzb.34.1694884663064; 
 Sat, 16 Sep 2023 10:17:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a17090301c100b001bbbbda70ccsm5477334plh.158.2023.09.16.10.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Sep 2023 10:17:42 -0700 (PDT)
Message-ID: <1e41b01a-2f34-5ff5-c2b2-025d061731de@linaro.org>
Date: Sat, 16 Sep 2023 10:17:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/hppa: lock both words of function descriptor
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Mikulas Patocka <mpatocka@redhat.com>,
 John David Anglin <dave.anglin@bell.net>
Cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
References: <87bd9251-5d6a-11f5-9a28-78224a776742@redhat.com>
 <953ee56d-173a-aaf2-c7fc-34386f285340@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <953ee56d-173a-aaf2-c7fc-34386f285340@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/16/23 09:18, Helge Deller wrote:
> On 9/16/23 15:52, Mikulas Patocka wrote:
>> The code in setup_rt_frame reads two words at haddr, but locks only one.
>> This patch fixes it to lock both.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>
>> ---
>>   linux-user/hppa/signal.c |    5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> Index: qemu/linux-user/hppa/signal.c
>> ===================================================================
>> --- qemu.orig/linux-user/hppa/signal.c
>> +++ qemu/linux-user/hppa/signal.c
>> @@ -149,12 +149,11 @@ void setup_rt_frame(int sig, struct targ
>>           target_ulong *fdesc, dest;
>>
>>           haddr &= -4;
>> -        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
>> +        if (!(fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1)))
>>               goto give_sigsegv;
>> -        }
> 
> Patch is Ok, but I think the qemu coding style is to keep the { } braces, even
> if they are unnecessary (as in this case).

Coding style also separates the assignment from the if condition.


r~

> 
> Acked-by: Helge Deller <deller@gmx.de>
> 
>>           __get_user(dest, fdesc);
>>           __get_user(env->gr[19], fdesc + 1);
>> -        unlock_user_struct(fdesc, haddr, 1);
>> +        unlock_user(fdesc, haddr, 0);
>>           haddr = dest;
>>       }
>>       env->iaoq_f = haddr;
>>
> 


