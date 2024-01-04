Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE08243D6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOlL-0007sI-9I; Thu, 04 Jan 2024 09:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOlI-0007s2-H7
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:31:56 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOlG-0001qz-9t
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:31:56 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cd1919f0acso8116741fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704378712; x=1704983512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sY1dUOY4UTuOIdht7Z8aPlnFk8cfK3vFwjPH0pKESFE=;
 b=TxfADFtWoz08xP/O11FUrVeC+lphlxG523HdYULLZXHXY1fNnDmY7EJvu6+cn6cq3v
 JlVJ0Q4rTsTMa0SbqVssfgp4QD7qfuz5McCuGvBgWiwTbiL8L++yjf+ip4qYODQGFjae
 X5pX7f5Wuk8xGWn8XBJ1m5tc/VLTg0QlnLz2FEokQsiXwNAF6MuohXoll+wd5rCK/uQu
 Ru8/pEdYvVQeNWG84VdY22mxAsUMqt1oZfuCBgBM2hGv8DlFszIS0Vzj3lyQOBHzenYP
 HCHQjlRKJw6Pbf4b47c8eQVCjN2QKW3nCD0TiNaKNmw+koZ1qpbXFy3ThvRgyJjrOCVI
 BbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704378712; x=1704983512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sY1dUOY4UTuOIdht7Z8aPlnFk8cfK3vFwjPH0pKESFE=;
 b=BXS2rr2vFPr+svaMOHTgE5L5nAq0Wr765y0mJU15FTjtonDAXid4Ka6BIfv9eb5vcq
 lnre2K9xgX0zxIyQhfZGIokA+4IDXKlRNXE/pb2C+rWvVQZbTuZ4C8ijBxtnNGb1Lj5y
 ZtU13BCfxku0T7eVpXbaJ+pbUdtQriIoiIEdTKYRpMT3s9jDjCd/u8DNCppU/hElcMVK
 q/YX4cf80hBS6frw1yYlUUf2E8pYbGy8USPNs4jPc1qV8zG/Dz9JIbB6iesIAElTLqs2
 bzborRxZgESuMjJu0k/+xVWIAK9EyToxVyMCSRlew0RtnT8kIZT/gjZUIWZxIoPOLRAG
 gCnQ==
X-Gm-Message-State: AOJu0Yw/PkBPGbw//gdQoAheh4QNwwNUtl/TIvKIysrExjSqGyhjGYrT
 EAruc3/UzhLA5XSZ0lACcEWwwrPoaldZcctHya0h0a+6pzkb6Q==
X-Google-Smtp-Source: AGHT+IH8FEgIQ3b48mntzYGXEVc2hPk2msHYcOeoKh6Gde8M9uGfHc+E0h3QX78hwlfKp/R/jxInWHpayqCwnh6uGm0=
X-Received: by 2002:a2e:7c18:0:b0:2cc:cf5f:b856 with SMTP id
 x24-20020a2e7c18000000b002cccf5fb856mr428577ljc.106.1704378712149; Thu, 04
 Jan 2024 06:31:52 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <87frzvzafv.fsf@draig.linaro.org> <87a5q3z05l.fsf@draig.linaro.org>
 <CAFEAcA-JxRkWCy4VF2NRmOorkvDZYEL-YJ4Aq8+PvXLDJW99qg@mail.gmail.com>
In-Reply-To: <CAFEAcA-JxRkWCy4VF2NRmOorkvDZYEL-YJ4Aq8+PvXLDJW99qg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 14:31:40 +0000
Message-ID: <CAFEAcA_NggN_WOF0Hp_dz8Y4NjrWHiu5i4YZsMe8gOPjnUbkrA@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Thu, 4 Jan 2024 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 21 Dec 2023 at 22:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> > modified   tests/avocado/tuxrun_baselines.py
> > @@ -168,7 +168,7 @@ def run_tuxtest_tests(self, haltmsg):
> >      def common_tuxrun(self,
> >                        csums=3DNone,
> >                        dt=3DNone,
> > -                      drive=3D"virtio-blk-device",
> > +                      drive=3D"virtio-blk-pci",
> >                        haltmsg=3D"reboot: System halted",
> >                        console_index=3D0):
> >          """
> >
> > And then we get:
> >
> >  (1/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv=
5: PASS (5.64 s)
> >  (2/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv=
7: FAIL: Failure message found in console: "Kernel panic - not syncing". Ex=
pected: "Welcome to TuxTest" (1.21 s)
> >  (3/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv=
7be: FAIL: Failure message found in console: "Kernel panic - not syncing". =
Expected: "Welcome to TuxTest" (1.24 s)
> > RESULTS    : PASS 1 | ERROR 0 | FAIL 2 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
> > JOB TIME   : 8.50 s
> >
> > So I guess this somehow hits ARMv7 only. Maybe something about I/O
> > access?
> >
> >   2023-12-21 18:21:29,424 __init__         L0153 DEBUG| pl061_gpio 9030=
000.pl061: PL061 GPIO chip registered
> >   2023-12-21 18:21:29,427 __init__         L0153 DEBUG| pci-host-generi=
c 4010000000.pcie: host bridge /pcie@10000000 ranges:
> >   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generi=
c 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
> >   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generi=
c 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
> >   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generi=
c 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
> >   2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generi=
c 4010000000.pcie: can't claim ECAM area [mem 0x10000000-0x1fffffff]: addre=
ss conflict with pcie@10000000 [mem 0x10000000-0x3efeffff]
> >   2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generi=
c: probe of 4010000000.pcie failed with error -16
>
> I suspect that this is not the same issue.
> You still see this failure even with commit 4446a22b96d1be
> reverted; and if you run QEMU with "-machine virt,highmem=3Doff"
> which disables the high memory regions on QEMU's end, the test
> proceeds to a login prompt.
>
> Either the kernel incorrectly thinks the regions overlap
> because it's misreading the dtb, or else we had a regression
> in the virt board with how we set the base address for the
> upper PCI windows.

Looks like it's the kernel getting this wrong. In the DTB
we say:
reg =3D <0x40 0x10000000 0x00 0x10000000>;
meaning the ECAM region is at 0x40_1000_0000, size 0x1000_0000.
But the kernel thinks:
ECAM area [mem 0x10000000-0x1fffffff]
so it has clearly truncated the address at some point.

There was a bug in non-LPAE kernels ages ago of a similar form,
but it was fixed already in this kernel version, and in any
case this kernel seems to have LPAE enabled. So it must be
a separate bug.

thanks
-- PMM

