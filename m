Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4767DF1CA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:55:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW87-0005CF-8r; Thu, 02 Nov 2023 07:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7z-0004bW-Oa
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7w-0006D1-4Q
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHuYA1eEprhWaGTRXzUYI9nnE15YBkEUHUViwNC2wOo=;
 b=WCFfMOT78Ipv61iX57+GbLwNAWzlARrMKgcVcAStuAFelIgHYXdpn4gEUXJf1qGM2kVJQy
 CwlE48CJjdsWUBqAgLG3H0Ikxd+kIXeYfFq8UFl62h2kpoLcAj8yraWcBk8hKaa/w/RnaJ
 QrrpfCvcevRZIJ4H0i3wJwHsfO6aZ0Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-ZIiR_lw6N-K1h5pGklo-_Q-1; Thu,
 02 Nov 2023 07:44:40 -0400
X-MC-Unique: ZIiR_lw6N-K1h5pGklo-_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E73DB2808FCC;
 Thu,  2 Nov 2023 11:44:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CCE2026D6E;
 Thu,  2 Nov 2023 11:44:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 28/40] tests/migration-test: Add a test for postcopy hangs
 during RECOVER
Date: Thu,  2 Nov 2023 12:40:42 +0100
Message-ID: <20231102114054.44360-29-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

To do so, create two paired sockets, but make them not providing real data.
Feed those fake sockets to src/dst QEMUs for recovery to let them go into
RECOVER stage without going out.  Test that we can always kick it out and
recover again with the right ports.

This patch is based on Fabiano's version here:

https://lore.kernel.org/r/877cowmdu0.fsf@suse.de

Signed-off-by: Fabiano Rosas <farosas@suse.de>
[peterx: write commit message, remove case 1, fix bugs, and more]
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231017202633.296756-4-peterx@redhat.com>
---
 tests/qtest/migration-test.c | 110 +++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7ebc23903..047b7194df 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -728,6 +728,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
+    bool postcopy_recovery_test_fail;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1404,6 +1405,80 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
+static void wait_for_postcopy_status(QTestState *one, const char *status)
+{
+    wait_for_migration_status(one, status,
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
+}
+
+#ifndef _WIN32
+static void postcopy_recover_fail(QTestState *from, QTestState *to)
+{
+    int ret, pair1[2], pair2[2];
+    char c;
+
+    /* Create two unrelated socketpairs */
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
+    g_assert_cmpint(ret, ==, 0);
+
+    /*
+     * Give the guests unpaired ends of the sockets, so they'll all blocked
+     * at reading.  This mimics a wrong channel established.
+     */
+    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    /*
+     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
+     * emulate the 1st byte of a real recovery, but stops from there to
+     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
+     * the recover process on dest QEMU (by triggering the G_IO_IN event).
+     *
+     * NOTE: this trick is not needed on src QEMUs, because src doesn't
+     * rely on an pre-existing G_IO_IN event, so it will always trigger the
+     * upcoming recovery anyway even if it can read nothing.
+     */
+#define QEMU_VM_COMMAND              0x08
+    c = QEMU_VM_COMMAND;
+    ret = send(pair2[1], &c, 1, 0);
+    g_assert_cmpint(ret, ==, 1);
+
+    migrate_recover(to, "fd:fd-mig");
+    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+
+    /*
+     * Make sure both QEMU instances will go into RECOVER stage, then test
+     * kicking them out using migrate-pause.
+     */
+    wait_for_postcopy_status(from, "postcopy-recover");
+    wait_for_postcopy_status(to, "postcopy-recover");
+
+    /*
+     * This would be issued by the admin upon noticing the hang, we should
+     * make sure we're able to kick this out.
+     */
+    migrate_pause(from);
+    wait_for_postcopy_status(from, "postcopy-paused");
+
+    /* Do the same test on dest */
+    migrate_pause(to);
+    wait_for_postcopy_status(to, "postcopy-paused");
+
+    close(pair1[0]);
+    close(pair1[1]);
+    close(pair2[0]);
+    close(pair2[1]);
+}
+#endif /* _WIN32 */
+
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -1439,9 +1514,19 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
+    wait_for_postcopy_status(to, "postcopy-paused");
+    wait_for_postcopy_status(from, "postcopy-paused");
+
+#ifndef _WIN32
+    if (args->postcopy_recovery_test_fail) {
+        /*
+         * Test when a wrong socket specified for recover, and then the
+         * ability to kick it out, and continue with a correct socket.
+         */
+        postcopy_recover_fail(from, to);
+        /* continue with a good recovery */
+    }
+#endif /* _WIN32 */
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1455,9 +1540,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
     migrate_qmp(from, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
@@ -1482,6 +1564,17 @@ static void test_postcopy_recovery_compress(void)
     test_postcopy_recovery_common(&args);
 }
 
+#ifndef _WIN32
+static void test_postcopy_recovery_double_fail(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_test_fail = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+#endif /* _WIN32 */
+
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
 {
@@ -3093,6 +3186,11 @@ int main(int argc, char **argv)
             qtest_add_func("/migration/postcopy/recovery/compress/plain",
                            test_postcopy_recovery_compress);
         }
+#ifndef _WIN32
+        qtest_add_func("/migration/postcopy/recovery/double-failures",
+                       test_postcopy_recovery_double_fail);
+#endif /* _WIN32 */
+
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
2.41.0


