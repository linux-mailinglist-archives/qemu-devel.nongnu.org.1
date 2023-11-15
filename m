Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C807EBF80
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 10:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3CE3-00018k-Vz; Wed, 15 Nov 2023 04:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1r3CE2-00014T-0d; Wed, 15 Nov 2023 04:30:22 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1r3CE0-0001Hl-6z; Wed, 15 Nov 2023 04:30:21 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 66EC05C01D5;
 Wed, 15 Nov 2023 04:30:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 15 Nov 2023 04:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1700040618; x=
 1700127018; bh=8+QBdNf6wLMyfzrSfhbvWTF80iZEuxzWtB3qvsCV0bs=; b=t
 j2pClV2OlvHc+CqPOaz2XsOdwL5UP9Hpaoc2Y+wcGa7G/j3Lj4l+fTZ7rqy4jmwN
 8U13UbY4jnVydhE7UuozAOQoKvMoU8pCOdwO8gHWj/k5W243SXMvscOFBev7xZag
 hzLKhlS1T57uAQ3ydhRnhrUZB8qYPS4GspMjCp32f6CZOQEbuCTMInd3vJ8XnOgp
 GXwiBylGf603KKGts89Q2YZX5rVqYjb+Vj6KQWRuB9zsyO3FCUtbminTcTLGCVRp
 LwIbQ9kuFSg3OGzzSPfv8HH2qXF9zBACcvvYFWr8YUsM6S1RnbdOdG906AT1hqgf
 ldvB5ftcDMg+VYszAPusg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1700040618; x=1700127018; bh=8+QBdNf6wLMyf
 zrSfhbvWTF80iZEuxzWtB3qvsCV0bs=; b=zPVpowQDUEawvBpb1+EJpTdV9HW3s
 wo9beWZJ0fu/JJS+7G90ARzbtcAgMO5wBenZr+jZrABHvYzx19UVSuJL6xwoVZ0f
 j/QRK2sEhpfi/Y5OoWJlhExV/ErhXhgpZyX9I2znXbnc7CjxwEkeDSXya/cbOKHq
 bykzkIRdI4kXpOtYajIroTTp8S94PoQ/nH0ObYN/P88sARxiGPhOfMLbitMzGnS1
 cU6ryVILrQKK4Tp0t17wJLcZ0wrK2rir8NzSRMjcgCjGw6ptGXc8oxSjvCfgO8bn
 MvtJMNcRWpg0q4UZHWagBTdiTkK4WdAz/2y6stl9af2lIxwAePir9xwuA==
X-ME-Sender: <xms:qo9UZYyh45LOpWip_zMUptZrwArdkl8qnw8kfwqinddLRyqbgspJeA>
 <xme:qo9UZcSsFavrHGLZNjHeUtKOJCPnfqGuhQBqYxgbDMhWA5lbPsF5pSrbsmr99qR3U
 AjMgr2NDmNkhmhQwas>
X-ME-Received: <xmr:qo9UZaX_goXISKNdzXgCY3OFIqnOcTePTmkOL5ko1Bs4PfkfEy_P8PNd2coE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefiedgtdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:qo9UZWiDdJF3bmM_62lsB9fzOfAWov8UnkxAkRzKUoaSCftwBoSZbg>
 <xmx:qo9UZaAnzyz0sEb_Z6aCcbvW5f_-VZfY8UmAksMtaFEnpt5pxLfG_Q>
 <xmx:qo9UZXI7NPp_OIbMmuRd2L_FJTf7nNPypSTTzoNk0Uu5iDCftNmiKw>
 <xmx:qo9UZVPdyfzDY9BgxC0NhArkd8cTHb3vVP-2_-aJmRi51ilmaNZnxg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Nov 2023 04:30:17 -0500 (EST)
Date: Wed, 15 Nov 2023 10:30:13 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH v3 65/78] hw/nvme: add fallthrough pseudo-keyword
Message-ID: <ZVSPpXuaX2ENybrf@cormorant.local>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <82f908be2888b88fd93f1c5531f54d25d1da1a59.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rKla3oN3pYsDg+qU"
Content-Disposition: inline
In-Reply-To: <82f908be2888b88fd93f1c5531f54d25d1da1a59.1697186560.git.manos.pitsidianakis@linaro.org>
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


--rKla3oN3pYsDg+qU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13 11:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>=20
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/nvme/ctrl.c | 24 ++++++++++++------------
>  hw/nvme/dif.c  |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e..acb2012fb9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1918,7 +1918,7 @@ static uint16_t nvme_zrm_finish(NvmeNamespace *ns, =
NvmeZone *zone)
>      case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>      case NVME_ZONE_STATE_EXPLICITLY_OPEN:
>          nvme_aor_dec_open(ns);
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ZONE_STATE_CLOSED:
>          nvme_aor_dec_active(ns);
> =20
> @@ -1929,7 +1929,7 @@ static uint16_t nvme_zrm_finish(NvmeNamespace *ns, =
NvmeZone *zone)
>              }
>          }
> =20
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ZONE_STATE_EMPTY:
>          nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
>          return NVME_SUCCESS;
> @@ -1946,7 +1946,7 @@ static uint16_t nvme_zrm_close(NvmeNamespace *ns, N=
vmeZone *zone)
>      case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>          nvme_aor_dec_open(ns);
>          nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
> -        /* fall through */
> +        fallthrough;
>      case NVME_ZONE_STATE_CLOSED:
>          return NVME_SUCCESS;
> =20
> @@ -1961,7 +1961,7 @@ static uint16_t nvme_zrm_reset(NvmeNamespace *ns, N=
vmeZone *zone)
>      case NVME_ZONE_STATE_EXPLICITLY_OPEN:
>      case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>          nvme_aor_dec_open(ns);
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ZONE_STATE_CLOSED:
>          nvme_aor_dec_active(ns);
> =20
> @@ -1971,12 +1971,12 @@ static uint16_t nvme_zrm_reset(NvmeNamespace *ns,=
 NvmeZone *zone)
