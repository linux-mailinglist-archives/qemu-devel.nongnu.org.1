Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769176AE90
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlpm-0001Cn-UL; Tue, 01 Aug 2023 05:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qQlpl-0001CR-D3
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:38:29 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qQlpi-0004fv-Q3
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:38:29 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-40fcc91258fso8323221cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690882704; x=1691487504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrTvMbsk1MslcgTIKZMjIlMWOaCD0Gl/oqXJ2fOQ/PA=;
 b=eUe/lQRgVEmiIVQE5AZ/Hk6oTxwaXm500X+uhuYdXdLxT6GckMQsVxXQaJCnAQYON3
 7QBsuRW4Ed1YZ+8ICcwCPw89xidrR0O9Ty0p6WiWkddrh6WN6ACKjFFHXl2WGUJqEylE
 bQ9qb7MMXQEmcy0v1CF4FC19lUHIAJYhQyyJt9xqEKdZ06lWNB2BwF/DaiPBf8bxHrTd
 Y6D4GKUfLub71VStVuKEuzYRiiGaN5ZWjMWFEeBus0vTsM61yg8l/4dyzN5/CWumftvq
 +aI6nz2umbrJiLyNeofhruaOqBCIuTRzRXGqjURhRdqT5VQ1Ld6gS4UaiHmLHRjTK0su
 W+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690882704; x=1691487504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrTvMbsk1MslcgTIKZMjIlMWOaCD0Gl/oqXJ2fOQ/PA=;
 b=d6EW4ovBmFSYGBDoo1mWC23I8/DtT0y2TE8VABsMwVQy7ud2AjKqxoyTonoHeUtFlI
 iKTHyXoAyK+elIc3JpPeFFVXoUCg7J/n7vhr0JsAqHBnXCQOpzJh9y5+hw2z5UUml0Mf
 h52KekmDcjrmy5bW9C9EqlGnK56DHc+QSnMnbLiENdhIH0uWTS42/EKT25093sfkzRSL
 4nfd6D4znRqdBUXxjG5rDC1OqzItrC71+oumCR9AsCdubBCwf3bSM6Q7NX/oKzAGiAFW
 sIjdS8j6vSl76JhSWoSU0VawG9lCUG7TOghRqzZthIMOQ2eoDyPmQHbhDKnanUCqkpUl
 gdAg==
X-Gm-Message-State: ABy/qLZQ+Al8xkUWj92EPP/8q4eaGpqvmAfFQ8TfviX5sq+LwqF96IRK
 ye78C8sP8/AKUjr+jvGKWOd5dT3hkEb4TCNTw8E=
X-Google-Smtp-Source: APBJJlFhTRlUBOEe2Cv4nH+ImGztpEe+TJC/EjZOB2m30vCgG9nr/ggW70LNox3hFgfh0rRmMo3cyrShHIbvthkvObE=
X-Received: by 2002:ac8:5887:0:b0:403:aabf:4efb with SMTP id
 t7-20020ac85887000000b00403aabf4efbmr16319211qta.44.1690882704328; Tue, 01
 Aug 2023 02:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230413081526.2229916-1-zhouzongmin@kylinos.cn>
 <20230801054334.1034300-1-zhouzongmin@kylinos.cn>
In-Reply-To: <20230801054334.1034300-1-zhouzongmin@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Aug 2023 13:38:13 +0400
Message-ID: <CAJ+F1C+Vu3n9x_zAuVe3CqYfQoX_Whjtwx7pbHTtuxsKP3gugA@mail.gmail.com>
Subject: Re: [RESEND PATCH] hw/i386/vmmouse:add relative packet flag for
 button status
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

On Tue, Aug 1, 2023 at 9:45=E2=80=AFAM Zongmin Zhou <zhouzongmin@kylinos.cn=
> wrote:
>
> The buttons value use macros instead of direct numbers.
>
> If request relative mode, have to add this for
> guest vmmouse driver to judge this is a relative packet.
> otherwise,vmmouse driver will not match
> the condition 'status & VMMOUSE_RELATIVE_PACKET',
> and can't report events on the correct(relative) input device,
> result to relative mode unuseful.
>
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  hw/i386/vmmouse.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index a56c185f15..6cd624bd09 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -44,6 +44,12 @@
>
>  #define VMMOUSE_VERSION                0x3442554a
>
> +#define VMMOUSE_RELATIVE_PACKET    0x00010000
> +
> +#define VMMOUSE_LEFT_BUTTON        0x20
> +#define VMMOUSE_RIGHT_BUTTON       0x10
> +#define VMMOUSE_MIDDLE_BUTTON      0x08
> +
>  #ifdef DEBUG_VMMOUSE
>  #define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
>  #else
> @@ -103,15 +109,18 @@ static void vmmouse_mouse_event(void *opaque, int x=
, int y, int dz, int buttons_
>              x, y, dz, buttons_state);
>
>      if ((buttons_state & MOUSE_EVENT_LBUTTON))
> -        buttons |=3D 0x20;
> +        buttons |=3D VMMOUSE_LEFT_BUTTON;
>      if ((buttons_state & MOUSE_EVENT_RBUTTON))
> -        buttons |=3D 0x10;
> +        buttons |=3D VMMOUSE_RIGHT_BUTTON;
>      if ((buttons_state & MOUSE_EVENT_MBUTTON))
> -        buttons |=3D 0x08;
> +        buttons |=3D VMMOUSE_MIDDLE_BUTTON;
>
>      if (s->absolute) {
>          x <<=3D 1;
>          y <<=3D 1;
> +    } else{
> +        /* add for guest vmmouse driver to judge this is a relative pack=
et. */
> +        buttons |=3D VMMOUSE_RELATIVE_PACKET;
>      }

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>      s->queue[s->nb_queue++] =3D buttons;
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

