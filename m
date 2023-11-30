Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB67FF806
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:19:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8kfR-0003j5-Gp; Thu, 30 Nov 2023 12:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8kfP-0003ip-P2
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:17:35 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8kfN-0006Ne-NI
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:17:35 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bc59115c2so1736024e87.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701364650; x=1701969450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncJF/tFfi+Vxe0JJs5NOco4mWvPIcg//viVvFk0VtvY=;
 b=M+2yvn0cXzK4R1GpF+b70l323LU6Bp66wlwt4mKfMQ/eK2MFOxrS42aWg1yO1nKt6T
 DgUHolhBa9UaHNc78KMEqnZlFXQjy5yl52ruVuKjA5EsncL2qH/z/Gn/aNChv0YKtm4i
 9bnnmSCBAploOdvXpPHFP8+Q7VZ1B+tCsifyL1O9Fi35vh1r+aF4Q/B+gx/5FAvR2cXv
 7HCnHOh17tOeS/l+AMYYJO/MP50pxTUd8ZJICwPx0UuwdfvHUeEzChGE3wrHejIqdB04
 J9caSGGO3fYSyJIpUMgPUkUz+ydLKhQFlQacHX7HIQiWkrrt9gO13D+mI8v8Tcyd27Sj
 HmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701364650; x=1701969450;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ncJF/tFfi+Vxe0JJs5NOco4mWvPIcg//viVvFk0VtvY=;
 b=YpyZvk3+KsFSWXeFAQ9bEWLhj6ZY9hr7388Gw+5Lio2mOr8nKwlNvW3J9V/U6Qctj1
 aUeahHBVl1XBcj7yccmr2BEEt5KfFgwoIrniCB4vSCFH4wMmtDLqbjiU6pmscJ3f4meb
 vXXFhnPCMIzxr2+JhmNmoocT12PB/d1JG/rV5MqEJ0zsbtoqxJdvnJE1+UEA/peC/ziU
 HhYdTiYJDYqbSNeiXNqUnjadP9KlERLJnJutlzL+gVmhcUlD/Y4BElCf5tfuw6ormVZv
 BgAn7TJYQ04yJ8wEb2jrE5VJ2NZPeZuuuvpPteStjDDD2GcJqE+jepfo3WcP3TZMtbtU
 A++A==
X-Gm-Message-State: AOJu0YwoZaoASDCFfL8ms36W4tVT4pCVt1VdQ/DYIjt5uVPGor0lNUNk
 vDC0PHplmrCvBuew3ZEyEd5Qv/Q9tgoGyNZYxmD2wg==
X-Google-Smtp-Source: AGHT+IHyBf4gryM8usvsVL6eA443ep2RuQutoKDbkZG5wHeNkd2kuLvfvE/b9UBAhP595RxEKL/Guw==
X-Received: by 2002:a17:906:3bc6:b0:a19:83cc:530e with SMTP id
 v6-20020a1709063bc600b00a1983cc530emr52030ejf.11.1701363977149; 
 Thu, 30 Nov 2023 09:06:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm2013005wrm.27.2023.11.30.09.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:06:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00C9F5FB51;
 Thu, 30 Nov 2023 16:59:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Cleber Rosa
 <crosa@redhat.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?=
 <philmd@linaro.org>,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@kaod.org>,  Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org,  Halil Pasic <pasic@linux.ibm.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Aurelien Jarno <aurelien@aurel32.net>,
 qemu-s390x@nongnu.org,  Beraldo Leal <bleal@redhat.com>,  Joel Stanley
 <joel@jms.id.au>,  Paolo Bonzini <pbonzini@redhat.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3] docs/devel: rationalise unstable gitlab tests under
 FLAKY_TESTS
