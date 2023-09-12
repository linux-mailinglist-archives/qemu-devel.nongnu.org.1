Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E9579CAAB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfz9S-000670-0q; Tue, 12 Sep 2023 04:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qfz9P-00061M-S1
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:53:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qfz9M-00027K-Ei
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:53:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0F7615C023A;
 Tue, 12 Sep 2023 04:53:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 12 Sep 2023 04:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1694508810; x=1694595210; bh=3v
 CEM+mD1XErZvAUf+X4qJF5ALIdOdJiS2lCqkUSsvk=; b=EBrQ2T5vEcpfMTAHNa
 q1ywCfZVnaaploxKJU+co9Wq24//fmFSs4vyOSQ6+myGB0bbSzluSV2UhJOt9p1T
 Rr7118pptfb/GicEuy5pQ5VQcPb05G64kOO5+HaOqXPe8fCXbzSCzAqJRtoHGi4v
 Rr97+Nhn6OJyC2fEAJjGvV0tLoG1q3T7czwd+49vy0JVJPgaKtb8rtq9Ex8YtReo
 bw686Jvp/LA3UiARCaTKcg1D0sloMFiFFyaZQ55e/ilrMilZmApACjpcoq4aON2P
 0CNRxxaXaB3RcXPkichBJaVzAYLALOpxH4seHTu71XCT2BCU7Q5XD9kL65lD6+A5
 Bd9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1694508810; x=1694595210; bh=3vCEM+mD1XErZ
 vAUf+X4qJF5ALIdOdJiS2lCqkUSsvk=; b=fwn9KAjaIvhnxw0w0KsSD+P9dUcxP
 Gw8627UMzU9jSS5VZ8mPnbmdoaSIhAOxD7uqplT8E+if2+QYBcQyVhTcc1tnZrE7
 T0lIlUZz5axFUevN5JhAo8Imcg3Ox1bryqYbccQEwdZn13yeQuvm35FGDVO+1FWO
 pAMcIrh7SX8C+RtRS3nyKI15sxADR6mKzXeOwcnGEVlGGkTk20dVcfjI0+aiWk/N
 DUQitJfGgeUUcMpBY1IOSoHkg2wBdcUJZAt/ZKjB5NOTDshF8wNvkW9VtMZBAsDf
 XPQJjICW4XechDROHFCh+h8z76dN2dHgGksM1LbLhBnH1CLnnGwU5edEg==
X-ME-Sender: <xms:CScAZcGFdU0q5dhzil-AVfxjHEqlFRLvCQ9ZnoaAJaKLKJbk-RohCA>
 <xme:CScAZVV1F4WSK6Lk1Y-naRfAmNBqcJDJ2kaTEzrx0iBCIHqpnhdlcqcr4d7zY4S6r
 hYP_G-x0xlFigZziA>
X-ME-Received: <xmr:CScAZWKrI5ZF9Zn6t7xG68j_QyEFKci0JANX8O118GSdWfMJwwOdzv5A7uE3oXpu_k-ydNTJqYCRvty3xSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehte
 dvgfegvdeggfehieefueejieeffeevgffhfedtuefftdelffelveeuhfduhfenucffohhm
 rghinheptghrrhgvvhdrtghomhdptghrohhsvhhmrdguvghvpdgtrhgrthgvshdrihhone
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegr
 lhihshhsrgdrihhs
X-ME-Proxy: <xmx:CScAZeFwZThNlStMyKeudD_7GeJOydc1IRfzC8k8fLNOvSEKxewt2w>
 <xmx:CScAZSX6SpBOu3ock9bROhJ3pS0V0jMM13mAZMsOJQi_wXef7t8ASw>
 <xmx:CScAZRNcrP28iCpbkVrdVyRJN__ThWN2XES2MICieraKUmNdrmihrg>
 <xmx:CicAZWowfAbkfOczE_ZyaS-NQJJIINxlGfDgaQbJDByZ8eUgjuGVMQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 04:53:29 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id DA19C85DD; Tue, 12 Sep 2023 08:53:27 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
 <87v8d2hqdu.fsf@alyssa.is> <87sf86hq0x.fsf@alyssa.is>
 <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
Date: Tue, 12 Sep 2023 08:53:25 +0000
Message-ID: <87jzsvrcvu.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.27; envelope-from=hi@alyssa.is;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Fri, Aug 25, 2023 at 12:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Alyssa Ross <hi@alyssa.is> writes:
>>
>> > Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >
>> >> On Fri, Aug 25, 2023 at 12:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> w=
rote:
>> >>
>> >>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >>>
>> >>> > On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is>=
 wrote:
