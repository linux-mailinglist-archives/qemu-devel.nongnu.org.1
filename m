Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DBC729F85
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7axy-0005r6-6d; Fri, 09 Jun 2023 08:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1q7axv-0005qS-Tf; Fri, 09 Jun 2023 08:11:39 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1q7axt-0001rj-Fa; Fri, 09 Jun 2023 08:11:39 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-43b2c7d9b52so520448137.3; 
 Fri, 09 Jun 2023 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686312695; x=1688904695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UlY6VZAINvZtgTpUTkUvHFILZ0edqwXEnqRop/VXX2w=;
 b=WpKV28u14qPXX1GFATalb8wjAMr0VD43EFUUJ2W2GVFuIGMSbhmGIHI85PqHYU3Dka
 z3I+KVvcwSksFYXT57wjkZpyewcM+KmA9z42bwLeMkctIbhUbz8icrwKfVxbl35gTI8j
 YiNBwzdwvGqlZDLeEI1ewGy7toZ+HEzXf949OnQ9wlMEHIZxevivD2KQyX/hmkHFPOaM
 K8J/I0tregpQFmvYwEnmD47EMBVOwwMttvWP4x3AoV2gxO1PX0Q4Xp3sjZY0uws0fS5B
 9hTbJl7X2O3VBkNY5whP09BmIxl6dpJ/0wDK5qGHIsHkQzCmVlCsqni9MzaIP0cE5TYg
 AJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686312695; x=1688904695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UlY6VZAINvZtgTpUTkUvHFILZ0edqwXEnqRop/VXX2w=;
 b=I8PorKv1KzRDE5QGj9D8DEh+o7EfdCJ/C6NQDHeem+FFDIbIfFnLgS3ax/1+ngYfDJ
 d7wReSzMNtQoy11ROU5o8wWBWUlfBBb2T5SXVoHm9KZe4kfNAt5zZ/JJD5dHkNVto41W
 BpX1GHXBvTAq9s2gAbNLSlu7xwrYRaz+TF1hRSzoGAFyJ0o+rM+3zZcJEwDsR00nCDdg
 ifr6qRLTJpAFzlQmLKugqkhrbwFpfMySlyINgpiCg7D0+69dGBT2yPy5mi40WgJlC9CE
 e2TAxsaRWy9pS5pXQGcH6kvJcIUFLqAYCdiwumdFbAFB4e4Z8+6DJeVzpswMf5/33YGP
 u3eA==
X-Gm-Message-State: AC+VfDxCMpo0J9dR39kzP1pBc2zsVSn7noWu2BO9Nnb7B3FJlIlb6ruw
 xFbQJ/uR8/+Q3aT0Qgi/kXuswbWU4rX8l05VgA0=
X-Google-Smtp-Source: ACHHUZ6BhWrKvC582GEtO5K2/b5VJejMfaZ+s0rdB4AteWnkiNqWovbzk/rY9XhQaus6lw+CJSkL95JuZOtb6IOzP9Y=
X-Received: by 2002:a67:fd75:0:b0:43b:240f:b92e with SMTP id
 h21-20020a67fd75000000b0043b240fb92emr628102vsa.18.1686312695525; Fri, 09 Jun
 2023 05:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
 <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
In-Reply-To: <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 9 Jun 2023 15:10:59 +0300
Message-ID: <CAK4993g-cQ3jF4dhvi4obszDxoETK6fwA-Kj0vCVa+hsn0s1wA@mail.gmail.com>
Subject: Re: QEMU AVR Patch - Correct handling of AVR interrupts
To: Adecy <ld.adecy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000032747a05fdb14595"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=mrolnik@gmail.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000032747a05fdb14595
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>

On Fri, Jun 9, 2023 at 12:04=E2=80=AFAM Adecy <ld.adecy@gmail.com> wrote:

>
>
> ---------- Forwarded message ---------
> De : Adecy <ld.adecy@gmail.com>
> Date: jeu. 1 juin 2023 =C3=A0 21:34
> Subject: QEMU AVR Patch - Correct handling of AVR interrupts
> To: <qemu-trivial@nongnu.org>
>
>
> Hello,
>
> I would like to submit the attached patch.
>
> Best regards
>


--=20
Best Regards,
Michael Rolnik

--00000000000032747a05fdb14595
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com">mrolnik@gmail.com</a>&gt;</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 9, 2023 at 12:04=E2=80=AFAM=
 Adecy &lt;<a href=3D"mailto:ld.adecy@gmail.com">ld.adecy@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">---------- Forwarded message ---------<br>De=C2=A0: <strong class=3D=
"gmail_sendername" dir=3D"auto">Adecy</strong> <span dir=3D"auto">&lt;<a hr=
ef=3D"mailto:ld.adecy@gmail.com" target=3D"_blank">ld.adecy@gmail.com</a>&g=
t;</span><br>Date: jeu. 1 juin 2023 =C3=A0=C2=A021:34<br>Subject: QEMU AVR =
Patch - Correct handling of AVR interrupts<br>To:  &lt;<a href=3D"mailto:qe=
mu-trivial@nongnu.org" target=3D"_blank">qemu-trivial@nongnu.org</a>&gt;<br=
></div><br><br><div dir=3D"ltr"><div>Hello,</div><div><div><br></div><div>I=
 would like to submit the attached patch.</div></div><div><br></div><div>Be=
st regards</div></div>
</div></div>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Be=
st Regards,<br>Michael Rolnik</div>

--00000000000032747a05fdb14595--

