Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2B78CFE2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mz-0000nG-Qb; Tue, 29 Aug 2023 19:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3by-0000PF-Fr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:38:46 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3bu-0000nc-5g
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:38:46 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so70003291fa.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693334319; x=1693939119;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0j1cHmvfZYgFj+aB1d4BvRk30V6wCU8Mnr2qF4Z3PLg=;
 b=ZPyNB87EQSQAIaspWHa8THw6z29Uqf77fM9ugrJpU8Lfg6sEIoWvuBMCavGjKk8Ms3
 fI6K69Xip4TDG8R5bHZxh2aPiZzFbNgDagK/Tox/PdBZ4RYp1VZRUrtoqsfxkaYpRyJX
 /U3vr4z1m0S/8IcAsMkU/n8WVD2NnSSfKAOxePYIvszjfTN4EMX4a2jk7mVEYZrpnYI2
 ZmvbnxCCpF8a5wUdagZG7kK0wiQ5on51GVQKFN1z3PBD/6Kqvf3LMXqY8+GyQRuwcEn0
 XHEBpIFiMH4C5PbAUXy7A0h/dzJsnZbO+LIgGgyYeUF8WLIHaBlAkxnrmu5qQxd20pEh
 8Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334319; x=1693939119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0j1cHmvfZYgFj+aB1d4BvRk30V6wCU8Mnr2qF4Z3PLg=;
 b=PZHfkydiVK4VOc4w+EIhEe61aJp0heNHQieVVb45t3SUcVMdikN/XycqyeC+Kb1w04
 ip4qnodBoTYKZXxsbWvZsaprd9d6gmWsH40nmDJZx9UFvjDfLQrQYU0JefAiqC7H7bll
 RBATNMs2nfuN+SIzSj9qrPW2WoBSoB4P4uRn/wRe0Ax24z037bkEKV5MlefXBA/Gl/vJ
 VMD3Fzz1dJDM+qbEdeS6c4/bdppTu1Rqg6J/BDAS/biwCGSfc6Bu9jLf0fKKqhzqP2GV
 7l0ZzBaPhV0J8Xgbeauxe1uDLyTFt7ylB9p46bILABTBjySyFT8KICuA+uGk6kHlbl2D
 WDig==
X-Gm-Message-State: AOJu0Yw5Ljj21wMo1WqILlRlKtwKfya0pQieQQw5xDK1VzDLi6E2rb10
 zSIqpwbE3rimz9d1liZPandQryYQ1sGKONVbVBMIJKbezFtq8+1M
X-Google-Smtp-Source: AGHT+IHRrBL09XyLzd4zpTIRClDnq7LJP46rinVKGtDX3GHx+rI2hudRwIJkaejG9GFhlQacXcL5P6xqXUSOGCSLbCE=
X-Received: by 2002:a2e:9cc8:0:b0:2bc:d522:dfd4 with SMTP id
 g8-20020a2e9cc8000000b002bcd522dfd4mr142512ljj.8.1693334319203; Tue, 29 Aug
 2023 11:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230828233821.43074-1-imp@bsdimp.com>
 <20230829135009.GA179554@fedora>
 <CAFEAcA_S1rTZgi6h1o9Hj9=ZoEEWbKiJ5KZ7Mx1fH0_+eX6FSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_S1rTZgi6h1o9Hj9=ZoEEWbKiJ5KZ7Mx1fH0_+eX6FSQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 12:38:28 -0600
Message-ID: <CANCZdfotH5rmsa6=2paG-2HOMYtMEDD4rApOzMRc8T6NU8AQiw@mail.gmail.com>
Subject: Re: [PULL 00/36] 2023q3 bsd user patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000095291d0604141eda"
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

--00000000000095291d0604141eda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 11:30=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Tue, 29 Aug 2023 at 14:51, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > Applied, thanks. In the future, please invoke git-request-pull(1) with
> > the public HTTPS repo URL to make it easier for anyone to fetch the
> > changes:
> >
> > > are available in the Git repository at:
> > >
> > >  git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request
> >    ^^^^^^^^^^^^^^
>
> Hi; it looks like this broke the clang-user build. Here's
> a gitlab CI run on my local branch:
> https://gitlab.com/pm215/qemu/-/jobs/4975956600
>
> In file included from ../../linux-user/arm/cpu_loop.c:21:
> ../../linux-user/qemu.h:210:9: error: 'PRAGMA_DISABLE_PACKED_WARNING'
> macro redefined [-Werror,-Wmacro-redefined]
> #define PRAGMA_DISABLE_PACKED_WARNING                                   \
>         ^
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/compiler.h:42:9:
> note: previous definition is here
> #define PRAGMA_DISABLE_PACKED_WARNING                                   \
>         ^
> 1 error generated.
>
> Looks like commit 15b950ecd16ecc added definitions
> of PRAGMA_DISABLE_PACKED_WARNING and PRAGMA_REENABLE_PACKED_WARNING
> to compiler.h without reconciling them with the
> slightly different ones in linux-user/qemu.h.
>
> Can we have a revert (or a quick fix), please ?
>

I'll look into right now. I think the solution is simple and I can have
something quickly (1-2 hours tops)

Warner

--00000000000095291d0604141eda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 11:30=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, 29 Aug 2023 at 14:51, Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; Applied, thanks. In the future, please invoke git-request-pull(1) with=
<br>
&gt; the public HTTPS repo URL to make it easier for anyone to fetch the<br=
>
&gt; changes:<br>
&gt;<br>
&gt; &gt; are available in the Git repository at:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-re=
quest<br>
&gt;=C2=A0 =C2=A0 ^^^^^^^^^^^^^^<br>
<br>
Hi; it looks like this broke the clang-user build. Here&#39;s<br>
a gitlab CI run on my local branch:<br>
<a href=3D"https://gitlab.com/pm215/qemu/-/jobs/4975956600" rel=3D"noreferr=
er" target=3D"_blank">https://gitlab.com/pm215/qemu/-/jobs/4975956600</a><b=
r>
<br>
In file included from ../../linux-user/arm/cpu_loop.c:21:<br>
../../linux-user/qemu.h:210:9: error: &#39;PRAGMA_DISABLE_PACKED_WARNING&#3=
9;<br>
macro redefined [-Werror,-Wmacro-redefined]<br>
#define PRAGMA_DISABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/compiler.h:42:9:<br=
>
note: previous definition is here<br>
#define PRAGMA_DISABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
1 error generated.<br>
<br>
Looks like commit 15b950ecd16ecc added definitions<br>
of PRAGMA_DISABLE_PACKED_WARNING and PRAGMA_REENABLE_PACKED_WARNING<br>
to compiler.h without reconciling them with the<br>
slightly different ones in linux-user/qemu.h.<br>
<br>
Can we have a revert (or a quick fix), please ?<br></blockquote><div><br></=
div><div>I&#39;ll look into right now. I think the solution is simple and I=
 can have something quickly (1-2 hours tops)</div><div><br></div><div>Warne=
r=C2=A0</div></div></div>

--00000000000095291d0604141eda--

