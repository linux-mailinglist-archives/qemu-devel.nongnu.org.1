Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60F77513A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:07:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZXf-0003fB-Uz; Tue, 08 Aug 2023 23:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZXZ-0003en-GP
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:07:17 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZXX-0002KN-42
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:07:16 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-997c4107d62so876798766b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691550433; x=1692155233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K2WH+1GVjdr+Rf2EFCdasscDxX//R7WDdFMAqnwA8aE=;
 b=UuVE2ixvTKfFiiScB0+bxZ9zRW6W5q32RHBnNPHysdhNHUf0Dliq8kPrY4WYpgSgY0
 S0iwatSGXdxQJzGp5dDtQFt64bF0+3doTSo6EncHyUwo/weuGBynQbg1gV//6NFSnQr4
 Q2noQQ2iPMivisAM5sLh3s/iuQ/CI2oapcwhFmKaftSisBbfp26GXlKQU9Uf0lmUDj07
 N0YT/5OXsGFLS4uvkbnCS+cfeXpXaceJeHKE7fKD8WqvuVYAI/xmbLfXcpbYRFuvDvNg
 DRfTopjgwh0UmkK6pYxdE4pdn54qtwUUEO5E44tn5inco3vMpYZyv5CZAe7q6FH4hcMz
 VVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550433; x=1692155233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2WH+1GVjdr+Rf2EFCdasscDxX//R7WDdFMAqnwA8aE=;
 b=MupJpmNJrf3jLV18QU7J5uPMM7QQnjBW9kvRnR0rP5fl+LvKObLYnHhb3383HAe5Lw
 5fSZ5hVR2KY9HLpa7+b9p982up9P5bREO7LgqNXlTQnryGJTnaENHmb0BzwpESa7/ejd
 EtoWjJsRty/2E058TxdYKdeECQXez4jVdgdVft1g+y7J9oTMh2uhpTupNmFZII5WpxwU
 /8chjdbhDo6OE8qt8IGL0WDAo+7R1LwpGmXdLknxa0jufcWU7Fadnv8kKNA64cMDIXKs
 PZ2Hd1K+I0jELAdIE6odEGCC5P/2f95H2ZpUzH+FQC8QLl7wlBLXnD7TPh8XZbXwdSad
 Pkfg==
X-Gm-Message-State: AOJu0YwVdM2+7njT1QOkCFNecUFhv/8JyszcNtr0e2WL3WiCZ/qc+leE
 gfmNC/D/nOUGCsqsjZd40P6ho0E4ru//7WtyuGF5/wmh53YLorzR/2Q=
X-Google-Smtp-Source: AGHT+IEclMIVZMSzXbvw2SJF6owt59BkubPpYgt8vc0wLiPzfk7UT86zH9wSVMKn/InN53msQzcT6LLfZK0AaaRzmiw=
X-Received: by 2002:a17:906:8455:b0:991:f427:2fdf with SMTP id
 e21-20020a170906845500b00991f4272fdfmr1143555ejy.76.1691550433554; Tue, 08
 Aug 2023 20:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-19-kariem.taha2.7@gmail.com>
 <ebc5c562-205e-5a1a-6b3e-381b8c022b26@linaro.org>
In-Reply-To: <ebc5c562-205e-5a1a-6b3e-381b8c022b26@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 21:07:04 -0600
Message-ID: <CANCZdfrZSF1cxTPYa-ec1rMqjC9cDVOR148qUG=g=S1MXh34Wg@mail.gmail.com>
Subject: Re: [PATCH 18/33] Implement stat related syscalls
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b64984060274c659"
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x636.google.com
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

--000000000000b64984060274c659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:53=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:08, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Implement the following syscalls:
> > stat(2)
> > lstat(2)
> > fstat(2)
> > fstatat(2)
> > nstat
> > nfstat
> > nlstat
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Why are all of these in os-stat.h instead of os-stat.c?
> Is this attempting to avoid clang's warning for unused static inline
> function in a c file?
>

I asked Stacey about this ages ago (why some things are like this) and he'd
indicated it was for better optimization (inlining) in
do_freebsd_syscall(). Other
inlines are in the .h files so that we can define a common set, and include
that
file and have netbsd/openbsd/freebsd pick and choose which ones to use
without
the warnings. The whole thing is a big mess right now, to be honest, but
I've tried
to avoid making structural changes in this area since I didn't want to
introduce bugs
and we have been chasing some weird corruption bug with threads for ages
(though
it might be related to the vm address space use bug that you fixed
recently, I've not
run things to see if that fixed it or not).

