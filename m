Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF187EB13D
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:56:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tsn-0007EH-2J; Tue, 14 Nov 2023 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r2tsk-0007Dv-Sj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r2tsj-0007It-0E
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pEWpGHSQtKWBVz7PIywzxsr1eVGBS+0wKF0pHCj3SH4=;
 b=c2xLxDyTNU52hOT0yGoywYOFTXL6CqlaYbVrjRUSBl1ujmCoEny8iAG0+OD/18Rb1ArAaF
 XU3VF4v2R/gbZJcaD9WdwPw1KGEYIFCXYCzfTdAe57Nru4uuE7s5q92GNtfGpNUzSRLvYc
 iYTPYVY3gnwxBSD1IoH+wcCqb05KgYw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-egdrzv-JN4Onkn25d2m7WA-1; Tue, 14 Nov 2023 08:55:05 -0500
X-MC-Unique: egdrzv-JN4Onkn25d2m7WA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-45fb975f9aaso849629137.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970105; x=1700574905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEWpGHSQtKWBVz7PIywzxsr1eVGBS+0wKF0pHCj3SH4=;
 b=qTZo0FnUnzDPXfK63FsdlgmKKjApxR0mfbnmgyIHxtB57bpqgYhGEZniF/fWIDwN+z
 8QeXxOTK/fkI+WCXPnO5wUSjQoJ0E1C8kRTusqak9AGYMVY5zbn9PN/rCnZ1JDhH3GFo
 oLf0An2OEX74oQmBWMfxwR03Pwxiaw8SC4CABmZ1i9WkHsCjphtnYyPwNc8M6WHjdTxi
 0qyZl9AlXzpKw9msf/c4vmXcB6Yi5+JDdimFoykkNNsp+F4zRDNF/HVV2kwmWgUVbfKa
 JDCdFCFc1jA/bPFVRq+JS6j+q7f+rTV26U7EkP+WkWxKMAW3xINMXx4T9uxk1PJhPbJu
 rUhA==
X-Gm-Message-State: AOJu0Yx/SbUBks5LBnBteIdtOajJIHyk/wmOVOfAOgOYuan6RlLBl/FY
 JqrTkH5BXr9kgxHcex9qzrDKyc1xdHU4Egpg9oy4YXen3YPA26tYbfNc5QtK4UAB9l7TuESmlcJ
 AImHzZ/b7rQnrwR+KFq1NRFgWt/e0CG4fKBYV7Fw=
X-Received: by 2002:a67:f901:0:b0:45f:c608:9534 with SMTP id
 t1-20020a67f901000000b0045fc6089534mr5189106vsq.21.1699970104127; 
 Tue, 14 Nov 2023 05:55:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESNFzQ96+Fn3WDhXSp0RiyqC3zu7G6HR2m9EaJFYyv6FrD4QN/a2PAaGFOBtmmGLfMTAVS2doclNIDpeJvcKU=
X-Received: by 2002:a67:f901:0:b0:45f:c608:9534 with SMTP id
 t1-20020a67f901000000b0045fc6089534mr5189075vsq.21.1699970103739; Tue, 14 Nov
 2023 05:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20231111152923.966998-1-pbonzini@redhat.com>
 <CAJSP0QX52-a4ECrAm=+5ho3W-Eo7o8vfx5T0JX+h+j_9HDVRRw@mail.gmail.com>
In-Reply-To: <CAJSP0QX52-a4ECrAm=+5ho3W-Eo7o8vfx5T0JX+h+j_9HDVRRw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Nov 2023 08:54:50 -0500
Message-ID: <CABgObfaTH7Xa5R4atJz1AEsPH1Q2ekLveaxgYjXQ7Z9VtrWGsw@mail.gmail.com>
Subject: Re: [PULL 0/6] Biuld system and CI changes for 2023-11-10
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000029970d060a1d222e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000029970d060a1d222e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 12 nov 2023, 13:06 Stefan Hajnoczi <stefanha@gmail.com> ha scritto:

> On Sat, 11 Nov 2023 at 23:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> ad6ef0a42e314a8c6ac6c96d5f6e607a1e5644b5:
> >
> >   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into
> staging (2023-11-09 08:26:01 +0800)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 1d802d050caeff83add1054bee1fc9f98e59a3f2=
:
> >
> >   .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)
> (2023-11-10 10:39:05 +0100)
> >
> > ----------------------------------------------------------------
> > * document what configure does with virtual environments
> > * Bump known good meson version to v1.2.3
> > * Upgrade macOS to 13 (Ventura) and Add manual testing of macOS 14
> (Sonoma)
> > * use simple assertions instead of Coverity models
>
> I'm not sure which commit causes this, but there is an msys failure:
>
> Here is the failing output with this PR applied:
> https://gitlab.com/qemu-project/qemu/-/jobs/5516759417
>
> Here is the master branch's passing output:
> https://gitlab.com/qemu-project/qemu/-/jobs/5513282154
>
> Please take a look. Thanks!
>

Looks like the series causes issue #1972 to appear more prominently. I will
resubmit once it's fixed (a patch is already available).

Paolo