>> >>> >
>> >>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >>> >>
>> >>> >> > - Official "release commits" issued for rutabaga_gfx_ffi,
>> >>> >> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
>> >>> >> >
>> >>> >> > - The release commits can make packaging easier, though once
>> >>> >> >   again all known users will likely just build from sources
>> >>> >> >   anyways
>> >>> >>
>> >>> >> It's a small thing, but could there be actual tags, rather than j=
ust
>> >>> >> blessed commits?  It'd just make them easier to find, and save a
>> bit of
>> >>> >> time in review for packages.
>> >>> >>
>> >>> >
>> >>> > I added:
>> >>> >
>> >>> >
>> >>>
>> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-p=
otential-packaging
>> >>> >
>> >>> > Tags are possible, but I want to clarify the use case before
>> packaging.
>> >>> > Where are you thinking of packaging it for (Debian??)? Are you mos=
tly
>> >>> > interested in Wayland passthrough (my guess) or gfxstream too?
>> Depending
>> >>> > your use case, we may be able to minimize the work involved.
>> >>>
>> >>> Packaging for Nixpkgs (where I already maintain what to my knowledge=
 is
>> >>> the only crosvm distro package).  I'm personally mostly interested in
>> >>> Wayland passthroug, but I wouldn't be surprised if others are
>> interested
>> >>> in gfxstream.  The packaging work is already done, I've just been
>> >>> holding off actually pushing the packages waiting for the stable
>> >>> releases.
>> >>>
>> >>> The reason that tags would be useful is that it allows a reviewer of
>> the
>> >>> package to see at a glance that the package is built from a stable
>> >>> release.  If it's just built from a commit hash, they have to go and
>> >>> verify that it's a stable release, which is mildly annoying and
>> >>> unconventional.
>> >>>
>> >>
>> >> Understood.  Request to have gfxstream and AEMU v0.1.2 release tags
>> made.
>> >>
>> >> For rutabaga_gfx_ffi, is the crates.io upload sufficient?
>> >>
>> >> https://crates.io/crates/rutabaga_gfx_ffi
>> >>
>> >> Debian, for example, treats crates.io as the source of truth and buil=
ds
>> >> tooling around that.  I wonder if Nixpkgs as similar tooling around
>> >> crates.io.
>> >
>> > We do, and I'll use the crates.io release for the package =E2=80=94 go=
od
>> > suggestion, but it's still useful to also have a tag in a git repo.  It
>> > makes it easier if I need to do a bisect, for example.  As a distro
>> > developer, I'm frequently jumping across codebases I am not very
>> > familiar with to try to track down regressions, etc., and it's much
>> > easier when I don't have to learn some special quirk of the package li=
ke
>> > not having git tags.
>>
>> Aha, trying to switch my package over to it has revealed that there is
>> actually a reason not to use the crates.io release.  It doesn't include
>> a Cargo.lock, which would mean we'd have to obtain one from elsewhere.
>> Either from the crosvm git repo, at which point we might just get all
>> the sources from there, or by vendoring a Cargo.lock into our own git
>> tree for packages, which we try to avoid because when you have a lot of
>> them, they become quite a large proportion of the overall size of the
>> repo.
>>
>
> Ack.  Request to have a rutabaga release tag in crosvm also made, should =
be
> complete in a few days.

Thanks!  I've found the rutabaga tag, but I still don't see any relevant
tags for aemu or gfxstream.  Any news there?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmUAJwUACgkQ+dvtSFmy
ccBvZA//ZCdWEGZVmGEz1C0AxOO6S3vBM9MpeXBlulmEJQYHY6qVb8MQJjHp5IhM
lCBzIcjCnEIyNvv3f7Q3MJHPLR3Hb/3L8bkD0dXHvCxqfnOTgJV7W6mAEwIhkBum
K1C0ks2ziWijZaIsc2rYopGxDkszlu5XNS6jCMZ3HDbDxnl8AMQQMrvglPWkRhZq
DWkfeCJMUIm5ARQlY7SRLK0P35oauN184YsM6TUqxETKviCir6P1so53wx7srY/g
C7CteeMoshAZ8zQu/DsZGl1LByXO+ERkbd7Rp1MOIchCKTPc2+brFiiPpj1peqid
hUMQDA4zNoYiHibv8l0S5pOYSfsAbrZ4yGTh+ucFNIOtIvGNvAq7PwXsYJ2AcE62
Q7YZv2kZYnQDVgc1F0uqQVymcYhGijur7E8AD2tJ45UYl/Ib3tHv//6dzORM4He8
Y2aCcf1/Qk97H5m9wfTKOqTjAc5bdVhoKMWguZWfaZe44jx+eRBMI9L9H5tD+7nx
K/0CnfQDeBdSpTGXCso5SNfGH3MpBVe4xZRd7593T8Hj+Z+ZIApnvDfkNy0tOoAO
Nk7GzKS5ZGS0fH0iWxAXNTzaae8rIgE2L9gB42WjFIdLojiBfjRkfUqqOxcgk8kx
R3ubhGcbb005jdDMI94xOmb+TgUuK1DOgfhJvwfWPu1BG9yJz28=
=6eUk
-----END PGP SIGNATURE-----
--=-=-=--

