Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4257982AF42
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuq6-0005Ea-As; Thu, 11 Jan 2024 08:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNupx-0005Cd-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:11:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNupu-0008Sp-VT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:11:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e5bfa260bso9023075e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 05:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704978665; x=1705583465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQ2UNQeUy/S45X0zJXf1Kvq8wAD4xMbyOJLY1J22aQQ=;
 b=wq9kUQmvlzhdbGBc7dT7N8bBCnOsqPn7woBzZ05qybINAfvUxvsLUJs3JFKU1y9kWu
 1PGBl1zVFPShhBBNjbBIqejJj6Vk9ZTOhgdnoLa2NzExSBIT0NQRnPfRim4jvo6mtmjn
 ahcT3C3l5xMONocoOLHdIOJ6IdGUAX4aKixg+u+nHffs9Z+1/CWuKpvnZ9BShqlu7oBj
 LuZbRcmz1mszHPLMyRicfRdAIat9ckmHtUg9FlZGW6A+YKRsZYMkFP02p7fTyWo4pZcR
 5DIKEsxeJ54hr6owBkyLsvAgAjW1Cokbf9JX+rVuwuBfhB60ohgr1qUak7Bw2O0uUM8o
 oOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978665; x=1705583465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ2UNQeUy/S45X0zJXf1Kvq8wAD4xMbyOJLY1J22aQQ=;
 b=BA6hBYOUi4ggAxCoBqGMw0l9G9XmOONLol2OrVclLXyG8BjuvSyvxobLLYij0xIJFz
 dG/aBAqxiISVEwNLPMs6SfxgOF7VKiVlFMcIyd8cRkt9kATciprB7ciqq3YFhbFbgVyN
 0VGuvZHj+/kPAFKJzkQ+LLhS/2f43rJjuHkLgXNIq7OV0kAdqx2lA4Zt5AuQBZxni491
 zMXAQ1PPnXa5jyfpPvVFdKV5a2jirND0kO3vDrkhApIrth79kSbFx9yw0fD9nmsdtHPD
 j07zLlxeIrZIAtHZIVUf3kilSoN6JjN2hru+Ectyj1kAvCansvdbI7Q/iePtptWkxaE1
 N/pQ==
X-Gm-Message-State: AOJu0YyCAYT4UIZUE52NMQy7eMuY85a5bVEutermrr86cpHt2TJDcCAO
 DU3ChrCl4WWbq5T7Mokrgzt75c7S7BjKVw==
X-Google-Smtp-Source: AGHT+IFNo9sNAFufa3Pe6T1Qh8eZKWn1zSJ9aztwzKqOc1XvqXPyPmNXcEH89S/TiiRWSgu2R3Irag==
X-Received: by 2002:a05:600c:198a:b0:40e:5feb:3624 with SMTP id
 t10-20020a05600c198a00b0040e5feb3624mr203631wmq.54.1704978664886; 
 Thu, 11 Jan 2024 05:11:04 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 dr18-20020a5d5f92000000b0033677a4e0d6sm1229216wrb.13.2024.01.11.05.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 05:11:04 -0800 (PST)
Message-ID: <b10e1e42-f765-45d8-affc-784849a51854@linaro.org>
Date: Thu, 11 Jan 2024 14:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
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
 <9fcd71ae-8a65-4f60-ab98-5a3e5807070d@redhat.com>
 <93861775-6cc5-fb52-8926-9c85fe42b932@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <93861775-6cc5-fb52-8926-9c85fe42b932@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/1/24 13:05, gaosong wrote:
