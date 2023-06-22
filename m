Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098373A0BB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJFD-0003wX-6R; Thu, 22 Jun 2023 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJEN-0002vp-GD
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:09 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJEK-0004oG-Qd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436150; x=1688040950; i=lukasstraub2@web.de;
 bh=ea7VwcjFFAVHqWFdORSqpLl0iTAREXn2aHg2ceqegUA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YRplzXbFyj6v5Bz3764QVejYFwJLlEZCcziKJuICUKUuACxzYS6Nl/UOZvFKDUn/pFvR77O
 B82T1otwXZQ6as/JhPCVGkUqJYxH4uaKTwf2JTgPKyrI8TvbXJ2s7kq2eGDMHGi4NlosS8923
 T3QRegvdfauj+IfTS8by2p2zXIwy8UiufXYH8yklPjKDjzVNTMCVbtpusGD47p3XCRqhY288J
 HHaWQvELqXeF/PNa9mNL2RuJ5a9LYlZ1mpQD1UmfBap2Qjj3xX3UzGUn6CtDEZJqtfFkeqA/z
 0lbhIRun1UhejNkC/d2Yr0QCnDtFwfBXjcLAVNEUHVVv5+jLveTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1qSIZg16x0-00Omjr; Thu, 22
 Jun 2023 14:15:50 +0200
Date: Thu, 22 Jun 2023 14:15:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 4/8] colo: Remove ENABLE_COLO loadvm command functions
Message-ID: <5628c538ff7b35246b5acb09d82420abbadccf02.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.9AEkJabhCLPvezCg4a.BK.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:rHf2CjxAyFfBTIw421O2e/9f41n+xaSpBVwxOgdOFs4sBT9d0RI
 ur+hHtg4f3+4kvOEgf9wadssPCPSe0bWeDZYAxMMzkFttjGAQaVoN1z2/tm1C953RzQpXsF
 sSwa9mz0JIaHBdFoLo+DR3b5eKj4YDNmG7w4X+U4kfoSbiEMxfhKV3Yuqba8w4/n3UfOQVs
 8tf0sp6rFm1Cf26lTwwcA==
UI-OutboundReport: notjunk:1;M01:P0:ErDGgjUG4O8=;iCVAnIzWattqwr2fWBa+rITyFLY
 2eJh319jrngPEx7hIo17e3jFrIii3bsrDVMgt91f8HsL6T3c1ysk0R4XLV3iOhYpSug9u6NFx
 5iqjsrH+GpY4aq9cODhnn5qs4oAI4DWWl28eaJEp+trkTqpSjqc23u6uWvTDSGEIgMFycGNXk
 lpQLxT7K8umOQqMM2RWAxiryzzjfu5ASLMjvob36JQD19s9AnvFs2+URHniXJlsfAxUZ/IfoT
 FtxU0eGu76XkO/gLBkqhjpjdnGe+DO2mE9/Vext9Bhecn0ZqPLsVjR80krf0JGSRp6jPU5oqJ
 9uJCvTYUaVHbVG1u4z5/KDKaYjyjminOiqWMF3/vqzWxyc/1au/nDNHEXnkhrfKxAaG2WD1Uy
 1sbW9wy6Lx32x56zC3u56SoDYejEkQITxDGtnc0FhN2m5PfweWmSBV/a3Ugr8sIJ+Gvosq6Hi
 tHsqU0/SO28iB/+zF0/IjH51+HCmhCRMocg2L4xAy5H1ffCBfKhZsnjp5xAPsB8ojbc5N7Vlp
 GWMIlbxssrrKeegnZH1NuTWg2BzGmal4BcY6B4a4S62mS+5higpvY/VYfz27GWPAadlc6d5BQ
 +mJF8zLZqp96f6DVdevnHqOQPxURfhhdJIdlduUlf6qR8VejhPepaFKRJbUyp7uc3aSpYjrOa
 5UhHuFgyNFIEbF2TahNAb9Gl/2pOTQ5HaUg7maS1xRd/ZNGWyCkTDs31I/BNIFU33kFS6Crhs
 GIYijHrQu+53noiEQI6E8vmfCva/HKl5KELn6+V9ZQDFZszQLaT9ozncH3HRYR6j7Tlq7q6KN
 lNt3vEhJjCnIAdYJVBdzu+Y9IuX5BODAV/NOXnt/ou0QQCrLPDdoR0tmWnaYN90TEnqaImK81
 chCbWRRPm1a//FueJShZSC82x09owp0HqI3qpBr1tEHNG07C/UM3Oi3v0KIxUXUDE1CeuA/Co
 7qMZ8HxhtAB68MrhLYU1pcLCG/Y=
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

