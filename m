Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EFF7915DF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd79K-0003oW-Bz; Mon, 04 Sep 2023 06:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qd79H-0003ni-It; Mon, 04 Sep 2023 06:49:39 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qd79D-0001N5-7q; Mon, 04 Sep 2023 06:49:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 6B77532007F9;
 Mon,  4 Sep 2023 06:49:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 04 Sep 2023 06:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1693824568; x=
 1693910968; bh=tJPEj+fjNH7kCozMYcrY9kliQQZ3lOfOA03Uorp7DpM=; b=S
 0pDyBJzmozYPOEJzKkl8VShGYLbOqdOEqteRhzlix8B76uZijeLn++c33j3ZVkXC
 AvabNK3oj9ng0/2Y7MFK/cvzDLm81X3DkuJIok3ws196plf2K2kB2emovx3VDADI
 B/w1A2EUo1lldUV1nh+esrZ5scgpfLyBlrk2CXrUn+o0OYo56/kIdw0lp5TfsOgP
 7xp0wJm/mospxNOeImHTD8dRrqXub/MVNOUAaWO1xe3Pvt+0ga8KgPtzNBEzEMij
 /wMn48Yu6+tfru/8PGNHOskot54inws2cZSjzb4Xx8h3DLcqI/LGqLc1oBjRaffm
 yiFNY1LaFqJWEtPvtg1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1693824568; x=1693910968; bh=tJPEj+fjNH7kC
 ozMYcrY9kliQQZ3lOfOA03Uorp7DpM=; b=Ctj3j/0HHwbnjj0WdDCeEgm6Cl9/v
 niygA4zYCgFe22yeY1ZregQ43/QmKbbsqaWIET9eQt4BxRkGFPc8XcbnPnXKXDQ/
 EFOzRYCNasGeamQkZpKwKuoe1wc+tkD7b60Xn5Q6lducKvY8pyo8WuYIFRIsgez0
 yva+vNqwksFgdyEXqGiYE8mnzUFWWtLYNaXPfEK+pJMH/AFKQh6vWZphJfQyO7lN
 qpsoL+pGn3iVZ0szIb//jyBY3qsJvUgyYbjCMQHRW0Vl/krfeBBv8oPDokX/+cEX
 OOeD38t2IU3mVumlzn5WyunPHK3EtpcDuoKZCw2hyc5wDY4SMvE+9FQQw==
X-ME-Sender: <xms:Nrb1ZEe0ACtHUGWWj8w7TsFpuwJAMOjF0vMaCBy57Jjqfwkkmmk8vQ>
 <xme:Nrb1ZGOorvxvBLIgrc8iHWWhu_Wb0HEZeDwpdLcMVBfetral_d3v02n9XhFacAZHx
 5LJQG3zb3MabvYir10>
X-ME-Received: <xmr:Nrb1ZFj8So7q109l3fT8v402x4vRJx4FgH-SmZNrw5xoLZWWCEqTF1UbEYBj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepffduvdfhheejudfgieejueeileegveduvdelhfekhffgteetffdtvdekveei
 leefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Nrb1ZJ_tpyqsqai-N4dsVhIay6lQ2LlnBZBVq7lxkRvvX2SwKKfT0w>
 <xmx:Nrb1ZAvL1DWf6cDmHRyvz59Fn_3lLD8p8WRzFNfXkXn5mZrH7OzlsA>
 <xmx:Nrb1ZAHyEFMqcowbiJjsA6P2RuFPQSsF2DELb_kY0LjbjGlUeuSsGQ>
 <xmx:OLb1ZNNJIU6BliJNYVbHeSvsfSiDwrlrvivHLUAyUoaIf1O3N3HL2g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Sep 2023 06:49:26 -0400 (EDT)
Date: Mon, 4 Sep 2023 12:49:20 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/3] hw/i2c: add mctp core
Message-ID: <ZPW2MFWp6mIvReS5@cormorant.local>
References: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
 <20230823-nmi-i2c-v4-2-2b0f86e5be25@samsung.com>
 <20230830153123.00006cc4@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8/teniqNx7Xmj1mb"
