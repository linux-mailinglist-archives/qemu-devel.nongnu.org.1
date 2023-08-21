Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85F782DA7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7Ik-0002Az-Om; Mon, 21 Aug 2023 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qY7Ih-0002Ad-L9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:58:43 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qY7Ie-0001AQ-IJ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692633517; bh=59av9dyf1ZroCB1Rfs04RuXtAb5V+NW3VRfxoekeWCY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=JwRf27OFJn6teRlMFazQGzhnfEgQO/ilB5zDbA7CDFWzRAsuVbdcRAnLGzcZz3nXv
 32CUaTkUXFvd2NiL8K3wlfmTLqBeK44e7zmbR9L53lIPOtP4p4g9mhotEBjCY7PkEd
 RrufFUxZoPhVDoV3GhIXZ/cfHbRHdzxD7R/sWOdbBPNtn1ksn8IoPswKV868Dl+MnD
 L7JAkfwxb7ds53DzbReFrMheMUEdYy052oU0dqO1VeOZbkzeUWcut6xYXmrimAlkt4
 +WTuI3dZJPul+4t6pSsB40/yVtyVa9GouQ3SHPZ4DGX7Df6ul/TmKaIbwQnCqudZPU
 V5qCkYGD6lZIw==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 3FEBB3F20D83;
 Mon, 21 Aug 2023 08:58:37 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id bWYkMjngnTrQ; Mon, 21 Aug 2023 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692633516; bh=59av9dyf1ZroCB1Rfs04RuXtAb5V+NW3VRfxoekeWCY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=GRCMqHyRaSYCMBHFbK4CGTvXkTY2Bg3y6urIh7rJChYeWJ0OOoENH1zonzxup45ef
 9Psfc0IthelapA03+eMjmmNsdukrtzm3tZBki+sometImZdkxNsSUbhQMGFZIpAj/J
 gIf7hFQ04S7u1mMh8Jm0SILUYuWojiZI+DxvS127R0wuU2NVIAW/7WZAMtJQLtpR1X
 pzD7JkUUcb4jUXuurkZU/myaUsQJUCrDUsS8dGb2aCkyWmErh2Dmw8owAtPNOH2Xtm
 CEUt9q1zU5XyzvldpB5ESvbdcsf5+YzH9glawwLKTmg8TSU+V0u6AzUbFOJW8guKRO
 Je8aHEMgSFOiA==
Received: from keithp.com (unknown [98.97.112.104])
 by elaine.keithp.com (Postfix) with ESMTPSA id 4F24B3F20D23;
 Mon, 21 Aug 2023 08:58:36 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id C50BD1E601E7; Mon, 21 Aug 2023 08:58:36 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: Funny results with long double denorms on m68k
In-Reply-To: <fe3ff30d-cf2c-0c45-b4f5-107dead420ac@vivier.eu>
References: <87bkf1l9hf.fsf@keithp.com>
 <75b13a6f-5866-4948-00fb-fbfdb7866e3d@vivier.eu>
 <fe3ff30d-cf2c-0c45-b4f5-107dead420ac@vivier.eu>
Date: Mon, 21 Aug 2023 08:58:36 -0700
Message-ID: <871qfwl74j.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> When I developped the FPU emulation I compared the result of QEMU and a r=
eal hardware using=20
> https://github.com/vivier/m68k-testfloat and https://github.com/vivier/m6=
8k-softfloat

It looks like the second of those has similar issues with m68k denorms?

https://github.com/vivier/m68k-softfloat/blob/6ecdd5c9627d02c7502de4acaf54c=
5c5b0a43bdf/softfloat/bits64/softfloat.c#L640

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTjiawACgkQ2yIaaQAA
ABHxmQ/+NVobEm5VLq3H/wwQa++nnzJ7ev1vhJJc5BXuKHgtvFWlT/s9/IWKRSw3
uRDIRA1IkxgFI+PRtmFq7gfGJZOvXdpnR7Nr9XWkI13zPH9SlY51JCgIKaCYmVzc
ne89I4HaPvJ+AmsnctqGgUuqgGvbGxeCMbEfWFGb2addIeVAIifxKUkGM01oSTZU
9E64OVxNqmHoZYfGP0QwyxhocHsHo+QSHtbx1KzUhVzigWyoanUhLNqLJROU18aK
AGmQq+GMvR+ZJpkzDaQ+47Jgbpr3c+iiFsupyg0TPBN6aHSOJnAUbcMIg/G4lt8+
QKxmqsTghHLiKKblk9spzyzaVoG/O3taNkwDafyeoyU5JpY6SMCzOLxB45f5iGM1
DF6XcTp3Np/QDVz9cZNxg1MJGde514m4Pgn3Ioj3xXt8PI2vTG/i1jtnTBwzoGCG
1HJsZhc1W5e7X2BZoURu3hdjJBvXYR9U3znCxbMJotdAsWTOayulMYOy+2tf2U9e
cpfXfc0zA5A46hOuGTVnBbXGYqf2oAvXah9oOkDWB1Xm6OdF+Up5vSIEXqaBsDTy
Ryo8ZO56XtyTZJ+RM+w403861qwebvRjFXwYaIiE6WRwbzppFq7ZejpjtgJspxCL
y9uvPZNYnNySX1D8VH/oMvt3hLIXRULrMDp0MzIghQgeXGyAr94=
=yPaO
-----END PGP SIGNATURE-----
--=-=-=--

