Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950E788F42
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcVS-0007ah-IT; Fri, 25 Aug 2023 15:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZcVO-0007aE-12
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:30:02 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZcVK-0000cP-Qz
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:30:01 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 44A653200AC7;
 Fri, 25 Aug 2023 15:29:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 25 Aug 2023 15:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1692991793; x=1693078193; bh=rX
 +MngYt57rLjQWB+KbsI2HWIZ9EeLUQpewgZaXHSOA=; b=MjH3to1apktpiEYLgz
 CNE4qLaH1JTiZmSOJUp/Cvw7kIcXt5Gd4Xs1E2XMvJ6Fk4BGIwKxwgDDsLsk9hS2
 I3IgmM9RbilU1Pd7yu9ou2ALLg6p9ezvAoOqrBKyc+urpjCZ69P4Ll4LusKooO27
 yBC2+dhJY1I7KgOGC3GQTrblpPiVUSUypJnpZM4jXjNNBpDjZ7avSETYe0+rE1dr
 hUaao1QeXNhhij2YBPz0wuyzbDM2kN3oJVQeb+sP5OokHmw4W7con/2xNAf097tL
 OdTbmrbyC1eJ9d3hJtIGT5McKvQLTK7dEfrd5l6KSOz8Ucga5jxBh4Qpey6z9Rzk
 TH/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692991793; x=1693078193; bh=rX+MngYt57rLj
 QWB+KbsI2HWIZ9EeLUQpewgZaXHSOA=; b=WW4BPmEMQqg+cayYWT4iYjnCl7xe8
 PXOYv5oxJ3QoNrj39zE6NNYo39yymMkt2YpFuKJ3zpNO2+tEbUzjb/aZnHhPevzI
 A19fn4Sx0VGAXq/CkH1oUGWi5APsansmNPPDLaV79qwdp82aifNpt4Gm5qdIybGg
 9IK5xiL0DR5GNqyr50xRMHT5XW7AB9xH6/SYbJf09P8ipXSqGHRwnbtCNBycf42o
 3dGV5byC1t9XQcXRUh+TR8i0Er+8mvBcOjuNBg+fM6Zu0zF+qkZNFl3aqakAS3/j
 0CIcJVHGkpNmadv6ZDF9WKEdThxn6oDzs/EjGjtMs5ubA2ZbO28rExQPQ==
X-ME-Sender: <xms:MQHpZCDhAbqwBEmzcnuOpGunbxWbAuI1mE_9AwkInva-TXXPOEifIA>
 <xme:MQHpZMi2hXQsWGVSXJMpLbTbvtXPDMiYax82drW0ceEyFLi2-JTK5Ao11aj-qvsTz
 RnQ0AJyNmNBEbUpQQ>
X-ME-Received: <xmr:MQHpZFnb5qaEz1EkFj2urZgfSHqqF5zkUWbAQd0sqFfiHd1IQ1ldJaoK_z4rFQhM94Scbkgk4fbnhE41nOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvkedgudefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihs
 shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephe
 etvdfggedvgefgheeifeeujeeifeefvefghfeftdeuffdtleffleevuefhudfhnecuffho
 mhgrihhnpegtrhhrvghvrdgtohhmpdgtrhhoshhvmhdruggvvhdptghrrghtvghsrdhioh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihes
 rghlhihsshgrrdhish
X-ME-Proxy: <xmx:MQHpZAzHTCJDyV08g5n-33LEDrN1SBIssQZW6eSInxXG4xGEHYWDsg>
 <xmx:MQHpZHRM2bjMUFd3OSbELIPgAUTZIGOMWEk0M-06m1PyBA6jLpR4AA>
 <xmx:MQHpZLZhDIMzWVxP-nMha20LiFLJIx9qa7hZYQu1kO912AT-VXAgLA>
 <xmx:MQHpZCFMVyo3ird4b3O1eQjKP7_kJ-gBM2BBLoXezsIExOKh_qEm9g>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Aug 2023 15:29:52 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id F15C080A3; Fri, 25 Aug 2023 19:29:50 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
