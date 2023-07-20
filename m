Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C310475A9A7
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPRk-0006ik-TD; Thu, 20 Jul 2023 04:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMPRi-0006hu-97; Thu, 20 Jul 2023 04:55:38 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMPRg-0004XE-Ao; Thu, 20 Jul 2023 04:55:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 11075320243E;
 Thu, 20 Jul 2023 04:55:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 20 Jul 2023 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1689843332; x=
 1689929732; bh=9bhb1KhdrwWvZj2Co0nCg2/He0WRIlVe/jpPT2GmYCU=; b=P
 ykhCuMNdSnZKvjzB+Rgw6hUH1/L+hKON1TlhjDbGsXqiooS8sd0CLysad9Zcth1G
 dK5GGq7uzi97rwy9gYNvfStSpFGvHh5vsVs4SfRQRIw5/ZiOkeKrM7rQ265cGyp0
 Wd05Ccixsjq841RCn1lYGH6ek6DHL3WGK602iKgFFSxpg624iaiBjo/wiR0y+TJK
 VWgZMTs6tBfT1F7Q/V38qRUEgsxyzKj3ljlLfi9cj5p87B2dGqqoOs5GU3Dr6tqA
 lxZUCz378ey5j9ycJgmzdE4sA+wuNnP7PgDdTQ02/wJQZ1NHqfHbgLKpcO9mFepm
 ybLM7B5TYiWDCepMylYhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689843332; x=1689929732; bh=9bhb1KhdrwWvZ
 j2Co0nCg2/He0WRIlVe/jpPT2GmYCU=; b=on/3B0PX8vBPt3iUkQM0szfPGA7k6
 0RhGZkSV/RKmVieYe2c+EhjKzVMTDA4XyfEIZYhYqzqKdPe2UKlUoImHIMTLdhTP
 zD3fVtFNEpIwbHbq7qX2ltRODyG0U7kfYK5toYhPwG1ZSaDEZ/ZTqhqV3ZdZYlgq
 F3ilOkwLGTdF7q+dceo67mij1g931Ej6KHjv+lpMOqAIBdCd2ll55sB7qf7z8yQC
 FoZM5LOHFh2ERvETPordQzCQSvgLCDHKl0jw7io9dYsau/DhBpwqbkWz6TmXe/9o
 hvjuPPRCR6TdEr3AUzjZyMQ3AtWYBU4+vXbJW/UqicqI3P33e0MTRyRGQ==
X-ME-Sender: <xms:hPa4ZBZfB3dEBEHJPBFWq3sUvQN8taw6UVwW5DFgtW_bwtYOg4I9Cw>
 <xme:hPa4ZIZcz1FtsqU1sf5kclw6KIIug_mMitwRmSRczA02K3YHALX6mUvOUGnASRRJq
 W_C9tw9LWo7xZhM-wE>
X-ME-Received: <xmr:hPa4ZD8hU5kJOR68eg_0pIYiwP7xRmrhWSNmqb5ZdthzCzQPtQRwWBCegkvoK9fFWbfz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgddtlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeffuddvhfehjedugfeijeeuieelgeevuddvlefhkefhgfettefftddvkeevieel
 feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hPa4ZPotO4V9hnCVw92MRLNXlN5Pp8ntLR3vxXdXutVErqkwlRQvRg>
 <xmx:hPa4ZMrzPFC1Vd1wkqM6maCHd2NEm5b7Fid4fXJ7CcU4fcRoJxU1uw>
 <xmx:hPa4ZFTlGVgTPFDf82qvdQMyisCGZ0V_ziWIMyyL8Mc7dOUnLTNeSA>
 <xmx:hPa4ZJ4tw2Ho-Jf9kV0jmG8K6yBC8_4n9yZMPWD2brGXTBxNl376Bg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 04:55:30 -0400 (EDT)
Date: Thu, 20 Jul 2023 10:55:28 +0200
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
Message-ID: <ZLj2gAFnv5o8j2pM@cormorant.local>
References: <20230719073605.98222-3-its@irrelevant.dk>
 <20230719073605.98222-4-its@irrelevant.dk>
 <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
 <CAFEAcA-BwdoxeiFjA8Xce-fX9j8Qf2FcrJBKBhgKbONVfrJ7ew@mail.gmail.com>
 <ZLj1DzCrEcorn6va@cormorant.local>
 <CAFEAcA_nLmZi1uQmYTQ7WdrQ9snj85SiWDZnX+wEQ_Z+7fw3Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B7RTa1C57hXLz3IK"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_nLmZi1uQmYTQ7WdrQ9snj85SiWDZnX+wEQ_Z+7fw3Rw@mail.gmail.com>
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


--B7RTa1C57hXLz3IK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 20 09:51, Peter Maydell wrote:
> On Thu, 20 Jul 2023 at 09:49, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > On Jul 20 09:43, Peter Maydell wrote:
> > > On Wed, 19 Jul 2023 at 21:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
> > > >
> > > > 19.07.2023 10:36, Klaus Jensen wrote:
> > > > pu(req->cmd.dptr.prp2);
> > > > > +    uint32_t v;
> > > >
> > > > >           if (sq) {
> > > > > +            v =3D cpu_to_le32(sq->tail);
> > > >
> > > > > -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq=
->tail));
> > > > > +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail)=
);
> > > >
> > > > This and similar cases hurts my eyes.
> > > >
> > > > Why we pass address of v here, but use sizeof(sq->tail) ?
> > > >
> > > > Yes, I know both in theory should be of the same size, but heck,
> > > > this is puzzling at best, and confusing in a regular case.
> > > >
> > > > Dunno how it slipped in the review, it instantly catched my eye
> > > > in a row of applied patches..
> > > >
> > > > Also, why v is computed a few lines before it is used, with
> > > > some expressions between the assignment and usage?
> > > >
> > > > How about the following patch:
> > >
> > > If you're going to change this, better to take the approach
> > > Philippe suggested in review of using stl_le_pci_dma().
> > >
> > > https://lore.kernel.org/qemu-devel/376e5e45-a3e7-0029-603a-b7ad9673fa=
c4@linaro.org/
> > >
> >
> > Yup, that was my plan for next. But the original patch was already
> > verified on hardware and mutiple testes, so wanted to go with that for
> > the "fix".
> >
> > But yes, I will refactor into the much nicer stl/ldl api.
>=20
> FWIW, I don't think this bug fix was so urgent that we
> needed to go with a quick fix and a followup -- we're
> not yet that close to 8.1 release.
>=20

Alright, noted ;) I will spin this into the other fix I have under
review.

--B7RTa1C57hXLz3IK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmS49oAACgkQTeGvMW1P
DemeqAf9FZT84mAQ22KFLTcmSi5JaSU23R+2XrDBFvjq8Fg07KZv7wbAKwfaMsJL
AfZ0dmepD8DoglMaLuZGUBBEYrC+HQy3+vXC1i3CxdwWwCYqiywRl7P4+KX7G5+h
6kTE82AHEHGQI4PlrDVgyMXrfOuDoymseiKEIOLIq4jBS/+Tiwl1uNaG73WDDuZj
C5EK8XaP/NfVbDbrWo4Ubw+mWQlBLotVxfIUIPF8u2Zz2PRGbUrk5ozi7jXjMhfg
nqZ4KIDjrB+4hWha9adiJb/k8O7gLkfdKNGlM2bHM93qafGf07a08rw4tBhhZQzT
eNX9r8ZznqQoMydsQfwFZMkRFDuGQg==
=1VME
-----END PGP SIGNATURE-----

--B7RTa1C57hXLz3IK--

