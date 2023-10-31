Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C27DCAA0
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:20:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxlr3-0000jz-39; Tue, 31 Oct 2023 06:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxlqx-0000jm-OL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:20:07 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxlqv-0004MH-Tj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:20:07 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67089696545so16898036d6.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698747605; x=1699352405; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2O2JDjQqrGSjR2gOo08HMTpS2lHVEj6FjuVotfbzps=;
 b=XBdL78S2Z+uwuijhDtkYKaUhGBw2AuWyQOpZGOIsGV7tDnM0hW4LdL/yavneyVPVfv
 ca72LLbwHfmS9FXUb+H66uYlKdfKWzR+sT1hvBPhGEUAAS6uSnNDKRlf5DMWcp0PpYQJ
 Ak4u3PNsgvFDVTr5yHwws4x5/oMoG8x36VCNN9Mk5eLi5KHO5U8X7YUfCkaGBJ/FLjqu
 raCgOjwuyln+wblGz/i2MVVqhr84ZlDZLi76YlnK+4+A0WWK6MjhQ6ZBx6IDnMEduBT5
 /7S3EefxI7D43k1lMFQ/HD4PcFMXrId6xnqbB4Xzc0pJY9JlGSR40MAFTbhtA/lbPt6k
 JiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698747605; x=1699352405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2O2JDjQqrGSjR2gOo08HMTpS2lHVEj6FjuVotfbzps=;
 b=a+MCPBB6jl59Jg3m/pvj/KXdZH4srGBpfhwmi4AZsMiDBiyoEV7Aw0Ne6D7+QDV+0V
 SMAFxKwpaPIJP6i9wTQUvVUciYZiFTAS0upSfQe1+vNW/8jHFhBed07VsQ0QbkDcdYRF
 Mrt1WaNcSHlbf8+PmpBXn/PvAGUjj/FXF3P8kcgzMQTm7eR5C8EJm9B05KpdrXLbfvwR
 Lx0Ja/S2pl4WFQlsel/xLmoRi/3ZzKFDFHutf5gvcOgD5+myjRgJOrgxZkx3oLLxkiiU
 axKI+5PrI54QRUp6gucdrD0aEtlWO3+TlZpegprRJstfgASglt6i8cLhIGbGD5zbbPA0
 j+Wg==
X-Gm-Message-State: AOJu0Yy44TZysydDyeRTZBa8axtp/wm9wov4ZXShaa2bKIGjwa9xQPaU
 kYcCvfy/3KT6bJ/YSVNPWZbcqZQV18aJHC/BFAA=
X-Google-Smtp-Source: AGHT+IG6Ds8YWcaLuAY5/tvs6d4jB0qr3CDz3myUT0QyrOBgH+pHuBg+5Mc0upTfvOtsVaoiNC80j6ai+575bS/eg9U=
X-Received: by 2002:a05:6214:f09:b0:66d:58a2:d23d with SMTP id
 gw9-20020a0562140f0900b0066d58a2d23dmr18382969qvb.61.1698747604818; Tue, 31
 Oct 2023 03:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231030024119.28342-1-dev@adrianwowk.com>
In-Reply-To: <20231030024119.28342-1-dev@adrianwowk.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Oct 2023 14:19:53 +0400
Message-ID: <CAJ+F1CJA2Gp8daGfW_Y0bW=18Jkx8zP3iKDE1VdSyEWeiPndSA@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: use correct key names in win title on mac
To: Adrian Wowk <dev@adrianwowk.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2d.google.com
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

On Mon, Oct 30, 2023 at 6:11=E2=80=AFPM Adrian Wowk <dev@adrianwowk.com> wr=
ote:
>
> Previously, when using the SDL2 UI on MacOS, the title bar uses incorrect
> key names (such as Ctrl and Alt instead of the standard MacOS key symbols
> like =E2=8C=83 and =E2=8C=A5). This commit changes sdl_update_caption in =
ui/sdl2.c to
> use the correct symbols when compiling for MacOS (CONFIG_DARWIN is
> defined).
>
> Unfortunately, standard Mac keyboards do not include a "Right-Ctrl" key,
> so in the case that the SDL grab mode is set to HOT_KEY_MOD_RCTRL, the
> default text is still used.
>
> Signed-off-by: Adrian Wowk <dev@adrianwowk.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Hi! I created this patch after having to compile QEMU from source with th=
e SDL UI enabled to avoid an unrelated bug in the Cocoa UI. I noticed that =
the title of the window was not correct so I added a quick fix. I have test=
ed this change on MacOS Sonoma (Version 14.1), and it works as expected. I =
did my best to ensure correctness, but this is my first time contrbuting to=
 QEMU (and also my first time sending git patches over email), so if there =
is anything I can do better then please let me know. Thank You!
>
>  ui/sdl2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index fbfdb64e90..4971963f00 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -172,11 +172,19 @@ static void sdl_update_caption(struct sdl2_console =
*scon)
>          status =3D " [Stopped]";
>      } else if (gui_grab) {
>          if (alt_grab) {
> +#ifdef CONFIG_DARWIN
> +            status =3D " - Press =E2=8C=83=E2=8C=A5=E2=87=A7G to exit gr=
ab";
> +#else
>              status =3D " - Press Ctrl-Alt-Shift-G to exit grab";
> +#endif
>          } else if (ctrl_grab) {
>              status =3D " - Press Right-Ctrl-G to exit grab";
>          } else {
> +#ifdef CONFIG_DARWIN
> +            status =3D " - Press =E2=8C=83=E2=8C=A5G to exit grab";
> +#else
>              status =3D " - Press Ctrl-Alt-G to exit grab";
> +#endif
>          }
>      }
>
> --
> 2.39.3 (Apple Git-145)
>
>


--=20
Marc-Andr=C3=A9 Lureau

