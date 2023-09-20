Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E77A8BF8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:46:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2DV-000073-B1; Wed, 20 Sep 2023 14:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2DC-00005W-S3
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:46:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2DB-0005hx-9R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:46:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5308430052fso61480a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235567; x=1695840367;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y41LIxe+rWFV74D29VJ2/gLWlancu8VwIGXfO/yU4+Q=;
 b=lM0gqd3d7P1jScie8CBoolJrmLxCR4SeE+8sflFyXe28gyecvTYa43WDCLdEbzXbiO
 9YMtT7CtPB05ZKGTssXUNTtD+wt4gpKNuJc5222oTYsO6pXgx3Jbh03grzCZfoQD9XIi
 /dyRETpGKyTx5iCkEdFmf8jbORN4vdm1+tjs5CqMjWPpBb9uYIPM1xrYWOg/edsxGxkI
 WoYgL0xAPaa3loandpfrdti1I3jpc434wb2fEfA0qrkjZR+WozxkLtbavPOaOgQ+PwSR
 MXfzKW8b3PGbzol4sZ4oR0ot/it+BPiLC5v7khYOfIr6MVd6vdHdo86WJ+mrolljTd2H
 gW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235567; x=1695840367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y41LIxe+rWFV74D29VJ2/gLWlancu8VwIGXfO/yU4+Q=;
 b=aHE98gWL7CUbjy2kh+jLhmseThqxD+2kEUTB6oFqUOijBOd6Xfyz3wx0hPbC1qljZx
 vaGf49hwC6klPsgfNHHgsIa0UmRfT2ERBdIA4C6kREvTRnQJS6ulOhgW/f8zxc97VtC4
 c7aKu/QSzjr2gq/2bvWMC9f1AGIjk6qvK75syu4Hb9XCJDzPmzMSfmOUtM5d02pKu1oO
 lETwsj8OzR+dbxq1LIWQqGYp8sPP4Pb43V1eCaxtDkk/aj71RPxuYuXcsBmbzDtVRcHb
 A1hND2wfzyxa0EKwVtJdp07uYijLBLvgwA8N4t9EBNUVbyml/YMHVSdO/59NiNpR5SDx
 x0QA==
X-Gm-Message-State: AOJu0Yy7qLRQvNdz8y0aT9Um5wvKwgTP5iflEz0+Ohhk6cS9XviZsSLJ
 tQy55XuFCQrBnEc/ShqLZasPkK8q22ART+YESo7d4g==
X-Google-Smtp-Source: AGHT+IE2vSnYszVIbzHFg/vTT0I+se/hL25eUIVKTKHizaPKYTG3idkaNQYmFJGPPNfxP3/nh2BD0fUVklrpM0MfcdU=
X-Received: by 2002:a05:6402:295:b0:522:30cc:a1f4 with SMTP id
 l21-20020a056402029500b0052230cca1f4mr3461262edv.0.1695235567615; Wed, 20 Sep
 2023 11:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-17-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-17-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:45:56 +0100
Message-ID: <CANCZdfo0A7gWGmKw=t55KOoR0HrYuhbTPL6Tnt+Cpy3vBfTGNg@mail.gmail.com>
Subject: Re: [PATCH v2 16/28] bsd-user: Implement get/set[resuid/resgid/sid]
 and issetugid.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d192af0605cec9b7"
Received-SPF: none client-ip=2a00:1450:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x533.google.com
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

--000000000000d192af0605cec9b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.h           | 76 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 28 +++++++++++++
>  2 files changed, 104 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000d192af0605cec9b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 76 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 28 +++++++++++++<br>
=C2=A02 files changed, 104 insertions(+)<br></blockquote><div><br></div><di=
v>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp=
.com</a>&gt;=C2=A0</div></div></div>

--000000000000d192af0605cec9b7--