So, that's kinda why. I do agree with you that that would be a better
structure, but
can we use this structure for upstreaming and once we get the other issues
worked
out, we can do a restructure... We've moved things around a bit, and I'm
also waiting
for the NetBSD folks that contacted me to finish their efforts before I
pull the rug out
from them (or they timeout, which isn't quite yet).

Warner


> > +/* stat(2) */
> > +static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
> > +{
> > +    abi_long ret;
> > +    void *p;
> > +    struct freebsd11_stat st;
> > +
> > +    LOCK_PATH(p, arg1);
> > +    ret =3D get_errno(freebsd11_stat(path(p), &st));
> > +    UNLOCK_PATH(p, arg1);
> > +    if (!is_error(ret)) {
> > +        ret =3D h2t_freebsd11_stat(arg2, &st);
> > +    }
> > +    return ret;
> > +}
>
> The patch ordering is poor, because freebsd11_stat is used here but not
> introduced until
> patch 23, and do_freebsd11_stat itself is not used until patch 30.
>
> And yet you delay compilation of os-stat.c until patch 29.  Patch 29 is
> either too early
> or too late, depending on the viewpoint.
>
> If os-stat.c compilation was enabled earlier, it would require you to
> order all of the
> patches such that os-stat.c will always compile.
>
> If os-stat.c compilation was enabled later (indeed last), you would not
> need to mark this
> function 'static inline' in order to avoid unused function warnings prior
> to their use in
> patches 30-33.
>
> I prefer the ordering in which os-stat.c always compiles.  This probably
> requires patches
> 23-27 be ordered first, and patches 30-33 be merged with patches 18-22.
> There is no need
> for *any* of these functions to be marked inline -- leave that choice to
> the compiler.
>
>
> r~
>

--000000000000b64984060274c659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:53=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:08, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Implement the following syscalls:<br>
&gt; stat(2)<br>
&gt; lstat(2)<br>
&gt; fstat(2)<br>
&gt; fstatat(2)<br>
&gt; nstat<br>
&gt; nfstat<br>
&gt; nlstat<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
<br>
Why are all of these in os-stat.h instead of os-stat.c?<br>
Is this attempting to avoid clang&#39;s warning for unused static inline fu=
nction in a c file?<br></blockquote><div><br></div><div>I asked Stacey abou=
t this ages ago (why some things are like this) and he&#39;d</div><div>indi=
cated it was for better optimization (inlining) in do_freebsd_syscall(). Ot=
her</div><div>inlines are in the .h files so that we can define a common se=
t, and include that</div><div>file and have netbsd/openbsd/freebsd pick and=
 choose which ones to use without</div><div>the warnings. The whole thing i=
s a big mess right now, to be honest, but I&#39;ve tried</div><div>to avoid=
 making structural changes in this area since I didn&#39;t want to introduc=
e bugs</div><div>and we have been chasing some weird corruption bug with th=
reads for ages (though</div><div>it might be related to the vm address spac=
e use bug that you fixed recently, I&#39;ve not</div><div>run things to see=
 if that fixed it or not).</div><div><br></div><div>So, that&#39;s kinda wh=
y. I do agree with you that that would be a better structure, but</div><div=
>can we use this structure for upstreaming and once we get the other issues=
 worked</div><div>out, we can do a restructure... We&#39;ve moved things ar=
ound a bit, and I&#39;m also waiting</div><div>for the NetBSD folks that co=
ntacted me to finish their efforts before I pull the rug out</div><div>from=
 them (or they timeout, which isn&#39;t quite yet).</div><div><br></div><di=
v>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +/* stat(2) */<br>
&gt; +static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +=C2=A0 =C2=A0 struct freebsd11_stat st;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 LOCK_PATH(p, arg1);<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(freebsd11_stat(path(p), &amp;st));<br=
>
&gt; +=C2=A0 =C2=A0 UNLOCK_PATH(p, arg1);<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D h2t_freebsd11_stat(arg2, &amp;st)=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
<br>
The patch ordering is poor, because freebsd11_stat is used here but not int=
roduced until <br>
patch 23, and do_freebsd11_stat itself is not used until patch 30.<br>
<br>
And yet you delay compilation of os-stat.c until patch 29.=C2=A0 Patch 29 i=
s either too early <br>
or too late, depending on the viewpoint.<br>
<br>
If os-stat.c compilation was enabled earlier, it would require you to order=
 all of the <br>
patches such that os-stat.c will always compile.<br>
<br>
If os-stat.c compilation was enabled later (indeed last), you would not nee=
d to mark this <br>
function &#39;static inline&#39; in order to avoid unused function warnings=
 prior to their use in <br>
patches 30-33.<br>
<br>
I prefer the ordering in which os-stat.c always compiles.=C2=A0 This probab=
ly requires patches <br>
23-27 be ordered first, and patches 30-33 be merged with patches 18-22.=C2=
=A0 There is no need <br>
for *any* of these functions to be marked inline -- leave that choice to th=
e compiler.<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--000000000000b64984060274c659--

