Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9C79D5B8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5r7-0002bS-WE; Tue, 12 Sep 2023 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qg5qv-0002IH-EG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:03:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qg5qq-000549-GC
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:03:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b5516104so61699615e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694534572; x=1695139372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glsG8iNwdUFvxeFxV5WExE+BPMPw7raWjC23V2NV8fE=;
 b=VS12aHST/jYzjbvziGaFxtpwpAuuwcJU6yVvBSP29vcXuJHuBbJ5GYOFUZXnpOufiw
 aRQaTd3GFkC3CgRbVv5skbGhO44gzB9Iopd/FNmUmwbWMo/w5U9RdD48NDw7Hs0QaTe6
 1gy/oLixbvRZ1rj8h17EQVSpd9To2PVdrxRgwDMk3ORVEfYdIF67f70GTb2vumJ4wW6S
 yVUHdEFEhQIgJGxFi3wvBrMwA3OGlur8skzJlGH/XXIAYg9HWHtOMuFPIO7PEBpfy2xe
 fMybrOIV8BTFNXThPbcMXUwzw1Nq3fRZMAAvhmwrIllSdp4G3cVibsn+8LHYEaOfj2l+
 6IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694534572; x=1695139372;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=glsG8iNwdUFvxeFxV5WExE+BPMPw7raWjC23V2NV8fE=;
 b=VwguDXPBBKJmAk6gq3cPrRoFtSODMy+q1Afb5/g3hhcyfP1rfOP6xKbSOCJMmptHS/
 PUbcjxMx+DPxc+5MwEWrpGZ9LsG26u8nBN2yZmh679LfkKM0YN8iu9orDRMeSjL7/rjr
 K/VLIUVU1RyCbCqqkzCtUhE0JgNk2L/AcvnxO1+3jdR8Lr1lAKbacaxGhR+09Y/VvWgH
 975MkwAJnqMU+YfFuA/iDAd1RgyTDmj8DQFADs+nbHF4B7P+pSW7QYTQIvWLMbXGUz6t
 NuanTe6tt8X4BMHGzUV7Mqap4X5cNKmkAFDZgRif+cYfWRIK6kHT9TlF9CQ+RVqwhe1D
 Ykow==
X-Gm-Message-State: AOJu0YxOUbTJgRDuwj0Me5Z3617+pmAz9Mvtbwxm1VLdmzt/aPan50SX
 HcPANUX1zZq3oaGnnNRNQETNXg==
X-Google-Smtp-Source: AGHT+IFxMJ3cMGrYIl0dHs4MM7Ewe7/LHBgbqDIqVHgBeVcWBGIGxBT4ojV72nrZ6Ct05p9wRTnkvA==
X-Received: by 2002:a7b:cb94:0:b0:401:b0f2:88cc with SMTP id
 m20-20020a7bcb94000000b00401b0f288ccmr11877482wmi.41.1694534571985; 
 Tue, 12 Sep 2023 09:02:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b003fefcbe7fa8sm13283371wmi.28.2023.09.12.09.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 09:02:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A17B1FFBB;
 Tue, 12 Sep 2023 17:02:50 +0100 (BST)
References: <20230912150611.70676-1-stefanha@redhat.com>
 <ZQCBoCI6lvJqhsbd@redhat.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Date: Tue, 12 Sep 2023 17:01:26 +0100
In-reply-to: <ZQCBoCI6lvJqhsbd@redhat.com>
Message-ID: <8734zjv0ph.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:
>> The avocado-system-alpine, avocado-system-fedora, and
>> avocado-system-ubuntu jobs are unreliable. I identified them while
>> looking over CI failures from the past week:
>> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
>> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
>> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
>>=20
>> Thomas Huth suggest on IRC today that there may be a legitimate failure
>> in there:
>>=20
>>   th_huth: f4bug, yes, seems like it does not start at all correctly on
>>   alpine anymore ... and it's broken since ~ 2 weeks already, so if nobo=
dy
>>   noticed this by now, this is worrying
>>=20
>> It crept in because the jobs were already unreliable.
>>=20
>> I don't know how to interpret the job output, so all I can do is to
>> propose removing these jobs. A useful CI job has two outcomes: pass or
>> fail. Timeouts and other in-between states are not useful because they
>> require constant triaging by someone who understands the details of the
>> tests and they can occur when run against pull requests that have
>> nothing to do with the area covered by the test.
>>=20
>> Hopefully test owners will be able to identify the root causes and solve
>> them so that these jobs can stay. In their current state the jobs are
>> not useful since I cannot cannot tell whether job failures are real or
>> just intermittent when merging qemu.git pull requests.
>>=20
>> If you are a test owner, please take a look.
>>=20
>> It is likely that other avocado-system-* CI jobs have similar failures
>> from time to time, but I'll leave them as long as they are passing.
>>=20
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 27 ---------------------------
>>  1 file changed, 27 deletions(-)
>>=20
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index aee9101507..83ce448c4d 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -22,15 +22,6 @@ check-system-alpine:
>>      IMAGE: alpine
>>      MAKE_CHECK_ARGS: check-unit check-qtest
>>=20=20
>> -avocado-system-alpine:
>> -  extends: .avocado_test_job_template
>> -  needs:
>> -    - job: build-system-alpine
>> -      artifacts: true
>> -  variables:
>> -    IMAGE: alpine
>> -    MAKE_CHECK_ARGS: check-avocado
>
> Instead of entirely deleting, I'd suggest adding
>
>    # Disabled due to frequent random failures
>    # https://gitlab.com/qemu-project/qemu/-/issues/1884
>    when: manual
>
> See example: https://docs.gitlab.com/ee/ci/yaml/#when
>
> This disables the job from running unless someone explicitly
> tells it to run

What I don't understand is why we didn't gate the release back when they
first tripped. We should have noticed between:

  https://gitlab.com/qemu-project/qemu/-/pipelines/956543770

and

  https://gitlab.com/qemu-project/qemu/-/pipelines/957154381

that the system tests where regressing. Yet we merged the changes
anyway.

>
>> -
>>  build-system-ubuntu:
>>    extends:
>>      - .native_build_job_template
>> @@ -53,15 +44,6 @@ check-system-ubuntu:
>>      IMAGE: ubuntu2204
>>      MAKE_CHECK_ARGS: check
>>=20=20
>> -avocado-system-ubuntu:
>> -  extends: .avocado_test_job_template
>> -  needs:
>> -    - job: build-system-ubuntu
>> -      artifacts: true
>> -  variables:
>> -    IMAGE: ubuntu2204
>> -    MAKE_CHECK_ARGS: check-avocado
>> -
>>  build-system-debian:
>>    extends:
>>      - .native_build_job_template
>> @@ -127,15 +109,6 @@ check-system-fedora:
>>      IMAGE: fedora
>>      MAKE_CHECK_ARGS: check
>>=20=20
>> -avocado-system-fedora:
>> -  extends: .avocado_test_job_template
>> -  needs:
>> -    - job: build-system-fedora
>> -      artifacts: true
>> -  variables:
>> -    IMAGE: fedora
>> -    MAKE_CHECK_ARGS: check-avocado
>> -
>>  crash-test-fedora:
>>    extends: .native_test_job_template
>>    needs:
>> --=20
>> 2.41.0
>>=20
>>=20
>
> With regards,
> Daniel


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

