Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1037ADC45
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknoX-0005Id-LK; Mon, 25 Sep 2023 11:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknoS-0005IN-0M
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:47:56 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknoO-0003ji-EP
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:47:53 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so11212654e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695656870; x=1696261670;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JUpY5/ln5or8c6kmEfTBo7oAastq2VL8RGZLB3FPhi8=;
 b=U06VGjBI3yV7i4frDzckdcI32i9kjc/kit2uJho+6DBLUIqPD2XMa2//czDHcv1BRm
 RcubhAHF+Bhnxg1o4l/7G5R4DVfpIMi7f+hCdX2kroRwBkjyFk0TYHVB1RC7KzHeXGiw
 Q4E+RaMWFGHsUPCvHzUa8Df0Kd+74Q1f1Cb9beWuj0RsGMlx82nJX+OMex60Rz6fMjk9
 fojlwlmYcST/4xnY9PjObO7fmEXoTJeVLgfXfYzMpDzPcGLaRKEkfHGET3med90eMsnQ
 1CgHd9evg8c3K9VCal/O0y8bciTwvozBctXYsZEfHJrDLHs/Um/DzQA14n8w9zcbDtC1
 Cg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695656870; x=1696261670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUpY5/ln5or8c6kmEfTBo7oAastq2VL8RGZLB3FPhi8=;
 b=X7MpbG4bHCKyyuLo6BDcljsMlTbDBn2DwtJrn6AjGl3Yjc7QFLXBBaxwmiPtPd5ckH
 ckD4rkvk1CWybZZSoBJFlEnnlrbXXdStsk7nlfyvUYx/5os3wVUoEEy5VTf5/NBK0Zu5
 g2Fm7DVazBiWIOS88CYdemWONDfToF/mgZ/4bkfdPbt2Ok5HUFjt/Ln1hy73q1qm1msZ
 0P1ZwkgnbZ2I/ceeUX+RVeLzEl66Ep35NGsZAoeAhpmt7bqr4WKE5nPeoCvG1OwGaLCA
 r+AED91qRgC4ytkBqTwdPZW8tCb3DLu9NaCP5utq83G2NH2uec87n+qsD8dD6XLPPeNr
 9oCA==
X-Gm-Message-State: AOJu0YyVH2Bdii6v/UtKApCKQ/TDAvlAcHwYXOLyllRmI9cEm8TcxpVn
 y1ATb6au2y20w/Db4oY18gQHybfhuLpVBCoTmgTXoQ==
X-Google-Smtp-Source: AGHT+IHJnJKrg5mB8u1nL45eEylipvaKmQ2DkByyF8mWoKXvKTaHGiZTokMMk6qVTho45mkVOW6RrxZzuIyoaIvqa2Q=
X-Received: by 2002:a05:6512:3b13:b0:503:3398:9d3b with SMTP id
 f19-20020a0565123b1300b0050333989d3bmr7756850lfv.10.1695656869405; Mon, 25
 Sep 2023 08:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-13-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-13-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:47:38 -0600
Message-ID: <CANCZdfo_J29xDLvQirsUWRg5Duoqes-rQHPxK6An+J0m522diw@mail.gmail.com>
Subject: Re: [PATCH v4 12/28] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000005cb866060630e18c"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
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

--0000000000005cb866060630e18c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:36=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 12 +++++++++++
>  2 files changed, 51 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000005cb866060630e18c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 24, 2023 at 8:36=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 12 +++++++++++<br>
=C2=A02 files changed, 51 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--0000000000005cb866060630e18c--

