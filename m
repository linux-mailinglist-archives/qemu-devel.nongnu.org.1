Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D183340C
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 13:20:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRAJs-0006UA-Fa; Sat, 20 Jan 2024 07:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rRAJp-0006Ti-LZ
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 07:19:25 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rRAJn-0004Tt-Dy
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 07:19:25 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id 4AFFF5C015E;
 Sat, 20 Jan 2024 07:19:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Sat, 20 Jan 2024 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1705753161; x=1705839561; bh=k6GtqYs65P
 FWqDzkl7NQVDzrjgbFe8YiepSl1p3whkU=; b=Ust+ShhWrUuEoU+/qKS4gdp1uX
 qi8MnHBzmkw/hAl9LePyCdUISuDnhIL+xButWjecQjFup7yqV1wZVKKj69b2lMkX
 7bfuQTRBdo80cxj4KyxRJD3rX/M4cCv+7PLD7UD0GPclZRvR2/9YaYYzGxPdIV3D
 xWrlLzaKYkKziOiXDZGbC5TwuBC5MFR1Dp1k91BbT5Zg+w/GpKCZj/HtsSZ6FH0/
 yY9pmyjsKfexrGHsmwOrJRNLjJLT/megFOJdTtLnTxqkuG67iOFdRcRhpWkkkxgF
 TgZgudBwSQ4NPe6KL9rPsoCuR/qLuRZModLwagdAZZCa/xalfcgcfiI0Pn3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1705753161; x=1705839561; bh=k6GtqYs65PFWqDzkl7NQVDzrjgbF
 e8YiepSl1p3whkU=; b=BYJDt1VPxigMovIR9U3ripnfc7dHU2lKGmvSSlUayPUg
 cvuZjxfv5Of1q8xjFeKegzYI40gQjXyEIrcJkrbCNUOzYtB6wI1oKBlinyyUM/6p
 6qc0k8CNDYejl3v9Vx9wk1kx81ZAiQxxy1DxSvK+1JoLmbBUCm26jWXQrvHwXplE
 ZbOm92e6sKZIK7sgGPFZZ3+DuvmGhSlHUMPGsX2jKiEYZbo/vPa+Rmz/R7WeehDE
 H0/iT5aamSpqYcF4QY1vxfHAPII2jOQr9AX3+o9ZSSOWW4zOik/AF1WwcLK1xfPL
 zgB954WDuV/SFOHIqk2hajFhA1VfybaKObvktQF2Ng==
X-ME-Sender: <xms:SLqrZZE7fqSt7pHhQ7OGAzojJWtOywLjsciYuFw0Wlpmfx0lL9riTA>
 <xme:SLqrZeW-5WJ7gLqqj8qFAa4MZ2WUWWTqZnJsQ6eovS_Fcc_8cxYLqBVfKAbhoj6dw
 7B7QXsZk1ajMSzc9Q>
X-ME-Received: <xmr:SLqrZbJd0A0FpKAYbWVneHhUGJmhpXop2dQEFQRe156KfYgAMx8w3V7bhn1raTHTdyanZNPOifs-etuxcMD3avGucHfa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgfeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeelvd
 fhtefgieegtdeutefguefgteejhfduffehieejteethedugeduledttdejieenucffohhm
 rghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:SLqrZfE84RYKhjaCeHu8wTa4VMmHIvMM135rdlCpkUeSVWP0QvDSXw>
 <xmx:SLqrZfU8F4PcmCMeCe6hw_m2SI-008KbiLrqk3SFC_lVCeNY-jz0Og>
 <xmx:SLqrZaOua9rffLFifb9fj9I35tlYxYK2HdCnQYp2hRF1Mg4W8lO0kw>
 <xmx:SbqrZfR786vmGrwMbfR00sLxbZSTj_sKu-boZLRLZn_vbuH2vUNfmQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jan 2024 07:19:20 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 95012C0A3; Sat, 20 Jan 2024 13:19:18 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
Date: Sat, 20 Jan 2024 13:18:52 +0100
Message-ID: <87cytwnqoj.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.26; envelope-from=hi@alyssa.is;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

> On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Hi Gurchetan,
>>
>> > Thanks for the reminder.  I did make a request to create the release
>> > tags, but changes were requested by Fedora packaging effort:
>> >
>> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
>> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
>> >
>> > So the request was canceled, but never re-requested.  I'll fire off
>> > another request, with:
>> >
>> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
>> > manually add debug logic")
>> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve licensi=
ng")
>> >
>> > as the commits.  These match the Fedora requests, and the AEMU one has
>> > been merged into Fedora already it seems.
>>
>> These revisions have the problem I mentioned in my previous message:
>>
>> >> The gfxstream ref mentioned here isn't compatible with
>> >> v0.1.2-rutabaga-release, because it no longer provides logging_base.p=
c,
>>
>> rutabaga was not fixed to use the new AEMU package names until after the
>> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be a
>> new Rutabaga release that's compatible with these release versions of
>> gfxstream and AEMU?
>
> Good catch.
>
> One possible workaround is to build gfxstream as a shared library.  I
> think that would avoid rutabaga looking for AEMU package config files.
>
> But if another rutabaga release is desired with support for a static
> library, then we can make that happen too.

We're exclusively building gfxstream as a shared library.

Looking at rutabaga's build.rs, it appears to me like pkg-config is
always used for gfxstream unless overridden by GFXSTREAM_PATH.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmWruiwACgkQ+dvtSFmy
ccDA9A/+I8rO/+0RZI3GKhS6gZwVhJW1Gi0Pd2Wqk4zeyR1So8/Qdo9UsHRz/m58
4sPG9z9bSVWuoMsEVD4Q2uxAdYkstQ5SAO9kjgnzW0lNIEofC8ihSUywtqOcVTbc
Shouv8Kpp/AacFvim8R8k8C2zO2TsTrBdmGHiJw46DHsPwjYG/NM8/wb+Nw2jxDB
yrferjAGoDYslAG+rudmK46pUTg2cFSeLvIx3ULTUZNFnzPdUpUh+wmpC2+7rY3A
ipcC9BJwjbNnp1yOupGu/RHutaMuXsUlo6Q661p7iiWriqq6C1k6rq+A3hyr0/F4
+nC7+EYIsnDShSA6OGa/ZE2cKTvFBFV6ietScY1YHnM9iZ+8VVBKBHrzSiH+f1wS
IdWTSUcgowB/n3aW2C6gHoaaiA5fS/CmMUt38Ys8EqWLc1A1VA2J5IDTMnvOdxb3
yvWMyP2DaVRis2+EUchkGb6efWSUBIzTuW4wzK0yYfhWQqinGB68D24sn3GnBqRx
/iK1NXelxFrUnUmCJ3W2Fc8+N07I9ZDfyphGBamHEnEQCZr/6hdaFWtUNUeF4KeS
Y7zaW5fedXfGD0YgxiCGrYyzLenkWndUctx5uN4oCmrW54GVljMDNSKbfUAvryqv
s612Vl6VMoSaCw6gpDjifAYNsWeKHUg+evmoLPygsVBSL5X859k=
=ZQk/
-----END PGP SIGNATURE-----
--=-=-=--

