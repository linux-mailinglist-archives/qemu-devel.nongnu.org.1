Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BD97D97F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Sep 2024 20:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sri4h-0003TF-GE; Fri, 20 Sep 2024 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sri4e-0003Rm-I4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 14:09:44 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sri4a-0003NH-OH
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 14:09:44 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-535dc4ec181so2345897e87.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1726855778; x=1727460578;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LacxQpJuK2J3AiMcw1FAtS734utUTVehtpy/NRIDDsY=;
 b=bRDE6u6T12WLu5hD8bNehpLgmJInQtQCab66pyLAAkhE7d90qpIBdhV4boKBbW1RXo
 me/kmdSfFiTzW0xokeptDzI1eKZfsLK2WqPVKew/MmWX5zcxHPEaWJKWhPLYXd4E0sF8
 UYGW2vl082V2j8NM2rzUt7QMlRd5+4a/QiBHxh/fM9n+9QOiHbmW6b0KbR1BKituk6JA
 QCQr5eOhWVCpV14SQF1TVoKKMIK1/zqwgU9hhgrZri6SvPjef17/IKdBOw2hIs0236d0
 QgEeOEYB7ocuthX7jqneG/y4KpkA0u0j+ClrpsBeTWlYvzTAw/ivJ1t7BkbQk7sLT45B
 9ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726855778; x=1727460578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LacxQpJuK2J3AiMcw1FAtS734utUTVehtpy/NRIDDsY=;
 b=cJN2u/bvHki5UfRG6Scx9yc16gZfi3gkdOTlH9450X1bok7gQJHlG0GVwQy3bHlPsM
 NrEbA2sA/5bY82vj0FIRa1gcjCr9OYGo/HW2MviW+fpbHI4A9DrKllKeHYoRv7m67Lp5
 CTr8yL924owM/+PB87rkTkEej4VHyKo4fiMF14Ii87k3mA/yqzx85fkydIfugN8vnrcr
 5zuf7TIOIpDDwtWpdN9q5ycVH/o/CRZhPVhV3h90VYcaannrl8A8Z1JGgAaD09lImMG+
 V8MFl3X6lGxRGJLfQwzJKh94gd4pUjpkWqyACrM7eLxEG3yNpvOU9ac/YJ8KK6ApZL79
 mBwg==
X-Gm-Message-State: AOJu0YzQl9Z5EUkXtyEZ4/WMn8LvVBktGQ7ptq7gzGqgnwzpsn/3KYQl
 HzqMnMhAIAvMrQ1BjjxsLAO/f7/1xW5/rOlLZ0mw2n199fyJm3QX+EYVOTxgWdFMDNBH3j6bw+L
 nlNxLO6dFiiNMlTeu2twOaNbGSKShwjwlKCEd/EkC3oR6l0oYBDE=
X-Google-Smtp-Source: AGHT+IFSj3n+69exar9gYLkq4atrEl3bEYdcmhpTf/uN+awbYylXl4LDamhKlsJMXRuzlyxuk91Z6vp51wNL4uRKwTs=
X-Received: by 2002:a05:6512:6c9:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-536ad3d7205mr2289035e87.39.1726855777687; Fri, 20 Sep 2024
 11:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
 <20240918192254.3136903-9-tavip@google.com>
 <Zus1YzMOZD1ppO-2@mail.minyard.net>
 <CAGWr4cSvq+WnUQO3-8jyasQPhKGQCvzOYqRm5W8vRdhW9iU=xw@mail.gmail.com>
 <ZutGsQglLtK7MtRB@mail.minyard.net>
 <CAFEAcA_ZUkz8xv_PP27nD_eRL18v0cU6A7K+K57b8ML-9pmodQ@mail.gmail.com>
 <CAGWr4cScq6+KQi2aJWtgSUSt+j28wXsxP240FfzTrCAFGRV14g@mail.gmail.com>
