Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BE79F972
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 06:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdgp-0005a9-VH; Thu, 14 Sep 2023 00:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgdgm-0005Zj-Di
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 00:10:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgdgh-00071P-5k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 00:10:47 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so483295a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694664640; x=1695269440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wwtp2XTDX3TwT7XFP3w19LhrVFw6BRNCHoHJa0Xx26c=;
 b=X1repaDqOrzxOXnHincITXWX1piAZwniFBetAZ156uby3eMYgSG4/HFx4wjVjASEPQ
 76w86ULMd6CU3apKAKa7DXP/Sui4NSCtJr9oE7wJ8Vz8BkRKmYLjH4mJWeQKvrNi8Lyt
 m+c1c7ZmLHSHf40racWr8W4w6rvXeczAJQosQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694664640; x=1695269440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wwtp2XTDX3TwT7XFP3w19LhrVFw6BRNCHoHJa0Xx26c=;
 b=g3WP+SOPFEZzwIS+MZTVCou5WcGu2mRMblXriZvLqLydjwcDXLwTZX2X5EXF2zbMdY
 ci2Q5e477En3Yvqotfyaqvxd8ylCY2mORggsAxsP0ljasLXHEnt2L5kDHEIFSVmL5GY1
 ILZxKw7PRq0Co+xSBwFhZDdJz4iXdVonsAi8wegdSqzVPupbpC6XNit0xwKkq0zxMHSE
 kx1tDi4Yg4xBDEhZVHbqevn+yoqAKz/iFrbSFA2tPQuqp8m5R4oHZ7yxIn9Cvadt24K+
 Artb4EOvxV46Ub491kTA8vVovXhFvEw0Q7r6guu0L2E5Zj2Fx+rn6gNwNaJIU5o+imca
 VVJw==
X-Gm-Message-State: AOJu0YzRink/vBzPVatnI9YZV4+HSkOstfQte8YxjIRwsGLNwrHz9ICE
 YGdLVNSOjzRMqtyN1HzkkHGKqdR/Prk/VMqscLLRow==
X-Google-Smtp-Source: AGHT+IFTzu0F2+9hyFvVNvVpb/shvzvUtizN2jjttVYGT3xdInLyReXBpjua3qSrpkgC4aEoZsUITg==
X-Received: by 2002:aa7:c648:0:b0:523:bfec:4912 with SMTP id
 z8-20020aa7c648000000b00523bfec4912mr3909106edr.11.1694664640368; 
 Wed, 13 Sep 2023 21:10:40 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 g8-20020a50ee08000000b00521d2f7459fsm352715eds.49.2023.09.13.21.10.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 21:10:40 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-52fa364f276so4705a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 21:10:39 -0700 (PDT)
X-Received: by 2002:a50:bb44:0:b0:52f:5697:8dec with SMTP id
 y62-20020a50bb44000000b0052f56978decmr284468ede.4.1694664639462; Wed, 13 Sep
 2023 21:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
 <CAJ+F1CJwATzG8by1tZucq15KbDHfE9OJEGq1jZ71UHivoTRsXQ@mail.gmail.com>
 <CAAfnVBn4yjOCi+OzqjYJ2wos1wsjrCAj+9j1kZ4v63a4LVX7mQ@mail.gmail.com>
 <CAJ+F1CLfJ_0yYh4ZaNwLt5JRB-QfijRZ3DPEEipbUbqV2Sv+=Q@mail.gmail.com>
In-Reply-To: <CAJ+F1CLfJ_0yYh4ZaNwLt5JRB-QfijRZ3DPEEipbUbqV2Sv+=Q@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 13 Sep 2023 21:10:26 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmaFT=ePb8jKcoL=kForNRZk7PrWvrtmvfU6T9-2Sj9SQ@mail.gmail.com>
Message-ID: <CAAfnVBmaFT=ePb8jKcoL=kForNRZk7PrWvrtmvfU6T9-2Sj9SQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000d995f2060549db94"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x532.google.com
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

--000000000000d995f2060549db94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 6:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Wed, Sep 13, 2023 at 5:08=E2=80=AFAM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> > On Tue, Sep 12, 2023 at 6:59=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@gmail.com> wrote:
> >> Packaging aemu and gfxstream is a bit problematic. I have some WIP
> >> Fedora packages.

