Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47184838D2A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:16:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSElQ-00010b-Lk; Tue, 23 Jan 2024 06:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rSElH-0000wq-K8; Tue, 23 Jan 2024 06:16:11 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rSElC-0005JD-K7; Tue, 23 Jan 2024 06:16:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0EAAA5C02AF;
 Tue, 23 Jan 2024 06:16:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 23 Jan 2024 06:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706008563; x=
 1706094963; bh=OqUxfiJ4GdFaBfv+IIrEo3EQFX8mHDK8EAyKJs5Ygfw=; b=V
 z0IJDfptG1+Ue2XPzBfVB9GsztqRzKfN24rCpkAaBbbJQlhr4JlW5c6W01Bx389c
 caMYVEZ+uos9hFT62qCUx2AiPob5Ufy1p8+iW9gplgDZBqJeBxF55WG81DucpiNh
 bvByPgMKgqhDJs31Jt8/iP+H6UMY/FKO0I16U378L/WPl6LwJkQ6r+yGKanfhImV
 z0y54UwO+PIJNmAVAlFJaCRX8tJnuUxp4giwg0Ng9K/SRiXYJKqi1UufB1hSYGQz
 VOrr7uS2nAp8j6bbmqtqp5qQ9n6WyIjVfcdCnklTKTiOKN5co+fs1GZ1ePGxQZM7
 u2xr64nPQAqyBwRRu4Rvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1706008563; x=1706094963; bh=OqUxfiJ4GdFaBfv+IIrEo3EQFX8m
 HDK8EAyKJs5Ygfw=; b=cT1RqNjy6V9oylpG6FxZAZiYq9CuvPOmdG10tOQutHu1
 Y7WbDn1QGzNDwCRgpSVgewhC4DkjJQfD3RCLl3udq2toJT/uHIt+OC/bm5u8ac/d
 y4AGCsGdgDU4Z6336IoPBWjCqWiD1lgQBNfoXsR9TsNwwAWCC3Zx6w4gbMAl+PCe
 XTI0gd4eOQQWOXN2kWFQdxkx8fA9+f6PHn8Iqs3/FTX5VnARjZyBlNWYgQib3m4h
 Ue9YiNfI2ldIBjiE+iCmYY3NJBvGGeTjRaRkVVZl4sh3XrSYAFmKBZJZF3cRvbDK
 37z8Jl3SiVFuat/42tB0N4CYMuuQB4OZGiHvyIxodQ==
X-ME-Sender: <xms:8p-vZZoUdQQN_eNdBv-a5T9PwDheh9q6CjnihxEy2PmgT2aMCkAemQ>
 <xme:8p-vZbo9SujAc3HUhFgicrQJt77enktpo9F4jnNZrlHleREmFG-YcjvzSgG8bKJuU
 iJzFP2ZPSQjX0nmW-o>
X-ME-Received: <xmr:8p-vZWO86cV0MoxDTcieLAor8f9j30WQdVyxe4_Qvmb4gGGkVkftorqMYTGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:8p-vZU6U7Q1dA55hNpGBK_rrfjngt0d0aaAg2rzp57wA1uTWObSAtw>
 <xmx:8p-vZY79kfk_xHt5ZGCXOEH1EZSPNiDz7R7dTJNUYL6XFoeBWIEnbQ>
 <xmx:8p-vZcglxdBWZD33qNq3yUjCBuFVwm6Xt8S84Rq-k0JxUiC0uxUzig>
 <xmx:85-vZSQ0oC1FW5esszRC_LgV7t66WAnTQ7IMf2bJBy69MTNURStYxw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 06:16:01 -0500 (EST)
Date: Tue, 23 Jan 2024 12:15:56 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Damien Hedde <dhedde@kalrayinc.com>
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, Titouan Huard <thuard@kalrayinc.com>,
 Hannes Reinecke <hare@suse.de>
Subject: Re: NVME hotplug support ?
Message-ID: <Za-f7Mp8RnBiynZ0@cormorant.local>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rnf48O8FfmPNYxX9"
Content-Disposition: inline
In-Reply-To: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
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


--Rnf48O8FfmPNYxX9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 23 10:59, Damien Hedde wrote:
> Hi all,
>=20
> We are currently looking into hotplugging nvme devices and it is currentl=
y not possible:
> When nvme was introduced 2 years ago, the feature was disabled.
> > commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
> > Author: Klaus Jensen=20
> > Date:   Tue Jul 6 10:48:40 2021 +0200
> >
> >    hw/nvme: mark nvme-subsys non-hotpluggable
> >   =20
> >    We currently lack the infrastructure to handle subsystem hotplugging=
, so
> >    disable it.
>=20
> Do someone know what's lacking or anyone have some tips/idea of what we s=
hould develop to add the support ?
>=20
> Regards,
> --
> Damien=20
>=20

That's not entirely true.

The *subsystem* is non-hotpluggable, but individual controllers can be
hotplugged. Even into an existing subsystem.

However, you cannot hotplug pci devices unless you set up a pcie root
port. Say,

  -device "pcie-root-port,id=3Dpcie_root_port0,chassis=3D1,slot=3D0"
  -device "nvme,id=3Dnvme0,serial=3Dnvme0,bus=3Dpcie_root_port0"

nvme0 can then be removed with device_del and added back as a new device
with device_add.

--Rnf48O8FfmPNYxX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmWvn+wACgkQTeGvMW1P
DemFUQgAlAxy0GXSZsQbyXd/4iAyJODvoVHTO/mN8MOpFvb583V0ycJ7Mn0GWQ5I
1bNGLKiBQMjasZS4qFI2Iqtil5RicbDGHTDERz81JC+QK7+sJKeX9aHaUaVatxOE
bngkm3yRqoTQ9AEDr05lDFjmvN5Yl9laL19MpJHoM3QpG+myVyfcDsMc5jiZcyQk
VN4/KBxkErR/4n/DrdFu0OeajL5N6w6jVEWnATBA1JeJpw7YbFxVZI1SUNAWUuxx
AATcgq6KRmeP9vpjBskDeUDh/jTKMMUcd6xb4uu1Vpp4WnTK9ehQ7T+DJPOszx2K
NW7G8OtNnbH06IJKWqvsN2HpuNxxsg==
=Z2XN
-----END PGP SIGNATURE-----

--Rnf48O8FfmPNYxX9--

