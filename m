Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DEE8063FA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 02:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAgSH-0000Cw-Ts; Tue, 05 Dec 2023 20:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgSF-0000Cf-7S; Tue, 05 Dec 2023 20:11:59 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAgSD-0004r1-Do; Tue, 05 Dec 2023 20:11:58 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c74b3cd4cso758779a12.1; 
 Tue, 05 Dec 2023 17:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701825115; x=1702429915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeTZkrB4DzpusmiLoNjG17PsLusgQKfIxgFTzmgYldg=;
 b=ctmYuk+0+hi9YmBLvg7M/yTJj356YUdplUDGP+/bGV7/jw0FsAv613Nlv6Zzftp6Ns
 Ws9lnI0hy8zzx4Fiz9xIJtbiMeRelhMw0iwptpf2srncF1Z03MfOGTJ2PlFnTWCKNwvF
 tn32TcMa7ojQAMhOvbLYQYJbPbAmzWghxTpCrtdFV2pJ0LY0SKr/WLCW7s17Qz1f3Wp1
 bnjXPknUhe7v8aypzwGG4jbuoZNa7L4px57dqBPAeV/MY/P2KbyVUuQweGNIsk/SMl8y
 Mh0WtgL9mEco0Jb+pdH3AL4aEtPSUoJx3Z2wuNQM1B+N/n2NZpKSLxrbsVftpkI2vrxa
 yQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701825115; x=1702429915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeTZkrB4DzpusmiLoNjG17PsLusgQKfIxgFTzmgYldg=;
 b=sIlO+XEFCpxsnTMO8OaSLQdXq3F4zdo1ua4cNoG3lLUchmA2NNXU/u+aR7+rGJg5Ps
 FJcmuP9PdIINAdkBpvnzZd8s4AOsgcEgGSNt/R4YpYBpskBP+jOnpGlnkHM3tqZf2/xy
 mBgkzN1qrIOMZfmxNauxP/r3n/rtTz4eJA1HL8qyPlWwdKqQ/3hzOcSYgcZZMtM3PXF2
 M2DgPswiG9paLaZtED2WrHZa+PwXbT/ICTs2iSzW8olPliOC9jp+RoG62QvkU25t+jrj
 uBws1v9b25sX5+S+FZazuYw3ttEy/3jUEtGRtNcDuXJLZKqe85XDUzc+ahx+TUiecBQT
 E83A==
X-Gm-Message-State: AOJu0Yx6OD6Ox07SIxClJB5Du9zrXoOGIIKDmcm9UqgKGnIJ3YcYCDgA
 50zakOTQQHiVUIMPPgjoDliMRz8/Hmnpd4t13yo=
X-Google-Smtp-Source: AGHT+IH62ITX39Fb5n/vP5AcIVzY+7K+EiiA7J79pLtvo3cY74bvHNMDK+xmJTNnU2p8poK18wV1pL6W2JE4XHfRAsc=
X-Received: by 2002:a50:d557:0:b0:54c:bb9c:4b88 with SMTP id
 f23-20020a50d557000000b0054cbb9c4b88mr128824edj.5.1701825114703; Tue, 05 Dec
 2023 17:11:54 -0800 (PST)
MIME-Version: 1.0
References: <170171757903.6536.10207274798404158986-0@git.sr.ht>
In-Reply-To: <170171757903.6536.10207274798404158986-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 11:11:27 +1000
Message-ID: <CAKmqyKOBjeE68LwisfuYBenKu3vGKHS8SQBeggeLcBrSLYBpJw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/1] Implement STM32L4x5 EXTI
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, peter.maydell@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Dec 5, 2023 at 5:20=E2=80=AFAM ~inesvarhol <inesvarhol@git.sr.ht> w=
rote:
>
> This patch allows to emulate the STM32L4x5 EXTI device.
> It implements register access and software interruptions.
>
> This is RFC because we're new at contributing to QEMU.

Thanks for the patches!

As a general guide, RFCs are for things that you don't think should be
merged. So for example maybe you have half finished something, but you
want to get some feedback, you can send an RFC.

You don't have to send an RFC just because you are unsure if you have
done something correctly. A patch is fine. Although there is no harm
in sending an RFC, usually you get less eye balls on it because
everyone is busy.

> We had some difficulties writing qtests and the result might be bizarre.
>
> We have some questions about the next steps for our stm32l4x5 project :
>
> Should we send a non-RFC patch after this peripheral implementation is
> reviewed,
> or should we wait for more peripherals to be implemented?

Yes!

The easiest way to develop upstream is to send your patches as early
as you can. Obviously you want to test them and make sure they work.
But you don't have to wait for every single thing to be finished. If
you have implemented support in a peripheral you can send those
patches upstream.

Again, as long everything works and is tested it's ready to go. Don't
wait for a year of development before trying to upstream, as that is
harder for you and for reviewers. Get feedback early and often :)

> We have syscfg and uart implementations ongoing.
>
> Also, should the version numbers restart from 1 when sending a non-RFC
> tag ?

Yes, it will reset to "PATCH", and then "PATCH v2" and so on

Alistair

>
> Sincerely,
> In=C3=A8s Varhol
>
>
> Changes from v2 to v3:
> - adding more tests writing/reading in exti registers
> - adding tests checking that interrupt work by reading NVIC registers
> - correcting exti_write in SWIER (so it sets an irq only when a bit goes
> from '0' to '1')
> - correcting exti_set_irq (so it never writes in PR when the relevant
> bit in IMR is '0')
>
> Changes from v1 to v2:
> - use arrays to deduplicate code and logic
> - move internal constant EXTI_NUM_GPIO_EVENT_IN_LINES from the header
> to the .c file
> - Improve copyright headers
> - replace static const with #define
> - use the DEFINE_TYPES macro
> - fill the impl and valid field of the exti's MemoryRegionOps
> - fix invalid test caused by a last minute change
>
> Based-on: <170049810484.22920.612074576971878323-0@git.sr.ht>
> ([RFC v3 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A board)
>
> In=C3=A8s Varhol (1):
>   Implement STM32L4x5 EXTI
>
>  hw/arm/Kconfig                    |   1 +
>  hw/arm/stm32l4x5_soc.c            |  65 +++-
>  hw/misc/Kconfig                   |   3 +
>  hw/misc/meson.build               |   1 +
>  hw/misc/stm32l4x5_exti.c          | 306 +++++++++++++++++++
>  hw/misc/trace-events              |   5 +
>  include/hw/arm/stm32l4x5_soc.h    |   3 +
>  include/hw/misc/stm32l4x5_exti.h  |  58 ++++
>  tests/qtest/meson.build           |   5 +
>  tests/qtest/stm32l4x5_exti-test.c | 485 ++++++++++++++++++++++++++++++
>  10 files changed, 930 insertions(+), 2 deletions(-)
>  create mode 100644 hw/misc/stm32l4x5_exti.c
>  create mode 100644 include/hw/misc/stm32l4x5_exti.h
>  create mode 100644 tests/qtest/stm32l4x5_exti-test.c
>
> --
> 2.38.5
>

