Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C7673A0BA
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:19:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJEy-0003HA-CI; Thu, 22 Jun 2023 08:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE5-0002jQ-1h
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:51 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJE1-0004ja-2I
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436129; x=1688040929; i=lukasstraub2@web.de;
 bh=eqH2U4fEnluonyQhABHLQ3e0x8Vrc66j24B8XUKpzfc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FAfJRoLnZEvBI7lf5TCSOJbSfgq+RSAesiWuSlLtCxEcgYGKa+HwQ2NIEZq19Gw0rqJSj+Q
 coOQqhsvdu2KEJpZMo/xdTuETK4xqT8A74Jc2kIdx2ZJIv/cLrlDd3pFd9PGYTPB755Q6TpxA
 rAo7qnmbU4L7YcxgrxdvSeo0Mp0z68JXfbZtkUC3t3zCZI6gVyrnaSaOOJjdKFOmegAoWqoZn
 9be5pXaQ9j9ZQUArHS6zoM/8HMGodx/yldnbxRwnwU4TEQqJ4OiK0wwgz4ihVffTYQISzaDKY
 QoDtX1wS6CTdkbNQ98yi5qeK87F7Dw2/qNGbdFDQEyEOMZKZi6lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQYX-1pmHvU34uP-00iIdA; Thu, 22
 Jun 2023 14:15:29 +0200
Date: Thu, 22 Jun 2023 14:15:26 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 2/8] colo: Setup ram cache in normal migration path
Message-ID: <dcc6c36a6225cb883c9d58697351a316b8b285e3.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mL2JbU9Z5BXS4FHVUj48THa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KsusEnZSB//mYFcbOAwad4HTUx904f4PvvJ/5P4rrjZmIP7+6yy
 gaz2f7/QLFJzmpndOciVGWQqEROMh8AvsSdy+yEaWY/iqrHHHtInJotXLjDvhwCApwavh8K
 Q+VtPrHwCCpcuVB1Zn93unLdatPKkQK2MydN2LvLRPfOpyW/FpwgyOjEiII7HP1deAAwwm2
 lFzEYfVBCX6cAMWDYBYCw==
UI-OutboundReport: notjunk:1;M01:P0:8GT7lOm08sU=;oW5W61uBO350/hoTqC93xBLkmTk
 wUkkgiQwvgr/0FeaYInqpcTRhbIVMDlA0+/eL8YNoQYAKLHzQeBaCo7FhUSJlj+bXB6VCDYTC
 cdCYaISNwlRJdVWRBnEHUQajE9COU3vZBCnQOJMtQlawQmcBa4VvqIonVuKnus+tEyDASeVdv
 474v3NUneLqHtq+x8/lbBkikG+AQGpC2C5wuJ0o20cQzicAC2/HxUyrG+LhAywHz/IXj8tL7E
 xO+24dNkZcw9pyDBlRhfS/LVTunkTXL/vyw4MQrATtSe5htpMLezCw6k61qsVHpoaPdnRO5Ze
 gLjrYORwcu1begUYVdWTn5eZpug/TdlofJCaBqRXRR8O77iOwiq3hY9Gkj0LjBru2U8cCPzm9
 EJh7Cil6KsRBfd57c2+Kro7FQUleoVTHOsYYguHCLZQDQVO82T3ZONtgB5E+VTHrgElzccw8W
 cW5Utp3ERBbm/v8GLIVY8289WfY4Ti5hF9rUHEjLiaRUtZU5YEEtVXAonaqGCXhz9T5wSYBfc
 Mgag3ll3/b74Wdu1W+kc4ixQ0csxIjlpFyzjDRSFotjF5v0RdYQ87BsbQ1HLHM27YuTLhZAGU
 FX6H8gTNFZuKOHEiaUMlAk/YlstvQwsl7uGoBMcHFgFOo50YL2OLQbn7Tqv0sAHppjgF6RGAV
 rXQzxJiYRq31EY9MRHGFz5oXqygXRN4BRtlqY76lE2YoiiPAPEjUoNXdhohyA/UXl0mBUhDIJ
 uq9QDpYBHSTcTxalHZdt/5QQD9B3IcGnT3E5dLXG0voHhqZ6gmWGwoj9V41PlgSrVCB8R7KRe
 K+gY629hGWhZZNQqkh2JnF4RY5b5hcYDAVbq4Sj6904yu8zDC05yZjrsMCXvT4By68PB/qfe1
 QnbGjt6S0+jQ0R1SsWEMw55qpZt06GyQ8UeRE2rOKLcjw/DuY8FH9OSe/0Ema6BMF+gHXM1cK
 wGYoew==
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

--Sig_/mL2JbU9Z5BXS4FHVUj48THa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Now that x-colo capability needs to be always enabled on the
incoming side we can use that to initialize the ram cache in
the normal migration path.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c | 16 ++++++++++++----
 migration/savevm.c    | 10 +---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea..050bd8ffc8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -404,10 +404,6 @@ int migration_incoming_enable_colo(void)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_report("COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -519,6 +515,18 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_report("COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        if (colo_init_ram_cache() < 0) {
+            error_report("Init ram cache failed");
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
diff --git a/migration/savevm.c b/migration/savevm.c
index bc284087f9..155abb0fda 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2302,15 +2302,7 @@ static int loadvm_handle_recv_bitmap(MigrationIncomi=
ngState *mis,
=20
 static int loadvm_process_enable_colo(MigrationIncomingState *mis)
 {
-    int ret =3D migration_incoming_enable_colo();
-
-    if (!ret) {
-        ret =3D colo_init_ram_cache();
-        if (ret) {
-            migration_incoming_disable_colo();
-        }
-    }
-    return ret;
+    return migration_incoming_enable_colo();
 }
=20
 /*
--=20
2.39.2


--Sig_/mL2JbU9Z5BXS4FHVUj48THa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO14ACgkQNasLKJxd
sljAZQ//d/tT5MKXtzMNGLHVEZZArKgbz59Ady0gAqi2Iffi5O8/43xdwrKz6KwB
chxWeHz+mXlxWUnNvWn8gZQ3iJVWsk9jJ5LjYfiRg+/m2zMtaYa3hRfebWlMaBRo
X0W6PJNoG/yEBHIfLsMR5+qguZ2tbZl9udXHeWOwKnMDQyem9femFDU0An7Tp8bg
AojTT7Q0/0ipLffr1lyRLvY+slxMxOuLEFzrWzfKQtslorNciusQuDB/NG3ACxp7
H6QqhSqMYpodHEFrj/OJaCIVUX9qpxyfSR1sM2tuCbiWSWcMl//v5VpYaIjp8g+H
JbXsqnuN7kMrVZZCZhDd7T2l3r0OAnCEs5gInupJJALzL+0em3gbKIEV86XQ8Rd4
+elVPh98O5e/cDlXANFnnmkx3no3j3yPy1XNn0bvf78ko230e4qc3U+JlAwfA0QL
MHnm8JR13sCi+SRAFhbeSA7q2FG2ZYn8jAW0mtnV/QvsGjJkRFB/OwgAOz/L20g1
uMBas6TJlaA/5JE5z0jbMIy884mb2nosw+k1z5OAVldvxbZALm42sYnozx0i0aUH
xj6GVqUhVrhxq/FzmYP4ApoNQzElNKDMseOi/t3NCjB8nGKHtPRwmeQiyxJ3GOGh
kix+96u/Va2forF6TxEy813Q36aqyQ2a2bQH9yJxNtP3v0H0tCc=
=j/fk
-----END PGP SIGNATURE-----

--Sig_/mL2JbU9Z5BXS4FHVUj48THa--

