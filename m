Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C080C50F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:45:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcpq-0007NR-Np; Mon, 11 Dec 2023 04:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rCcpk-0007M8-8D
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rCcpi-00029T-59
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702287851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QG89E2BQvLlpJroB6n80NFUI+pRmzq5qN3ID+qnK/Eo=;
 b=hi3nc9WwxstculmcsyZyJY5C1xx4otr2cEKef+M0f9dXtZGS5iQ6CMY6zyZj9chQDHpnuj
 rnvex7pHkC64Y5A4aSuGszAIIPTV79/st09/BtGInW/lzcnE8l6r45bu1eta1y7KfZIAb9
 s6Z55CZW6FKXPEEw2lS+0znvKfe+WCQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-6nTQPrARMTiS79gS0QQSCQ-1; Mon, 11 Dec 2023 04:44:09 -0500
X-MC-Unique: 6nTQPrARMTiS79gS0QQSCQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54cfdd60557so2209107a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702287847; x=1702892647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QG89E2BQvLlpJroB6n80NFUI+pRmzq5qN3ID+qnK/Eo=;
 b=qLadVZS/RNe4epu+CsGLkw+f8X2gMKI+5n8GvUMQAkqfvaNgWpfSlnCYMDogmkL/En
 L5yoYLZXIfELm6urcw1Seq/AjZ8IeQhfCDxw2u2/DyRxPN+V6eDN331uVxI6FFS5NB55
 fiXNbubrMQJ1nGqsoBCD91GGtgP/bYBSwl/TZzDsaw8wG/qJih3bhL5fQOGfjTFfXo+7
 Kqv0jAPbBKFuNsbjuvDPGvDYI+cFpAKUruxPSraatjlRvZYjeT5tmHYuTPq5SQttB/wG
 URyxcSHJXW0cDzEJwxcr8VvzDqpqjh0m1g1XyUK0+/EhEDJ8ODrtTtu/+vPlRzXae5Bv
 tTqg==
X-Gm-Message-State: AOJu0YxcbWxsEquEEXLZKx2GkItKTLSFx/XpLPaNygjSBrl1z+DpibDT
 +dsADalSg+EwxweO0xSrpro04J2j+mZ20+svhujhi50l2PUXR43mQkPNo6o0iL8aznoZChQyoc7
 CjmI/1f/175DmFxu+0I/BDwVKKrL1LIM=
X-Received: by 2002:aa7:d74d:0:b0:54c:4837:759d with SMTP id
 a13-20020aa7d74d000000b0054c4837759dmr2071299eds.73.1702287847554; 
 Mon, 11 Dec 2023 01:44:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1B0PyetPVbByuh2cEYTOfxH0nZ7nOHM7KcP7PCCvzD1qX6WnZGurFNXb2kf8Uv48vEZj7e2W0Wa09j7ovos=
X-Received: by 2002:aa7:d74d:0:b0:54c:4837:759d with SMTP id
 a13-20020aa7d74d000000b0054c4837759dmr2071295eds.73.1702287847269; Mon, 11
 Dec 2023 01:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20231211-vnc-v1-1-a3551d284809@daynix.com>
