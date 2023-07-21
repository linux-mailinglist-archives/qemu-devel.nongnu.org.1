Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9275BFDB
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkfr-0007sA-RU; Fri, 21 Jul 2023 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMkfp-0007rr-7R
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:35:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMkfj-0003F2-Vz
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689924927; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Hb2UG6fb8dYtudIAm5VAcz87V/RZdM5UJLodm+kX2+oypCQ8JgRcm3oeQkeIEZyIcx
 fhOLjD8J18f0TizpPSduurCi+LocpxXbOze//tQ3abma5AJ32Xir+aEQu7+qHTdZL5/u
 6ASVaayIFYDM580LGn7npNdQtYzi4vLZWngPymsDdnBxf2a8naujasqmNSPpI81ZdR8e
 q8e7oy3QFufAu8oBMeWJuqPjA5LfN1q95FcR9PVNFceHihIf2DaZaXhS+qYrlWu/gXd6
 zu0+f+mV0bKZZE/eOIROOfboW6BCdt0i9rYE7qdUWBBaRyjfAL+/BjyiBESnAvxxbvSz
 2DEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689924927;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=puoqMdQGKNzkt5Hfi9ZDF06V7ij2cNOxxZWDb50J9M4=;
 b=WliNxYtYeKP+OzganhDq6Etnkqz62z6onCgE3s3brZIVpJU4X22p7/SmzAHiFgKhyF
 PaobBVxCkBhSFHE0ZfVq9XnBixkN8FGBHfWHbA22UaSuWXzgOR2cjdUfS/xm5DTqsHFJ
 1vI/hDVnj33s0wALph5R3sfxm/qVcifd4OF8zH7LDUIEjpOuT6hL0SOMUKWFwILQYW7Q
 JJeXzXoGxIJzL2viO+GOoMheJv1QHXY2wxenYzjq2dtTSHO8Wv0gA8GcsqmSjfPjACtU
 x+eCXEDLMl8bUQwffneh22B5L03m0dUxCtfSF/wiOCKVU/U2BrgiSvSj96qkKnGnQiet
 QYmg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689924927;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=puoqMdQGKNzkt5Hfi9ZDF06V7ij2cNOxxZWDb50J9M4=;
 b=cHvRCzx6D5/YWJck7YrWKBOA+ClaahpTmMCzbM5I3a3stikhPY4Q1gkoVaejQmg6Os
 FbTnfpDYrRlYJjXOx1lVNJAYeE0kctCdpw3rdKl4qGjqsIEmtkD8xgqGrO9QHV8yAosc
 hdC9ZZxYKmH58778QyofK9N2NTTVdvMNODYR9yp+HmHAAzm9uj712E82KfSRDbVE2xfT
 yzpCLl4tQBejxCF9Bxvjz3J+R0EzZdM/az1T6nAXm3pyi/jk4XT89rIg+Cd5boDcWG57
 E6wfVWP9G1uLdUKkcP76OaALUWZtuf0wwQwsKhF+4O5+2Uz3ImnqyRfMerYh5tIAGgVj
 a2XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689924927;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=puoqMdQGKNzkt5Hfi9ZDF06V7ij2cNOxxZWDb50J9M4=;
 b=NNdqsuO5oKEds2PxXlWWzjDhl3kXQxJUMguSS4X9nj+tRgylE4Xfso4Ny01LW44Ukj
 VdG2qyI4M+L7IOeIYhDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.4 AUTH)
 with ESMTPSA id m4dd28z6L7ZRCFb
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 21 Jul 2023 09:35:27 +0200 (CEST)
Date: Fri, 21 Jul 2023 09:35:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: 8.1-rc0 testfloat fails to compile
Message-ID: <20230721093513.515b2306.olaf@aepfle.de>
In-Reply-To: <10e95d52-109a-d683-a9ea-2ab9b52e795d@redhat.com>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
 <20230721090359.1b9797cd.olaf@aepfle.de>
 <10e95d52-109a-d683-a9ea-2ab9b52e795d@redhat.com>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zd3Jenre/q7U6mQeruXe4j7";
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

--Sig_/Zd3Jenre/q7U6mQeruXe4j7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 21 Jul 2023 09:18:08 +0200 Thomas Huth <thuth@redhat.com>:

> Or are you compiling with -O0 or something similar?

Does the master branch compile for you with 'export CFLAGS=3D"-O2 -Wall -We=
rror=3Dreturn-type"'?

I prepared a patch to deal with it, and indeed it looks like the compiler m=
ight be able to spot the fact that only values between 0 and 7 can ever app=
ear there. Apparently it fails to recognize that.


Olaf

--Sig_/Zd3Jenre/q7U6mQeruXe4j7
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS6NTEACgkQ86SN7mm1
DoCCEBAAngEQxo8gJ0qcXZ5Wa1RPUUjWqiEe18f9mKMRNgeYxSqV1GR+2meV5qCY
QxXrmtVdUZa1PdEHUI0+A566wW/pLGlaphQ6lRVpgBCXqmeUmrY4p2eNZ3fIU8f/
Gt3SLC+e5tS4OX/OpQ/MA90wFPPw0cliFxPQs+XRRR3hwwiR5mg0NGe2lebKhq3d
yNwk4XwRgrQpswJ//DaWA7dMGFYJmW956glsFQeY5SOmWUomoVt8CmyUiEL41gKM
uEweqqYcPXkoZAyTMlsox83/oOuapYPfFjv7bWJS8Vp0Hi1teph3WIcr42yV+88G
erGAVM2u7Xhhyap/KoQDYNb+DFCZUOyP+/so2WWGvLJBufR7wGYKq0K8FQztwzJP
b5ZwnfPkuahvNaRn7c+sG2e45y0XeQgKKU1N70r5z5txfbCp+kabP5PEi+5JoRGm
9hHpdAvpYZ0Xarkw7mfm/fT+cQTt8Kb5Qu4srCkOl0eS9iXam+8OIveD9nkogavO
L/NPf9QiHFJSLUa1ieM5297FCJvdJUUPBS1wlP0+BjegqzzbQmf9dnX0Km6IKwVM
XRRrq6vVXdMJ0CHNdQomuWIuT/ArSb5Qg3oFP0r2OUAzI+dVTsm7ftTi+GZRP3aM
KzsjsnG1lBqLeqQgTiEYAnrG5Jd5DZomCR7PT8sB9j9UKvsjaRI=
=wI79
-----END PGP SIGNATURE-----

--Sig_/Zd3Jenre/q7U6mQeruXe4j7--

