Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB67FF671
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:42:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8k6D-0001fg-Rw; Thu, 30 Nov 2023 11:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r8k67-0001fU-84
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:41:07 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r8k63-0000Cq-SQ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:41:05 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c9b7bd6fffso15809031fa.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701362458; x=1701967258; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsyXXDyAXykqAjb/T5ppI8uWl8n1qg1OdjdBH8wm6vM=;
 b=etnZl35aFnaZAcfneb/YW7xOjnT6CyYtXonpJxbadm0JJYZoVIG0YzXREDI+xSD30j
 DIQvG52DUQb9FmkTh/M1HDGsLOa1hveiaVYGouSASysOOaBBVbnSSeT0Qc5NyAPAKCpX
 IBe1+3ugxnsgk3NISrCNVd5q9gv4uwx4NPQQvSawdDnrljqUqlFVhAKQ0FhGYmSgqROg
 q93lUGx+ITrHOumDat5YQP05c8fJaJX9EnGYJxuqGMby2tjy+WD8qFIFh861IkZ5G5ks
 MunR4GHvDlg4xZ0WDN9A8ZXfyE8OL8HcO7OZlo2+3N+4jx7F3qfLDPhTVxmqTKEP/3SI
 Fsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701362458; x=1701967258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsyXXDyAXykqAjb/T5ppI8uWl8n1qg1OdjdBH8wm6vM=;
 b=osgg7wXuYj3tK5wIT+vJq/hb6FuOY+SoZXyW42/6mofURm28X9LJ0+vgDoqoI+ED1a
 EUN8KbrWSBSvikrdehiS+mC3dS0XBrIOXiiUVo7XNjqSU5VoxYZVltwIaekZsiuvdfE9
 YEbTJz82MZEsLAbV1j5S6QgSPNM+sZAkSQg+XgJGKFKhrvKd7VsdxeTehfAJaBtyqQZb
 1YSchpJ5/lXeZZBDk7aPkmeZMrAnMHUTud2fIEgzaRWMSrxMKsisE++7zdxoDUunN5SH
 5fx118AckEPh699W57vuVDi4QmCPz06JzInvpdpvejtFGnxu+LIun1aJtoHiOU5NUDHH
 hZtA==
X-Gm-Message-State: AOJu0YxQ5Wme8eWsovziHEiLsaL89aRuADF+iF2oklU0y4wuYtWVNPe8
 XIKDiupxuA44fN4/PcUU98lK0hffq0a0C5EV+hor5NQrAkKiTX8L
X-Google-Smtp-Source: AGHT+IF3dMS9Rz9iWdac9/jkopgixoCg+pfD2O2LRP9BgWEweDkPEs3TYPbT8vO9wh368SMFVj/Mil+AEPo7wy4CtVU=
X-Received: by 2002:a05:6402:f19:b0:54b:4067:6278 with SMTP id
 i25-20020a0564020f1900b0054b40676278mr27922eda.26.1701362418461; Thu, 30 Nov
 2023 08:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
 <20231130153333.2424775-3-alex.bennee@linaro.org>
In-Reply-To: <20231130153333.2424775-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Nov 2023 16:40:06 +0000
Message-ID: <CAFEAcA91HawkhdxmQmz-+t1favfWmzJCpgAy6xr_1+AEomEXNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs/devel: rationalise unstable gitlab tests under
 FLAKY_TESTS
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Cleber Rosa <crosa@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Thu, 30 Nov 2023 at 15:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It doesn't make sense to have two classes of flaky tests. While it may
> take the constrained environment of CI to trigger failures easily it
> doesn't mean they don't occasionally happen on developer machines. As
> CI is the gating factor to passing there is no point developers
> running the tests locally anyway unless they are trying to fix things.
>
> While we are at it update the language in the docs to discourage the
> QEMU_TEST_FLAKY_TESTS becoming a permanent solution.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/testing.rst                   | 31 +++++++++++++++---------
>  tests/avocado/boot_linux.py              |  8 +++---
>  tests/avocado/boot_linux_console.py      |  5 ++--
>  tests/avocado/intel_iommu.py             |  5 ++--
>  tests/avocado/linux_initrd.py            |  5 ++--
>  tests/avocado/machine_aspeed.py          |  8 +++---
>  tests/avocado/machine_mips_malta.py      |  8 +++---
>  tests/avocado/machine_rx_gdbsim.py       |  8 +++---
>  tests/avocado/machine_s390_ccw_virtio.py |  2 +-
>  tests/avocado/replay_kernel.py           |  5 ++--
>  tests/avocado/reverse_debugging.py       | 14 +++++++----
>  tests/avocado/smmu.py                    |  5 ++--
>  tests/avocado/tuxrun_baselines.py        |  4 +--
>  13 files changed, 67 insertions(+), 41 deletions(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 22218dbedb..579d1837e0 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -1371,23 +1371,32 @@ conditions. For example, tests that take longer t=
o execute when QEMU is
>  compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` v=
ariable
>  has been used to determine whether those tests should run or not.
>
> -GITLAB_CI
> -^^^^^^^^^
> -A number of tests are flagged to not run on the GitLab CI. Usually becau=
se
> -they proved to the flaky or there are constraints on the CI environment =
which
> -would make them fail. If you encounter a similar situation then use that
> -variable as shown on the code snippet below to skip the test:
> +QEMU_TEST_FLAKY_TESTS
> +^^^^^^^^^^^^^^^^^^^^^
> +Some tests are not working reliably and thus are disabled by default.
> +This includes tests that don't run reliably on GitLab's CI which
> +usually expose real issues that are rarely seen on developer machines
> +due to the constraints of the CI environment. If you encounter a
> +similar situation then mark the test as shown on the code snippet
> +below:
>
>  .. code::
>
> -  @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on G=
itLab')
>    def test(self):
>        do_something()

Can we also say here that when marking a test as flaky:
 * we should raise a github issue giving details of what goes wrong
 * the URL of that issue should be in a comment above the @skipUnless
   line ?

That way we have a history of why we disabled the test and we
might even manage to fix it some day, in which case we'll know
we are able to unmark it as flaky...

> +To run such tests locally you will need to set the environment
> +variable. For example:
> +
> +.. code::
> +
> +   env QEMU_TEST_FLAKY_TESTS=3D1 ./pyvenv/bin/avocado run \
> +      tests/avocado/boot_linux.py:BootLinuxPPC64.test_pseries_tcg

The "env" here is unnecessary (assuming a standard Posix shell);
"VAR=3Dvalue foo" will run "foo" with VAR set to 'value' only
for the duration of that command.

thanks
-- PMM

