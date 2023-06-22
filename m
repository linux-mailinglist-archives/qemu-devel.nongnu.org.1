Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977D73A0BE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJFo-0004rd-Qj; Thu, 22 Jun 2023 08:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJFH-0004PG-Fz
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:17:07 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJFD-0004zW-1w
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436207; x=1688041007; i=lukasstraub2@web.de;
 bh=g6yu7GvQieWk9mfhwl3BdPKipbnnXa0sMfY+/YG0PfQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=tsQPWgMCqzqIP+5K/wJS/jpiCLfv7kDfCo70nVE3GVcVfry6/hdSm0v+uXOVJr+e2ZEUJsY
 TYs5TrVs4hcnKWZ0dGV0FFrqHkZNCV8TBo6JoZus5zGoNAp5UQZ4b76F6Akn0NgSJhD0UJQen
 Ab2FxyRjUSfDddrlKIO3frHGWDYLumFYRujTJfMu1Aai6w7WA35i7xsYeNeKuwBr8cQmPRt4R
 WY0JYgSlbF9lBDuBQ5BJETirqgBEQQ0JNPMKXcGLU1sw5sRM31h5IXJo+BTE/Pk1RTfM+nM5g
 5UWT+mWcjnNrtOxx4c8YJya3okdKQdCsQF9nGBEagslN5Z1UfEEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1pakV61y75-00hy1w; Thu, 22
 Jun 2023 14:16:47 +0200
Date: Thu, 22 Jun 2023 14:16:44 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 8/8] ram: Remove useless colo special-casing
Message-ID: <5f9a18890044d4c9801c47e9e49a35cbb882a523.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iSfd5ycTwb0trurklglomSB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/mVDHitdH5qFmz2RRtRVeYMsw/TyLcn/V8/+XMuQCI5T7zGftjU
 gklaM3Da65ErO5vv1+rtIHpahtXvuE49ATRqoYHCAAFTOdQAps/wb2Z11me/qQwt3+s19Pl
 qU46nan++MSqPC/QEfHKdbWb+NoGUoM2DNS4fo2rj/Kw7tWBQ6kWbMFAbKWGF01zK/DufdS
 wuoN/gTwE39jTgQjYjMqg==
UI-OutboundReport: notjunk:1;M01:P0:yszvcjABKu8=;/rAD5DSxCL0ypr59SHZ79fhYYsj
 bIDYBKY0Y2I0gJ6v8ZW1/SEYYBWhZikHdPso+LAFcH+WgdUStZ+dAAV7Y7WXkXOXN5V8Cojqp
 4S54WUssOf2IsvEw2VnkByM3/VRGQ/0Z7hbtGPVl90GOZmGe9XaVZR8iiuyRX8BPUf42vlDIH
 eo7+MwXLPkNtl/H43HVmO0SXaYov9sD47S9LO8rDKMW0HLNIEBYJqjCmEblzYS6zdSOtDr6Ok
 RKeacBLFP2S/TFZvPP9jU7Xtl56cx+fnRnu/L4TA7Gye9hUoN4CsGTyAikic4/sNNRGeX41gs
 BaRi8s8dNYeRoBieFVdkeHtmIV4HDSQaBqmiy9Mm/z9VwOgHhlFZOTfGzMrfjHVZhK4wivZke
 dV3/b19bQbXpS0EsnuR8WO8AqhG10/D/8WGxf1yd0RyNzDK9MmMcpaANitgmO0aplmWPs/OPE
 bBPSVRGXi708v/aX0tn6x9y+xVnavVZblJjc6g+97XmbaYlRl9Ry8kcKNMMjIcKZIliJ3m6B7
 pOuLHPdYWZGwtn0mM//nhv0y2raxmlE+iWwxETGWgeb4ynYyUPOeQwdCH6aj3MhQy9jD8/SvR
 U+7omvW495ytFBQgFxuJVUr6Kpb/+bnD7F4zOAsBzWij3vLdgB9eF3eqNacTZ57NMZTerazNa
 AVdz0NUBO5QU+g44AWplMdXJVPda8EC9osI91+xLKAodhvVJpEH8Lg8hPIyf9rY+HKGmYfyvY
 tv3fe05Aa5ESdGjizh/Z8VXva6qNV1pWyCYkBmhH45jHp5VvyWZ5M8sFF6b+nIzZI5z/H79J7
 XR/ASL3286e7SvOUQKCFkABRxfGhfxilQnOKdfUbXSNeW2Wp6TMrGNYqRhZAMvAQtDsbqeceL
 uCHzj+4bcZbp/aU0RoF+12qOeMNyZQwdHY+3pV0txGHHWyAWKwoBs3xns9vilp0fM3H/SyjNN
 Zu5QVXvgsYjdFJaBth1PoUdCKvs=
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

--Sig_/iSfd5ycTwb0trurklglomSB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This is not needed, as colo primary side everything is more or less
a new migration for every checkpoint.

Also, we only enter colo mode after the precopy migration is finished
so this if is always taken. Still add an assert just in case.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e3eadd08cd..e5c1146360 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2994,17 +2994,17 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMBlock *block;
     int ret;
=20
+    assert(!migration_in_colo_state());
+
     if (compress_threads_save_setup()) {
         return -1;
     }
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp) !=3D 0) {
-            compress_threads_save_cleanup();
-            return -1;
-        }
+    if (ram_init_all(rsp) !=3D 0) {
+        compress_threads_save_cleanup();
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     WITH_RCU_READ_LOCK_GUARD() {
--=20
2.39.2

--Sig_/iSfd5ycTwb0trurklglomSB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO6wACgkQNasLKJxd
slhung/8C+nOlrUe2mmif6SDecxxKqXUDgKlMqwQ5MVqm9heLqC/AzmT3+7kaN8e
8XtxS3/8eUsCpFr67delEW2szvW9CddKXzNy2r+LcYdoRHfGMOrcE6nQPJOC2/LC
qrFUQ2ZiC6b4+t8Gby00IQbquIP2MMZvmZbvKYudw0tYnOtOJWwrY7ivjoKPTjM2
P8PoWScWhJIB4ulpiCXVLUSvRnOK6ksd2jOQE5evF7oneHQw5ZwrqZUIeyWyrSdh
4HWnNXysGVaHHA/UJK+8geLhU4sidahwmp+Hh/wqAOUAI2EbNjY7PzXNpEIHaspJ
cQTE4t8PoJaBqreo7k0EU0uEiE6CIRaIjzTVGils7IwhTGam0mBkRlfepsYIgQYM
ZFW4oITRqX/b3lGQDNLzf5eMf03ocimmpjbvOgnS4nDb29yvqsJ1NmkOGKu1CoqC
4Ba01tMvxcJ0bL434Rn9dtvflvNz42RigO793yyAAPQtkjBXsamo0Nl6UL/ZUOl8
3rMqm38oRaqTWB4j5GTH7pFsFE1XkD8u08tPBbFOKAYmhL/jRnGUtSUJwOvWdJDg
yDQ/zwvHSBJln/HYw+k5kHLxCLSX07f4+6QNSZZkHmzv3G8kPBb9EfTKkmRGdwEh
2NMC6b2RRrIGtOTqx0fcZqz055ita4cNkDFDDQFs4AsJFPpIEj8=
=Iq/Z
-----END PGP SIGNATURE-----

--Sig_/iSfd5ycTwb0trurklglomSB--

