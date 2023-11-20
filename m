Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C917F1230
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:37:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52Yr-0006xn-Qp; Mon, 20 Nov 2023 06:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r52Ym-0006xb-Vt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:35:25 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r52Yl-0002KW-F8
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:35:24 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so25743161cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700480122; x=1701084922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AvudzWa6Ei0wMCuedJ9Zzk7wTdYgjhxu6Ld0CiWU3A=;
 b=ZZxJXAcaXDEp3ADOGKH4tZMkC9zifpedrjMhnKvpjfqYWYk82OGjR9HPO/RI9W0jyc
 22JWzbQu8Ut6huFpP58MbC3mkdSNsqQcNcpg0uhB5P0xdl+YQrEs9OPgujEbx5SByysH
 dXX8gwtxYPkHj2SPGCvXk6P2tgraPWxIS41Dn11kU2pf55eaeIcCC+bMmLzinHs7zEsZ
 d6ERTByPb/XnPE7SG0eAOQ9/EHtGfLVtAllK/sQBtgFpkyEeRyTIsmHHjrxVLEIiEx9i
 A/aquzOU7JqUJO53iiOpLTXcLInYVV/iLzhqhMG/cQAyS/tIqzJD1EXmU4Ak0Mkx/coa
 d5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700480122; x=1701084922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5AvudzWa6Ei0wMCuedJ9Zzk7wTdYgjhxu6Ld0CiWU3A=;
 b=EGHFrw7y44YzAJTeqk+tC8oY+FWMLmS7ufkj5dR9372D66xWO71ihRJonyyfAag+4M
 vAE5aHG+9+iVTrVuDAWSrgT0YQdl10R5D4EUUjuTeIZ00I6Fifox6A+pnIm6k7ErHIAX
 CFfGf91LsC9szEMczyfjiDluKs/OVjPXcCc2TUZv9nF4h+Wz8nIf/0FlTtW853K4664Y
 i/0xjGiz7tMD3ivS1YkO978Nmu+I0kT2WnI+vksUDDxJA1efLl6tfeZlJrZjk1NDR3+2
 SWi/VDvxDuYWtjwgDB8fPP3n/nYkIkZA7uDD0eRQAFkwAccyEX+tEiqYnKI9UFR3tGcJ
 VzYQ==
X-Gm-Message-State: AOJu0YxM9hECYXjlKPIBsEF+nYvLJY+SRpVJZ0OVAWFhTeOue9LV20Hl
 pMEQ4F3JNxZusTa9Skq2eLEma+uiB9WV7KLUXps=
X-Google-Smtp-Source: AGHT+IFkO2wbhsHVA8yxBfaZoqgrJ6e0Oi8LM1XhhlFsq6O5EkofxvU7/+6p+Va5tBXC+Uhfm0zKa06Bmd+6my/X1K8=
X-Received: by 2002:ac8:7d41:0:b0:41e:28d1:c8ff with SMTP id
 h1-20020ac87d41000000b0041e28d1c8ffmr11393624qtb.51.1700480122229; Mon, 20
 Nov 2023 03:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20231120112804.9736-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231120112804.9736-1-akihiko.odaki@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Nov 2023 15:35:10 +0400
Message-ID: <CAJ+F1C+p87y5b23x87W-rVm8a9Y9UqDiPd_HsfhkGtYffZ3ksQ@mail.gmail.com>
Subject: Re: [PATCH v2] audio: Free consumed default audio devices
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Nov 20, 2023 at 3:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Failed default audio devices were removed from the list but not freed,
> and that made LeakSanitizer sad. Free default audio devices as they are
> consumed.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> V1 -> V2: Set s->dev NULL after free (Marc-Andr=C3=A9 Lureau)
>
>  audio/audio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index f91e05b72c..8d1e4ad922 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1758,12 +1758,15 @@ static AudioState *audio_init(Audiodev *dev, Erro=
r **errp)
>                  goto out;
>              }
>              s->dev =3D dev =3D e->dev;
> +            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> +            g_free(e);
>              drvname =3D AudiodevDriver_str(dev->driver);
>              driver =3D audio_driver_lookup(drvname);
>              if (!audio_driver_init(s, driver, dev, NULL)) {

Maybe it would be clearer/safer to set s->dev in audio_driver_init() on suc=
cess.

>                  break;
>              }
> -            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> +            qapi_free_Audiodev(dev);
> +            s->dev =3D NULL;
>          }
>      }
>
> --
> 2.42.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

