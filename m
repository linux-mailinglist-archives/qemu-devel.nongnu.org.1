Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6927739F58
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCILZ-0002uE-Da; Thu, 22 Jun 2023 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCILX-0002ts-Qe
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:19:27 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCILU-0004qN-J6
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687432758; x=1688037558; i=lukasstraub2@web.de;
 bh=74YFrnTHV3m+nHMo2Nn1V2d8fk+1hOwOgOeVWlw3fUE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=eHlTfDcI0dMy6WyijIhy90r9oQ9ZArm58EOr7xaMrNqRA9+irFT8YuidC7Xm7AgpBFUM9Pj
 SdbmIhOiWelxx9Z2tukwndz8zqFw6WCW0tx/w08CgZ8pVHbtB2lFhz00Ev3m0RAPuU2pWFHRS
 x7FskUnxHX+NxDffyawcdBu6FmniZq46tinsRtZOEx2Xm7a3Dm4EkLEcdb6QrFZ5uFrPngSBu
 dSpJ/PsePgyDMnf+M7raFwMF3XRK1KRmEjr59cl7jKvYjXUlBiT0OwcO1vm7ieo00wihfDylR
 jTPceYEcloYOhM2m7/FyLRMgO6mNLHCjF5BY/p7QnJVJlFKlTldg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8ai-1qPa213TOa-00MFjc; Thu, 22
 Jun 2023 13:19:18 +0200
Date: Thu, 22 Jun 2023 13:18:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3] multifd: Add colo support
Message-ID: <20230622131846.1f5fabb1@mobian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dc+pofX.XfCXEgXSv2tLTL7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pbgsSHAf7fk+cMYfKckdZj3w7M2KXEHJuoSj45dg2420DQnE/MH
 n1MHrYluiGwcuho4gY0CPsd9E45Q4qCb9dqqNgw6/2Kmn1LlHf3VvvGjy/9mBdCUUo5MPYv
 GLQQVLgRngSxAr0ul6Nm+5JQmq8ECeFmx7urgiL06SQb67tiMXdNGbcATWKWeInl487R13K
 L4jM7q0X0MHjKW7TH4rGg==
UI-OutboundReport: notjunk:1;M01:P0:tPqkSRylChk=;6DeNtD8jgcvsATkem2QFjLRBagX
 5CZtEO8NJR4f9/1ZRsNHC4jF+JQqS9+++j68hLHGb8O4cixnuEAFqa19dbMQYAr7wsRjywOBN
 haINk0yI1KX9nRRscrgaAsZuZcV1XXkBP8vQ/1Np9pdSkixBo4mq5tq6NF6c86PegiWqyi6Wk
 KyeAwPOMlxW7VR7OG78AEWHFJheGNElcJUoCoGEPqKc9XHy6PciYVrfmqx4mP5jzwpzUgkZ+S
 D/I3gYmiom0Tlqm2MFTvyx/34kFXB1wFBriKcYZTwHrjHk7uWM1kAGk0sOGdldjLio+KfuzSU
 sA1hirQtTpOAiukPCR620hXcXqQdXMv3ejsiZZNoPPonIFxyADFui2W2QFvLi4uEN7URpBpgl
 wPFc+v6yMEsCE4DswOGbxLtvJOx+GB6KyRZ3bPrdSgH9nzE/NOrAeqkAZXpdz8c1iYSQaol7+
 OCGcS0IjN5tjCTLnR/T6X9wdHFF+pWr8uJ4gV6DWvHpvb+fs3uQZECGG+DiKPZ+wsXa1AG6ll
 IgwLF4ha6Is2smlK/Irt+Oa9AKsS2qLKYs1r5cc89iWDJd0O8fxmA0dSY7laHvhX1D5JJWNoB
 x5u6ABQntOyTcpriJ3MpKAMdFsZmZglGARMFamGLErAk6kM1B//CjGfFkFlQJIL33iRwRyai2
 51uMm+Fo/VvZI75AII9Uoxh1SdELikfyQWba+PCydk+wjjhp56ejVkqnBrSzVkYKcrH6T0Byr
 CqbZHgBgKC0xmtvFCVVlwBe49oN8E8TmqU5B/8/vFMu0w0XVHcPizS54gwcKvJMiCZBuQO0JR
 6sv/mPrKUzYtMxjqAX1kHOXwK+zNks8ZchR9pkmqliVK/Qz5UnL1ZmJzv/Np3OuDvOcPSe5Qa
 NZ5je4SH0dUTrswmilV+EKZXUpdblH14JcZ2+ld8FWY6fZgwUmchcKBNU7kqfo0BNBUf8Eajl
 HgfgHw==
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

--Sig_/dc+pofX.XfCXEgXSv2tLTL7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Like in the normal ram_load() path, put the received pages into the
colo cache and mark the pages in the bitmap so that they will be
flushed to the guest later.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/meson.build    |  1 +
 migration/multifd-colo.c | 53 ++++++++++++++++++++++++++++++++++++++++
 migration/multifd-colo.h | 24 ++++++++++++++++++
 migration/multifd.c      |  5 ++++
 4 files changed, 83 insertions(+)
 create mode 100644 migration/multifd-colo.c
 create mode 100644 migration/multifd-colo.h