Date: Fri, 25 Aug 2023 19:29:49 +0000
Message-ID: <87v8d2hqdu.fsf@alyssa.is>
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

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wro=
te:
>> >
>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >>
>> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
>> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
>> >> >
>> >> > - The release commits can make packaging easier, though once
>> >> >   again all known users will likely just build from sources
>> >> >   anyways
>> >>
>> >> It's a small thing, but could there be actual tags, rather than just
>> >> blessed commits?  It'd just make them easier to find, and save a bit =
of
>> >> time in review for packages.
>> >>
>> >
>> > I added:
>> >
>> >
>> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-p=
otential-packaging
>> >
>> > Tags are possible, but I want to clarify the use case before packaging.
>> > Where are you thinking of packaging it for (Debian??)? Are you mostly
>> > interested in Wayland passthrough (my guess) or gfxstream too?  Depend=
ing
>> > your use case, we may be able to minimize the work involved.
>>
>> Packaging for Nixpkgs (where I already maintain what to my knowledge is
>> the only crosvm distro package).  I'm personally mostly interested in
>> Wayland passthroug, but I wouldn't be surprised if others are interested
>> in gfxstream.  The packaging work is already done, I've just been
>> holding off actually pushing the packages waiting for the stable
>> releases.
>>
>> The reason that tags would be useful is that it allows a reviewer of the
>> package to see at a glance that the package is built from a stable
>> release.  If it's just built from a commit hash, they have to go and
>> verify that it's a stable release, which is mildly annoying and
>> unconventional.
>>
>
> Understood.  Request to have gfxstream and AEMU v0.1.2 release tags made.
>
> For rutabaga_gfx_ffi, is the crates.io upload sufficient?
>
> https://crates.io/crates/rutabaga_gfx_ffi
>
> Debian, for example, treats crates.io as the source of truth and builds
> tooling around that.  I wonder if Nixpkgs as similar tooling around
> crates.io.

We do, and I'll use the crates.io release for the package =E2=80=94 good
suggestion, but it's still useful to also have a tag in a git repo.  It
makes it easier if I need to do a bisect, for example.  As a distro
developer, I'm frequently jumping across codebases I am not very
familiar with to try to track down regressions, etc., and it's much
easier when I don't have to learn some special quirk of the package like
not having git tags.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTpAS0ACgkQ+dvtSFmy
ccDm4xAAoOOdnnrmdhrydiCbm+CIgoCOSY7heMeHx+4HsSO6L5OCkn3wstJAGAe3
ptAelZwaPwiYlHCltOr1qKNWiVD39QBfZ6TkA74kJm6mM0mRmBqxI7/1vBM6uRh8
dUnDDxCL62Q90rluqG0vP1ckz/akJQr+NfXSA2vGVJ8egBNZ4bmvL9Sicf8PkIVw
KDS7RK+/Gga6VNTAazjVz26cmPv7zmUdb6zvx2+gm/iLWRbfzgl3HD1xF6Lf16j9
ht9LFSER8XA2xQdXJwGj67OOoz/lQHjo3I9R5U0xP9g+vWFrxZnGw3emvuuvqZ7E
ZIvV388ZCUazDhX4227d0qByzy0mml/ex93tloLQ+85fSJ+s69H/lCIVuKsn1mCx
5m1/a+RKey0K2xMv7UAlI9NVbdmksMU2/OsStc+KGHeqA7JOh4N1yes+q+raJ8By
U9SNNAfmBhKAc1sAKBFxxzif9i2ruC1wsSvamwOoCRtf2AGneekSua2OYJ1qXhV7
ftMZQPtm4o9oHNidQ94Oyy4vh71eBnPYTs6HlESsT/gVf+zlAsTFw5WiE0gE2sPy
GDvQrZlPkd8LfPyecbgmJZUAeVtX10GWoAiXh4FYIyJXj/8bzra30GMg0TGjH/bm
O+XsFslv/TxdTocWvo5BUwHaHuzupV7VfNKiKnFrAJfmKxIsKsI=
=ohtt
-----END PGP SIGNATURE-----
--=-=-=--

