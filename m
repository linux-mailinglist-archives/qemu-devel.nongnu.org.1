Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BAA827F41
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:22:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6RI-0004L8-Ox; Tue, 09 Jan 2024 02:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rN6R0-0004HB-Jj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rN6Qx-0004pc-Om
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704784919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZXDNKvgIVz5jeydoPCFyrwrq/l0xYOFV7TLLSWPLyLY=;
 b=gi4brgMRNBJ1fnF0IxA9LhhnEJ79oCW8dRwSBS30gCEI5j+P6SupItezPJkhI7e9q5unBc
 NNbSlCIeTPlfwI7EVIeOj0MrRf1lebdf5dAPCLw5xWb6G5x/3lG99o1tE/xSljzh/kYujs
 Q6QaIwa78VR0h3bX4z9rh+6FsBL1au4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-rX4EpFxKPs-DOUr-NMuu0w-1; Tue, 09 Jan 2024 02:21:57 -0500
X-MC-Unique: rX4EpFxKPs-DOUr-NMuu0w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-555f8e831f2so1125474a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704784916; x=1705389716;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXDNKvgIVz5jeydoPCFyrwrq/l0xYOFV7TLLSWPLyLY=;
 b=tkSmqcn3XKZ8v0YRUJ9s+dmcTcIDM6dMc4UQdquzcoMK7tsAe18Y1tdRw+FBnJ34wE
 r+zd8k+Ogg+2hcjT+1koGWKUpsX7sDZBBI05n3otyqvTINoTDzk5ZOfisSdP0Eai0sGU
 +O6i/XGG3RiNyJ1Yb0TjC4dQgqFCQE106F15nKxbNUsbkgyTgJSJtA9C1pBYq+2HKQnX
 oVfnbSZOtp46EKKZsflKjdtaWCBjimFKVZAzXzIUfi2tWDxmGTUZpj/O7SGZGW+tzOQS
 lmREskFVdzbseaRpeWIhkwHNOQIUj414UW8PRnpLqGJHT1a2N38Wx5LEkYhUxKRldkN1
 GNFQ==
X-Gm-Message-State: AOJu0Ywcd03vMigdYyAVh5H0Zk4T9p39O0ohasAew9s2gHhgcuRkOEg6
 JuKmARTm277azP7U1VhYnMeGYUiL80ZeIBKiYE6cURI71Ok2OaiZY5L3u4lT1CW1N67yPQvy1/+
 A5OnhSGVbBSTbl/0t2xF814s=
X-Received: by 2002:a05:6402:134c:b0:557:de83:64dd with SMTP id
 y12-20020a056402134c00b00557de8364ddmr932658edw.18.1704784916212; 
 Mon, 08 Jan 2024 23:21:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAImBATU6oCLBNwsi/AojzetoCCh9Y4F9DykTaGRlG0MaD1KrX/jtt2jkNq9oCfNXGO89umA==
X-Received: by 2002:a05:6402:134c:b0:557:de83:64dd with SMTP id
 y12-20020a056402134c00b00557de8364ddmr932645edw.18.1704784915890; 
 Mon, 08 Jan 2024 23:21:55 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 s7-20020a056402014700b005576f4471besm625229edu.42.2024.01.08.23.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:21:55 -0800 (PST)
Message-ID: <5219f49a-c75d-4c42-86ba-4e4d90e58968@redhat.com>
Date: Tue, 9 Jan 2024 08:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Leonardo Bras
 <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de> <87ttvjoexo.fsf@secure.mitica>
 <ZZuZcCxxIS6j_jHD@x1n> <87frz73nr7.fsf@suse.de> <ZZyrqnk3nJ3WIX8v@x1n>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZZyrqnk3nJ3WIX8v@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 09/01/2024 03.12, Peter Xu wrote:
> On Mon, Jan 08, 2024 at 11:26:04AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Wed, Jun 07, 2023 at 10:27:15AM +0200, Juan Quintela wrote:
>>>> Fabiano Rosas <farosas@suse.de> wrote:
>>>>> We've found the source of flakiness in this test, so re-enable it.
>>>>>
>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> ---
>>>>>   tests/qtest/migration-test.c | 10 ++--------
>>>>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>>>> index b0c355bbd9..800ad23b75 100644
>>>>> --- a/tests/qtest/migration-test.c
>>>>> +++ b/tests/qtest/migration-test.c
>>>>> @@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
>>>>>       }
>>>>>       qtest_add_func("/migration/multifd/tcp/plain/none",
>>>>>                      test_multifd_tcp_none);
>>>>> -    /*
>>>>> -     * This test is flaky and sometimes fails in CI and otherwise:
>>>>> -     * don't run unless user opts in via environment variable.
>>>>> -     */
>>>>> -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>>>>> -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
>>>>> -                       test_multifd_tcp_cancel);
>>>>> -    }
>>>>> +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
>>>>> +                   test_multifd_tcp_cancel);
>>>>>       qtest_add_func("/migration/multifd/tcp/plain/zlib",
>>>>>                      test_multifd_tcp_zlib);
>>>>>   #ifdef CONFIG_ZSTD
>>>>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>>
>>>>
>>>> There was another failure with migration test that I will post during
>>>> the rest of the day.  It needs both to get it right.
>>>
>>> This one didn't yet land upstream.  I'm not sure, but maybe Juan was saying
>>> about this change:
>>>
>>>          commit d2026ee117147893f8d80f060cede6d872ecbd7f
>>>          Author: Juan Quintela <quintela@trasno.org>
>>>          Date:   Wed Apr 26 12:20:36 2023 +0200
>>>
>>>          multifd: Fix the number of channels ready
>>
>> That's not it. It was something in the test itself around the fact that
>> we use two sets of: from/to. There was supposed to be a situation where
>> we'd start 'to2' while 'to' was still running and that would cause
>> issues (possibly with sockets).
>>
>> I think what might have happened is that someone merged a fix through
>> another tree and Juan didn't notice. I think this is the one:
>>
>>    commit f2d063e61ee2026700ab44bef967f663e976bec8
>>    Author: Xuzhou Cheng <xuzhou.cheng@windriver.com>
>>    Date:   Fri Oct 28 12:57:32 2022 +0800
>>    
>>        tests/qtest: migration-test: Make sure QEMU process "to" exited after migration is canceled
>>        
>>        Make sure QEMU process "to" exited before launching another target
>>        for migration in the test_multifd_tcp_cancel case.
>>        
>>        Signed-off-by: Xuzhou Cheng <xuzhou.cheng@windriver.com>
>>        Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>        Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>        Message-Id: <20221028045736.679903-8-bin.meng@windriver.com>
>>        Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Hmm, i see.

Sorry for that :-( Maybe it's better if we remove the migration-test from 
the qtest section in MAINTAINERS? Since the migration test is very well 
maintained already, there's IMHO no need for picking up the patches via the 
qtest tree, so something like this should prevent these problems:

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3269,6 +3269,7 @@ F: tests/qtest/
  F: docs/devel/qgraph.rst
  F: docs/devel/qtest.rst
  X: tests/qtest/bios-tables-test*
+X: tests/qtest/migration-*

  Device Fuzzing
  M: Alexander Bulekov <alxndr@bu.edu>

(as you can see, we're doing it in a similar way for the bios tables test 
already)

If you agree, I can send out a proper patch for this later today.

  Thomas


