Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E474E9F3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9Pw-00080D-OY; Tue, 11 Jul 2023 05:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qJ9Ps-0007v5-As; Tue, 11 Jul 2023 05:12:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qJ9Pn-0003fB-VH; Tue, 11 Jul 2023 05:12:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689066708; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=N1uDNgxwsXPmRM1nlDkXAowa/Gw0UDvTaMHzKMHFqpjuTwUrtmkMARP94Jm48gdJBx
 SGAsWgI2vYEHbDDTIQHXJnH4GJuqqg1zcHaBv2JTxMCK8QpyUnxjPpjtgrHcMdbcKRfy
 X/0kd9ZUNcjGw0w3nHKH0IgmaEsSIOdJEOxkIq/7F6FMoaOon9sHsM7wJ1Ixy8D3W+O4
 KHjPKz8wFvKCwt54YzL6FnyGvcd+W5InjdPv4+qqvZ8XorWQpYTb3ZKrqp1Faz9Vd3fn
 2YpvG1rBprd+sTFvhLZmI0TtvM3V/bH+wbXOPngrT+j1GXNQFQ5FwDWuGIrZThiFSOnL
 jI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689066708;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aWEAl5xcPwgCJYOyqg/uiX52TFz7UIETMSILDvooNSA=;
 b=sr/uI6br7dxbZSCUx2I5nDH19sdIlFpB/Dmt+Zr2S7mci4bmFojFPqi3+m0pJEARNM
 y+ChvOCZQCeMEs703UOWdC8ScEv8uZgo0gxGfMjchmjx8cVAgZ5k0qYxIDBO+YFovseg
 3KBcgIphckGRsV3k8oPVnfi7RowRd8oSwA597Idh4xStJo/T0ZdsTfreKaizaN4OHCCA
 x9VCiLracPjF7k0EaFq9lk6nz6NnBGcmRbpYwKfwqJCCq4jRhGsRoZOAvLvoItWgqB6i
 SSpSuqY9miSJpGyTLTs5oE4SQfxjPk8HJf+MfhE69LsoYpueTahm+OUkhv/OdJcmqtAf
 ab5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689066708;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aWEAl5xcPwgCJYOyqg/uiX52TFz7UIETMSILDvooNSA=;
 b=mVhrt/JMqdkayGGq9y0xtkxx2bQGURCbyZOqYzYiDTbFXruc4JiHbzfNIsiyRCozMl
 kwM+N3agd/n12wYGOG+QJSlOa8ZWAYwhU028wXVVEYdLQY4AtGBsVeEJdhQVDl461kpw
 UBlv6W+I9MlkCX0o8PP1bK1qummu8hujtaIDvAjCPnv+yYzvOdiEsDorpEs9GnJAwRU4
 dhQ6OPakROaRpW8XYIgVLdvhZpI3XFeYyDpp/vSpxJDeLJAOP51v6ADWZDytgT4UTgoO
 Dez6r/nDCIk7TNHNrOZBAFLZHIpxBtBEGRgyFNkjxIlJTjl5aHUF56DU/qNwYgG2hACW
 ySJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689066708;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aWEAl5xcPwgCJYOyqg/uiX52TFz7UIETMSILDvooNSA=;
 b=5wqoakOQmRVBkuKjhPMUIjlS1pnWvD2fZoRKDVGqsQ3LQ9pA8eFKcM31Di9J7btS//
 f998pB7u7YdcHBd4VXAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXWiuRzeUch3GC65VTeyB8J8uIo2XouOdmzEbR5JRZ31g=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az6B9BmbR2
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 11 Jul 2023 11:11:48 +0200 (CEST)
Date: Tue, 11 Jul 2023 11:11:33 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Lev Kujawski
 <lkujaw@member.fsf.org>, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230711110547.20cc57f9.olaf@aepfle.de>
In-Reply-To: <3FF0EBC1-F1F8-4D1D-91DC-904DB287C887@gmail.com>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
 <3FF0EBC1-F1F8-4D1D-91DC-904DB287C887@gmail.com>
X-Mailer: Claws Mail 20230706T114334.0dc50f72 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oF6DnXficilBOT3nX.7t_55";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.50; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/oF6DnXficilBOT3nX.7t_55
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 05 Jul 2023 21:52:05 +0000 Bernhard Beschow <shentey@gmail.com>:

> I wonder if we should fix this line rather than dropping it.

I think this needs to be fixed, just to fix the initial commit which
added this bug. This will allow backporting this oneliner.

Further changes to pci_xen_ide_unplug will be done in a separate patch.


Olaf

--Sig_/oF6DnXficilBOT3nX.7t_55
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmStHMUACgkQ86SN7mm1
DoCcAg//ZK4GD1H+29ZkIAqhQoDdCfs1GDGYG493JFju+AZAFAJz5GyCzet6ZC4Q
I0CxdmZaisEC81GhrKL8dBnkEgc4QwmPD+Nd0Un9zFZMKeRrVWVuIbHQFxR/eJor
yqoqPd36//Dd1wsYafBGQteStmwelipABnQ2+/uv0T5XawFd2UJeKgTeJdbVONjq
YoX5iqrqe/VOhTn8XvW/Z5PNWWileepqgz6EmF4UQtTE0Opqubn985CPS8Frlh/i
TBAeXbN4v8VDqIfzWG/oO+lI5a4Ia7wU1ng4/5er1r+NJHdok52P156YM9dOWjtk
tPfNY8zgAdRXVS6s3+BC4fEHZ7mmMvtWHFX64/cvZGMm4ODe/EE9bLnmWbHaxJ41
jOOqJ8Dww0Jxc1WMcLV5QwGjrjtNwNf2mHxDSShNgoQG50dL+66CzzZs3NLtdsUf
gVJN2ZSXVCghWaBxJ9M80oEUEGA1KHb39ZZQWn7Y/krkvH2HdntXIpe8jvoY3ElS
6MhxBRVW80/uw7+cBcz4Qb+NwcQ1qnQAJN3jGVoLXtCdeNTRakRiqX9OKyOCbXlv
AvJw4awNxyh0k8zEr5atF64nyuAxL7l6qqjPOHBqP38uHQ1raQ14iRCtlF22k6Th
WUgVsDowPruTskckzZ6/nBzh4Nw66FdVmlDAR4KDrJCiS8BQcyo=
=fhS5
-----END PGP SIGNATURE-----

--Sig_/oF6DnXficilBOT3nX.7t_55--

