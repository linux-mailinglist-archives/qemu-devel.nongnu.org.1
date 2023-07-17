Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1475612C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLM1I-000598-4B; Mon, 17 Jul 2023 07:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qLM1E-00058d-UC
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:03:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qLM1D-00085D-3y
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:03:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689591825; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=cuYpn4D2QOPPPUFvrVUwg3iMd/z/gU+f/+ITTifZ5CpmoXtvMq6brp3v7MKzGF6Sc7
 3485mFHM0c574tcL8fs4Z60XQacx/6GP79Qz9ymXWfS/MF7A8P8lVnansx+Q4Xj5aHT1
 +X+duI859em7SFy4x66IozNrQq2KhwdJu7KOJsIgV6IHcwnKMGrh893BZNzuK5pzkonu
 0DRx/XzMKLIzmJAjwRJK9av39VJ0FW0+su0Bw3U3IiMzPw2B7C75hkW2Sidc8FJ/z0YA
 nnke5LpTh/4YSKGW/4Fd0vY8bNZYjsuKTe8bO0PoAhKbyhQa6y+wiY4xZEUjphuT9uNp
 5XsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689591825;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=JwlXraZpkgGryz/8myziihb7uRDZrQbjFQfUno2bLjM=;
 b=AVv+DjOwHidNoR+5i2mVBokCyKoADysoAoeQoFhLfc1HMhPOdns6kbSZjeDVtS9OGy
 R9NTkqx6kN0bV2ppIapHnxNoKFvTjUvhnI8XjI9a5cdkp3hdFtwwptW6QYNzVcezD/zx
 B4XVabHnYaLhLR//kf64hifOGuHV5wBEv2w3dLBh4AYxMNkYfmFbdeddOBasETJ4Lssd
 bqqa+vqwTVjjNW60HxgDu2sDXkhTB/wxeIv7xM4N99jUhM4y8T/4fbH7ZEJh7xZmV047
 gb4xmBRDaO7VxZsiAceTQmn37bqbNEnpu7RUGQUQ7Q21+1Xyby6nxHrU6TQo5/U/AUWQ
 i2rg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689591825;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=JwlXraZpkgGryz/8myziihb7uRDZrQbjFQfUno2bLjM=;
 b=gMHO5ecl+hM/8mkBKnobCIYHlanV1uobWhxJRIzL9iWIypR0AK0KsaQcPGPKDed/Eu
 0oaw2nb0XGv7V+77MLEuohvlDYvrXZ3zszj/xpfn/wo1TRkP0kS6KhOK3fETK5fT8wCr
 bqppr4XM2Y8oUytxtd7U9d2ENZq+Pod/U4T7SDLWT7Ooo7+saCLMQSqmkJI3O72cpOMi
 /i5ycnm6CCV6RxQIWMW4g08b/n3Tx+1jRLXVcAzkiWUjn+X5CiHb1/OGBIUchOogzkuw
 rlje7qnYF2Zn1PXUBmbfRx2laFSYZJaTMEP2X3SQQlmGR0OSkkIr1Xn7LMGbJMdQ2waD
 dAaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689591825;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=JwlXraZpkgGryz/8myziihb7uRDZrQbjFQfUno2bLjM=;
 b=jl8A1zymFdW/fjFVQetRZdRhkkAkN1DNmYP2SiSpV03C32xxNdTE7+gEInti+Tqy3U
 sUDSFRv2Z9qsZmoWFfDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az6HB3jy0S
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 17 Jul 2023 13:03:45 +0200 (CEST)
Date: Mon, 17 Jul 2023 13:03:38 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Lev Kujawski
 <lkujaw@member.fsf.org>, John Snow <jsnow@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230717130338.29b7a911.olaf@aepfle.de>
In-Reply-To: <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
 <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
X-Mailer: Claws Mail 20230714T084508.e5e1185f hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FVoGBy43rn=2nidx=D5Fnoi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.167; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--Sig_/FVoGBy43rn=2nidx=D5Fnoi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 17 Jul 2023 08:46:16 +0000 Bernhard Beschow <shentey@gmail.com>:

> The PIIX fix alone just fixes the syptom, not the underlying problem. The=
 underlying problem is that the BAR isn't deactivated, and with the PIIX pa=
tch it will stay at address zero rather than in the USB function address ra=
nge.

Did you mean to say USB will not work now? It actually does with just 230df=
d9257 backported to v4.2+.

Either way, I will test and send the additional change for pci_xen_ide_unpl=
ug in the next days.


Olaf

--Sig_/FVoGBy43rn=2nidx=D5Fnoi
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS1IAoACgkQ86SN7mm1
DoBknQ/+Ih92UXyXa4imE65pH9xXTD06XW0E9G4RaZGaNBUM0tTJNWtP+ipXP3Au
slLO9DlWTCTFQfvMFI8HGNYGKkAxx/hWf3gcqPoiibJ0QpYbblvqsnKWUJG+FkRt
iQpemNWF+rihzXZvykrrjNi1jA4oLkmWzJzdu4sxnLypeOD0/1w1Sy468AKyod0u
eacpEAVK9woBG4HT2op4pUn3xGoZmDLfPIssWJ+6DPSYcP7dc1NyERZToQq08DPC
Zy0QNeSCCqAqI9CIj7mpeIUnytQtI1fx9kNiB2Y54Hn2BKulSDP84apGF2wWxuUK
lteK2GrrA92ReOJjKh9Dtkm2yXfMUCZorYmrJ4OUzrVs0LI41Vu0G1smD7jifBmN
6Mxh+TDgoUjbnjJrM8Li/cAeMIGweJNWBt1JS4v3WyovRpEgGgpH8pDwqSny1NuQ
JTbPvCA4TwlkMzrSrlfGymN8hwKQPns+P0gO6FIFXgwE4vzg0zlY6qt/1Fuw+5yc
OX3hLxtamcoaZfWpIPzMyWj7VpC15bIvS+YWuj9DnfNR1PhwpcQfHDGD/ze46ZJ+
LWhqlG5fL21kDTMgvFb49HKxcJNusNzChEli9IgmLIfPf6WZze9YaOOWlmZiBJRx
hBj4X0De6crJL6sZa3mC/Zf/zHqRLi9h1Fj9J9ly2oZQFR3bfTE=
=CV9U
-----END PGP SIGNATURE-----

--Sig_/FVoGBy43rn=2nidx=D5Fnoi--

