Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1E79FC56
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggCn-0008QI-Nj; Thu, 14 Sep 2023 02:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qggCd-0008NZ-R3; Thu, 14 Sep 2023 02:51:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qggCb-0000jq-Fo; Thu, 14 Sep 2023 02:51:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 661125C05FB;
 Thu, 14 Sep 2023 02:51:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 14 Sep 2023 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1694674301; x=
 1694760701; bh=J/HLeLEXpeRVYhte1bdBX42F5BQJM/gXB81PJla/K6o=; b=o
 Kwy0E7VCCEK+XWLyhErTInkHrb44iLyQVytzAiM4h8y6FxUuUu1ExvO24nLvFZWp
 Kfdzno0HbJ7Whlx/yEK9795ISO46kSKRFvxKVkjvEd+rPO057Yz6IU5FO0bjUtiA
 q1gKRTm11FdumnkcqVve6igMdfdIDNnjcmcGhodhc3750yePx1E3M8Taw5vYFivC
 8nWmGWaKiM85Z0FBdsIBfA1bUqe46nI3m0YdHRQsB7lJPd7mtJuz5GG07PdkXx5T
 Ca8m6+IpZSiAmyc+7boNDWBVlMqNLOFtq6WRKZ2oyJNus6cJuo3eLGc+ht+w9CAB
 z5x946c2TSKsUK2ZK9P0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1694674301; x=1694760701; bh=J/HLeLEXpeRVY
 hte1bdBX42F5BQJM/gXB81PJla/K6o=; b=cTovbXHuwDSEFxUNy5T0hUuAtuV3T
 sdPtYkYgDTNzZawwyhzO3KkV2sfN4zI9uMUOIRNsiJ9OC769ZQ+G7dnMjn7I2a89
 2/FooRaaQ2o0FBqMaXzLIM7DJfoTigggjzhL7xCfW/CRNP+OvmCGyqWj9e7JrXyh
 haoqc6v5FdbAe8TWgvoHwrGidOcC0dvN/WIYzgT2vKPbSAQmuOP1FpJ85tF6ku9C
 3Tu7q74e1wQ8ewDidkKqxjc6ftyM+qY3bjL4k9WHiY/sNqWcssfojLXBpC2AqdAx
 8XqTEXttjfhihdnnTJEe6lFGzdqBJISG/LIXDbqhV4gUq0GOLzY/B0q2g==
X-ME-Sender: <xms:fK0CZdSvBR8ZY8iWMnK6C48aoAVNkrTnUKIsu6Rhe9RxeB32ucxbBQ>
 <xme:fK0CZWxxyogRQ8ApQgnLTzVDBf7zd_e1UcHiAKYiHTGCDpaN8D7FRGbIdp157GdGF
 Xp2M1PWA3oQmLINi3o>
X-ME-Received: <xmr:fK0CZS2rCU-mFnju7YRll6x_ZFsNqDEdd2IFVnPjIubD_luF2ztBWv3_ZJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiledguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpedtvdelleetkeekheeiveethfehkeffveethffgveekiedvieegfefgtdeu
 tdetveenucffohhmrghinhepqhgvmhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:fK0CZVC8R2-Ur06QQIA0qpvEowrln3NZBTbC6b5ojDk6SAGCiZDTYA>
 <xmx:fK0CZWjSvgprx6vcQutW2qPrAlvCThkirIHt8-vU8s47Dv-Z8hFQ2w>
 <xmx:fK0CZZqiD627QWyLkgQD3ih_iqCWzeaJLXluH_arjk2ArZG53VB6Bw>
 <xmx:fa0CZaxnKZTI56NnCIBLlrSxnZh2cGFwRNzwbYxq8jm61T1SEHAUVw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 02:51:39 -0400 (EDT)
Date: Thu, 14 Sep 2023 08:51:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v5 3/3] hw/nvme: add nvme management interface model
Message-ID: <ZQKtdSI-wZ20_V0F@cormorant.local>
References: <20230905-nmi-i2c-v5-0-0001d372a728@samsung.com>
 <20230905-nmi-i2c-v5-3-0001d372a728@samsung.com>
 <130f973070f4422e226a9e68218109094f0420fa.camel@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1B1Z7rKIwxgV248n"
Content-Disposition: inline
In-Reply-To: <130f973070f4422e226a9e68218109094f0420fa.camel@codeconstruct.com.au>
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


