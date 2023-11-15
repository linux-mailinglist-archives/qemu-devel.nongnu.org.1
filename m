Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802F7EBF7F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 10:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3CDE-0000sJ-9I; Wed, 15 Nov 2023 04:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1r3CD9-0000rW-Hd; Wed, 15 Nov 2023 04:29:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1r3CD7-000105-A1; Wed, 15 Nov 2023 04:29:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 526975C00F2;
 Wed, 15 Nov 2023 04:29:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 15 Nov 2023 04:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1700040561; x=
 1700126961; bh=GOaj9AnavObB7WgflEEL+BH64lAUfd3EvE0m6JWvJN8=; b=2
 C+/d/ThFfigpFt6vsPpVA1mmg29th36dUVQ1PGWOve5MmjGFTKkI0EUladgtjfeA
 s/pvEuH+I1bs9T3PdYTwZ9nzgDDrTbBcl++E1vCnW7eZkPOb31RMEBcs4zkMbsox
 YLOQvHGrKf3bgYs48nb/MOAAiKWmA3s07imYr/OkLLnmhElS2u/40HF0h/rPWQVB
 +Psg7jLLjn+Pp4UhEnIwMtFQZ61UpGkc5FfQWWJiwfpLE8IGPjIDg/ZdN8OoLsNx
 GHNbkYrIHddiDXHkrEvq/vRkho4NyzeJT3QkZ6W1G+gtutTkEMr4LIGfSnKsQF2h
 gaT6Hk2u3NQllIiKTviNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1700040561; x=1700126961; bh=GOaj9AnavObB7
 WgflEEL+BH64lAUfd3EvE0m6JWvJN8=; b=zuOY/jwXesn+c3fFkW3WQ8ts6/xsI
 enpmCQUzpfoAD1JmoRmQ2OgGziTThFwDjrenANLekAd8gEqzShsGnA1zpEyJITAL
 bfwQVdPbsasADeClOISpqrI0W7m3B3It9QBXjNvhSY8RS9s6BeHUstSizfS75E60
 aRPWasMg7Pdki+DxCgcXTdgstc5Exw4uD2yxdHsdmp+9JPYYC+nqrmuzHqiXu1Pj
 lhGcm1fJkaONRcFusYKGyJoHJetWMIqkexogaZsb/nR7t3/X3p28irXYcZzLh+am
 Lw9xKVGkxiItDxyeoyUNBGh+gpXcMhOYzsxblWpLjh2lScraT6ULraQLw==
X-ME-Sender: <xms:cI9UZckjtOyjrkARc2MNM_EZkOmkEWJiOrrSzqWjvB62mcMhIt-j9A>
 <xme:cI9UZb3uGzSgBO2LjHVIB5WBN9FZSkMEjUoLR2MawJmf1Vd_Pr3GZJ_zw_e20_SvE
 7BSNxiDLX7Ad5I7pfY>
X-ME-Received: <xmr:cI9UZarM_jsHS_Nwl9UR8132AnOLsX5mjz9oYNxbQzSU1b1IA1n2ulumwgPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefiedgtdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:cI9UZYlM-dQnJWaWLeU2DV1P3vHXeciy8MfiGQd82ECzB4PSuNsV_w>
 <xmx:cI9UZa1weEHUkGd317VbyTbTIFSZurpgxKXUsKu1godvy27M-_fgXg>
 <xmx:cI9UZfsD5nv0zNbxZAt7d2SlDKfd0fFk1a3QXe8vk0iy_4jK07zx2w>
 <xmx:cY9UZd1j0WZods9JZRw0RWNidmAlL9s1BKSb6kbYavA_6z2XPp2csQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Nov 2023 04:29:19 -0500 (EST)
Date: Wed, 15 Nov 2023 10:29:14 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Alistair Francis <alistair23@gmail.com>
Cc: cbrowy@avery-design.com, wilfred.mallawa@wdc.com, mst@redhat.com,
 lukas@wunner.de, kbusch@kernel.org, hchkuo@avery-design.com.tw,
 Jonathan.Cameron@huawei.com, jiewen.yao@intel.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <ZVSPam_DHGkncxQz@cormorant.local>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
 <20231017052155.173577-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="utY7QJTzuslh8Jp5"
Content-Disposition: inline
In-Reply-To: <20231017052155.173577-4-alistair.francis@wdc.com>
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--utY7QJTzuslh8Jp5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 17 15:21, Alistair Francis wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Klaus Jensen <k.jensen@samsung.com>

I have no problem with picking this up for nvme, but I'd rather not take
the full series through my tree without reviews/acks from the pci
maintainers.

--utY7QJTzuslh8Jp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmVUj2kACgkQTeGvMW1P
DeldJAf+OhBi9sTXsqiGuPcXnibQMwaqddX7G/SClSyfR5wlZAolQRiC2qCst6YG
ybqo51cBA2wgZkIFPes6hN8vwOoZblUB7Ng/GzmXUNaI2CEK9FpRql+XswDr9ICk
4FAMOKWXbdh77lfNMb3Wu1z9zRZXHMrPm3Rqbb1qdVfqwNnqZV8K15OcRjRSCDp2
QHOBtq5pXNy0C01EGgl4u9sRb+W/THQDFnSP8GVNIjTVTmV4Rj8TE0WBSKaoRyh/
L/wVo/0b4bfUKsTwBwntlsCkX+RuXVBPqocRlgdzjXSJPCtXUuDjA3/UVQFfAFKX
GWbuWywtl8tzTkwebsfPHgD33lCx3g==
=qavD
-----END PGP SIGNATURE-----

--utY7QJTzuslh8Jp5--

