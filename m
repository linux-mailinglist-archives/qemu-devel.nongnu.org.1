Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A59A7E4807
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QbY-0004Bf-MP; Tue, 07 Nov 2023 13:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0QbR-0004Av-Rp
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:15:05 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0QbP-0003Za-S3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:15:05 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso10108713a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380902; x=1699985702; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35X5vy4Rj1KmOwRgRttxnTmHWHAYpW/YmQurvBxlCr8=;
 b=Ii9gZNaUntxA32y+VUEoC/LuVpGuVlpJ4or40duhiiH3AEXIBT6jDj7XwPikVHK3ai
 uB6QGLP1tqNyMFIAl4Us/hr94+BFVoK4yd+JSGmzsbgaV7nYRPXcv90HLBILbY7werYi
 stsr0bqGeLLUALnmpJJx2PVOVzpwIuHYv1NMVrBqxAowrPunJTSVBjLN/Bkc12V4/uk+
 1ItnlaRUy8co5WwrXgs4AY+z9hVYWk5+V3POU0tB5+yah4WElERryCq60jYAng1lZNa6
 VW8csNQWuw2LLKSBkQ+EaBgcuDl+FQsaXB3x0WCcaJZlBp2W4b06BcWN+noRNEhANtxk
 RRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380902; x=1699985702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35X5vy4Rj1KmOwRgRttxnTmHWHAYpW/YmQurvBxlCr8=;
 b=F2EW7ExxYo8/r/mm1Uc1OncgoLfV+ROfyohsnBn7GrwJXMQP8lH7aWVKrV+Isd1tbi
 gOxvzp03UK0cooOiKsA8kV9AS9Nkt5Kz7lr39gECKl1YTrBecRvuV56ZdL3Vblug23SY
 YSJeLHH+kfav45NG9PY21dTUQAjOWBVWI0RuDK9M0PklmqmnDBqAp9ujnzxGHHggLtTP
 yAUI6nUryredIJmBjpk3oB1qShYcE+B0QtHsOExNle2z4Od0DuNln4ZQiwPGiCtzjPry
 +C3ADxIOob/jJ+hLXJ8wr8fvXz17wGVIXgM11bJ7FNCqLFkg3wbN/uUoNSW4FNDguzob
 sqLA==
X-Gm-Message-State: AOJu0YwYuFTIEySkSrQIJU/zV4GrSQ/sqcPc7maa7uakY7Fv8SkRcntz
 kE8IPti7Ur314yqSPm2XPisbDbw4KcsMVMnKLZv8kA==
X-Google-Smtp-Source: AGHT+IGhgTK/EoFcRibakNnUErYnYMuDtwEdW3WVLo6RTLpz6SzdjHHkAmKq6ZlP+b1sGYMFBvYuJDI9bkl0rh1QCmI=
X-Received: by 2002:a05:6402:1348:b0:53f:a377:7287 with SMTP id
 y8-20020a056402134800b0053fa3777287mr26864969edw.18.1699380901908; Tue, 07
 Nov 2023 10:15:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
 <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
 <fa33a840-2135-4ba8-9db1-6684275e93c3@gmail.com>
 <092437de-efef-1c1c-00f5-8667792c5226@eik.bme.hu>
 <4cc81579-1b3c-1373-eeb2-0c941b06c5a1@eik.bme.hu>
In-Reply-To: <4cc81579-1b3c-1373-eeb2-0c941b06c5a1@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 18:14:50 +0000
Message-ID: <CAFEAcA-r+KkrM2RJ--OPC6MhpmfkHitBpwpXKUbvzD3ts4hAbw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org, 
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 7 Nov 2023 at 18:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> So if it's tests/qtest/test-hmp.c that seems to try to run a bunch of
> command for each machine AFAIU. This machine needs a firmware image but
> this test seems to run it with -S and never starts the machine so could
> take any file with -bios for that, e.g. -bios vof.bin (thought about -bios
> /dev/null but that does not work but any other file should probably be
> OK). I don't know how to tell test-hmp to use that thogh or to skip this
> machine.
>
> At some point pegasos2 also needed a firmware but this wasn't a problem
> back then. Either this test is new or we could just ignore this error?

The test has been around for a long time, and no, you can't ignore
'make check' failures, they will break the CI. It's one of
the tests we have that test properties that must be true for
all board types (or all devices, in the case of some other
tests). One of the properties is "it ought to start up cleanly
without extra arguments".

pegasos2 works because there's a vof.bin for it in pc-bios/.

thanks
-- PMM

