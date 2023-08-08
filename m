Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E1773814
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFrx-0005PC-KA; Tue, 08 Aug 2023 02:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFrs-0005Or-UB
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:06:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFrr-0001pk-6X
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:06:56 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 512F25C0196;
 Tue,  8 Aug 2023 02:06:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 08 Aug 2023 02:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691474814; x=
 1691561214; bh=Cs62rN7RYC1KmBS54m0hlh5W0rztFF7H6814zZGnUbs=; b=Q
 sQu3eY6cV8yet95WIdUMlsGyo7zBpo3WP455Bag+XaiGJUxmDyrxjAaahUEeq72M
 hJbcsEAAGtJonh8OaIKvmsLCyLUdhuie1iBYugm/SdgowAJud40mx17YOGk/hPG/
 EL5BmbvnAx4ondBaHXY6MJPkUg19yJfHt1Mxs3Nv1balOJlXrpYcb28UQgUqlmqK
 AHoL/u3lTGe9XuR78j40gl8ZAUWyNz0y6xcOTWN8HIFeUY45wKnfBa8aFS46gYDl
 8ToAwP9JoDmOrdoFeT4Zj4kKeT9UwFrjzx9aLl2aLJXkI1WQXoKD2ufWFE8oBltW
 YzXi34jhCIdKxVbaiTqYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691474814; x=1691561214; bh=Cs62rN7RYC1Km
 BS54m0hlh5W0rztFF7H6814zZGnUbs=; b=DGJtrMWzCh/ghwLfaUd2sJ5l/aj+z
 EQUF9gt+plNdBQFqpL+LXVqTUgGqbiki/iiHdvznRKcOEf9I9fKbtG2t6vXPfEOr
 zGhNFYVHQskxrLge0HZfYeh5ODjqL2jNhwZkJPrAXWzf1aEgGmoPge6E6lqmGEGE
 m550W0ly7kYL71JVrmOCiAG1tXXecsOkUKie2i9Fa+fzaWQRo9Wtol2o1V7M4GeE
 DZyLDBrgf9+VgeX4dc/lKdE85NEM61XdUQWbnEebcQ8jD/SroMSHiUrAfoc64cAH
 CKpv0T9feYFGUgfHTdXC0aMKdGmVSf3QoF63mv133FNbvllTv1FIS4TGg==
X-ME-Sender: <xms:fdvRZPPyt5ZMpqx2CLS_8YhoYdYmqaQcymbtLOFZ2bchkgRPV0u8ng>
 <xme:fdvRZJ_fkmqH95rcaTc5P1Kn7RgvrYZNSP5tzkztyfq4MHrepm-qKj8fRx8AxRe0A
 uQ8tRIs5v1uM0bKRBI>
X-ME-Received: <xmr:fdvRZORoZlWegwZtJdUGI5gOgCC9yoSVo7U5OnKusm2DTpLszOsHVbh99CekcCXLWRIpMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugddutdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:fdvRZDvt6g2nMAA9rFQOApzwa2Kc6RDY9y6jCYdBLU4o8HNil3yI-Q>
 <xmx:fdvRZHfI0RYbIiQkPYFg9rJP_-amxSUHFk8NJShda3j5LdebH5RBGg>
 <xmx:fdvRZP3gB7IdFKuqJogNE2PC1yJDSWc6pBQiBBtRTgaEijrcd9d89Q>
 <xmx:ftvRZD6J-mRbwlLKH3EGxHcFvGx6T7N9OzAMhHRY2ygB4tjPSVoHJg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 02:06:53 -0400 (EDT)
Date: Tue, 8 Aug 2023 08:06:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ankit Kumar <ankit.kumar@samsung.com>, kbusch@kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] hw/nvme: bug fixes and doc update
Message-ID: <ZNHbe6zZZKhJO517@cormorant.local>
References: <CGME20230807160836epcas5p34398954fecd7388469012404b09b78f9@epcas5p3.samsung.com>
 <20230807212745.70151-1-ankit.kumar@samsung.com>
 <165b8dea-9afb-3aeb-7551-9ecacb225fb0@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xD2Qx4dnKE2rGu8B"
Content-Disposition: inline
In-Reply-To: <165b8dea-9afb-3aeb-7551-9ecacb225fb0@tls.msk.ru>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
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


--xD2Qx4dnKE2rGu8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  8 09:04, Michael Tokarev wrote:
> 08.08.2023 00:27, Ankit Kumar wrote:
> > This series fixes two bugs
> > 1. CRC64 generation when metadata buffer is used.
> > 2. Protection information disable check for Type 3 protection.
> >=20
> > This series also updates the documentaion for pi (protection informatio=
n),
> > and adds missing pif (protection information format) entry.
> >=20
> > Ankit Kumar (3):
> >    hw/nvme: fix CRC64 for guard tag
> >    hw/nvme: fix disable pi checks for Type 3 protection
> >    docs: update hw/nvme documentation for protection information
>=20
> At least the CRC64 change smells like a -stable material, - the bug
> is present in, for example, qemu-7.2 too. But I don't know how important
> it is to keep nvme updated in 8.0 or before, and what the outcome of this
> bug is, to begin with. Somehow I think nvme was in preliminary shape
> before 8.0.
>=20
> Are the other changes also relevant for -stable?
>=20
> Please keep Cc: qemu-stable@nongnu.org for anything you think is worth
> to have in previous/stable releases.
>=20

Hi Michael,

Yes, this is stable worthy.

I'll add Cc: stable and fixes tags on relevant patches on the pull.

Thanks for the heads up!

--xD2Qx4dnKE2rGu8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR23sACgkQTeGvMW1P
DekBNAf/fHmPb18U3FU91SFwJyma70DlXFIO6g4l3FdSuNdnk9781L583ch3V+9p
0tQPWpTKnanoPYtM79ccPEV+tcKjTg+mFq+naKnBTS3RIzdgl5rO4iajsM8rhsAk
qoWFcmwU7DB84+DlYuR/9h38Vrt5DvyEhEQnoirNO13yhYtp71umjtEnLbK9vsla
bLkhtSLzoH9IhIBaajTU1URhWinKfmC7ZrsmK6gudXnBXdJBQ4sF8DPt4UdXyJmn
UjkwdhIUzzWTPvxwK79u8JDZcAEJGRMnTzTPs1PYUDUYrrd5mJw4N8EBD/jfV9Ov
QbUR4yzR6v55y5W8zPJ3tPZGYdy3pw==
=5hr5
-----END PGP SIGNATURE-----

--xD2Qx4dnKE2rGu8B--

