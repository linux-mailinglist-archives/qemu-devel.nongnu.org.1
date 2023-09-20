Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED57A8B1A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Zr-0003fY-CS; Wed, 20 Sep 2023 14:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Zb-0003au-DL
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:05:15 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1ZY-0006fk-EW
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:05:13 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50307acd445so267151e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233110; x=1695837910;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hoHirWrRl2bA9QKyWArZH/v3A7f07/i59TOPEJqsODw=;
 b=wY0U4YCGZ9dDR8WEg2NYXK7hkllPYVWztGgiW1vyaqCTG8u1j2UU084u/sXKVVcHIq
 /na895zzQebIPh1c85jfYSBs7/pVv8v262nSslraZIvsJkvBptkwdk4lL+wYCkMGsnbZ
 vBH6GwLh0EuPLMxm3Ic/HR0e20+VflJxPnurPnzzv8/twPeyHWpLGFReplKu3Qzv/VdY
 WMYYy8nzRWpX+dkNn1Wf1y1uOM2dDlMxwRgfI4Mkwy+rzs07f8tt25TpUrsypaKuwPoB
 aAHLUVpT8htXKnXUhL+tarsK1WwoA3/w4OYYsX2O8uAcj2gFyOrpe+faiqSwppHlwnlH
 Rmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233110; x=1695837910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoHirWrRl2bA9QKyWArZH/v3A7f07/i59TOPEJqsODw=;
 b=NH2KntCGaJlfm6RY4DfLQzc7DYSXiOHfwI3q7wOEikP0AvKJzFa63H5Py8kzsI+akM
 d0XV+KqH0atLY930gfFodjdShOLUDjtAOYGGDFTYP4SwR7YvyB+UQ5J46Vy71q6SBKHD
 CyKgDKycV4T81r39r9bDLj4Uk/kov3CRJaFqcriZzlO15Vyf/XxwS+C7bbdFWUMZ6frk
 GaVqp+Rk9nbvYDKQIyxVf3Ii+STsBLABjIkPUM8Irl04O/0kHC2OrowWEPM0PgGrJbts
 zh4b9iLRH5Wu/TKkN2wC8aq6/DxStX7tRVKNAESrqf3pBGFSXVqTZABSzLQLyMos96tH
 6IAg==
X-Gm-Message-State: AOJu0YxCOX5jCZsFo7/0ikoejIkStJ4k5l3FbiI+j8qO61KYBOYMsWpq
 TqcCBnCEZ0E50OZ0znXGvIC20+G4ttaY3PNq45BPmRmn7K+5/QYYsyOx3hmF
X-Google-Smtp-Source: AGHT+IFWxvYnbC0TMdIJ6UI3apYaG2jn+tQ0KmzDe6QGFqLJPeG6s4zHbMIaAOnVkoy7eietSjER71p8e8WRz9z0Bcs=
X-Received: by 2002:ac2:4d89:0:b0:500:8443:744a with SMTP id
 g9-20020ac24d89000000b005008443744amr2841357lfe.7.1695233109939; Wed, 20 Sep
 2023 11:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-5-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-5-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:04:58 +0100
Message-ID: <CANCZdfrwfxW9jUijq_waKV3bJyxSsLOQra4Xy1-Ln=YzCa=T3g@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000005470ef0605ce372c"
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

--0000000000005470ef0605ce372c
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
>  bsd-user/qemu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000005470ef0605ce372c
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
=C2=A0bsd-user/qemu.h | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br></blockquote><div><br></div><div>R=
eviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.co=
m</a>&gt;=C2=A0=C2=A0</div></div></div>

--0000000000005470ef0605ce372c--

