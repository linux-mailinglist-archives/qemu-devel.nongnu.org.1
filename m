Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93479A425
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfazf-0007NW-JI; Mon, 11 Sep 2023 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfazQ-0007Je-C2
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:05:44 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfazG-0008Jm-53
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:05:43 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-414b3da2494so25743711cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694415923; x=1695020723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZ0vvN5xpXnv3V3orGZ//WJmXqSomN12daT8mKFIBAk=;
 b=L6GLLNsM+A+ezYfXzApMh7iFE9J/mdtZoJeWZK6sj2sDIj61/hIyueyeLfP/kdliBF
 sokropSoyRYlZcbsqjC/zIjOsk2Oo/IcyX5r8+o4YnKTW5+p1w3dbafs6jq00x4ZGEG0
 hauDzvJBP23KEJlDtAnLwpJKlNsrvXpD/lGe8RpkGR15PVKiquQUhxxB2m8nVDlyYWI5
 u1iD81vCF0Hayc86ucPcSYPs100ln1eQvGQVI+Ei1Py8j1Wb+EZQe0WbvpY7MBlm/2Kr
 oXtY1KCELfoDx1DoyLAVduIf2XI6hdbSW+zm4VvPO+Q0vSlTrfg3Mn6mjD6cHnFNWd79
 PK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694415923; x=1695020723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZ0vvN5xpXnv3V3orGZ//WJmXqSomN12daT8mKFIBAk=;
 b=KTsKqQsCJ7hquLUu0VHpPNqEWWUDo2vjoAagnnRnSB6Iu7YK0qs6CIVQj1zG9XwY7Z
 Sn8MGHxlQxqQ7UIrkl9xyZoQ5LnUmIm/oKCzu9p/H3bs6VCn9+J7AGDKzEjoUKSsGZ/N
 R40PlXSQVAfo+QHsSLYA3FMmGShbyA8sDnYuQ8icJqXyvssbH3QJrGr9gfw0CDYJ92vD
 N90SrruC/mNI4hNc+++FaTmDLuiZhcGomhaCsN7ysHKoliewlJnDr/ZzPkK29GK5/ObY
 Zj6Xk9KVvPdxDokN5OZMq7Qxq2CsiFmOxTAISePXHNNrwF6pS9WvB1DJmVT3fSjW31qV
 QxnQ==
X-Gm-Message-State: AOJu0YwDGHv9i0QX9Y155UYmSAFLa9H/fnrP2f4Q8H8VpCPgwjh1M4xl
 Wfbu3ESiMKeRLg9f3zPiEENQQrGEL+9Yb1hqki02Xz7cahI=
X-Google-Smtp-Source: AGHT+IFfgyE/vdWrOfM74SFgYgvdGA8Q5TCVuqjmRZNBhqt0hY8mMd0u1Y/ut5KxkXaOFoFuM1PTMbWdsMGGNB0Zlhg=
X-Received: by 2002:a05:622a:1393:b0:412:1c5f:4787 with SMTP id
 o19-20020a05622a139300b004121c5f4787mr10036459qtk.67.1694415923365; Mon, 11
 Sep 2023 00:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093928.309361-1-marcandre.lureau@redhat.com>
 <20230801093928.309361-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230801093928.309361-2-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Sep 2023 11:05:11 +0400
Message-ID: <CAJ+F1CKX3RSO=zHus4s5gpN1OvvT2Zn75LchB8PdTMaHLYwwVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vmmouse: use explicit code
To: qemu-devel@nongnu.org
Cc: zhouzongmin@kylinos.cn, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Tue, Aug 1, 2023 at 1:40=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> It's weird to shift x & y without obvious reason. Let's make this more
> explicit and future-proof.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  hw/i386/vmmouse.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index fce13a5cde..cd9ac11afc 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -46,6 +46,11 @@
>
>  #define VMMOUSE_VERSION                0x3442554a
>
> +#define VMMOUSE_MIN_X 0
> +#define VMMOUSE_MIN_Y 0
> +#define VMMOUSE_MAX_X 0xFFFF
> +#define VMMOUSE_MAX_Y 0xFFFF
> +
>  #define TYPE_VMMOUSE "vmmouse"
>  OBJECT_DECLARE_SIMPLE_TYPE(VMMouseState, VMMOUSE)
>
> @@ -106,8 +111,12 @@ static void vmmouse_mouse_event(void *opaque, int x,=
 int y, int dz, int buttons_
>          buttons |=3D 0x08;
>
>      if (s->absolute) {
> -        x <<=3D 1;
> -        y <<=3D 1;
> +        x =3D qemu_input_scale_axis(x,
> +                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_M=
AX,
> +                                  VMMOUSE_MIN_X, VMMOUSE_MAX_X);
> +        y =3D qemu_input_scale_axis(y,
> +                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_M=
AX,
> +                                  VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
>      }
>
>      s->queue[s->nb_queue++] =3D buttons;
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

