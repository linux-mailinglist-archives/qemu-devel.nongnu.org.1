Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A151E75A997
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPLt-0004Dn-5E; Thu, 20 Jul 2023 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMPLn-0004CZ-Pe; Thu, 20 Jul 2023 04:49:32 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMPLl-0002uo-Hj; Thu, 20 Jul 2023 04:49:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id AB68E3202219;
 Thu, 20 Jul 2023 04:49:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 20 Jul 2023 04:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1689842964; x=
 1689929364; bh=Vyg3XZRLDB0TH3WUMQCbKQSyqygcvOyaJKOYGDFkoSo=; b=f
 5E6UXDkI/CsjMxBWiNFfi6jXdUDSAsZJYdGU1TkTnbLziP8sjcWeVVJ5iIOV9/mX
 r6botGljKtvfAQR+MmqDS2eyIfdV8dT0rZerVkZ09yhJU2qdboE1SyMWsR/EvTQq
 DQrAKpya8osdKLBIavse+JGDbpCcaG4VRWT/EYTg2oSI5xriEsjG5m/9//qCj1VU
 NRVPE9S3/HTqmv7lwQxBZJIUh/95YcWsel+Nxd8zo7w5xdyYkM9tfRiB753XDw78
 fc7DWLdc/+t9nmNhrnBq40LYp743QhtkZePmoQ/yHsGDGRBkC5pz6PJ4jNOd4+hs
 7CflsoEYwxfQudTyRcgjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689842964; x=1689929364; bh=Vyg3XZRLDB0TH
 3WUMQCbKQSyqygcvOyaJKOYGDFkoSo=; b=b4Tn/1DioU6mlVOPdbyI1sxya0dOO
 iccEvBZHYKxPWg0zG4KXTHyEOcrh0j33DgM95ZZWFRq67kJ0jQTHyUgmFHs8328/
 iLJmseU2ZOt3mv9/BgZNc0dGfEzePkRHuFHZzR8TsGP/2Ejg05axACNfwPSiE6dU
 gNvRzDTa7uYq0BlAwNm6/ruz0YdaoTRfFvOmqkUps9N6jY9EOJ8TW0Y8kNhY3w/3
 sTDnnzfvd9Be6RKKrCFAiFA0/ydcTfwq//dIUYHzC88+SfYhsc8BqA7R0GFKlhCS
 8ehi8alQyp/BKX5COVTQUop9pb56Q9EIQerX4KRsDQ4iovGo4gfyfCvqA==
X-ME-Sender: <xms:EvW4ZDVKahln5OthkAE_UB-_IpugcdBmqEl9dMJQQ632CmXBHOPKBw>
 <xme:EvW4ZLlSv_eru2vthisXoaZijYifArPCp9z4sKC6NEU__qVAzR0pzpsWBjobbMW48
 LfJxadzBp5yo2quasQ>
X-ME-Received: <xmr:EvW4ZPbGtAgbEnEMcw-sOrgCR1VFosUZKj7ghrqplkVQRGHdCyqktWikyVW3ZMeQGNA5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeffuddvhfehjedugfeijeeuieelgeevuddvlefhkefhgfettefftddvkeevieel
 feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:E_W4ZOUmZSMYy-Ze7LWZRcTEwCCf5ywEiogYq2dN6S1v19d00KEACw>
 <xmx:E_W4ZNkRY6BpWoJnw_TUnIu-B6o9VYod1YHjPSZacl86roHqfr531g>
 <xmx:E_W4ZLcrKm8VNj2lbNwvvlrBLBPtkPnDtshTjQI6qd_-hpI6_F6Mxw>
 <xmx:FPW4ZPlGNI6Rp-1vLaXLV9D-WXr37jv3Bsf602j5qs7hFKoj_CbmTg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 04:49:21 -0400 (EDT)
Date: Thu, 20 Jul 2023 10:49:19 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 1/1] hw/nvme: fix endianness issue for shadow doorbells
Message-ID: <ZLj1DzCrEcorn6va@cormorant.local>
References: <20230719073605.98222-3-its@irrelevant.dk>
 <20230719073605.98222-4-its@irrelevant.dk>
 <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
 <CAFEAcA-BwdoxeiFjA8Xce-fX9j8Qf2FcrJBKBhgKbONVfrJ7ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FoNiP9HD5ObqExI6"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-BwdoxeiFjA8Xce-fX9j8Qf2FcrJBKBhgKbONVfrJ7ew@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--FoNiP9HD5ObqExI6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 20 09:43, Peter Maydell wrote:
> On Wed, 19 Jul 2023 at 21:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 19.07.2023 10:36, Klaus Jensen wrote:
> > pu(req->cmd.dptr.prp2);
> > > +    uint32_t v;
> >
> > >           if (sq) {
> > > +            v =3D cpu_to_le32(sq->tail);
> >
> > > -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->ta=
il));
> > > +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
> >
> > This and similar cases hurts my eyes.
> >
> > Why we pass address of v here, but use sizeof(sq->tail) ?
> >
> > Yes, I know both in theory should be of the same size, but heck,
> > this is puzzling at best, and confusing in a regular case.
> >
> > Dunno how it slipped in the review, it instantly catched my eye
> > in a row of applied patches..
> >
> > Also, why v is computed a few lines before it is used, with
> > some expressions between the assignment and usage?
> >
> > How about the following patch:
>=20
> If you're going to change this, better to take the approach
> Philippe suggested in review of using stl_le_pci_dma().
>=20
> https://lore.kernel.org/qemu-devel/376e5e45-a3e7-0029-603a-b7ad9673fac4@l=
inaro.org/
>=20

Yup, that was my plan for next. But the original patch was already
verified on hardware and mutiple testes, so wanted to go with that for
the "fix".

But yes, I will refactor into the much nicer stl/ldl api.

--FoNiP9HD5ObqExI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmS49Q4ACgkQTeGvMW1P
DemE/wgAg6yABL+Ct/YHy8YG0TiX4vkt90//y+NLIHx8WojtgwdxdWSw8tbibx9c
1YG6BHQ4pLm2cJTB1mvuT1ZxNFSPcea3nEVbV1pfETxRflEYp00nnY3/zBVSKjcy
H5obf/IY+IcCN2BVCF6dXKDLrPVzwhVwmZA/tRTNLmmEvBlk+FpRLontuJDi4Lvg
UBvy/jkTwp72YD6tTC6vyy2HrlokmAszDpSVo/TWBuOrA5HdRvL8VpSbCiSdaAHR
OBjCZ0PBYw5/HOBLiE2ODNRtPh7J6F+H1nzaXjtxM10dJHzEN121ZuHmKPNLeKEO
ZUKOIGgug6ZYZa+FIbDUqUqHwG6MtA==
=DB25
-----END PGP SIGNATURE-----

--FoNiP9HD5ObqExI6--

