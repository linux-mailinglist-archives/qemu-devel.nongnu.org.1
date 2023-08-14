Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9C77B21D
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 09:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRiI-0001BM-9n; Mon, 14 Aug 2023 03:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qVRiA-0001Ao-Dw; Mon, 14 Aug 2023 03:09:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qVRi8-0007jw-31; Mon, 14 Aug 2023 03:09:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 37F325C00B1;
 Mon, 14 Aug 2023 03:09:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 14 Aug 2023 03:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1691996991; x=
 1692083391; bh=sKAWYncJ++DoKKA9stUcoPxMx8+FQwVzE1u3F5G771A=; b=T
 6Ty987uhAAZaB9ifWbDjlGVH1Xm0cqEr3DVDvffGKRMn/OOSduNJqUWZ+qH+poe7
 9IqTvHoPa/SYqzV1eboXK+BNMNhBE8h73IV6pk+FaosOZHKSsyRh/1G60RN3ucOF
 ceNKZEJcFnVsMKMJieiJSRzXyrBGk3bTST06yFRbEm95KYw3/Gqdlv8omlSZvCe1
 bIzmxm83Uh0lWjtdlHx1ivw8hbadHftgnyuteEDY6A1uP3Y2ZAh3Xc70YuexK5RE
 qvfWLdQ/j6NFs5HnkhLCryTPKoW01kd3Ty6n+YbYuyJ1tqotGRMNJu7iObiT6kG/
 TOaSW+J3jPg7uh32T4HVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1691996991; x=1692083391; bh=sKAWYncJ++DoK
 KA9stUcoPxMx8+FQwVzE1u3F5G771A=; b=oNuPoQ1rB+OGSkpFJfY4TuYcoEem9
 iRJS3VWD/w6/IfR0AVdxdE8pQ38ASzXM/yrTsRYd6bif+MA+HUMpWHVMmVL9KjyL
 8Q9yAW9Wed0YBDRm01RcqomjW7fvNcZQKriPGVjY8usJ4/Mua6oQKq3Vwkw46HtS
 UxjhEeO6jqu40i7hjsN/zPuk6w1RU6IpN1UiE+xYGZ1ulsn6XXJYwAITxT7pNUjt
 bxPFgIRoiveBGvLVEIUznJ3gGwarZiY46GIb3uL295V0hVuMEtQk1OPPRwktRKmp
 1juI9fFwVEGM+p2v/qx/ye30g7TH4v+0TVa8pxL9pb2L2E5AbzbHE0sqw==
X-ME-Sender: <xms:PtPZZH4cdkeI2PyAEm40wCg5gQrG2_t5pl64ZunFpo5FH5h0zmv89A>
 <xme:PtPZZM5xAVuf9KyJr2knoD-4DWXmCUXDmKYdidwjQTAi_ePQfycTjneCwNQIOMh93
 95XQaOmWdu6V7ibO-c>
X-ME-Received: <xmr:PtPZZOfgJJH7rFxpnM9BLETGtZVuhDkLsIo1KdQoO1-WiBK5Iz3NsYgXZFzIuqgO0r6LuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtfedguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeeugfefleelfedtudekvdejteejjeegkeetueekfeffteejtedtffduudej
 ledtveenucffohhmrghinhepphgrthgthhgvfidrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdr
 ughk
X-ME-Proxy: <xmx:PtPZZIK4mtqnWU_6HJPlpiUTN7cJKq1WftSNvw531CMk6PGJcr3M-A>
 <xmx:PtPZZLIfwSWWj-eQd5no8cZswZ3CbgtPczzgSKZTyVTMDYI0qge84A>
 <xmx:PtPZZBwHs6rOLVgAbKKN5Dwm-uG8yYLhEi1kOKMY8oGvnU8WVSaUig>
 <xmx:P9PZZIErVVHZ_jzg8ric-e2zK_QvmYiRXHGuPQV1P6onM-pHOKqa1g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 03:09:49 -0400 (EDT)
Date: Mon, 14 Aug 2023 09:09:47 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: avoid dynamic stack allocations
Message-ID: <ZNnTO1qnA308CUtb@cormorant.local>
References: <20230811174751.784620-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DvsWgJHTaeqECF/a"
Content-Disposition: inline
In-Reply-To: <20230811174751.784620-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--DvsWgJHTaeqECF/a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 11 18:47, Peter Maydell wrote:
> The QEMU codebase has very few C variable length arrays, and if we can
> get rid of them all we can make the compiler error on new additions.
> This is a defensive measure against security bugs where an on-stack
> dynamic allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
>=20
> We last had a go at this a few years ago, when Philippe wrote
> patches for this:
> https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/
> Some of the fixes made it into the tree, but some didn't (either
> because of lack of review or because review found some changes
> that needed to be made). I'm going through the remainder as a
> non-urgent Friday afternoon task...
>=20
> This patchset deals with two VLAs in the NVME code.
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (1):
>   hw/nvme: Avoid dynamic stack allocation
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>   hw/nvme: Use #define to avoid variable length array
>=20
>  hw/nvme/ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.34.1
>=20

Thanks Peter,

Applied to nvme-next!

--DvsWgJHTaeqECF/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTZ0zsACgkQTeGvMW1P
DenwAggAt+yE3gYqmygNg7mhfNJzwvKPslcMwGcSuT+g7+1XS/0Mxp/dXBb0rppo
c21GLXInKa+IHQWyVP+k3Tis+aaxqtYvQ+Em1f0lRXz73BTVXxNDRqTWHzbu988c
WtIeft9CIBJheQN0ipAz2WITZHN+LO71zWLPPi5zhbDbWeiyQi+6gWT8AgVg2vy1
o7Nuod87JG8lrrfLpCYh5NLGDYWyGs2GfbfS9ZYiHXbAckBq4GJ93A77fjl1m/0m
Nxgg9QwuV34q5lO4+Ub/LcEhIqtoHkAFu3uzinWGywwzxt71hq3vrm8FFZl9cd3K
7+fEjT+rU6r0iXeMnmahzpuTUoq2KQ==
=xbtf
-----END PGP SIGNATURE-----

--DvsWgJHTaeqECF/a--

