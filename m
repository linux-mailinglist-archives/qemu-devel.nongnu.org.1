Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DA76B897
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrIp-0002M7-Nl; Tue, 01 Aug 2023 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQrIn-0002KK-JS
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:28:49 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQrIl-0005p7-6S
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690903724; bh=kyPlq9m/m/ZKRsTko6vpefjmXDK+3SwDiY8hgNgVrBc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=SxcEgMCwRp69hnIGxlinwnmu0TyNNCsMpQQwB+JuevWA4vPjGe7Ct5UrBnj3u3Mrc
 TDmGLcdtC6R/uJU9nSZc8sHm2iNijQXJuQ1X1hnBoUq6bllPH5xc3qkisROywCIp6P
 Z/QJ2zlpDmzMAE7x9vmWHI5+R+Gi0BkexiCAsP7xMhNUxXH5EXAF/1GoZb/qvBp3Cz
 Vsgk3MWl04QAnNzcmdmSCI0G+AF4hK9fXb6z9jU1sUt78O/scqsRsXF8Vxurnnb8nb
 9Uu7iAQYEJ3WNti23lajnbVVI9SaqttcKi/bOdD6EJTqVuAQ4Izn9a3rotQ2kJLAyr
 K25lR1jc7jPSg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id AECFD3F20801;
 Tue,  1 Aug 2023 08:28:44 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id MZ0aU6MYBUd7; Tue,  1 Aug 2023 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690903723; bh=kyPlq9m/m/ZKRsTko6vpefjmXDK+3SwDiY8hgNgVrBc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=so5xokgiX43lxr0a0aF0kRqaSCpQ7U+Vq9JDuns5m6mZBJE0EhXuGTVeUEXpKOg0D
 c9QuMsBGJHEI+ejGhp+wU9LF5F7DFxGecRdfNIORRIDTFF/JhHNfSSq56zeTblrPqH
 lPy0jogk+1Iq8tVZwFudxwOCjULUQR7lsznTm0laBHrBmSukvl3Zp4+V2OaZCRbdy2
 2Y7iiWBjwZvkB7JliL1cO4Dck4Dhe7oFUigNf6w6e8EEkf4KFT+g4k7+V8fpZluTX+
 YaLcY7kjJQcLcFxkCWGyyf3yPC3VHHoX2xJswhbuw2xSIQgZMxl/LEuTyqNGI5EfIH
 LoqktSUuvSE5A==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 99A183F206C6;
 Tue,  1 Aug 2023 08:28:43 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 7790B1E601E7; Tue,  1 Aug 2023 08:28:43 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut
 <marex@denx.de>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
In-Reply-To: <CAFEAcA-WHHn0-PfJ8vTgZL5xjvR+=n1_We3v7uRT+Phi6DzsMg@mail.gmail.com>
References: <20230731224106.292845-1-keithp@keithp.com>
 <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
 <87r0omol1r.fsf@keithp.com>
 <CAFEAcA-WHHn0-PfJ8vTgZL5xjvR+=n1_We3v7uRT+Phi6DzsMg@mail.gmail.com>
Date: Tue, 01 Aug 2023 08:28:43 -0700
Message-ID: <87o7jqok7o.fsf@keithp.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


> Yeah, the closest to a "standard" we have for nios2 is that
> I asked the Codesourcery folks to document it in the libgloss
> sources and put the URL to it in a comment at the top of
> nios2-semi.c, given that there's no official spec and the
> original and main guest-side user is libgloss.
> m68k is in a similar position only without the URL
> in our source file :-)

Yeah, we had the same ask when getting risc-v semihosting merged. For
that, I actually pushed through an "official" risc-v standard. I kinda
wish I'd used the m68k model instead of the arm model as that provides
simple POSIX semantics...

https://github.com/riscv-software-src/riscv-semihosting/blob/main/riscv-sem=
ihosting-spec.adoc

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTJJKsACgkQ2yIaaQAA
ABEQ+xAAiarIj73F12wxkAu8zuWigEI1YlfaY30cLnEwlOyvv/lktf8lvAxo6GZd
SW8fel01/ctrQhriXMLfX5jbXrLGCLHFc96C7jShj5Yh8uwwdEOQ5iH4b5H54xKw
zX5RCt1kzJEvAGEJEpj3vp6jCARtcA/427qf5pUz7JYviojE3g7GKNYgzwet4ujB
GAb792ddDmFOEn0TIU9y7vRhu4vy3A9gXtQezWyd6SWX1bByMfSEnkI8mf1cKfAC
3CzKPDIZNMAD3lK8S2itzM48IvsWdjEYxcoIHi/WKJaDMyWS0OVhgyTxiQvzjl4W
6CWWzQGCpRl2B2DWpBDQCtOiUp4xSfbB+IedjgmY3oppL2Zr5xDpeUB6g86kwkMJ
1BLqf/M7e2f3MOzVPlIeIVP3483imlLNm9aJBmqGg8bTP+rvIzPgv+Ieh19br1Nt
II3SZJLxgHJ3GDp9Ztd7n2MULGPTTa2lhk5AY92ELotE1TIaYHrjg3LmNyzJWxa3
D2O8pwwMjaw70Pp8e0iVeJpM2V5K/71J4SiXK4kxF808+2iGnuPClORdTQvEDdRr
NxVw3ExEV6gj12/4SVpjrZfOt74q7lWqiEYp1ytXFzx2OZHtg+9mVagiPCWzcyYm
t1w1YdJGrnKpBIQOvj4m5MQa/z8UAtXVS9XlsDjyCJ4uUNnrY6Y=
=4KhG
-----END PGP SIGNATURE-----
--=-=-=--

