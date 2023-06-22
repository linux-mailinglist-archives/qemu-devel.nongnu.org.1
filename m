Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6273A0B9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJEz-0003UO-NM; Thu, 22 Jun 2023 08:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJET-0002yv-VV
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:15 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCJEP-0004pK-RS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687436158; x=1688040958; i=lukasstraub2@web.de;
 bh=LHTPFx26nLfuCo78D/NfUSFHYtAmB2Ipa3ilByNTIqI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=tABNQIRMB7zNJ6FXBBk3LMzfV11QXWy3p98Y/19JRpW/XSzBTpocHr5VnoZ6rZqxsJhtlEd
 n/3fn+6nP8gmKAuPh5o1n1FlEF6fz+FwuXLH/L4EU1+pWflAwajOIzVFXeP8dO0qV5J1zglmm
 ZwGGsLJ4BIzn61p2CSCTJNiEpjdqLmEuhXOgWTjEGG2lmdnYK9f2cz8LBn9gIDUfViVGdXEtc
 Tqlzd1razHU20bN2/m85fVuUkCnyMOrWdeEhfUUlCLTG8GAiiKwhLVE8ZBoVSja3yPFUh8v6q
 +FiPgU7TM8EVyOwzGv6On1Fk+y7YIwgME5gBhDiZB0JkrcvYrnMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([141.58.32.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1qJfbZ1A8h-00GMmM; Thu, 22
 Jun 2023 14:15:58 +0200
Date: Thu, 22 Jun 2023 14:15:55 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: [PATCH 5/8] colo: Don't send ENABLE_COLO command
Message-ID: <c5fc483a73f755e294a869ce9f6850323abeb8a2.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <cover.1687429356.git.lukasstraub2@web.de>
References: <cover.1687429356.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qY1nuiH8lLkXmuuY6=78zTc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:MYV703HeTQioXgtgsJKYkXs2I42pDTlRQ++aQLb+ToeUh8NraYu
 c0fe9SfJ2qfWhuTZLg7+P5ghHxnyRtGU2hUuDhIOZAYTiR9UucPqjMkkJCikimzXPyiw//t
 /X1U6ABA9WcFkN9kvriDJowTQj5Y3v9b9XGksopWVvUvGp610lv4bbwevvGWIrci6ekR5gP
 qQik9oGvpuaZM+xWPr8FQ==
UI-OutboundReport: notjunk:1;M01:P0:C4saCdPCwJE=;UXUowXWHhVTZH3pOmVUMQYD7+Tb
 uk/Z04L6COcG+WYMBuBMfGQ+cNwwNPcwMfpYybxGzmSHqnUqtwLNdHgwMmDqgLo72iUM9hovL
 ZLCIa8f1n4+H+Z4rTfmB7Iv4rpjf/+rPeAfHgKE8vHRPTq5AXfOx7hUzcnOUZZXul4DgUx+ne
 c0NUDPsPDQJ/iOeb16NjKfGenKXOiAuybdrefX5EsRH9MRRSOJagVOohACUTsGdKy4iGoGiYV
 u2yWa3GH3R9MUoQnEdGfAwu4yc74+HTA1J7sSr7rlvWOjISAHapbRIRMubCvXH/pZh/zuUFJ5
 2HZFWSjzJS5eI692Om9nuv3IHg3UdKBaHHQsEjeOD/e4EJYRIw81jVzTjI+RwTcKBT+fGSCpF
 BWozS64Wmxlyzwq1qhbyWvvdHV+qZJBw/avEmRNRzCTQsPlIMS1KkUH1B8gJiKXRf4JU6E5CM
 dEEh/wDM84XkItoMnT8NF3xANhmCWSfiiwBbmH3iGx0jvS7QpGxMLYFETQKOW507B1MklBimE
 OJCpKaX6pLp+zzeiPoS4CRKjGKqg7Cy2D1MlylgSEqAs33HPYlqUPvLfUp/QooVLYNXYj2YMg
 XxNVSKH1DszISSYC5rlfK18+jmTTNxw6UaDlc92ojJaF/MIf4m1+zM+eiamOAI+NunBsvPYXl
 eHW9pbb+sZ10hMFwitTO/KJaEO2mnvd+Bu56+aapSzDPEC+3fY+GNEHZiHIMWX32DkClnDmih
 HlzVhqryEas9id9nvj4slfeOp5fJtIILkKQUKGk8VYj1sSuSX0G/ndGNBh7koJlIKW03qZKKv
 02xGZplik9ttexiNxIFbRLL4ISqAvP4eyjfOM22eK/tS8EWLWy7WpLs+Om3sribRr5Dw4iP2A
 vnPY4dEMOE0cMq5jrjulmwwhAnsReyT8xIHXOYcEhDm6j66oCp/+/HPBucNi07ex2Um1u5VbC
 AXnsby4ALWIAV++DjrSJSuez9kU=
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

--Sig_/qY1nuiH8lLkXmuuY6=78zTc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

We should only migrate to qemu with newer version, and there it's
not needed anymore.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c  | 5 -----
 migration/savevm.c     | 6 ------
 migration/savevm.h     | 1 -
 migration/trace-events | 1 -
 4 files changed, 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1d347533f9..a954ff4f7d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2929,11 +2929,6 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_postcopy_advise(s->to_dst_file);
     }
=20
-    if (migrate_colo()) {
-        /* Notify migration destination that we enable COLO */
-        qemu_savevm_send_colo_enable(s->to_dst_file);
-    }
-
     qemu_savevm_state_setup(s->to_dst_file);
=20
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3a1de15bd0..5986f852b2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1035,12 +1035,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
     qemu_fflush(f);
 }
