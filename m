Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD5D739F59
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCILm-0002vH-0W; Thu, 22 Jun 2023 07:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCILk-0002um-Mp; Thu, 22 Jun 2023 07:19:40 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCILj-0004tM-3n; Thu, 22 Jun 2023 07:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687432776; x=1688037576; i=lukasstraub2@web.de;
 bh=ddWbLBpQVuLtpgtxk3xEWBoFyEIL7NttvuUp3ALaQGo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=uH4zJ7soALs1WIp04BtTOZlf6c22EqLIw36jmvLWq9lv8mTq6cjSxTUwexJKkZu2Ho2TTo3
 1/YflZQPa3jPG3WjKWJuoFtqEc6nLdwMf0yOX1yB4PUCz4xnknu2A5TQn+gSgezgFjivxzea/
 If6myYte0lzoWN5ADOdTJ1UFCwAGsGcXUzZHRr/WDTFuu2F0b9DfaJ5Vt258GmJXqqa1SG2a4
 xqHsyLK+9rMNx3LqSpOL8/jPWRq5e7dIb9S2KGxNqX2cdGpBbb+qUuancK8YxihT8ed+c0tgU
 JCN6taSqwt4yZd4hKWgdO25MEevlBKr7uxGlafs8KohaoMFN9KqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Elg-1pzHkd3o12-0148yX; Thu, 22
 Jun 2023 13:19:36 +0200
Date: Thu, 22 Jun 2023 13:19:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] ide: Fix a rare hang during block draining
Message-ID: <d69ad42912db00f9520a7205c4d2bae6efca5279.1687430874.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j9QAq3kUhqyIl=ux45clnyQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:l8yVPj6Aa0iNe/BphBFKXUvUnHJ2BHRI8o54sDbhUDs2RQXvlzb
 ZyfBQkbmOZGP/Ag8CAScp2fY0RCR2H31AkuN8Sv0L0tUEll/ehKl/Od78aYNptnCB9I2dqS
 uylT76ukoqXkF0eZDNaxFM+hTE9Xu0oPnclEauMwYw+VZXFzKNRcQmojjN4WD1exdfhlg/O
 ThpLkpotvH0BIDogs4xrA==
UI-OutboundReport: notjunk:1;M01:P0:4hMrkcvElhU=;2H5lg0HF+mJ+o05SwwJwEs+TXri
 sIX28w9AaDEkEsyPY4CfFi47o9WRaOF0ahFx9SXi+64dlhhBvgoRx1OSsviFgkSg1WpLGU+al
 W2iiBNNyuG3XEUuTXkx0UxFBtU6CAKcJG4c6J4dwEH4cFbDsWwUvXcGYzb61xOHQhSsKwIIKz
 z08e3QI/fO3vnkqBejAH+3I+i1ekdvqTXDS1rEoli6jwo5VP+sreVkKt7E/67FF23qEuAX9pX
 BnSptXJuJNj4saLYymLE3KFtZp1+x0C8mFa9Oz0/i4hYe/4EKsxILrym5+IzWWIftFirFyaYm
 dPNnVB6xhZPqqYq5v3ljdk/TBI3kLeJD9ZOYXdyMxkpjo9ZY+Evr3P7ERqOSPYdn8C6V3/8wf
 oNiS6uQO0fLV0G37i4Kkf16d6hmKJkQ0tSzv1MUtD1Vu4FxGH2bnkw4OLh0hPfiLG8Loo4ME0
 fi1tijPDPFOcIGOoJ9yReLuUQ3cqOyGQ5kU5KSHbRWPNpmvIddJoX3odDktq97/ns461SW3GG
 ImKSJL8IVt7YeblAg2agjRKCTqUapkWp5ylVd/XT4MPewWM6KYC8KaiAm2XL6srJvhmAmMvqr
 TTg+y7KNaNyrm6GuV2071vsFl6jPfle1cqzhdOkVVb3nXpRRtFRm879nv2Bf0qFNcSPLIg0rZ
 BLTnDo61thd9qDNAyZVUHDVuCD5g4j/4z6Pt7WF21WvSjv/C+uoPbiz5UX7oq5h6or0Ev5c+M
 eN9HwvnrUWcOqX+YKnCUJjH8R39hY8m5F2/HBIlPYL7tkUlBQOz0s66pO6aZtMwh+Pmv18LDY
 doTKhPXu/9XiyuGRa2IRYwJKumRIf4Q90vHpEj6xcXfRq3OvzPMicXnOXmCdS4pwQBqoUM0h9
 ag0mivQ7F8Hwm9FerqkzFHvf2ctWYL07yiL96LzKvfzq+oPvSkWEs8ggxv14zvbFWuNA9qfZu
 6+e8Kg==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

