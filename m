Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0579DD62
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgEMj-0001sA-1c; Tue, 12 Sep 2023 21:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgEMf-0001rv-3c
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 21:08:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgEMb-00085V-Vw
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 21:08:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31dcf18f9e2so6306644f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694567294; x=1695172094; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJXrFQL4nakuOoSR0sbWPZflkPV1jc/tdLghAUTYTTg=;
 b=esBTtCCOjq8nrpKZyFtB2J7iXPU9FkHMIAR3CysZ76ZvIsuz2kMxQ6B1yhfd7tzE4b
 l+0ofKCSbFODqZYVCeG/Zfm+RW814iamQmQWW00oRGsg4JhYsxhAE5oxOkJ7h0kLPJBr
 SFaZnrznau+4qLzpLDTP2EOBqopGvvQqux8Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694567294; x=1695172094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJXrFQL4nakuOoSR0sbWPZflkPV1jc/tdLghAUTYTTg=;
 b=ZZbUwkCAJKywA6DljQG0Z50r1H3b2Wf5M4LeGuEPuRiM2+ANNObgQXcz0E565lLBC0
 xVrq5ivBV7gr1bpUeT/jDiVcAwgC5vYXUGBqXgKgcG5trSxrsH/wC+pG2fbQ27XfbSJ4
 n7tO4PZ8LUZbW3WUK1UTVREbDMuopE27rrCrx4JymWdVKZXTJR+ej6EinSyT7TATCWiI
 8NMbQRQoqW/yFnW+1pztz9Ro76Cqi9Gr5Orh3fZLE6VQsgRO2Q490dpvmWGtHW6dlIlD
 +Ie4hOea5Bb+TQkUc15TxXlarao6XUfDid+x33BHCDNzKr3PExknDBzxKqp4GlAE+5dY
 1ODg==
X-Gm-Message-State: AOJu0YxQGuBrtg2jynIM111Eo4evF9xBmUO33YMFufRf7Ms8Hupe7VCa
 IxYNP7rPIdXMRl1UrTAjWOs+j6bmlGBsvHNA9QxQ7A==
X-Google-Smtp-Source: AGHT+IHoxId2NrW5E1JAmI/9Vo48tISyvMmyJZFFOOnUkrTZxQP1mAxoVCpqVAeX8o92LMuf5x6g+w==
X-Received: by 2002:a5d:5149:0:b0:317:6310:a616 with SMTP id
 u9-20020a5d5149000000b003176310a616mr802525wrt.36.1694567294666; 
 Tue, 12 Sep 2023 18:08:14 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 r12-20020a056402034c00b00522572f323dsm6570270edw.16.2023.09.12.18.08.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 18:08:14 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so7279a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 18:08:14 -0700 (PDT)
X-Received: by 2002:a50:d79a:0:b0:52e:f99a:b5f8 with SMTP id
 w26-20020a50d79a000000b0052ef99ab5f8mr34068edi.7.1694567293813; Tue, 12 Sep
 2023 18:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
 <CAJ+F1CJwATzG8by1tZucq15KbDHfE9OJEGq1jZ71UHivoTRsXQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJwATzG8by1tZucq15KbDHfE9OJEGq1jZ71UHivoTRsXQ@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 12 Sep 2023 18:08:00 -0700