> Stefan
>
> >
> > ----------------------------------------------------------------
> > Paolo Bonzini (2):
> >       tests: respect --enable/--disable-download for Avocado
> >       docs: document what configure does with virtual environments
> >
> > Philippe Mathieu-Daud=C3=A9 (3):
> >       buildsys: Bump known good meson version to v1.2.3
> >       .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
> >       .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)
> >
> > Vladimir Sementsov-Ogievskiy (1):
> >       coverity: physmem: use simple assertions instead of modelling
> >
> >  .gitlab-ci.d/cirrus.yml                            |  22 +++++-
> >  .../cirrus/{macos-12.vars =3D> macos-13.vars}        |   2 +-
> >  .gitlab-ci.d/cirrus/macos-14.vars                  |  16 ++++
> >  configure                                          |   9 ++-
> >  docs/devel/build-system.rst                        |  88
> ++++++++++++++++++++-
> >  python/scripts/vendor.py                           |   4 +-
> >  python/wheels/meson-0.63.3-py3-none-any.whl        | Bin 926526 -> 0
> bytes
> >  python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 0 -> 964928
> bytes
> >  pythondeps.toml                                    |   5 +-
> >  scripts/coverity-scan/model.c                      |  88
> ---------------------
> >  system/physmem.c                                   |  22 ++++++
> >  tests/Makefile.include                             |   2 +-
> >  tests/lcitool/libvirt-ci                           |   2 +-
> >  tests/lcitool/refresh                              |   3 +-
> >  14 files changed, 157 insertions(+), 106 deletions(-)
> >  rename .gitlab-ci.d/cirrus/{macos-12.vars =3D> macos-13.vars} (95%)
> >  create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
> >  delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
> >  create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
> > --
> > 2.41.0
> >
> >
>
>

--00000000000029970d060a1d222e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 12 nov 2023, 13:06 Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Sat, 11 Nov 2023 at 23:30, Paolo Bonz=
ini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"nor=
eferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit ad6ef0a42e314a8c6ac6c96d5f6e607a1e5=
644b5:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge tag &#39;for-upstream&#39; of <a href=3D"https://rep=
o.or.cz/qemu/kevin" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/repo.or.cz/qemu/kevin</a> into staging (2023-11-09 08:26:01 +0800)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git</=
a> tags/for-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to 1d802d050caeff83add1054bee1fc9f98e59a3f=
2:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0.gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonom=
a) (2023-11-10 10:39:05 +0100)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; * document what configure does with virtual environments<br>
&gt; * Bump known good meson version to v1.2.3<br>
&gt; * Upgrade macOS to 13 (Ventura) and Add manual testing of macOS 14 (So=
noma)<br>
&gt; * use simple assertions instead of Coverity models<br>
<br>
I&#39;m not sure which commit causes this, but there is an msys failure:<br=
>
<br>Here is the failing output with this PR applied:<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/5516759417" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/jobs/5516759417</a><br>
<br>
Here is the master branch&#39;s passing output:<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/5513282154" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/jobs/5513282154</a><br>
<br>
Please take a look. Thanks!<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Looks like the series causes issue #1972 to appe=
ar more prominently. I will resubmit once it&#39;s fixed (a patch is alread=
y available).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Stefan<br>
<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Paolo Bonzini (2):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests: respect --enable/--disable-download f=
or Avocado<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0docs: document what configure does with virt=
ual environments<br>
&gt;<br>
&gt; Philippe Mathieu-Daud=C3=A9 (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buildsys: Bump known good meson version to v=
1.2.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ve=
ntura)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.gitlab-ci.d/cirrus: Add manual testing of m=
acOS 14 (Sonoma)<br>
&gt;<br>
&gt; Vladimir Sementsov-Ogievskiy (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0coverity: physmem: use simple assertions ins=
tead of modelling<br>
&gt;<br>
&gt;=C2=A0 .gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 +++++-<=
br>
&gt;=C2=A0 .../cirrus/{macos-12.vars =3D&gt; macos-13.vars}=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 .gitlab-ci.d/cirrus/macos-14.vars=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 ++++<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 ++-<br>
&gt;=C2=A0 docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 88 +++++++++++++++=
+++++-<br>
&gt;=C2=A0 python/scripts/vendor.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 =
+-<br>
&gt;=C2=A0 python/wheels/meson-0.63.3-py3-none-any.whl=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | Bin 926526 -&gt; 0 bytes<br>
&gt;=C2=A0 python/wheels/meson-1.2.3-py3-none-any.whl=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| Bin 0 -&gt; 964928 bytes<br>
&gt;=C2=A0 pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 scripts/coverity-scan/model.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 88 ---------------------<=
br>
&gt;=C2=A0 system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 22 ++++++<br>
&gt;=C2=A0 tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 tests/lcitool/libvirt-ci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
&gt;=C2=A0 tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 14 files changed, 157 insertions(+), 106 deletions(-)<br>
&gt;=C2=A0 rename .gitlab-ci.d/cirrus/{macos-12.vars =3D&gt; macos-13.vars}=
 (95%)<br>
&gt;=C2=A0 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars<br>
&gt;=C2=A0 delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl<b=
r>
&gt;=C2=A0 create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl<br=
>
&gt; --<br>
&gt; 2.41.0<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000029970d060a1d222e--


