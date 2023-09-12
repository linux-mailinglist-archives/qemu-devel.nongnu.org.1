Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C379D373
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4Fb-0006u7-4p; Tue, 12 Sep 2023 10:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4FS-0006oG-CE; Tue, 12 Sep 2023 10:20:17 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qg4FL-0002mZ-Fi; Tue, 12 Sep 2023 10:20:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 230DA3200914;
 Tue, 12 Sep 2023 10:20:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 12 Sep 2023 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1694528399; x=
 1694614799; bh=WXtB205key1X9HYIhGAfzoYgm+//OLY9xZBfMw3iEBc=; b=m
 8TE7AFiKtt6xVVo2PU8YbV03CacGPRiNK7TyyWeS7gPuuWShiW2JoXKzIVBalC0z
 EzMplJ7OcCj+7y35mJ1B+idqmsqJTltj/u8WFZhk5g7azc1QlkNPq9K5pgFHOrDO
 LtfMffvQi2pmVo4sZ9hqmokDESTAK/qfVi9vQG7s7JE4UzM7nP1pCRA0d1+hRI5h
 TgytJytJoviFcU5pQq3drLxgckpkTe9NJNkcLasF3qqXUNZOsu4DpEs0oK4UC/GI
 OAMMDPwF4xSzr596q/dIcHJv1LNds9ydqPzzdKKLT5FrSkUg1FzbBWj3u0ISuZvz
 wJTZJTcwLjnzPP97EucEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1694528399; x=1694614799; bh=WXtB205key1X9
 HYIhGAfzoYgm+//OLY9xZBfMw3iEBc=; b=RET7MJDx6NG1LGxmfS3ZniGf01pLF
 1S6k2vdJRYbmtdircRxPnvdOyJdLCPlZZu0qjLXxxyio+gzCMnRY5Soq4UdOEW6q
 Pc760oEJ9SUFLayLtIWLOakYf6IhDpPmrQEEtFOeBjSoEuMQH/GQuJrdwG9u5jDg
 WirG3zETpzF2RHuUWlxYbfBCfQiSI1k8fQ65lIaDp4LBwhYIjZCJGUATGRPIPsbS
 FzMGzCLwQUk+kmQ9vXOeJ3C24VeIeWSyJxjXpIuon3QRLVAzbdsX5evvOEXYipEr
 7Pnd8ilD5/Gz8GJdpy5eWbqYCcZXHbUsgGjuOSOmHglnzbXl1f03ya2+Q==
X-ME-Sender: <xms:jnMAZReaXzANbPFq3G5rnTd3_yNawYtFi3wr_8UUh5ayCgCdrEcrMw>
 <xme:jnMAZfNhT8TUDfEfi_tqCB2Ocmy5X7Lv1iLZqm8xTEdEBARVev60JyIaFi6OBXj8q
 K5KXXMVdl8Z0xa0xVQ>
X-ME-Received: <xmr:jnMAZaheMeXHufSmdY5hE3Zrcynq6KudD3RSpv2N1P6msOdigYb6qQ-bWNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgjeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepuefgfeelleeftddukedvjeetjeejgeekteeukeefffetjeettdffuddujeel
 tdevnecuffhomhgrihhnpehprghttghhvgifrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgu
 kh
X-ME-Proxy: <xmx:jnMAZa-p0yg8D7Ai8vypgu9kojiTqnxovf4aqYQ31HKbcLwdP-6nAg>
 <xmx:jnMAZds9KvgLYXnuH_Wpk4PyxkcNMd7-z54A7-3wkiCkrGM83eF9Ow>
 <xmx:jnMAZZG0WQ58rnb-hQhXxGu_OFPJcAUzWnsXrtmstqbT9iXlI13oWg>
 <xmx:j3MAZXINHkg2aZByUYV-Tud1wGtialuMt88B5sxHsHUhph7E3Wyz7g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 10:19:58 -0400 (EDT)
Date: Tue, 12 Sep 2023 16:19:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: avoid dynamic stack allocations
Message-ID: <ZQBziO0GX1AJ6eFt@cormorant.local>
References: <20230811174751.784620-1-peter.maydell@linaro.org>
 <ZNnTO1qnA308CUtb@cormorant.local>
 <CAFEAcA9LZvwceR7973Vz=p78S8CMUja-zhEdjB9MfKeCs8qvWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1sWFzu3aLXKQsTTA"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9LZvwceR7973Vz=p78S8CMUja-zhEdjB9MfKeCs8qvWA@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
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


--1sWFzu3aLXKQsTTA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 12 15:15, Peter Maydell wrote:
> On Mon, 14 Aug 2023 at 08:09, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > On Aug 11 18:47, Peter Maydell wrote:
> > > The QEMU codebase has very few C variable length arrays, and if we can
> > > get rid of them all we can make the compiler error on new additions.
> > > This is a defensive measure against security bugs where an on-stack
> > > dynamic allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
> > >
> > > We last had a go at this a few years ago, when Philippe wrote
> > > patches for this:
> > > https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/
> > > Some of the fixes made it into the tree, but some didn't (either
> > > because of lack of review or because review found some changes
> > > that needed to be made). I'm going through the remainder as a
> > > non-urgent Friday afternoon task...
> > >
> > > This patchset deals with two VLAs in the NVME code.
> > >
> > > thanks
> > > -- PMM
> > >
> > > Peter Maydell (1):
> > >   hw/nvme: Avoid dynamic stack allocation
> > >
> > > Philippe Mathieu-Daud=C3=A9 (1):
> > >   hw/nvme: Use #define to avoid variable length array
> > >
> > >  hw/nvme/ctrl.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Thanks Peter,
> >
> > Applied to nvme-next!
>=20
>=20
> Hi Klaus -- did these patches get lost? They don't seem to
> have appeared in master yet.
>=20
> thanks
> -- PMM

Oh. I never sent the pull - I'll do that right away! Thanks for the
reminder!

--1sWFzu3aLXKQsTTA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmUAc4gACgkQTeGvMW1P
DekeXgf/VJBz+Px3S16CZftFg9PP09TC25B9jG3etX7JWRLf4moqVvKjybvjjK7L
kTZQz98sbqOW3MnCxyfyLU9WfucAEGq/5W9qYkEVHkAAMeFGeSyFYXltndkfXzD9
4XKvVyiysyILg71K6EvGcB+anGQETIL74LexZGkRdZX6F+LZ8RlnPbZTggcz35ht
0S3K2/LczgOoCMrOcmBi7bc+crI9rC0BYCAKMXT/ItBlItpYvMBo73PSW59LJdfS
uRUMPrppTUHLVkpn/OcG8sMtyfJj4ZWyIEJFA8LXoJqWtty17ZEiTBVCA0DeuWb+
c705Z1mKYAU0iAJvYwcxmEMip3qlJw==
=WD0j
-----END PGP SIGNATURE-----

--1sWFzu3aLXKQsTTA--

