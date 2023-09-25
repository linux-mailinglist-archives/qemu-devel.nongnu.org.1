Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0B7ADC80
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknxz-000538-LJ; Mon, 25 Sep 2023 11:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknxj-0004mF-Oi
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:57:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknxg-0005cE-5q
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:57:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so1540368466b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695657446; x=1696262246;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rzm796MbOkaZus6R0TkYciD0vGThfaHHpROKVQ88huo=;
 b=Yf4wgA7KiBfpRQIedPvg0QWHQDC4j+zeS2rIV/JuNB+0ZKrMqdFdU7rY/dLlUNzPQR
 vFRsnsvC+rd87oJ0Frdw3NKzfmrGWCqCFbL9QmHV7rCcgB6gmnvSKnQeH409dSmPe4T0
 KkgwsWB0xIWFl6GFFr5ncljkxyt0eScuQwLMWo6JqCqcgMxdFG6kFElEAVlLiiRREPyw
 vtp3ERkgEoJ4r9X2VoMM6EZ8X1K6rme+rmV1f9yathq2bO36hjMjn1ht0EuMOnD3lVO6
 KLj3+vwxJdb39wSeXjfQVeFx6QP/KS4zGbR0KOSrbdMX+UYf/cZqUSEFrqJzRh9Sz3rJ
 fmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657446; x=1696262246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rzm796MbOkaZus6R0TkYciD0vGThfaHHpROKVQ88huo=;
 b=QgNHA5pqNjNi5O5NhG8Yagysk3HQxFkfo7Y6w2c8epebDIw159BPk3t8xvEC+jzkZz
 M+DwQjwWDPDqz3xJ2aaQDL8PoKy5D0Cvh4CrHEdcJKpkAUmy8k2zUjshbDIqpWzEEq1P
 J5Sm3qCVwCnhHPKdMeIr0Qnl2wJ0oWfa7di/DaMkMS6fwwNNgx9nZjb7fNTUlguKN+bG
 epyu74pT1ow4J/CnNNn22w0V7/pldh6VaK2DvTKOkQqeHoSPr032ja33FRoL1mc1arRv
 YdH2C7nFaNOJpROZX+6BmQ4GQHjy/axUoH2F1MD+MYHpvSb2MwY3fcPoKENd6bRZRfH4
 pu1w==
X-Gm-Message-State: AOJu0YyTUvbM4bgsITrd2vLB9uu8CjlNwUkyJXDAKJK78bdg0J4csYJZ
 QxzSXc+kXnxrFqCb9fVNrDacHpsqytlYVHSzG3rMRg==
X-Google-Smtp-Source: AGHT+IHANbPelqhCfwMQEhVEPTRxllD5TYoLOo2QXlqIJYCJmqUiuHFLic1fP0xvTb+JV8pw+GmIWro6YcZ2RBLesrQ=
X-Received: by 2002:a17:906:530b:b0:9a1:b85d:c952 with SMTP id
 h11-20020a170906530b00b009a1b85dc952mr58045ejo.12.1695657445976; Mon, 25 Sep
 2023 08:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-26-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-26-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:57:15 -0600
Message-ID: <CANCZdfqxp=yeAg-3S+7SDKcBfWzvTWztJ5rH5k-DAjHJ=+9k0A@mail.gmail.com>
Subject: Re: [PATCH v4 25/28] bsd-user: Implement pdgetpid(2) and the
 undocumented setugid.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000ba8e2a060631032f"
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62f.google.com
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

--000000000000ba8e2a060631032f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:37=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 31 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000ba8e2a060631032f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 24, 2023 at 8:37=E2=80=AF=
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
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 23 +++++++++++++++++++++++<=
br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 31 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000ba8e2a060631032f--