X-Gmail-Original-Message-ID: <CAAfnVBn4yjOCi+OzqjYJ2wos1wsjrCAj+9j1kZ4v63a4LVX7mQ@mail.gmail.com>
Message-ID: <CAAfnVBn4yjOCi+OzqjYJ2wos1wsjrCAj+9j1kZ4v63a4LVX7mQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Huang Rui <ray.huang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, 
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000099131606053331ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000099131606053331ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 6:59=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi Gurchetan
>
> On Wed, Sep 6, 2023 at 5:22=E2=80=AFAM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> >
> >
> >
> > On Wed, Aug 30, 2023 at 7:26=E2=80=AFPM Huang Rui <ray.huang@amd.com> w=
rote:
> >>
> >> On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:
> >> > From: Gurchetan Singh <gurchetansingh@google.com>
> >> >
> >> > Changes since v12:
> >> > - Added r-b tags from Antonio Caggiano and Akihiko Odaki
> >> > - Removed review version from commit messages
> >> > - I think we're good to merge since we've had multiple people test
> and review this series??
> >> >
> >> > How to build both rutabaga and gfxstream guest/host libs:
> >> >
> >> > https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >> >
> >> > Branch containing this patch series:
> >> >
> >> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13
> >> >
> >> > Antonio Caggiano (2):
> >> >   virtio-gpu: CONTEXT_INIT feature
> >> >   virtio-gpu: blob prep
> >> >
> >> > Dr. David Alan Gilbert (1):
> >> >   virtio: Add shared memory capability
> >> >
> >> > Gerd Hoffmann (1):
> >> >   virtio-gpu: hostmem
> >>
> >> Patch 1 -> 4 are
> >>
> >> Acked-and-Tested-by: Huang Rui <ray.huang@amd.com>
> >
> >
> > Thanks Ray, I've rebased
> https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13 and
> added the additional acks in the commit message.
> >
> > UI/gfx maintainers, since everything is reviewed and there hasn't been
> any additional review comments, may we merge the gfxstream + rutabaga_gfx
> series?  Thank you!
> >
> >
>
> Packaging aemu and gfxstream is a bit problematic. I have some WIP
> Fedora packages.
>
> AEMU:
> - installs files under /usr/include/host-common and
> /usr/include/snapshot. Can this be moved under /usr/include/aemu
> instead?
> - builds only static versions of libaemu-host-common.a and
> liblogging-base.a (distros don't like static libs much)
> - could liblogging-base(.a,.so,..) also have "aemu" name in it?
> - libaemu-base.so is not versioned
> - I can't find a release tarball, nor the (v0.1.2) release tag
> - could have a README file
>
> I am not very familiar with cmake, so it's not obvious how to make the
> required changes. Would you like me to open an issue (where?) or try
> to make some patches?
>

I filed an internal bug with all the issues you listed: Android side should
fix this internally.

I see a few options for packaging:

1) Punt on gfxstream/AEMU packaging, just do rutabaga

gfxstream is mostly useful for Android guests, and I didn't expect anyone
to actually package it at this point since most here are interested in
Linux guests (where gfxstream VK is headless only right now).  Plus
ioctl-fowarding > API forwarding for security and performance, so I'm not
sure if it'll have any sticking power even if everything is supported
(outside of a few niche use cases).

Though, I sense interest in Wayland passthrough for dual Linux use cases.
I put up:

crrev.com/c/4860836 <http://crrev.com/c4860836>

that'll allow packaging on rutabaga_gfx and even CI testing without
gfxstream, since it is designed to function without it.  We could issue
another rutabaga-release tag, or you can simply add a patch (a common
packaging practice) on the Fedora package with the "UPSTEAM label".

2) Actually package gfxstream only

Probably an intermediate solution that doesn't introduce versioning/static
library issues would be just to have a copy of AEMU in the gfxstream repo,
and link it statically.  Will need another release tag/commit of
gfxstream.

3) Don't package at all

For my particular use case since we have to build QEMU for sources, this is
fine.  If upstream breaks virtio-gpu-rutabaga.c, we'll send a patch and fix
it.  Being in-tree is most important.

Let me know what you prefer!


>
> gfxstream:
> - libgfxtream_backend.so is not versioned
> - I can't find a release tarball, nor the (v0.1.2) release tag
>


https://android-review.googlesource.com/c/platform/hardware/google/gfxstrea=
m/+/2749095


>
>
> (packaging is important so we can build the new code in CI too!)
>
> thanks
>
> --
> Marc-Andr=C3=A9 Lureau
>

--00000000000099131606053331ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 12, 2023 at 6:59=E2=80=AF=
AM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com"=
 target=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi Gurchetan<br>
