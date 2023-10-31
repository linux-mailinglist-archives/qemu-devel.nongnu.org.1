Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438787DCE5D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpEN-0000VB-6Q; Tue, 31 Oct 2023 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpDk-0000Ny-VA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:55:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpDh-0000kU-U4
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:55:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso8855422a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698760546; x=1699365346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS2UNgnPcFMlj8ETZ/dlqbFi7v/mKjcFcXiUAGOAbsU=;
 b=iyO8vy1Pbok0edip3S2waHly70mjUQqeiypsDqctJB/qWx1+zgvCgKPxkoXbeYKjPJ
 Dch1I/lrKhhXrNDhGzeNNZbjyEx37722+Q/7a+g1jIganSihRQW5NsurmxqofuSi1dMk
 KtG6cHRBkXQoeQ+ITuBPgUmb0tlYaqKQVytqxySL0JrxCyLH/Ps70GUo3+e9dLbsl1U2
 XKzegEIW2FITsN0HdlZdTINoqpy+nGBnu6GC/GX4Qfa3ylrxPs5Qz86foX2dYOZHyAXW
 gbzS/zrDMRD2ejTZUv/jAeP70eqD8Cx/lJYQZ2S4CM4p8SQDNYFQsdHV5N/nTcltdnCh
 KCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760546; x=1699365346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mS2UNgnPcFMlj8ETZ/dlqbFi7v/mKjcFcXiUAGOAbsU=;
 b=vKxMmrBkA4DM7fedA4mrxUnfWLbzSPUfl4fMaT1bTH8jG578w80dfyKlKyI6dXatio
 8kEX8kfpUHu74FLEH32KaFiL+Adz90zgj3VC8yqaErfj+y3OlDoHmu7M0dq/XcqNwtiK
 sVkJF9Y2YIBRjT/A19DALCVDt8dUpx2MAHgTShkD+ET3i9julKHXreteBrJizSpvYGj5
 7ytcpjVZEvek/2NL+Ajs2yWDiIftvjfEG/oVhUpuVZdTS4RUI3g3RBUbl7ioTGq/qrla
 258umzqsPz8fM4P6M2uwGbq7b3oqY+v+tFJnKYCRGKKN80fTgT5h5Lp5D3/WgNnFvQqw
 lKHw==
X-Gm-Message-State: AOJu0YxvzpVCmDL7cOp27UTjY1iCwtPE5+/3oGDqcZWL5goJblQnGUGQ
 UAo9pj/S6+dm2ih6RvPofL7IojuKkZjI7ZLRq64Now==
X-Google-Smtp-Source: AGHT+IEcnp2gNjoI60C+IeiIhHTucBlrnv+vcnQeov0wTqussOpaPASzpjouSr6Qwn/Wd9paY+jzVA9NIem0fWT0DDQ=
X-Received: by 2002:aa7:d74f:0:b0:53e:3b8f:8a5a with SMTP id
 a15-20020aa7d74f000000b0053e3b8f8a5amr9099063eds.39.1698760545910; Tue, 31
 Oct 2023 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
 <20231030114802.3671871-6-peter.maydell@linaro.org>
 <9ea5c9b8-d740-4cec-9896-568babeca9aa@ilande.co.uk>
In-Reply-To: <9ea5c9b8-d740-4cec-9896-568babeca9aa@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 13:55:34 +0000
Message-ID: <CAFEAcA9dJnp0CVOzVWV+Q-U4ji9c8=14ggztKGktCSsDDp_F0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hw/input/stellaris_input: Convert to qdev
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 30 Oct 2023 at 20:38, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 30/10/2023 11:48, Peter Maydell wrote:
>
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
> >
> > diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/st=
ellaris_gamepad.h
> > index 23cfd3c95f3..6140b889a28 100644
> > --- a/include/hw/input/stellaris_gamepad.h
> > +++ b/include/hw/input/stellaris_gamepad.h
> > @@ -11,8 +11,26 @@
> >   #ifndef HW_INPUT_STELLARIS_GAMEPAD_H
> >   #define HW_INPUT_STELLARIS_GAMEPAD_H
> >
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> >
> > -/* stellaris_gamepad.c */
> > -void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
> > +/*
> > + * QEMU interface:
> > + *  + QOM array property "keycodes": uint32_t QEMU keycodes to handle
> > + *  + unnamed GPIO outputs: one per keycode, in the same order as the
> > + *    "keycodes" array property entries; asserted when key is down
> > + */
> > +
> > +#define TYPE_STELLARIS_GAMEPAD "stellaris-gamepad"
> > +OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
> > +
> > +struct StellarisGamepad {
> > +    SysBusDevice parent_obj;
>
> Minor style comment: for QOM types there should be an empty line after pa=
rent_obj to
> aid identification (as per
> https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-=
declarations).

Fixed.

> > +static const TypeInfo stellaris_gamepad_info =3D {
> > +    .name =3D TYPE_STELLARIS_GAMEPAD,
> > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(StellarisGamepad),
> > +    .class_init =3D stellaris_gamepad_class_init,
> > +};
> > +
> > +static void stellaris_gamepad_register_types(void)
> > +{
> > +    type_register_static(&stellaris_gamepad_info);
> > +}
> > +
> > +type_init(stellaris_gamepad_register_types);
>
> Is it worth converting this to use DEFINE_TYPES() during the conversion? =
I know Phil
> has considered some automation to remove the type_init() boilerplate for =
the majority
> of cases.

I could, I guess. It seems a bit awkward that DEFINE_TYPES()
wants you to pass it an array even when you only have one type,
though, which is going to be a very common use case.

-- PMM

