Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941D7D66AC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qva6U-0001nM-SO; Wed, 25 Oct 2023 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qva6S-0001kR-Eg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:23:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qva6Q-0000aa-6l
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:23:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id E07815C028D;
 Wed, 25 Oct 2023 05:22:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 25 Oct 2023 05:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1698225778; x=
 1698312178; bh=4ypX31g/i13YoSC7fP57RPLF8i1N4QOhSeCrwMI9BKk=; b=F
 GduFpBGxfi1v4MhbUty1quZRJ2ZxIWvsVON3n5RdG7GDR4rIgug9WEFF3VFght3A
 JpQ7z/Gx300eZ6vacrDPjAO/9SMGbDK6NVTnNRE+QZKnFY00wOXvZIPQIIjMd9zw
 Z3fgGdWtxPmFoSU+xO9MfaqSBT/YK2GrAGUICXVLtPDxea/RNZJLcwzpGUXDLf5s
 eIkfqVxtGQZgxFW/jFrTsvoiC6Z9wnx2+Gw9ZLd1j6zoo/oVPziU0LGKdYoSC5hE
 WIupz6G/So2paEd/3lMJPdg0uUsIQsoCQubXw9XXSX7EOaGSAD9vLy4urFBebj72
 8zfNYXnaQSIz4QsvTEJBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698225778; x=1698312178; bh=4ypX31g/i13Yo
 SC7fP57RPLF8i1N4QOhSeCrwMI9BKk=; b=FAML3nuVmwgT2Dqw8vPhHfzoeoAsl
 sKSl5N/v8GWS9Y3rB7OzKQVbUCKmPmANhPJEFYR5097ai+bnhe8zbmwvOw541mrl
 baSAfedzmz/uElMNtG0Kju/HyJf+vy1VPeC/v7iRN7PmP6dU4Tib2fuEtIjsalLh
 /W2BvD0xNU7UkZBwSQPEnnHplL32NFQvAWjae+OIF+0rx8ld0oYh9T/6ltUHUphg
 7CkVkKIW55a0SxfcYDcpLg5IVyexgcIeVz9FzMqHuRgfxfDTBfqpdvZUGP5Al40Q
 D9pb5/AtC0ld7xxRTr+cp65ibKX6X2fxzyp71HT/3NxoXdCo0DaijdcLg==
X-ME-Sender: <xms:cd44Zbn2GqSZMEvfSvHK1zdi72O_CaEOGzi65sQhLdBZ3E0JUEVx5g>
 <xme:cd44Ze1ep0FMncyJKoMIhOUb_wAT3m4bXMLiRBIuo5awQIrbe22gr9RkDCGfsXdE-
 djY7l7CPoeg4Y27p7M>
X-ME-Received: <xmr:cd44ZRqxaFNMdlssLRYO3qY0lyD3sU3m2zoz5d5bDHZkiR4lnwprwHzxp-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejiefftdeuuedugeejtdevleehleegleduvedvkefgudfhleetjeekgeeutdeg
 geenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhnvhhmvgigphhrvghsshdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhs
 sehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cd44ZTkwjKf-QjfBCRKfhY-jEXZGmUqSdvXh9E3viodxPmjlxKpmSw>
 <xmx:cd44ZZ2C02g22TLn38U87e9Jw3byVe6lu6oBFdi6M6s212SKH8MS0Q>
 <xmx:cd44ZStHCrlArPTH4T2DesGeScFtT8fdzw044ilV_nh3YRkUOOMQ9Q>
 <xmx:ct44ZR_8EvczZsCVHIzWEHAz-yNaCT1TkvFiBk55p6H8JUA__-6niQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 05:22:56 -0400 (EDT)
Date: Wed, 25 Oct 2023 11:22:47 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org,
 peter@pjd.dev, joel@jms.id.au, cminyard@mvista.com
Subject: Re: [PATCH] eeprom_at24c: Model 8-bit data addressing for 16-bit
 devices
Message-ID: <ZTjeZ6LB96yaiW3l@cormorant.local>
References: <20230921034816.320655-1-andrew@codeconstruct.com.au>
 <f5e6727c-887c-4533-a5df-db1a57318870@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rceDmsEz9DMFcJN9"
Content-Disposition: inline
In-Reply-To: <f5e6727c-887c-4533-a5df-db1a57318870@kaod.org>
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


--rceDmsEz9DMFcJN9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 25 11:14, C=C3=A9dric Le Goater wrote:
> Cc: Klaus
>=20
> On 9/21/23 05:48, Andrew Jeffery wrote:
> > It appears some (many?) EEPROMs that implement 16-bit data addressing
> > will accept an 8-bit address and clock out non-uniform data for the
> > read. This behaviour is exploited by an EEPROM detection routine in part
> > of OpenBMC userspace with a reasonably broad user base:
> >=20
> > https://github.com/openbmc/entity-manager/blob/0422a24bb6033605ce75479f=
675fedc76abb1167/src/fru_device.cpp#L197-L229
> >=20
> > The diversity of the set of EEPROMs that it operates against is unclear,
> > but this code has been around for a while now.
> >=20
> > Separately, The NVM Express Management Interface Specification dictates
> > the provided behaviour in section 8.2 Vital Product Data:
> >=20
> > > If only one byte of the Command Offset is provided by the Management
> > > Controller, then the least significant byte of the internal offset
> > > shall be set to that value and the most-significant byte of the
> > > internal offset shall be cleared to 0h
> >=20
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interf=
ace-Specification-1.2c-2022.10.06-Ratified.pdf
> >=20
> > This change makes it possible to expose NVMe VPD in a manner that can be
> > dynamically detected by OpenBMC.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> It seems that the "at24c-eeprom" model doesn't have a maintainer. Until
> this is sorted out, may be this change could go through the NVMe queue
> since it is related.
>=20

I can, but I'm not that confident on determining if we choose to
implement this behavior broadly. I have no qualms, but someone who works
more with embedded stuff might?

--rceDmsEz9DMFcJN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmU43mYACgkQTeGvMW1P
DekylwgAjTRoX9Xh4vT3XS26fU4+19JuaNRQq632joAvtOWsJEmVp6IiowqHD8No
CbKfiAmXR1q1teLJNgeyLvwTNFzzHvUtcS+PTWU00Db5W3vB2v/fs2Ng1pY7sVeS
llCtUwGOdbZTZLZfArfDJVxv2bVUL3yle1q8nH/iIk+1ZUk3SVqOOJ5t/zyMD0sX
trG6crtESNx1x1fSS0+dY4TogxiygREXrYsbVFAQ9c59z4MSiGe+vprN7EL7djRz
ZZ7BPzv1lbZxazE1C7XcAflnYVg1d/5flk6Z8XoNs19ZJo65HTTXto3KH+aOlyzE
7bR9uYidneEvR36g+1qmtNvSvo8+CA==
=fS7J
-----END PGP SIGNATURE-----

--rceDmsEz9DMFcJN9--

