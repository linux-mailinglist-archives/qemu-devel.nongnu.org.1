Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ADC788F2D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZc89-0002mX-7R; Fri, 25 Aug 2023 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZc84-0002kg-3K
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:05:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZc81-0004tA-5l
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:05:55 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so154364166b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692990351; x=1693595151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WmQKvPomDCzJDdg0vtHTiK6TLnmc87ITLv4zW8xwXSQ=;
 b=KRv7bExBydHYpzMtS36+irEuJKy1HxQwn/jyGQ/an6XsQ0s/dp2yInhurlkml4ANwW
 jlkF1Sv0ndWjZiENb1hGCQk2ROBtZ5oODJeT6ApOaCJLeeOuhmWWZ8BSBB5oczmft90P
 iI3AmRfISKbEXryAnqac5e5EqoUaYLxAdmD6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692990351; x=1693595151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WmQKvPomDCzJDdg0vtHTiK6TLnmc87ITLv4zW8xwXSQ=;
 b=PKj4EbKIR3sMHJmbKcDjOglPySPV2c9S2cTCZvBm3XuxPIa5NJlQG7Gmn6DumMER3c
 1ZZjIWUw47PMbZw1o8WZ1RNFoOucnrg4nrHwGc7kOmYk/kgC9vdWpma+eNPIuLxF7k8G
 5VS/NlspDw9CquG+pP6APwmtaXtslmPBikxNRY01U7YXsxmeiYjHQLxdFagdzm4Ct5E5
 MHIJ8gglyrgExJKcO39yyeMOhgD/k9Tiy9rApg1VJYb+f5UJTSgfSRO2BMWpaWpUq+eu
 quhRQOcbpTr3m0PeC7Fcpl9gQEU9pGEO5jOL1nG0YPg9xj4SFBC0qTaCdCkCMR0W5OVw
 OT3w==
X-Gm-Message-State: AOJu0YxOJlP6wvOk2bbNUTeCJ6vvjYvsC9T5Cjj4okOfTrbi97aBbSUT
 2Xubcm9Qvc1rZyyyPDZSJaX0DzDfsOgikFcfX5FgJQ==
X-Google-Smtp-Source: AGHT+IGCl9h2yBf1f+LnEY8gJcbADKtjB1DEnejymFXYqlSpeJOIPIzgkkYPFwiX5rqy5v8MT+u1DQ==
X-Received: by 2002:a17:906:aadb:b0:99d:fc31:242f with SMTP id
 kt27-20020a170906aadb00b0099dfc31242fmr15073700ejb.66.1692990350667; 
 Fri, 25 Aug 2023 12:05:50 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 f24-20020a1709067f9800b00977eec7b7e8sm1244080ejr.68.2023.08.25.12.05.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 12:05:50 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-5232ce75e26so2152a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:05:50 -0700 (PDT)
X-Received: by 2002:a50:9b16:0:b0:519:7d2:e256 with SMTP id
 o22-20020a509b16000000b0051907d2e256mr44703edi.0.1692990349773; Fri, 25 Aug
 2023 12:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
In-Reply-To: <871qfriok0.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 25 Aug 2023 12:05:37 -0700
X-Gmail-Original-Message-ID: <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
Message-ID: <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="00000000000068e8cc0603c408ad"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x634.google.com
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

--00000000000068e8cc0603c408ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrot=
e:
> >
> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >>
> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
> >> >
> >> > - The release commits can make packaging easier, though once
> >> >   again all known users will likely just build from sources
> >> >   anyways
> >>
> >> It's a small thing, but could there be actual tags, rather than just
> >> blessed commits?  It'd just make them easier to find, and save a bit o=
f
> >> time in review for packages.
> >>
> >
> > I added:
> >
> >
> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-po=
tential-packaging
> >
> > Tags are possible, but I want to clarify the use case before packaging.
> > Where are you thinking of packaging it for (Debian??)? Are you mostly
> > interested in Wayland passthrough (my guess) or gfxstream too?  Dependi=
ng
> > your use case, we may be able to minimize the work involved.
>
> Packaging for Nixpkgs (where I already maintain what to my knowledge is
> the only crosvm distro package).  I'm personally mostly interested in
> Wayland passthroug, but I wouldn't be surprised if others are interested
> in gfxstream.  The packaging work is already done, I've just been
> holding off actually pushing the packages waiting for the stable
> releases.
>
> The reason that tags would be useful is that it allows a reviewer of the
> package to see at a glance that the package is built from a stable
> release.  If it's just built from a commit hash, they have to go and
> verify that it's a stable release, which is mildly annoying and
> unconventional.
>

