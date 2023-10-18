Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11D7CDE51
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7DT-0003lD-Ha; Wed, 18 Oct 2023 10:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DL-0003jI-O7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:01 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DJ-0003di-Ct
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:07:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3968F21ACE;
 Wed, 18 Oct 2023 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6CdRQtAeFGTgVBiNhhrW5bvDasjwx+ZXkZUt6fbKrw=;
 b=qRhCsheoxnBdlRakmlaOZX/l8wDwRfX2FPEBn0rocviGBFVu/Wf9ALLP9jzvmLV7wxme5d
 GgkiWIC3N7PbfvbVm6mU3GjFzcgMrMBby1lww0T2VTtM6Hv+akXxtyjkKalUPMYgI6s+Tf
 egdjmyc3w48nM62KJmnE/5cmZOIy0gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6CdRQtAeFGTgVBiNhhrW5bvDasjwx+ZXkZUt6fbKrw=;
 b=pkkJhSpLHBHhJV4J7kNORVllDa0SV1OOWNL5QV/KG2Tg/HtQe/zfaU00XPZ5M8DZx3KEA6
 YmE43eR05fSgPuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE08D13915;
 Wed, 18 Oct 2023 14:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6MoQHrnmL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:07:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/11] tests/qtest: Introduce qtest_resolve_machine_alias
Date: Wed, 18 Oct 2023 11:07:30 -0300
Message-Id: <20231018140736.3618-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The migration tests are being enhanced to test migration between
different QEMU versions. A requirement of migration is that the
machine type between source and destination matches, including the
version.

We cannot hardcode machine types in the tests because those change
with each release. QEMU provides a machine type alias that has a fixed
name, but points to the latest machine type at each release.

Add a helper to resolve the alias into the exact machine
type. E.g. "-machine pc" resolves to "pc-i440fx-8.2"

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 16 ++++++++++++++++
 tests/qtest/libqtest.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7c5628e0dc..fda163836c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1553,6 +1553,22 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     }
 }
 
+char *qtest_resolve_machine_alias(const char *var, const char *alias)
+{
+    struct MachInfo *machines;
+    int i;
+
+    machines = qtest_get_machines(var);
+
+    for (i = 0; machines[i].name != NULL; i++) {
+        if (machines[i].alias && g_str_equal(alias, machines[i].alias)) {
+            return g_strdup(machines[i].name);
+        }
+    }
+
+    return NULL;
+}
+
 bool qtest_has_machine_with_env(const char *var, const char *machine)
 {
     struct MachInfo *machines;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index d16deb9891..6e3d3525bf 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -922,6 +922,16 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
 
+/**
+ * qtest_resolve_machine_alias:
+ * @var: Environment variable from where to take the QEMU binary
+ * @alias: The alias to resolve
+ *
+ * Returns: the machine type corresponding to the alias if any,
+ * otherwise NULL.
+ */
+char *qtest_resolve_machine_alias(const char *var, const char *alias);
+
 /**
  * qtest_has_machine:
  * @machine: The machine to look for
-- 
2.35.3