> 在 2024/1/11 下午4:26, Thomas Huth 写道:
>> On 11/01/2024 08.25, gaosong wrote:
>>> Hi,
>>>
>>> 在 2024/1/11 下午3:08, Thomas Huth 写道:
>>>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>>>> Full build config to run CI tests on a Loongarch64 host.
>>>>>
>>>>> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
>>>>> in their CI namespace settings, see:
>>>>> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>>>>>   .gitlab-ci.d/custom-runners.yml               |  1 +
>>>>>   .../openeuler-22.03-loongarch64.yml           | 21 
>>>>> +++++++++++++++++++
>>>>>   3 files changed, 28 insertions(+)
>>>>>   create mode 100644 
>>>>> .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>>
>>>> ...
>>>>> diff --git a/.gitlab-ci.d/custom-runners.yml 
>>>>> b/.gitlab-ci.d/custom-runners.yml
>>>>> index 8e5b9500f4..152ace4492 100644
>>>>> --- a/.gitlab-ci.d/custom-runners.yml
>>>>> +++ b/.gitlab-ci.d/custom-runners.yml
>>>>> @@ -32,3 +32,4 @@ include:
>>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>>>>>     - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
>>>>> +  - local: 
>>>>> '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
>>>>> diff --git 
>>>>> a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>>>>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>> new file mode 100644
>>>>> index 0000000000..86d18f820e
>>>>> --- /dev/null
>>>>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>> @@ -0,0 +1,21 @@
>>>>> +openeuler-22.03-loongarch64-all:
>>>>> + extends: .custom_runner_template :-)
>>>>> + needs: []
>>>>> + stage: build
>>>>> + tags:
>>>>> + - oe2203
>>>>> + - loongarch64
>>>>> + rules:
>>>>> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && 
>>>>> $CI_COMMIT_BRANCH =~ /^staging/'
>>>>> +   when: manual
>>>>> +   allow_failure: true
>>>>> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
>>>>> +   when: manual
>>>>> +   allow_failure: true
>>>>> + script:
>>>>> + - mkdir build
>>>>> + - cd build
>>>>> + - ../configure
>>>>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>>>> + - make --output-sync -j`nproc --ignore=40`
>>>>> + - make --output-sync -j`nproc --ignore=40` check
>>>>
>>>> Does this system really have more than 40 CPU threads? Or is this a 
>>>> copy-n-past from one of the other scripts? In the latter case, I'd 
>>>> suggest to adjust the --ignore=40 to a more reasonable value.
>>>>
>>>>  Thomas
>>> No,  only 32.   I think it should be --ignore=32 or 16.
>>
>> --ignore=32 then also does not make much sense, that would still be 
>> the same as simply omitting the -j parameter. I guess --ignore=16 
>> should be fine.
>>
>>> I create a same runner on this machine, and I  find  some check error.
>>> but I am not sure how to fix it. :-)
>>>
>>> See:
>>>
>>> https://gitlab.com/gaosong/qemu/-/jobs/5906269934
>>
>> Seems to be related to RAM backing... for example, the erst-test is 
>> failing, which is doing something like:
>>
>>     setup_vm_cmd(&state,
>>         "-object memory-backend-file,"
>>             "mem-path=acpi-erst.XXXXXX,"
>>             "size=64K,"
>>             "share=on,"
>>             "id=nvram "
>>         "-device acpi-erst,"
>>             "memdev=nvram");
>>
>> So it seems like -object memory-backend-file" is not correctly working 
>> in your gitlab runner? Is there some setup missing?
>>
>>  Thomas
>>
>>
> This is my runner config.
> 
>      concurrent = 32
>      check_interval = 0
>      shutdown_timeout = 0
> 
>      [session_server]
>        session_timeout = 1800
> 
>      ...
> 
>      [[runners]]
>        name = "loongarch64"
>        request_concurrency = 24
>        url = "https://gitlab.com"
>        id = 31426483
>        token = "glrt-bGugocYrR2yqcu3ma7ka"
>        token_obtained_at = 2024-01-10T08:31:29Z
>        token_expires_at = 0001-01-01T00:00:00Z
>        executor = "shell"
>        builds_dir = "/data/gitlab-runner/builds"
>        cache_dir = "/data/gitlab-runner/cache"
>        [runners.cache]
>          MaxUploadedArchiveSize = 0
> 
> I create a project runner 'loongarch64' for my branch ci-master.
> Do we need some special configuration?

We need to follow this process:
https://lore.kernel.org/qemu-devel/20240104160805.56856-1-philmd@linaro.org/

