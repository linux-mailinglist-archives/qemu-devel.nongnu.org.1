Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B7078BC34
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 02:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qampd-0006Ds-HL; Mon, 28 Aug 2023 20:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qampa-0006Dc-BS
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:43:42 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qampW-0000MQ-Ob
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:43:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso4998149a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693269817; x=1693874617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U11GIOFJHNx1BiktUibuYyGzK2t/vYnQSiNpu33bGh8=;
 b=l73VYhbiGQHw+/qSImqg5Tdj7TjpxkTbfWQKwTmoAdW8PyXPCqTwXXpsHOgsTxwGvG
 kYXrrkh1LO+bR0So7DaYCdvEI72hvgrgHyuHYMMivqczRelpW1r0p+kpiQ6JyuBcEqrI
 gbZ/Y/XBVCNEtXCS2gpgVhMEQqVYIUZQVWXlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693269817; x=1693874617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U11GIOFJHNx1BiktUibuYyGzK2t/vYnQSiNpu33bGh8=;
 b=E/b2LnM1Jjzai9G9nhIdsS6zt4qt9Zq3OfEpZx9Funf2OvSSqof/sfe5Nyek1PkiPK
 ujNm6xQNrSkCH6KlhPPEp6pmmz7T/gHtL3mTw7wY2oLbg0Qt8bSPy4F/pWovOg8Q01h5
 juRdkxBbEqEUo19ti5frsK+Sm+JS/B5P0Sc7ZJOBKDNsbOaBtOCRQwMicTFZPsJ3wox8
 zcCBhOvVkxHTK0ooLUZGSLs5UGnFpiSW8ea3EE/urhTp0UBuruQYeNNrbmb03nxzi06J
 ejYuJuADnOd/b+8YNba1zWaovHCbtCFiAU6IxyvleL21wpaRMBtZ9tbIlQ8c2pIP6r1v
 cWMA==
X-Gm-Message-State: AOJu0Yw0UgM+ZUXlx37p93OJYuA0vKXxqbkRt3lbi5r59sFs2t3gRHZk
 IYPlxS7hIchRGuEoeTzFqwgOH/86SsWSCYPe+bzcTg==
X-Google-Smtp-Source: AGHT+IFm1RGGWLQBC5gm1H3nlt4otAIDkuDOXNN+FLTxMJDU5Yv/fn4YFO8+bQfvIyBPc+uJVXQj4g==
X-Received: by 2002:a50:ed09:0:b0:525:6d9e:67c0 with SMTP id
 j9-20020a50ed09000000b005256d9e67c0mr20653125eds.23.1693269816284; 
 Mon, 28 Aug 2023 17:43:36 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 x4-20020aa7dac4000000b005256e0797acsm5090405eds.37.2023.08.28.17.43.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 17:43:36 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so6338a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 17:43:35 -0700 (PDT)
X-Received: by 2002:a50:c2c9:0:b0:51a:1ffd:10e with SMTP id
 u9-20020a50c2c9000000b0051a1ffd010emr44174edf.3.1693269815422; Mon, 28 Aug
 2023 17:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
 <87v8d2hqdu.fsf@alyssa.is> <87sf86hq0x.fsf@alyssa.is>
In-Reply-To: <87sf86hq0x.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 28 Aug 2023 17:43:23 -0700
X-Gmail-Original-Message-ID: <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
Message-ID: <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="000000000000dc51550604051986"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x52a.google.com
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

--000000000000dc51550604051986
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:

