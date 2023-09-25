Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A185B7ADC78
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:57:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknwj-0003DO-LZ; Mon, 25 Sep 2023 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknwi-0003Ct-71
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:56:28 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknwg-0005RT-Ms
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:56:27 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bffc55af02so109123341fa.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695657385; x=1696262185;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NfHpgZzEjyvoxzvkkKxWNUs6R0zE8YQxn3ooYbkq4B4=;
 b=s1/mQoKeMhYvb+Y7YEni3lMY+lb+bWgfBkQNCIb77ntg6Fw0DrbbCAwBrAfsHPOHos
 vNGYsByU4h+3XHY4Ec881AvcYSdsLStD3lPu33YGZfKw+3siWgu0kr2qzQmbsu8IFgrw
 0sNmh3QBugu/NwTd0V0SUSwibjFkeu6cVUUUBgzNLSEtO39MukOuSrp9mhU/Ph4uP7ry
 t7NIIJYp1Rlb8/wNBPLwmY3x4iXMQVEMhz323jNpZmmZBTcwrAXD2vKLDlfmKiYA6y7d
 7tHQ3aVSN8ITpv9NkHu4kAOetLT9RBmigusVmhcPcJ+F014CXSRUoMhge0XTjJTDciFR
 uxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657385; x=1696262185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfHpgZzEjyvoxzvkkKxWNUs6R0zE8YQxn3ooYbkq4B4=;
 b=pE0BG/zGGvGMNlm2KGPcLsNqRvYYEi89o6/db4WY4tN+CriunGwVwIOGYtguJbno9E
 CE+kgcGFHy0D+WZ02hlJ7EqHYFMU3AX/Udsi5kKGvKngyTWmUQN0R+joFFjJBb4BrqS8
 XMCL8rFVGGsyJtmRxTKE4iiHEFliiG5ZdQ4a/hyXxTo8P1/0p4COUa1oXmnL+ClBLS9r
 luh6fobe1KNsf7LJ7sh6qE1OmNCLcRMFeURRZhBDj4FA59cWsdBo3pDXQUdBClJsI7l5
 a1Wdy+RZkoQOGB+TJMCA/TzG2qdiqunA9vReW8fKyC4ObXDhfSHusjmICeCAbgpEWhvC
 0TUQ==
X-Gm-Message-State: AOJu0YwTSQniE1LdA9/QA/t2aC/EPBgupLRRfu/F1cuKHfvxsbjFS3CU
 xlOY8gbXxGCacKs80D8h7mQcBpJKXKU7poBdutLdkw==
X-Google-Smtp-Source: AGHT+IFLCRT+9nUbkteUYz1Q3nEEi8+J8j+Oc8rmEpfGhdn2jfZFXpFMXNssrCsVp1UU9v/p6waI0mmZ6E1rHx9yC6k=
X-Received: by 2002:a05:6512:1283:b0:500:9969:60bf with SMTP id
 u3-20020a056512128300b00500996960bfmr7080618lfs.68.1695657384709; Mon, 25 Sep
 2023 08:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-25-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-25-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:56:13 -0600
Message-ID: <CANCZdfrmem2-9yw8-+5t7MJHy_HRFFsB3cBj-27TiY0P3BTG3A@mail.gmail.com>
Subject: Re: [PATCH v4 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000013a9f00606310090"
Received-SPF: none client-ip=2a00:1450:4864:20::22a;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22a.google.com
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

--00000000000013a9f00606310090
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:37=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 40 insertions


Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000013a9f00606310090
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
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++=
++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 40 insertions</blockquote><div><br></div><div>Review=
ed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>=
&gt;=C2=A0</div></div></div>

--00000000000013a9f00606310090--

