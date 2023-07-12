Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8604751024
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 19:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJe5Z-0005iI-7Q; Wed, 12 Jul 2023 13:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qJe5W-0005i9-VW
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 13:57:19 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qJe5V-0002ru-01
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 13:57:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so2348601a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1689184634; x=1691776634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qTNm5QQy4qza3aLasAFegYwAnFUPdWXCc40Ez1ZvGgo=;
 b=gXC5zgdZ4J6fkF8ggYE2tR9nHsROWfe2+yB1BXAt4FlK5iu2GcIM7A2tnFcpZqpfDP
 YmfELEbYj5/rVVfDwbKKJbaIHXjksqnTmqZQza1WmJGY5QKkRyHpupxuZ+yF69qlS928
 Cn7cDPSRb3QW7VH1OHXUInmW0kId/xRjCpBSbFDEzXaG8wtZ1eSEYmyltN0/L9TUqUM0
 spTtcUdq6AIJt4ou4D6/kQ6mDhGtCU7BUqg89sRznydbeWQ0Cv+EN3B3o6oHEHJTB9Li
 ihAf8j9gXB30jYpXpqTEV+6Fap3WJFD3qibb4U+JQDI+UhttOKD5yx2skAccHQU2k4+/
 DHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689184634; x=1691776634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qTNm5QQy4qza3aLasAFegYwAnFUPdWXCc40Ez1ZvGgo=;
 b=LJlFJoorZo9TmFoWAgGAI41ekDwuBC/QADB8TfIZgjDxDQsZKic0BUtFdoYOYnB4zy
 Y9H+WNzYOTPBw933q3qJaxgzmg/aMlaZRJqV3S5+li2fQ7BxNHa6F55rotUlbw9ZlBdP
 BmjX7Nzktp/LZoXredfFcNfzxZveiqMYToBTIiB+lQUU9SWNMieVHhKEiijJRJ60dVXC
 piXlpQHHLxjovuE5UlHIgayFwavAj7AK/7GWU33AP4Ozixo1wrcKS3gV8+NeJj2Sc2sk
 zI0fOXVzxcm0RuGL4EZSrrwOgmOD6imtQXUE5gcAur9QuNt5HuBy0PSu2qxz1eUj3hPj
 Am5g==
X-Gm-Message-State: ABy/qLZ1+IHvp0MkFWqttMI4OCBBMW5p/JQ9dv6iYHEq4y+kHruLvK/+
 Euqqjdtv5xDejzE0yf7dUZPXwXG8gFPTK0KNOJTcIA==
X-Google-Smtp-Source: APBJJlEpS7QQNmbWameuov4oKHjmEs8L03IDdmg4wJBJRUxkfOWvWi513B6iY5ucqZs8wB7tdxamKdhJL9WSBUxG1M4=
X-Received: by 2002:a05:6402:3492:b0:51e:48e7:72ca with SMTP id
 v18-20020a056402349200b0051e48e772camr3974745edc.13.1689184634190; Wed, 12
 Jul 2023 10:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-2-philmd@linaro.org>
 <CANCZdfptsrH6vXCtjxWyjSFu4CG92xmOuQ9i1uGs3301QmxC=g@mail.gmail.com>
 <68f79db8-b241-0ad6-353f-11bd68e3ffd9@linaro.org>