>>
> >> AEMU:
> >> - installs files under /usr/include/host-common and
> >> /usr/include/snapshot. Can this be moved under /usr/include/aemu
> >> instead?
> >> - builds only static versions of libaemu-host-common.a and
> >> liblogging-base.a (distros don't like static libs much)
> >> - could liblogging-base(.a,.so,..) also have "aemu" name in it?
> >> - libaemu-base.so is not versioned
> >> - I can't find a release tarball, nor the (v0.1.2) release tag
> >> - could have a README file
> >>
> >> I am not very familiar with cmake, so it's not obvious how to make the
> >> required changes. Would you like me to open an issue (where?) or try
> >> to make some patches?
> >
> >
> > I filed an internal bug with all the issues you listed: Android side
> should fix this internally.
> >
> > I see a few options for packaging:
> >
> > 1) Punt on gfxstream/AEMU packaging, just do rutabaga
> >
> > gfxstream is mostly useful for Android guests, and I didn't expect
> anyone to actually package it at this point since most here are intereste=
d
> in Linux guests (where gfxstream VK is headless only right now).  Plus
> ioctl-fowarding > API forwarding for security and performance, so I'm not
> sure if it'll have any sticking power even if everything is supported
> (outside of a few niche use cases).
> >
> > Though, I sense interest in Wayland passthrough for dual Linux use
> cases.  I put up:
> >
> > crrev.com/c/4860836
> >
> > that'll allow packaging on rutabaga_gfx and even CI testing without
> gfxstream, since it is designed to function without it.  We could issue
> another rutabaga-release tag, or you can simply add a patch (a common
> packaging practice) on the Fedora package with the "UPSTEAM label".
> >
> > 2) Actually package gfxstream only
> >
> > Probably an intermediate solution that doesn't introduce
> versioning/static library issues would be just to have a copy of AEMU in
> the gfxstream repo, and link it statically.  Will need another release
> tag/commit of gfxstream.
> >
> > 3) Don't package at all
> >
> > For my particular use case since we have to build QEMU for sources, thi=
s
> is fine.  If upstream breaks virtio-gpu-rutabaga.c, we'll send a patch an=
d
> fix it.  Being in-tree is most important.
> >
> > Let me know what you prefer!
> >
>
> I would rather have standard packaging of the various projects, so we
> can test and develop easily.
>

Ack.  Here are the requested changes:

- https://android-review.googlesource.com/q/topic:%22aemu-package-fix%22
- crrev.com/c/4865171

The main change is:

https://android-review.googlesource.com/c/platform/hardware/google/aemu/+/2=
751066

Once that's okay for packaging, I'll ping harder on v0.1.2 gfxstream/AEMU
release tags.  Let me know if you want another release tag for rutabaga, or
if just patching in upstream changes would be acceptable.

For rutabaga, I ended up having to patch a little bit the shared
> library, to fix SONAME:
>

Landed as crrev.com/c/4863380.


