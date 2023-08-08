Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC480773805
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 07:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFjd-00080r-NU; Tue, 08 Aug 2023 01:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFjX-0007wR-GY
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:58:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFjV-0008Bq-B1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:58:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id DF83D5C01B3;
 Tue,  8 Aug 2023 01:58:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 08 Aug 2023 01:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691474296; x=
 1691560696; bh=HEiqUt6n/yAHTXpImqh7LgQw/1rlcAnBleEWop8NAcU=; b=a
 SIGUq8Ti79u7PvkUyhxRLtgsKjXOQNoM0bLw8+6T9OKuvU3k3NaGlRti2mYu12mW
 bdkg0CeYxJj/ptzRW9AVjRfUBvIvG5H/yglswMJcoF2Y8m5EWMmqfG+l3GmjJ8Cc
 Mj8WnZo2vj5R57KgT8q5OzN9XbnUQIQtLDI5im1BI0VQIzuSVyCUk68+OyuQi01C
 qDY18wxchuaO7KR8SF9V3wBF7qI5U2zyAhxxP17K0Ju1kbrFPcxlv+Gi8WVS0sri
 jHDwEg6Kkn53Ar1Rr6uwIixG/qU409s/fQX9rcJtkEs8TVhH7lCaF2dZ1er1UG87
 nydaPEtOFnXX5Yw0pz/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691474296; x=1691560696; bh=HEiqUt6n/yAHT
 XpImqh7LgQw/1rlcAnBleEWop8NAcU=; b=Vi+ErbejbSxoUODcW4BEdbuc6b5CL
 JtazWf3yZEwARRRZUft2jBLTmmTJhkFOU+QyLyXJb8rojuAiF0FOGqPHIsk8eng6
 egBrckoTAV/53mY/0oFFwS99OOvbS7jslxK1Rr408BmnpFbeUNGN+3XVG2a5QlY7
 1Chx1O4VvLFySnjQjICJGjPtO/WFN1ixOSuubzI7oLhGJN/93SlEYGVG5oxBa1tw
 g1eyvnhqBaDOkt0McqV3tYs4Uc5ymGWLPY/XTwXFEZXo85KRIAJ3BA2OdLI+FWfZ
 1xFhzd8xA+vQuIMY06E1sg9lDIX8rBN44M7jbewtG8qSOyhruGKvKnOCA==
X-ME-Sender: <xms:eNnRZFN1tq5eyQPoZX9Sn3zGpvmOe5Rol5bgApA00KmJgckwB3z28g>
 <xme:eNnRZH-ikrs9a-cXn4-JKFWL0K2TZsZWJLKFWU6pEwYcAN6DkvKgpFyV8SkPBbSK2
 Y_2us4ZLibo3WZ8Rts>
X-ME-Received: <xmr:eNnRZESi4YGfOK7lwgrXD-sVLWv-IA4MMutgIC51bkr9KZwY4TKuBFx9mLBpGa7A99PJIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeivefffffhledukeehhfetueelkeffudeuieektdegtefhgeefleeiudelveel
 keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:eNnRZBubbtgVn7B6-AcjSEiWlmDdn-hjRKiwn5HwLpn5FCBvL9EqWA>
 <xmx:eNnRZNcQmikwFdxEYcZKL7IcldqIPKPGUbAVasr8rKt5Mgg8MgtQXw>
 <xmx:eNnRZN3x1JoOlOo9es0iblhqp-z_kt_Cj4OfQNViFfCeGmlp_pn_HA>
 <xmx:eNnRZOrBL8KPoEBIf03H3YOeDye16PMMcu1SLuO_hsI5CUMDS1o81g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 01:58:15 -0400 (EDT)
Date: Tue, 8 Aug 2023 07:58:14 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ankit Kumar <ankit.kumar@samsung.com>
Cc: kbusch@kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: fix CRC64 for guard tag
Message-ID: <ZNHZdoYnoFegAyRj@cormorant.local>
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160837epcas5p3b360bae29265c0851f13491952b40f38@epcas5p3.samsung.com>
 <20230807212745.70151-2-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9m/x2lvMcl+Rtdja"
Content-Disposition: inline
In-Reply-To: <20230807212745.70151-2-ankit.kumar@samsung.com>
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


--9m/x2lvMcl+Rtdja
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  8 02:57, Ankit Kumar wrote:
> The nvme CRC64 generator expects the caller to pass inverted seed value.
> Pass inverted crc value for metadata buffer.
>=20
> Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
> ---
>  hw/nvme/dif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
> index 63c44c86ab..01b19c3373 100644
> --- a/hw/nvme/dif.c
> +++ b/hw/nvme/dif.c
> @@ -115,7 +115,7 @@ static void nvme_dif_pract_generate_dif_crc64(NvmeNam=
espace *ns, uint8_t *buf,
>          uint64_t crc =3D crc64_nvme(~0ULL, buf, ns->lbasz);
> =20
>          if (pil) {
> -            crc =3D crc64_nvme(crc, mbuf, pil);
> +            crc =3D crc64_nvme(~crc, mbuf, pil);
>          }
> =20
>          dif->g64.guard =3D cpu_to_be64(crc);
> @@ -246,7 +246,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *n=
s, NvmeDifTuple *dif,
>          uint64_t crc =3D crc64_nvme(~0ULL, buf, ns->lbasz);
> =20
>          if (pil) {
> -            crc =3D crc64_nvme(crc, mbuf, pil);
> +            crc =3D crc64_nvme(~crc, mbuf, pil);
>          }
> =20
>          trace_pci_nvme_dif_prchk_guard_crc64(be64_to_cpu(dif->g64.guard)=
, crc);
> --=20
> 2.25.1
>=20

Good catch, thanks!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--9m/x2lvMcl+Rtdja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR2XYACgkQTeGvMW1P
Dem1IQgAn9GVcV8Zln736YATNirULoHqz8GaOvobtiECy4aUqTL2ffrNZAhFuA0e
O0kOzyUJvacGhdNZR7UgMp4SSdbSWWzFs6TM6SYYWNCP/B9Gp9nSsSmRlsU6Ckqw
FyPqgsBWQOinGqq09wIFoZoqAqOeHYdpZOJ5fzCkxSvoCcZ8zLSppnW79m9Ldp9h
jtUPj/dSZLNHXzPE1kLLaSUBlARqWXHUYhXknCRlILkGEftgXOodfII2VvUaUYcw
WMc5dWf6o21HdVLzvGBs2U7y92tD4keOtGZbQ7ewVWy2EK7wWu6zKs+IBvwDWdh6
EU9Oc28Mn9otojelbQ4zAlbnN1jxyQ==
=+ZbU
-----END PGP SIGNATURE-----

--9m/x2lvMcl+Rtdja--