--1B1Z7rKIwxgV248n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 12 13:50, Andrew Jeffery wrote:
> Hi Klaus,
>=20
> On Tue, 2023-09-05 at 10:38 +0200, Klaus Jensen wrote:
> > >=20
> > > +static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest
> > > *request)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 uint32_t dw0 =3D le32_to_cpu(request->dw0);
> > > +=C2=A0=C2=A0=C2=A0 uint8_t identifier =3D FIELD_EX32(dw0,
> > > NMI_CMD_CONFIGURATION_GET_DW0,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IDENT=
IFIER);
> > > +=C2=A0=C2=A0=C2=A0 const uint8_t *buf;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 static const uint8_t smbus_freq[4] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* succe=
ss */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01, 0x00, 0x00,=C2=A0=
=C2=A0 /* 100 kHz */
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0 static const uint8_t mtu[4] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* success */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x40, 0x00, /* 64 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00,=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* reserved */
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0 trace_nmi_handle_mi_config_get(identifier);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 switch (identifier) {
> > > +=C2=A0=C2=A0=C2=A0 case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D smbus_freq;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_=
UNIT:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D mtu;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nmi_set_parameter_error(n=
mi, 0x0, offsetof(NMIRequest,
> > > dw0));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 nmi_scratch_append(nmi, buf, sizeof(buf));
> > > +}
>=20
> When I tried to build this patch I got:
>=20
> ```
> In file included from /usr/include/string.h:535,
>                  from /home/andrew/src/qemu.org/qemu/include/qemu/osdep.h=
:112,
>                  from ../hw/nvme/nmi-i2c.c:12:
> In function =E2=80=98memcpy=E2=80=99,
>     inlined from =E2=80=98nmi_scratch_append=E2=80=99 at ../hw/nvme/nmi-i=
2c.c:80:5,
>     inlined from =E2=80=98nmi_handle_mi_config_get=E2=80=99 at ../hw/nvme=
/nmi-i2c.c:246:5,
>     inlined from =E2=80=98nmi_handle_mi=E2=80=99 at ../hw/nvme/nmi-i2c.c:=
266:9,
>     inlined from =E2=80=98nmi_handle=E2=80=99 at ../hw/nvme/nmi-i2c.c:313=
:9:
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29:10: error: =E2=
=80=98__builtin_memcpy=E2=80=99 forming offset [4, 7] is out of the bounds =
[0, 4] [-Werror=3Darray-bounds=3D]
>    29 |   return __builtin___memcpy_chk (__dest, __src, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    30 |                                  __glibc_objsize0 (__dest));
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> ```
>=20
> It wasn't clear initially from the error that the source of the problem
> was the size associated with the source buffer, especially as there is
> some pointer arithmetic being done to derive `__dest`.
>=20
> Anyway, what we're trying to express is that the size to copy from buf
> is the size of the array pointed to by buf. However, buf is declared as
> a pointer to uint8_t, which loses the length information. To fix that I
> think we need:
>=20
> - const uint8_t *buf;
> + const uint8_t (*buf)[4];
>=20
> and then:
>=20
> - nmi_scratch_append(nmi, buf, sizeof(buf));
> + nmi_scratch_append(nmi, buf, sizeof(*buf));
>=20
> Andrew
>=20

Hi Andrew,

Nice (and important) catch! Just curious, are you massaging QEMU's build
system into adding additional checks or how did your compiler catch
this?

Thanks,
Klaus

--1B1Z7rKIwxgV248n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmUCrXUACgkQTeGvMW1P
Dekx4wgApZQGNZtaA6hPhghkuAImuNPkRQCLDO6+lYjNM7hstaOPddfh4UxeWscM
1mb79VN35VpYbPkMiRh/nN5eMx/XHkBcStCCrEKSexjaplpSap6/9jUs/ZUENg5c
wRyLPE7OMU+nGtixWgJVwNBAsVouM/Wz29/s70YJcVfCjXNpI5WU+mHmZ9npDRDH
Izu2mB9z+m355KLbG3PbcNjh4hjGBt0GX38AMwjucExko87cWmlEQflxeviEwdbC
nR2N/PVXpsSo9NUHMBBlIy1Uq0YlGZHSoR3ZIVYhMXgczIS3H2LsyHWXv43yvZnd
L5rDKIUwV+mIDtAZyS03t6+PKI0Ymg==
=NgxH
-----END PGP SIGNATURE-----

--1B1Z7rKIwxgV248n--

