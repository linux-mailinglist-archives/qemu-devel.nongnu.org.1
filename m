Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A964836E88
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:56:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyWZ-0007kw-5h; Mon, 22 Jan 2024 12:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyWP-0007kB-3T
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:55:45 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyWN-0006y3-Hd
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:55:44 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso4252349a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705946142; x=1706550942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejeElf4yn55fnBGDRqcp6pLsiBaNoEd7ctNNe2DLq4o=;
 b=JIjDkEMMAVISzbmpshEfzlyGK273KqN6lMkgKxSOQ5rdwTjAxp0v3EU7sLpDmRILE0
 v+vwxAM3LSSUOYtQxtWqT8r1Q1o441kckoTCLUnJXFDy9Gk/XwcuftlYzyiCgoaKe2O2
 5X/Q/y3q0x3YvuH/E0mQ/pvFjEEPc+YrP1CaC525nktfXSQmdFrLOdiQFqaBXd6JyJ1X
 E5fEZK4EhJppDilykoi9TMr4qiIe5ahfsxpqh/HM8Y/splY5Iz5Ys0j+uCOV+2zsaM4Z
 uAn8ltGv/xnyiVnfMK7/kf+a+EER7phAGpMe9Sy/QMThp+gnGSdboNo+9HYgQ9HNqns+
 nvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705946142; x=1706550942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejeElf4yn55fnBGDRqcp6pLsiBaNoEd7ctNNe2DLq4o=;
 b=bCeDwCdIgnE3UC3pFPAGwcj17jt2JpTCKtmOADTCgSAdrhBk8eLhheCWSd6eqQX3C+
 6QOsj7Zdnz5Tn4sXx0WeeWWOqC3hC6IJtTp68FNdNe9clMpbySz0gZamwcd4xyRxV4Qs
 ukr/Ca23u1St310tMze6bC8LykTVmorpqMv4gWqXrecSoG/8YzmrzRcfPdf9iYVbnEuj
 2R0V9qe4HqLNaRSOchLkyX51hgaukcRJZWx8n+zbe6bXOD/+Ri0Jn5RvogtMYsau5yVF
 XE3fEfIL0TCNwXAHXp7TCzPFJiu0QHY63D1lm/6koedh6w3Y6LQhbjaFFyXaKfgIicpP
 PvUA==
X-Gm-Message-State: AOJu0YyR1QgLewSIyySpT0BishVuopM0BAg0W/gY4UgC/ep69FQ5k4GT
 ltNg4rW7PNzBmsQQGBzGq+OP62mxlG1/7q958+lDuHO9ih06tenxMeDVzEbO9qftMGsDtNp83m0
 AWkwRZjqPYhohhLWV+9WN+vmONqC3U+Jw+CFkJw==
X-Google-Smtp-Source: AGHT+IH80paaFmsNvImGnXZ13D4wLqwVkeTg5F6LeKHbxt7bVQ4r2p0hnqehPxM3h/nnuhIxi3letzg/vXlsyp51BNY=
X-Received: by 2002:aa7:c914:0:b0:55a:749f:8b42 with SMTP id
 b20-20020aa7c914000000b0055a749f8b42mr184053edt.6.1705946141700; Mon, 22 Jan
 2024 09:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20240122163607.459769-1-peter.maydell@linaro.org>
 <20240122163607.459769-3-peter.maydell@linaro.org>
 <ceb451fd-c7c6-4ddd-861f-df8e4d897dc5@linaro.org>
In-Reply-To: <ceb451fd-c7c6-4ddd-861f-df8e4d897dc5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:55:30 +0000
Message-ID: <CAFEAcA_Cg1nButGjwOtz9QQMgQS9eY37V-xoC4m=hLnr35DYCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] qemu-options.hx: Improve -serial option documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, 
 Bohdan Kostiv <bogdan.kostiv@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 22 Jan 2024 at 17:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 22/1/24 17:36, Peter Maydell wrote:
> > The -serial option documentation is a bit brief about '-serial none'
> > and '-serial null'. In particular it's not very clear about the
> > difference between them, and it doesn't mention that it's up to
> > the machine model whether '-serial none' means "don't create the
> > serial port" or "don't wire the serial port up to anything".
> >
> > Expand on these points.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   qemu-options.hx | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ced82848637..d8c3fe91de1 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4129,7 +4129,8 @@ SRST
> >       This option can be used several times to simulate up to 4 serial
> >       ports.
> >
> > -    Use ``-serial none`` to disable all serial ports.
> > +    You can use ``-serial none`` to suppress the creation of default
> > +    serial devices.
> >
> >       Available character devices are:
> >
> > @@ -4151,10 +4152,17 @@ SRST
> >           [Linux only] Pseudo TTY (a new PTY is automatically allocated=
)
> >
> >       ``none``
> > -        No device is allocated.
> > +        No device is allocated. Note that
>
> >          for machine types which
> > +        emulate systems where a serial device is always present in
> > +        real hardware, this may be equivalent to the ``null`` option,
> > +        in that the serial device is still present but all output
> > +        is discarded.
>
> Should we deprecate this broken case, suggesting to use ``null``
> instead?

It's machine specific. On systems with pluggable serial devices
it makes sense to use '-serial none' to get rid of them
entirely. On systems where the UARTs are hardwired into the
board, having '-serial none' literally delete the UART device
just breaks guests, which is why those boards make it behave
like '-serial null'. But users should still be able to use
'-serial none' to say "I don't really care about serial here".

(This is why in commit 12051d82f004024d5d we made the chardev
frontend functions cope with having a NULL backend, to avoid
boards having to say "oh, serial_hd(n) is NULL, I must create
a 'null' backend for it", which half of them didn't do.)

thanks
-- PMM

