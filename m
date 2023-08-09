Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D3775203
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 06:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTb0f-0002Z3-R2; Wed, 09 Aug 2023 00:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTb0Z-0002Yk-Ny
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 00:41:20 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTb0X-0005Cg-BS
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 00:41:19 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5231410ab27so7224883a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691556075; x=1692160875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg3ZDbA8DqMUWvDx/E/06HVuzD+TcCdh5eildYoeEUc=;
 b=xoPy6CID3CxPJQQXrXcmGo8gisN9CTvutHUP/qY1Ci7bWYnXqToXBFacDoiuBqRx5o
 LhtToUcouHMKw/RSsFOeDD1QuxjIgbxFr8ujz9LlVDFtGe5QmCmoweSh1eVyvdgq2Y3P
 A0E7OamR/Jjge7SaE3g2GGpPI+4/D3ETjDf0LcAJOf4c/BRHDu2wkS/Bjh0U1PfKC25i
 5cREiZESV/utBCm7p1E4ibaN0A7vw1BoT5l+Y++NcwsDg1ye3FvsF3Gacyz9ODqpMAKs
 lVaeK6OTuZrxftM6EMysyZHqZLDDXxt5v5Rqg7yc0k+Ymkvrn3jnElR5cWtW/ByJbgzR
 M34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691556075; x=1692160875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tg3ZDbA8DqMUWvDx/E/06HVuzD+TcCdh5eildYoeEUc=;
 b=GFQ+4oYgkTTV72CwNpIJC0diHA4UtxlNWf9wAQxFsSPRDg3KPH+tzhukB9gzuoMN8m
 aqIEABc3/rBw87stR0iRiTlYn0XFEHxJlS6c5Ty0k/Vk8ZH6AFkbahYdIGs+nTM3X9Vy
 sMoo45assWqwK0KE+YOKd0syN+TwfsiZRFbxq60TBctLCj0Jws/LwKAZZ6jGM/yWTlKw
 h3b4UxAa+1ooNDVlQMFkpcqBNpOBDmtgAzlj9mQ7pYL7lD9zsUsOvPZA1yklhtR18To1
 uptDje3+c5sOaX+u8YicZ07W5O+Zegrx9LYfSxgVYCxOzXgTggo2b8Nj1bQ/v8eIK6fm
 aEzQ==
X-Gm-Message-State: AOJu0YwjD8ctxL0Wtoq12N3KG4YBqRZHzKLmXV/J9mB5i83MqINRbzL8
 PIBd24A0P49y0wG4Necc2z4NsQZRWR8jj4FEK6Id6A==
X-Google-Smtp-Source: AGHT+IFVpFpUziGuOFX9qz9r73rSr4v5IHza0tsU7237/cb4iqQs7gDCk6wjyLp+xGUiXx3glZty+1KbEm8B42eBMY0=
X-Received: by 2002:a17:907:7858:b0:993:f996:52d5 with SMTP id
 lb24-20020a170907785800b00993f99652d5mr1071422ejc.25.1691556074976; Tue, 08
 Aug 2023 21:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-9-kariem.taha2.7@gmail.com>
 <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
 <CANCZdfokHaz0PiLyesK9abDB6CGWzYBhtN=MRhY=JJo1x_DKFw@mail.gmail.com>
 <b8651c48-b8bf-e7ec-564d-1077d9e58cfb@linaro.org>
In-Reply-To: <b8651c48-b8bf-e7ec-564d-1077d9e58cfb@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 22:41:05 -0600
Message-ID: <CANCZdfpwQAPLYxsf18RPyr1GDz6h1uT9MNLuhADG-dT0B7HOFw@mail.gmail.com>
Subject: Re: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000f78b670602761610"
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