diff --git a/migration/meson.build b/migration/meson.build
index 1ae28523a1..063e0e0a8c 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -21,6 +21,7 @@ system_ss.add(files(
   'migration.c',
   'multifd.c',
   'multifd-zlib.c',
+  'multifd-colo.c',
   'ram-compress.c',
   'options.c',
   'postcopy-ram.c',
diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
new file mode 100644
index 0000000000..4872dc6d01
--- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,53 @@
+/*
+ * multifd colo implementation
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/target_page.h"
+#include "exec/ramblock.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "ram.h"
+#include "multifd.h"
+#include "options.h"
+#include "io/channel-socket.h"
+#include "migration/colo.h"
+#include "multifd-colo.h"
+
+void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p)
+{
+    if (!migrate_colo())
+        return;
+
+    assert(p->block->colo_cache);
+
+    /*
+     * While we're still in precopy state (not yet in colo state), we copy
+     * received pages to both guest and cache. No need to set dirty bits,
+     * since guest and cache memory are in sync.
+     */
+    if (migration_incoming_in_colo_state()) {
+        colo_record_bitmap(p->block, p->normal, p->normal_num);
+    }
+    p->host =3D p->block->colo_cache;
+}
+
+void multifd_colo_process_recv_pages(MultiFDRecvParams *p)
+{
+    if (!migrate_colo())
+        return;
+
+    if (!migration_incoming_in_colo_state()) {
+        for (int i =3D 0; i < p->normal_num; i++) {
+            void *guest =3D p->block->host + p->normal[i];
+            void *cache =3D p->host + p->normal[i];
+            memcpy(guest, cache, p->page_size);
+        }
+    }
+    p->host =3D p->block->host;
+}
diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
new file mode 100644
index 0000000000..58920a0583
--- /dev/null
+++ b/migration/multifd-colo.h
@@ -0,0 +1,24 @@
+/*
+ * multifd colo header
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
+#define QEMU_MIGRATION_MULTIFD_COLO_H
+
+#ifdef CONFIG_REPLICATION
+
+void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p);
+void multifd_colo_process_recv_pages(MultiFDRecvParams *p);
+
+#else
+
+static inline void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p) {}
+static inline void multifd_colo_process_recv_pages(MultiFDRecvParams *p) {}
+
+#endif
+#endif
diff --git a/migration/multifd.c b/migration/multifd.c
index 3387d8277f..6b031c1fd2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -25,6 +25,7 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
@@ -1134,10 +1135,14 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
=20
         if (p->normal_num) {
+            multifd_colo_prepare_recv_pages(p);
+
             ret =3D multifd_recv_state->ops->recv_pages(p, &local_err);
             if (ret !=3D 0) {
                 break;
             }
+
+            multifd_colo_process_recv_pages(p);
         }
=20
         if (flags & MULTIFD_FLAG_SYNC) {
--=20
2.39.2

--Sig_/dc+pofX.XfCXEgXSv2tLTL7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSULhYACgkQNasLKJxd
sli42g//clgCT+JjG3VLZmWHSc7dSVUFfIGK6jTsuNeWD8/Aaag4peiFi570yez1
f6h180RNJbpXCrD7TpT5TBsooT99RiclEQsEfjGb/ZIhn5r3zeha2c7qrnBstX3/
mjlCwKSBTawE0G7mbPkhEiWaX8ojQrAtMkKmELt2vsLj7lDi/TYSKx99y1A5OICH
H5HCL/RjMGppmqWpthf57xFHNHgJADDoR+OFlgKqBdVhG42j1CQlsFvznoeZ+GBH
9I7bIgk+vZ3hH+7mq74mO3OP286vsQ5g5SHZTmUqjcDg6G3XGMVRiH826QKXWEbi
msTQvXJOfpjs3bYz9GA0Qug7EnDAQsHM+GiS2ef5Jp7hXFh4vhlDz4NdLPMdY6EU
NclkgJWe2FEsixNuRclRts55ID7tak30Lu3gSZB4JVn7ebDE7u9UyRSEsX5J8qXB
H81j32j0wFaBRb/oTDLJdzZ4FbPfJxN0h4Sbh7C1q7oPxsKr5XpLMuZCKF9xhMDq
EQ7xq2PjzBPu6ygzG0/GzXGC9Q7xX5krg60joqs2UPEEKMcPLncCjC9yXIDRTe9s
/AYCM5YbHBljB1Hhch9kaZHwa+ECH8Fy1A8Y8fQwn8t+5n4oTWvLQ7FeTLvZVpAW
UKmKA62Pjym7phLzx1PTGV49hPxYY5Y5WoNE/9m3yImC/WtnaEI=
=fWLq
-----END PGP SIGNATURE-----

--Sig_/dc+pofX.XfCXEgXSv2tLTL7--