In-Reply-To: <CAGWr4cScq6+KQi2aJWtgSUSt+j28wXsxP240FfzTrCAFGRV14g@mail.gmail.com>
From: Corey Minyard <corey@minyard.net>
Date: Fri, 20 Sep 2024 13:09:26 -0500
Message-ID: <CAB9gMfosdyNxRS4N+pt+oHCXoQ2enV7Ot+ws7enuts0XOMUp5g@mail.gmail.com>
Subject: Re: [PATCH 08/25] hw/i2c: add support for flexcomm i2c
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::12f;
 envelope-from=corey@minyard.net; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Thanks, this all looks good to me.  And FIELD() is the right way to
go, as Peter said.

-corey

On Fri, Sep 20, 2024 at 1:03=E2=80=AFPM Octavian Purdila <tavip@google.com>=
 wrote:
>
> On Thu, Sep 19, 2024 at 2:36=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Wed, 18 Sept 2024 at 22:31, Corey Minyard <corey@minyard.net> wrote:
> > > Generally it's frowned upon to have a ton of extra stuff that's not
> > > used.  I would think some is ok, like defining bits in registers that
> > > aren't used yet, but I have no idea how all the enums below here
> > > actually tie into anything.  I'm guessing these are just bitmasks int=
o
> > > registers, but really, it's a lot easier to read if you have somethin=
g
> > > like:
> > >
> > > /*
> > >  * The I2C Master function enable. When disabled, the Master
> > >  * configuration settings are not changed, but the Master function is
> > >  * internally reset.
> > >  */
> > > #define FLEXCOMM_I2C_CFG_MSTEN (1 << 4)
> >
> > The FIELD macro already gives you that:
> >   FIELD(FLEXCOMM_I2C_CFG, MSTEN, startbit, len);
> > will define an R_FLEXCOMM_I2C_CFG_MSTEN_MASK (which is
> > (1 << startbit) for the 'len =3D=3D 1' case).
> >
> > You can also set and read a 1 bit field the same as
> > any other, with the FIELD_DP32/FIELD_EX32 macros, so
> > you don't often need to directly use the MASK macro:
> >   s->cfg =3D FIELD_DP32(s->cfg, CFG, MSTEN, 1);
> > and
> >   if (FIELD_EX32(s->cfg, CFG, MSTEN)) {
> >      ...
> >   }
> >
> > The FIELD() macros are a bit unwieldy sometimes but the
> > advantage over ad-hoc #defines is that they're consistent
> > for every field in every register.
> >
> > I agree that providing enums for the possible values for 1-bit
> > fields is a bit superfluous.
> >
>
> I went ahead and removed those 1-bit enum values and added support to
> filter register/fields when generating the code. Also converted the
> enums to defines to make these a little bit more compact as I don't
> think we have any advantage over the enums?
>
> So with the following invocation:
>
>   run_target('svd-flexcomm-i2c', command: svd_gen_header +
>     [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h=
',
>       '-p', 'I2C0', '-t', 'FLEXCOMM_I2C',
>       '--fields', 'CFG TIMEOUT:TOMIN MSTCTL MSTDAT
> STAT:MSTPENDING,MSTSTATE INT*:MSTPENDING* SLV*:'])
>
> I am getting the below generated file. Note that the register info is
> generated for all registers because this information is used to
> initialize the reset values, mask writes appropriately in registers
> and trace register access.
>
> Please let me know if this looks good or if there are any other tweaks
> I could make.
>
> /*
>  * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
>  *
>  * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
>  */
> #pragma once
>
> #include "hw/register.h"
>
> /* I2C Bus Interface */
> #define FLEXCOMM_I2C_REGS_NO (1024)
>
> /* Configuration Register */
> REG32(FLEXCOMM_I2C_CFG, 0x800);
> /* Master Enable */
> FIELD(FLEXCOMM_I2C_CFG, MSTEN, 0, 1);
> /* Slave Enable */
> FIELD(FLEXCOMM_I2C_CFG, SLVEN, 1, 1);
> /* Monitor Enable */
> FIELD(FLEXCOMM_I2C_CFG, MONEN, 2, 1);
> /* I2C bus Time-out Enable */
> FIELD(FLEXCOMM_I2C_CFG, TIMEOUTEN, 3, 1);
> /* Monitor function Clock Stretching */
> FIELD(FLEXCOMM_I2C_CFG, MONCLKSTR, 4, 1);
> /* High Speed mode Capable enable */
> FIELD(FLEXCOMM_I2C_CFG, HSCAPABLE, 5, 1);
>
> /* Status Register */
> REG32(FLEXCOMM_I2C_STAT, 0x804);
> /* Master Pending */
> FIELD(FLEXCOMM_I2C_STAT, MSTPENDING, 0, 1);
> /* Master State code */
> FIELD(FLEXCOMM_I2C_STAT, MSTSTATE, 1, 3);
> /* Idle. The Master function is available to be used for a new transactio=
n. */
> #define FLEXCOMM_I2C_STAT_MSTSTATE_IDLE 0
> /*
>  * Receive ready. Received data is available (in Master Receiver mode). A=
ddress
>  * plus Read was previously sent and Acknowledged by a slave.
>  */
> #define FLEXCOMM_I2C_STAT_MSTSTATE_RECEIVE_READY 1
> /*
>  * Transmit ready. Data can be transmitted (in Master Transmitter mode).
>  * Address plus Write was previously sent and Acknowledged by a slave.
>  */
> #define FLEXCOMM_I2C_STAT_MSTSTATE_TRANSMIT_READY 2
> /* NACK Address. Slave NACKed address. */
> #define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_ADDRESS 3
> /* NACK Data. Slave NACKed transmitted data. */
> #define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_DATA 4
>
> /* Interrupt Enable Set Register */
> REG32(FLEXCOMM_I2C_INTENSET, 0x808);
> /* Master Pending interrupt Enable */
> FIELD(FLEXCOMM_I2C_INTENSET, MSTPENDINGEN, 0, 1);
>
> /* Interrupt Enable Clear Register */
> REG32(FLEXCOMM_I2C_INTENCLR, 0x80C);
> /* Master Pending interrupt clear */
> FIELD(FLEXCOMM_I2C_INTENCLR, MSTPENDINGCLR, 0, 1);
>
> /* Time-out Register */
> REG32(FLEXCOMM_I2C_TIMEOUT, 0x810);
> /* Time-out time value, the bottom 4 bits */
> FIELD(FLEXCOMM_I2C_TIMEOUT, TOMIN, 0, 4);
>
> /* Interrupt Status Register */
> REG32(FLEXCOMM_I2C_INTSTAT, 0x818);
> /* Master Pending */
> FIELD(FLEXCOMM_I2C_INTSTAT, MSTPENDING, 0, 1);
>
> /* Master Control Register */
> REG32(FLEXCOMM_I2C_MSTCTL, 0x820);
> /* Master Continue(write-only) */
> FIELD(FLEXCOMM_I2C_MSTCTL, MSTCONTINUE, 0, 1);
> /* Master Start control(write-only) */
> FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTART, 1, 1);
> /* Master Stop control(write-only) */
> FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTOP, 2, 1);
> /* Master DMA enable */
> FIELD(FLEXCOMM_I2C_MSTCTL, MSTDMA, 3, 1);
>
> /* Master Data Register */
> REG32(FLEXCOMM_I2C_MSTDAT, 0x828);
> /* Master function data register */
> FIELD(FLEXCOMM_I2C_MSTDAT, DATA, 0, 8);
>
> /* Slave Control Register */
> REG32(FLEXCOMM_I2C_SLVCTL, 0x840);
>
> /* Slave Data Register */
> REG32(FLEXCOMM_I2C_SLVDAT, 0x844);
>
> /* Slave Address Register */
> REG32(FLEXCOMM_I2C_SLVADR0, 0x848);
>
> /* Slave Address Register */
> REG32(FLEXCOMM_I2C_SLVADR1, 0x84C);
>
> /* Slave Address Register */
> REG32(FLEXCOMM_I2C_SLVADR2, 0x850);
>
> /* Slave Address Register */
> REG32(FLEXCOMM_I2C_SLVADR3, 0x854);
>
> /* Slave Qualification for Address 0 Register */
> REG32(FLEXCOMM_I2C_SLVQUAL0, 0x858);
>
>
> #define FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(_name) \
>     struct RegisterAccessInfo _name[FLEXCOMM_I2C_REGS_NO] =3D { \
>         [0 ... FLEXCOMM_I2C_REGS_NO - 1] =3D { \
>             .name =3D "", \
>             .addr =3D -1, \
>         }, \
>         [0x200] =3D { \
>             .name =3D "CFG", \
>             .addr =3D 0x800, \
>             .ro =3D 0xFFFFFFC0, \
>             .reset =3D 0x0, \
>         }, \
>         [0x201] =3D { \
>             .name =3D "STAT", \
>             .addr =3D 0x804, \
>             .ro =3D 0xFCF57FAF, \
>             .reset =3D 0x801, \
>         }, \
>         [0x202] =3D { \
>             .name =3D "INTENSET", \
>             .addr =3D 0x808, \
>             .ro =3D 0xFCF476AE, \
>             .reset =3D 0x0, \
>         }, \
>         [0x203] =3D { \
>             .name =3D "INTENCLR", \
>             .addr =3D 0x80C, \
>             .ro =3D 0xFCF476AE, \
>             .reset =3D 0x0, \
>         }, \
>         [0x204] =3D { \
>             .name =3D "TIMEOUT", \
>             .addr =3D 0x810, \
>             .ro =3D 0xFFFF0000, \
>             .reset =3D 0xFFFF, \
>         }, \
>         [0x205] =3D { \
>             .name =3D "CLKDIV", \
>             .addr =3D 0x814, \
>             .ro =3D 0xFFFF0000, \
>             .reset =3D 0x0, \
>         }, \
>         [0x206] =3D { \
>             .name =3D "INTSTAT", \
>             .addr =3D 0x818, \
>             .ro =3D 0xFFFFFFFF, \
>             .reset =3D 0x801, \
>         }, \
>         [0x208] =3D { \
>             .name =3D "MSTCTL", \
>             .addr =3D 0x820, \
>             .ro =3D 0xFFFFFFF0, \
>             .reset =3D 0x0, \
>         }, \
>         [0x209] =3D { \
>             .name =3D "MSTTIME", \
>             .addr =3D 0x824, \
>             .ro =3D 0xFFFFFF88, \
>             .reset =3D 0x77, \
>         }, \
>         [0x20A] =3D { \
>             .name =3D "MSTDAT", \
>             .addr =3D 0x828, \
>             .ro =3D 0xFFFFFF00, \
>             .reset =3D 0x0, \
>         }, \
>         [0x210] =3D { \
>             .name =3D "SLVCTL", \
>             .addr =3D 0x840, \
>             .ro =3D 0xFFFFFCF4, \
>             .reset =3D 0x0, \
>         }, \
>         [0x211] =3D { \
>             .name =3D "SLVDAT", \
>             .addr =3D 0x844, \
>             .ro =3D 0xFFFFFF00, \
>             .reset =3D 0x0, \
>         }, \
>         [0x212] =3D { \
>             .name =3D "SLVADR0", \
>             .addr =3D 0x848, \
>             .ro =3D 0xFFFF7F00, \
>             .reset =3D 0x1, \
>         }, \
>         [0x213] =3D { \
>             .name =3D "SLVADR1", \
>             .addr =3D 0x84C, \
>             .ro =3D 0xFFFF7F00, \
>             .reset =3D 0x1, \
>         }, \
>         [0x214] =3D { \
>             .name =3D "SLVADR2", \
>             .addr =3D 0x850, \
>             .ro =3D 0xFFFF7F00, \
>             .reset =3D 0x1, \
>         }, \
>         [0x215] =3D { \
>             .name =3D "SLVADR3", \
>             .addr =3D 0x854, \
>             .ro =3D 0xFFFF7F00, \
>             .reset =3D 0x1, \
>         }, \
>         [0x216] =3D { \
>             .name =3D "SLVQUAL0", \
>             .addr =3D 0x858, \
>             .ro =3D 0xFFFFFF00, \
>             .reset =3D 0x0, \
>         }, \
>         [0x220] =3D { \
>             .name =3D "MONRXDAT", \
>             .addr =3D 0x880, \
>             .ro =3D 0xFFFFFFFF, \
>             .reset =3D 0x0, \
>         }, \
>         [0x3FF] =3D { \
>             .name =3D "ID", \
>             .addr =3D 0xFFC, \
>             .ro =3D 0xFFFFFFFF, \
>             .reset =3D 0xE0301300, \
>         }, \
>     }