<br>
On Wed, Sep 6, 2023 at 5:22=E2=80=AFAM Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Aug 30, 2023 at 7:26=E2=80=AFPM Huang Rui &lt;<a href=3D"mailt=
o:ray.huang@amd.com" target=3D"_blank">ray.huang@amd.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:<b=
r>
&gt;&gt; &gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@go=
ogle.com" target=3D"_blank">gurchetansingh@google.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Changes since v12:<br>
&gt;&gt; &gt; - Added r-b tags from Antonio Caggiano and Akihiko Odaki<br>
&gt;&gt; &gt; - Removed review version from commit messages<br>
&gt;&gt; &gt; - I think we&#39;re good to merge since we&#39;ve had multipl=
e people test and review this series??<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; How to build both rutabaga and gfxstream guest/host libs:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html=
" rel=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/appendix/rut=
abaga_gfx.html</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Branch containing this patch series:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://gitlab.com/gurchetansingh/qemu/-/commits/q=
emu-gfxstream-v13" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/=
gurchetansingh/qemu/-/commits/qemu-gfxstream-v13</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Antonio Caggiano (2):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0virtio-gpu: CONTEXT_INIT feature<br>
&gt;&gt; &gt;=C2=A0 =C2=A0virtio-gpu: blob prep<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Dr. David Alan Gilbert (1):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0virtio: Add shared memory capability<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Gerd Hoffmann (1):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0virtio-gpu: hostmem<br>
&gt;&gt;<br>
&gt;&gt; Patch 1 -&gt; 4 are<br>
&gt;&gt;<br>
&gt;&gt; Acked-and-Tested-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd=
.com" target=3D"_blank">ray.huang@amd.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks Ray, I&#39;ve rebased <a href=3D"https://gitlab.com/gurchetansi=
ngh/qemu/-/commits/qemu-gfxstream-v13" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13</a> an=
d added the additional acks in the commit message.<br>
&gt;<br>
&gt; UI/gfx maintainers, since everything is reviewed and there hasn&#39;t =
been any additional review comments, may we merge the gfxstream + rutabaga_=
gfx series?=C2=A0 Thank you!<br>
&gt;<br>
&gt;<br>
<br>
Packaging aemu and gfxstream is a bit problematic. I have some WIP<br>
Fedora packages.<br>
<br>
AEMU:<br>
- installs files under /usr/include/host-common and<br>
/usr/include/snapshot. Can this be moved under /usr/include/aemu<br>
instead?<br>
- builds only static versions of libaemu-host-common.a and<br>
liblogging-base.a (distros don&#39;t like static libs much)<br>
- could liblogging-base(.a,.so,..) also have &quot;aemu&quot; name in it?<b=
r>
- libaemu-base.so is not versioned<br>
- I can&#39;t find a release tarball, nor the (v0.1.2) release tag<br>
- could have a README file<br>
<br>
I am not very familiar with cmake, so it&#39;s not obvious how to make the<=
br>
required changes. Would you like me to open an issue (where?) or try<br>
to make some patches?<br></blockquote><div><br></div><div>I filed an intern=
al bug with all the issues you listed: Android side should fix this interna=
lly.</div><div><br></div><div>I see a few options for packaging:</div><div>=
<br></div><div>1) Punt on gfxstream/AEMU packaging, just do rutabaga</div><=
div><br></div><div>gfxstream is mostly useful for Android guests, and I did=
n&#39;t expect anyone to actually package it at this point since most here =
are interested in Linux guests (where gfxstream VK is headless only right n=
ow).=C2=A0 Plus ioctl-fowarding &gt; API forwarding=C2=A0for security and p=
erformance, so I&#39;m not sure if it&#39;ll have any sticking power even i=
f everything is supported (outside of a few niche use cases).=C2=A0 =C2=A0<=
/div><div><br></div><div>Though, I sense interest in Wayland passthrough fo=
r dual Linux use cases.=C2=A0 I put up:</div><div><br></div><div><a href=3D=
"http://crrev.com/c4860836" target=3D"_blank">crrev.com/c/4860836</a></div>=
<div><br></div><div>that&#39;ll allow packaging on rutabaga_gfx and even CI=
 testing without gfxstream, since it is designed to function without it.=C2=
=A0 We could issue another rutabaga-release tag, or you can simply add a pa=
tch (a common packaging practice) on the Fedora package with the &quot;UPST=
EAM label&quot;.</div><div><br></div><div>2) Actually package gfxstream onl=
y</div><div><br></div><div>Probably an intermediate solution that doesn&#39=
;t introduce=C2=A0versioning/static library issues would be just to have a =
copy of AEMU in the gfxstream repo, and link it statically.=C2=A0 Will need=
 another release tag/commit of gfxstream.=C2=A0=C2=A0</div><div><br></div><=
div>3) Don&#39;t package at all=C2=A0</div><div><br></div><div>For my parti=
cular use case since we have to build QEMU for sources, this is fine.=C2=A0=
 If upstream breaks virtio-gpu-rutabaga.c, we&#39;ll send a patch and fix i=
t.=C2=A0 Being in-tree is most important.=C2=A0=C2=A0</div><div><br></div><=
div>Let me know what you prefer!=C2=A0=C2=A0</div><div>=C2=A0<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
gfxstream:<br>
- libgfxtream_backend.so is not versioned<br>
- I can&#39;t find a release tarball, nor the (v0.1.2) release tag<br></blo=
ckquote><div><br></div><div><br></div><div><a href=3D"https://android-revie=
w.googlesource.com/c/platform/hardware/google/gfxstream/+/2749095">https://=
android-review.googlesource.com/c/platform/hardware/google/gfxstream/+/2749=
095</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
<br>
(packaging is important so we can build the new code in CI too!)<br>
<br>
thanks<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div></div>

--00000000000099131606053331ac--

