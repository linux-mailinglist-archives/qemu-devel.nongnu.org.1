Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC58787F1A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 06:53:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZOnq-00065J-06; Fri, 25 Aug 2023 00:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOng-00063Y-Sk
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:52:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOne-0001Se-Dp
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:52:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso56591266b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692939116; x=1693543916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sinzVZersKuY6HzvaMxLsZBIQQki0QdeX/7RSc+d2cY=;
 b=Iv1f8p6QbK4hpNCIzozv0B+KZarD/R5milDFztWj5HwDMZeXRyDbTS+4HjWD5kQ/Dn
 Putly+/W2y75mW4zrM7h6Gh+/Rx3/0ewGf3DV4f6YP9GoCELJu3M2vSjOqKfrQ0dIujv
 Xdva88D9lXI1N7XZ4b64KjUVjEFE66tsKFPaMrM0onSiAsbj/yPn+RGfsSXkn9NPvRT8
 4MHyMv+X9ERIZa06ZvteGWxPpJmgODvtn+NoSNC7ZfdIZ1cX0v5UFykr930C5KYocOiA
 DHu0HTy9O4dVgl+3HtqXudZXJKmMVnKp3v4OAZ/C0lwn6XD/QeRnsqQXLbXWewWZFGh5
 UWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692939116; x=1693543916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sinzVZersKuY6HzvaMxLsZBIQQki0QdeX/7RSc+d2cY=;
 b=I5sy3aaWnMBi8XTMarn3TGhBCmeuIQeRKMZCqyiA08U7t46ZYq/pgJbsMexXhVU5yY
 og8hcRhZ0dpa1vRjhsej81BQbR6KzRMPo5T1UPRWqt1S6f2fMQOM0YuS/ZwqNfkCOCLX
 YEN5fGWfp17APhks4DzTdj0kVqWwtHcM4TwICvJmw+11lvJB7m2OmoDmK1KQ0ZFsR1sR
 bpJY7Y1Flh9c7c2b5c4ZaYAcg+DhKmHhRLbU6N1RSK6Yz22XbvB2Ua+6COx6DqxC35Vs
 uFze2WvslltdANMoHNl3y3uKrgICYEUyFkSK0b0tRtUUbjhDZ6wKa3bVPM5iTilM56W8
 /Eyg==
X-Gm-Message-State: AOJu0YyfLK34zF9nZNmgu0GLJR6+yMUCrcWT3uBw95iA6eu/m8SSymnf
 gq8yXN1E67PpGs5czoAiTq1vBw==
X-Google-Smtp-Source: AGHT+IFySpVvwrPTnZewZ2lOGN4jbK+AMsLnQHkparsVPF6q8hX6LeT7mkt0FqUnMkd69ws4y7G2Zw==
X-Received: by 2002:a17:906:5346:b0:9a2:1ce5:1243 with SMTP id
 j6-20020a170906534600b009a21ce51243mr2872764ejo.60.1692939115657; 
 Thu, 24 Aug 2023 21:51:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 jj26-20020a170907985a00b00988e953a586sm492773ejc.61.2023.08.24.21.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 21:51:55 -0700 (PDT)
Message-ID: <8ca8095a-993e-52c5-ddb1-77271cab111e@linaro.org>
Date: Fri, 25 Aug 2023 06:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823163440.GA851545@fedora>
 <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
 <CAJSP0QXO1QQ=4UyLXg_=iyc9=uy1CdeL0fq8_95ewZiewU6XTw@mail.gmail.com>
 <e0b5f2d5-a489-a1b4-b630-987a2999a2b2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e0b5f2d5-a489-a1b4-b630-987a2999a2b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 18:10, Thomas Huth wrote:
> On 24/08/2023 16.51, Stefan Hajnoczi wrote:
>> On Thu, 24 Aug 2023 at 02:53, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 23/08/2023 18.34, Stefan Hajnoczi wrote:
>>>> On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
>>>>> The following changes since commit 
>>>>> b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
>>>>>
>>>>>     Open 8.2 development tree (2023-08-22 07:14:07 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
>>>>>
>>>>> for you to fetch changes up to 
>>>>> 6c49f685d30ffe81cfa47da2c258904ad28ac368:
>>>>>
>>>>>     tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)
>>>>
>>>> Hi Thomas,
>>>> Please take a look at the following ubuntu-20.04-s390x-all CI failure:
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/4931341536
>>>
>>> It says: "TimeoutError: Timeout waiting for job to pause" ... could you
>>> please check the load on that host? ... I think that s390x runner is 
>>> known
>>> for being too slow some times, so I assume that problem should go 
>>> away if
>>> you re-run the job when it is less loaded.
>>
>> I ran it again and it timed out. I've merged the PR and assume the
>> test is just flaky.
> 
> I think someone needs to look at the runner to see whether there is 
> still old stuff taking CPU time or something similar.

Would reporting the runner load on failure help in some way?


