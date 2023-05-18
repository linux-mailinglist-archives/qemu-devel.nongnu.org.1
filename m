Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A643670832D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdaa-0008N0-46; Thu, 18 May 2023 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdaT-0008Ik-ER
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:22:35 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdaR-0004gF-Gk
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:22:33 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2533d3acd5fso1920478a91.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684416150; x=1687008150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2ihCKFyovIE9h8BOCpXNw6alrdFhl9FwhPhfLZE03s=;
 b=KulHWZSUOefL5CEYlIpFvU6z6LV7KrvMRFcKFblmfzkrfM4Ohz1eFAkciwQS5pHwHr
 eE2JZEms8+xJPYro0NtERYRB+tBczo/IRKsarzi45wYhkIB+RYHyKlnD6NPtQ61Xqf7O
 d1EdIKfoPo5jiTDCYHONvAF5M2KFxcYg2nDJtbYUjpjDeiy3JLAIRMWeS37kkWIdXAB2
 9NcKdKHjlonh640tSct8zpRfxzzRvZ1vkc7k51yJHJCdgn8Gch+nXOjJj0Knk5ottEIV
 q/j5AOi4NPiIcvEPJQqDcQxNa8qGQvkoM1oJ8kjz82YjbwwGP/9mlVSMvQ+MszwXd7fp
 n6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684416150; x=1687008150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2ihCKFyovIE9h8BOCpXNw6alrdFhl9FwhPhfLZE03s=;
 b=diCbJ67dxttzFEnLPo7gs34Ae+H/5kr/cmA3m47aielGLBx/zY4x4H0Ka+DxDLp0YG
 S9vUpSjLM4x/EIeMJXyiKOBzfuGVUmVzeU9ZB88RimczGaIcYzScJovXbV2FvKmVap1s
 Y0EwM91bI7QjgeYwyiKICyxKFVMX+gitgMD5gAmcxYbgVBbc+mJtxACviChRLwmrN/a0
 txuoo4lUQ3s3lwumQZR6MOPHETDOvbaEmKCjFgFGWgaoKZNMBSsgk3JSY5euoMFD47e8
 qbyAgbGaW+pGBPUCcTYLufksMokGnWtp1Cx0VnFoZoZwtzFketp6vaska1GC8ghfFGVI
 YkPA==
X-Gm-Message-State: AC+VfDwSqopo+Gjr4rsVoWKWZNfDqCDcRprxaLmPqoL2PSwc6iK4EPCl
 fozVegk1VMzykeBO8GqVvcKmQA==
X-Google-Smtp-Source: ACHHUZ49H10LOPQ1iRCLGbjWH3MgnPRxwAthQuZVadzCAhzE/baA3iy0yXSBdTcvVOvRC2xUKhwAaQ==
X-Received: by 2002:a17:90a:3e0f:b0:253:27b4:cd4d with SMTP id
 j15-20020a17090a3e0f00b0025327b4cd4dmr2382211pjc.27.1684416149896; 
 Thu, 18 May 2023 06:22:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 gw23-20020a17090b0a5700b002535a337d45sm1383721pjb.3.2023.05.18.06.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:22:29 -0700 (PDT)
Message-ID: <b7e26d58-f8dd-3647-c3b5-87a0a0611578@linaro.org>
Date: Thu, 18 May 2023 06:22:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: command line, guest console output missing from avocado log
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <CAFEAcA8rZDtUFTM7Ya6aTTZw0bHYL0y-6Akjoru1SS=qeh+KWA@mail.gmail.com>
 <CAFEAcA_jbxsKrG0T_3Wi1Q-LZePqNqgVsdS8okQP1ADzqrL0hw@mail.gmail.com>
 <87r0rlwk5a.fsf@linaro.org>
 <CAFEAcA-Djx6jXON8WLhfexbjAaYT5W23DMrWOmuRwffpNBG6Bg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-Djx6jXON8WLhfexbjAaYT5W23DMrWOmuRwffpNBG6Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 05:08, Peter Maydell wrote:
> On Fri, 12 May 2023 at 18:10, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Tue, 9 May 2023 at 19:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> I just noticed that the guest console output seems to no longer
>>>> be in the avocado log file. Can it be reinstated, please?
>>>> The console logs are typically the most useful clue to "why did this
>>>> test fail" and without it you're just guessing in the dark...
>>>> The details of what QEMU command line avocado is running
>>>> also seem to have vanished : that also is among the most
>>>> useful items of information to have in the log.
>>>
>>> Ping? Where can I find these bits of the log for avocado
>>> test runs now? I tried looking in the individual per-test
>>> directories but they're not there either...
>>
>> Hmm they have indeed disappeared. According to the docs doing:
>>
>>    ./tests/venv/bin/avocado --show console:DEBUG run tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_arm64
>>
>> should be enough, and there is another option --store-logging-stream
>> which takes the format. However I wasn't able to get this to work.
>> However moving the logging into the avocado name space with the
>> following:
>>
>> --8<---------------cut here---------------start------------->8---
>> modified   tests/avocado/avocado_qemu/__init__.py
>> @@ -138,7 +138,7 @@ def _console_interaction(test, success_message, failure_message,
>>       if vm is None:
>>           vm = test.vm
>>       console = vm.console_socket.makefile(mode='rb', encoding='utf-8')
>> -    console_logger = logging.getLogger('console')
>> +    console_logger = logging.getLogger('avocado.guest.console')
>>       while True:
>>           if send_string:
>>               vm.console_socket.sendall(send_string.encode())
>> @@ -407,7 +407,7 @@ class LinuxSSHMixIn:
>>       """Contains utility methods for interacting with a guest via SSH."""
>>
>>       def ssh_connect(self, username, credential, credential_is_key=True):
>> -        self.ssh_logger = logging.getLogger('ssh')
>> +        self.ssh_logger = logging.getLogger('avocado.guest.ssh')
>>           res = self.vm.command('human-monitor-command',
>>                                 command_line='info usernet')
>>           port = get_info_usernet_hostfwd_port(res)
>> --8<---------------cut here---------------end--------------->8---
>>
>> then makes things work with --show avocado.guest.console:DEBUG and the
>> job log automatically get the output in the logs.
>>
>> I note that:
>>
>>    https://avocado-framework.readthedocs.io/en/101.0/guides/writer/chapters/logging.html
>>
>> has a big TODO note in it.
>>
>> Cleber,
>>
>> Is this the change we should make or should we be able to pick arbitary
>> name-spaces for logging?
> 
> Ping! Can we either fix this or roll back to the old Avocado
> version, please ? I've just run into "want to find out why
> the test failed, log has 0 information" problem again.

Seconded.


r~