=20
-void qemu_savevm_send_colo_enable(QEMUFile *f)
-{
-    trace_savevm_send_colo_enable();
-    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
-}
-
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
 {
     uint32_t buf;
diff --git a/migration/savevm.h b/migration/savevm.h
index fb636735f0..cb3318e9e2 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -57,7 +57,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, c=
onst char *name,
                                            uint16_t len,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
-void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
=20
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..bd3ec40e31 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -36,7 +36,6 @@ savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
 savevm_send_postcopy_resume(void) ""
-savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_state_setup(void) ""
 savevm_state_resume_prepare(void) ""
--=20
2.39.2


--Sig_/qY1nuiH8lLkXmuuY6=78zTc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUO3sACgkQNasLKJxd
slgGqBAAsMN3T1WIavZDGk8vbz110k9Fdvmhbq5JIVPS4OzBhW6G2NeTwCe2bfj5
7bt6c0AlF3+s4EnleMG0CV1rdcJbef8fL0ZzITBxfUS6pGrOC+eTMeWFOadxMScO
DJEqGWAZWrHSU/48J9UsrPANI0mR2JOiAR4Jrig+Jh5gSAYs7cCVu0rVomlyTW8w
zeqsVIaZx0F+P7pWpR/qZk7KWCcaw/C9C9JmsAYseUFVFUUBqJA2DuQgBTOltJQU
J8r4WeqP9Xx6xAlh+7Evb0/GGjJvOoXN8jxSxo6amtQQ5pG0s5q1tk8AhH2L289y
k1UZSLZMoAekux86qDb29Nog/WfG2vQBvyxzLGsiShXurC3FdD6kbVHRRyeeBZgF
/epPqL004RdffVT/gzDJ6M5AHElsXFixr/8ks7vJehRZpE59u1Cq4OGTU04UWGsR
VDdOt2+SuVLG5Un1qTd+dSOYb5fzrUFZw8ZsXt2Ijq2BHKFe0JD2HktzA35eB4aR
ss9QUztrYB8qnXB6+hDHntI4P3CAasGtbzc7SBOBdf51Q13dBsOqjbd3Nlioc/Ei
y8c3Ax2dyzgog7kxnIHPrd2E62838PDHKT/iwpJzR+4gAfAzqosSNyEuDhLyWF9Q
1BxKVEUBNiSN/4GkMbVqdhnclKjK97ZJ/x/rboAwfG5hZJgDYw4=
=i5/X
-----END PGP SIGNATURE-----

--Sig_/qY1nuiH8lLkXmuuY6=78zTc--

