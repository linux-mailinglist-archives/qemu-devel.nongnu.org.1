Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59B800C39
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 14:32:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r93b2-00052p-Qt; Fri, 01 Dec 2023 08:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r93b0-00052Y-Qr; Fri, 01 Dec 2023 08:30:18 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r93az-0000Fy-7A; Fri, 01 Dec 2023 08:30:18 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d856210057so286004a34.1; 
 Fri, 01 Dec 2023 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701437413; x=1702042213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH+NVr5dvJ1pbj6ZslFfay8kvyZdy3CtR1L09cAHFFU=;
 b=aPNT10YuyjdMBaFpl+c2v1755AC4G2P5TgL6CsBKU5lsCkSrE5Jj0t+0OkcRZHpTsT
 /IQgjRLDmMXIrlk/1Q0He3/wvuhubKG4GLGprVpgIlsvA/l8EgoiuEvdpimLmBBoaO9c
 YH9dIXvwe0QDI7HZpWP8HtWhcW078ekvesk25eyUvyVMK7OWwePUoU6JDqFrwPMQ4/s8
 C2qeiRb14NE8VBNtc5083vnWYRL2PGgoWyNjcpHeXgry5rmxo4nGtNZmIbdIFZcnDpmB
 fm0SQDGa6o/evxCFyNENl+mw86IsixElsiWOdmhimPAYYD0NeAXp4/tocom2OGOzIJPe
 saZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701437413; x=1702042213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH+NVr5dvJ1pbj6ZslFfay8kvyZdy3CtR1L09cAHFFU=;
 b=Ehyz+/e6/6/4jkbIf87vsXGGzk5IkXpE+y++W1pnVNk7/fdd8Dhb5I+8emP7IqxEZn
 6mW4m0wa/das2vIeseZtzjwrqyMR+7VTtFy4d1oQr+ImlC7t5i9mBVV4A5nTIZJ44zEi
 /vio6J0lXlEF5Cs8+OsH9b/EELapPSE+iblQZEjW4oJ58gRNihxiI/bMm831E3seQIhR
 DfSfQyka4ynZAK+S/P1xiQDFpLvaOPndmnzGfFaQqMsXA/AzScR+jTsHHobMX9s73W63
 uSvFCMZ0jakwYCcN6PeQVdbGV0kTtzNS925NuyquxjCqtMiVQ3zcXGMjWAFEcQnJmrJe
 IsVw==
X-Gm-Message-State: AOJu0YwrhH8u1f92TuYV5Du0rUM6Q3USjD6+cMQDGHKXX2q4vzkbYN4S
 K3JXISNXlFLBHqaDSYqw7q8bbr9Ne95VASlogfw=
X-Google-Smtp-Source: AGHT+IHXTtOeEYVzJ0MUB5wDmesbCYgLew+qvlkXJnbvzcyd1lqJsAFa3O7z82jRVvwWfOtpRp0Cgl2i1zs78AypaqQ=
X-Received: by 2002:a05:6870:7d01:b0:1fa:f387:e0a1 with SMTP id
 os1-20020a0568707d0100b001faf387e0a1mr1270505oab.9.1701437412780; Fri, 01 Dec
 2023 05:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 1 Dec 2023 08:30:00 -0500
Message-ID: <CAJSP0QUzOOinLjVBPak-j4pLoBeaAQX5XFET+7W9JUnrxkNvNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] final fixes for 8.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Beraldo Leal <bleal@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 1 Dec 2023 at 07:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> 8.2 is looking fairly stable but I do have one bug fix for gdbstub
> which I came across while debugging something else. The changes for
> avocado rationalise all flaky tests under the QEMU_TEST_FLAKY_TESTS
> environment variable. The final patch re-adds the flaky tests to the
> CI as a manually run allow_fail job so we can still attempt to debug
> their failure in the place they tend to fall over.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> v2
> --
>
>   - addressed some review comments
>   - emphasised raising a bug for failing tests
>   - drop some tests now missing assets online
>   - fix wrong microblaze target for tests
>
> The following still need review:
>
>   gitlab: build the correct microblaze target
>   tests/avocado: tag sbsa tests as tcg only
>   tests/avocado: drop malta yamon tests
>   tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test
>
> Alex.
>
> Alex Benn=C3=A9e (7):
>   gdbstub: use a better signal when we halt for IO reasons
>   docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
>   tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test
>   tests/avocado: drop malta yamon tests
>   tests/avocado: tag sbsa tests as tcg only
>   gitlab: build the correct microblaze target
>   gitlab: add optional job to run flaky avocado tests
>
>  docs/devel/testing.rst                   | 32 ++++++++++------
>  gdbstub/internals.h                      |  1 +
>  gdbstub/system.c                         |  2 +-
>  .gitlab-ci.d/buildtest.yml               | 32 +++++++++++++++-
>  tests/avocado/boot_linux.py              | 10 +++--
>  tests/avocado/boot_linux_console.py      | 28 ++------------
>  tests/avocado/intel_iommu.py             |  6 ++-
>  tests/avocado/linux_initrd.py            |  7 +++-
>  tests/avocado/machine_aarch64_sbsaref.py |  1 +
>  tests/avocado/machine_aspeed.py          | 10 +++--
>  tests/avocado/machine_mips_malta.py      | 47 ++++--------------------
>  tests/avocado/machine_rx_gdbsim.py       | 10 +++--
>  tests/avocado/machine_s390_ccw_virtio.py |  3 +-
>  tests/avocado/replay_kernel.py           |  8 +++-
>  tests/avocado/reverse_debugging.py       | 16 +++++---
>  tests/avocado/smmu.py                    |  6 ++-
>  tests/avocado/tuxrun_baselines.py        |  5 ++-
>  17 files changed, 122 insertions(+), 102 deletions(-)
>
> --
> 2.39.2
>
>

