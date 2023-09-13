Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0779DD72
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgESV-0002yr-Rj; Tue, 12 Sep 2023 21:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgEST-0002yh-5n
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 21:14:21 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qgESP-0000gS-Vu
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 21:14:20 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-986d8332f50so833439766b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694567655; x=1695172455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/IIV1ob7ZSR6C68gvOUiRoxNChciRn6kpHTaaHp8+wg=;
 b=kHrD5nfQoMUN2W4xhLNE3VemqSJHawFCUlbhVqVVq13NaCIXBjaQuAxrw+SBDBxLhH
 gayAtXGKAbPxVkIs9LUmV80nNFn5EabpFe3rTuEAv3isoqzMERygmUJXzLErDN1wRgCk
 gG8NBsZL7Abj0vTuqsPsOGp8SAh/bfeOJki9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694567655; x=1695172455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IIV1ob7ZSR6C68gvOUiRoxNChciRn6kpHTaaHp8+wg=;
 b=Ej3j31mm0UMOss/3XWIofOhkTMJfcL+3eoM8zd6EqoKyKEy0jhVhQzreMreYxxul4L
 BQzXhVtOk8vCfYZy7/AX22p9mNQ8U++SqlXJEfnI4cBSnxspLBXc0/adNd6SuIHcdDBr
 skRO3yFiF3161oadmLIwIHfDP5fp4VS+RFKbLVcweVJXGxXG+BWZ2MtzldaW7xrGGBew
 X9JR5nlk653+BiSUr1ZF4Zxv4QvrfxZl/n2TA3lqMDHwCPGz6q4YiyT7asowfHW277Fw
 oMUU6UcCwllhkdCK9CVmN2qrw/RiqmsUEtdtNwstbbdjmVHr9G3F4LZH1K3qWy1Wh1cc
 v7zw==
X-Gm-Message-State: AOJu0Yz4YGAuN5QxX8pNJhCmU8eYH5xlmOnaj2kb09/Y11JjZKfbKBsU
 0qaVxw4/uGN+6HHhD6y84Sdz4fPowsnSozwZa3kZF7aL
X-Google-Smtp-Source: AGHT+IEKqeXG3fO033pMTRHnve38MdgGh2BfwkH4FfCIMTils1SoTO+PmFYcYG7B9lPWJmvv+WG8TQ==
X-Received: by 2002:a17:907:7710:b0:9a9:ee3d:48db with SMTP id
 kw16-20020a170907771000b009a9ee3d48dbmr665378ejc.3.1694567655780; 
 Tue, 12 Sep 2023 18:14:15 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com.
 [209.85.128.51]) by smtp.gmail.com with ESMTPSA id
 lz5-20020a170906fb0500b0098e78ff1a87sm7501660ejb.120.2023.09.12.18.14.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 18:14:15 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4009fdc224dso19075e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 18:14:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4a9a:b0:3fe:ef25:8b86 with SMTP id
 b26-20020a05600c4a9a00b003feef258b86mr67736wmp.4.1694567654705; Tue, 12 Sep
 2023 18:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
 <87v8d2hqdu.fsf@alyssa.is> <87sf86hq0x.fsf@alyssa.is>
 <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
 <87jzsvrcvu.fsf@alyssa.is>
In-Reply-To: <87jzsvrcvu.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 12 Sep 2023 18:14:02 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=NEMnW4YKV1aqg98aSW-av8vWWF2W3Wqpqt7Y5hKxhKg@mail.gmail.com>
Message-ID: <CAAfnVB=NEMnW4YKV1aqg98aSW-av8vWWF2W3Wqpqt7Y5hKxhKg@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000001bdae006053347a3"
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

--0000000000001bdae006053347a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 1:53=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > On Fri, Aug 25, 2023 at 12:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wro=
te:
> >
> >> Alyssa Ross <hi@alyssa.is> writes:
> >>
> >> > Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >> >
> >> >> On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is>=
 wrote:
