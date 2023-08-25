Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC6788F47
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcct-0001ev-6f; Fri, 25 Aug 2023 15:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZccq-0001ek-CG
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:37:44 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZccn-0002Dv-Oj
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:37:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id B20F532000E5;
 Fri, 25 Aug 2023 15:37:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 25 Aug 2023 15:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1692992258; x=1693078658; bh=24
 a1uiVQUplTalyANEqOTFMS9L6DAQzoYA5hzjc5XRI=; b=LBqXGPeYr+cFr4cm1P
 ay7CM7ofjg5FIL2Kq7u7HkDc/1NVKqFOHF29qsBxK7exZUiaOZh80SsGSh15jhC7
 DYN6ftW1Bckl0E3j+0Y3ANeuN/EfyuR+fUXRA8SkEH9o1KP6Y71vB97cMaXrum7q
 neyALBPSu65ZybBSQ5hgrf5U9/1Ku/y7qYZ7Z5uKuKqfh/pV/ogiNR+xVrLVa3wn
 X+ilHRqkj6+W8X+g/9MCS7i6uOyR4sHJ1spwuUp1R50+CITxM7LTGRUQ7XEjhtKZ
 QvuHB6en4VNdnw78Q+Hsc6MspGDGnB+ZeaAha80ICrd0FV1nEKvmd+ex8VwZ6oiN
 PtjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692992258; x=1693078658; bh=24a1uiVQUplTa
 lyANEqOTFMS9L6DAQzoYA5hzjc5XRI=; b=TmBNLTNJDWzKKKWrv27i8LpN7JMtl
 8okEdevwG48zI0zZk+qUqz1A6J9dV5JKRnvo2fY0HzgYV2SMn6EPhDqa3/vWefz3
 AqqXOElHnq24d8w6UqxmiTA9FV0AUxN1Pop0NqadB+WY8ftC9pbhnm0cmyU0mZ9x
 HYjrZ/6lmGGXHYnfSdLv70MGDjLhw/86GyzgiTHn7OIkoSjtNNRnL5l+oPhDJEb/
 qcPewRMkcQsarC6OnzCSqNPY4jjQAH3V4f5SVcUN33rIxj2B/7vuLdQ+sA4T2Yd9
 MJVrhjZU/zr1lgdDtfEA84YZEyneVD5qkI7+P6OtTwSZ2PNFUG8Jq5WeA==
X-ME-Sender: <xms:AQPpZAUhVk4zKEVgPG3BcxHu1KPdmvkxc7CdD9Zo33wmwGBCXa0YFA>
 <xme:AQPpZEmp6MoeEIJTeWg6Hyx8yVRohucatJrwpTebqg2HsNyXa5KM5j3adIbKyRTtJ
 h6QYQkgtOoCln0e-A>
X-ME-Received: <xmr:AQPpZEYC1MGI3jFu9h5sAl7fsngkiGkIEwCrpiuNCUqX_J4P3IMzxFfKhK7rl_508Ur6QX1uDYcy7jH-a9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvkedgudefkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihs
 shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephe
 etvdfggedvgefgheeifeeujeeifeefvefghfeftdeuffdtleffleevuefhudfhnecuffho
 mhgrihhnpegtrhhrvghvrdgtohhmpdgtrhhoshhvmhdruggvvhdptghrrghtvghsrdhioh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihes
 rghlhihsshgrrdhish
X-ME-Proxy: <xmx:AQPpZPVHuxLlcsKWpsgc5EujKSX-xeWGjI0QsHC3N4ouSndRwzDx2Q>
 <xmx:AQPpZKmFg0SOkg4Eqxax6IBN2c-9ewibFUlPUNHUTHwlKIGXnD3BwA>
 <xmx:AQPpZEdbyJxNmIqGb_83XXx9sQWKag1G46Bxnz5p81aYXqqWJc0RFw>
 <xmx:AgPpZE4IQF4dmV9rBwCLMLbig-m6Zda56crXfDsy5kSxbQ8JfgP2lA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Aug 2023 15:37:37 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id A9BE280A5; Fri, 25 Aug 2023 19:37:35 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <87v8d2hqdu.fsf@alyssa.is>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
 <87v8d2hqdu.fsf@alyssa.is>
Date: Fri, 25 Aug 2023 19:37:34 +0000
Message-ID: <87sf86hq0x.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.20; envelope-from=hi@alyssa.is;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alyssa Ross <hi@alyssa.is> writes:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
>> On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrot=
e:
>>
>>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>>
>>> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wr=
ote:
>>> >
>>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>> >>
>>> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
>>> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
>>> >> >
>>> >> > - The release commits can make packaging easier, though once
>>> >> >   again all known users will likely just build from sources
>>> >> >   anyways
>>> >>
>>> >> It's a small thing, but could there be actual tags, rather than just
>>> >> blessed commits?  It'd just make them easier to find, and save a bit=
 of
