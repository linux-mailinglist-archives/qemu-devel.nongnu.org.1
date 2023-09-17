Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C57A3550
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpcT-0001jw-Bd; Sun, 17 Sep 2023 07:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpcR-0001jh-Sq
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:07:15 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpcQ-0006fM-8g
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:07:15 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50078eba7afso5911620e87.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694948832; x=1695553632;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MUYBhc474ITzDs91OcXw/mxvjfrV8uL0NoVG68VdpMw=;
 b=pEzo3dKa0yVowsQrV/xCdmrVcZxvJVpaqc8iLdhfzSFEcZmyXkKTSF+VCZS93IR2Ye
 s4tQLINtLQ+tYLEugvDzqHvxRNQenZ4oxVmLMfnzDc+sdlcCGtOkyta2rXSGuhunGKaB
 SgWDr7gjMJZxBNNjngQh6M9pHpsrDJPpVUwtso59WLmGXp9J7alWo2p/3VzYy6V8Lt7g
 pI0TZyzN1sL+LrpmddUFntV9SPi0WeH/agpeKKftzu8EesFwqyYpKYqpiTpkivKZL0in
 PYffzaayr+pdsg1AESmmXCHIZVQBqsIfrgnDUlDFPtKh7PtEAxTgG0HY7quWJbD5+wMe
 4jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694948832; x=1695553632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUYBhc474ITzDs91OcXw/mxvjfrV8uL0NoVG68VdpMw=;
 b=RiUnq73AfQ2nuBa6pXVDFa9Ib2DmayKYYxbqHvL8zqyDH9hDBy9omPin+ThXvfrDJW
 +pRIWoF8V/wmachAAPg4Y+iQALFt45nLD9NoYOSgo+3TcvuSJKRJ6hlKiyojR0YMDHEa
 i1fPNGDIhz+EYD2MOyhQjE73JroC3bz9L7kCETd/ncNreSKpHPGWK37vTwS4S54r1E80
 6GQ0pB49bJ4Pa8L6EXqW2to8zsxZHuFR+uinld6D0GvRg26CRmKXhVfTzqpSF002f3kH
 7s1DR0tFb/zBnSlylpY1SbG56UHJ/ql8O1XGm2lt7HZbpCpUGBjkz2PtYYawxA5/E4np
 oBjw==
X-Gm-Message-State: AOJu0YyxzRTto57P2JPxGAerJoYHB6GpaYGu6RXh3FuU8wFjG1WTNjQm
 0Si9rayeuoVfpof7WgA1ZOzOvJU7/PILrPTE+yvoPG/Y3dCjqprX+jfwcw==
X-Google-Smtp-Source: AGHT+IGP976zgX4IfWLnavBq/8Tr3UuExVhbRCfUQNG8ZD7Z+iX9+yu0YUI7evgVYnjyR4u6uLJgQ+dlCusymE91uVE=
X-Received: by 2002:a05:6512:3ec:b0:502:e651:129b with SMTP id
 n12-20020a05651203ec00b00502e651129bmr4794445lfq.19.1694948832369; Sun, 17
 Sep 2023 04:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-22-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-22-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 12:07:01 +0100
Message-ID: <CANCZdfogVGThzL21J8jyy3ybmoJim3dh9+EJd_6j4t2nczakDg@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] bsd-user: Implement shmctl(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000010f6ca06058c071a"
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000010f6ca06058c071a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000010f6ca06058c071a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 39 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 43 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--00000000000010f6ca06058c071a--