In-Reply-To: <CAFEAcA91HawkhdxmQmz-+t1favfWmzJCpgAy6xr_1+AEomEXNg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 30 Nov 2023 16:40:06 +0000")
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
 <20231130153333.2424775-3-alex.bennee@linaro.org>
 <CAFEAcA91HawkhdxmQmz-+t1favfWmzJCpgAy6xr_1+AEomEXNg@mail.gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 30 Nov 2023 16:59:55 +0000
Message-ID: <87jzpz6ut0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 30 Nov 2023 at 15:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> It doesn't make sense to have two classes of flaky tests. While it may
>> take the constrained environment of CI to trigger failures easily it
>> doesn't mean they don't occasionally happen on developer machines. As
>> CI is the gating factor to passing there is no point developers
>> running the tests locally anyway unless they are trying to fix things.
>>
>> While we are at it update the language in the docs to discourage the
>> QEMU_TEST_FLAKY_TESTS becoming a permanent solution.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  docs/devel/testing.rst                   | 31 +++++++++++++++---------
>>  tests/avocado/boot_linux.py              |  8 +++---
>>  tests/avocado/boot_linux_console.py      |  5 ++--
>>  tests/avocado/intel_iommu.py             |  5 ++--
>>  tests/avocado/linux_initrd.py            |  5 ++--
>>  tests/avocado/machine_aspeed.py          |  8 +++---
>>  tests/avocado/machine_mips_malta.py      |  8 +++---
>>  tests/avocado/machine_rx_gdbsim.py       |  8 +++---
>>  tests/avocado/machine_s390_ccw_virtio.py |  2 +-
>>  tests/avocado/replay_kernel.py           |  5 ++--
>>  tests/avocado/reverse_debugging.py       | 14 +++++++----
>>  tests/avocado/smmu.py                    |  5 ++--
>>  tests/avocado/tuxrun_baselines.py        |  4 +--
>>  13 files changed, 67 insertions(+), 41 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 22218dbedb..579d1837e0 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -1371,23 +1371,32 @@ conditions. For example, tests that take longer =
to execute when QEMU is
>>  compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` =
variable
>>  has been used to determine whether those tests should run or not.
>>
>> -GITLAB_CI
>> -^^^^^^^^^
>> -A number of tests are flagged to not run on the GitLab CI. Usually beca=
use
>> -they proved to the flaky or there are constraints on the CI environment=
 which
>> -would make them fail. If you encounter a similar situation then use that
>> -variable as shown on the code snippet below to skip the test:
>> +QEMU_TEST_FLAKY_TESTS
>> +^^^^^^^^^^^^^^^^^^^^^
>> +Some tests are not working reliably and thus are disabled by default.
>> +This includes tests that don't run reliably on GitLab's CI which
>> +usually expose real issues that are rarely seen on developer machines
>> +due to the constraints of the CI environment. If you encounter a
>> +similar situation then mark the test as shown on the code snippet
>> +below:
>>
>>  .. code::
>>
>> -  @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>> +  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on =
GitLab')
>>    def test(self):
>>        do_something()
>
> Can we also say here that when marking a test as flaky:
>  * we should raise a github issue giving details of what goes wrong
>  * the URL of that issue should be in a comment above the @skipUnless
>    line ?
>
> That way we have a history of why we disabled the test and we
> might even manage to fix it some day, in which case we'll know
> we are able to unmark it as flaky...

Good idea, I'll update.

>
>> +To run such tests locally you will need to set the environment
>> +variable. For example:
>> +
>> +.. code::
>> +
>> +   env QEMU_TEST_FLAKY_TESTS=3D1 ./pyvenv/bin/avocado run \
>> +      tests/avocado/boot_linux.py:BootLinuxPPC64.test_pseries_tcg
>
> The "env" here is unnecessary (assuming a standard Posix shell);
> "VAR=3Dvalue foo" will run "foo" with VAR set to 'value' only
> for the duration of that command.

Ahh I habit I've picked up from running a fish shell. Do we want to
assume everyone's interactive shell is Posix compatible?

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