> Alyssa Ross <hi@alyssa.is> writes:
>
> > Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >
> >> On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wr=
ote:
> >>
> >>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >>>
> >>> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> =
wrote:
> >>> >
> >>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >>> >>
> >>> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
> >>> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
> >>> >> >
> >>> >> > - The release commits can make packaging easier, though once
> >>> >> >   again all known users will likely just build from sources
> >>> >> >   anyways
> >>> >>
> >>> >> It's a small thing, but could there be actual tags, rather than ju=
st
> >>> >> blessed commits?  It'd just make them easier to find, and save a
> bit of
> >>> >> time in review for packages.
> >>> >>
> >>> >
> >>> > I added:
> >>> >
> >>> >
> >>>
> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-po=
tential-packaging
> >>> >
> >>> > Tags are possible, but I want to clarify the use case before
> packaging.
> >>> > Where are you thinking of packaging it for (Debian??)? Are you most=
ly
> >>> > interested in Wayland passthrough (my guess) or gfxstream too?
> Depending
> >>> > your use case, we may be able to minimize the work involved.
> >>>
> >>> Packaging for Nixpkgs (where I already maintain what to my knowledge =
is
> >>> the only crosvm distro package).  I'm personally mostly interested in
> >>> Wayland passthroug, but I wouldn't be surprised if others are
> interested
> >>> in gfxstream.  The packaging work is already done, I've just been
> >>> holding off actually pushing the packages waiting for the stable
> >>> releases.
> >>>
> >>> The reason that tags would be useful is that it allows a reviewer of
> the
> >>> package to see at a glance that the package is built from a stable
> >>> release.  If it's just built from a commit hash, they have to go and
> >>> verify that it's a stable release, which is mildly annoying and
> >>> unconventional.
> >>>
> >>
> >> Understood.  Request to have gfxstream and AEMU v0.1.2 release tags
> made.
> >>
> >> For rutabaga_gfx_ffi, is the crates.io upload sufficient?
> >>
> >> https://crates.io/crates/rutabaga_gfx_ffi
> >>
> >> Debian, for example, treats crates.io as the source of truth and build=
s
> >> tooling around that.  I wonder if Nixpkgs as similar tooling around
> >> crates.io.
> >
> > We do, and I'll use the crates.io release for the package =E2=80=94 goo=
d
> > suggestion, but it's still useful to also have a tag in a git repo.  It
> > makes it easier if I need to do a bisect, for example.  As a distro
> > developer, I'm frequently jumping across codebases I am not very
> > familiar with to try to track down regressions, etc., and it's much
> > easier when I don't have to learn some special quirk of the package lik=
e
> > not having git tags.
>
> Aha, trying to switch my package over to it has revealed that there is
> actually a reason not to use the crates.io release.  It doesn't include
> a Cargo.lock, which would mean we'd have to obtain one from elsewhere.
> Either from the crosvm git repo, at which point we might just get all
> the sources from there, or by vendoring a Cargo.lock into our own git
> tree for packages, which we try to avoid because when you have a lot of
> them, they become quite a large proportion of the overall size of the
> repo.
>

Ack.  Request to have a rutabaga release tag in crosvm also made, should be
complete in a few days.


>
> (This probably differs from Debian, etc., because in Nixpkgs, we don't
> package each crate dependency separately.  We only have packages for
> applications (or occasionally, C ABI libraries written in Rust), and
> each of those gets to bring in whatever crate dependencies it wants as
> part of its build.  This means we use the upstream Cargo.lock, and
> accept that different Rust packages will use lots of different versions
> of dependencies, which I don't believe is the case with other distros
> that take a more purist approach to Rust packaging.)
>

--000000000000dc51550604051986
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 25, 2023 at 12:37=E2=80=
=AFPM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Alyssa Ro=
ss &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&g=
t; writes:<br>
<br>
&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" tar=
get=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross &lt;<a href=
=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.=
org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross &lt;<=
a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote=
:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@=
chromium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:=
<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; &gt; - Official &quot;release commits&quot; issued fo=
r rutabaga_gfx_ffi,<br>
&gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0gfxstream, aemu-base.=C2=A0 For exam=
ple, see <a href=3D"http://crrev.com/c/4778941" rel=3D"noreferrer" target=
=3D"_blank">crrev.com/c/4778941</a><br>
&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;&gt; &gt; - The release commits can make packaging easier,=
 though once<br>
&gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0again all known users will likely ju=
st build from sources<br>
&gt;&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0anyways<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; It&#39;s a small thing, but could there be actual tag=
s, rather than just<br>
&gt;&gt;&gt; &gt;&gt; blessed commits?=C2=A0 It&#39;d just make them easier=
 to find, and save a bit of<br>
&gt;&gt;&gt; &gt;&gt; time in review for packages.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I added:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html#=
latest-releases-for-potential-packaging" rel=3D"noreferrer" target=3D"_blan=
k">https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-p=
otential-packaging</a><br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Tags are possible, but I want to clarify the use case bef=
ore packaging.<br>
&gt;&gt;&gt; &gt; Where are you thinking of packaging it for (Debian??)? Ar=
e you mostly<br>
&gt;&gt;&gt; &gt; interested in Wayland passthrough (my guess) or gfxstream=
 too?=C2=A0 Depending<br>
