Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072717E4826
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qhd-0003gJ-VO; Tue, 07 Nov 2023 13:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0Qha-0003fm-Tq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:21:26 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0QhZ-00057B-9d
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:21:26 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso10075918a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699381283; x=1699986083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltyzVQcYUTEP4DOJZknrO/CqLib4xydUJazDnR8QFss=;
 b=N08tyTF5UfES92wyk1P0QJzmJWMy9dFz6RB5XpW7kBuBYGHWFSa7tJg6P3grrUJTmT
 sYY+sBVbbcWGsqid6QnOxy4oHIemn86OB/nJM1S5SqTxwFZEPJDJwtZT99w962ETFdMp
 J4VD4IWsGjFMiL+jrU33WKX5Df6O+OpP4Ru1orAk1L81z+i4xjB+VfMfDdXfFfM5hfS4
 lVH6q9pExp/C8x5Z7/6s7ViN3+3D9mUehSyxrcEHS+l1Ol1/B1YiHLN8quKOE3m037Pe
 HxA5rUu1jksExsg2H+l4zPwmxqrukk018cM4jl6jEs3IA2lTTfg56kQXqWjyr9diWUHw
 9K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381283; x=1699986083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltyzVQcYUTEP4DOJZknrO/CqLib4xydUJazDnR8QFss=;
 b=OXvPrkUiuqLW9LUQQAyvy+v/5kwEK5HAGZ6qUVApmztVSalMKXbenW4PM7hFxTF0AL
 fiYS9ot5sBe3Rfpfr9x/VrB0oVbYw5yseDWjelsZAvoEnlnHBTDPAmF5kusCMVm629+X
 QGQSXpdWnY2NVECqpqD6cPeMYUWJJj7RO/9UBaDUmGXfnAmWT0GGqtYtghuDUfkUyZ52
 U62EkCZWYBXvMNxStP8pV8DlFFtTpxyDNAEgVQd6DXsk0x2qOD28kVhsV4uiMJ/5um1e
 y/qZjOVhKTvryH8g3ZgMguu6sYQcog1W/wRJrOOXnc5GtQcT/3wq9gufpb+m14kX2kVz
 n6Lg==
X-Gm-Message-State: AOJu0Yygg1M8BTchIUJQe+oK2w4n9YRurHsNQCa1k2ZdAwfVzFmwHSVB
 Ad7SN6gWYqnG2fdyV4R67JfSr1P1Qpvp4Mh/p4B7rA==
X-Google-Smtp-Source: AGHT+IFxat6GfCwJLUEXwSNJlNgvamvtunz+6eStoLa/PlKz7j91Ka5zKIYToA9HDXNqgKGEYliD1N5uosYdRgu1Yqk=
X-Received: by 2002:a50:9552:0:b0:543:7ba6:5bb0 with SMTP id
 v18-20020a509552000000b005437ba65bb0mr15649643eda.35.1699381283554; Tue, 07
 Nov 2023 10:21:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
 <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
 <fa33a840-2135-4ba8-9db1-6684275e93c3@gmail.com>
 <092437de-efef-1c1c-00f5-8667792c5226@eik.bme.hu>
 <4cc81579-1b3c-1373-eeb2-0c941b06c5a1@eik.bme.hu>
 <CAFEAcA-r+KkrM2RJ--OPC6MhpmfkHitBpwpXKUbvzD3ts4hAbw@mail.gmail.com>
 <7757c836-f40c-8bcd-fc9a-187654c497d4@eik.bme.hu>
In-Reply-To: <7757c836-f40c-8bcd-fc9a-187654c497d4@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 18:21:12 +0000
Message-ID: <CAFEAcA_FoXBc1SUpGh_U1GwqqBCwEEOJLXo20wcPi7WBuubjgA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org, 
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 7 Nov 2023 at 18:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 7 Nov 2023, Peter Maydell wrote:
> > On Tue, 7 Nov 2023 at 18:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >> So if it's tests/qtest/test-hmp.c that seems to try to run a bunch of
> >> command for each machine AFAIU. This machine needs a firmware image but
> >> this test seems to run it with -S and never starts the machine so could
> >> take any file with -bios for that, e.g. -bios vof.bin (thought about -bios
> >> /dev/null but that does not work but any other file should probably be
> >> OK). I don't know how to tell test-hmp to use that thogh or to skip this
> >> machine.
> >>
> >> At some point pegasos2 also needed a firmware but this wasn't a problem
> >> back then. Either this test is new or we could just ignore this error?
> >
> > The test has been around for a long time, and no, you can't ignore
> > 'make check' failures, they will break the CI. It's one of
> > the tests we have that test properties that must be true for
> > all board types (or all devices, in the case of some other
> > tests). One of the properties is "it ought to start up cleanly
> > without extra arguments".
>
> I'll send a patch in a minute which hopefully fixes that skipping the exit
> when using qtest and called without -bios.

Yeah, looking at eg hw/mips/malta.c that's what we do there:
we check qtest_enabled() before printing the error about
not being able to load a BIOS blob.

thanks
-- PMM

