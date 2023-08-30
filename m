Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB478D61F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLCx-0005iO-Rr; Wed, 30 Aug 2023 09:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbLCv-0005i2-Jx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:05 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbLCs-0003zf-KO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:26:05 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso187101766b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693401961; x=1694006761;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1NjUvmYK8LsJnjhMqaCCXXiJ27ExEkNbMVG0096ujI=;
 b=a5rErTPeF/T99LXXmDS0PRhs+/EQvfaOVxtJk8uubiODIPNeXZnXRNQ3oYfO/lB9c0
 WyOhvpZbnR6LnebgPQ4Jb1u/5Pr0ckxc/5FI4wiJ4oQ2sBfaqMaBeyR3JyUUa3ooHP0h
 r2tuF8IE07Lw9emt7lI81t5CwnOWS2FwZJ5W6mXO2PQp5Ro065a1alscOwnZen6LchAe
 0pJ4h/peu3kRarl7J3jdGBf9XsUIBlnbfN2FzKKUrjl+uBLVOip7XwWbBLnZCbqZk7Pp
 4PXX5v4dxWQp+WfVd0Cz6H0rZjlu8hnn8gGw73L5TUz8+MbGtCtx72t3/VWVPK6+W/1n
 qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693401961; x=1694006761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1NjUvmYK8LsJnjhMqaCCXXiJ27ExEkNbMVG0096ujI=;
 b=Mz14RGFTs3xRfCaFwPno9+oSmdbH3jqeH+iTdQhFj4c8IgkpmzHsIsucjue9C3YR7T
 3qBBwaG0+XSRpV6efB1Wvy2xfu0pCpIZ3zTcZsDXDQ2RydLzVhenLVw4w6SQQyhEngVm
 eaQhvCAxR6SL/Kg29FDDOUbVmKIyOoWEHOtoS7dcnhobujlBo3ViZ0oafsCFCY0p8DLO
 xK8sVv8w8KJmN6dLIcMIt3JuQAHCj6ijjWSRctJR9Oq30/3XHkq+zEvdbjblpOvX1K7p
 PBrXf1MDkJz5BMRNqAx3RCxR6Kq2aCDCgMwkdkWHf4yY0vavgeHExsboIlg4VN3nr25w
 Nsyw==
X-Gm-Message-State: AOJu0YyP2wlWOD0Ycrdgcqxz6ikOThtAhu3bM02z/tsfCj8giGLJBHBu
 UOyxvQVqLkHDZbKdulgN6cOBLc5f42igBW8L3OUcxQ==
X-Google-Smtp-Source: AGHT+IE7sf99tmPvQ8Hgk1u/6OAmusgLOQCdwpBe4cZtfgJZFgoZ1N0Rh0RsmQSonCPxft76KWWb4Hu6sDP2xVhNMkQ=
X-Received: by 2002:a17:907:980c:b0:9a1:c32c:a69c with SMTP id
 ji12-20020a170907980c00b009a1c32ca69cmr6287596ejc.17.1693401960595; Wed, 30
 Aug 2023 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230830022205.57878-1-imp@bsdimp.com>
 <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
In-Reply-To: <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 30 Aug 2023 07:25:48 -0600
Message-ID: <CANCZdfrHVB+4bYKhqNcUXEr8WWQmwK8PHF=N_9siX3MBckDJNw@mail.gmail.com>
Subject: Re: [PULL 0/1] Quick fix patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000052dcd1060423de69"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--00000000000052dcd1060423de69
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 30, 2023, 7:16 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> Hi,
> The patch introduces the following build failure:
>
> cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p
> -Isubprojects/libvhost-user -I../subprojects/libvhost-user
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu99 -O2 -g
> -Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> -fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o
> subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c
> ../subprojects/libvhost-user/libvhost-user.c
> In file included from ../subprojects/libvhost-user/include/atomic.h:18,
> from ../subprojects/libvhost-user/libvhost-user.c:53:
> ../subprojects/libvhost-user/include/compiler.h:38:40: error: missing
> binary operator before token "("
> 38 | #if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
> | ^
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4981576093


Looks like the macros should be removed there too...  but I don't know
about the subproject tree. Can I submit to it the same way?

And for a quick fix... maybe I just move it back to bsd-user/qemu.h until I
have more minutes and can test things better or fund the time to setup a
Linux build box for docker...

Warner


> Stefan
>

--00000000000052dcd1060423de69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Aug 30, 2023, 7:16 AM Stefan Hajnoczi &lt;<a h=
ref=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Hi,<br>
The patch introduces the following build failure:<br>
<br>
cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p<br>
-Isubprojects/libvhost-user -I../subprojects/libvhost-user<br>
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu99 -O2 -g<=
br>
-Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing<br>
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing<br>
-fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ<br>
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF<br>
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o<br>
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c<br>
../subprojects/libvhost-user/libvhost-user.c<br>
In file included from ../subprojects/libvhost-user/include/atomic.h:18,<br>
from ../subprojects/libvhost-user/libvhost-user.c:53:<br>
../subprojects/libvhost-user/include/compiler.h:38:40: error: missing<br>
binary operator before token &quot;(&quot;<br>
38 | #if defined(__clang__) &amp;&amp; __has_warning(&quot;-Waddress-of-pac=
ked-member&quot;)<br>
| ^<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/4981576093" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/jobs/4981576093</a></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Looks like the macros should be removed there too...=C2=
=A0 but I don&#39;t know about the subproject tree. Can I submit to it the =
same way?</div><div dir=3D"auto"><br></div><div dir=3D"auto">And for a quic=
k fix... maybe I just move it back to bsd-user/qemu.h until I have more min=
utes and can test things better or fund the time to setup a Linux build box=
 for docker...</div><div dir=3D"auto"><br></div><div dir=3D"auto">Warner</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><br>
Stefan<br>
</blockquote></div></div></div>

--00000000000052dcd1060423de69--

