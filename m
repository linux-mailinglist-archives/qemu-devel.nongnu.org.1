Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEDE8191BF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 21:55:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFh6W-0007j3-53; Tue, 19 Dec 2023 15:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFh6T-0007iq-Pz
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:54:13 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFh6R-0002Bt-HC
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:54:13 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55370780c74so3117122a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703019249; x=1703624049; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjJwp1/FbGr8Kk+3d7iLOxhGSrD0INwcsCN9U03JsDY=;
 b=uvGR9aTbIempail7WjwH7Jd/A9wDpdZPqbLzPFM2g8SVj7H9+Y2+tpIm8tewIMHLQT
 ikkoB5GXxS+dDArnMq7N536KqpLIMAu6DVMQSU2Jbxcz4f5cpvHW2/wJ2lRVsDGbVR0q
 YMpr6ZDi+5NCtoEfhzE7dX5FgOLUplHwtlO9F52oVc3pyzKcbsq3DL3TrPSdinplyKs8
 CfgB12RG6XXc8nV5xHdEQuTnglkGLIzKDCVE7SGpSiHNwqLHFm8zZYhg1XhzwEGmB9YN
 qJoi2ybdL3uZ9W9Qgd1k/5ArniGA8P87whypc43ySxdsOD/hVu8yZy1ssRcOFJYMemMI
 fb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703019249; x=1703624049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjJwp1/FbGr8Kk+3d7iLOxhGSrD0INwcsCN9U03JsDY=;
 b=EVXXuLxKYQ7YXFDYD315k20HkaFjS36cJXhxOfJmFtsBA33MxubVQwj/QLTvhL05pQ
 9LdO673RJ/m7pJY7wnyYm/umvWWrd5E5DeJmCNk0U0Fa0aUgCQK4PsWb6Um4RS96VGr8
 VbI2wknOF+Eko80c977kQeR3bRJQlgFz8w6TcshJdDyi8RlWdQ2bR9jLcJYcbBBs5bb9
 bqJZm+a7ilE/DDfBs0mhYwuSVvCeeaGBslYkU7HWH4vH3UrLU2aiVQZAsxi7wJ1HZwqc
 QNtCeDFTQPebFgj+ttean6hC7EHrN0SWEWHDcXnCw7oWURSw6CpviqLNMR3Q/Bpc3jZG
 9IUA==
X-Gm-Message-State: AOJu0Yw3hv4GTZU4yFy6RIRNHl4PELb4jwqJCZQkTNr9kWaNblWobj9f
 QlDLFfERNubn9Uu/8j5s6FwDXQZy/HuY2HUi+T7pAg==
X-Google-Smtp-Source: AGHT+IE1D0lPHssi+zfJoHi0qax6JQFIxR9cVS3auJWV4mdkvYY/15hos6pOY99N4nFp7gHg7O/MciMdbqOw38+ca9Q=
X-Received: by 2002:a50:c31d:0:b0:553:af37:d5d0 with SMTP id
 a29-20020a50c31d000000b00553af37d5d0mr465069edb.79.1703019249551; Tue, 19 Dec
 2023 12:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
In-Reply-To: <87plz22d9r.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 20:53:32 +0000
Message-ID: <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
Subject: Re: Qemu resets terminal to crazy defaults
To: Fabiano Rosas <farosas@suse.de>
Cc: Dave Blanchard <dave@killthe.net>, qemu-devel@nongnu.org
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

On Tue, 19 Dec 2023 at 19:40, Fabiano Rosas <farosas@suse.de> wrote:
>
> Dave Blanchard <dave@killthe.net> writes:
>
> > Hello all, can you please help me to understand what Qemu is doing here=
?
> >
> > When connecting to the guest for example using a serial/tcp/telnet link=
, some kind of code is being immediately transmitted over the link which sc=
rews up my Xterm terminal settings, including changing the text cursor shap=
e and most notably, disabling wraparound of long lines, so that they get tr=
uncated at the edge of the window instead.
> >
> > Can this behavior be disabled by command line, and if not, what is the =
code doing exactly so I can know where to disable it? I tried disabling all=
 calls to tcsetattr() but that had no effect.

> I looked into the automatic margins issue a long time ago and I seem to
> remember it was caused by the firmware (SeaBIOS) configuring the
> terminal and QEMU just never returning it to the original state. I
> eventually gave up trying to fix it because I was having trouble finding
> a reliable point in QEMU shutdown sequence to enable the capability
> back. Nowadays I just run 'tput smam' after quitting QEMU.

To check whether this is happening because of the BIOS (or other
guest code) vs QEMU itself, you can try running QEMU in a configuration
where it doesn't run any BIOS code. One I happen to know offhand
is an arm one:

   qemu-system-aarch64 -M virt -serial stdio

This won't print anything, because we haven't loaded any guest
code at all and there's no default BIOS on this machine type.
(The emulated CPU is sat in effectively a tight loop taking
exceptions.) If that messes up the terminal settings, then it's
likely being done by something inside QEMU. If it doesn't, then
it sounds like as you say it'll be because of the SeaBIOS
firmware writing stuff to the terminal.

(There might be a way to run the x86 PC machine without it
running a BIOS, for a similar test, but I don't know if there
is or how to do it off the top of my head.)

I do know that QEMU doesn't clean up things the guest does
to the terminal, because for instance if you have a serial
terminal and the guest puts it into "emit boldface/bright",
that doesn't go back to normal non-bold text when QEMU exits.
(It would be nice if it did do that...)

thanks
-- PMM

