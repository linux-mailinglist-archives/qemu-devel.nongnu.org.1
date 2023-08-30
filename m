Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B278D370
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 08:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbF8p-00053E-AO; Wed, 30 Aug 2023 02:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qbF8d-00052f-Fn; Wed, 30 Aug 2023 02:57:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qbF8Z-0002aE-OM; Wed, 30 Aug 2023 02:57:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 9E5A832009E7;
 Wed, 30 Aug 2023 02:57:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 30 Aug 2023 02:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1693378626; x=
 1693465026; bh=2PW1IHODsdKepyKRkqlqzfemGRV2SizP0LHSntgyniU=; b=o
 GQK95cBrBHMvrmXP1nepkxMfDl5IqWDG6Yl3qNJMNBCKBBXviUw4jGYBo3qXWa3k
 DKhJuOA5wVZjt2MPhWKoYCaLGJLvpiDCpe+QxOcUH7ohV6JjGSqymo/5WQonnyt5
 5HfHRuK+gMGw7t/hX/e10nbJOTNHNF2TFijpOUxIiym/RX85SvDkhjMcO1PwaERk
 n/cQNbMSgvI22Cb7Q6beQ+r3mpuCdSUqTHIXcPDCGny04CpF5n5YhXwLEk2Yju8l
 3ADcj/KlpkPjqZMFlN0XfgFF79EpU3EKuzGX0Q3u7VeCsCH3AULTWAp/O8apEpqk
 T9TkHCWmZieFql5juocHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1693378626; x=1693465026; bh=2PW1IHODsdKep
 yKRkqlqzfemGRV2SizP0LHSntgyniU=; b=o8i/5nikN1Q7yocYeH/RcqPbaddY1
 Hrh1/PW3M2r7d71AYhA7C5gRJkDsOfIhVY+C6Qslfx7O5K3Z7L8CVXnOGJt4OeY7
 MkwZqiPQ+l2UJtnYCofBdsoRuetYhnuo4NldIy87VSZG2ujmGdVsPHkZZ1np/5lD
 C8JROuaF5m5+gYae54gjcKHwX1s+Rdiy/vjag9BwnPta3bjMRT88CptLAI6+ocV7
 1tHiLUyLLMGLVS181SJtRHAy7uIZFhBCXw/Xd4w9N7sA52N6cTwcrje3HNd+UKlY
 rTPAGhFHqEbXNSbd3MjkSAk5PGFQn0ELcrYcSNOwx0vHewMZ0G8M1vcsg==
X-ME-Sender: <xms:QejuZI1B1xtUuLpio0cEEGo6e_qX0ILbUVZbMLp7yt8MIXJl7f7ghA>
 <xme:QejuZDGzfTtaXCYtluD7VawbU2k_zgpLRiLt0syd5BQ977YRHyiPKEnMiWdorRyO_
 1O_uSSv_SotiLds470>
X-ME-Received: <xmr:QejuZA6qD-qWHk9rHvC_d1eaW4yc-ZQSbFlgPkYPcDLw3kXaAC5FdeHvOUFPBFiZrsyzKMcaS3PVvzpQJ9Sducc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedguddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:QejuZB1oP-mc4lKRLBi0eEPTI3Y8g-qT9OfnliwdqWQe7YQErxpb1A>
 <xmx:QejuZLEmiaQfJ6E3qJYPm9jjlM3qqxIJOB51oAvZd6Glf5_t5zfygg>
 <xmx:QejuZK8bO_Gg8U8IdO2bwnTvm8v704JhczCkJjvXSWNZCV45BdltEA>
 <xmx:QujuZMPuqUFQzzH3ugL_YNo2o6SP9g18HyVPEIWuKb3QkR20dcZSZw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 02:57:04 -0400 (EDT)
Date: Wed, 30 Aug 2023 08:56:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] kconfig: Add NVME to s390x machines
Message-ID: <ZO7oNAmnOqKFGAQH@cormorant.local>
References: <20230828150148.120031-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nDWo+LSCHcAeTBtI"
Content-Disposition: inline
In-Reply-To: <20230828150148.120031-1-clg@kaod.org>
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
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


--nDWo+LSCHcAeTBtI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 28 17:01, C=C3=A9dric Le Goater wrote:
> From: C=C3=A9dric Le Goater <clg@redhat.com>
>=20
> We recently had issues with nvme devices on big endian platforms.
> Include their compilation on s390x to ease tests.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/nvme/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
> index 8ac90942e55e..cfa2ab0f9d5a 100644
> --- a/hw/nvme/Kconfig
> +++ b/hw/nvme/Kconfig
> @@ -1,4 +1,4 @@
>  config NVME_PCI
>      bool
> -    default y if PCI_DEVICES
> +    default y if PCI_DEVICES || PCIE_DEVICES
>      depends on PCI
> --=20
> 2.41.0
>=20

Acked-by: Klaus Jensen <k.jensen@samsung.com>

--nDWo+LSCHcAeTBtI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTu6DMACgkQTeGvMW1P
DelLOwf/RyfBRmuvviI0V69rMvQRWm4g8wSkD4xXMAIrugZrTK6VDlChpo03A0OE
9ui9+3AaX6THhXla7C/zoJozUx69DzXV4NJnkW+WwgNn8k2yHSVSlLrPj+tZwVIY
fGLSwNyaWAqjF2GaGLVwmiv71+XfL0f801/ybZ/lhb25VP1xZpXVZPRTvyuYMyeq
pNeDcD+PR6hQhR5cflHzJvfHs6UjfV16XZZAc+UlQDLY4hNCtKEcY0n7v1HX8rNJ
upoCB18ghwDY7qWqoaxTzSwNEPN/QEoZiZyMrQGqZQEGPw2AknT1e/k7eubL7U2e
sFqEJ/z8QDRLKHhFFkEVXRr3dZnstw==
=eCQp
-----END PGP SIGNATURE-----

--nDWo+LSCHcAeTBtI--

