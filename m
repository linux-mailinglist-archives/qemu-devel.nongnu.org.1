Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29861710B27
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29EQ-0006cq-QM; Thu, 25 May 2023 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q29EO-0006bM-80; Thu, 25 May 2023 07:34:08 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1q29EL-0002CE-PS; Thu, 25 May 2023 07:34:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id ADC0932003C0;
 Thu, 25 May 2023 07:33:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 25 May 2023 07:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1685014438; x=
 1685100838; bh=A1EUSiH05ybJpEadn0UkunleNidrximLxi3rOwhFAeY=; b=X
 dV7DSghp/EEUUS6T/E5DzXcAxhSTbP4yqeQIwfDOyszPJeOGhMOCMDBtY3mLBVJW
 k6iPug57dp4SF16hjYXBuM9aBQo6dHRPnJYkQ0RajUnoQMeJhx8FbDUngSxGdRze
 mmBlaubWO5MFgQQFDBr1USd9eFoyW6x5+sgvJ5+S6mQSeRmsLBEf3dAMnsI/MhTY
 4mCNzlu+UyIwdaFkgVXuQBCPU03h7+pm4V/MLZRg/cOAGO+Kb6dr6Qsbtf+iO6oF
 KsaY3X90e/oUivVIPf2kZz41bdoFdGeVJ9LoOFR0hmJJjIr91ArTu/Hitw23ulQm
 98T6zpSsaTs0mcqlNaGEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1685014438; x=1685100838; bh=A1EUSiH05ybJp
 Eadn0UkunleNidrximLxi3rOwhFAeY=; b=utdajSZL01/fLQ8SSkXHZegbfBwYY
 CnTuy6NEA7mvkzSNlHCmX1+lbpo2K1/UtCEsai6zFFXJtV99mq/EeEtiOUxn9oif
 vzhDHSu6MBHAllPypp+FDZa3E8X/Dl2eN9fiiiSJsi33pBE1NfepnGD1RN8dDmLY
 PJfBU7QWdp0DdlaJAQrhpesOwS06l8buRv5TgHR6nDnPUL7tBY4gSTa1yqDnGTQz
 D+2QcRclvxk+N94a4pxMBkxGqBXZN2soq4SYWIiKdcTatworOIDlgwsukmec/NoQ
 0RSlQhW78u7Q9Y/uXBaeNaefiS8hjJ/k4YL0/W3fe0SnN5SLrppMYsjUQ==
X-ME-Sender: <xms:pEdvZGrOFYrCJNufg6W2u_R_nxYUCH9WwWJCpegwWOHsVCsFiiT2Dw>
 <xme:pEdvZEo7auBCqfOvHLxyntIOKwDBBHlS441hE6n4zLU4chsJAnQps4NKg0lvrqk5a
 2bO3j2L5mvYAnhTdOE>
X-ME-Received: <xmr:pEdvZLMSGMrvq0nYG93PYLxwHv5cPSS2lpF0_zQ3FZ8mMEUq-Z96OceCL3_3wbNRHxCD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveei
 leefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:pEdvZF409Gh6Zw0sUQCAkqDUY2SjyImIg1avld-BQdmIdt-LiuO3Pg>
 <xmx:pEdvZF6E8h3R4PKiajqjVZRzDqNt9onIzVXaZnzf4O7Vh5OGpBT5Sg>
 <xmx:pEdvZFhsva55sIJDvH2Ag6gSIjSPe85XJ8UIK8Ze_vrDU5aQZeiTLw>
 <xmx:pkdvZEInH1HrtXyjkDjRXDixJXy2ahugwX67iotjRQdr42cgY6XnXQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 07:33:54 -0400 (EDT)
Date: Thu, 25 May 2023 13:33:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Delevoryas <peter@pjd.dev>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jason Wang <jasowang@redhat.com>, Lior Weintraub <liorw@pliops.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 1/3] hw/i2c: add mctp core
Message-ID: <ZG9HoKFzvIngzomZ@cormorant.local>
References: <20230425063540.46143-1-its@irrelevant.dk>
 <20230425063540.46143-2-its@irrelevant.dk>
 <20230525122711.00002a61@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8ZwLm31Fr6bPAHsP"
Content-Disposition: inline
In-Reply-To: <20230525122711.00002a61@Huawei.com>
Received-SPF: pass client-ip=64.147.123.24; envelope-from=its@irrelevant.dk;
 helo=wout1-smtp.messagingengine.com
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


--8ZwLm31Fr6bPAHsP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 25 12:27, Jonathan Cameron wrote:
> On Tue, 25 Apr 2023 08:35:38 +0200
> Klaus Jensen <its@irrelevant.dk> wrote:
>=20
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Add an abstract MCTP over I2C endpoint model. This implements MCTP
> > control message handling as well as handling the actual I2C transport
> > (packetization).
> >=20
> > Devices are intended to derive from this and implement the class
> > methods.
> >=20
> > Parts of this implementation is inspired by code[1] previously posted by
> > Jonathan Cameron.
> >=20
> >   [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonatha=
n.Cameron@huawei.com/
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> This is very useful for the CXL MCTP CCI support - got rid of most of the
> nasty code when I moved over to using this (will post code shortly)
>=20
> A few comments inline - but all trivial stuff.
>=20
> What I can give now though is:
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Hi Jonathan,

This came at just the right time! I was finally preparing v3 since Lior
is also requesting that this gets merged sooner rather than later ;)

I'll work in your very resonable comments (thanks!) and ship it.


Thanks again,
Klaus

--8ZwLm31Fr6bPAHsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmRvR58ACgkQTeGvMW1P
Dem5wAgAgd0shlQK2sUpGuTmGXBGFdi3vmQxPihacby/QkvzzHrzMFXl6xPc3sx+
a6v3lQ0WWBhc9uN0v/ZeXvwN3CVkLJIOBAyyRDYSJOeQi9ZhL70dLlf5TPe+J3AR
FBuO08jWVfipMCuMxsUJKlv94iS1MqQ2egh54ziWMMKpZ9qRvtQLPFacLPKoDWpX
3gveU+XewSYjovt74ZR+tUire0KrnFuAflI/XE3+OuQEDruMl7ZuTF8W9y7HTSba
4jZMz1q12kkJIp06lvsVW4HsmZEHxRKE0wdGF6xr4rxrW/uZROPwcdEu+7V+hZJU
3vFRK9tJx81y2BuTMpBZUVluT1KTRw==
=1OCM
-----END PGP SIGNATURE-----

--8ZwLm31Fr6bPAHsP--

