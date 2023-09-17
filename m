Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C37A352A
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 12:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpAb-0006nD-E7; Sun, 17 Sep 2023 06:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpAa-0006n0-Br
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:38:28 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpAY-0000w4-TI
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:38:28 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-502934c88b7so5885088e87.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694947105; x=1695551905;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=elwyoAt4rOWMBSVAL8BzJ7OEL7cCTWPIA3/FdQjHbbg=;
 b=xqSan+z6wQBsEe35oJXh1V+xNhjcmzKqIjY+fyYxlIoY623obEhu6keRJSAiSZ9iWD
 zcjLW2EE9kzM7lIFD/5s2Th/t1mYj2odgg/ko5uiu17Cn7Axefp/6jf9w5FfgqMZCSNH
 H40ojnVZHVv8WLCs596Rmr2STisV5iLanJE/1Ny5xl1r7oAHlDbRVUiBhnxR994pbzDy
 w+090fozBCKa3D0BvtD3IxKZhOoH1QIbi56+2YWbyJuAcxb4PccLKlPBpGJBDUjeF/Fz
 gpz0svrJXdnvtHgTUXeuuV6bvzCBIVYXuYhWg3kffCLFcbazMiv1Z9PYbykiUCX7dw8q
 lRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694947105; x=1695551905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=elwyoAt4rOWMBSVAL8BzJ7OEL7cCTWPIA3/FdQjHbbg=;
 b=Ixfo+LaJE6OljSC5MfwIPmpbQkl7vvS6gyUzp4+Lj3HR+liEMd13emrh+KL+Q+y0Qs
 VkNcH6aupN21mhUZD1P1mJtCNUNC0X6e4GXynB0As9s8Y0if5iYiIANyX1DTNjfADo2t
 wSdwZ2R7vVF2/ptb8Q4mDTccTM84snMFY1dka8H4wUEphtb+uvi8VkUDpF1jRT0jzBkB
 pmXAEvThPanL80kOjWYDtKdTGTI/imVisVEgAm4WhbjpRRM5+AbXEjUWEl2rn8wyGZiH
 ayQmoi3pGqp8QECiwho/O5rGGdTo3bj/4MYvfgxoZyEqo+KJcCDwdLXwBhA9uElEa+/O
 +VHQ==
X-Gm-Message-State: AOJu0YzdRxAY4+v4DyHOxpYAX+NqJD7a7bWmiaOkzuU7PwUiL74yP6ON
 iivbo0KSZzKRCVcOsjTNXfVRlE8FCoD+cs60m0re3g==
X-Google-Smtp-Source: AGHT+IH5BbKTVBfBJHVnUt4tmPfnb89aCLiIpLuruwWYqsqekCSm5VRVhrJXtMpPOEXOL/WkoYMiSDjriGVNmsGs12I=
X-Received: by 2002:ac2:5f55:0:b0:4ff:8d9e:d36f with SMTP id
 21-20020ac25f55000000b004ff8d9ed36fmr5212978lfz.39.1694947104824; Sun, 17 Sep
 2023 03:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-17-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-17-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 11:38:13 +0100
Message-ID: <CANCZdfq2NKRWtPkYE_kezje3=_aP9yQTOBGNpuBCSV77xU=t=w@mail.gmail.com>
Subject: Re: [PATCH v5 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000018b68506058ba062"
Received-SPF: none client-ip=2a00:1450:4864:20::12d;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12d.google.com
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

--00000000000018b68506058ba062
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 +++
>  bsd-user/syscall_defs.h       |  2 ++
>  3 files changed, 59 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000018b68506058ba062
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@g=
mail.com" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 53 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 +++<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A03 files changed, 59 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>=C2=A0</div></div></div>

--00000000000018b68506058ba062--

