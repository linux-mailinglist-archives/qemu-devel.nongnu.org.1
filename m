Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A468273A0B0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJEX-0002l5-RE; Thu, 22 Jun 2023 08:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE1-0002h2-5I
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:46 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJDt-0004dv-Qz
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436106; x=1688040906; i=lukasstraub2@web.de;
 bh=dWKiLIPazjrKIoBFOSuNizoBOqNozbNEZjEKUGglzlM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=kbWAEsGJ/FhvYpyM5sDKnlgMzHER7vLcCA4RhPFpdv33aijuKV+YEB7yLPO+XMojULFmyIn
 kEf/Qe80oGWa1wYRhbrTcKc3Jw2f6tr8xdauez0PYaEN3LnfOLkdrpRbwKquIQMqqdgCQkIVw
 Eo2a2WRB9i5vjGp8eqz4/fPod9h4uOYVSNZJmxnPGoO+3LeWP0VSd89riFSruC21WkjuLNncU
 4hvzodfmTDqNML7A/H/fzhYin5Dm+EutqxPD2fAVTKQzWtH4g0sA4SQGccWgj3nwf/UHOV2Hy
 yE7wjLrmFgmgKqV45J6jkngZmDvgydUpORWbB+PBlYkWzYVghkcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1q2HI110CR-01763L; Thu, 22
 Jun 2023 14:15:06 +0200
Date: Thu, 22 Jun 2023 14:14:40 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 0/8] colo migration cleanups
Message-ID: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XKOab+1y2CfoHP7PyqU5Ou5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:OuNwq3QlU08/iYKxNsrXGgU/skhze3C6T1v92Lu/p1YUbfCV2cK
 Jy8HzNACqSASuPiI6of5i1r6T438eiuW9/bzArh58sRJdboG+HfXpU0XHSFVgow26G2uF7S
 KdO361swpZDzKPYlnavLFxas1DnhhVa4lvAkjZ+xZUZ3BhmVN+SS6VL4KZ/HBHjXgduNTeA
 EsdU0iV4jaNZs9Fd6Z/Kw==
UI-OutboundReport: notjunk:1;M01:P0:Qtxd6hg/4Og=;iI4lU8/wNB3h0v+3LT1SsjQhhSi
 AKhZZaBdSvgBqvREmG1AAbB2MhuYtHbFDNmIUCCRjKn/F+OE0OAjIdOL2G4qrKNIqYY0SgXfg
 BCW4NzhQHaIoNhxbVE8jOuAF4vti9xHv1UjJp72YK5Mp5yImxjzJerCpaaAz+MD8+uO/PtBUL
 M8VuuVZ+7Kil8SxxBV2HHqni/FYaRdlwEg2HXpSq+Y2MyDTR6rnZTrsWiu0ZNRX/w9YvZ11KZ
 JfLumszbOwm5J5cZ4FReA8E0u4vuA7HjqnlZMgtLeKRnaTsZ0L0i30WBkppVxQy5RU3M+/TV9
 AQhooX7iTV+2+2wQ+Lcvt+FAEMKVc7poqqHC4mvkLaD0bhUm+k6iQodvsLkmNM0rpzhOgHpx/
 /2NMA9IEzPGfNEAZyLknaib/3KIGVnCC7e6PuAovRAHnhnZnRFPSnTN2G2SpXS2kGWiQcfTfi
 m6P1uvqw0w74/DxalnukwCHEkW48KUXpYfJ0N5zlALNjgNGwiZXvLD57m+rUjd2eXbn8TLUQz
 Kfj76rN4NRtLNoxSNDUboPp0M5qi3xgrRiQM7+s15oESXWynhEUoVaNYLlifXNwjYs0Ixrg3v
 pA6QI56d4pElDbF7Ikkun0hzl4MwD0OOVZD0I0K6PneTTSkgC+p6+tZS3vqIxYrZhj8e5GfAj
 Px9IS1OkPnplJya9BLRBqtXP6yR2BRX6aDuUDKAAnfz4WKh6Icv8MkfO++yfsPQ+x04EO5lyJ
 oA/nLvk+mnqXMNgzKh8Dg+a/7y7IQ9mXULnMFGn0FRl3y9GU/w5CRGXLsYs32bFF66lQ8vUIS
 1GzxsUQt/HWe/5YG9qUE5TL77yXiCVRQhlxW60aPrnrBsqJQYg3tImD7k5aMYzWocSYlrVUJv
 Q+HjMfvuahCKRggF4aWGEbXQaqKL367/e4L5R8ZkJCzP1AnEWP41pfUCWb2Sg+Xw9flQU86xx
 g+ycfKfk+ZZkzm3pzZ6mPGvlnIk=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/XKOab+1y2CfoHP7PyqU5Ou5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are some cleanups around the colo migration code. Notably, we only
