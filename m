Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B77AC763369
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 12:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qObeO-0006do-Fa; Wed, 26 Jul 2023 06:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qObeM-0006dc-Db; Wed, 26 Jul 2023 06:21:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qObeK-00029M-Oo; Wed, 26 Jul 2023 06:21:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1690366901; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=JZ2VBvZRkwnXzohKQr31l0jKqDdKduUFMD7EchmyC6hyQ5aBierWTvKtJ5+jzCM9Ci
 OxuhoBHdYWRE499pj/MoUqJWxSJ+JJJf1QPyfLOKMBeHDtZEC997F37c2CnoJ+eDGgfL
 WwQqp/NSY3Vbn0Dwe5W0DVgOTY3OFoWhKUExqHneSAvht/UnGgLSlsui8x34olBfD+N/
 hCydFjCVkuWxLaIg0Uub7JzczuRhfrUh0/+qIb7CFwYOH/WGvaWf5SHngqvA1YQeBmFw
 +dXbm9Hh699+t1vFyPadnNDpacwzEqnB28RPbPGD1GdAvQg76ZERZN3K7TPteDg2OECa
 xkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690366901;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=CoY8DWEahNyxVCOb2Ekcop6aCimFM+HqEOI14Aw82hw=;
 b=aowmQWbRGYaleBQoQ1J5T8gVmEcWdxNwmIx7Jw6BUC4gF//o+RSC0s2gr1mDQbQR8P
 RoAyyhynLlm2cMACWctQ32U4oGMEBo5+Ra6T7wjLXygJA9XafkdnzfYezuRRpDv0f60g
 Nci+TPIRmIN8SZv3KB1Cxn4k+bVC0gn5nTrDekgvMaNaUizbU2eal9nSc6G1Ttp4QaGT
 I9biThjcqvCPn3jhb/bwx6kfPWgv0b8bF3wIFSNnG6nKpx/6BNkE3YSGGBj8C8CC353l
 XiEMBPugmshG9qLwjK6b+v3omyM1beTljPW/k2uhgoIa9p5n7b/JQkMfgrDchS5MgaYM
 wmTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690366901;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=CoY8DWEahNyxVCOb2Ekcop6aCimFM+HqEOI14Aw82hw=;
 b=NqXaiGsLAi4c+vl2MsWRXunjYe+j5+Cui0vXpI3mg5pC1hdPGcmyCbcpp/VWpkQapp
 VHA8JMXP6G5Nh08FymExPpsIjl4OdefW7NUALqD2ffSSyewFBzL08GhalWHpaZ4CiTW3
 xqfl08NtUCJ7GOBMLQxRYCByrEEecMSV5o60Z2raDlPcDP4TrE3ydlAX2xyCksQiQqzH
 ja+ig0x61xq3fZT85NLjMMCPKZCPq0BuRBUmNCjdh9KHCn1iHDdaAUei4U7Nx992jK/o
 vsWLsH06AMj0RJNNGjx5nEhLF91/mQyZRGWB+QOstgGSPZq3m+CV10he59X71HNqPeCU
 vA9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690366901;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=CoY8DWEahNyxVCOb2Ekcop6aCimFM+HqEOI14Aw82hw=;
 b=0FE4p14iA2ROui1nt4nqB4B3MtGvS9X9LjNvH/ocBJtXaccfpNlSVRHmM+bX9YURom
 FBzetT+81XYf2sdpT+AA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.6 AUTH)
 with ESMTPSA id jd2f5az6QALf78L
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 26 Jul 2023 12:21:41 +0200 (CEST)
Date: Wed, 26 Jul 2023 12:21:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-8.0.4 00/31] Patch Round-up for stable 8.0.4, freeze on
 2023-08-05
Message-ID: <20230726122134.12c8926d.olaf@aepfle.de>
In-Reply-To: <2684d072-c13b-2d12-c7d4-ba987961f2dc@tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <20230726120727.755b478e.olaf@aepfle.de>
 <2684d072-c13b-2d12-c7d4-ba987961f2dc@tls.msk.ru>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DQ..mJYKdGz0UJnLeOsKdea";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.20; envelope-from=olaf@aepfle.de;
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

--Sig_/DQ..mJYKdGz0UJnLeOsKdea
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 26 Jul 2023 13:12:43 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> This one is included in 8.0.3 and 7.2.4 already, picked up for the previo=
us
> stable series/releases.

Indeed. I just noticed I still had 8.0.2 exported, sorry for the noise.


Olaf

--Sig_/DQ..mJYKdGz0UJnLeOsKdea
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmTA864ACgkQ86SN7mm1
DoAMpw//UIjVdYHOmbb05rtxwOq+wOV4VNTdHyvF9uMt8Z8gcOL86qze1u5tR0nQ
RM6D9WvBsa9OCx2OudLMOd4Kif3BhInOAHbY1xsOOmBd0hNBrPQ6/fuxkjasFGO7
jrCWDhtagLQctFunrxB42lbezb6xStCc4kEYvP1OBMTFocjdDJMfU73tdOefxb3j
6Q3sHT8LXqVtf7J3+WA+kgt3NPmuG8frLM0eK24ry4HcQp89xPnAVRW9h61iZJVQ
GLEP0j/jyNYm/Qi3484nd0Fe1l9fm5nG1P1liRLyDKP7GWsBZcn7NNtxWNKHaeaQ
iw6m23XUjaFhKUiE164hB87B6lr4cfHJaHArnWj0O5ur6fWLuz7rk8PDh5Vye39U
QnRM661K6Vob6BtpyVXNXn1IEjKJjwnYR1oAfbA94McOzoB4TZOd5uKKlAON7+J4
KMqsw7+24U+1+bu2ykpF+Ri3coNPASYCxAejd+E5tNbYP865ScE+quE8Bq82cQeP
APTYfNP6OuouiBQuDDfqRpFT2XfyVK+i5pJPsEqlVQKXruFpkglhs0kJCWnBBo1m
KU4bsiMBhx6D8KPuLb/mvt/hDh8+8O019EQdmhP9wS2VuNTvPeVk6HddkUyroAzT
h3n+8sigoh7C9+6i3QmFQARpfhFy9Isk83nS9mtqpuvUj/2PnWk=
=S5mm
-----END PGP SIGNATURE-----

--Sig_/DQ..mJYKdGz0UJnLeOsKdea--