Understood.  Request to have gfxstream and AEMU v0.1.2 release tags made.

For rutabaga_gfx_ffi, is the crates.io upload sufficient?

https://crates.io/crates/rutabaga_gfx_ffi

Debian, for example, treats crates.io as the source of truth and builds
tooling around that.  I wonder if Nixpkgs as similar tooling around
crates.io.

--00000000000068e8cc0603c408ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 25, 2023 at 12:11=E2=80=
=AFAM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Gurchetan=
 Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank"=
>gurchetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross &lt;<a href=3D"mai=
lto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org"=
 target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; - Official &quot;release commits&quot; issued for rutabaga_gf=
x_ffi,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0gfxstream, aemu-base.=C2=A0 For example, see <a h=
ref=3D"http://crrev.com/c/4778941" rel=3D"noreferrer" target=3D"_blank">crr=
ev.com/c/4778941</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - The release commits can make packaging easier, though once<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0again all known users will likely just build from=
 sources<br>
&gt;&gt; &gt;=C2=A0 =C2=A0anyways<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s a small thing, but could there be actual tags, rather tha=
n just<br>
&gt;&gt; blessed commits?=C2=A0 It&#39;d just make them easier to find, and=
 save a bit of<br>
&gt;&gt; time in review for packages.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I added:<br>
&gt;<br>
&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-r=
eleases-for-potential-packaging" rel=3D"noreferrer" target=3D"_blank">https=
://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-potential=
-packaging</a><br>
&gt;<br>
&gt; Tags are possible, but I want to clarify the use case before packaging=
.<br>
&gt; Where are you thinking of packaging it for (Debian??)? Are you mostly<=
br>
&gt; interested in Wayland passthrough (my guess) or gfxstream too?=C2=A0 D=
epending<br>
&gt; your use case, we may be able to minimize the work involved.<br>
<br>
Packaging for Nixpkgs (where I already maintain what to my knowledge is<br>
the only crosvm distro package).=C2=A0 I&#39;m personally mostly interested=
 in<br>
Wayland passthroug, but I wouldn&#39;t be surprised if others are intereste=
d<br>
in gfxstream.=C2=A0 The packaging work is already done, I&#39;ve just been<=
br>
holding off actually pushing the packages waiting for the stable<br>
releases.<br>
<br>
The reason that tags would be useful is that it allows a reviewer of the<br=
>
package to see at a glance that the package is built from a stable<br>
release.=C2=A0 If it&#39;s just built from a commit hash, they have to go a=
nd<br>
verify that it&#39;s a stable release, which is mildly annoying and<br>
unconventional.<br></blockquote><div><br></div><div>Understood.=C2=A0 Reque=
st to have gfxstream and AEMU v0.1.2 release tags made.</div><div><br></div=
><div>For rutabaga_gfx_ffi, is the <a href=3D"http://crates.io">crates.io</=
a> upload sufficient?</div><div><br></div><div><a href=3D"https://crates.io=
/crates/rutabaga_gfx_ffi">https://crates.io/crates/rutabaga_gfx_ffi</a><br>=
</div><div><br></div><div>Debian, for example, treats <a href=3D"http://cra=
tes.io">crates.io</a> as the source of truth and builds tooling around that=
.=C2=A0 I wonder if Nixpkgs as similar tooling around=C2=A0<a href=3D"http:=
//crates.io">crates.io</a>.</div><div>=C2=A0</div></div></div>

--00000000000068e8cc0603c408ad--

