Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7178703A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAN0-00048u-Sb; Thu, 24 Aug 2023 09:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qZAMx-00047B-Ti; Thu, 24 Aug 2023 09:27:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qZAMu-0004BJ-Fy; Thu, 24 Aug 2023 09:27:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id AB8A05C00D4;
 Thu, 24 Aug 2023 09:27:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 24 Aug 2023 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1692883639; x=
 1692970039; bh=RjM4DLQB6WCsVUAGNeyRZ4loInnPoZMBLRw49PK1HFk=; b=r
 n1JQUukIYyFLrGO/HwsqwGf83u8X2/dxs9XjgqocdWiyLvG0bNlUiUxW3tMKNZE7
 dyzwZFHXg2mNNuCzNVuPrL30r6GcrZb28hMAQeZ4d72kgH8omND4q7RXoJd5vsk0
 xWcTL9H0ZFsnJhE9McTcmZqpDSkX+dSVE23LMPbnxE12CDjMGsbnWgO2ajkGjyx6
 hb9ARwbRN98vv7XW7C680pVOxRzu8nZACHBeY6o6ej8t5AyVZbhVy58NSEz8nqad
 qtfa6XoEJKgON83i7MUZuoGcYvn8Kyyp34CiGlBfJCTPI0e1EnDOMNcZlScwlR3x
 ooFuHZFDG6jXNMc2Y/s4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692883639; x=1692970039; bh=RjM4DLQB6WCsV
 UAGNeyRZ4loInnPoZMBLRw49PK1HFk=; b=Eg5tsMmBx2THYthkW4HcTdjYbQCxQ
 wKbKvn0KdZUGm4V9plIvuZd/S+lkQ+EMgG/gqvjgAt2db9sza8Hg7qUBu+Uia23R
 TsvF9OtGnc5E2ffOFmsa1yQ97Z++8MvKchNkRySu4dIkfLq+LeWU4qbVkeSQx4vL
 MKjJasHT3E0arX8CUvhlQqNsfates/B68jGi/cnSEHwnpr9wmOhVGBimWgGlPU6l
 2QZkgi70t23sGEwyf5j+4s8eFblj/ESC3EtcT5FhvUd9I6xO+tMH6UwH50tmxpjm
 N4jp/HLOu2dIoM+W8ibjibDzwQSwtO/cn9ETxJP1V2CaucVgIYK81P13Q==
X-ME-Sender: <xms:tlrnZCUJu1JEAdPyIu6CMhABAggoCN-r4LeTQWwJIjCgC-ivETxfgQ>
 <xme:tlrnZOk-7A-re-njIooh7ke_LBMV4prm4sEIW224mIL9sVgd4gKPZ5slFnPXIRXvB
 92tPEV_Cx2wjO9DMQ4>
X-ME-Received: <xmr:tlrnZGZ3SAwPM0SskTihQAbH2a0eRiqoxgUrYxZYRMn4Gm4Tl875eSz03wGaGWAe010wR8hMtDyXjAEc8-8f6Rs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddviedgieefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnheptdejkeevudekueegledvleehgffffefhjedtkeeugffhledvffetheevveeg
 udeinecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:tlrnZJXmCyEnCn5X_T0C2CiIK2vhKhSkFiSeUm_UNmMezUhOcz9L1w>
 <xmx:tlrnZMnP2sYKvtdmB4IPnPHwRJW0l1RFIUVjhE52-Wzq4Nfl7bfHgw>
 <xmx:tlrnZOeqC5690phxkrRX1CZ-XYlwUu5ma5L3LzUNdA1_ddKBJvcaxg>
 <xmx:t1rnZGVVd7cJ9A3gHBF6eIqe7i-Bw8b2rEX-D5Uv0gDAB35wqj--ZA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Aug 2023 09:27:18 -0400 (EDT)
Date: Thu, 24 Aug 2023 15:27:11 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: Re: [PULL 1/2] hw/nvme: fix null pointer access in directive receive
Message-ID: <ZOdar5SaiEjOuYj5@cormorant.local>
References: <20230809133909.45818-4-its@irrelevant.dk>
 <20230809133909.45818-5-its@irrelevant.dk>
 <556b1036-fa1c-f207-6ce6-a9cf22805e6c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aO+pejhavWMuR4xf"
Content-Disposition: inline
In-Reply-To: <556b1036-fa1c-f207-6ce6-a9cf22805e6c@linaro.org>
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
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


--aO+pejhavWMuR4xf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 24 14:44, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/8/23 15:39, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > nvme_directive_receive() does not check if an endurance group has been
> > configured (set) prior to testing if flexible data placement is enabled
> > or not.
> >=20
> > Fix this.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1815
> > Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
> > Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index d217ae91b506..e5b5c7034d2b 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -6900,7 +6900,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *=
n, NvmeRequest *req)
> >       case NVME_DIRECTIVE_IDENTIFY:
> >           switch (doper) {
> >           case NVME_DIRECTIVE_RETURN_PARAMS:
> > -            if (ns->endgrp->fdp.enabled) {
> > +            if (ns->endgrp && ns->endgrp->fdp.enabled) {
>=20
> This patch fixes CVE-2023-40360 ("QEMU: NVMe: NULL pointer
> dereference in nvme_directive_receive"). Were you aware of
> the security implications?
>=20

Yes, but I was not aware of the CVE being assigned at the time. I don't
think it was?

But if what you are saying is that it was my responsibility as
maintainer, to get that reported and assigned, then I apologies and will
of course keep that in mind going forward!

--aO+pejhavWMuR4xf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTnWq4ACgkQTeGvMW1P
Del72gf/a5wsHArZHxbslqJdf4Z6JbJRxQ6dGaRCLWOxeCrDtqwn071lglUWYEkp
SfF/yYqxOuoSerNmZeOFNtdk1BQePYqb5svvenAGEhpSa67WM3qZdNGJ3i79C2CI
3/XRdrrqPB0piqgNl82rhltkEEL7BbanNz1mq7tvZJvELAcml0E4Lb78O4JpwDlo
5KEA9pAwtkow5ChiPMz9l0N6AjCqbfpcvSRkKMlkCoM1Mm0PsUWYHFjVEd/5vjPD
lAcfcMYkja4fZeaXZ7XXBPX57lx26OPCU8MHDp33HR8h/y2GOCV9+bRnMX5mdlde
udYLS0akUy85YLrzGgfYZICVi4jJFw==
=IMDS
-----END PGP SIGNATURE-----

--aO+pejhavWMuR4xf--