>              }
>          }
> =20
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ZONE_STATE_FULL:
>          zone->w_ptr =3D zone->d.zslba;
>          zone->d.wp =3D zone->w_ptr;
>          nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ZONE_STATE_EMPTY:
>          return NVME_SUCCESS;
> =20
> @@ -2017,7 +2017,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, Nv=
meNamespace *ns,
>      case NVME_ZONE_STATE_EMPTY:
>          act =3D 1;
> =20
> -        /* fallthrough */
> +        fallthrough;
> =20
>      case NVME_ZONE_STATE_CLOSED:
>          if (n->params.auto_transition_zones) {
> @@ -2040,7 +2040,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, Nv=
meNamespace *ns,
>              return NVME_SUCCESS;
>          }
> =20
> -        /* fallthrough */
> +        fallthrough;
> =20
>      case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>          if (flags & NVME_ZRM_AUTO) {
> @@ -2049,7 +2049,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, Nv=
meNamespace *ns,
> =20
>          nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN=
);
> =20
> -        /* fallthrough */
> +        fallthrough;
> =20
>      case NVME_ZONE_STATE_EXPLICITLY_OPEN:
>          if (flags & NVME_ZRM_ZRWA) {
> @@ -3582,7 +3582,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequ=
est *req, bool append,
>                      return NVME_INVALID_PROT_INFO | NVME_DNR;
>                  }
> =20
> -                /* fallthrough */
> +                fallthrough;
> =20
>              case NVME_ID_NS_DPS_TYPE_2:
>                  if (piremap) {
> @@ -3737,7 +3737,7 @@ static uint16_t nvme_offline_zone(NvmeNamespace *ns=
, NvmeZone *zone,
>      switch (state) {
>      case NVME_ZONE_STATE_READ_ONLY:
>          nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
> -        /* fall through */
> +        fallthrough;
>      case NVME_ZONE_STATE_OFFLINE:
>          return NVME_SUCCESS;
>      default:
> @@ -4914,7 +4914,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8=
_t csi, uint32_t buf_len,
>      switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
>      case NVME_CC_CSS_NVM:
>          src_iocs =3D nvme_cse_iocs_nvm;
> -        /* fall through */
> +        fallthrough;
>      case NVME_CC_CSS_ADMIN_ONLY:
>          break;
>      case NVME_CC_CSS_CSI:
> diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
> index 01b19c3373..00dd96bdb3 100644
> --- a/hw/nvme/dif.c
> +++ b/hw/nvme/dif.c
> @@ -161,7 +161,7 @@ static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *n=
s, NvmeDifTuple *dif,
>              break;
>          }
> =20
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ID_NS_DPS_TYPE_1:
>      case NVME_ID_NS_DPS_TYPE_2:
>          if (be16_to_cpu(dif->g16.apptag) !=3D 0xffff) {
> @@ -229,7 +229,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *n=
s, NvmeDifTuple *dif,
>              break;
>          }
> =20
> -        /* fallthrough */
> +        fallthrough;
>      case NVME_ID_NS_DPS_TYPE_1:
>      case NVME_ID_NS_DPS_TYPE_2:
>          if (be16_to_cpu(dif->g64.apptag) !=3D 0xffff) {
> --=20
> 2.39.2
>=20
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--rKla3oN3pYsDg+qU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmVUj6UACgkQTeGvMW1P
DenihQf8DpqZsZ4ECe9YCch8w4hU0snlIQpNk29izSAFMybGSW5D6+lWCrkYXbye
cmJ/y2KgflPO+cDorpPkXGnYeJkp3+vTYEXhAjHP5La30RYxQgAYEsf3QL1GBx+z
vOA3b1yPX1t/KYTMmpe1UoxjnP4u8zi1fRNiS98pDVXb2GXa51Wljl4vz/Qouwin
0tmvKgiqoghhMRMK+aQMlR3Jq7QK/ctJWjCARS5rdMlo2R6OAs9b7IDS4kfsoj6a
QHE15ADwI1PHoHzVlpamhMVobhTCafTVpR24MlzEP4cHZ3/zyYj+vV1bV2leQfkw
MjoIjTOHfCo47/Qr6iDQdolOKBD16A==
=SUMM
-----END PGP SIGNATURE-----

--rKla3oN3pYsDg+qU--