--000000000000f78b670602761610
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 9:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/8/23 19:51, Warner Losh wrote:
> >      > +    /* __int32_t  st_lspare; */
> >
> >     Why commented out?
> >
> >
> > I believe that the element was a padding one ....
> >
> >      > +    struct target_freebsd_timespec st_birthtim; /* time of file
> creation */
> >
> >     Does that not place st_birthtim at the wrong place?
> >
> >
> > So this winds up in the right place because there's a hole...
> >
> > However, having said that, I don't think it should be commented out.
> It's not
> > in the bsd-user branch. And the state of the upstream code is such that
> we can't
> > run full tests easily on the system calls, so we're making sure they
> basically
> > work, but will run the full regression test once some other changes are
> made
> > to allow shared libraries to work (many of the calls in this patch are
> needed
> > to make 'hello world' work).
>
> I think there is not a hole, because the struct is __packed.
>
> (Also, QEMU_PACKED vs __packed?)


There's a nstat that's an older stat w/o this field. I'm not entirely sure
__packed should
be on either one of these, honestly. nstat is quite old, and I'm not at all
sure what's up
with it. I think it dates from a time when there was only i386 and then we
expanded to
alpha and needed to 'fix' this interface... Not sure why it got the
freebsd11_ prefix, so
I'll have to chase those details down to see if this is an extra cut and
paste or what.
That may take a little bit to chase down in the logs and in people's
memory. I think
that's the back story. Normally, nstat is only defined in the kernel, and
this is a binary
interface from ages ago that we likely don't need to implement, but I need
to confirm
that, and make sure rust or go don't have some weird, misguided mistake...

But nstat and stat are supposed to be the same, except nstat omits
st_spare, so that's
why it's commented out. stat's supposed to be carefully laid out so packed
or not
doesn't matter. But testing that would take a little bit as well.

Warner


> ~
>

--000000000000f78b670602761610
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 9:12=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/8/23 19:51, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* __int32_t=C2=A0 st_lspare; =
*/<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why commented out?<br>
&gt; <br>
&gt; <br>
&gt; I believe that the element was a padding one ....<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 struct target_freebsd_timespec=
 st_birthtim; /* time of file creation */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Does that not place st_birthtim at the wrong place?=
<br>
&gt; <br>
&gt; <br>
&gt; So this winds up in the right place because there&#39;s a hole...<br>
&gt; <br>
&gt; However, having said that, I don&#39;t think it should be commented ou=
t. It&#39;s not<br>
&gt; in the bsd-user branch. And the state of the upstream code is such tha=
t we can&#39;t<br>
&gt; run full tests easily on the system calls, so we&#39;re making sure th=
ey basically<br>
&gt; work, but will run the full regression test once some other changes ar=
e made<br>
&gt; to allow shared libraries to work (many of the calls in this patch are=
 needed<br>
&gt; to make &#39;hello world&#39; work).<br>
<br>
I think there is not a hole, because the struct is __packed.<br>
<br>
(Also, QEMU_PACKED vs __packed?)</blockquote><div><br></div><div>There&#39;=
s a nstat that&#39;s an older stat w/o this field. I&#39;m not entirely sur=
e __packed should</div><div>be on either one of these, honestly. nstat is q=
uite old, and I&#39;m not at all sure what&#39;s up</div><div>with it. I th=
ink it dates from a time when there was only i386 and then we expanded to</=
div><div>alpha and needed to &#39;fix&#39; this interface... Not sure why i=
t got the freebsd11_ prefix, so</div><div>I&#39;ll have to chase those deta=
ils down to see if this is an extra cut and paste or what.</div><div>That m=
ay take a little bit to chase down in the logs and in people&#39;s memory. =
I think</div><div>that&#39;s the back story. Normally, nstat is only define=
d in the kernel, and this is a binary</div><div>interface from ages ago tha=
t we likely don&#39;t need to implement, but I need to confirm</div><div>th=
at, and make sure rust or go don&#39;t have some weird, misguided mistake..=
.<br></div><div><br></div><div>But nstat and stat are supposed to be the sa=
me, except nstat omits st_spare, so that&#39;s</div><div>why it&#39;s comme=
nted out. stat&#39;s supposed to be carefully laid out so packed or not</di=
v><div>doesn&#39;t matter. But testing that would take a little bit as well=
.<br></div><div><br></div><div>Warner</div><div>=C2=A0<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">~<br>
</blockquote></div></div>

--000000000000f78b670602761610--

