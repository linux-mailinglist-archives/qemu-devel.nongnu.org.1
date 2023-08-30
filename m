Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F478D376
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFCC-0006Qt-Hs; Wed, 30 Aug 2023 03:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qbFCA-0006Ql-9l
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:00:54 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qbFC7-0003S5-Qk
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:00:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 0EE9032009EE;
 Wed, 30 Aug 2023 03:00:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 30 Aug 2023 03:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1693378848; x=
 1693465248; bh=ugCFq4oJJsNG9ZzpBdEl6y+K7MzvIfXbTPmWFEwRE2g=; b=H
 YZcP8MWDFndwjxRC9oUxVH48WtXmKoPS5oeS260iddikqxBbXoKalcgOnGn+gMWX
 hSxsWMXXbvftzESwzFHbExycIZfMCLRACnzssn56m3LPRlIdrVYqZ6jsmXV7XVjU
 N+YYewLPFcEb3Ey2wUO2GRm0DYUxffJZumBQHQzJv44PTMESS/SqrKGZNILKLVq8
 orxGWtmcP6ExUskfuC++skliBC7C7fxClWdFa8mhbEZxMtfq4Gv0TfGcwiyO/Tpn
 iVdeP7SdrYPpsKHBwLfeVVRDSPRbLykxeAXFEcthNVHgTpac6jNI1sPImBPiZbrN
 9goWkGN2I79T7WbfMeyOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1693378848; x=1693465248; bh=ugCFq4oJJsNG9
 ZzpBdEl6y+K7MzvIfXbTPmWFEwRE2g=; b=SxP5Wb3GH8GxA4trd6qXnUVe1VzIM
 K+xFmSK4BKZMODaqTro62v7er3CSd+GTRmtfTLjKvxt+23DVacu5MSI64QNP6XU+
 M2axIRlppETdV+KFD7pWfvvhLA1zzqvKiDjVkHpRv2kmVauEh5ZJsf9s6pU+CSSV
 oyYVDy4tF7xNyAZU3gB7ViZlgh1aDsyj6v7EeIIGMsJD9yZvlD1bp92ctTmns2nU
 63UbjeEiiiu7tPeaEm/XmmQHPsg7PxjTKhCvhTMW7Sxt7TgPjJBAy8AnmDINxk6Z
 FPyjdc5R1Qev0s+N6dk5F5rHmzEsBKrpkKrKGjtxfFgmcXuo2wlEL9AXw==
X-ME-Sender: <xms:H-nuZNoN1-ophH1ac-gF0z_K_FMLrsjn8RB1GWsfLZ6o3jkMhiu8fQ>
 <xme:H-nuZPrd8Ey8ZzhCuIdfc5LhLWdw1iQIgFyhY6d57vhB1H3h_2YoU4BuTVkpfsgYP
 hosktvAXVMAqaCVSaU>
X-ME-Received: <xmr:H-nuZKN31Y8j_m_fh8PyJvfLNx22Mzx0KLbp9IweL4ROmzC60iFlFmvsDlWcrM7UsSbaavBig2yFy6-O_h18A3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedguddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeffuddvhfehjedugfeijeeuieelgeevuddvlefhkefhgfettefftddvkeev
 ieelfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgu
 kh
X-ME-Proxy: <xmx:H-nuZI7Oh_DxCSFwrMLcps75rMSZlQTGFevs3Gc7SX8AeUMEPj7FGQ>
 <xmx:H-nuZM5KkjjXseEfAdejLEtNNZ833Xvi3dFGaUnK6mpIHR76HTJBPQ>
 <xmx:H-nuZAiKTaA_ET-hODYnqYDK925ao8taeCuuD5jHk6Pjt46UIRpqhg>
 <xmx:IOnuZLbalbLR0XOnfzkle_x3bgfT_AX6yljD0bTWc0mII5XD1qjzJA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 03:00:47 -0400 (EDT)
Date: Wed, 30 Aug 2023 09:00:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: www <ouyangxuan10@163.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jeremy Kerr <jk@codeconstruct.com.au>
Subject: Re: [qemu]: How to use qemu to =?utf-8?Q?e?=
 =?utf-8?Q?mulate_MCTP_Over_SMBus_devices=EF=BC=9F?=
Message-ID: <ZO7pGmqwdc3fRx_Z@cormorant.local>
References: <673a6186.280a.18a449e0da2.Coremail.ouyangxuan10@163.com>
 <037e85aa-9d0a-f398-25a4-f23991c8942b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0YcExmJxFIHSTjtF"
Content-Disposition: inline
In-Reply-To: <037e85aa-9d0a-f398-25a4-f23991c8942b@kaod.org>
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--0YcExmJxFIHSTjtF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 30 08:54, C=C3=A9dric Le Goater wrote:
> Hello Byron,
>=20
> On 8/30/23 06:05, www wrote:
> > Dear Sir=EF=BC=8C
> >=20
> > I have a few questions for you to ask.
> > 1. According to my data collection, MCTP function should not be impleme=
nted in qemu.
> > I would like to ask you how to simulate MCTP Over SMBus devices=EF=BC=
=9FOr do we have a device program with similar functions for reference?
> > (The biggest problem with simulating MCTP Over SMBus devices is that th=
ere is a master-slave switch between request and response.
> > It requires the device to actively respond to the requestor, that is, t=
he device initiates the reply.)
> >=20
> > 2.=C2=A0Among the BMC functions, the communication between the BMC and =
the OS is a very important and basic function.
> > Is there a way to simulate the communication between BMC and OS to test=
 device drivers and applications?
> > If we want to implement this feature, how do we go about it?
> >=20
> > I am looking forward to your reply.
> > Byron
>=20
> Initial support for MCTP over I2C is being discussed here :
>=20
>   https://lore.kernel.org/qemu-devel/20230823-nmi-i2c-v4-0-2b0f86e5be25@s=
amsung.com/
>=20
> This is not my domain of expertise. So I am adding a few people who could=
 help.
>=20

I think the already upstreamed support for asynchronous send
(i2c_send_async + i2c_ack) along with the above series should get you
started.

The series referenced by C=C3=A9dric implements an abstract mctp device that
other devices can derive from. This model implements MCTP control
message handling as well as handling the actual I2C transport
(packetization).

Thanks,
Klaus

--0YcExmJxFIHSTjtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTu6RoACgkQTeGvMW1P
DenCFgf8DV4CFVThINWNvCv42Tnp5FbLRIZhQot8EINdsPl2nVS099TUmsgixdnM
S10QEWCbA3DchmHaNlYJmKFTm7sW2/5umk+lrn8plXsoodVTQTN6Bpj51pOzfcAq
DWOKPURhrlp+8pvIm0H+a9lZt5YlqgQuw/Wyvyc621GbJ03ODo68o5YUkvMylkzW
+CwSkNnd7AYWf8l9Z8lcojQBj1ItOlHpzmus76ZMN4EN5qcN+Ffh2NHMHkuzEDyO
Qj9FoY33xcFOmXh5kGs1tYyJxq5gCPSl+5Jr8/VP7xx6REDY1tbIh/WuRsfhfXPu
cZldUdwEiJQjpHFijplJd3NCwQXVXQ==
=KLkz
-----END PGP SIGNATURE-----

--0YcExmJxFIHSTjtF--