> >> >>
> >> >>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >> >>>
> >> >>> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.i=
s> wrote:
> >> >>> >
> >> >>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >> >>> >>
> >> >>> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
> >> >>> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
> >> >>> >> >
> >> >>> >> > - The release commits can make packaging easier, though once
> >> >>> >> >   again all known users will likely just build from sources
> >> >>> >> >   anyways
> >> >>> >>
> >> >>> >> It's a small thing, but could there be actual tags, rather than
> just
> >> >>> >> blessed commits?  It'd just make them easier to find, and save =
a
> >> bit of
> >> >>> >> time in review for packages.
> >> >>> >>
> >> >>> >
> >> >>> > I added:
> >> >>> >
> >> >>> >
> >> >>>
> >>
> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-po=
tential-packaging
> >> >>> >
> >> >>> > Tags are possible, but I want to clarify the use case before
> >> packaging.
> >> >>> > Where are you thinking of packaging it for (Debian??)? Are you
> mostly
> >> >>> > interested in Wayland passthrough (my guess) or gfxstream too?
> >> Depending
> >> >>> > your use case, we may be able to minimize the work involved.
> >> >>>
> >> >>> Packaging for Nixpkgs (where I already maintain what to my
> knowledge is
> >> >>> the only crosvm distro package).  I'm personally mostly interested
> in
> >> >>> Wayland passthroug, but I wouldn't be surprised if others are
> >> interested
> >> >>> in gfxstream.  The packaging work is already done, I've just been
> >> >>> holding off actually pushing the packages waiting for the stable
> >> >>> releases.
> >> >>>
> >> >>> The reason that tags would be useful is that it allows a reviewer =
of
> >> the
> >> >>> package to see at a glance that the package is built from a stable
> >> >>> release.  If it's just built from a commit hash, they have to go a=
nd
> >> >>> verify that it's a stable release, which is mildly annoying and
> >> >>> unconventional.
> >> >>>
> >> >>
> >> >> Understood.  Request to have gfxstream and AEMU v0.1.2 release tags
> >> made.
> >> >>
> >> >> For rutabaga_gfx_ffi, is the crates.io upload sufficient?
> >> >>
> >> >> https://crates.io/crates/rutabaga_gfx_ffi
> >> >>
> >> >> Debian, for example, treats crates.io as the source of truth and
> builds
> >> >> tooling around that.  I wonder if Nixpkgs as similar tooling around
> >> >> crates.io.
> >> >
> >> > We do, and I'll use the crates.io release for the package =E2=80=94 =
good
> >> > suggestion, but it's still useful to also have a tag in a git repo.
> It
> >> > makes it easier if I need to do a bisect, for example.  As a distro
> >> > developer, I'm frequently jumping across codebases I am not very
> >> > familiar with to try to track down regressions, etc., and it's much
> >> > easier when I don't have to learn some special quirk of the package
> like
> >> > not having git tags.
> >>
> >> Aha, trying to switch my package over to it has revealed that there is
> >> actually a reason not to use the crates.io release.  It doesn't includ=
e
> >> a Cargo.lock, which would mean we'd have to obtain one from elsewhere.
> >> Either from the crosvm git repo, at which point we might just get all
> >> the sources from there, or by vendoring a Cargo.lock into our own git
> >> tree for packages, which we try to avoid because when you have a lot o=
f
> >> them, they become quite a large proportion of the overall size of the
> >> repo.
> >>
> >
> > Ack.  Request to have a rutabaga release tag in crosvm also made, shoul=
d
> be
> > complete in a few days.
>
> Thanks!  I've found the rutabaga tag, but I still don't see any relevant
> tags for aemu or gfxstream.  Any news there?
>

It's harder to get the attention of the Android build team than the Chrome
build team.  Though, there are a few issues with AEMU/gfxstream packaging
we also need to figure out -- see "[PATCH v13 0/9] rutabaga_gfx +
gfxstream" for details -- interested in your opinion on the matter!

--0000000000001bdae006053347a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 12, 2023 at 1:53=E2=80=AF=
AM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@aly=
ssa.is</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" ta=
rget=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; On Fri, Aug 25, 2023 at 12:37=E2=80=AFPM Alyssa Ross &lt;<a href=3D"ma=
ilto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">=
hi@alyssa.is</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium=
.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross &lt;=
<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrot=
e:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@=
chromium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:=
<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa R=
oss &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&=
gt; wrote:<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurche=
tansingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt=
; writes:<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; - Official &quot;release commits&quot; =
issued for rutabaga_gfx_ffi,<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0gfxstream, aemu-base.=C2=A0=
 For example, see <a href=3D"http://crrev.com/c/4778941" rel=3D"noreferrer"=
 target=3D"_blank">crrev.com/c/4778941</a><br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt; - The release commits can make packagin=
g easier, though once<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0again all known users will =
likely just build from sources<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0anyways<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; It&#39;s a small thing, but could there be a=
ctual tags, rather than just<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; blessed commits?=C2=A0 It&#39;d just make th=
em easier to find, and save a<br>
&gt;&gt; bit of<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt; time in review for packages.<br>
&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; I added:<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html#late=
st-releases-for-potential-packaging" rel=3D"noreferrer" target=3D"_blank">h=
ttps://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-poten=
tial-packaging</a><br>
&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt; &gt; Tags are possible, but I want to clarify the use=
 case before<br>
