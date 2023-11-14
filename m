Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446C7EAFBC
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 13:21:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2sOl-0008BY-TK; Tue, 14 Nov 2023 07:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2sOj-0008BI-I6
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:20:05 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2sOe-0005NX-B1
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 07:20:05 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42033328ad0so35548201cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699964399; x=1700569199; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gctLALT8xLMhRnaFjp6XsEhqzTIgHTmasau9reYb0sg=;
 b=jVEbe7jZOH6i/TfqMk2oxz6ouao2jLQ2UC6AowjTUL6c7rjs8K88qwyULEV2sQk5Qn
 EpYU72Hf2rhVlo96NOVUheki7uKuWsnbVX/p2IjWPL4HjiLbJdBJI4qWyugiRfuvfb5K
 dyaQQEVEyRk/50fgVaXfqPYj8a+qtD2KJHSvp7j8HsqbuOUUAbnqdp5ob3C7SItKFSYo
 Qa6VTCw8gFJC8JsQBOoh48Hn3M0C8mTOX6xHYqyFaVRggkyOcgUYRVrUG7EuTLQ6og7g
 ZoCV2hqKYNMePvZ0JVzfE+a3xZTlNnEHCNujDoD8DRlc8ao6LldO5H48D291wvjufqMW
 cd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699964399; x=1700569199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gctLALT8xLMhRnaFjp6XsEhqzTIgHTmasau9reYb0sg=;
 b=XJ7XME4QIeUmz5In06aXXl/XbM2neQCf0VI9F5C56Cweh7XD4BKQmGWIn/M04DhIHE
 MKdp75ZvtrRlFcf3l6CPFRLKmOY8enp7A5W/i086lC0GrY59ONCeNvNPdYB1xGuKKbzd
 JaWiNbb9zznDZ6SVzt2XY7o4iwy7DkUi0zlOzf7TLQFtEoJC0rWroj8DZwM7rxLKVprF
 dc2isXr2pXF9BXss70RpISTMtnA4K349ii1BE89jTWaZUc6XreQqn46pL2C+pSpG1hxV
 DScD6SSwuLMPlClipnA2AFsKy8yjQBvYIGFDZAnsNlaHtLqCEGZEmb3iEfSeN+aXQ0r7
 MBhA==
X-Gm-Message-State: AOJu0YzsQN58JSXvaPcNYQO0+a+c8bG9mHLsUNmHGHhGaMYBmVE66Xig
 nYWZU0iLd4NwXoXkfqWxKODfTZbqdh3W9TdJvKw=
X-Google-Smtp-Source: AGHT+IHo9SWjv98VPOgcCCHAfhp2C10LqxNucrXZZLEgeLwB+mSJP2Lxrfirhr7d3W07sTuWoQ0jOuEmn+3pTB8eMKg=
X-Received: by 2002:ac8:7f02:0:b0:41e:2aab:8dc with SMTP id
 f2-20020ac87f02000000b0041e2aab08dcmr2160101qtk.37.1699964399064; Tue, 14 Nov
 2023 04:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20231018133621.721259-1-edmund.raile@proton.me>
