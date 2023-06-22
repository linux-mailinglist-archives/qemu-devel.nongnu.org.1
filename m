Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBD73A0B7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJF0-0003kG-EL; Thu, 22 Jun 2023 08:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE8-0002l1-SN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:53 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE4-0004kL-RB
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436137; x=1688040937; i=lukasstraub2@web.de;
 bh=OClwFk1QdVOr62kEg2FxJDxzv/XBVt3YzwoglM/RjDs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=amg6OTA4drXAOQJJlNGQurMl4HCeYG5Vn1L6EGq3bu/dilspZFSn6YBtUZoYwSgqGOQU4bb
 Kdt/1TIkdBD2c9PLZ1EzF5zNKXjKOBM+FfhOnkDmEDesZY5luwe30Je5ERDhj0PS+sJI9CYGb
 Fq7g3lasitw2NBF4dPswcpAeLQxiOho39TKGB8jtJbkYyMk2ZzrkZpCwZybEnh0qdDsk6mvZv
 MRAFWisl1rqv386P0SRcBDv+bLSn47VoIWaECRfyBC8LMCHxl5FlI9PmJw6w2+DlByt2/su+a
 GZii6bVT6UdnXpjLJdEIs58MJPmhGAZxWKP7rCIKFxZjRT5EujFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoNZM-1pjmxV2xei-00obHZ; Thu, 22
 Jun 2023 14:15:37 +0200
Date: Thu, 22 Jun 2023 14:15:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 3/8] colo: Replace migration_incoming_colo_enabled() with
 migrate_colo()
Message-ID: <1e6ab707c554a5ae8aa7497cc988f5032a2d1351.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FXU4NaZA5V_GSmL9Q/US199";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:mUZnEJfguqMtFbYK2OgayIraqHIGf4uDj6rgbT4/3VLiT7UO1hS
 r5kvZaePRAzlrUA7uWSqIRAKrRL/ZpH26Re90HwOJiWsMDl8EEXf/C68bTVtO+pKGqEzoLd
 xC4gODeRdiKw4RL28R0KWngT3APnUq5nh9hFOM7g1mMAVqLEY2Nfoy8BKina6noTEk9mFmq
 N6oXefg7iVxs2jSQcarTA==
UI-OutboundReport: notjunk:1;M01:P0:QYi0jRSvt2A=;tp72257pT2Izp7lMKvbsnLGskfD
 w5itNrK62lZNAWYDZDAhUMH+8EsiUm7u0WLjkTDC2wYSohMgFOoF0mZHYr8cgGULgpAY8j0vN
 uOKar6W91LIBZvyJpmRmPWDs0NHSzwpCw72guIaa57ctO+Rk2NGPrpjtf82b2JR5qzV9/BoE3
 L0rsudulnZEnK5dwIVBnliqLeWMXqeTrg0+LqQhh1ooz04KdlfV2JhW8j7CmJFXtUAz9l0ptr
 uP9rrk+lfX/p1VPlhVTTdIvQksR2VtcdchpteVO1BpmSHhVWeUbnM84uWvWUfwxJuvA97Nbhd
 zA6o2xdKHe7n0TIJqe7vkznaE/Lcm///2JYDpeTZ8m3jLpJYlhMhjcC3Yv/56vJ27BrV3OLGb
 pJp9iqNp9+EPQnK4JFvdl50tcMj5E0RgSKbLdqrMMyycI3G8FuTeXLNJ9nmFB96I2U+DRJdBa
 tt2KOhHZOTwjyd5UiGscjIaG6Vzmq11PiDR3BjEaNKyZh7eNcBXRQFZaC7sS/kBor1xuQToWx
 0DBmM/27yRZINiZIN1Fvs9XwwFvLd8VktidUAAZ94DK+jsXPSb/cBQ732CC5AkRxi0K6FiDQX
 6Kdn5IfjCEeYJE/DVV6oEZb1V4KOxCVxJ3AmxrgAWr6rSTNiU8LZrvtQ9BMBqSe+caajMLHuG
 vPpJbjIdZb1dkUtqXTyKpFoKazFUeAxfUUiI5soI2C0gDf4U4uFKJllS5f17Zd6CpUpXff+xT
 QbIfQLvnhFQuLJcj4Mw4AWVVr6VA+qUnYP13czKT0ZXyJpAMZN3dDUpl4IW7hpDknzTtydLSu
 VIs6MnwI1wHS28eX2YMQBAoU4aAsOqwsBpG14e8ru2JUOwB9UdqjlIjQF8KxoH+0FSNX7MzNw
 tUHZYrwpaTwR216QkNf2OyZzWnzRCM9eTA5mZAD1H/bsQAdL8q1iyDg9i9CqHnkgF543flEOt
 w84DTG0YFukGUIU4qBPZ9I4vlAw=
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

