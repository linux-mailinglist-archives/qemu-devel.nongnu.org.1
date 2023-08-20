Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E48781C58
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZlH-0004g2-Rw; Sun, 20 Aug 2023 00:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZlG-0004fr-A6
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:09:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZlE-0005Jh-6q
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:09:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so4593678a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504594; x=1693109394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3aANH9BT8Cchha/fX0LxWm06dw8tJcyEz3eyG1bX5EM=;
 b=clJ3kN+w5CUv2Wq3gCPvRU/pe9UEAulNMFhfLq4v/1N+RRK62TqhmBc+1kuXXRMS5x
 Qb1+sz0PiUZNqOv2AQ/QpH1gLKuOEIBl/N1YMPaDuYBr0kbik9jevSMHRnveCf+7dHfA
 02qrvkKbD3xKh2AXbHj3JQaEP5GZCiOAR8I+XDGnbr3yc8JLLwEnTa+i1kCSeDYAbtbt
 Bz6d0RBKfHsK5Xuk6vnU1JQjI5Zqm4kHaLP/0Y9JOsIOVvGNdWVB/awRWge9bK9y87x6
 ja7l07Lxw/msogChwbGuNOYXMRWealW4mfDXhk2ar49wokiLlzuedk7aB2Cxhz7XA2gE
 BVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504594; x=1693109394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aANH9BT8Cchha/fX0LxWm06dw8tJcyEz3eyG1bX5EM=;
 b=WSSYFQWwtKsYoDR8x7AEaE3bTDpd0uxSuZzbgVCmw0DhzyHT2jdlbMW2sRnizdGKgd
 Ga/ivF1z42TEudAPptCdPC0DF5RQx0IR/EiVjgkRNF/04cMUMfq42gb16gRU86KK9cTJ
 PS6jQYZTfq06Q9QqH6aRJKSuODouiRcJzj86NRpvU49EJgGmvefWZD/9UtkS07o66vCq
 eD6ZEZ7cfR2BmCOevsXXNPFhkXHTbwJpUE6Q9aa85Mfqqy5AhsqG4MW+tyrV+TFFA2cH
 wMSR6DjrwVfRFSOk0yt8j8kCWVG2FJ3xpIGoly+GEiexJ1f/mIq0UT5ktdAVXY2B4PPA
 VRdw==
X-Gm-Message-State: AOJu0YwUW05zO0/AE/Qxg75NMmmJSh7+SQGZqzhOP3bZXa6lb8gLi4D8
 puhhusBZpTuNNR+OCVS91TyHNf8NFHI3ohCJ9exxTB/PHTE670EX
X-Google-Smtp-Source: AGHT+IGzgArLj6rZRqPvjgxM2pJuJptC/xVFJ8hGlQZ3UAcuEp2I91kTGfq6crL0e5tgnMWkkekbNNaizrEOGdAvgSs=
X-Received: by 2002:aa7:d297:0:b0:522:2add:5841 with SMTP id
 w23-20020aa7d297000000b005222add5841mr3310327edq.7.1692504594686; Sat, 19 Aug
 2023 21:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-5-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-5-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:09:47 -0600
Message-ID: <CANCZdfp0Q5ck-vMMOA4AQbELGEQaBE881LSXEiW-vfZyUky2ng@mail.gmail.com>
Subject: Re: [PATCH 04/22] Introduce freebsd/os-misc.h to the source tree
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000025b662060352ef73"
Received-SPF: none client-ip=2a00:1450:4864:20::52f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52f.google.com
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

--00000000000025b662060352ef73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> To preserve the copyright notice and help with the 'Author' info for
> subsequent changes to the file.
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-misc.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 bsd-user/freebsd/os-misc.h
>

 Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000025b662060352ef73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
To preserve the copyright notice and help with the &#39;Author&#39; info fo=
r<br>
subsequent changes to the file.<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-misc.h | 28 ++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 28 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-misc.h<br></blockquote><div><b=
r></div><div>=C2=A0Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdim=
p.com">imp@bsdimp.com</a>&gt;<br></div></div></div>

--00000000000025b662060352ef73--

