Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A00FC79E512
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNEN-0001oK-Al; Wed, 13 Sep 2023 06:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgNEL-0001mw-74
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:36:21 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgNEI-0008K2-Ec
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:36:20 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso114380461fa.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694601376; x=1695206176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1CLyN/uLtNwrXb9kEaqYZXD/LGXTMfLEloH8cttp1c=;
 b=oudZfg9WS5NF6medWY5MQxu4pix3UmB3Nn0Bls0MieSqlbF92u4CSo+/SMlvuZl0ME
 GbTUW0xsf0K+l+d7Mslp6yIT4tWe4vmBRIxdXRBARDUwNrdSXaFyCLaIjjrq0S7hxhVr
 T6UqaDvpP8gv8cs2+WodvlEUxlQsGzkGnFIDoCLbpK/zsKJrnwUItXm5AzhrUm10ayto
 uNVccQGkxLTXpvcaU/Fvr+Ibq+WxUGP8I/21IG6R36yTKCjBDAyT0jyKdg/AuLRYDU+p
 1h7Tdp/78kCUGHjAiBXQ0HcTC6zFpC+A6Oj0/se+UGQMi4FwG0bitUd/X5jv/tH113+C
 CUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694601376; x=1695206176;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S1CLyN/uLtNwrXb9kEaqYZXD/LGXTMfLEloH8cttp1c=;
 b=J7PC9WqlwAxGTnzPs2T8k/a0LzpOZqq+r+jVkVxJ8xaIJOHuVtE7MsbdbJRsDUgbOx
 TCiN8I5gwszgcF7qGhBqsvEWWn+2F+ROm3pIFwWXowuu9J5vYbiWkUZUgUcr35ZG4A/G
 iN4zhfNEi39e4yznClI5b635Vqc9Z9u/hhvQUD/11W9CCAI7dLExUE1z2w8o0pHlRUVf
 S7gI495rZ8Axh1vYtdyqr2QihAL5gUtzEb08Ks/peTxMfRxBPcKo1WovEkZrs4uC2n8x
 +qRoq2P/hdkJRLZH5rbbh9hDEd+LHvnbFy+SQqMlRgxWyr2gBGjo0JN2mOssG9NGtd7H
 qAvg==
X-Gm-Message-State: AOJu0Yxw3isdi8Vx6sbixjCps7Beo2FvKJORGaSkCKqgi0i6tcoa+TV+
 /VqN3rp5vdnBUCraSlJcAO+UYQ==
X-Google-Smtp-Source: AGHT+IH550V9Q7FZmm01Xi04bFb7nlUSn0w/GuI71fgcZQ0/rEnaVqf9Yi5AASkwO2PUrha3v+fspQ==
X-Received: by 2002:a2e:8699:0:b0:2bc:e2bc:81ff with SMTP id
 l25-20020a2e8699000000b002bce2bc81ffmr1856948lji.51.1694601376234; 
 Wed, 13 Sep 2023 03:36:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c22d100b00403bbe69629sm1659094wmg.31.2023.09.13.03.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 03:36:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 65C0D1FFBB;
 Wed, 13 Sep 2023 11:36:15 +0100 (BST)
References: <20230912150611.70676-1-stefanha@redhat.com>
 <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
 <CAFEAcA_roU-_E4P94km1RF=u6c+GRBxrGP0jS1_dXsRABCymJg@mail.gmail.com>
 <4e335f86-d075-4cc0-af5a-9dca9b3bf261@linaro.org>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Date: Wed, 13 Sep 2023 11:35:12 +0100
