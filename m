Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D919F7CDC95
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6DP-00006G-RK; Wed, 18 Oct 2023 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1qt6DL-0008TC-T2
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:03:55 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1qt6DK-0007Fu-1A
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:03:55 -0400
Received: by mail-yb1-f169.google.com with SMTP id
 3f1490d57ef6-d9a398f411fso7702472276.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634232; x=1698239032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdycpuLVrzszrN21dw+67+yQgNGaoncSefGig6LAy40=;
 b=pAZ428Lu4QOdupODCKIWr65AUfFi+iX+1ZfvI2m5Pnw0k73PSkxXIrVLwYkhS1p1lK
 3pJbDtRaoznKpcmyItVdDIRLGQg9d240Ww0o5wU0GVLq6T8kec44kfWv3ySigdSnb+HZ
 s4quUu52cKDGRWdfSce1ihG+dk4z24xTyhYOkZcX9tpRPbzmB0/+/AErKLmMId8HEBzs
 1pTgwK6i7yv8vGKBqjsTKWp+oyUqvtZdcF/twGeIcQ/z6aNhM/+m3pgscWO/EicO8Bx2
 Sj5Aa7jF9n99TTjBpuTz+S6sd5VtcZ75/T8LKJlUvnOTl13HigluA2QF/SKZZTlSWIwQ
 Yz7g==
X-Gm-Message-State: AOJu0Yyuyh8Juy6SW6AAPUY9JFExsXarUw5ynciEjDCo7he/mMzj7oCv
 zN1ftmS7Y4X7O9oJe96u95JSKO7XapxJaw==
X-Google-Smtp-Source: AGHT+IEwLFQW/iuhqFTO9yDD2BO7inRhiNm2XlnT4ku3LL1Qtz/MBHm/Zdk44t5CUZpT0N7l37bY+g==
X-Received: by 2002:a25:dfd1:0:b0:d9a:6259:5461 with SMTP id
 w200-20020a25dfd1000000b00d9a62595461mr5644984ybg.38.1697634232296; 
 Wed, 18 Oct 2023 06:03:52 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com.
 [209.85.128.174]) by smtp.gmail.com with ESMTPSA id
 p137-20020a25d88f000000b00d748501d9b4sm1287264ybg.21.2023.10.18.06.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:03:51 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-5a7be88e9ccso85464827b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:03:50 -0700 (PDT)
X-Received: by 2002:a0d:e84a:0:b0:577:3d46:f90e with SMTP id
 r71-20020a0de84a000000b005773d46f90emr5588526ywe.32.1697634230733; Wed, 18
 Oct 2023 06:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231018124023.2927710-1-geert+renesas@glider.be>
 <6fdd4de08a97060b952e0bfa4dd3144d9c23e800.camel@physik.fu-berlin.de>
In-Reply-To: <6fdd4de08a97060b952e0bfa4dd3144d9c23e800.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Oct 2023 15:03:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV39vcBSjxHo6+d82jgZHyLnCdoKjT6-jW4QsD8MZ4dpA@mail.gmail.com>
Message-ID: <CAMuHMdV39vcBSjxHo6+d82jgZHyLnCdoKjT6-jW4QsD8MZ4dpA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
 linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.169;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-yb1-f169.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Adrian,

On Wed, Oct 18, 2023 at 2:46=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-10-18 at 14:40 +0200, Geert Uytterhoeven wrote:
> > The new Linux SH7750 clock driver uses the registers for power-down
> > mode control, causing a crash:
> >
> >     byte read to SH7750_STBCR_A7 (0x000000001fc00004) not supported
> >     Aborted (core dumped)
> >
> > Fix this by adding support for the Standby Control Registers STBCR and
> > STBCR2.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this supposed to be applied on top of Yoshinori's DT conversion series=
?

No, it's a patch for QEMU.  Sorry for the confusion.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