In-Reply-To: <20231018133621.721259-1-edmund.raile@proton.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 16:19:47 +0400
Message-ID: <CAJ+F1CLoxcTmY7-9eUjyBVaa4z_vTZFneK8SLXxvV5ud7qkAXw@mail.gmail.com>
Subject: Re: [PATCH v3] ui/gtk-clipboard: async owner_change clipboard_request
To: Edmund Raile <edmund.raile@proton.me>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 18, 2023 at 5:38=E2=80=AFPM Edmund Raile <edmund.raile@proton.m=
e> wrote:
>
> Previous implementation of both functions was blocking and caused guest
> freezes / crashes on host clipboard owner change.
>  * use callbacks instead of waiting for GTK to deliver
>    clipboard content type evaluation and contents
>  * evaluate a serial in the info struct to discard old events
>
> Fixes: d11ebe2ca257 ("ui/gtk: add clipboard support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1150
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> ---
>
> Gitlab user kolAflash is to credit for determining that the main issue
> of the QEMU-UI-GTK clipboard is the call to the blocking function
> gtk_clipboard_wait_is_text_available in gd_owner_change, causing guests
> to freeze / crash when GTK takes too long.
> Marc-Andr=C3=A9 Lureau suggested:
>  * gd_clipboard_request might express the same issue due to using
>    gtk_clipboard_wait_for_text
>  * the callbacks could use the QemuClipboardInfo struct's serial field
>    to discard old events
>
> This patch implements asynchronous gd_clipboard_request and
> gd_owner_change with serial checking.
>
> What I haven't implemented is gd_clipboard_notify's
> QEMU_CLIPBOARD_RESET_SERIAL handling, I don't know how to.
>
> Please help me test this patch.
> The issue mentions the conditions, so far it has been stable.
> Note that you will need to build QEMU with `enable-gtk-clipboard`.
> command line options for qemu-vdagent:
> -device virtio-serial,packed=3Don,ioeventfd=3Don \
> -device virtserialport,name=3Dcom.redhat.spice.0,chardev=3Dvdagent0 \
> -chardev qemu-vdagent,id=3Dvdagent0,name=3Dvdagent,clipboard=3Don,mouse=
=3Doff \
> The guests spice-vdagent user service may have to be started manually.
>
> If testing is sufficient and shows no way to break this, we could undo
> or modify 29e0bfffab87d89c65c0890607e203b1579590a3
> to have the GTK UI's clipboard built-in by default again.
>
> Previous threads:
>  * https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06027.html
>  * https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04397.html
> I am not responding to either of the previous threads so as to not break
> anything in the mailing list by correcting my mistake in the subject.
>
>  ui/gtk-clipboard.c | 84 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 14 deletions(-)
>
> diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> index 8d8a636fd1..07fe8b0ce1 100644
> --- a/ui/gtk-clipboard.c
> +++ b/ui/gtk-clipboard.c
> @@ -133,26 +133,85 @@ static void gd_clipboard_notify(Notifier *notifier,=
 void *data)
>      }
>  }
>
> +/*
> + * asynchronous clipboard text transfer callback
> + * called when host (gtk) is ready to deliver to guest
> + */
> +static void gd_clipboard_request_text_callback
> +    (GtkClipboard *clipboard, const gchar *text, gpointer data)
> +{
> +    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
> +

No need for cast with a gpointer.

> +    if (!text || !qemu_clipboard_check_serial(info, true)) {
> +        return;
> +    }
> +
> +    qemu_clipboard_set_data(info->owner, info, QEMU_CLIPBOARD_TYPE_TEXT,
> +                            strlen(text), text, true);
> +    return;

drop that return; line

unref(info) (see below)

> +}
> +
> +/*
> + * asynchronous clipboard data transfer initiator
> + * guest requests, host delivers when ready
> + */
>  static void gd_clipboard_request(QemuClipboardInfo *info,
>                                   QemuClipboardType type)
>  {
>      GtkDisplayState *gd =3D container_of(info->owner, GtkDisplayState, c=
bpeer);
> -    char *text;
>
>      switch (type) {
>      case QEMU_CLIPBOARD_TYPE_TEXT:
> -        text =3D gtk_clipboard_wait_for_text(gd->gtkcb[info->selection])=
;
> -        if (text) {
> -            qemu_clipboard_set_data(&gd->cbpeer, info, type,
> -                                    strlen(text), text, true);
> -            g_free(text);
> -        }
> +        gtk_clipboard_request_text
> +            (gd->gtkcb[info->selection],
> +             gd_clipboard_request_text_callback, info);

You should ref() info here

>          break;
>      default:
>          break;
>      }
>  }
>
> +/*
> + * asynchronous clipboard text availability notification callback
> + * called when host (gtk) is ready to notify guest
> + */
> +static void gd_owner_change_text_callback
> +    (GtkClipboard *clipboard, const gchar *text, gpointer data)
> +{
> +    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
> +
> +    static uint32_t notification_serial_last;
> +
> +    /*
> +     * performing the subtraction of uints as ints
> +     * is a neat trick to guard against rollover issues
> +     */
> +    if (!text ||
> +        (((int32_t)(info->serial - notification_serial_last)) <=3D 0))

You should only handle the last update, so a simple comparison with a
GtkDisplayState clipboard_request_serial field should do.

> +    {
> +        goto end;
> +    }
> +
> +    notification_serial_last =3D info->serial;
> +
> +    info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> +    qemu_clipboard_update(info);
> +
> +    goto end;

drop that line

> +
> +end:
> +    /*
> +     * this notification info struct is temporary
> +     * and can safely be freed after use
> +     */
> +    qemu_clipboard_info_unref(info);
> +    return;

needless return;

> +}
> +
> +/*
> + * asynchronous clipboard data availability notification initiator
> + * host notifies guest when ready
> + */
>  static void gd_owner_change(GtkClipboard *clipboard,
>                              GdkEvent *event,
>                              gpointer data)
> @@ -160,22 +219,19 @@ static void gd_owner_change(GtkClipboard *clipboard=
,
>      GtkDisplayState *gd =3D data;
>      QemuClipboardSelection s =3D gd_find_selection(gd, clipboard);
>      QemuClipboardInfo *info;
> +    static uint32_t notification_serial;

You should use a GtkDisplayState field instead.
>
>      if (gd->cbowner[s]) {
>          /* ignore notifications about our own grabs */
>          return;
>      }
>
> -
>      switch (event->owner_change.reason) {
>      case GDK_OWNER_CHANGE_NEW_OWNER:
>          info =3D qemu_clipboard_info_new(&gd->cbpeer, s);
> -        if (gtk_clipboard_wait_is_text_available(clipboard)) {
> -            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> -        }
> -
> -        qemu_clipboard_update(info);
> -        qemu_clipboard_info_unref(info);
> +        info->serial =3D ++notification_serial;
> +        gtk_clipboard_request_text
> +            (clipboard, gd_owner_change_text_callback, info);
>          break;
>      default:
>          qemu_clipboard_peer_release(&gd->cbpeer, s);
> --
> 2.42.0
>
>
>


--
Marc-Andr=C3=A9 Lureau

