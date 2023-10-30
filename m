Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB407DBBFC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:42:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTSr-0003zX-TB; Mon, 30 Oct 2023 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxTSa-0003gY-1d
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:41:45 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxTSY-00022g-AV
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:41:43 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so6582556e87.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676900; x=1699281700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZP9PI7JkEjJacQ9m1qwyOCQPGrQtID7iUP9UtdfMpw=;
 b=I5tk00L3Q04w/JbWzK1X3hkwh/Ur2NR5AV6s+MLvtifo5oSAn1pqEohSvX0AjjNkGm
 fTZZHD8rLCQ/JROE2WTJ5NERANqYOVqMMY/k3Dt+kGD3YLfYlZJDresgbNItnbWppdGI
 /kOw8s5cGCD8hVMsM4BXYap2Q3NUr0hL4V+sLTo1N9u3Hg1D0Y0mMBsifsrlCyB0qoqI
 zhTJRDFyk5v8d/pm3/Q2Oh0LsKEodO3gwAO0Zcd/ybHZOUMlc88Ne3QZ9J8PM/qUgic7
 mt6HeOLJ52oGGa9kuv+bSMVGwJcqK3oJxMH36BLf6YJNbp2UOdrIdmuM+xIR3hMm2kuD
 CSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676900; x=1699281700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZP9PI7JkEjJacQ9m1qwyOCQPGrQtID7iUP9UtdfMpw=;
 b=EbJT8TqfBBDbvMdgo7XqTj4w/AlHC+Ax4PyvVhA8T52om2WbWAd/c8kshKE7/hpGUm
 dhCeYZ/p9eEhxdMPfDBiSE7OSfq6GGCldg6GPj7oox4viu2kjFFFRwSWGAIA+6/NYN95
 nk0MSRHGLshjRfIS6OFv7Tf2Q2oDMxoq5b4jm3K2li7JYAX9IuEMtqx2hLcOxEXRkreL
 Niu70AzZHD9k7vDbMuK2wPMuceOoij0/BsUliHKzmo2NCHpg0aNFv/vjS8ce8rATvhu7
 zMmZ+2r1tRjTXsnK1NAD9kKJyAvpezq0/MqDBRTY927tOIXHUGjayMzt688NvD9Dr9i6
 pmRw==
X-Gm-Message-State: AOJu0YwW8QF1A0W1vuUSBXtEymx4QdaltUQYMlOFiDSHTJqrtpPsEZ4a
 dCtCHmf0P17GX8TO4N3R8aDA/9ODvzdrIIy6MFAuFw==
X-Google-Smtp-Source: AGHT+IEQByTsm6cFdlkuI9TD9RMdpy+m1X0votMV73Km/GO0HPZAm4gveSwg7Tyo4uQdJWa7A+kUXkR85KJL1x2cRKo=
X-Received: by 2002:ac2:4adc:0:b0:500:7685:83d with SMTP id
 m28-20020ac24adc000000b005007685083dmr6666215lfp.48.1698676900393; Mon, 30
 Oct 2023 07:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <edf24aec-59cf-d594-7bda-cef3c268a835@linaro.org>
In-Reply-To: <edf24aec-59cf-d594-7bda-cef3c268a835@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2023 14:41:29 +0000
Message-ID: <CAFEAcA_GC8ypM2Y94KCU9Q_dntF6Na+igu-+0JZJ+MvPFE_HcA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 30 Oct 2023 at 13:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> Cc'ing Markus for QObject.
>
> On 30/10/23 12:48, Peter Maydell wrote:
> > Convert the hw/input/stellaris_input device to qdev.
> >
> > The interface uses an array property for the board to specify the
> > keycodes to use, so the s->keycodes memory is now allocated by the
> > array-property machinery.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > v1->v2: drop private/public comment lines
> > ---
> >   include/hw/input/stellaris_gamepad.h | 22 ++++++++-
> >   hw/arm/stellaris.c                   | 26 +++++++---
> >   hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++--------=
-
> >   3 files changed, 89 insertions(+), 32 deletions(-)
>
>
> > diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> > index 96585dd7106..707b0dae375 100644
> > --- a/hw/arm/stellaris.c
> > +++ b/hw/arm/stellaris.c
> > @@ -31,6 +31,7 @@
> >   #include "hw/timer/stellaris-gptm.h"
> >   #include "hw/qdev-clock.h"
> >   #include "qom/object.h"
> > +#include "qapi/qmp/qlist.h"
> >
> >   #define GPIO_A 0
> >   #define GPIO_B 1
> > @@ -1274,16 +1275,27 @@ static void stellaris_init(MachineState *ms, st=
ellaris_board_info *board)
> >           sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(=
nvic, 42));
> >       }
> >       if (board->peripherals & BP_GAMEPAD) {
> > -        qemu_irq gpad_irq[5];
> > +        QList *gpad_keycode_list =3D qlist_new();
>
> I'm trying to understand better qlist_new(), but unfortunately there
> is not much documentation. Looking at how the allocated list was
> released, I found use of g_autoptr in tests/unit/check-qobject.c,
> so I tried:
>
>             g_autoptr(QList) gpad_keycode_list =3D qlist_new();

The API for qdev_prop_set_array() documents that it takes ownership
of the list you pass it (and it ends up calling qobject_unref() on it).
So I think adding g_autoptr() here will result in the memory being
double-freed (once inside qobject_unref() when the refcount
goes to 0, and once when g_autoptr frees it as it goes out of scope)...

> * thread #2, stop reason =3D signal SIGABRT
>    * frame #0: 0x8b1eb11c libsystem_kernel.dylib`__pthread_kill + 8
>      frame #1: 0x8b222cc0 libsystem_pthread.dylib`pthread_kill + 288
>      frame #2: 0x8b132a50 libsystem_c.dylib`abort + 180
>      frame #3: 0x8b049b08 libsystem_malloc.dylib`malloc_vreport + 908
>      frame #4: 0x8b06924c libsystem_malloc.dylib`malloc_zone_error + 104
>      frame #5: 0x8b05b094
> libsystem_malloc.dylib`nanov2_guard_corruption_detected + 44
>      frame #6: 0x8b05a2a8
> libsystem_malloc.dylib`nanov2_allocate_outlined + 404
>      frame #7: 0x0201fdc0 libglib-2.0.0.dylib`g_malloc0 + 36
>      frame #8: 0x02007718 libglib-2.0.0.dylib`g_hash_table_setup_storage
> + 76
>      frame #9: 0x020076b0 libglib-2.0.0.dylib`g_hash_table_new_full + 96

...which is probably why a later memory operation runs into a
malloc data corruption assertion.

thanks
-- PMM