--Sig_/j9QAq3kUhqyIl=ux45clnyQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If the guest issues a discard during a block drain section, the
blk_aio_pdiscard() may not be processed, but queued instead.
And so the callback will never be called to issue the bh and decrease
the BB in-flight number again.
This causes a hang in the drain code, since it will wait forever for the
BB in-flight counter to decrease.

This reverts commit 7e5cdb34 "ide: Increment BB in-flight counter for TRIM =
BH"
to fix this hang. The bug fixed by that commit will be fixed differently
in the next commit.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 hw/ide/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..d172e70f1e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -436,16 +436,12 @@ static const AIOCBInfo trim_aiocb_info =3D {
 static void ide_trim_bh_cb(void *opaque)
 {
     TrimAIOCB *iocb =3D opaque;
-    BlockBackend *blk =3D iocb->s->blk;
=20
     iocb->common.cb(iocb->common.opaque, iocb->ret);
=20
     qemu_bh_delete(iocb->bh);
     iocb->bh =3D NULL;
     qemu_aio_unref(iocb);
-
-    /* Paired with an increment in ide_issue_trim() */
-    blk_dec_in_flight(blk);
 }
=20
 static void ide_issue_trim_cb(void *opaque, int ret)
@@ -516,9 +512,6 @@ BlockAIOCB *ide_issue_trim(
     IDEDevice *dev =3D s->unit ? s->bus->slave : s->bus->master;
     TrimAIOCB *iocb;
=20
-    /* Paired with a decrement in ide_trim_bh_cb() */
-    blk_inc_in_flight(s->blk);
-
     iocb =3D blk_aio_get(&trim_aiocb_info, s->blk, cb, cb_opaque);
     iocb->s =3D s;
     iocb->bh =3D qemu_bh_new_guarded(ide_trim_bh_cb, iocb,
--=20
2.39.2


--Sig_/j9QAq3kUhqyIl=ux45clnyQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSULkQACgkQNasLKJxd
sljU9g//bQ7SIX8/f7hsgfoqjdH6B3u4FmeW88eVX0KrZVDo4eu0iAhvTZMnawxl
QXgLKWBJbp5PSkzeNkh7L7M3itFI3LT2CBc9RjzXy3kTiej0CNBgR2JUvXBAoIZa
Dcbey6PHMmfAqSDNVJUkoBS35crSizgetG+NKTtQ6sVKt1xEXW2Og2L8va87b3N8
/mNsnq9cg41x0JdALpBvOGMw0YxYLiGYUUHMIYjUvz5U7uuepBtzYeoVYTWdfU76
WCwvN5wsxBawbpuD7hrCyPU97sUxtQEilomMLIJd8RHzbGN0G6PiT6KUnoWhgIyX
7xuT0by7Nf+KQ6MxhYsSeu9REFGZKYHD7nK2KJ6Fhk8qaZqXJg1bLsrcCcTElu7o
EA6H9Ssqz08zK4hnbgT0eHuqWY2Ktx25i9Xy66kS3Ya11QDaiAlgRIciBWeGj2dw
GIFaRW6niV+P4+FTSEfKuxqr/QLApUAYkZIzJ1/pwY4dPDuL731PXE5G4g1rSKAA
e7P/+HevU4VttYyOqAeByEBIzqeOt39cq7zEd9OrnOpcfSB0I1igXiXc4eNadZK0
Ztj9ywcqB4soHy+9GspvyQ139Irj/1k2b4Sgt01UNQSuua8wgidkM44VnJAUvO0J
OFG0Gc9vAX1FcatrWP0VEP0XlGqJl12sCbBZk4eMg+Ty4CXqDtE=
=rob9
-----END PGP SIGNATURE-----

--Sig_/j9QAq3kUhqyIl=ux45clnyQ--

