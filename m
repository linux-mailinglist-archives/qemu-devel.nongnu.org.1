Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A7757A86
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiyc-00059h-7y; Tue, 18 Jul 2023 07:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qLiyZ-00058j-0O; Tue, 18 Jul 2023 07:34:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qLiyW-0002VF-PT; Tue, 18 Jul 2023 07:34:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id D01365C00BE;
 Tue, 18 Jul 2023 07:34:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 18 Jul 2023 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1689680077; x=
 1689766477; bh=KjzJKVrgUy3DJIlC+R6FBP/T/cCWgdfOjfxttQjI6zw=; b=k
 7MjYVn7YbqGGdZgWm/Sdpd/wTAgdKta7+b0A5/+sUaScgSyOLD8K7ahBpnB73k7A
 E36m3P8FcU8zeSBZGHLF54/trH3XB1XLUaHhlWTkdm0VrqANsQ+tN9IhBKfQBZuk
 RBnUIuyCMOyVT2Q7VPXnXGNmOhh3IndnLtKQ2EqwRsRFbJ9udIg6rbcHmnF4eO3k
 9S/6DsO+GsU80TLOagVfEVTJKxy3IfDAh2WOxwRoClR89dhfictCGXPXZbaLkank
 m+yVZgzdOY2riVF3bd8YS86YplrN5z1rQm4TL0wine9vjfQvA4ZQuzJTSNwPQgyU
 CTNwm/EYAd2nUSCfodm/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689680077; x=1689766477; bh=KjzJKVrgUy3DJ
 IlC+R6FBP/T/cCWgdfOjfxttQjI6zw=; b=U1E6uEALyMMPgIP/3WP+RBQDpiv1A
 UNytdpt5ihDGSxOlCdi/qTDHzeXtnHjdvYhc4z6/9kCWxSdzVWlsYXpFyGFDH1He
 MN5w/HpT0DZLPjTckHoOVt8N+LbP8QlTbW8DBLv2pBcflaWLFHihrL7KGhvvvDE8
 FCQX3famv9yQiKWUglI3eAK5gcGoPPqPWr9BM+5Gm4OOuRU+wxHK9VyZPLXsRYK0
 +PLvh1K9HNmGO25E39yfR1cpS0BFH4D0uNezA/9TR3z1IqtYYSfrpUO4edNB95pT
 9XjZMXYV4T8BQh8LR0sWPOIvzuijjnixHzHMPf3AEU7/dw54+1vCAlaxw==
X-ME-Sender: <xms:zXi2ZClvWEt9uZS9sqyn6ttJezda-MPHJBkVPg1tJ7VdtN8KmkM8Dg>
 <xme:zXi2ZJ1GSNgqn2FperVFdLmfEBfMQ5RjEfcE9obo9UHbcFLCMHh1fa21cZafsdBFI
 DLcjvVuUQ5mI9OZhKU>
X-ME-Received: <xmr:zXi2ZAp3UzwbPlv_TQT0fiPpr3nmpfxMPrkxJUCGSaNKX4bYcC6T9dggKMw7k9cRtEWv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdegtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:zXi2ZGkXmFrc55YHlIxjVxdnRayvk1hSlOmtUfEVOw643i45aFdT1w>
 <xmx:zXi2ZA0S2hZrJM1mUaUSuRnXeOVvetrIzu3K_EoOvlCyS3NmnPEQ_g>
 <xmx:zXi2ZNv58xGJ0AFr_DFqBfwhzBpw2Zd656QQ_3mtfb0Z2GlmPQSzJA>
 <xmx:zXi2ZBmydEwskvIDT_JMxQZRIUjQDqULx-_92GO95kD51mr1bD9NUw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 07:34:36 -0400 (EDT)
Date: Tue, 18 Jul 2023 13:34:34 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Message-ID: <ZLZ4yhYyfNzHqoDn@cormorant.local>
References: <20230718103511.53767-2-its@irrelevant.dk>
 <376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dXrV9f8KrpIPzBH3"
Content-Disposition: inline
In-Reply-To: <376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--dXrV9f8KrpIPzBH3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 18 13:18, Philippe Mathieu-Daud=C3=A9 wrote:
> On 18/7/23 12:35, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
> > doorbell buffers"), we fixed shadow doorbells for big-endian guests
> > running on little endian hosts. But I did not fix little-endian guests
> > on big-endian hosts. Fix this.
> >=20
> > Solves issue #1765.
> >=20
> > Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support=
")
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 8e8e870b9a80..dadc2dc7da10 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -6801,6 +6801,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
> >       PCIDevice *pci =3D PCI_DEVICE(n);
> >       uint64_t dbs_addr =3D le64_to_cpu(req->cmd.dptr.prp1);
> >       uint64_t eis_addr =3D le64_to_cpu(req->cmd.dptr.prp2);
> > +    uint32_t v;
> >       int i;
> >       /* Address should be page aligned */
> > @@ -6818,6 +6819,8 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
> >           NvmeCQueue *cq =3D n->cq[i];
> >           if (sq) {
> > +            v =3D cpu_to_le32(sq->tail);
> > +
> >               /*
> >                * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
> >                * nvme_process_db() uses this hard-coded way to calculate
> > @@ -6825,7 +6828,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
> >                */
> >               sq->db_addr =3D dbs_addr + (i << 3);
> >               sq->ei_addr =3D eis_addr + (i << 3);
> > -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail=
));
> > +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
>=20
> Or use the PCI DMA ldst API which does the swapping for you:
>=20
>   stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
>=20

Nice! That's definitely preferable. I'll queue that up for next, but
leave this patch as-is since it's been tested on a real big-endian host
and gotten its tags ;)

--dXrV9f8KrpIPzBH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmS2eMkACgkQTeGvMW1P
Dem8iAf+O5ypu0RWOG6LC0gFGSHZ/vJ+YT6ye5p/67MxYCyWFyDXWa1Xbr3fwO6e
2Rs5xI4QigJdgLZJXUO70LrusAERFeJ23I3LjusEMtqbmt/RqZWfE4NKBkaJWpfe
8PxLmGhD+5IKR12UJH6tJ9rggA+npW71bsuruh5+dP2lswIGnT6FzlIo2OFgkfq3
gfs/G0jxx/r3KJOttW3/4vJXp4XTfJQCljbpHRkjCrKm6V1Ipo/LIATlZRWQ5km2
aNmFg6KFjUz1k/AcT1VlhJv85DksOcCtg2ZzT42XfNQtfQ5bfU5VAKikG0fZeN1Q
QZEMZX/d7KRSTFFlVqVG2rqj3Jo4CQ==
=ZrUx
-----END PGP SIGNATURE-----

--dXrV9f8KrpIPzBH3--

