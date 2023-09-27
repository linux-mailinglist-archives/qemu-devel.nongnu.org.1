Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B437B02A6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSaQ-0006fn-Ee; Wed, 27 Sep 2023 07:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlSaO-0006fQ-MW
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:20:08 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlSaM-0008BZ-T6
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:20:08 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4194d89a6dfso21998711cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695813606; x=1696418406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY5/27jxMmyE4AWw00Dmd6Q8zdY2GNAH8O3Sgd8NmGo=;
 b=NNGjtpUrnB0yO/1cUQEtXHrCsNKqOuEYjm+Z6stRp+faWtFz6QPWWlBASRgvcW819i
 QSz5y4a6pdHwR746LFJey36cct+w0VA7jgN6eMIahI6/JARAVECvay0r73nAyR3PxVBE
 PJlcwPAJ944mO6ZiXSUztW/EGu0cjNpmwQFAsSFHDi0WRraJyMGRl219EvqYsQzC+d1S
 3ee62nbRyKWCsNCwfp6/6GWjXGn8uskIkQ9/Vvi1m6wwk3kyovnEFfPYgWGadPblfnNa
 HK1fc8YlrQJzWMHU7ci5ee1Y8eWCT7ibEErimpnB6l5K5I2pqDrxsQEYSyiCrVsn7d3v
 4+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695813606; x=1696418406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EY5/27jxMmyE4AWw00Dmd6Q8zdY2GNAH8O3Sgd8NmGo=;
 b=NM9YSBTv2tMqvRkQ9yDiu9gy4sAqywLZNTYAWp3QLATTgpwJGjtFZySwU+sNtcZ8tz
 WCSs0X1hBx4ID+lXyIKvxwwwQwHxU8aWZK96iyBwLQn7+EcRVxwDBZq+3TEV9aIM27uY
 IviIWt0/1ruwoWYrLsuFrXzjCDNjjk4ep6EYDv6QIrTdWP10fl3yzAC3VhpZXGlPv7aV
 MLcUEcsrjFf+QbKRFDgbcGUVoMQeXzJxOSl62fAxxngbqZxn+kM/WgqenEvSCjUvnebG
 t5iKtFP01nUx6qN9fgWr3XhzGO1/bW70mfsMlDpZf9Lle6byOZ37/i3K5jgbGICl0Sqx
 3l9w==
X-Gm-Message-State: AOJu0YzWYNxHJ9Jh2yolzyoTNBpYnLCT/Hc5ISgC+ELfHFemeVhhVM9R
 nCquwcC57CLdTLiWO95bHqyXlQPwcpj1cUcWo/I=
X-Google-Smtp-Source: AGHT+IECxDKez0CASrEfHEwXtfU5JKnbRAjtPMNf4e7XaqsLNclGC1z8/k3qug5SfxMnx/RVwskblntIw6PNY8b+138=
X-Received: by 2002:a05:622a:1045:b0:410:8873:aca with SMTP id
 f5-20020a05622a104500b0041088730acamr2162190qte.52.1695813605697; Wed, 27 Sep
 2023 04:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <aAwe9catDmfueb8CnatNB2DVKHAb02dX2Pyz1Io_CJglORjXYYP6Tnb_F7_kA7etfwRgfRiKZxyWl0Jp-SDLNlvm2qwduL_duHJvh9kDjoA=@protonmail.com>
In-Reply-To: <aAwe9catDmfueb8CnatNB2DVKHAb02dX2Pyz1Io_CJglORjXYYP6Tnb_F7_kA7etfwRgfRiKZxyWl0Jp-SDLNlvm2qwduL_duHJvh9kDjoA=@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Sep 2023 15:19:54 +0400
Message-ID: <CAJ+F1C+YGwJ9inCmowktWJFr-mdev6GP-vWDHJOR6KhoJhPeZg@mail.gmail.com>
Subject: Re: qemu-gtk clipboard crash fixes
To: "edmund.raile" <edmund.raile@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

Hi

