Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A67CF0E1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNF8-00036k-9B; Thu, 19 Oct 2023 03:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1qtNF3-0002zI-1O
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:14:50 -0400
Received: from mail-yw1-f175.google.com ([209.85.128.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1qtNF0-0002dt-Qc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:14:48 -0400
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-5a8628e54d4so4214827b3.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699685; x=1698304485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpvXWo/6V1i22b/w1LnolG7teO3Wcdy7rN1XpA4/nIw=;
 b=btIGj87f+elf8+bILqkv6Mjz4jznhA1AEPDGnQarxejUsNXRnyzGBY+WD9oxZnszpD
 ip78j6x4lKOMVBQrPVSAA/5gf2CvS1f0wYCgjeUIhOvnqF6sgmQx1QqufwP5ZF+tAuZ3
 OfqpqOK+kedsoOtak0yblhRfwD+7BBYIA4DBuddNVtH5ba0b+viky+iMYzFkDu1RDvwU
 FKxk5C4obmKKgteEDUr9fdxCxQ3imid2jUH9UZ2wka7TNhA3JZvvixAysv16Ep9cARzv
 JM0p8VclqLvZHFK7MuBa2Yc9oJF4PdXB+zQjblQzZeWg+jtXuBf5m8tOeMO/izHv/CDe
 tNiw==
X-Gm-Message-State: AOJu0YzwqWj7sIRSD2N6xB+U6ID8fus4yrrs4c1ARLuWvg7npcAF+F5V
 hmnUICJDUzoEj4Ft0mUTUFTuYfYVoKoC4g==
X-Google-Smtp-Source: AGHT+IH0AU9SOZvgxhQA5PvYOWaiXbBh+SYf+UB1FyCR1c9E7KdfD5KKUz5v8Ad41Qah13XI4el7OQ==
X-Received: by 2002:a81:8341:0:b0:5a7:d8c8:aa17 with SMTP id
 t62-20020a818341000000b005a7d8c8aa17mr867702ywf.13.1697699684961; 
 Thu, 19 Oct 2023 00:14:44 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com.
 [209.85.128.175]) by smtp.gmail.com with ESMTPSA id
 y82-20020a0dd655000000b005a7ab32d454sm2221887ywd.10.2023.10.19.00.14.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 00:14:44 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-59e88a28b98so4105187b3.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:14:44 -0700 (PDT)
X-Received: by 2002:a0d:d710:0:b0:5a5:575:e944 with SMTP id
 z16-20020a0dd710000000b005a50575e944mr848560ywd.4.1697699684389; Thu, 19 Oct
 2023 00:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231018124023.2927710-1-geert+renesas@glider.be>
 <875y338j2c.wl-ysato@users.sourceforge.jp>
In-Reply-To: <875y338j2c.wl-ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Oct 2023 09:14:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7aMoaXUyvb5AHd5ZgbQ7LQhg1GF--yGRG3RZUhj6kBA@mail.gmail.com>
Message-ID: <CAMuHMdW7aMoaXUyvb5AHd5ZgbQ7LQhg1GF--yGRG3RZUhj6kBA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
 linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.175;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-yw1-f175.google.com
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

Hi Sato-san,

On Thu, Oct 19, 2023 at 4:03=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Wed, 18 Oct 2023 21:40:23 +0900,
> Geert Uytterhoeven wrote:
> > The new Linux SH7750 clock driver uses the registers for power-down
> > mode control, causing a crash:
> >
> >     byte read to SH7750_STBCR_A7 (0x000000001fc00004) not supported
> >     Aborted (core dumped)
> >
> > Fix this by adding support for the Standby Control Registers STBCR and
> > STBCR2.
>
> FRQCR is also not returning the correct value, so it needs to be fixed.

I knew there would be more, hence the RFC ;-)

> Here are my changes.
> https://gitlab.com/yoshinori.sato/qemu.git
>
> It include.
> - Minimal CPG support.
> - DT support
> - Add target LANDISK.

Thank you very much!
It would be a good idea to mention this is the cover letter of your
Linux patch series, so your test audience doesn't have to fix
already-solved problems...

BTW, your commit da64d6541226a516 ("hw/sh4: sh7750.c allow access
STBCR and STBCR2.") just ignores writes, and always returns zero
when reading.  This may cause issues with Linux code relying on
clock_ops.is_enabled() to return correct data.

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

