Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29AE73A0B1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJEX-0002l3-Rl; Thu, 22 Jun 2023 08:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE1-0002h4-94
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:46 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJDv-0004hs-Aj
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436118; x=1688040918; i=lukasstraub2@web.de;
 bh=hbQnc5B7sbqpBhLG2YXl+AmDHf0JZy8xQ3zAuAgPEFE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Zta5rK+6aWtKk9i/ES2/LlWRpn2iqs7c30IQaaEgw+eC3KK7hZ8JdRexehJtZfDqLoU9Bpw
 v+79kF0DQNyn3JXQNi8oWKdlXY1SF/50zaBD0DkdpWyBYCizzXBH5i5qkbWTvZwsA4xOg/Q0n
 jbuC9/VZ5BRYOE50qHj+JObphVkzrB91cO0CFKR02ZpJ3u0H7K5++vGBzRRnDZ2AxyruTlrnE
 XRo1NjeMILKxKEueJ0DosT3zNRHA4LsRyc5ykRBp4FGCg2qZM7jv34kmXw2x/Yr7A30G37uNy
 2VmFvGG+QnDEOk+ASkS4FTdoqAriYlMubAoxwmwC6t0EIoyM7J0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG9DE-1qHkjq1mQu-00GdW4; Thu, 22
 Jun 2023 14:15:18 +0200
Date: Thu, 22 Jun 2023 14:15:15 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 1/8] colo: Only support the same qemu version on source and
 destination
Message-ID: <9acf84c3a558357d1c834923b832ddc1d2aa7548.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xFedaaOIsFjPGys/AC.h=wW";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:WAigrmgCJtNl1jf36bTojW5mU+hYAnVCsaGmXJIGNN+YHawfduJ
 bmHmbz41v/dzet2s2tji3pxrG0/0NctwRMTUr7uo5Xvf1UjeNHp/MbGbcvkstTThnPHi0BH
 FS8ElZQggMNGUYOtIysyx1uDCafOye2o2/y5ScWbNKyj3HPDqn1gnuWadHQWEvPZf4WFtbF
 AlMgu9herPfHjBRfmk4/A==
UI-OutboundReport: notjunk:1;M01:P0:6w/8k4xe6qw=;QFqcGMjcsATc4xv1dNbEo2Yl6An
 z+TOsUsmUe81ARzPgsHgZTZF7So5ZfA8gDbwiFSeaxPilloPPVjo+6OipwYLMLEZQ6kszDJxX
 bwDJovKY+V/lJTmBraWr8FNn/lj+RODh031qrGo5A+b0c4w5O5M4NyRTgjeM+T/ByTT0bBbLo
 vKbGuGprxAJH0ftirScreFwak6y9a0MM6CrK3zWbPyjsHnV8v3fLXzUe+8RXk2uCiFBvUvLqh
 oF5ajuMPUqTf8E+pkE2Gq5DsnBMb74RGAUtmZWtvwd0+1gl0g1jc9+LBIFMqufHpjqU01R/rN
 PkWlPXxYDSVj9LsUf3KGrjDEuOQdAgHF7CHvaPGx281Be0ILbA5B3VkDfmtkP8Hk2cFdnD9b9
 tLnpdgsFZlMwUL5P4h/KKSJvnFtEMNmMyYCFEga4gp81SFZTF+K/E6DCIgY+cavK8U6tET90K
 Vt5SA98xPbl33LWbsSvF2Ms+KEIggxIGlYx2OA3NepU/QGeM/QqowpNtnUCIdQKQt8U+3t+Xi
 CrbgrX8/bDks5ui5Ip0eWMEDEM2chPYTIvciDx0UO7MLMsX+mPcaT0FYpPjxIjriMW4gFnzWU
 5XYENlQc4Qp+/TiyAmkuVRe8xk25ee/+gyD/S0PqJA12aEITFJx/tsdNoIlk3+QXaQZmwJSOt
 m509ftCZbdv9B4knmdZeVCBtmrR6Y1uFb/nvKRqJ2G9P9qJUmPLhj2C9h13IH0MadjYBCHE5I
 aXEeTG4Wa+i02FF6rIP8mlNJSuL+zBSsugeFg0Pf5tPNpGHPeKUXk9RebXYDrWEpN9BZ69Wgw
 e3wi2+rA7hjXr6ruxkWVine2Phcl/TNrj2zcSyCRBbWCc7JIcFVbOFGMdNz6ayLUTYz0vxpNv
 5OdS9Qzabu4Uh65M7OWnd9czn/fTLtglIMbkwlogFm2lK8WrVkZQwol0jXogW9Pp9xw6Vhq+F
 fn1m5Vvu2k7jbFs6Dbr52Vz+MSo=
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--Sig_/xFedaaOIsFjPGys/AC.h=wW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 docs/COLO-FT.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index 2e760a4aee..8e64480dbd 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -148,6 +148,8 @@ in test procedure.
 Note: Here we are running both instances on the same host for testing,
 change the IP Addresses if you want to run it on two hosts. Initially
 127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
+Note: COLO is a experimental feature, so currently is should only be used
+with the same qemu version on sourcee and target.
=20
 =3D=3D Startup qemu =3D=3D
 1. Primary:
--=20
2.39.2


--Sig_/xFedaaOIsFjPGys/AC.h=wW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO1MACgkQNasLKJxd
sljCgQ//VUowdiahyyiL//8xyFcTIQc9YwI4qM0Ydx3Z1XUo0bnqFZNCweku1Lu2
NxL8yHsxVN2rGbU9huGxXsLHgtVocAB1IH/+jrNN/iIBJWY2gqAgLToZrko1JwbP
jgGraDkg4zGRUYKE5xRQYlnThnNsW4sXvD/c/pWAAS35UHwWUV/QljofpD8kkGZV
amiSxm766df6DTdyIOn0a1QCZS+S6sgaq3PlL34NSVNcJOkbZcnbNUVF0sjDr6Wa
5LActdtc9UGNDUYLEgKDvRd877CFO5cU4/gip8lr1iJAsf8ZKdpBrIepJh4pbbyd
xMuMEx719GHVVVIXhEl7pI1IzTgp3njflAejlHGADXd/LcqgjGMtR2fMn22472M1
UdSqc3aMuv2noLH5G7WQZOJmzUM/pIlRmRIhW0rQ8irx7NWRNM9y8r16Nngl/BND
b1oItJ0Wn8hFoqcdRM56HiWJ4E8IjCTb4nO6lquu7D8XngSyyUOGbkbfdhQyz8rB
or7p7VxWu07iglr8da2YHksxNITT23nNn+92mps5PP84WqMaLQEgQFFeoEEiId9v
9PV9FhHsPBH5Uoql9KNWcjWvRvkr6Km3ScuODQymCS0ecjZJwZTruud/Ym6GzdvV
alLTM/IbowBQJVPAfQ55nIEqhdsSpqAF7D41J9U5rQO7J3XJ6dQ=
=HP35
-----END PGP SIGNATURE-----

--Sig_/xFedaaOIsFjPGys/AC.h=wW--