On Mon, Sep 25, 2023 at 7:08=E2=80=AFPM edmund.raile
<edmund.raile@protonmail.com> wrote:
>
> In response to [gemu-gtk-clipboard freezing and crashing guests](https://=
gitlab.com/qemu-project/qemu/-/issues/1150).
>
> I think I might have a solution for the gtk clipboard sometimes crashing =
guests.
>
> @kolAflash I couldn't have done it without you, figuring out `gtk_clipboa=
rd_wait_is_text_available(clipboard)` was the issue is half the work.
>
> The real issue is that it's blocking and I'd wager that's a big no-no sin=
ce qemu & KVM have to run the VM + OS, preferably as real-time as possible.=
 Something times out and you get a core dump.
>
> So as a replacement, `gtk_clipboard_request_text`, which is async and non=
-blocking is a better choice, hopefully.
> It requires an additional function to handle receiving text.
>
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> From 530db8b6c7adc99f540d7d8cc6122320868326e6 Mon Sep 17 00:00:00 2001
> From: Edmund Raile <edmund.raile@proton.me>
> Date: Sun, 24 Sep 2023 09:46:27 +0200
> Subject: [PATCH 1/1] qemu-ui-gtk clipboard possible fix for crashes

Thanks for the patch, but this is not a proper way to send patches on the M=
L.
See: https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitt=
ing-your-patches

>
> ---
>  ui/gtk-clipboard.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> index 8d8a636fd1..64d4f7ac9d 100644
> --- a/ui/gtk-clipboard.c
> +++ b/ui/gtk-clipboard.c
> @@ -153,6 +153,18 @@ static void gd_clipboard_request(QemuClipboardInfo *=
info,
>      }
>  }
>
> +/* non-blocking clipboard receiver implementation */
> +static void gd_clipboard_text_received_callback(GtkClipboard *clipboard,=
 const gchar *text, gpointer data)
> +{
> +    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
> +    if (text) {
> +        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> +    }
> +
> +    qemu_clipboard_update(info);
> +    qemu_clipboard_info_unref(info);
> +}
> +
>  static void gd_owner_change(GtkClipboard *clipboard,
>                              GdkEvent *event,
>                              gpointer data)
> @@ -170,12 +182,8 @@ static void gd_owner_change(GtkClipboard *clipboard,
>      switch (event->owner_change.reason) {
>      case GDK_OWNER_CHANGE_NEW_OWNER:
>          info =3D qemu_clipboard_info_new(&gd->cbpeer, s);
> -        if (gtk_clipboard_wait_is_text_available(clipboard)) {
> -            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> -        }
> -
> -        qemu_clipboard_update(info);
> -        qemu_clipboard_info_unref(info);
> +        /* gtk_clipboard_wait_is_text_available (blocking) was used here=
 previously and crashed guests */
> +        gtk_clipboard_request_text(clipboard, gd_clipboard_text_received=
_callback, info);

Although this prevents the main loop from blocking immediately in
QEMU, it's unclear why GTK would block in the given issue.

Iow, it may very well be that something else is broken at GTK level,
and we never get the callback either.

Also, there is another "blocking" call in gd_clipboard_request() which
could have the same issue easily and should probably be addressed with
the same patch.


>          break;
>      default:
>          qemu_clipboard_peer_release(&gd->cbpeer, s);
> --
> 2.42.0
>
> don't forget to configure with --enable-gtk-clipboard before building
>
> I'd say my gvt-g win10 VM has become a lot more responsive (was using gtk=
-clipboard besides being broken).
> Paste from the VM is a bit delayed sometimes but I can live with that.
> So far my VM hasn't crashed yet.
>
> I'd like to ask you for help in evaluating my patch.
> The issue linked to in the first line has instructions on the crash case.
>
> It's my first time on the mailing list, I hope I've done this right.
>
> Mr. Lureau CCed here had this to add:
> Blocking the signal handler isn't great either, as we may miss clipboard =
updates. I think we could "reuse" the serial field on info and check in the=
 callback if we don't have the latest, just ignore the result and free.

If you don't intend to use the "serial" approach to discard previous
requests, we should mention in the patch that it assumes Gtk will keep
the requests in order.

--=20
Marc-Andr=C3=A9 Lureau