&gt;&gt; packaging.<br>
&gt;&gt; &gt;&gt;&gt; &gt; Where are you thinking of packaging it for (Debi=
an??)? Are you mostly<br>
&gt;&gt; &gt;&gt;&gt; &gt; interested in Wayland passthrough (my guess) or =
gfxstream too?<br>
&gt;&gt; Depending<br>
&gt;&gt; &gt;&gt;&gt; &gt; your use case, we may be able to minimize the wo=
rk involved.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Packaging for Nixpkgs (where I already maintain what =
to my knowledge is<br>
&gt;&gt; &gt;&gt;&gt; the only crosvm distro package).=C2=A0 I&#39;m person=
ally mostly interested in<br>
&gt;&gt; &gt;&gt;&gt; Wayland passthroug, but I wouldn&#39;t be surprised i=
f others are<br>
&gt;&gt; interested<br>
&gt;&gt; &gt;&gt;&gt; in gfxstream.=C2=A0 The packaging work is already don=
e, I&#39;ve just been<br>
&gt;&gt; &gt;&gt;&gt; holding off actually pushing the packages waiting for=
 the stable<br>
&gt;&gt; &gt;&gt;&gt; releases.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; The reason that tags would be useful is that it allow=
s a reviewer of<br>
&gt;&gt; the<br>
&gt;&gt; &gt;&gt;&gt; package to see at a glance that the package is built =
from a stable<br>
&gt;&gt; &gt;&gt;&gt; release.=C2=A0 If it&#39;s just built from a commit h=
ash, they have to go and<br>
&gt;&gt; &gt;&gt;&gt; verify that it&#39;s a stable release, which is mildl=
y annoying and<br>
&gt;&gt; &gt;&gt;&gt; unconventional.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Understood.=C2=A0 Request to have gfxstream and AEMU v0.1=
.2 release tags<br>
&gt;&gt; made.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; For rutabaga_gfx_ffi, is the <a href=3D"http://crates.io"=
 rel=3D"noreferrer" target=3D"_blank">crates.io</a> upload sufficient?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; <a href=3D"https://crates.io/crates/rutabaga_gfx_ffi" rel=
=3D"noreferrer" target=3D"_blank">https://crates.io/crates/rutabaga_gfx_ffi=
</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Debian, for example, treats <a href=3D"http://crates.io" =
rel=3D"noreferrer" target=3D"_blank">crates.io</a> as the source of truth a=
nd builds<br>
&gt;&gt; &gt;&gt; tooling around that.=C2=A0 I wonder if Nixpkgs as similar=
 tooling around<br>
&gt;&gt; &gt;&gt; <a href=3D"http://crates.io" rel=3D"noreferrer" target=3D=
"_blank">crates.io</a>.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We do, and I&#39;ll use the <a href=3D"http://crates.io" rel=
=3D"noreferrer" target=3D"_blank">crates.io</a> release for the package =E2=
=80=94 good<br>
&gt;&gt; &gt; suggestion, but it&#39;s still useful to also have a tag in a=
 git repo.=C2=A0 It<br>
&gt;&gt; &gt; makes it easier if I need to do a bisect, for example.=C2=A0 =
As a distro<br>
&gt;&gt; &gt; developer, I&#39;m frequently jumping across codebases I am n=
ot very<br>
&gt;&gt; &gt; familiar with to try to track down regressions, etc., and it&=
#39;s much<br>
&gt;&gt; &gt; easier when I don&#39;t have to learn some special quirk of t=
he package like<br>
&gt;&gt; &gt; not having git tags.<br>
&gt;&gt;<br>
&gt;&gt; Aha, trying to switch my package over to it has revealed that ther=
e is<br>
&gt;&gt; actually a reason not to use the <a href=3D"http://crates.io" rel=
=3D"noreferrer" target=3D"_blank">crates.io</a> release.=C2=A0 It doesn&#39=
;t include<br>
&gt;&gt; a Cargo.lock, which would mean we&#39;d have to obtain one from el=
sewhere.<br>
&gt;&gt; Either from the crosvm git repo, at which point we might just get =
all<br>
&gt;&gt; the sources from there, or by vendoring a Cargo.lock into our own =
git<br>
&gt;&gt; tree for packages, which we try to avoid because when you have a l=
ot of<br>
&gt;&gt; them, they become quite a large proportion of the overall size of =
the<br>
&gt;&gt; repo.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Ack.=C2=A0 Request to have a rutabaga release tag in crosvm also made,=
 should be<br>
&gt; complete in a few days.<br>
<br>
Thanks!=C2=A0 I&#39;ve found the rutabaga tag, but I still don&#39;t see an=
y relevant<br>
tags for aemu or gfxstream.=C2=A0 Any news there?<br></blockquote><div><br>=
</div><div>It&#39;s harder to get the attention of the Android build team t=
han the Chrome build team.=C2=A0 Though, there are a few issues with AEMU/g=
fxstream packaging we also need to figure out -- see &quot;[PATCH v13 0/9] =
rutabaga_gfx + gfxstream&quot; for details -- interested in your opinion on=
 the matter!</div><div>=C2=A0</div></div></div>

--0000000000001bdae006053347a3--