support the same qemu version on both sides for now. Though in this
patchset I still try to be support migration to a newer qemu version.

Lukas Straub (8):
  colo: Only support the same qemu version on source and destination
  colo: Setup ram cache in normal migration path
  colo: Replace migration_incoming_colo_enabled() with migrate_colo()
  colo: Remove ENABLE_COLO loadvm command functions
  colo: Don't send ENABLE_COLO command
  colo: Reject colo with postcopy capability enabled
  colo: Reject colo with block migration capability enabled
  ram: Remove useless colo special-casing

 docs/COLO-FT.txt         |  2 ++
 include/migration/colo.h |  3 --
 migration/colo.c         |  2 +-
 migration/migration.c    | 63 ++++++++++------------------------------
 migration/options.c      | 14 +++++++++
 migration/ram.c          | 14 ++++-----
 migration/savevm.c       | 21 +-------------
 migration/savevm.h       |  1 -
 migration/trace-events   |  1 -
 9 files changed, 41 insertions(+), 80 deletions(-)

--=20
2.39.2

--Sig_/XKOab+1y2CfoHP7PyqU5Ou5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUOzAACgkQNasLKJxd
slhqLw/+NrQs9TI0mPBVE3D9LNIVx8BnA6LekbRiVKiyhWQ+mehR9ZF+Vw2TtHjR
ED+A1xG9zaZV2d37GoQ263SmnlH3bi1elo3D9qqkBdoVQeGACUEuaK+c1RmgIAGO
KHyolMHHDHNJLGenLFUyS+ZDiibt3P8mp2REAXrENsdW1eDBU37pguzopf/GzJEW
a3w1JpADBMbwwqloUZ3thcif9xdRZ3xs1VZGKkbr4N4/FKJfgLszdzsbg1skY7kv
vThVk/W9QYkjOyGucykeLzwuEqzhRUyEN2RSgciByBJ2zeqxLWNvJrzu9H6VAAgR
FhF4tnPexgJwjOz2OrDMMTryA+/BSlo+wl1jB5MGr7bu1P9m04HenGyk7dg7kqNg
OF7vMfUIC3V7Um+QEmhjVwyL9Tobu8eTGWMZ9w7DVx600ldSHI80xBHezpNToWE9
R9+I6sNRHVK6MV0OZntpOQIGShglRM8SveFAByrf+BA42lLcLpecpGtQJ1L5Ds5L
Wr5PR4O+hnyHBdpVk48WaAKV+YkeU0NcyA8xn4Ml7ktf3zC/L4rMj7oiOb5R2Z/J
QEC1bQPSXzPOoWLpy8A2NkUQOA8dI5UJe/m+CNf8QOFSKzCNV9YrOwGrtGJuYfbo
XRe8/jVBooXBPuJCb++CzNbcKG+TdQ93GPMYqgtcBzQxLmjgZEQ=
=3IRl
-----END PGP SIGNATURE-----

--Sig_/XKOab+1y2CfoHP7PyqU5Ou5--

