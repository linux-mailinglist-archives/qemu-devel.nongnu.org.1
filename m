Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B32824350
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:10:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOPt-0005Om-3Y; Thu, 04 Jan 2024 09:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOPq-0005OT-6j
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:09:46 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOPa-00065q-Df
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:09:45 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5569472f775so662763a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704377368; x=1704982168; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DG9a768eSOiKRXSd6TVEHDTth2jwVn7YiKEKDz4EX9g=;
 b=bOl5Iv0f/EWhLk1QgkVe7IL9Z6nCz9qJOFlhMCP+lTg2Jl6OvtNg+nVi/j9WvTLBmc
 Mf24IHn5cQJgYZm7evzm3KJaNGPL29pBPlhjG78SlY4jOdYa5rElgU8WyPvFhOeM2nLg
 YXlVRMoi9Jf5cjdilvR8uYCJCiS103Yk+e10a1uXLYEptjp1u18a78aioFiLmw9LLSEx
 Gv0U66paMGSi/3BFv42wn9OIqLhERp2bcjTb50mV2haYF0gO8DsUZQtVFr16BsYY+RKi
 qAsTxZSqlbjEuc64nO2zX68gTRBQ4S/UybKnUfqMm0e9Rbs7gL5wJLYGTlJfFPzCq82Q
 HTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704377368; x=1704982168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DG9a768eSOiKRXSd6TVEHDTth2jwVn7YiKEKDz4EX9g=;
 b=ICaJzl0xKJvC1s2esNtNqmaPxBNYewvXI/HRmU5+Z6o7RM3MrinCdvXI8py1LX/8gV
 oxHB4yLvFU0vIeOGRaqLDS4PNovCgeveaL+c43beE699wmA6tKQu5BEtCSzTC+Kvdje4
 OKMf9b6lto44QurKzND7Lx+GSofLyJgrY6ZVlTgw6iEAX9qOyuHPoCzCBaT6nFA2CCnA
 kZkgq60GvqR+y0jHNvlrKsgjD4oUpbvejxFe4Icd6oZ5yOi+0UsRYt/g6bQVG2Njuhdr
 TmA0hP1bV2HMTcmYE0sOpvgzFLAlgSksVWnpNie112TUhBR9mM4tDH0qlJNmcd8mTk5M
 5Yyg==
X-Gm-Message-State: AOJu0YzEYuR4YTVv6lIVQYRPBNntsKcHw/vbBEEKUkZBs8VskZFpQbkl
 6Wh9Vg0K+/gTzhMmyGfoenGdFIUKse+UfNZgO5z31j5sfP+pIYkWYtSbGQcY
X-Google-Smtp-Source: AGHT+IGzA5/8CqbHpkT5qSD+IsDQD43PxquRbbyX8QELt69tSnuvtp37Y16UpigYGCkvTWTMTUQwGhb93JC2YWqaD1Y=
X-Received: by 2002:a50:9e0c:0:b0:556:e4da:618b with SMTP id
 z12-20020a509e0c000000b00556e4da618bmr432614ede.10.1704377368258; Thu, 04 Jan
 2024 06:09:28 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <87frzvzafv.fsf@draig.linaro.org> <87a5q3z05l.fsf@draig.linaro.org>
In-Reply-To: <87a5q3z05l.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 14:09:16 +0000
Message-ID: <CAFEAcA-JxRkWCy4VF2NRmOorkvDZYEL-YJ4Aq8+PvXLDJW99qg@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 21 Dec 2023 at 22:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> modified   tests/avocado/tuxrun_baselines.py
> @@ -168,7 +168,7 @@ def run_tuxtest_tests(self, haltmsg):
>      def common_tuxrun(self,
>                        csums=3DNone,
>                        dt=3DNone,
> -                      drive=3D"virtio-blk-device",
> +                      drive=3D"virtio-blk-pci",
>                        haltmsg=3D"reboot: System halted",
>                        console_index=3D0):
>          """
>
> And then we get:
>
>  (1/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv5:=
 PASS (5.64 s)
>  (2/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv7:=
 FAIL: Failure message found in console: "Kernel panic - not syncing". Expe=
cted: "Welcome to TuxTest" (1.21 s)
>  (3/3) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_armv7b=
e: FAIL: Failure message found in console: "Kernel panic - not syncing". Ex=
pected: "Welcome to TuxTest" (1.24 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 2 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
> JOB TIME   : 8.50 s
>
> So I guess this somehow hits ARMv7 only. Maybe something about I/O
> access?
>
>   2023-12-21 18:21:29,424 __init__         L0153 DEBUG| pl061_gpio 903000=
0.pl061: PL061 GPIO chip registered
>   2023-12-21 18:21:29,427 __init__         L0153 DEBUG| pci-host-generic =
4010000000.pcie: host bridge /pcie@10000000 ranges:
>   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic =
4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
>   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic =
4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
>   2023-12-21 18:21:29,428 __init__         L0153 DEBUG| pci-host-generic =
4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
>   2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generic =
4010000000.pcie: can't claim ECAM area [mem 0x10000000-0x1fffffff]: address=
 conflict with pcie@10000000 [mem 0x10000000-0x3efeffff]
>   2023-12-21 18:21:29,429 __init__         L0153 DEBUG| pci-host-generic:=
 probe of 4010000000.pcie failed with error -16

I suspect that this is not the same issue.
You still see this failure even with commit 4446a22b96d1be
reverted; and if you run QEMU with "-machine virt,highmem=3Doff"
which disables the high memory regions on QEMU's end, the test
proceeds to a login prompt.

Either the kernel incorrectly thinks the regions overlap
because it's misreading the dtb, or else we had a regression
in the virt board with how we set the base address for the
upper PCI windows.

thanks
-- PMM

