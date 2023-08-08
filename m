Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1AE773807
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 07:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFkT-0000We-Iy; Tue, 08 Aug 2023 01:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFkR-0000Ts-0f
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:59:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFkP-0008NA-FR
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:59:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 6F4745C01BF;
 Tue,  8 Aug 2023 01:59:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 08 Aug 2023 01:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691474352; x=
 1691560752; bh=/tY9ZA9n1Wic8xWLpr8z44YBoi7R0bBX5OK28oEHhZ0=; b=m
 9i9eUCAbBTrbPF/OAtI66VWOjOWJAUmry9Dd7hE/OiAu7cIc32stLVfNjMGfWOD9
 stmpO+5BivlzKqS6wytZ87rzXNadDQ4L0sXEtg1vwX8O4fkzgLfI++jT5OrI8KSy
 93dO0l4FQh15YqtRNpCxrXKh8mxuvyhLX8/5h/YP2TXVmH53DBPTPNt6cei4H6Pr
 gg/maOrC3Qq9eL+sppn3vsnHGFfh7t0C1CHtFoerNzLiO0jepBENZr8ZKDDBInSo
 eiWYSy2zVpMkNV74Xh5ZEDcTu1j/JdQm0H0uUIKxgO107Tm/O4+UuEJ9MaDhn8GG
 eVfNZxNOeXq+3NXGMQI+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691474352; x=1691560752; bh=/tY9ZA9n1Wic8
 xWLpr8z44YBoi7R0bBX5OK28oEHhZ0=; b=RcMXgs0jaY7dOYQemZjewhLQtF/cu
 LsLc4u9+qovrQbg6vUki7u0xW/RHOX2aqdY/SDA5ZlqY+lW5SayeU3xdT3RAQU1q
 /nC763hN/8dC8K2tUislnTY/EiVdTfLLS9Xzg5UlNoWJmAHq05vHQymh3SHfj/y7
 sg200R+UpOIfL7mmRP04MNE4B7bieIVASOFOZtWgeO653qxTnJo4DVGSaatZ5OBx
 aLkNyb2UHza8kJgPpLrJZoLTFTi0ZmLI1LypdpqKSEk+aFNFpJHTxj+REATw3LM0
 sIlg8yjkQon/qSkFm/ayrO9wtwoPNqIVpUJCU9WSsrdJHDLoxHeAMty9g==
X-ME-Sender: <xms:sNnRZJ3kWcSKlhRgFP26LhI-7v7CHwS8SZ9zrrYDAj1JvgCxWovpZQ>
 <xme:sNnRZAGBXYwadFNEbHoKcJM0ucvTFtsy7aT2RRvAvgUz_18BvCo1jmr30c6nMqRHy
 B5UqKqPIl3vUg35KIw>
X-ME-Received: <xmr:sNnRZJ4rA4jOmhrszCEkIuX3xPlXx_EoJFXTKt5g0f8CDZGttdAipTAcAEtv1Ty9l2lgmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:sNnRZG3yFEErI7riDFoYd4ZAqflHvh5FrOz2_83R1etLSpdtQLSmmg>
 <xmx:sNnRZMHqeMaQ41YoRPYFi0Ia4P0EB3T7O7WgNOgB8YGGb5V1ZhYOrw>
 <xmx:sNnRZH_2N201wcNkg1GEhiZ-eljQy-cqRI9et5uykrXWjPbMJ_OvBg>
 <xmx:sNnRZBQvFDkW9gu8j1lar-oOGHFPi1kJCF0JwyJtw6e5KlWWUhpBgQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 01:59:11 -0400 (EDT)
Date: Tue, 8 Aug 2023 07:59:09 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ankit Kumar <ankit.kumar@samsung.com>
Cc: kbusch@kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] docs: update hw/nvme documentation for protection
 information
Message-ID: <ZNHZrdFsSVa5DlOZ@cormorant.local>
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160839epcas5p3fc18f1e23b454a6db48de18c822ac2d4@epcas5p3.samsung.com>
 <20230807212745.70151-4-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o/AN4wJR8D3RzzFL"
Content-Disposition: inline
In-Reply-To: <20230807212745.70151-4-ankit.kumar@samsung.com>
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


--o/AN4wJR8D3RzzFL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  8 02:57, Ankit Kumar wrote:
> Add missing entry for pif ("protection information format").
> Protection information size can be 8 or 16 bytes, Update the pil entry
> as per the NVM command set specification.
>=20
> Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
> ---
>  docs/system/devices/nvme.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
> index 2a3af268f7..30d46d9338 100644
> --- a/docs/system/devices/nvme.rst
> +++ b/docs/system/devices/nvme.rst
> @@ -271,9 +271,13 @@ The virtual namespace device supports DIF- and DIX-b=
ased protection information
> =20
>  ``pil=3DUINT8`` (default: ``0``)
>    Controls the location of the protection information within the metadat=
a. Set
> -  to ``1`` to transfer protection information as the first eight bytes of
> -  metadata. Otherwise, the protection information is transferred as the =
last
> -  eight bytes.
> +  to ``1`` to transfer protection information as the first bytes of meta=
data.
> +  Otherwise, the protection information is transferred as the last bytes=
 of
> +  metadata.
> +
> +``pif=3DUINT8`` (default: ``0``)
> +  By default, the namespace device uses 16 bit guard protection informat=
ion
> +  format. Set to ``2`` to enable 64 bit guard protection information for=
mat.
> =20

I'll add a small note that pif=3D1 (32b guard) is not supported.

Thanks,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--o/AN4wJR8D3RzzFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR2a0ACgkQTeGvMW1P
Den3CQgAtVtge8cR4MS5xtOe+rqrqajM3rgacTdLjE3YL5qW8FmUdEGDCxBKDrUh
9zp88O4H7TJSooJtmZIaY2IwPb8YGtmXiocHweMMr7HhSxSEkjdBTvX/oNlxzUgP
0KIfyzOur1GEsX69Ur58ZG4FQvISYJrkmvYNUmiyjX58ruWYX00elf/Tjd1YDn1A
D4rhra0l0SEUaucBV7KCG/VI0NRecV7BU2uia+WLey9WB6K2M/ShtAyW6ldECGoH
gDuo/utResY2UJW91Ql3vF7pPj/XIxcJscad/YRpgRjayndV8ZjfBWluD4NvzIgU
SNzcwv+pT5aAFdH8++s4hEYx2hCPfw==
=7QyV
-----END PGP SIGNATURE-----

--o/AN4wJR8D3RzzFL--

