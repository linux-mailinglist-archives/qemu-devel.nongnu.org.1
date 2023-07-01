Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6F744AC0
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 19:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFefI-0004za-TM; Sat, 01 Jul 2023 13:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFefG-0004z1-9x; Sat, 01 Jul 2023 13:45:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFefE-0003Vj-2J; Sat, 01 Jul 2023 13:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688233533; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=QnyjJDzdLS4gf14b51gZL9LObxISRFO1WXnkhZ+mrTdvkbHbEYZIFE0qCBRYwKG0uG
 Iv8cXfGCMeQXcCHdcpJz46uuVOknRfwprmJfAoQ08RhkrM29PtOiQCvtBjFIQjPzhZ95
 hgVsEV1d3h0B8/sMUGqqQhitbNxMtKVqLHr4zTmWrGEojxVrXdDCJmZCWY0TopDK0iac
 2KHyavH0X2NHbj/OhA+JFG10T8/yXqI9Qfjj0Gy0PMUt3p+fcMTG1lQB5RnxnLKC3IKJ
 Zf/9JESZzkhPxZDVPM/oJ/KUkzFLk02rfyG/ti/gtkFS+QRyn+1OiMB0t3UPfMKbvapB
 baLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688233533;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=36MiBxuvoKB0YuD/WXyv9OcOmPg68QApYwxHYJQxyF0=;
 b=BYiAVfPo+l/BZCBP79Jfstb9QkJVSu1jKcIYSlyNXrOj0Axgs0vtgxasSWdiV2g10o
 BtTvF8h7AOvB/nJa8v8luQHLWTHzb3zqj5lRt9cRGgP8KMHEEDQa3NVDL8+z5o4VHU4f
 UrjfnRXNMR5oMzI9TUeQdY/QvRd9+drUtlPqvnb3cY+M06sfC5c1TXoryiKIjIcGAXG0
 CibwJWgnFVbxu3642ZwlRdaDFLFmFNyftq6XvcaXwdIS8AqCy0x/WJLwoDZfw0SWC2TB
 aB1+PwLdgU+6nRtvB0nGsHbF0q8WmT8gN88DLigZyWwXeLMQkJ6j5TqbzH4a6LJTj1su
 Z98Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688233533;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=36MiBxuvoKB0YuD/WXyv9OcOmPg68QApYwxHYJQxyF0=;
 b=MfoSKs+kK6aWC4KSMrWWHcj/m+cUMFNOy6BC2NuwF4exp1g6Bky4W/uIGdSkZu+kqZ
 7zWSyNISA0eI28SzAYtYE6wcEDDVdueDrJ1HOO/TWvrGCwL2ac+rmHkgNUI12NamXcMU
 FA41ZTtVh2eKvUurZ8VE9kmNC80Rmf7PPWAF8ezlojtxntzKttJ0gV6yoMIqOKh9tOO1
 u6Sfk8iqImw/4hmvazNjf3xxH3bTsM9Exf9qon6csSeJqxZ3HaauLqmKwGq9fZEKaUUK
 psFpKNGvI+YlZFigbAitGk1p8KYKcoZmciMW8NZP+M3DTrqbtAlMIwvDODWfqo9nSmXd
 yBAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688233533;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=36MiBxuvoKB0YuD/WXyv9OcOmPg68QApYwxHYJQxyF0=;
 b=M39Y9Y/v1ncZRRNE1fW/Sj/nTSndMuz5zWV966Oabhj6fWsSvWq6SqmZ4C+ecbm9mY
 PqjAQhilMUfJDunKiNBQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4VReIOE3s+xIC8HZ8TOtjelmE6SkKgUS6xMby0Q=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az61HjX1ie
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 1 Jul 2023 19:45:33 +0200 (CEST)
Date: Sat, 1 Jul 2023 19:45:25 +0200
From: Olaf Hering <olaf@aepfle.de>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Lev Kujawski
 <lkujaw@member.fsf.org>, Bernhard Beschow <shentey@gmail.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230701194525.4d6a3c5f.olaf@aepfle.de>
In-Reply-To: <alpine.LMD.2.03.2307011532500.25684@eik.bme.hu>
References: <20230701111341.25500-1-olaf@aepfle.de>
 <alpine.LMD.2.03.2307011532500.25684@eik.bme.hu>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oKaQWu3G5Eeuzc/SUBR6wuz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.54; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

--Sig_/oKaQWu3G5Eeuzc/SUBR6wuz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sat, 1 Jul 2023 15:34:40 +0200 (CEST) BALATON Zoltan <balaton@eik.bme.hu>:

> If all 32 bits should be writtern does this need pci_set_long instead of =
pci_set_word?

Thanks for spotting. After a number of experiments I used the wrong variant.


Olaf

--Sig_/oKaQWu3G5Eeuzc/SUBR6wuz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSgZjYACgkQ86SN7mm1
DoBpJQ/9Ea8n0Ydto9ziKSa1JNnozbStxCTKjtZ9hFybe5oDRVv9zIRlh6tk+TLH
8tmcO3npxwFVPXUSu4lPZXu4TOQOLSSkqcfhCO6cA/kRie6X2vTKI2e98XiSE4O5
4sSWas7rQmy9nAEMmgmTBN0gkm61KKnYI4LLJDQLmA7NwAH/19oEI8aKlaKRoLT1
ZQ+IRi0fUyCQkobT6aD/Wtfl6IjB8tB1PwY7FX9mfBLWHBpb7KhJFN2YwqwQ/YT1
Qf7U9dOJ8ulfbt8hHXk374okDEsf9ao4w1JzK71mflzsApHdKa13oWpXa6ofC6mZ
vqVjb1hfnjpt63xO5Ea6CbgpgfMLOSkodTlS8S9mQxjuxILH8wFOLAt/IcjGgHYo
K1NEa7crXajZv3GvIVnMBmR3X21FvRxRx+9vRpZdDv2JiIbo0wazrfzy8l4BK0+w
9IaAXas6KTQL4s/1tk0dA2hWx9LmFE6xA9H+DC1AyRMOcjxoMN6g6Yr3fA5e9m/L
aBW1oLjl+EedHaCGcfjlow4IuQOy8pbkLSj1yS0ANUks/GWCvFSQfO51tj49ay5j
L0I43V56vzX64/W5ISymi9O7C2qKSnzCFCdZUk/BcMIbENrZvYudDPH6FNv+hR5E
02VrTErmStr1Vo/kA+X+b0uOYlAd+zrZ+NjTGrnwiVmUeusm92Y=
=pBm3
-----END PGP SIGNATURE-----

--Sig_/oKaQWu3G5Eeuzc/SUBR6wuz--

