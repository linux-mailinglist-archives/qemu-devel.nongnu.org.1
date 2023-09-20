Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934B7A8CB6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2nT-0000vA-SL; Wed, 20 Sep 2023 15:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2nR-0000uc-0y
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:23:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2nP-0003Gi-Fr
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:23:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-532addba879so264497a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237814; x=1695842614;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7yO0pJ2ed9VDGXd8LqFRDnc//8eMnRVgfWmvJXUBeU=;
 b=mBa6DV/s1HcJNtlDkMKT6V3jpUKh5mTnUMEf9yQxxyfjBPIuzpQfWzSTZsjdlgJthR
 0LQkea63tBFn/fMpYe3Caec/ZtiPO8yTm/11pKbPGwuY+iGuyB/9kbxWB37gsmh/wuCJ
 Yk0s4nfVcarBDFlMd4p4qNgHuap2aAtDC/0r9+wMkuZFIg/uYsSs54igMhukbm5YnflG
 9oT+vYQ5bNx51hHzdCoC5yH/j9XJIihMdopoq6GTPxFw2wKEdCEY4zUWV97KA2TwxHXz
 WpAYilKMvCtCZiXyfWZog0h50sobG72cRdYS71UDFHfyKJlYK7fQLS4Mi4A8VQrvAIxM
 q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237814; x=1695842614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7yO0pJ2ed9VDGXd8LqFRDnc//8eMnRVgfWmvJXUBeU=;
 b=tj5KlBsRuXB+rulrAe4HGznOkxpY7XvC2/f2BQHIMYXPKrKO8dst5GvmKJjIpFIojw
 cmyLpF9LioJsDf3UAJIE61PdudUDJHe/mJtr4YVl1Pji7UYciij01C8poGlgsmGkCSil
 fCdmDOKhkzvYulFu6WPulAzPDYtL+cL8KK6HGKRB4ejn+g7XmzMj5fIfmj2PeJ2zS24P
 Sww4P3jNLdkuo29c2P0QyTh6c2nQBDXaJ1Ql36oETjKLn5O8GXl5DLWh/lPUxrK9UFdh
 OaIEAvrQ9BKUGhTmIrEGlsVbLoEf7rbcwKSsPqETAkAeA2uLxmXCS0F2TuRYkBvvQWTD
 MS+Q==
X-Gm-Message-State: AOJu0YzJKizQ6jdB8rUwMguAEbJ7/j0SBRVDDu+7UdtPBpdAaBzGiRL9
 MNj/SN4ehom8sEq1bnmSTn9O+/u5UvXNwj4oCpWAug==
X-Google-Smtp-Source: AGHT+IF3GfYdWEoMq+k6+tz9ZkYIs/D7bqD+f8idWMDfED8+jKTPkPsGN4xHAaicQDIUlVvtzzqA4hZvjcbc4CuIXpg=
X-Received: by 2002:aa7:c411:0:b0:521:d2ab:e4df with SMTP id
 j17-20020aa7c411000000b00521d2abe4dfmr4943089edq.19.1695237813763; Wed, 20
 Sep 2023 12:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-29-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-29-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:23:22 +0100
Message-ID: <CANCZdfqaKOdqP0uxFJ=TedfuFYsrMshyN6Ln57Y_=W3OZ_oxAQ@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] bsd-user: Implement pdfork(2) system call.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b32e800605cf4f34"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
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

--000000000000b32e800605cf4f34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:40=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 36 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I chased down pdfork recently for other reasons, and I'm pretty sure this
is good.

Warner

--000000000000b32e800605cf4f34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:40=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++=
++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 36 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>I chased down pdfork recently for othe=
r reasons, and I&#39;m pretty sure this is good.</div><div><br></div><div>W=
arner</div><div>=C2=A0</div></div></div>

--000000000000b32e800605cf4f34--