Content-Disposition: inline
In-Reply-To: <20230830153123.00006cc4@Huawei.com>
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


--8/teniqNx7Xmj1mb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 30 15:31, Jonathan Cameron wrote:
> On Wed, 23 Aug 2023 11:21:59 +0200
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
> > Squashed a fix[2] from Matt Johnston.
> >=20
> >   [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonatha=
n.Cameron@huawei.com/
> >   [2]: https://lore.kernel.org/qemu-devel/20221121080445.GA29062@codeco=
nstruct.com.au/
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> I made the minor changes to the CXL FM-API PoC to use this and all works =
as expected so
>=20
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
>=20
> Some minor things inline.  With those tidied up or ignored with clear rea=
soning.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
>=20
> > diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
> > new file mode 100644
> > index 000000000000..217073d62435
> > --- /dev/null
> > +++ b/hw/i2c/mctp.c
>=20
>=20
> ...
>=20
>=20
> > +static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
> > +{
> > +    MCTPI2CEndpoint *mctp =3D MCTP_I2C_ENDPOINT(i2c);
> > +    MCTPI2CEndpointClass *mc =3D MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
> > +    MCTPI2CPacket *pkt =3D (MCTPI2CPacket *)mctp->buffer;
> > +    size_t payload_len;
> > +    uint8_t pec, pktseq, msgtype;
> > +
> > +    switch (event) {
> > +    case I2C_START_SEND:
> > +        if (mctp->state =3D=3D I2C_MCTP_STATE_IDLE) {
> > +            mctp->state =3D I2C_MCTP_STATE_RX_STARTED;
> > +        } else if (mctp->state !=3D I2C_MCTP_STATE_RX) {
> > +            return -1;
> > +        }
> > +
> > +        /* the i2c core eats the slave address, so put it back in */
> > +        pkt->i2c.dest =3D i2c->address << 1;
> > +        mctp->len =3D 1;
> > +
> > +        return 0;
> > +
> > +    case I2C_FINISH:
> > +        if (mctp->len < sizeof(MCTPI2CPacket) + 1) {
> > +            trace_i2c_mctp_drop_short_packet(mctp->len);
> > +            goto drop;
> > +        }
> > +
> > +        payload_len =3D mctp->len - (1 + offsetof(MCTPI2CPacket, mctp.=
payload));
> > +
> > +        if (pkt->i2c.byte_count + 3 !=3D mctp->len - 1) {
> > +            trace_i2c_mctp_drop_invalid_length(pkt->i2c.byte_count + 3,
> > +                                               mctp->len - 1);
> > +            goto drop;
> > +        }
> > +
> > +        pec =3D i2c_smbus_pec(0, mctp->buffer, mctp->len - 1);
> > +        if (mctp->buffer[mctp->len - 1] !=3D pec) {
> > +            trace_i2c_mctp_drop_invalid_pec(mctp->buffer[mctp->len - 1=
], pec);
> > +            goto drop;
> > +        }
> > +
> > +        if (!(pkt->mctp.hdr.eid.dest =3D=3D mctp->my_eid ||
> > +              pkt->mctp.hdr.eid.dest =3D=3D 0)) {
> > +            trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
> > +                                            mctp->my_eid);
> > +            goto drop;
> > +        }
> > +
> > +        pktseq =3D FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, PKTSEQ=
);
> > +
> > +        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, SOM)) {
> > +            mctp->tx.is_control =3D false;
> > +
> > +            if (mctp->state =3D=3D I2C_MCTP_STATE_RX) {
> > +                mc->reset(mctp);
> > +            }
> > +
> > +            mctp->state =3D I2C_MCTP_STATE_RX;
> > +
> > +            mctp->tx.addr =3D pkt->i2c.source >> 1;
> > +            mctp->tx.eid =3D pkt->mctp.hdr.eid.source;
> > +            mctp->tx.tag =3D FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLA=
GS, TAG);
> > +            mctp->tx.pktseq =3D pktseq;
> > +
> > +            msgtype =3D FIELD_EX8(pkt->mctp.payload[0], MCTP_MESSAGE_H=
, TYPE);
> > +
> > +            if (msgtype =3D=3D MCTP_MESSAGE_TYPE_CONTROL) {
> > +                mctp->tx.is_control =3D true;
> > +
> > +                i2c_mctp_handle_control(mctp);
> > +
> > +                return 0;
> > +            }
> > +        } else if (mctp->state =3D=3D I2C_MCTP_STATE_RX_STARTED) {
> > +            trace_i2c_mctp_drop_expected_som();
> > +            goto drop;
> > +        } else if (pktseq !=3D (++mctp->tx.pktseq & 0x3)) {
> > +            trace_i2c_mctp_drop_invalid_pktseq(pktseq, mctp->tx.pktseq=
 & 0x3);
> > +            goto drop;
> > +        }
> > +
> > +        mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
>=20
> Given this returns -1 on error should probably handle errors.
>=20