--Sig_/FXU4NaZA5V_GSmL9Q/US199
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 include/migration/colo.h | 1 -
 migration/colo.c         | 2 +-
 migration/migration.c    | 7 +------
 migration/ram.c          | 2 +-
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index eaac07f26d..4a1955067b 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -27,7 +27,6 @@ bool migration_in_colo_state(void);
 /* loadvm */
 int migration_incoming_enable_colo(void);
 void migration_incoming_disable_colo(void);
-bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/colo.c b/migration/colo.c
index 72f4f7b37e..8b0e7c9af3 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -927,7 +927,7 @@ int coroutine_fn colo_incoming_co(void)
=20
     assert(qemu_mutex_iothread_locked());
=20
-    if (!migration_incoming_colo_enabled()) {
+    if (!migrate_colo()) {
         return 0;
     }
=20
diff --git a/migration/migration.c b/migration/migration.c
index 050bd8ffc8..2506fd63f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -379,11 +379,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState *=
mis,
 }
=20
 static bool migration_colo_enabled;
-bool migration_incoming_colo_enabled(void)
-{
-    return migration_colo_enabled;
-}
-
 void migration_incoming_disable_colo(void)
 {
     ram_block_discard_disable(false);
@@ -484,7 +479,7 @@ static void process_incoming_migration_bh(void *opaque)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-    } else if (migration_incoming_colo_enabled()) {
+    } else if (migrate_colo()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
diff --git a/migration/ram.c b/migration/ram.c
index 5283a75f02..e3eadd08cd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3892,7 +3892,7 @@ static int ram_load_precopy(QEMUFile *f)
              * speed of the migration, but it obviously reduce the downtim=
e of
              * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_colo_enabled()) {
+            if (migrate_colo()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporarily=
 */
                     host =3D colo_cache_from_block_offset(block, addr, tru=
e);
--=20
2.39.2


--Sig_/FXU4NaZA5V_GSmL9Q/US199
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO2YACgkQNasLKJxd
slj4RBAAgWe1S9q4tiX0yu2LgJPvmclNHDR62Z8s69Lqp6FSp1e78NssdyZGYLGO
B7vneFm9TkoeSn4YmVObjyYaz7Zj9BWeSs97NL4v3vff44X2kai2WQNs1m/33rWn
sHFBXU4mh/y6ZQnhssNkSHVlZRFyWMuSj/hYW6KL5yi160mC4jBnqFb9By1AgEne
6hqaSSLWoBZHBZMY8wT3Ywp6/ezoD6AQxsYZ0mG9knnaGbl9JYd/uQ6PvS1LLqUO
IYBm1aUDxAG8mmfARrQS81ww8lVQm4LJSzJodRQ/Epz9PhHjvHFrbuIyRnqZtgj0
MaOOP6CHItOt7Skm3L2XPAV1uIQiGS4hwzIn8Z1TdiQa2oAgow/Cc4mYfVngn/me
QCY33C8wLLLLUGcp37+qbRzBtfNd5d8o/ihnoaiPH+jXynrfeThV/cnN9/QwiShs
MG8MMWx+JlzDgarUI5AZ4d1MolwD6QP4XR4WLpdyp/kWnfU7MAQ0ks1UKiDdVJTN
YFVl1Fhpx/Akyezafx8sR41oEe1z5h99tFWnL3GgNuThjPfuPZBiKaz88nsbIvvD
kte9dFcStMOtcf91LeC53M4K5dbrVglpWMatfeUUVWPo1uaBHTpjp5ksnbCzMB11
v//xI7pmymt9Q3J2Lar/u4qIiZ84Z30ljoyDeuXgh5RGU+P/muE=
=BQ4u
-----END PGP SIGNATURE-----

--Sig_/FXU4NaZA5V_GSmL9Q/US199--

