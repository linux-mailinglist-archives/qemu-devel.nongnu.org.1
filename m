Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2FE76D6E6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 20:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRGgN-0000Jx-IF; Wed, 02 Aug 2023 14:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qRGgJ-0000JS-Jj
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:34:47 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qRGgH-0004Bl-2g
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 14:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1691001280; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=iwkeQOnJGC1o33Av/Xa847H1dk/52T7IDg6bfJszBuYQDeL9rsF51+bi6PTpkUP8lw
 qL7iQfwax6OfqA901TbuIsrEPZ4NtWF8tsbqlqIFZ3oTBh5y4unDYfTlOHmv6Ba/1ZrT
 UZ2BueStbSELEyuRiKHZxNsL/CnFFtylXWLfK+zO8Fq4sqjBErhRpZa5dFw+7ZTC4hg5
 /iAAa5pJZFcSDxTHfAtqecBonw4bhLxS7W3X819oT5NfuLKdcYy2Mhu/g8QgwHq3cLkH
 vh81sfV3IEMPyM2w21esD/ZYGCvJMngEHr8J3PpfwmmCfG5R6F7WcniKIrAEzYKuhp6j
 GRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691001280;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4culOgsYhPnMoJOn+Nrsg2bKD6mG3R4gUNdUhcIfQZM=;
 b=ionzQBzCYZScDshHuIseg6oPrd+4Tt9G3M8TCzGO7Fkv2aOIs0np8pm+wBik6Vrg8b
 oMGG3XqsKi+WlDDaV2fwThURjcI82SsFYAVGDBuEfSmLQToKveLnp+ZDKMyjtruJmtYq
 2gZlI+lzxHSopfpJK3eE/dxTM0wYftH2qMN8VjYbzg7gpBw79Oiz4UJIXvbK29WlN4Os
 2I7cXA1tNj/c9Q+6hafDE3tAgP18cdRxcmVelvJy+/VO/ITq3Na2tkQOArtgQQOadLoo
 ETlBjYIvQvXVSi5bsOj5e7A6bnZr7jTKFD9VIqr4ziyF2Yi9y9u2hwnPdn6/LN2nR8T+
 F5XA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691001280;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4culOgsYhPnMoJOn+Nrsg2bKD6mG3R4gUNdUhcIfQZM=;
 b=g7TYmpWK8reaQzblMYFkR2J5EAOlZLJSguRKM0xKrQ5JhS6Yi5fSAqifoqjIZYztKE
 ipK5ra43d4i0Z8GyZzx6glFN5MQQxdb3XW79xjU/+KHg8NlNzZqgBitLgwdp/cf63FfI
 UoK6fQuZmOVMrwMgYsBkjuNmY8VbxnKxUHW0UIHKNDyR4PXjQ6K/Nuj/93mzAEBFbO3p
 cors0YQlX7KU/5c/WFVQSGuprnMO01q97m59FC1ndR34Tyg6764nyJ7rl+ExYwlPao9X
 wGF2XzFI1xY+624zp8du43CKJ2ATgZFLWICXC6EVENjJyn3V11m2ey+oXDcfI6aiQKCB
 C9eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691001280;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=4culOgsYhPnMoJOn+Nrsg2bKD6mG3R4gUNdUhcIfQZM=;
 b=mVAoLUdWe6xvP7rZ5lzbXuN0LYZYAHOeXrfvgYlO+Ehy7oSW8DH4BBiTpUb3U5D82f
 xx0061kRKoQ+P5jOKRAw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5U0GIOxzsQPrGAhfM0BJebfTWeDWMtcJLtvI+aQ=="
Received: from sender by smtp.strato.de (RZmta 49.6.6 AUTH)
 with ESMTPSA id jd2f5az72IYdW2g
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 2 Aug 2023 20:34:39 +0200 (CEST)
Date: Wed, 2 Aug 2023 20:34:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] Misc fixes, for thread-pool, xen, and xen-emulate
Message-ID: <20230802203432.42d52a26.olaf@aepfle.de>
In-Reply-To: <0441c6bd-eb98-8013-5756-418775863aa1@tls.msk.ru>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
 <0441c6bd-eb98-8013-5756-418775863aa1@tls.msk.ru>
X-Mailer: Claws Mail 20230724T063118.58ae3d58 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sk6AJIPP4W0b.sOUFRnKwoY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.22; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

--Sig_/Sk6AJIPP4W0b.sOUFRnKwoY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 2 Aug 2023 18:18:01 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> Or if whole thing makes no sense to backport to stable, please
> let me know as well.

The xen-platform change does not need to be backported IMHO.


Olaf

--Sig_/Sk6AJIPP4W0b.sOUFRnKwoY
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmTKobkACgkQ86SN7mm1
DoAyaRAAlRPV2DsDOxRYmfJ6nyQ/CYF260V/UPMaHNHhP543qrHWlVMZ0IGAcrKr
tXKH3p7mhjRzmktnYWmiIBQJB5vFSwJMMI3EjHffsJ4KiDMyiUDotnZvTGIeowO4
F19K7LAd4AG1pzoK0qqw8d5Ea+2L8ktzOuRMqYCt9nos+LkV4TeIR6BVBlyGVEa4
TS+jN6GkZUuk1+ETjq7KJDZrpNftjmBTAS/U4EG2xK8iMylMSLlTcMsM/Dxo2Aom
cAZc+oHP8kn3r2vSg7AndXnL72sArSy2Ad6H2TA+CuTyVznqYSFSq3Mx06astE4w
+Gnc1UF3kuyfMRj09LIzTHO7ulednO2i8/zsbu1bc5ALe5WsbbhlrKm547Y9X8Il
3sd541W3tmUPkScww+ZlnFwG331AvMQ3CqFr3oL1yJN/LAIDewk1M6ixsfftPbyP
4zwJmO61kyZxLLYrF4wiJCRO8fxbnAwc2XEB426KNMadI4As84EYFj9L+hJjTA5i
GwP5MylQzriZ257aoU91O/ByurOiveWRhVSuHXK4OdWeLVWSm3YQyTdugouNRQdT
d7NmDPSOQ8P8tiqXjSmMkufWLEpE83cce8DiZ6NXMZTb+4TE2YXRXzqIwWYFE2HW
4FbGw/iNWRh+zYXUbcgzTMoYNr6oe32oE08JnP6uaE9aim94Kpw=
=KNCs
-----END PGP SIGNATURE-----

--Sig_/Sk6AJIPP4W0b.sOUFRnKwoY--

