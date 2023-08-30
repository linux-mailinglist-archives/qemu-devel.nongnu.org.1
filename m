Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5D78D690
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMEL-0001DZ-Pe; Wed, 30 Aug 2023 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbMEH-0001D8-O2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:31:34 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbMEE-00048C-HD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:31:33 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so8882532e87.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693405887; x=1694010687;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/8L+KQjXewEpGptRQpFqP7VngHBDgm7jVBykJrXjQE=;
 b=wqjouyVSvN/uaj+9PCAqeXIkQ8ZpwThNmUXByyy7GG0mHGqrkWPC2SErgfH4N2H7Qz
 kuvPVdnDDX5SwG6W0WzenF+4os3r4/U28HW4aCRL4RanDCRWQdwlKJCiM0zA86FavRu7
 i7UjqHCmaBwwwhmqyOaW/cqJwRmlzhhCLF075ZyhkJvRZbWZ9F63Q1m1IdrHzFiUbHt3
 kjhezfRVHrNH/CqT31ri5m82QlaXzWJJpNLeMf9isJ1NvtiwOC0NCElp4e0hzrJ1cQhK
 PtXq9ab0YY5uWyL7pKFPkXJBXDb8K06eVq6FKJmMJ79XuTpYcpc1ENQEZrpVHZJqRc5z
 gHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405887; x=1694010687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/8L+KQjXewEpGptRQpFqP7VngHBDgm7jVBykJrXjQE=;
 b=T2dpBa+EJO7aMwpSFfinJtZ7/LHRR8ozq3nKdbRNZdLwTtfVFDKdaZPtsjTGra/6f1
 xmqVW0ysfZfC5XoCyT1ZO+a/Xjfc8PuNy9z2l1bpSfhjmcakgLq7gkeM9oV0VnqSV3Bn
 kf8TEPd5artCDwRH09AXzHhjFyYEMCl7Zni5KdxsEWZFm2oUlTk5AXBEjJVcZxP48ci1
 r+IsFE69GXjoAZs5LZM9RouUYTAU7tosqzCkYXNMFaMW0tM699WyfBBlYZgbt4eACeZp
 IqDV9Z18kE/EHNE/txmctbOIdW2K1x4K5frwG8eKiEb3gwI7EmVfM1i8Pf3JskSHyxS9
 eC9Q==
X-Gm-Message-State: AOJu0YwJ3aKRTAqz0C2sFITrRvZR/qr9G7yBqFFnOMvDvCwfcz6fLOyo
 B0Hj8gi5HXqnnYvLj7wfw5Obw7svP2KQ+lb6f5Qw8np/9Z95/x8V
X-Google-Smtp-Source: AGHT+IERLN9SAQNh5b0gM02n6567G+cfykIAHU4TmsxdiQlVZTuG4IgaDsws7BZikfzV5C8U9CRcWrjwdHQV7fxUEtI=
X-Received: by 2002:ac2:54bb:0:b0:4fb:9168:1fce with SMTP id
 w27-20020ac254bb000000b004fb91681fcemr1555422lfk.59.1693405887160; Wed, 30
 Aug 2023 07:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230830022205.57878-1-imp@bsdimp.com>
 <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
 <bcc8770e-95e6-e259-3c0b-e18a2c41474b@redhat.com>
In-Reply-To: <bcc8770e-95e6-e259-3c0b-e18a2c41474b@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 30 Aug 2023 08:31:15 -0600
Message-ID: <CANCZdfqijpBfCJpv0QywMF3bd4Kow-3wyqs2ohT7w3tcYWOVZQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Quick fix patches
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Laurent Vivier <laurent@vivier.eu>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005d824d060424c8f6"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12b.google.com
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

--0000000000005d824d060424c8f6
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 30, 2023, 7:26 AM Thomas Huth <thuth@redhat.com> wrote:

> On 30/08/2023 15.16, Stefan Hajnoczi wrote:
> > Hi,
> > The patch introduces the following build failure:
> >
> > cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p
> > -Isubprojects/libvhost-user -I../subprojects/libvhost-user
> > -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu99 -O2 -g
> > -Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing
> > -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> > -fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ
> > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF
> > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o
> > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c
> > ../subprojects/libvhost-user/libvhost-user.c
> > In file included from ../subprojects/libvhost-user/include/atomic.h:18,
> > from ../subprojects/libvhost-user/libvhost-user.c:53:
> > ../subprojects/libvhost-user/include/compiler.h:38:40: error: missing
> > binary operator before token "("
> > 38 | #if defined(__clang__) &&
> __has_warning("-Waddress-of-packed-member")
> > | ^
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/4981576093
>
> IIRC older versions of GCC do not have __has_warning() yet, so if you want
> to use this in compiler.h, you have to do it below the line in compiler.h
> that adds this:
>
> #ifndef __has_warning
> #define __has_warning(x) 0 /* compatibility with non-clang compilers */
> #endif
>

This already works for linux-user. If there are gcc versions that break,
our current CI jobs don't show it. Why add complexity for unsupported gcc
versions? And how do I know I got it right?

I'm really starting to think the feedback 'move it to compilers.h' should
have just been ignored... it's turning into a lot of my time to correct
that I don't have when I'm also out of CI minutes to test with.

Warner





>   HTH,
>    Thomas
>
>

--0000000000005d824d060424c8f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Aug 30, 2023, 7:26 AM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 30/08/2023 15.16, Stefan Hajnoczi wrote:<br>
&gt; Hi,<br>
&gt; The patch introduces the following build failure:<br>
&gt; <br>
&gt; cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p<br>
&gt; -Isubprojects/libvhost-user -I../subprojects/libvhost-user<br>
&gt; -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu99 -O=
2 -g<br>
&gt; -Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing<br>
&gt; -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing<br>
&gt; -fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ<br>
&gt; subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF<br>
&gt; subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o<br>
&gt; subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c<br>
&gt; ../subprojects/libvhost-user/libvhost-user.c<br>
&gt; In file included from ../subprojects/libvhost-user/include/atomic.h:18=
,<br>
&gt; from ../subprojects/libvhost-user/libvhost-user.c:53:<br>
&gt; ../subprojects/libvhost-user/include/compiler.h:38:40: error: missing<=
br>
&gt; binary operator before token &quot;(&quot;<br>
&gt; 38 | #if defined(__clang__) &amp;&amp; __has_warning(&quot;-Waddress-o=
f-packed-member&quot;)<br>
&gt; | ^<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/4981576093" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/jobs/4981576093</a><br>
<br>
IIRC older versions of GCC do not have __has_warning() yet, so if you want =
<br>
to use this in compiler.h, you have to do it below the line in compiler.h <=
br>
that adds this:<br>
<br>
#ifndef __has_warning<br>
#define __has_warning(x) 0 /* compatibility with non-clang compilers */<br>
#endif<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">This already works for linux-user. If there are gcc versions that bre=
ak, our current CI jobs don&#39;t show it. Why add complexity for unsupport=
ed gcc versions? And how do I know I got it right?</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I&#39;m really starting to think the feedback &#=
39;move it to compilers.h&#39; should have just been ignored... it&#39;s tu=
rning into a lot of my time to correct that I don&#39;t have when I&#39;m a=
lso out of CI minutes to test with.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Warner</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 HTH,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div></div></div>

--0000000000005d824d060424c8f6--

