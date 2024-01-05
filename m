Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33B8255B1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:41:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLlMm-000659-Il; Fri, 05 Jan 2024 09:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLlMk-00064z-Di
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:40:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLlMi-0007yg-Jt
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:40:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ced19f15c3so824228a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704465602; x=1705070402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klNYkt3KRaSo8ShKxrTNAFGyD4ke/A+cj/8a/FPAh1w=;
 b=GCCpvFQ51SzTCF+ek3s0djenrkLyAFC7WKYE3BnAPXdVcprsqp/Ei8dFJXUU3qptAd
 Ef/uh7OsE9KU1jyW18/PP6cNr4rBi9GFtalXYG6LyKjEdsHXuFvVN1FXzNbZQTr2MuES
 pCFZlA9c09Ti4Hkao5fuBJNU/jx2xB4qy4Rtz05wn9vfKGGz4U/6n1UJZKBn5O7z4C9p
 hv2A2IfF6DSwU6mXv6w1jvWTWiIZ8gdS+1jaOJQNGALR8Rk2zfkxgkCns/p14SF7TMBE
 jszD7jMYR0dlNMwk4JZdZtpizyb7e0IuCrFGdXVKKhZpgU/ZzkWVFmD1uUQCW6hL/cDR
 bxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704465602; x=1705070402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klNYkt3KRaSo8ShKxrTNAFGyD4ke/A+cj/8a/FPAh1w=;
 b=CkOUyULmTfdeIXtOc5H9vqoHWbz2LMdtjo4nv1V0WgNKbu7awhVgQkccAnvYrxnQLA
 vrmBJXyl4qB6/3PAh2Va/av0YmNOYHbh1w/TUvd1mHI6fVaXU3x2xPe3ZkKfbg1X85Fc
 UcXEsbbgU/ZKKr+J8pxnUN5f3igiYFZ1fQHAEXVRfMll9LV2vNIVgWfPb3J8r+G7VyG8
 RKjFDU4vCFwWcU1m1BztiEUuYfuSoEeW8xjU/FIPc0J0BPN6Eky70mR6bH6ENN+3+I6M
 bKNY/nRi2N6bWfQvIAm3ZAG2sCJSBs4UC0ChnjWnV5FqOYXDELP9dru9tHGXBmLDGpua
 QxWw==
X-Gm-Message-State: AOJu0Yx/AokCc5DiJvyhAyY+9Ry9sDs7VhGIt7VEkudNd+OvOfrUSilr
 RsayMNclpuFmErL6vqUKNEWMuBb7hff2jXWDbyQGwsmyQrmS
X-Google-Smtp-Source: AGHT+IGUa5RveMfl3Kd5SFsLiLsi1Ulv+LrpSzvdZj7p+isUNZKWVqHYqQMC+bL7cerbpygCaeJ20yKc/yOlITs9PqE=
X-Received: by 2002:a17:90a:1c82:b0:282:d080:feed with SMTP id
 t2-20020a17090a1c8200b00282d080feedmr1947853pjt.40.1704465601959; Fri, 05 Jan
 2024 06:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-2-chigot@adacore.com>
 <104080fa-71d2-41a8-b273-171173d6cb44@linaro.org>
In-Reply-To: <104080fa-71d2-41a8-b273-171173d6cb44@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 5 Jan 2024 15:39:50 +0100
Message-ID: <CAJ307Ei8E8x8Jncy-5+-2KoSwCE12QggKM_ynnAJ_Tg5qgG_nw@mail.gmail.com>
Subject: Re: [PATCH 1/9] sparc/grlib: split out the headers for each
 peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x534.google.com
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

On Fri, Jan 5, 2024 at 3:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 5/1/24 11:24, Cl=C3=A9ment Chigot wrote:
> > ... and move them in their right hardware directory.
> >
> > Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/char/grlib_apbuart.c                       |  4 +--
> >   hw/intc/grlib_irqmp.c                         |  4 +--
> >   hw/sparc/leon3.c                              |  6 ++--
> >   hw/timer/grlib_gptimer.c                      |  4 +--
> >   include/hw/char/grlib_uart.h                  | 30 ++++++++++++++++++=
+
> >   .../hw/{sparc/grlib.h =3D> intc/grlib_irqmp.h}  | 14 +++------
> >   include/hw/timer/grlib_gptimer.h              | 30 ++++++++++++++++++=
+
> >   7 files changed, 74 insertions(+), 18 deletions(-)
> >   create mode 100644 include/hw/char/grlib_uart.h
> >   rename include/hw/{sparc/grlib.h =3D> intc/grlib_irqmp.h} (86%)
> >   create mode 100644 include/hw/timer/grlib_gptimer.h
>
> This still matches the MAINTAINERS patterns, good.
>
> > diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.=
h
> > new file mode 100644
> > index 0000000000..b67da6c62a
> > --- /dev/null
> > +++ b/include/hw/char/grlib_uart.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * QEMU GRLIB UART
> > + *
> > + * Copyright (c) 2024 AdaCore
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
>
> When adding license, SPDX tag is prefered (although not enforced)
> because it eases tools parsing.

Should it be something like this ?
 * SPDX-FileCopyrightText: 20xx-2024 Adacore
 * SPDX-License-Identifier: MIT

Would updating, now, all those files make it better ?

> > + */
> > +
> > +#ifndef GRLIB_UART_H
> > +#define GRLIB_UART_H
> > +
> > +#define TYPE_GRLIB_APB_UART "grlib-apbuart"
> > +
> > +#endif
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

