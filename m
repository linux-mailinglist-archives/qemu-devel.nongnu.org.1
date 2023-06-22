Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206373A0B6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJF1-0003ro-Bm; Thu, 22 Jun 2023 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJEe-0003OE-OE
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:33 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJEc-0004sA-Ly
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436166; x=1688040966; i=lukasstraub2@web.de;
 bh=Px+Y/tVB+Oj9OhJDFyDlzeSvmWStrMZ2B884l15ZcAw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=oOliFi2qcu3+QMRZDA6tq2v0Tt7o8asXtMF6XSafsA08Dq6JtiB/H57bkeS3G/DQVSpeBDv
 8d4llqhkP0IwozvBKkPdpkXosNAbEx/PAe84hjD1PQaEq2CK9WuKTCgP5Htp1gS3oBUiimXT4
 1gZW9kHSZvx7HLtLSsFX0pPGo+7SF37t0uZM2NvYBCYkUdQEPV48ryCbPIqA3BP8UutECmnao
 6ArzYzLNoPNjNHkHuGlhnBg2cGb6t9tTPt0SgRyp81Esc3yAPg3NjcUJJMilr2+RU0Al43AFo
 h09SwFubSgrH6G0ovtkj0KGhASxgF++UM5wy8hVKfu6lWTBQTuKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Movne-1pjExE3538-00qFRh; Thu, 22
 Jun 2023 14:16:06 +0200
Date: Thu, 22 Jun 2023 14:16:03 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 6/8] colo: Reject colo with postcopy capability enabled
Message-ID: <1054ff7b2410ce8ec05a8b60cdc8faf306a7374d.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/epmtosof8T9sv8V.L/DdCCi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:y4DshqWHV2DQ2aDrKmbjEuvEL37cnBwpv5al7mJPhqpX1B5al2q
 LYEWV9L73GzQen9vFlcmnVVWAKsAst6UlYos+Av1M+abG9Qt2oRttLUZnzCsts8dCu42PxC
 3EWS9XVTJGY1l5Q8EpzrwrDtFHfbN1Rs+CF4I7cfHPXXMjDz42ccCUMtkn8ROyXvHaKPNQD
 dBLbjLoYw9JptR+SWNK/g==
UI-OutboundReport: notjunk:1;M01:P0:xOoR/uL/bQ8=;15XvXhvdrGu2H3D5uhVAx1PdiQc
 LIpN/dz62oOJfXYW8oPRMEGrl/WA2Vq+a7zNsnynCQ7IPqU6vccLw0EQi2S2O7cMjoLOs2ivg
 tQ2ZBGhboMWm1V1bW131nRZRrjeZW5GfhH3pw0EQg4MCGkR1165HeRBmCpEKm9VcG3yOR5Dvt
 Sh1cx0m2LPBhUXAToytYyggXcG4ORLWgJQIOiAlz7zVLUy57sDzDJio+kjeE4kdeKSdceKi4c
 YexEEsogsiaPcEIP8k3k3p8EZmmweTcLTg3vEQOJqSOd7O+xZuCithFvcFwxtFXezxEXjKT0z
 ZvHSDFCv03vKnrld5pCfD4p188bmwSaNDOtYdfUKLWgQ4s7tSxnbN31bT3ab63U5jzWCl/X3x
 +U2Mp9SF9d0tj9XWC1IwFd+gMUlK7RIj8Z74meW08lBctUW4mTmItnHoHNLooB3Ream3iXYH/
 E1AHsR57Z4f07h/Ka8KIAht9ZeeGLeZbsCAS3efL3vuHxwt+C0BJdDDvqu5yULakx+lzyMsSg
 ZljLnXQGNmiCAqIp1oHYn9kUjLYlx3Wb9WBP+qdgheJLPWOOn5q+SpaiY84Bbi2YUt+/OYJJk
 wUNH6HvQ1z7724olc7u6V2NbWebKE2b/FF4ip+/VvdyvZBKAIlnzZIiLRXG3rp3c4wfKWlztC
 xZAQ9IwYENXSAcue35ytflTY3cjzCUHcMJDeI9BHaf+HMNJk2eFhPOpjfdLaS2dIWsiHVKJ9d
 2+NHmZ6L8suLPzUPyahShbCw/6yR+C12IwaN21IjvqwdFekMVa/EPTt7tc1AfWsffZ2SxY25D
 mQsduIW9/hWeP3y/wtKxFVV5gvEoVqfT8QzxVcQ5IyEWCpW7MgcRbvWdyH88U2KkDTZdNsCxW
 FZ45Npwi7A4/EYKl1j9gomKHJmjalbIPnpFnM4PV2GOMvZcYoHGmlS6aHlOmAwTtR+kxhUWRT
 v15JHzth2ugnsW+Ok3URRvhUp1w=
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

--Sig_/epmtosof8T9sv8V.L/DdCCi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c | 5 +++--
 migration/options.c   | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a954ff4f7d..9860f960f2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2333,9 +2333,10 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
=20
-    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
+    if (migrate_colo()) {
         /* COLO does not support postcopy */
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+        assert(s->state !=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
+        migrate_set_state(&s->state, current_active_state,
                           MIGRATION_STATUS_COLO);
     } else {
         migrate_set_state(&s->state, current_active_state,
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..d3d4525d40 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -445,8 +445,17 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps=
, Error **errp)
         error_append_hint(errp, "Please enable replication before COLO.\n"=
);
         return false;
     }
+#else
+    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+            error_setg(errp, "COLO is not compatible with postcopy");
+            return false;
+        }
+    }
 #endif
=20
+
+
     if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
         /* This check is reasonably expensive, so only when it's being
          * set the first time, also it's only the destination that needs
--=20
2.39.2


--Sig_/epmtosof8T9sv8V.L/DdCCi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO4MACgkQNasLKJxd
sljuBQ/+JbPF7jSp4HfviRHxjnwCd531pGqbts++IrCViCczHCe848kM9aUfh5D5
sZPCqTeRY/1OviGB7FLWZF3w17uqGx/is75GnszxZhbLBKkGBebMObPknO4tkbjK
ejFadq4V6bAIzksXqYAjzvJvG4NU9ZHhv+vK5i8YZmeaYJ6mntk+XYdkKW/mi7oK
rkzAD/HCS+FO7DKd5kdvmO17r4fg0ZIfLeNUMmNLQOD+HJjm5tYM8Oof/DLn/w/8
qcgDAtx5epB+EVTig0L0LWC+XrsoSWOYaFvn7hasDcY2EiwKJG3prftI4SLEfL6P
FmqjLgqEMiZr73b1w2OP+WdOpFQ4eJ00W4cj5kLzmqeG1jKtKowOgnnbvrTxN2vZ
4bxS3yPwEj8FAMgkLcLAfPAEEhxm2cnm8u8X925p3q1o1XpToYUt+WznH/9O1DnN
YjM9o5ZnuggbT564jwD6E9xLiyjkUJnwS2f+0klgRrCFacN8GJ4ZbrhFu2o3+zMd
FkDNuh1JplPF2767dNRi5egAoAjFlyTAVTh6Bf8UJLcoqegFItVy/ZQc9TJFSm95
Xox8K9T/FPI5EcaxWBkYSWElNlNbBvkingO5W4jAw9NsFVgTxuMlNLoNwF9ukSbn
iekKmETetkx/ExvbPSHwJaGf0caGX+GKjrQOkCgCoRp55E7+qfs=
=chN3
-----END PGP SIGNATURE-----

--Sig_/epmtosof8T9sv8V.L/DdCCi--