Yes.

The event callback should only potentially return -1 in the case of
I2C_START_SEND, so I just do a `goto drop` here.

>=20
> > +
> > +        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, EOM)) {
> > +            mc->handle(mctp);
> > +            mctp->state =3D I2C_MCTP_STATE_WAIT_TX;
> > +        }
> > +
> > +        return 0;
> > +
> > +    default:
> > +        return -1;
> > +    }
> > +
> > +drop:
> > +    mc->reset(mctp);
> > +
> > +    mctp->state =3D I2C_MCTP_STATE_IDLE;
> > +
> > +    return 0;
> > +}
>=20
> ...
>=20
>=20
> > diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
> > new file mode 100644
> > index 000000000000..fccbf249cdbe
> > --- /dev/null
> > +++ b/include/hw/i2c/mctp.h
> > @@ -0,0 +1,127 @@
> > +#ifndef QEMU_I2C_MCTP_H
> > +#define QEMU_I2C_MCTP_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/qdev-core.h"
> > +
> > +#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
> > +OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_EN=
DPOINT)
> > +
> > +struct MCTPI2CEndpointClass {
> > +    I2CSlaveClass parent_class;
> > +
> > +    /**
> > +     *
>=20
> Drop the blank line for consistency with the other comments.
>=20
> > +     * put_buf() - receive incoming message fragment
> > +     *
> > +     * Must returns 0 for succes or -1 for error.
>=20
> I would expect any negative to count as error rather than just -1.
> Also, simple imperative should be clear enough
> 	* Return 0 for success or negative for error.
>=20
> > +     */
> > +    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
> > +
> > +    /**
> > +     * get_buf() - provide pointer to message fragment
> > +     *
> > +     * Called by the mctp subsystem to request a pointer to the next m=
essage
> > +     * fragment. The implementation must advance its internal position=
 such
> > +     * that successive calls returns the next fragments.
> Subsequent call with return next fragment.
>=20
> Up to the implementation to decide how it does this.
>=20
> > +     *
> > +     * Must return the number of bytes available.
> 	Return number of bytes in message fragment.
>=20
> Available might mean in all fragments.
>=20

Thanks for these suggestions, I worked that in.

--8/teniqNx7Xmj1mb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmT1ti8ACgkQTeGvMW1P
DekUqwgAljYNSoFtVO4IovqEhjrqkL9wIyfFJiy66EuJwmZfNb6LY2Xx80J0aix8
ZUjBztcDeFGvOKZm9dimvSh8HrExMOu7HbFQm8BsFuP1Y8rZ9wLutMmW6luFCfni
e6DLUv2VRZJJt8KkGgOa+qcqNbBAZ7qBuWDKCNzlbvYBFJ3ofofArXySfwiCRwfY
moBbQAWVB4WQJ+JneD11Sn/Y9Nt84OsY8vncN2LmaApNgVlE7yoVO7+T95KMc7xr
8GaLPEjAPd0mEevgQU5KSyE6quPiTeGHm0uOJ2v7wTtLO9ctOJXRyUCINLiSprfj
Flokh9VcymJTAXJO+2mBCv6vZWggFQ==
=xH9s
-----END PGP SIGNATURE-----

--8/teniqNx7Xmj1mb--