&gt;&gt;&gt; &gt; your use case, we may be able to minimize the work involv=
ed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Packaging for Nixpkgs (where I already maintain what to my kno=
wledge is<br>
&gt;&gt;&gt; the only crosvm distro package).=C2=A0 I&#39;m personally most=
ly interested in<br>
&gt;&gt;&gt; Wayland passthroug, but I wouldn&#39;t be surprised if others =
are interested<br>
&gt;&gt;&gt; in gfxstream.=C2=A0 The packaging work is already done, I&#39;=
ve just been<br>
&gt;&gt;&gt; holding off actually pushing the packages waiting for the stab=
le<br>
&gt;&gt;&gt; releases.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The reason that tags would be useful is that it allows a revie=
wer of the<br>
&gt;&gt;&gt; package to see at a glance that the package is built from a st=
able<br>
&gt;&gt;&gt; release.=C2=A0 If it&#39;s just built from a commit hash, they=
 have to go and<br>
&gt;&gt;&gt; verify that it&#39;s a stable release, which is mildly annoyin=
g and<br>
&gt;&gt;&gt; unconventional.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Understood.=C2=A0 Request to have gfxstream and AEMU v0.1.2 releas=
e tags made.<br>
&gt;&gt;<br>
&gt;&gt; For rutabaga_gfx_ffi, is the <a href=3D"http://crates.io" rel=3D"n=
oreferrer" target=3D"_blank">crates.io</a> upload sufficient?<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://crates.io/crates/rutabaga_gfx_ffi" rel=3D"noref=
errer" target=3D"_blank">https://crates.io/crates/rutabaga_gfx_ffi</a><br>
&gt;&gt;<br>
&gt;&gt; Debian, for example, treats <a href=3D"http://crates.io" rel=3D"no=
referrer" target=3D"_blank">crates.io</a> as the source of truth and builds=
<br>
&gt;&gt; tooling around that.=C2=A0 I wonder if Nixpkgs as similar tooling =
around<br>
&gt;&gt; <a href=3D"http://crates.io" rel=3D"noreferrer" target=3D"_blank">=
crates.io</a>.<br>
&gt;<br>
&gt; We do, and I&#39;ll use the <a href=3D"http://crates.io" rel=3D"norefe=
rrer" target=3D"_blank">crates.io</a> release for the package =E2=80=94 goo=
d<br>
&gt; suggestion, but it&#39;s still useful to also have a tag in a git repo=
.=C2=A0 It<br>
&gt; makes it easier if I need to do a bisect, for example.=C2=A0 As a dist=
ro<br>
&gt; developer, I&#39;m frequently jumping across codebases I am not very<b=
r>
&gt; familiar with to try to track down regressions, etc., and it&#39;s muc=
h<br>
&gt; easier when I don&#39;t have to learn some special quirk of the packag=
e like<br>
&gt; not having git tags.<br>
<br>
Aha, trying to switch my package over to it has revealed that there is<br>
actually a reason not to use the <a href=3D"http://crates.io" rel=3D"norefe=
rrer" target=3D"_blank">crates.io</a> release.=C2=A0 It doesn&#39;t include=
<br>
a Cargo.lock, which would mean we&#39;d have to obtain one from elsewhere.<=
br>
Either from the crosvm git repo, at which point we might just get all<br>
the sources from there, or by vendoring a Cargo.lock into our own git<br>
tree for packages, which we try to avoid because when you have a lot of<br>
them, they become quite a large proportion of the overall size of the<br>
repo.<br></blockquote><div><br></div><div>Ack.=C2=A0 Request to have a ruta=
baga release tag in crosvm also made, should be complete in a few days.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
(This probably differs from Debian, etc., because in Nixpkgs, we don&#39;t<=
br>
package each crate dependency separately.=C2=A0 We only have packages for<b=
r>
applications (or occasionally, C ABI libraries written in Rust), and<br>
each of those gets to bring in whatever crate dependencies it wants as<br>
part of its build.=C2=A0 This means we use the upstream Cargo.lock, and<br>
accept that different Rust packages will use lots of different versions<br>
of dependencies, which I don&#39;t believe is the case with other distros<b=
r>
that take a more purist approach to Rust packaging.)<br>
</blockquote></div></div>

--000000000000dc51550604051986--