>>> >> time in review for packages.
>>> >>
>>> >
>>> > I added:
>>> >
>>> >
>>> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-=
potential-packaging
>>> >
>>> > Tags are possible, but I want to clarify the use case before packagin=
g.
>>> > Where are you thinking of packaging it for (Debian??)? Are you mostly
>>> > interested in Wayland passthrough (my guess) or gfxstream too?  Depen=
ding
>>> > your use case, we may be able to minimize the work involved.
>>>
>>> Packaging for Nixpkgs (where I already maintain what to my knowledge is
>>> the only crosvm distro package).  I'm personally mostly interested in
>>> Wayland passthroug, but I wouldn't be surprised if others are interested
>>> in gfxstream.  The packaging work is already done, I've just been
>>> holding off actually pushing the packages waiting for the stable
>>> releases.
>>>
>>> The reason that tags would be useful is that it allows a reviewer of the
>>> package to see at a glance that the package is built from a stable
>>> release.  If it's just built from a commit hash, they have to go and
>>> verify that it's a stable release, which is mildly annoying and
>>> unconventional.
>>>
>>
>> Understood.  Request to have gfxstream and AEMU v0.1.2 release tags made.
>>
>> For rutabaga_gfx_ffi, is the crates.io upload sufficient?
>>
>> https://crates.io/crates/rutabaga_gfx_ffi
>>
>> Debian, for example, treats crates.io as the source of truth and builds
>> tooling around that.  I wonder if Nixpkgs as similar tooling around
>> crates.io.
>
> We do, and I'll use the crates.io release for the package =E2=80=94 good
> suggestion, but it's still useful to also have a tag in a git repo.  It
> makes it easier if I need to do a bisect, for example.  As a distro
> developer, I'm frequently jumping across codebases I am not very
> familiar with to try to track down regressions, etc., and it's much
> easier when I don't have to learn some special quirk of the package like
> not having git tags.

Aha, trying to switch my package over to it has revealed that there is
actually a reason not to use the crates.io release.  It doesn't include
a Cargo.lock, which would mean we'd have to obtain one from elsewhere.
Either from the crosvm git repo, at which point we might just get all
the sources from there, or by vendoring a Cargo.lock into our own git
tree for packages, which we try to avoid because when you have a lot of
them, they become quite a large proportion of the overall size of the
repo.

(This probably differs from Debian, etc., because in Nixpkgs, we don't
package each crate dependency separately.  We only have packages for
applications (or occasionally, C ABI libraries written in Rust), and
each of those gets to bring in whatever crate dependencies it wants as
part of its build.  This means we use the upstream Cargo.lock, and
accept that different Rust packages will use lots of different versions
of dependencies, which I don't believe is the case with other distros
that take a more purist approach to Rust packaging.)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTpAv4ACgkQ+dvtSFmy
ccBpCg/9Eihm7a6BYNBNludX3i8eCbyuXEOiTGty6liYuB1Ox8kEWz2RJKyj4xAJ
mq4vIErCkjx5M2NJfxnpxMzNsWiI7Cr420eUjVRLBjqIB3mUa5itc4VW+y1cWKAM
oL3iZMdttJ7bf9CfvTwSoa9bgXYBzl9g4FeD87xsz0plXz6avZqAtK9PrX4zrUIu
3JX5twbCuxkivpmxY/oKl54DQH6F5p+Dv+mLH98qrmloKqNufkVkH3aN+4cpRYaG
3iK7+WRXDGa8/HRe3J4JXbeDYDDziHNFENESJuSgDVwHV0d21D60mbYr6WKU8k6h
WbRdHH8nq+0wUoPV79WcC2cW9O3tEbEkoF8XDEM8w1Hs5jCqLM045HLO0xvg/520
e1qDe33Scn80Gfx3s3qlKbs6dg9QK+LH/XrPnwmb1V5lVehn9VZJrAC4IGRuXczV
+UcaAaN957qeJr/rug4DWN5nP/hSk8DbrQUiuObQT/MwVGtn+JxpC7FNBpbTY0oN
tGspdy7awUSpB5ctfthEXjKf4k4C4ItJpjwagEtXFB3Rg2fJPADuRD2oGd39BNXn
BuOKHQRqkKyQjrJ936sdjGSs+6QlseiEEFcE/wJ8pjRXxBcNb8GhtBPEL2y3Qy/p
m7KaGsdChNymMk9H/aJTesglJYoYLPgNUzke3cKhwgda8XIuKPA=
=5+FG
-----END PGP SIGNATURE-----
--=-=-=--