>
> diff --git a/ffi/Makefile b/ffi/Makefile
> index d2f0d38..7efc8f3 100644
> --- a/ffi/Makefile
> +++ b/ffi/Makefile
> @@ -47,13 +47,13 @@ build:
>
>  install: build
>  ifeq ($(UNAME), Linux)
> -    install -D -m 755 -t $(DESTDIR)$(libdir) $(OUT)/$(LIB_NAME)
> +    install -D -m 755 $(OUT)/$(LIB_NAME)
> $(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
>  endif
>  ifeq ($(UNAME), Darwin)
> -        install_name_tool -id $(DESTDIR)$(libdir)/$(LIB_NAME)
> $(DESTDIR)$(libdir)/$(LIB_NAME)
> +        install_name_tool -id
> $(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
> $(DESTDIR)$(libdir)/$(LIB_NAME)
>  endif
> -    ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)
> $(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
> -    ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)
> $(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)
> +    ln -s $(LIB_NAME).$(RUTABAGA_VERSION)
> $(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)
> +    ln -s $(LIB_NAME).$(RUTABAGA_VERSION) $(DESTDIR)$(libdir)/$(LIB_NAME=
)
>  ifeq ($(UNAME), Linux)
>      install -D -m 0644 $(SRC)/share/rutabaga_gfx_ffi.pc
> $(DESTDIR)$(libdir)/pkgconfig/rutabaga_gfx_ffi.pc
>      install -D -m 0644 $(SRC)/include/rutabaga_gfx_ffi.h
> $(DESTDIR)$(includedir)/rutabaga_gfx_ffi.h
> diff --git a/ffi/build.rs b/ffi/build.rs
> new file mode 100644
> index 0000000..efa18d3
> --- /dev/null
> +++ b/ffi/build.rs
> @@ -0,0 +1,3 @@
> +fn main() {
> +
>  println!("cargo:rustc-cdylib-link-arg=3D-Wl,-soname,librutabaga_gfx_ffi.=
so.0");
> +}
>
>
> The package is a bit unconventional, since it's a rust project
> providing a C shared library. I am not sure I did Fedora packaging
> right, let see:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D2238751
>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--000000000000d995f2060549db94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 13, 2023 at 6:49=E2=80=AF=
AM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com"=
>marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi<br>
<br>
On Wed, Sep 13, 2023 at 5:08=E2=80=AFAM Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt; On Tue, Sep 12, 2023 at 6:59=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a =
href=3D"mailto:marcandre.lureau@gmail.com" target=3D"_blank">marcandre.lure=
au@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Packaging aemu and gfxstream is a bit problematic. I have some WIP=
<br>
&gt;&gt; Fedora packages.</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt;&gt;<br>
&gt;&gt; AEMU:<br>
&gt;&gt; - installs files under /usr/include/host-common and<br>
&gt;&gt; /usr/include/snapshot. Can this be moved under /usr/include/aemu<b=
r>
&gt;&gt; instead?<br>
&gt;&gt; - builds only static versions of libaemu-host-common.a and<br>
&gt;&gt; liblogging-base.a (distros don&#39;t like static libs much)<br>
&gt;&gt; - could liblogging-base(.a,.so,..) also have &quot;aemu&quot; name=
 in it?<br>
&gt;&gt; - libaemu-base.so is not versioned<br>
&gt;&gt; - I can&#39;t find a release tarball, nor the (v0.1.2) release tag=
<br>
&gt;&gt; - could have a README file<br>
&gt;&gt;<br>
&gt;&gt; I am not very familiar with cmake, so it&#39;s not obvious how to =
make the<br>
&gt;&gt; required changes. Would you like me to open an issue (where?) or t=
ry<br>
&gt;&gt; to make some patches?<br>
&gt;<br>
&gt;<br>
&gt; I filed an internal bug with all the issues you listed: Android side s=
hould fix this internally.<br>
&gt;<br>
&gt; I see a few options for packaging:<br>
&gt;<br>
&gt; 1) Punt on gfxstream/AEMU packaging, just do rutabaga<br>
&gt;<br>
&gt; gfxstream is mostly useful for Android guests, and I didn&#39;t expect=
 anyone to actually package it at this point since most here are interested=
 in Linux guests (where gfxstream VK is headless only right now).=C2=A0 Plu=
s ioctl-fowarding &gt; API forwarding for security and performance, so I&#3=
9;m not sure if it&#39;ll have any sticking power even if everything is sup=
ported (outside of a few niche use cases).<br>
&gt;<br>
&gt; Though, I sense interest in Wayland passthrough for dual Linux use cas=
es.=C2=A0 I put up:<br>
&gt;<br>
&gt; <a href=3D"http://crrev.com/c/4860836" rel=3D"noreferrer" target=3D"_b=
lank">crrev.com/c/4860836</a><br>
&gt;<br>
&gt; that&#39;ll allow packaging on rutabaga_gfx and even CI testing withou=
t gfxstream, since it is designed to function without it.=C2=A0 We could is=
sue another rutabaga-release tag, or you can simply add a patch (a common p=
ackaging practice) on the Fedora package with the &quot;UPSTEAM label&quot;=
.<br>
&gt;<br>
&gt; 2) Actually package gfxstream only<br>
&gt;<br>
&gt; Probably an intermediate solution that doesn&#39;t introduce versionin=
g/static library issues would be just to have a copy of AEMU in the gfxstre=
am repo, and link it statically.=C2=A0 Will need another release tag/commit=
 of gfxstream.<br>
&gt;<br>
&gt; 3) Don&#39;t package at all<br>
&gt;<br>
&gt; For my particular use case since we have to build QEMU for sources, th=
is is fine.=C2=A0 If upstream breaks virtio-gpu-rutabaga.c, we&#39;ll send =
a patch and fix it.=C2=A0 Being in-tree is most important.<br>
&gt;<br>
&gt; Let me know what you prefer!<br>
&gt;<br>
<br>
I would rather have standard packaging of the various projects, so we<br>
can test and develop easily.<br></blockquote><div><br></div><div><div>Ack.=
=C2=A0 Here are the requested changes:</div><div><br></div><div>- <a href=
=3D"https://android-review.googlesource.com/q/topic:%22aemu-package-fix%22"=
>https://android-review.googlesource.com/q/topic:%22aemu-package-fix%22</a>=
<br></div><div>- <a href=3D"http://crrev.com/c/4865171">crrev.com/c/4865171=
</a></div><div><br></div><div>The main change is:</div><div><br></div><div>=
<a href=3D"https://android-review.googlesource.com/c/platform/hardware/goog=
le/aemu/+/2751066">https://android-review.googlesource.com/c/platform/hardw=
are/google/aemu/+/2751066</a><br></div><div><br></div><div>Once that&#39;s =
okay for packaging, I&#39;ll ping harder on v0.1.2 gfxstream/AEMU release t=
ags.=C2=A0 Let me know if you want another release tag for rutabaga, or if =
just patching in upstream changes would be acceptable.</div></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
For rutabaga, I ended up having to patch a little bit the shared<br>
library, to fix SONAME:<br></blockquote><div><br></div><div>Landed as <a hr=
ef=3D"http://crrev.com/c/4863380">crrev.com/c/4863380</a>.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/ffi/Makefile b/ffi/Makefile<br>
index d2f0d38..7efc8f3 100644<br>
--- a/ffi/Makefile<br>
+++ b/ffi/Makefile<br>
@@ -47,13 +47,13 @@ build:<br>
<br>
=C2=A0install: build<br>
=C2=A0ifeq ($(UNAME), Linux)<br>
-=C2=A0 =C2=A0 install -D -m 755 -t $(DESTDIR)$(libdir) $(OUT)/$(LIB_NAME)<=
br>
+=C2=A0 =C2=A0 install -D -m 755 $(OUT)/$(LIB_NAME)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)<br>
=C2=A0endif<br>
=C2=A0ifeq ($(UNAME), Darwin)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 install_name_tool -id $(DESTDIR)$(libdir)/$(LI=
B_NAME)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 install_name_tool -id<br>
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME)<br>
=C2=A0endif<br>
-=C2=A0 =C2=A0 ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)<br>
-=C2=A0 =C2=A0 ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)<br>
+=C2=A0 =C2=A0 ln -s $(LIB_NAME).$(RUTABAGA_VERSION)<br>
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)<br>
+=C2=A0 =C2=A0 ln -s $(LIB_NAME).$(RUTABAGA_VERSION) $(DESTDIR)$(libdir)/$(=
LIB_NAME)<br>
=C2=A0ifeq ($(UNAME), Linux)<br>
=C2=A0 =C2=A0 =C2=A0install -D -m 0644 $(SRC)/share/rutabaga_gfx_ffi.pc<br>
$(DESTDIR)$(libdir)/pkgconfig/rutabaga_gfx_ffi.pc<br>
=C2=A0 =C2=A0 =C2=A0install -D -m 0644 $(SRC)/include/rutabaga_gfx_ffi.h<br=
>
$(DESTDIR)$(includedir)/rutabaga_gfx_ffi.h<br>
diff --git a/ffi/<a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_=
blank">build.rs</a> b/ffi/<a href=3D"http://build.rs" rel=3D"noreferrer" ta=
rget=3D"_blank">build.rs</a><br>
new file mode 100644<br>
index 0000000..efa18d3<br>
--- /dev/null<br>
+++ b/ffi/<a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_blank">=
build.rs</a><br>
@@ -0,0 +1,3 @@<br>
+fn main() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0println!(&quot;cargo:rustc-cdylib-link-arg=3D-W=
l,-soname,librutabaga_gfx_ffi.so.0&quot;);<br>
+}<br>
<br>
<br>
The package is a bit unconventional, since it&#39;s a rust project<br>
providing a C shared library. I am not sure I did Fedora packaging<br>
right, let see:<br>
<a href=3D"https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D2238751" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/bugzilla/s=
how_bug.cgi?id=3D2238751</a><br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div></div>

--000000000000d995f2060549db94--

