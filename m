Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA3A73FB47
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE741-0005q3-VK; Tue, 27 Jun 2023 07:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qE73z-0005ma-Cv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:40:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qE73x-0002H8-3h
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:40:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1687866030; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Oycm2VcwANSg283vPXjXFfOfEYI4mX0rMOypTsUMKITbLIxtoMVdkMT5w0TDfKIvMn
 x1FhfV+McbAw8YQfrEgz2xHHzwPw60cXsCHOkvFDiSAsw/Nz4XpWeksBB1xjcu+lzWAQ
 yyvFShfwWzVnkh2mB6iI3GF4OA6HDSWLzQr6aYm4RihtQsDA6tnjzsWcfaLkfTUD7St3
 p067LJRqj6unJBmnQAsELGBgoSrE8kUmp26zdLwX3pTRi/KjSMhlzgtsTE4AjQBnOlht
 3LAOxV1so8t4Pdvps97y73bu6UaTjHLWNJtz2wATTQIPfxGN0O97gDV33sBRarc4PlY2
 9swQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687866030;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=7r7Vjrw1pT3+QPmalZ8Jntj7FY0ixbMGjMuzuV9qPEE=;
 b=sDwbQu/UIoacr023i8yOcxth2qqqPqSSNFo7V6umDgYLvI5U9KlWTjq02Iptzk4qPi
 W1t3wFRIMWnpi/REvbgA/c6o/3bGpOZfrFt8lL65ymiVvjN+Euy6Q4WJttjtbWtAKxMF
 Nd0jW3jPv6IM3pXgvF5V4bcmYN202jSZbMf4+1hNbl1ERewX9cGfmBGeSxgbgGym6agW
 LR6MX3sjiJzu2pgve8XHJwVjoeNN5KEdUacIEqDT3erjMRhWVZSpzkSo+cQik2SJvHZP
 bpHRK3J0xWYC2qJxUN+t9TkLT2WoaJGJyFs/1qAI29JbcpMP64Nidhm2V+uyJipJ9+mh
 ZCXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687866030;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=7r7Vjrw1pT3+QPmalZ8Jntj7FY0ixbMGjMuzuV9qPEE=;
 b=WJjTwo9I+vTHWQ9zk2BvfgEJ/1POJVlt8n3H0L3heQDE3YJvzYDjU05fPj8B9eLYKd
 8fGSJts2F2TUzLGkZv/RQG97iM+a6hVP+YCkFlto8xEDcKiXiAlZ/42GsfrqfJxD+NrO
 KI+xQGQT185Vp330AiLMn8AkqxpURoV13elk4maxWWKgDxO0aC407E/J11+hJZ0TjhTC
 GB/POTA70mKJaWk/qi+lpXk+Aa828duBDvrillbJZptKSLBPAcNuqJKAWY5Z+iPPoAlL
 u18q9kVc7DdRthevphTCIvmVE/ptZRjgVxhRkfliRvFkm9gmJacEy+hvATfXJl3YOg5h
 t8jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687866030;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=7r7Vjrw1pT3+QPmalZ8Jntj7FY0ixbMGjMuzuV9qPEE=;
 b=U2LFzJk8D3WdR4FR4eO2htNO+6bCj49iMYTpAXye4lZs8R4VIt2NNhoBPz5B5UVIiQ
 SI2ngtioGjUY1dC4ESCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXWiuRyeUQh3GC6w0BTiV2X9kN/WAr0rdTE7oY1qJzPNA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az5RBeUlKX
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 27 Jun 2023 13:40:30 +0200 (CEST)
Date: Tue, 27 Jun 2023 13:40:28 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>, xen-devel@lists.xenproject.org, Stefano Stabellini
 <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Message-ID: <20230627134028.648924f4.olaf@aepfle.de>
In-Reply-To: <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de>
 <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JIfyy9HKszghr4sGGJ93kPh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.51; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
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

--Sig_/JIfyy9HKszghr4sGGJ93kPh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail.com>:

> Bits 4..15 represent the BAR address, and pci_set_byte() only clears bits=
 4..7, leaving bits 8..15 unchanged. Perhaps this causes the BAR to be move=
d into the UHCI region? Does changing the call to pci_set_long() fix the pr=
oblem?

Thanks, it seems this fixes the issue. Let me verify this with a clean buil=
d.


Olaf

--Sig_/JIfyy9HKszghr4sGGJ93kPh
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSayqwACgkQ86SN7mm1
DoCD2A//eY3W0UJDn5/pvvsnpT3NQHRDbW9+K55otIvepS72amDYfnZOvZi+hSzy
gUqcSYMOLbanHOtV6OQgWfj18tCAZ7CpQ5qGK3kjtvPJ8TLJnzMKsgNTS4Kmzse0
Z3jJ2tJVMsDS5in5dDrsSHvLVGbb/Kcm3mCCl/ahf6nbqYmqJ2MO8IF0Td2khWH8
tX79p/cANEpNJIriCRb/hiNnuvlQr7WF6HxvaYPMibtyH4bE9FehV9maOWIMwnw5
GeAqSbr5xVRbw4bT3xKaw95cRi1gwLqWVr6QOWI7kbMSL/lPvwLXyLDTfSCh7iXj
H95TwjniQwHW7hKG1+NRSaEPh5AzFDKbQzmJPjC5x+CS1iN8ud4vAknihMn8qDu1
vMyMAi3xsYcrS7DuDrXbcfygSS/yGbU3ejflwQqdgOPBJhBqLbpeQ3VmjiCURpSp
21/pZJvvHkwn9Y9qdC2FjtkM13cxMgKIqk00dVYtmdaFwSgA0F5+aj75JUhWxeIF
uiwBMJR0IsIP+1CmxfF9jJQiJhMe88oWBEiYpakqkxuYzGaGqoG+eGD5+LMnqOEH
y7eQCwAjXZBpjb28qQE1oVR3nRRiDyE5vLUu8iqlZ+7ho/YV917vVd43szD44xH0
GIF1t8AJ9dldDHXtPijpIT7ngD9v4PhcujxmPK9EplU/w5ggdbc=
=8mEl
-----END PGP SIGNATURE-----

--Sig_/JIfyy9HKszghr4sGGJ93kPh--