In-Reply-To: <20231211-vnc-v1-1-a3551d284809@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Dec 2023 13:43:55 +0400
Message-ID: <CAMxuvazT6KbrSe-Y-nPZqPyvsOrvKLaMYhpDwrCD+tJMW1xTWw@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc: Respect bound console
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Dec 11, 2023 at 12:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> ui/vnc may have a bound console so pass it to qemu_console_is_graphic()
> and qemu_text_console_put_keysym().
>
> Fixes: 1d0d59fe2919 ("vnc: allow binding servers to qemu consoles")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 59 ++++++++++++++++++++++++++++++----------------------------=
-
>  1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 4f23a0fa79..ddab42346f 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1931,7 +1931,8 @@ static void do_key_event(VncState *vs, int down, in=
t keycode, int sym)
>      }
>
>      qkbd_state_key_event(vs->vd->kbd, qcode, down);
> -    if (!qemu_console_is_graphic(NULL)) {
> +    if (!qemu_console_is_graphic(vs->vd->dcl.con)) {
> +        QemuTextConsole *con =3D QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
>          bool numlock =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_N=
UMLOCK);
>          bool control =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_C=
TRL);
>          /* QEMU console emulation */
> @@ -1945,88 +1946,88 @@ static void do_key_event(VncState *vs, int down, =
int keycode, int sym)
>              case 0xb8:                          /* Right ALT */
>                  break;
>              case 0xc8:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_UP);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_UP);
>                  break;
>              case 0xd0:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_DOWN);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_DOWN);
>                  break;
>              case 0xcb:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_LEFT);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_LEFT);
>                  break;
>              case 0xcd:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_RIGHT);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_RIGHT);
>                  break;
>              case 0xd3:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_DELETE);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_DELETE);
>                  break;
>              case 0xc7:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_HOME);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_HOME);
>                  break;
>              case 0xcf:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_END);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_END);
>                  break;
>              case 0xc9:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEUP);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEUP);
>                  break;
>              case 0xd1:
> -                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEDOWN);
> +                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEDOWN);
>                  break;
>
>              case 0x47:
> -                qemu_text_console_put_keysym(NULL, numlock ? '7' : QEMU_=
KEY_HOME);
> +                qemu_text_console_put_keysym(con, numlock ? '7' : QEMU_K=
EY_HOME);
>                  break;
>              case 0x48:
> -                qemu_text_console_put_keysym(NULL, numlock ? '8' : QEMU_=
KEY_UP);
> +                qemu_text_console_put_keysym(con, numlock ? '8' : QEMU_K=
EY_UP);
>                  break;
>              case 0x49:
> -                qemu_text_console_put_keysym(NULL, numlock ? '9' : QEMU_=
KEY_PAGEUP);
> +                qemu_text_console_put_keysym(con, numlock ? '9' : QEMU_K=
EY_PAGEUP);
>                  break;
>              case 0x4b:
> -                qemu_text_console_put_keysym(NULL, numlock ? '4' : QEMU_=
KEY_LEFT);
> +                qemu_text_console_put_keysym(con, numlock ? '4' : QEMU_K=
EY_LEFT);
>                  break;
>              case 0x4c:
> -                qemu_text_console_put_keysym(NULL, '5');
> +                qemu_text_console_put_keysym(con, '5');
>                  break;
>              case 0x4d:
> -                qemu_text_console_put_keysym(NULL, numlock ? '6' : QEMU_=
KEY_RIGHT);
> +                qemu_text_console_put_keysym(con, numlock ? '6' : QEMU_K=
EY_RIGHT);
>                  break;
>              case 0x4f:
> -                qemu_text_console_put_keysym(NULL, numlock ? '1' : QEMU_=
KEY_END);
> +                qemu_text_console_put_keysym(con, numlock ? '1' : QEMU_K=
EY_END);
>                  break;
>              case 0x50:
> -                qemu_text_console_put_keysym(NULL, numlock ? '2' : QEMU_=
KEY_DOWN);
> +                qemu_text_console_put_keysym(con, numlock ? '2' : QEMU_K=
EY_DOWN);
>                  break;
>              case 0x51:
> -                qemu_text_console_put_keysym(NULL, numlock ? '3' : QEMU_=
KEY_PAGEDOWN);
> +                qemu_text_console_put_keysym(con, numlock ? '3' : QEMU_K=
EY_PAGEDOWN);
>                  break;
>              case 0x52:
> -                qemu_text_console_put_keysym(NULL, '0');
> +                qemu_text_console_put_keysym(con, '0');
>                  break;
>              case 0x53:
> -                qemu_text_console_put_keysym(NULL, numlock ? '.' : QEMU_=
KEY_DELETE);
> +                qemu_text_console_put_keysym(con, numlock ? '.' : QEMU_K=
EY_DELETE);
>                  break;
>
>              case 0xb5:
> -                qemu_text_console_put_keysym(NULL, '/');
> +                qemu_text_console_put_keysym(con, '/');
>                  break;
>              case 0x37:
> -                qemu_text_console_put_keysym(NULL, '*');
> +                qemu_text_console_put_keysym(con, '*');
>                  break;
>              case 0x4a:
> -                qemu_text_console_put_keysym(NULL, '-');
> +                qemu_text_console_put_keysym(con, '-');
>                  break;
>              case 0x4e:
> -                qemu_text_console_put_keysym(NULL, '+');
> +                qemu_text_console_put_keysym(con, '+');
>                  break;
>              case 0x9c:
> -                qemu_text_console_put_keysym(NULL, '\n');
> +                qemu_text_console_put_keysym(con, '\n');
>                  break;
>
>              default:
>                  if (control) {
> -                    qemu_text_console_put_keysym(NULL, sym & 0x1f);
> +                    qemu_text_console_put_keysym(con, sym & 0x1f);
>                  } else {
> -                    qemu_text_console_put_keysym(NULL, sym);
> +                    qemu_text_console_put_keysym(con, sym);
>                  }
>                  break;
>              }
> @@ -2044,7 +2045,7 @@ static void key_event(VncState *vs, int down, uint3=
2_t sym)
>      int keycode;
>      int lsym =3D sym;
>
> -    if (lsym >=3D 'A' && lsym <=3D 'Z' && qemu_console_is_graphic(NULL))=
 {
> +    if (lsym >=3D 'A' && lsym <=3D 'Z' && qemu_console_is_graphic(vs->vd=
->dcl.con)) {
>          lsym =3D lsym - 'A' + 'a';
>      }
>
>
> ---
> base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
> change-id: 20231211-vnc-f9d7b0880acb
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>


