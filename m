Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4C79153E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6J4-00057P-33; Mon, 04 Sep 2023 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd6J1-000571-0x
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:55:39 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd6Iy-0006Tr-OM
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:55:38 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41479b9b4f1so9598561cf.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693821335; x=1694426135; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5n0UAy7oNKcH47/KGNEbddLF9azsH/8ikdDq3qiTFI=;
 b=qbVk1t5DxmkFpS4O/AciuyV2SIPNBCVotsBd+Jj8bbhXbjecQuOYzN6gde3Zj5/9xo
 1SwhqQlScfh6geWwSGAkmGpxQ+NwWKFFXjOWf4PHVcEPxGCsWCvIo1iMq8j5ffBON4zT
 VI7grg9rFKAfiyBg1EOb3CO+uwl1PVMMmvWLrlMIfpvNku9bYMTLKv4bDfeh6w+yFB8T
 3Yu9vjRSpqr4YlILSdYTtKfNQyEI5Zo6Ry4WccXzA+m40i3HgOzaJIVO/4NA8siPOHET
 L90kg5qPiDGteje8btyQ0L78WpaEM7sdsHcKt7dNhK6h1R3XEddPggOesVSTdqpr2kx7
 SGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821335; x=1694426135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5n0UAy7oNKcH47/KGNEbddLF9azsH/8ikdDq3qiTFI=;
 b=ZUTec0AjF7hmblx3gZo/FhCf/d1Dk0VkgkDiE8/oB7oFNAXvPxzajhCNoFqwS1DmUD
 7DI9naBWlR55LoNNhmctD706Klj3HWHX24UrOzQOs9f5+Iw7NllnUDOE1qOLSbKeA3l9
 KYPTaVptroQ5OOyhz+EC9aITdZdrsTDo/PYkQ9kYLjvyksvwCXpURT8cOaiLqcmq0FhR
 c62S8QOoJpp3Ujd5L0wRjzsWaPmAIhqVQTkFnUMda0YKCcCzKDQ1cKmnsBYoehZXQHNc
 +1PJJGnPfyebeH+ojXpaVa/SVfU9xmMUrBn3/TehACVJxgCQjOl/0xx0LQUxaPR/w3FM
 jBzw==
X-Gm-Message-State: AOJu0Ywr3y3HYnjswwG6jav4LckhxBtBV+0/hxrKXnQwfWDQvyTCjKa1
 QMhjLfPkhBSjFySq32iFZngPn6KS5npEpGo8Vam23FRAlP0=
X-Google-Smtp-Source: AGHT+IE2WJVltcx+MabymNVgy1GwXduu9c3gQ2RgW3M5/VdU0S6ii0ZPtB/HtzGP/AN8MzMJRI1/74/rPrg7m7ayQvA=
X-Received: by 2002:a05:622a:3d2:b0:409:f273:e28d with SMTP id
 k18-20020a05622a03d200b00409f273e28dmr13801756qtx.62.1693821335329; Mon, 04
 Sep 2023 02:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-27-marcandre.lureau@redhat.com>
 <ZPH066LPeGit5U0j@redhat.com>
In-Reply-To: <ZPH066LPeGit5U0j@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 13:55:23 +0400
Message-ID: <CAJ+F1CLC+t8Z4bm5F1s1qVZkUznBoY_vW9xyUnF7ZBtUyvbaiA@mail.gmail.com>
Subject: Re: [PATCH 26/67] ui/vc: move cursor_timer initialization to
 QemuTextConsole class
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

On Fri, Sep 1, 2023 at 6:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:00PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The timer is only relevant when a text console exists.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/console.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> > diff --git a/ui/console.c b/ui/console.c
> > index 8c4a2c83fa..ffa68c3a22 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1399,6 +1399,10 @@ qemu_text_console_finalize(Object *obj)
> >  static void
> >  qemu_text_console_class_init(ObjectClass *oc, void *data)
> >  {
> > +    if (!cursor_timer) {
> > +        cursor_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME,
> > +                                    text_console_update_cursor, NULL);
> > +    }
>
> Any possibility of moving 'cursor_timer' into a field in
> QemuTextConsole ?
>

It's global, so all consoles blink at the same time I suppose. It's
not obvious to me how we could make it a class field either.

thanks

--=20
Marc-Andr=C3=A9 Lureau