In-reply-to: <4e335f86-d075-4cc0-af5a-9dca9b3bf261@linaro.org>
Message-ID: <878r9atl5s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 13/9/23 11:18, Peter Maydell wrote:
>> On Tue, 12 Sept 2023 at 21:00, Thomas Huth <thuth@redhat.com> wrote:
>>> Please don't remove the whole job! Just disable the failing tests withi=
n the job, e.g.:
>>>
>>> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kern=
el.py
>>> --- a/tests/avocado/replay_kernel.py
>>> +++ b/tests/avocado/replay_kernel.py
>>> @@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_pa=
th_xz):
>>>            console_pattern =3D 'Kernel command line: %s' % kernel_comma=
nd_line
>>>            self.run_rr(kernel_path, kernel_command_line, console_patter=
n, shift=3D5)
>>>
>>> +    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
>>>        def test_mips_malta32el_nanomips_4k(self):
>>>            """
>>>            :avocado: tags=3Darch:mipsel
>> Please don't skip unstable tests on gitlab only. If they're
>> unstable, then nobody wants to be running them and wondering
>> if these are flaky tests or real issues, whether theyr'e doing
>> it on gitlab or locally. (I know we already have a lot of these,
>> but the effect is that instead of saying 'make check-avocado'
>> you have to say 'GITLAB_CI=3D1 make check-avocado'.)
>
> Good point, I'll simply use:
>
>         @skip('Pending https://gitlab.com/qemu-project/qemu/-/issues/1884=
')
>
> Looking at other ones:
>
> $ git grep -w @skip tests/avocado/
> tests/avocado/machine_sparc_leon3.py:17:    @skip("Test currently broken")
> tests/avocado/netdev-ethtool.py:89:    @skip("Incomplete reg 0x00178
> support")
> tests/avocado/netdev-ethtool.py:96:    @skip("Incomplete reg 0x00178
> support")
> tests/avocado/replay_kernel.py:333:    @skip("Test currently broken")
> # Console stuck as of 5.2-rc1
> tests/avocado/replay_kernel.py:368:    @skip("nios2 emulation is buggy
> under record/replay")
> tests/avocado/virtio_check_params.py:119:    @skip("break multi-arch CI")
>
> Looking at the first one:
>
> commit 5baecf58ad9fb3ce24d331978526909d0beca482
> Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Date:   Tue Mar 31 12:50:42 2020 +0200
>
>     tests/acceptance/machine_sparc_leon3: Disable HelenOS test
>
>     This test was written/tested around beginning of 2019, but was
>     extracted from a bigger series and posted end of June 2019 [*].
>     Unfortunately I did not notice commit 162abf1a8 was merged by
>     then, which implements the AHB and APB plug and play devices.
>
>     HelenOS 0.6 is expecting the PnP registers to be not implemented
>     by QEMU, then forces the discovered AMBA devices (see [2]).
>
>     Before 162abf1a8, the console was displaying:
>
>       HelenOS bootloader, release 0.6.0 (Elastic Horse)
>       Built on 2014-12-21 20:17:42 for sparc32
>       Copyright (c) 2001-2014 HelenOS project
>        0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
>        0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
>        0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
>        0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
>        0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
>        0x4006d390|0x4006d390: rd image (152678/65889 bytes)
>        0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
>        0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
>        0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
>        0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
>       ABMA devices:
>       <1:00c> at 0x80000100 irq 3
>       <1:00d> at 0x80000200
>       <1:011> at 0x80000300 irq 8
>       Memory size: 64 MB
>
>     As of this commit, it is now confused:
>
>       ABMA devices:
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       <1:3000> at 0x00000000 irq 0
>       ...
>
>     As this test is not working as expected, simply disable it (by
>     skipping it) for now.
>
> More than 3 years passed already, what a disappointment.
> Offending commit is 4 years old.
>
> commit 162abf1a83ddd06ce1618666f84f88ba4dbffe10
> Author: KONRAD Frederic <frederic.konrad@adacore.com>
> Date:   Wed May 15 14:31:32 2019 +0200
>
>     leon3: introduce the plug and play mechanism
>
>     This adds the AHB and APB plug and play devices.
>     They are scanned during the linux boot to discover the various
>     peripheral.
>
> I'm not complaining about that particular commit, I wonder about
> usefulness of disabling tests from unmaintained areas.
>
> Maybe we can commit a date when disabling a test, having a disabled
> test failing _after_ that date, so if it isn't fixed we remove it.
> Smth like,
>
>   @SkipBroken(date=3D'2023-11-15',
>               desc=3D'Pending
>               https://gitlab.com/qemu-project/qemu/-/issues/1884') #
>               Will fail if run after 2023-11-15 and this test isn't
>              fixed
>
> Thoughts?

I like the:

  @skip('Pending https://gitlab.com/qemu-project/qemu/-/issues/1884')

I think trying to do anything more fancy is just going to lead to
frustration later on.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

