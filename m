Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DE773806
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 07:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFjC-0007or-FH; Tue, 08 Aug 2023 01:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFj9-0007ny-LD
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:57:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qTFj7-00087j-KK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 01:57:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id D638F5C01AA;
 Tue,  8 Aug 2023 01:57:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 08 Aug 2023 01:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691474271; x=
 1691560671; bh=2R79hSSzdyd4hfKPi2wSpdqxN+UNp8wvERXDoigDbvw=; b=O
 /IoqiaZW4J28wDsqB99sfcByX7fvnAAywa2GJSWwPxgqSg4ts11Khuepc93HijmP
 AQCnThtvuJyI47pwHV6sazOrKVFTUso04XimjVY9UI+NEXRNCcvc2kHnx1wlGiMl
 JBwwBmnY7ThVG6hdAtlJliXF0FOojdCKlJBTloAaMyTLsYQnWoTy1/ILWKj7j98u
 M5pcZwiTRM7pFtkNzOGfQ5lHdVXN9p+PEgL2bVqbUCxyLMB7j2PKpyZZT8pLuKzn
 GBkP+SNrtjhWP5XSl0A8NJXpVjRT5dOiUvbW874EXsvOMaRdb0eXGrf3olXTdTXP
 gUXuZklJs6+gRWoDceavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691474271; x=1691560671; bh=2R79hSSzdyd4h
 fKPi2wSpdqxN+UNp8wvERXDoigDbvw=; b=RU5rzs8iPRsiQ/Bw+/A27FXFo8Hgd
 VJnQw/FLbnOo0GJScPdnOEfoeGC/wP+kEuIIjsM3fDXRedqFx8N/EZ8tTHbmEW4e
 XA5UgRZLMFZfcgooyy+JeiNsQ8ZcT/qQJdxDKqcCFLi+5OyN6Tho2FHAV2NsZgjm
 ZggXT0Z/WDzLpTpzAkXhjODTlWDkHnWgTtetUiY9sBLa3qdMx/B932g0tfdzhNBT
 1rHDZpPkHXNJhBiX8U2YjrxiZhU4axfRX9mz3GKgUdmYBfDaHJSHBxT+iY4/kYG/
 jNeVum3+H3JzbT1jAexMdd6TfjKmREZ41ZPzKpseZjqZI59n+E5jiRlNw==
X-ME-Sender: <xms:X9nRZL1v2lEAEht8wxaYfqBqKLxbk5NS5R22s66Hx4VCTIjFM1t65g>
 <xme:X9nRZKF9l0qT02868000Jrj7tdpeR6FDeU1M7by85ELsfZ93riBdlnUbeyo8dCIKV
 VIkAc7nQBB2ij1R9M4>
X-ME-Received: <xmr:X9nRZL57K0Nns6ohafiuCAMCiI52GjmUijV5cj9JzdNHDsRhpNJdwFzwldaheNazvkJJYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:X9nRZA3Qu8ZSJBVUdc2vwFZY-6D0GBNMQHyM0_yW6cRFieERv4huew>
 <xmx:X9nRZOEHI6nbDa4jNUmvQ83kXo7xxK0baISJHwvTagydyXaSEdPXQA>
 <xmx:X9nRZB8dUV-99ZKVdT_-tlMenLbGk9v5T5V_xTl35CRh0XU5ZO-5-Q>
 <xmx:X9nRZDTQuC6nKrLApaKGUZd51zBmLJ-d9uIKhbK4GajknAcxU2e3lA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 01:57:50 -0400 (EDT)
Date: Tue, 8 Aug 2023 07:57:48 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ankit Kumar <ankit.kumar@samsung.com>
Cc: kbusch@kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] hw/nvme: fix disable pi checks for Type 3 protection
Message-ID: <ZNHZXExR3Q6Ei-bx@cormorant.local>
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160838epcas5p389c82acd77fd8c74fc7f83300b9d0aa9@epcas5p3.samsung.com>
 <20230807212745.70151-3-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VsOX+gQWVvyIj0AK"
Content-Disposition: inline
In-Reply-To: <20230807212745.70151-3-ankit.kumar@samsung.com>
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


--VsOX+gQWVvyIj0AK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  8 02:57, Ankit Kumar wrote:
> As per the NVM command set specification, the protection information
> checks for Type 3 protection are disabled, only when both application
> and reference tag have all bits set to 1.
>=20
> Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
> ---
>  hw/nvme/dif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
> index 01b19c3373..f9bd29a2a6 100644
> --- a/hw/nvme/dif.c
> +++ b/hw/nvme/dif.c
> @@ -157,7 +157,8 @@ static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *n=
s, NvmeDifTuple *dif,
>  {
>      switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
>      case NVME_ID_NS_DPS_TYPE_3:
> -        if (be32_to_cpu(dif->g16.reftag) !=3D 0xffffffff) {
> +        if ((be32_to_cpu(dif->g16.reftag) !=3D 0xffffffff) ||
> +            (be16_to_cpu(dif->g16.apptag) !=3D 0xffff)) {
>              break;
>          }

For type 3, if reftag is 0xffffffff the NVME_ID_NS_DPS_TYPE_3 case will
fallthrough to the next cases (_TYPE_1 and _TYPE_2), checking if apptag
is 0xffff, and disable checking if so.=20

> =20
> @@ -225,7 +226,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *n=
s, NvmeDifTuple *dif,
> =20
>      switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
>      case NVME_ID_NS_DPS_TYPE_3:
> -        if (r !=3D 0xffffffffffff) {
> +        if (r !=3D 0xffffffffffff || (be16_to_cpu(dif->g64.apptag) !=3D =
0xffff)) {
>              break;
>          }

Same here.

--VsOX+gQWVvyIj0AK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR2VsACgkQTeGvMW1P
DemJdwf/bbtHOkYx3MBa/kUy77zA8MFpB5BYe4UKLApZQnKxFKfrI5RhDswAf/qC
AS8pH5H9kttMpAutwhP3MXO0uKaD0Ks8Jo8jX5G4IpMSfT+uJs6zuYfR4sQsEznJ
C+7VeRJy/Hm3H189IQSt+xl8rMck3iKwPUe+7vkqFYwR86MAtvgsHRGXrPGPGCj8
ox7w1NS0Os4ZPDJUHDt7o5LFvdbpwn20mAg3M9NwYf5qdRG8w2D7YrL1SCNL+gcp
S/tZqZaJACY3rdpz62+JWsmq5cozwKDE3SQnQlMRcvYdIBNnfbDfZ8CxVqqF976J
9dxuuPRFw/NAdO9fH+ZFdJ4O76PIkA==
=3Tp1
-----END PGP SIGNATURE-----

--VsOX+gQWVvyIj0AK--

