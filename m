Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C2E722B41
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CFj-0005lC-D4; Mon, 05 Jun 2023 11:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6CFh-0005kb-Jp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6CFe-00083u-KS
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzEoVejdJUdhwRJYT/4kD88Cr8NignP+V8kGgM/tmFo=;
 b=Zxey2tdNaf/wwjlqhkwdkf/8slnoI/DVkle9lybev12GHUb0ES6KhPLgRoIzyFHkuxS7uk
 8jm8Ik5+uFkzgDHyd8Ro11eqnIwDpLGstAndeOZ84Uwu9nbQ/b04SqK0e/FC99HhA3OWNW
 u+XYKEktkovUKhA5An1QJSmPLdYeTHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-EGByI3BNO66DC0XalRRN4A-1; Mon, 05 Jun 2023 11:36:06 -0400
X-MC-Unique: EGByI3BNO66DC0XalRRN4A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e7a6981cso2672425e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685979365; x=1688571365;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzEoVejdJUdhwRJYT/4kD88Cr8NignP+V8kGgM/tmFo=;
 b=ltbhhL83X9OGwFkvC8Y0gS8qFdvc9t1bFizS6w9MbwlUvR186MDSICVjK+oc3ULn9S
 MFT9G3ztFq5Sxs42WaBshpVCiXVc2UNnK8VWpIQu8XHSa4BYKi4VR+kCkWfqTwJl2MPa
 n+252WuJieJ2LU9fA6IbJgqp3LqnZkAWJ58+pom5tOTWRBgiArHpjbgV1zQijwd+zLP6
 yvg2wCt8mz6rmxlHxUPDEo+VcQUv0zcc/RF/UzWJrJv9zFTc9zXzHPMeYe9+nlFZj2NI
 5L3+pdXJbKDeIBTQiqmyG+Mk6fx7a1NHkISUJR9QHRfMy6Bw4q+sTYG7mF3UDA5F72aV
 4q0Q==
X-Gm-Message-State: AC+VfDxFr/CbOo1n0kWHdeuSbm9/ISk3jjB5KUj++Qm93rRZYiiz5zEn
 enArGa315qAd2K7fxjqBBV21mc7mNsH2gU2gGdyatmvRG+aoLThodx9aLdhJ7wEarFlpMhoEgqv
 4GBlr8BPhGM/jT0g=
X-Received: by 2002:a05:6000:18ca:b0:306:26d7:3805 with SMTP id
 w10-20020a05600018ca00b0030626d73805mr4968049wrq.63.1685979365368; 
 Mon, 05 Jun 2023 08:36:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lfFbOvQf0lA1/xdc2+vdMxMh9DuJc1QbMP9lRmUtjb06kU++zfxm7j3qb6UIbw/HARIcdQA==
X-Received: by 2002:a05:6000:18ca:b0:306:26d7:3805 with SMTP id
 w10-20020a05600018ca00b0030626d73805mr4968036wrq.63.1685979365062; 
 Mon, 05 Jun 2023 08:36:05 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 k9-20020a056000004900b002c71b4d476asm10099849wrx.106.2023.06.05.08.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 08:36:04 -0700 (PDT)
Message-ID: <0f4090d2-02cb-ff7e-bdd8-5814607e1711@redhat.com>
Date: Mon, 5 Jun 2023 17:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <a0bb4c2a-92ad-4290-3eb8-4168b8828d76@redhat.com>
 <ZH3tyx//NRnvKY0m@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/6] tests: enable meson test timeouts to improve
 debuggability
