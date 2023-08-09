Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C277510A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZIa-0004y6-Cu; Tue, 08 Aug 2023 22:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZIV-0004xp-G9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:51:43 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZIT-000848-TG
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:51:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5231f439968so6693084a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691549500; x=1692154300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=so0doi6RVmXjvSMXmrH/lcAHKysKDNqYJmn3BU5SlPA=;
 b=DE9KVM+Ps3zynptV6/+IhooWSZWcBxZPFlolBkZXXKNb97C9lX8043XBXlA8OA0Iq2
 klelMjZSPyGzyuy6JO5n6qEVV2aDk/fZ12WNSLQIbLVM0J6S+v8eIz4PoUthm1dVACvA
 iEr0WmVmIEwSPzlkscOrQMhMfDGlgJgnyK6CqI8X1X8ojEplw3FfjCAtVPrOo25H837H
 dDdNKQ34+ldZE3t1voVYiZXzlT5Fga3hwTiUTQB82Zsnp49GUuAAJq0PLYU+5SEMh5Qz
 UVH/UqdIIlbJ10JJ6CPG/wiC25O36iN1H36TY11GOFxbBoHWY3fbQAVQFhbU3CZGh/Mx
 8GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691549500; x=1692154300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=so0doi6RVmXjvSMXmrH/lcAHKysKDNqYJmn3BU5SlPA=;
 b=ffWNWEh/BrSKgVfjgqvvGfHsu7YwCVxARNfzq7tHXYA1WLsVSz5M3sPZrCCLhRf9H/
 yGQWwqj1uuNr0RXtJJAkSOZFXCvRQNwukAJhar0x5KIPrU7eG2F5A3dF89dMiEHq8IZB
 1T61wN6uM8DDb5niT7nauTB+LIus3IxftLgn9jc+idA5AXA3uGo40vkZFIpwTj8oSOv4
 Z6wJ5aHBqmdEKpbBIDIboaGPmceJKRkJoBKD05N32xbscHA6ur3OKcTfUFClJ1ZbjoJb
 961Oivfp5JJwXZigPeJ+iGag6MJKdnaZqWaSezM3Jnkg83IIwxzlKj1EOXR1CaA4mVNe
 53HQ==
X-Gm-Message-State: AOJu0YwKcDroXO+01+zM73OAqkTyNigmXCoX7nfN5MEm5ikc1sW4Kpz+
 1AFjCbn71bPi/XF0aommtzthlewxKF0f8ZCOh1JOvA==
X-Google-Smtp-Source: AGHT+IGo4SsVToneqVTcbx5RQgLBXwD89a2zCsnhIUVUVs77A7xgOZxa6mKrLPDWeHuJVEnsYhsVj3tLUFJC2qZnFg0=
X-Received: by 2002:a17:906:5354:b0:987:4e89:577f with SMTP id
 j20-20020a170906535400b009874e89577fmr973240ejo.24.1691549499726; Tue, 08 Aug
 2023 19:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-9-kariem.taha2.7@gmail.com>
 <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
In-Reply-To: <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 20:51:30 -0600
Message-ID: <CANCZdfokHaz0PiLyesK9abDB6CGWzYBhtN=MRhY=JJo1x_DKFw@mail.gmail.com>
Subject: Re: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000000d307c0602748f76"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
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

--0000000000000d307c0602748f76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:24=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > +    uint32_t   st_flags;    /* user defined flags for file */
> > +    __uint32_t st_gen;      /* file generation number */
>
> Drop the __.
>
> > +    /* __int32_t  st_lspare; */
>
> Why commented out?
>

I believe that the element was a padding one ....


> > +    struct target_freebsd_timespec st_birthtim; /* time of file
> creation */
>
> Does that not place st_birthtim at the wrong place?
>

So this winds up in the right place because there's a hole...

However, having said that, I don't think it should be commented out. It's
not
in the bsd-user branch. And the state of the upstream code is such that we
can't
run full tests easily on the system calls, so we're making sure they
basically
work, but will run the full regression test once some other changes are mad=
e
to allow shared libraries to work (many of the calls in this patch are
needed
to make 'hello world' work).

Warner



>
> r~
>

--0000000000000d307c0602748f76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:24=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrote:<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0st_flags;=C2=A0 =C2=A0 /* user def=
ined flags for file */<br>
&gt; +=C2=A0 =C2=A0 __uint32_t st_gen;=C2=A0 =C2=A0 =C2=A0 /* file generati=
on number */<br>
<br>
Drop the __.<br>
<br>
&gt; +=C2=A0 =C2=A0 /* __int32_t=C2=A0 st_lspare; */<br>
<br>
Why commented out?<br></blockquote><div><br></div><div>I believe that the e=
lement was a padding one ....<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timespec st_birthtim; /* time of =
file creation */<br>
<br>
Does that not place st_birthtim at the wrong place?<br></blockquote><div><b=
r></div><div>So this winds up in the right place because there&#39;s a hole=
...</div><div><br></div><div>However, having said that, I don&#39;t think i=
t should be commented out. It&#39;s not</div><div>in the bsd-user branch. A=
nd the state of the upstream code is such that we can&#39;t</div><div>run f=
ull tests easily on the system calls, so we&#39;re making sure they basical=
ly</div><div>work, but will run the full regression test once some other ch=
anges are made</div><div>to allow shared libraries to work (many of the cal=
ls in this patch are needed</div><div>to make &#39;hello world&#39; work).<=
br></div><div><br></div><div>Warner<br></div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--0000000000000d307c0602748f76--

