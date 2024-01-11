Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127482A915
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:26:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqOe-0003Pa-96; Thu, 11 Jan 2024 03:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqOc-0003PJ-8n
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqOY-00050f-9R
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9i1Yj8voV9qIXRzdUCEi1kGSu3040etqcpl7RX7FUUg=;
 b=PFRuVJ1P+WObQCq3Vg5ff3sXM9mIafIgT1cEwx4yg9EHMn9ENJumld0QVwJkHFUZBoYwn1
 iqVrGxgo3M/vFgwlFz6YAU0FBPMEWy1V9nfOtLUIRs5XqHQwO2tmTOoMHMdafmWwW4l44f
 djvAfd0+zaCOsTQeBz+ixcJVXgZgds4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Nr63E9-jPuys7AwdWVc8mA-1; Thu, 11 Jan 2024 03:26:31 -0500
X-MC-Unique: Nr63E9-jPuys7AwdWVc8mA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-680c7ce15a0so58317036d6.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961591; x=1705566391;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9i1Yj8voV9qIXRzdUCEi1kGSu3040etqcpl7RX7FUUg=;
 b=syjuBebI6UXGUBagDXI6CEZBWz+mCn9t/pnv61aTbDC1+EQFUk+XfunMAmpUfGhvcn
 isJnFvf3NdTLKC5lQTRk1tPfta8w5fw9tVzvMxkD8aYp47AsZuVXhltdSI2lAFtK5R8j
 XpQ/eff5KSwRYmWgHQllThqo44UiOPlIRuJKDbiM8RCpY31BTgeGCAJ6OYugMCg/kJv9
 MnRt6KWk7IxS9pyKC/+AMTwZYCCSa0+J2xFXa76mtMdWqChWGjgwjLq+bE5hL5BGMQuP
 qYHYqAZ/jrxUkoQHEAOumim+3rxglBuD7b/jQeZmZjX9qGvwuxEMiZCFAqzIVAyaaxLK
 NpRA==
X-Gm-Message-State: AOJu0YyPJgCw+PAWaj6aICpLWOZ1sFBtmbFH1WzddfKjYETXGH7Y6KiS
 RC/vQU3V1S+2PM6WYccVvMRhsCIJFn4TQ/CduCwckwsDsz6XTV7Z5t0cp3Az3ggmK1soNV7qQ1o
 o7blmOSxPc7U2hxLbjJnZNx8=
X-Received: by 2002:a05:6214:2581:b0:67f:b784:f68c with SMTP id
 fq1-20020a056214258100b0067fb784f68cmr830474qvb.79.1704961591218; 
 Thu, 11 Jan 2024 00:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaGQrouhZXjpWOUyym8CKxuzrkGgpdwi+np6ETqi6Q9Xiezmp0diIBD9iiwmZIqrPtHuqmyw==
X-Received: by 2002:a05:6214:2581:b0:67f:b784:f68c with SMTP id
 fq1-20020a056214258100b0067fb784f68cmr830456qvb.79.1704961590976; 
 Thu, 11 Jan 2024 00:26:30 -0800 (PST)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 e10-20020ad4418a000000b0067f80dbd535sm154634qvp.8.2024.01.11.00.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:26:30 -0800 (PST)
Message-ID: <9fcd71ae-8a65-4f60-ab98-5a3e5807070d@redhat.com>
Date: Thu, 11 Jan 2024 09:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-2-philmd@linaro.org>
 <3d30c1b6-1de1-418e-80f6-3d693375142a@redhat.com>
 <6134cdb3-1884-5d7f-fc2d-4a6a2fa2126a@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6134cdb3-1884-5d7f-fc2d-4a6a2fa2126a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/01/2024 08.25, gaosong wrote:
> Hi,
> 
> 在 2024/1/11 下午3:08, Thomas Huth 写道:
>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>> Full build config to run CI tests on a Loongarch64 host.
>>>
>>> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
>>> in their CI namespace settings, see:
>>> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>>>   .gitlab-ci.d/custom-runners.yml               |  1 +
>>>   .../openeuler-22.03-loongarch64.yml           | 21 +++++++++++++++++++
>>>   3 files changed, 28 insertions(+)
>>>   create mode 100644 
>>> .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>
>> ...
>>> diff --git a/.gitlab-ci.d/custom-runners.yml 
>>> b/.gitlab-ci.d/custom-runners.yml
>>> index 8e5b9500f4..152ace4492 100644
>>> --- a/.gitlab-ci.d/custom-runners.yml
>>> +++ b/.gitlab-ci.d/custom-runners.yml
>>> @@ -32,3 +32,4 @@ include:
>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>>>     - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
>>> +  - local: '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
>>> diff --git a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>> new file mode 100644
>>> index 0000000000..86d18f820e
>>> --- /dev/null
>>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>> @@ -0,0 +1,21 @@
>>> +openeuler-22.03-loongarch64-all:
>>> + extends: .custom_runner_template :-)
>>> + needs: []
>>> + stage: build
>>> + tags:
>>> + - oe2203
>>> + - loongarch64
>>> + rules:
>>> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ 
>>> /^staging/'
>>> +   when: manual
>>> +   allow_failure: true
>>> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
>>> +   when: manual
>>> +   allow_failure: true
>>> + script:
>>> + - mkdir build
>>> + - cd build
>>> + - ../configure
>>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>> + - make --output-sync -j`nproc --ignore=40`
>>> + - make --output-sync -j`nproc --ignore=40` check
>>
>> Does this system really have more than 40 CPU threads? Or is this a 
>> copy-n-past from one of the other scripts? In the latter case, I'd suggest 
>> to adjust the --ignore=40 to a more reasonable value.
>>
>>  Thomas
> No,  only 32.   I think it should be --ignore=32 or 16.

--ignore=32 then also does not make much sense, that would still be the same 
as simply omitting the -j parameter. I guess --ignore=16 should be fine.

> I create a same runner on this machine,  and I  find  some check error.
> but I am not sure how to fix it. :-)
> 
> See:
> 
> https://gitlab.com/gaosong/qemu/-/jobs/5906269934

Seems to be related to RAM backing... for example, the erst-test is failing, 
which is doing something like:

     setup_vm_cmd(&state,
         "-object memory-backend-file,"
             "mem-path=acpi-erst.XXXXXX,"
             "size=64K,"
             "share=on,"
             "id=nvram "
         "-device acpi-erst,"
             "memdev=nvram");

So it seems like -object memory-backend-file" is not correctly working in 
your gitlab runner? Is there some setup missing?

  Thomas