In-Reply-To: <ZH3tyx//NRnvKY0m@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/06/2023 16.14, Daniel P. Berrangé wrote:
> On Mon, Jun 05, 2023 at 04:07:46PM +0200, Thomas Huth wrote:
>> On 01/06/2023 18.31, Daniel P. Berrangé wrote:
>>> Perhaps the most painful of all the GitLab CI failures we see are
>>> the enforced job timeouts:
>>>
>>>      "ERROR: Job failed: execution took longer than 1h15m0s seconds"
>>>
>>>      https://gitlab.com/qemu-project/qemu/-/jobs/4387047648
>>>
>>> when that hits the CI log shows what has *already* run, but figuring
>>> out what was currently running (or rather stuck) is an horrendously
>>> difficult.
>>>
>>> The initial meson port disabled the meson test timeouts, in order to
>>> limit the scope for introducing side effects from the port that would
>>> complicate adoption.
>>>
>>> Now that the meson port is basically finished we can take advantage of
>>> more of its improved features. It has the ability to set timeouts for
>>> test programs, defaulting to 30 seconds, but overridable per test. This
>>> is further helped by fact that we changed the iotests integration so
>>> that each iotests was a distinct meson test, instead of having one
>>> single giant (slow) test.
>>>
>>> We already set overrides for a bunch of tests, but they've not been
>>> kept up2date since we had timeouts disabled. So this series first
>>> updates the timeout overrides such that all tests pass when run in
>>> my test gitlab CI pipeline. Then it enables use of meson timeouts.
>>>
>>> We might still hit timeouts due to non-deterministic performance of
>>> gitlab CI runners. So we'll probably have to increase a few more
>>> timeouts in the short term. Fortunately this is going to be massively
>>> easier to diagnose. For example this job during my testing:
>>>
>>>      https://gitlab.com/berrange/qemu/-/jobs/4392029495
>>>
>>> we can immediately see  the problem tests
>>>
>>> Summary of Failures:
>>>     6/252 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                TIMEOUT        120.02s   killed by signal 15 SIGTERM
>>>     7/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test          TIMEOUT        120.03s   killed by signal 15 SIGTERM
>>>    64/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                  TIMEOUT        300.03s   killed by signal 15 SIGTERM
>>>
>>> The full meson testlog.txt will show each individual TAP log output,
>>> so we can then see exactly which test case we got stuck on.
>>>
>>> NB, the artifacts are missing on the job links above, until this
>>> patch merges:
>>>
>>>      https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04668.html
>>>
>>> NB, this series sets the migration-test timeout to 5 minutes, which
>>> is only valid if this series is merged to make the migration test
>>> not suck:
>>>
>>>     https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00286.html
>>>
>>> without that series, we'll need to set the migration-test timeout to
>>> 30 minutes instead.
>>>
>>> Daniel P. Berrangé (6):
>>>     qtest: bump min meson timeout to 60 seconds
>>>     qtest: bump migration-test timeout to 5 minutes
>>>     qtest: bump qom-test timeout to 7 minutes
>>>     qtest: bump aspeed_smc-test timeout to 2 minutes
>>>     qtest: bump bios-table-test timeout to 6 minutes
>>>     mtest2make: stop disabling meson test timeouts
>>>
>>>    scripts/mtest2make.py   |  3 ++-
>>>    tests/qtest/meson.build | 16 ++++++----------
>>>    2 files changed, 8 insertions(+), 11 deletions(-)
>>
>> FWIW, I now ran this on my rather old laptop with an --enable-debug
>> build with "make -j$(nproc) check-qtest" and got these additional
>> failures (beside the expected migration-test that still needs its
>> final speedup):
>>
>>   qtest-aarch64/test-hmp        TIMEOUT   120.07s   killed by signal 15 SIGTERM
>>   qtest-aarch64/qom-test        TIMEOUT   420.09s   killed by signal 15 SIGTERM
>>   qtest-arm/qom-test            TIMEOUT   420.10s   killed by signal 15 SIGTERM
>>   qtest-arm/npcm7xx_pwm-test    TIMEOUT   150.04s   killed by signal 15 SIGTERM
>>   qtest-ppc64/pxe-test          TIMEOUT    60.01s   killed by signal 15 SIGTERM
>>   qtest-sparc/prom-env-test     TIMEOUT    60.01s   killed by signal 15 SIGTERM
>>   qtest-sparc/boot-serial-test  TIMEOUT    60.01s   killed by signal 15 SIGTERM
> 
> Did you see any others in the 45-60 second time window, as those would
> be candidates for increases too - don't want to have things right below
> the 60 second cutoff ?

The qos-test on arm likely needs some adjustment, too:

  qtest-arm/qos-test                    OK     40.72s   115 subtests passed
  qtest-aarch64/qos-test                OK     54.00s   108 subtests passed

  Thomas