In-Reply-To: <68f79db8-b241-0ad6-353f-11bd68e3ffd9@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 12 Jul 2023 11:57:03 -0600
Message-ID: <CANCZdfrmZSciRGRSVF0MQc0OtaRZH81Dp1eJN+C490Aw5YLMdg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tests/lcitool: Generate distribution packages list
 in JSON format
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014ce6306004df22e"
Received-SPF: none client-ip=2a00:1450:4864:20::52b;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000014ce6306004df22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 5:07=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 11/7/23 21:39, Warner Losh wrote:
> > On Tue, Jul 11, 2023 at 8:49=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     Add the generate_pkglist() helper to generate a list of packages
> >     required by a distribution to build QEMU.
> >
> >     Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
> >     JSON, create the files under tests/vm/generated/ sub-directory;
> >     add a README mentioning the files are generated.
> >
> >     Suggested-by: Erik Skultety <eskultet@redhat.com
> >     <mailto:eskultet@redhat.com>>
> >     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org
> >     <mailto:philmd@linaro.org>>
> >
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
> >
> > also, FreeBSD 14 branches next month... do I just grep for FreeBSD-13 t=
o
> > find all the places to update for 14.0?
>
> Per docs/about/build-platforms.rst:
>
>    Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
>    -----------------------------------------
>
>    The project aims to support the most recent major version at all
>    times for up to five years after its initial release. Support
>    for the previous major version will be dropped 2 years after the
>    new major version is released or when the vendor itself drops
>    support, whichever comes first. [...]
>
> We want to be able to test the oldest/newest releases.
>
> Maybe we can add a pair of definitions, so we'd have to only
> change 2 lines in a single place when releases occur?
>

I'd love that. There's two bits of information per release: name and
checksum
of release artifacts.

Warner


>
> >     @@ -191,6 +197,11 @@ try:
> >           generate_cirrus("freebsd-13")
> >           generate_cirrus("macos-12")
> >
> >     +    #
> >     +    # VM packages lists
> >     +    #
> >     +    generate_pkglist("freebsd", "freebsd-13")
>
>

--00000000000014ce6306004df22e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 12, 2023 at 5:07=E2=80=AF=
AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 11/7/23 21:39, Warner Losh wrote:<br>
&gt; On Tue, Jul 11, 2023 at 8:49=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Add the generate_pkglist() helper to generate a lis=
t of packages<br>
&gt;=C2=A0 =C2=A0 =C2=A0required by a distribution to build QEMU.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Since we can not add a &quot;THIS FILE WAS AUTO-GEN=
ERATED&quot; comment in<br>
&gt;=C2=A0 =C2=A0 =C2=A0JSON, create the files under tests/vm/generated/ su=
b-directory;<br>
&gt;=C2=A0 =C2=A0 =C2=A0add a README mentioning the files are generated.<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Suggested-by: Erik Skultety &lt;<a href=3D"mailto:e=
skultet@redhat.com" target=3D"_blank">eskultet@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:eskultet@redhat.com" t=
arget=3D"_blank">eskultet@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=3D"mailto:imp@bsdimp.com"=
 target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;<br>
&gt; <br>
&gt; also, FreeBSD 14 branches next month... do I just grep for FreeBSD-13 =
to <br>
&gt; find all the places to update for 14.0?<br>
<br>
Per docs/about/build-platforms.rst:<br>
<br>
=C2=A0 =C2=A0Linux OS, macOS, FreeBSD, NetBSD, OpenBSD<br>
=C2=A0 =C2=A0-----------------------------------------<br>
<br>
=C2=A0 =C2=A0The project aims to support the most recent major version at a=
ll<br>
=C2=A0 =C2=A0times for up to five years after its initial release. Support<=
br>
=C2=A0 =C2=A0for the previous major version will be dropped 2 years after t=
he<br>
=C2=A0 =C2=A0new major version is released or when the vendor itself drops<=
br>
=C2=A0 =C2=A0support, whichever comes first. [...]<br>
<br>
We want to be able to test the oldest/newest releases.<br>
<br>
Maybe we can add a pair of definitions, so we&#39;d have to only<br>
change 2 lines in a single place when releases occur?<br></blockquote><div>=
<br></div><div>I&#39;d love that. There&#39;s two bits of information per r=
elease: name and checksum</div><div>of release artifacts.</div><div><br></d=
iv><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -191,6 +197,11 @@ try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;freebsd-=
13&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;macos-12=
&quot;)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 #<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 # VM packages lists<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 #<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 generate_pkglist(&quot;freebsd&quot;=
, &quot;freebsd-13&quot;)<br>
<br>
</blockquote></div></div>

--00000000000014ce6306004df22e--

