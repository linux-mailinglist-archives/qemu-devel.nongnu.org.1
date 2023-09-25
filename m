Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06D7ADC5A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknsn-0000VW-Js; Mon, 25 Sep 2023 11:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknsm-0000Sm-Ao
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:52:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknsk-0004hK-J7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:52:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99de884ad25so839175766b.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695657141; x=1696261941;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJPqKI3zUbg2onI3fZJFVOBghNC0yxE7jnDTsYYPiPM=;
 b=acXzY4kqCcqgvNeqGhb2Dds+2TPib/bMt1YXbSQO09N0zye38hJwoQM3L74mYuggW0
 iwqpZl/MEtZD/DWa3R7jsdSUBp0rOMVvGCHyZx5LdAdTMigd13yawVFM4XnagFbyQ3i7
 MU05o6wds/7tH98/jvmVj7+ZFgpiYgwz3QiHCnF5Il3Ke//X+/nwCVC4ETABEnzmz7Q/
 WoSfkk5b955HbiG8Yien5D7foOcJ9LJFAezClhbKNc2btMHvOhAUI96WwydMRo8f8mHM
 uRgSPJPi5gp8BNYEFCn52f2Dy26w3wYCobPLMGfZonkQOIPOLZl2PD2YIqZo3C1b3NQp
 T9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657141; x=1696261941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJPqKI3zUbg2onI3fZJFVOBghNC0yxE7jnDTsYYPiPM=;
 b=LNL6UeMq6sUWuhDV0mmkEyxFXSfd+FRxg0A60uys8d0qM59oR3b3oBeskKh7W+A48m
 TTl54040kmy/IGGqUzZN9o6H3Go3CFjexG+sixwyFRrpCIWei82Y7tyHChJyFZBAeexE
 52T+m7AVX6x6MWh8hPZOy57Aal5+x9ZsQAajuO1J1uREgRT2JUKgM5kp9QUAbuVowro2
 CJb7cAlHcWlenD4+CTmm+ipwO1zapXedb53sa5tE7sUqaGTSkey/kvr1eWurCkmPEfoQ
 +76qxsYzQQF1sajWn0zrwLe2kH6vCPyecTjJQQKryzcCENAeQSvKnlKetapl34p5O+n5
 EYWg==
X-Gm-Message-State: AOJu0Yxb+Bzv6E4IpUNAvdFRvw3j0mC2PcnVI2xaqEPK4fkfRDTsZAiZ
 zQi7WL5qeEbXM1060jNeW6acjB7/lmIUFPrzRpTfjA==
X-Google-Smtp-Source: AGHT+IHma4TqH7vWMjmWbl2VVIUuO0PYDWUvkr6QQwN4UC0wA15WHu+2Edy6mgVYOHfaWTz1ZMQjVNnmfaTfPYkGsQY=
X-Received: by 2002:a17:906:1db2:b0:99c:b0c9:4ec0 with SMTP id
 u18-20020a1709061db200b0099cb0c94ec0mr6222733ejh.30.1695657140862; Mon, 25
 Sep 2023 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-24-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-24-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:52:09 -0600
Message-ID: <CANCZdfp_+1tjUX8YvzpYVV59Xg921s_iZ7qGSLX+4aNGcb=DjQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/28] bsd-user: Implement wait4(2) and wait6(2) system
 calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000008af3b6060630f19c"
Received-SPF: none client-ip=2a00:1450:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62a.google.com
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

--0000000000008af3b6060630f19c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:36=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-proc.h    | 84 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 15 +++++++
>  2 files changed, 99 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000008af3b6060630f19c
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
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 84 ++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 15 +++++++<br>
=C2=A02 files changed, 99 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--0000000000008af3b6060630f19c--

