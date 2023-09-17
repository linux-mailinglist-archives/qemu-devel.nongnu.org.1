Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F17A3526
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 12:35:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhp7M-0004Pt-CY; Sun, 17 Sep 2023 06:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp7H-0004PC-Bs
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:35:03 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp7F-0000Hx-PJ
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:35:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so4254454a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694946899; x=1695551699;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8zyXJWkYUTbzSz8ouSylvyS+phgkaZRdxTJx9pF3w28=;
 b=W3CbUmz7JD3ttpp3erWg5tBQ4yZuu0xyFt3o2EKSKwnUh12eHSoRq6JpZwyd4gUaFh
 19SXkSfpHm2hLd4unz5HP/AjrlVmavA9+VYYIqghrhVStK1mQAJMpCkTac87H1tpifPr
 zmCNugQ+UIVMVGAO84kF1yVH4w9cZ9MfobrvjG+n8gf+eFcVzQ4Wh25ECnAILju4yFPI
 17I8M82B6rxXeD9Hsxs2NDZmLg1czlcGntg2G/HvBN4+swtmsNwTN0uiN+YzFk0j0jz1
 8BrhKpWgr8fO5Svv819TbcTBx7zyIgmN0L4xB35sLBv+8yq2bk/wcFBIRN8VyyZEKeLk
 0VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694946899; x=1695551699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8zyXJWkYUTbzSz8ouSylvyS+phgkaZRdxTJx9pF3w28=;
 b=U+GRFD4KFuyEGIhc0NTluuJn/pu2703/svg3JMW0g2xHA18AzqL2U5hEB+rtHR5KwN
 OYZtDrpHVBXUTHfB7m9g83lEULFILSiAofxmBM/rLC+34bkE8d6/RbpmCCWj5D9XP611
 Qkhzk8jjC3qxLfwopEFwkRRLVXRCn1pCWPQyYeBdWwZYA6kEB/nFSiBBIsfzzxPZtvwQ
 RzfnszMzCJmsTtxP+IKQX4RzcSzZga1X+Eao874TIAr0ZQceoMIw4XSa2jDdD1/HfDG2
 alXzCsX36HpR6pF0Npo2IggLcW3o5nmIerCbmLlMRXl2cFCH5vbdcp24JGD6/xsFFv00
 9edg==
X-Gm-Message-State: AOJu0YwRNIvusvmi6HmHjtFkqHkE2fKG3eAGdmvHkQV5U7ZELwZHiPyR
 l5WKWfm9DKNHXcTy0Zeo+n6MA+frOm9XWtwGA2JhAw==
X-Google-Smtp-Source: AGHT+IGgHUxDuNmWCVwNCFfinNEO4VFhcq2D135v2jDw676N5PTorQ5Bh9J5X1GfFJ2d6cP75M3L3ajvecygtNy8O2A=
X-Received: by 2002:aa7:cb17:0:b0:525:4471:6b53 with SMTP id
 s23-20020aa7cb17000000b0052544716b53mr5512303edt.19.1694946898845; Sun, 17
 Sep 2023 03:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-10-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-10-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 11:34:48 +0100
Message-ID: <CANCZdfr7RJXBbmfOeYRWNOOYovFdgJ0gCyd8o+YEH2RsqFvczw@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] bsd-user: Implement ipc_perm conversion between
 host and target.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d1b7c006058b9385"
Received-SPF: none client-ip=2a00:1450:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52e.google.com
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

--000000000000d1b7c006058b9385
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
>  bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000d1b7c006058b9385
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
=C2=A0bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++<br>
=C2=A01 file changed, 25 insertions(+)<br></blockquote><div><br></div><div>=
<div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsd=
imp.com</a>&gt;</div></div></div></div>

--000000000000d1b7c006058b9385--

