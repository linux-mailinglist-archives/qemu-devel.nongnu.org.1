Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360EA8063F6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 02:05:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAgLR-0007Cg-Du; Tue, 05 Dec 2023 20:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgLP-0007CT-AJ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 20:04:56 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgLM-0002kb-SH
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 20:04:54 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54ca339ae7aso4349083a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 17:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701824691; x=1702429491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEAbpF2SThmoYW857skSuGD1PSK2La9CB5UpLpPWfhA=;
 b=VFPM14o0Idv+EcWDSG5FGGhLRkU8AwPaKwVN2QitzG7++bXpD4fqX7j3PDpyBxKuqz
 /Wf8jIUM0LOJ9Mffl+Br0OFvW2mjiGeRoV3ajx7+RhusOLdhZTAviksTZZ9KCWvvyp+t
 XzL6cIQC9IUvC5zyPIt3urcWA7oRH8/v5PIjEkqHb3cpEjLtpDPoOgUyUX9gWfMwlswV
 /WvIO2M+twZzRPPo5OObYaJxtDRhp7t7XdlVPG7U9O+suQ123J+yB1/AqixU2Tsa7TvJ
 P6kp1880j0R699SMh45GzN0aPR9rTtoeeHNyArz1JJxuL2WWJjAS3rnnw8QfBdHO+02i
 VsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701824691; x=1702429491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEAbpF2SThmoYW857skSuGD1PSK2La9CB5UpLpPWfhA=;
 b=DG8A3dxOUAF9p8Z9flo/ArgAlQUsJin6lIajZcBq7atl1kfmdh0LdpafKOEqYdWCH4
 cDMplKKiAIRRnax/FwlkU6V3ZfINqRc3KEh+SD5I9wEkS2RHu0dvd2BhdlywQm3H6mqY
 /bNu58S6gpt1TTHTxz06hLdPs1mQkpdovwKIStl9uDGbJuj5F7yRTPga5Ko4RoQTuus2
 cUyv6K/xQRAIRna9HtWWiko8ZsgiiD+3LQMSOoEkpoCCRYSV6GRZ2fKl0rKHdImKf/xK
 gpwsrfNrNSfIX1CSga+uqKU18RM6lE8us3pL+wMIWNTWmHwfrmd+qbgmunCf9609mzcI
 CsgA==
X-Gm-Message-State: AOJu0YxNPQScvkg6IwohBsnZW+uDKor+iCPNkDw4eyPfOfgdVJelc/su
 omPfRJOTGGxo8mW6JlOL6LYVs1k7FdOJytQW46YSoLh47nVH5g==
X-Google-Smtp-Source: AGHT+IEZnn1ZP878VWdGIQcGdd5atijzEygFW9n03+X9u3rTViMyFwUP8BIUbEz9tJxzTMEcEqRjLL+Kt/l93cc/DwU=
X-Received: by 2002:a50:8e12:0:b0:54b:1ca8:851e with SMTP id
 18-20020a508e12000000b0054b1ca8851emr106672edw.2.1701824690805; Tue, 05 Dec
 2023 17:04:50 -0800 (PST)
MIME-Version: 1.0
References: <170152443229.18048.53824064267512246-0@git.sr.ht>
In-Reply-To: <170152443229.18048.53824064267512246-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 11:04:23 +1000
Message-ID: <CAKmqyKN2sZhghq0yweD33DwpE=n1-gicZhSU2nL_j1t9OhC4rw@mail.gmail.com>
Subject: Re: [PATCH qemu v3 00/20] Fix malfunctioning of T2-T5 timers on the
 STM32 platform
To: "~lbryndza" <lbryndza.oss@icloud.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Dec 2, 2023 at 11:40=E2=80=AFPM ~lbryndza <lbryndza@git.sr.ht> wrot=
e:
>
> Current implementation of T2 - T5 times on the STM32 platform does not
> work properly.
> After configuring the timer-counter circuit to report interrupts every
> 10ms, in reality the first interrupt is reported
> only once after a few seconds, while subsequent interrupts do not come.
> The current code also does not properly emulate the operation of even
> the basic functions of the TIME-BASE unit.
> This patch contains fixes that reimplements the basic functionality
> of the time base unit such as up-counting down-counting , and alternate-
> mode up-down counting.
> The ptimer() API is used to emulate timers.
> After applying the patch, STM32 timer works correctly in its basic
> functionality.
> The ISIX-RTOS test unit was used to test the patch.
> Links and instructions can be found below:
>
> https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_pri=
mitives.cpp
> https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.=
md
>
>
> qemu-system-arm -M olimex-stm32-h405  -kernel
> build/tests/libisix/isixunittests.binary -nographic
> unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
> unittests_entry.cpp:83|Exceptions pretest. OK
> 51 selected tests
> [   RUN    ] 01_base_00 TimeBase timer vs systick
> [  1001ms  ] ...
> [   RUN    ] 01_base_01 Basic heap allocator
> [   1ms    ] ...

Great! This is a good step in the right direction.

Each patch needs to have a different title though. The idea is that
each patch describes what that patch is doing. So each commit will
have a title and commit message describing that patch. The cover
letter (this email) will then describe the overarching goal.

Alistair

>
> Lucjan Bryndza (20):
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>   Fixing the basic functionality of STM32 timers
>
>  hw/arm/stm32f405_soc.c             |   2 +-
>  hw/timer/stm32f2xx_timer.c         | 262 +++++++++++++++++++----------
>  include/hw/timer/stm32f2xx_timer.h |  23 ++-
>  3 files changed, 189 insertions(+), 98 deletions(-)
>
> --
> 2.38.5

