Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A679E031
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJbe-0008AD-IJ; Wed, 13 Sep 2023 02:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJbb-00089h-1C
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:44:07 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJbW-0005DJ-J5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:44:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso819179966b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694587440; x=1695192240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nnvJvrslAg/jQdbrh3/IH6kBUA4IeTGmZcz4opDDxJY=;
 b=lw/P/bDWx6khGm7kZu+kRtk1m7An8/bBm69T2+nBfNRmIZ1HDoPZu+Ch7wXsdeJZwO
 SYiRlrioET/njfTuvZw6GGMclFjYvxrzI/OttIBgzXLrVIXAAXVRUmb1p70E781GSSkF
 7okUvdrIfBNdVGW+EiaKb2QWUVK0NTeb0u4de9ANjiEj2SqNVk3/MVet2I0aiifXiScg
 BA9K/gL+ZzmGsiWVfcrvQyMdIj+xMgidUmXvBmruXE8UoFfjNFQvH1aIpmNxiu9vji2m
 dIwl6fYYdL+B7NUlWzzd7IRsAyJj0SioSYn9lPzX+WnZK7hrIE0VqoS7mecgFzY9jp4h
 laow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694587440; x=1695192240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nnvJvrslAg/jQdbrh3/IH6kBUA4IeTGmZcz4opDDxJY=;
 b=lC55D9BCrLqvIlhAGaWY6TzeF+spQSW8cftjJ5QCjl/luTTAcCPsq3QroNjXYPc5q+
 Xi1VaChyplI2633wJfROBg/qd0Zhr4s08caY6bx+cwvfs7kIU1ghf6MUzff2+Ngkuvhl
 7uw19Ypp6670uKdZgiZbqBoTKnoakARQJ8f5xrQDStNH6+ksIDtAeRLDK1WkU1CgNVRZ
 3aAePa3sIAOwbC/DUOo84t4Cf+VdY0hk25hH58WthTn9m6klqg1tLS+nN4bGN4D+pupf
 jL5ExkNna3S7Huka2HBzMjnTLI+J2QBrzLGEytq0zPHrvenpdW3twtDVkl3reAbm3sZS
 7QLg==
X-Gm-Message-State: AOJu0YzNDhmwXzcqTpEyqO/IeYktSXisUMPAPa7NHOjSfeZXt1ojkuia
 EMLJeX+rzusZh1fvaQ46DDp5rw==
X-Google-Smtp-Source: AGHT+IGFD+KNwJd5N0TEJbHrC1fApC5dB9e8Hl0aI4mQ6U/QdoPWMeHy7JCzCkDyZm+I581SDCs9Xw==
X-Received: by 2002:a17:907:780e:b0:9a5:8269:2c94 with SMTP id
 la14-20020a170907780e00b009a582692c94mr1034722ejc.57.1694587440582; 
 Tue, 12 Sep 2023 23:44:00 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1709066b8f00b0099bca8b9a31sm7774070ejr.100.2023.09.12.23.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:44:00 -0700 (PDT)
Message-ID: <6996928d-5869-241b-9d5c-25282b9f36ab@linaro.org>
Date: Wed, 13 Sep 2023 08:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230912150611.70676-1-stefanha@redhat.com>
 <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 12/9/23 21:58, Thomas Huth wrote:
> On 12/09/2023 17.06, Stefan Hajnoczi wrote:
>> The avocado-system-alpine, avocado-system-fedora, and
>> avocado-system-ubuntu jobs are unreliable. I identified them while
>> looking over CI failures from the past week:
>> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
>> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
>> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
>>
>> Thomas Huth suggest on IRC today that there may be a legitimate failure
>> in there:
>>
>>    th_huth: f4bug, yes, seems like it does not start at all correctly on
>>    alpine anymore ... and it's broken since ~ 2 weeks already, so if 
>> nobody
>>    noticed this by now, this is worrying
>>
>> It crept in because the jobs were already unreliable.
>>
>> I don't know how to interpret the job output, so all I can do is to
>> propose removing these jobs. A useful CI job has two outcomes: pass or
>> fail. Timeouts and other in-between states are not useful because they
>> require constant triaging by someone who understands the details of the
>> tests and they can occur when run against pull requests that have
>> nothing to do with the area covered by the test.
>>
>> Hopefully test owners will be able to identify the root causes and solve
>> them so that these jobs can stay. In their current state the jobs are
>> not useful since I cannot cannot tell whether job failures are real or
>> just intermittent when merging qemu.git pull requests.
>>
>> If you are a test owner, please take a look.
>>
>> It is likely that other avocado-system-* CI jobs have similar failures
>> from time to time, but I'll leave them as long as they are passing.
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   .gitlab-ci.d/buildtest.yml | 27 ---------------------------
>>   1 file changed, 27 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index aee9101507..83ce448c4d 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -22,15 +22,6 @@ check-system-alpine:
>>       IMAGE: alpine
>>       MAKE_CHECK_ARGS: check-unit check-qtest
>> -avocado-system-alpine:
>> -  extends: .avocado_test_job_template
>> -  needs:
>> -    - job: build-system-alpine
>> -      artifacts: true
>> -  variables:
>> -    IMAGE: alpine
>> -    MAKE_CHECK_ARGS: check-avocado
> 
> Please don't remove the whole job! Just disable the failing tests within 
> the job, e.g.:
> 
> diff --git a/tests/avocado/replay_kernel.py 
> b/tests/avocado/replay_kernel.py
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, 
> kernel_path_xz):
>           console_pattern = 'Kernel command line: %s' % kernel_command_line
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, 
> shift=5)
> 
> +    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')

Better:

        @skipUntil(gitlab_issue_resolved(1884))

(joking)

I'll send a patch, smth like:

         @skipIf(os.getenv('GITLAB_CI'), 'Pending 
https://gitlab.com/qemu-project/qemu/-/issues/1884')

>       def test_mips_malta32el_nanomips_4k(self):
>           """
>           :avocado: tags=arch:mipsel


