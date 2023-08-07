Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9C87730D7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 23:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT7KY-000337-Qx; Mon, 07 Aug 2023 16:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qT7KR-00032y-TA
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:59:51 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qT7KQ-0001N5-CV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:59:51 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-40fd6da0325so32854401cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691441988; x=1692046788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxBfUYloKOmzcCJ/FWttEw4Y980/GIhqarY2Bi83C08=;
 b=WDtfnp6dRj2rnU02lm9nmyGbfyk9nYyYZ7d5mOlWrGgg5KjVZ7Lo/KzpCyQWQf90H1
 qA4YXZSlfnXY41fnPlqcyUPcQK+VS/CPP/yogqfH8/c8d0Zjbnw8fvry4HolMMv2v1yc
 +4Oz+qIR0K/aN6zcNOtDgp2JE1NDDUax9bJdUON9+6bOz58lan5F3RVxgScZLDw0t4LF
 PHibNRJdmfQB87wQUvalAonv+3Hhit0c3RCrMR6YZBcglv9CCnHx9r42mHv8FbpXw55x
 Gu+aXH0cw12y2m808QI1Ev7rEWHVsKLM6nysU0KILbRl6bRC87p2iBnM/fLrszyuEK/f
 34hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691441988; x=1692046788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxBfUYloKOmzcCJ/FWttEw4Y980/GIhqarY2Bi83C08=;
 b=LDRM2vA3zDiFbiUBs07biM8kB2EbeU/wTLMhthbX2Ec0x3A15t/vmysfvgIqRcb2aB
 RsItRYiRW9/GD0cbue36On7celU6EUtnslJecB+dLSOnyi+kh7gpCneZAx//Isk6jxZ/
 lM64030BB43R0GA+g58B/tG1n9E3zfvqDZfZjueONWcyqT5u6nqlZqxR1zDgoqnOa2RU
 WX+7A6Gk9KdNTHT95ixeQgR0z1U6KUigduPIYgQHVTscaB2J4Iw9GmiAhh+a4759SzF5
 Smr2ws7T22DvyAZcN5/Sz8en47LcWegrfKuZWuv9sN25xMbm2Crs5XP/GWKrFK9xNGn3
 hBTw==
X-Gm-Message-State: AOJu0YxSMFQzt43e59cYI70K5Xw+Vm9oqoZXEKQnV3F8+0AVV/JCaH+K
 PaZgjNRr0316yaa8FR9c0KTkXjVJgrsZB/NhQIE=
X-Google-Smtp-Source: AGHT+IEBSxe1Dlz3CgQtwyv1t5eoUHZD+caiVa65qTqkQiFrTPY5xTZkjjin/xY50VG1bAWF7jxT4KzFB6XgdIxh5JA=
X-Received: by 2002:ac8:7e93:0:b0:403:b103:248 with SMTP id
 w19-20020ac87e93000000b00403b1030248mr15114952qtj.4.1691441988248; Mon, 07
 Aug 2023 13:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230807201443.2668-1-werner@carne.de>
In-Reply-To: <20230807201443.2668-1-werner@carne.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Aug 2023 00:59:36 +0400
Message-ID: <CAJ+F1CJk_7reShjGcUBGszX2LFpmVUapBibtQnYBpxmWDp+mgw@mail.gmail.com>
Subject: Re: [PATCH] serial COM: windows serial COM PollingFunc don't sleep
To: Werner de Carne <werner@carne.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Werner

On Tue, Aug 8, 2023 at 12:46=E2=80=AFAM Werner de Carne <werner@carne.de> w=
rote:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
> Signed-off-by: Werner de Carne <werner@carne.de>

This changes the polling callback to return 0 when I/O can't be
processed.  in util/main-loop.c, it results in an early break of
os_host_main_loop_wait().

How does that help?

thanks

> ---
>  chardev/char-win.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index d4fb44c4dc..92a7016105 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -28,7 +28,7 @@
>  #include "qapi/error.h"
>  #include "chardev/char-win.h"
>
> -static void win_chr_read(Chardev *chr, DWORD len)
> +static int win_chr_read(Chardev *chr, DWORD len)
>  {
>      WinChardev *s =3D WIN_CHARDEV(chr);
>      int max_size =3D qemu_chr_be_can_write(chr);
> @@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
>          len =3D max_size;
>      }
>      if (len =3D=3D 0) {
> -        return;
> +        return 0;
>      }
>
>      ZeroMemory(&s->orecv, sizeof(s->orecv));
> @@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
>      if (size > 0) {
>          qemu_chr_be_write(chr, buf, size);
>      }
> +
> +    return size > 0 ? 1 : 0;
>  }
>
>  static int win_chr_serial_poll(void *opaque)
> @@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
>
>      ClearCommError(s->file, &comerr, &status);
>      if (status.cbInQue > 0) {
> -        win_chr_read(chr, status.cbInQue);
> -        return 1;
> +        if (win_chr_read(chr, status.cbInQue)) {
> +                       return 1;
> +               }
>      }
>      return 0;
>  }
> @@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
>
>      PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
>      if (size > 0) {
> -        win_chr_read(chr, size);
> -        return 1;
> +       if (win_chr_read(chr, size)) {
> +                       return 1;
> +               }
>      }
>      return 0;
>  }
> --
> 2.28.0.windows.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