--Sig_/.9AEkJabhCLPvezCg4a.BK.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

No need for it anymore now that x-colo capability is required
on incoming side. Still accept the command as noop, for
compatibility with older qemu.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 include/migration/colo.h |  2 --
 migration/migration.c    | 26 --------------------------
 migration/savevm.c       |  7 +------
 3 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 4a1955067b..addbc24fcf 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,8 +25,6 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
=20
 /* loadvm */
-int migration_incoming_enable_colo(void);
-void migration_incoming_disable_colo(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/migration.c b/migration/migration.c
index 2506fd63f7..1d347533f9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -378,31 +378,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState *=
mis,
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
=20
-static bool migration_colo_enabled;
-void migration_incoming_disable_colo(void)
-{
-    ram_block_discard_disable(false);
-    migration_colo_enabled =3D false;
-}
-
-int migration_incoming_enable_colo(void)
-{
-#ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but COLO "
-                 "module is not built in");
-    return -ENOTSUP;
-#endif
-
-    if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but c-=
colo "
-                     "capability is not set");
-        return -EINVAL;
-    }
-
-    migration_colo_enabled =3D true;
-    return 0;
-}
-
 void migrate_add_address(SocketAddress *address)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
@@ -480,7 +455,6 @@ static void process_incoming_migration_bh(void *opaque)
             runstate_set(RUN_STATE_PAUSED);
         }
     } else if (migrate_colo()) {
-        migration_incoming_disable_colo();
         vm_start();
     } else {
         runstate_set(global_state_get_runstate());
diff --git a/migration/savevm.c b/migration/savevm.c
index 155abb0fda..3a1de15bd0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2300,11 +2300,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncomi=
ngState *mis,
     return 0;
 }
=20
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
-{
-    return migration_incoming_enable_colo();
-}
-
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -2387,7 +2382,7 @@ static int loadvm_process_command(QEMUFile *f)
         return loadvm_handle_recv_bitmap(mis, len);
=20
     case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis);
+        return 0;
     }
=20
     return 0;
--=20
2.39.2


--Sig_/.9AEkJabhCLPvezCg4a.BK.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO3MACgkQNasLKJxd
slgiTw//dHYPntG+7yZ5O7MUJHKAY2HgO9AOTzAySmfr7l1xGQaFNIBagjCYzI08
c1m7KZXShurqpqxGVUDyClV+K8ZHx9hQa8jjuAAY5lqD76Drww+tnO2daSKJFQhC
xmQjm6HLjjmGLzCZt4ppZN32r8nox2txa5CjGkWAmgCiwHcmNfIsuQsoCtJOh03N
OXXKdsY6eU1crBUFGlnN3NEFWkCHBC4OkJHfMJxPu9iwHTfsGopkE5a7myjkbKou
TOQrRyDVcqDZnbcQUjCScT7o+5Pz7M3p0xOfF0RDMAGWc0ZjfQNzQnz39zyUKHDW
QHDxrNx+Hy/Je87cjSkLKgYjfLJ2dqohI+ehggl6UxrneLRA9S3BvWpBxSyVSEYO
zIvZIQyrxkBJEqZ4QMONgXlIUJS15faos1dBpOsn+nOiYQO5A++6+aR9Ya/iuEGr
IC1cepQxMlyw6379CTixO0pUAZJgcaxsXdU5kwkLVChiOdiXmOy4Uz2wdjlld9yl
ee2+l0BJVFNkdZdGXeFh5arsIiKmyz2jVIFIs5kFPKXoqGTuXnu2a0jrqcjDWDGe
WaCc+0eJNhSGzvqB6Skf+9iMac81pi8cLG97+m2Jm1RKvOC/nWGY1bx3/Sz/4NGc
Kx1BKs+NtGyPAJ4YLhkAIwYxuLrSPiGr1HHOEPrBwTplzz+XIfo=
=GAH4
-----END PGP SIGNATURE-----

--Sig_/.9AEkJabhCLPvezCg4a.BK.--

