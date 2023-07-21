Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B861775BF51
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkBa-0007sZ-P4; Fri, 21 Jul 2023 03:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMkBT-0007q8-EK
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:04:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMkBR-0004za-7C
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689923047; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=HTxZ2Faqn6sGaWni6TAHTpHX38X0fG8iKelCndIoL7WtOjFM67C+oDr2ybnXun4hOY
 pmXrlypyD1qp+ZJwrEnMzhinVzz7mLGnTvzfqH0VN+4PWMX4A/OtsgD7AclpCA90nef+
 eU1Bhm7wm4ITiKCsxl6rorokcjGiWcvopbQvjbDDydA5qqvEbFDluoJUghBBUfcfor9T
 06Bb3oN5A8209fxoz07y7jmHEFXfknfRRNEVoapEYAGcpdtHCuLRqc8kUdaLwHcYqqTp
 wNSYzVnoDbpHZQBUBmX73XF/OUoukOucjy8UepHL9TZAQK0H4tQhUGQoCYu4CPwzBAx1
 rsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689923047;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Rt1qDQTiPWLOqlpCcRM4WvzS/gw1Lj50G4YsZBsNP80=;
 b=F0ijfGMpkguNGvwPmWaMBhxAZ5LE3viSAN6SyJxSABI8Vx/y8/MSdDoAnpH/F3KlNv
 vg/PYi/ERU0kYyO4a8sSXdfA1RHAwBwAlCC9ItAuMxXZ2QxUUiqi/i5QjEUm9xUlvWAD
 tsqXL0iFCbln+o57sm3zKLZQBwOd6DUTUvoZHQF55Z//h3hpM+4xh/WzYegBBxQbssfg
 Ys/e/0cbJHL/TGTU/RWMnIpNdLg+k25o6obvzvKip/40FHmUACdFppn2MyM60SpHMehl
 MEjwG+HqkmSr2n7C2uWD1K9tKp3EXPq3xE+XIKNrqGWNuMBS6nhUK8a/KfQO16GFKfg+
 TNlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689923047;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Rt1qDQTiPWLOqlpCcRM4WvzS/gw1Lj50G4YsZBsNP80=;
 b=e1YI0bk5ux9RZfZthVxZo4nLhcW0ib6lWxqmlNhlsUKzbLgosHntrx6MSpUZIhGI0m
 oeLSfDBzKGhh82WCZks5qslP1ziaLnfZbG+3TBUGPcdLN19FurOcCh1IiXQm/vc4HRfo
 xUQ3tXZTJJ9mTDJpF2kB5zalrC6vcnc39sgBYT2vK6JFz4Gva51gRJqo1ZSVv3NuHkcA
 qxoBjZPcpXzpJy7AgkHR7kSKAEiBUonyWtvWqTuCg4KVjAbcIOUzBb1bBEXN0/Fxqr0D
 OAxySn3Fic7rJShfG1WJxIyIQaAsV6apCcohOJLGfFqC0BEAVyfHuqtSn0Z8RmA3kvqJ
 KN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689923047;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Rt1qDQTiPWLOqlpCcRM4WvzS/gw1Lj50G4YsZBsNP80=;
 b=fC02nywa9wtadWRbYfNf/xdRr/eW7DgQtDCIwFJtSKveE6UPIeL4qOcPpCCakU3fvq
 PBEFaXLIqy6GjODl58CQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.4 AUTH)
 with ESMTPSA id m4dd28z6L747C7Q
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 21 Jul 2023 09:04:07 +0200 (CEST)
Date: Fri, 21 Jul 2023 09:03:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: 8.1-rc0 testfloat fails to compile
Message-ID: <20230721090359.1b9797cd.olaf@aepfle.de>
In-Reply-To: <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8J5JGTRo6KppNXZ8Xbd98zi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.162; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/8J5JGTRo6KppNXZ8Xbd98zi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 21 Jul 2023 08:54:21 +0200 Thomas Huth <thuth@redhat.com>:

> Which compiler version is causing trouble for you?

Right now it is gcc 13, hopefully every compiler will error out with -Werro=
r=3Dreturn-type.

I think it makes sense to replace Leap with Tumbleweed. We already know it =
compiles fine with Leap, because the submission compiled fine on the submit=
ters laptop. Where is the repository that needs to be adjusted to make this=
 replacement?


Olaf

--Sig_/8J5JGTRo6KppNXZ8Xbd98zi
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS6Ld8ACgkQ86SN7mm1
DoAB/g//Tgxmtc9RYIVaHWKrBQq7KT0vGHVeo5WSjQR+rwJwtUgEXh1hP3SYSC/7
thRc9WuHlikEKROnbrrn7u43RpZiDzm5QCNyNvzc4Chn6AmrCILSGbgTI7veS9gQ
fjZXfJ6wKq5utiY4nYY+cUDpdls2k8+A64I/vCdqyT8smLY2UHNv1+7hcnGtkyiX
WtmOWOQFGvGNhmLAElaL/EMxllZ9VVqDQbhrZQKXO+piLrLgPCFlfklO1cs7AzId
cXcQWgAO67eYJHhehmwsTmCocyYLjjnevUvQloENND7BhX6eVIHaiGhEXjt8lKnl
ZyQr8O4nPIoctQzRZ/a6OPKMiLYXU0o4FKK4hPHITnLppVuqBGUp1hZMc6SEg7Pm
nzggGqb5Dt7bZos2Fu9dgjN/iwnyMD430jJ9cnzw5hJUyX0ztsQUypBDHS++IcfX
XGpzw2TQLHlda6uXy9troZDKFHnaEn9w2xPQ7vM60MnpukexvGTBR3X4N8JluT01
l6g5yaUtoLJauSH1y3Mf6Y6F8lVyKlBwqQL8ApzKTqb58OPWZmdJxeP6DYHJrvFl
Ay/H/PpIk7dyRR+O78IppSMkDkpHLLpClcyUePFHx5u4o6+wJH3HgRmHVd8uB99W
0f4yjuICKPkm5bXDGHyVDCGqlnVaNdVNbqRtcXu8E+9W6uu3ydY=
=tTie
-----END PGP SIGNATURE-----

--Sig_/8J5JGTRo6KppNXZ8Xbd98zi--

