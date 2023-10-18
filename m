Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A17027CE7B5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCD4-0003JM-GR; Wed, 18 Oct 2023 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCD2-0003Ix-OT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCD1-00054F-9r
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5732218E0;
 Wed, 18 Oct 2023 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWUA6/SAgHRK6GW3QBtM99zEGK18eSzoUskHQUgNgP4=;
 b=JkCApC7pX5sUw1LJ7yBqycEHWYH5s/p/j5v8L4EEVpSEFbYxEWDurz1I4QlAX5J556+IUK
 HhD57Rh9xLql9wKrXnskcwYC/pLwCqVUXpFy1XeqTOvcs0XqncQfxWIA/ylISkqhCQZwVE
 op2fg7iM77V5uSk1iC48Skr00Od3Brc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWUA6/SAgHRK6GW3QBtM99zEGK18eSzoUskHQUgNgP4=;
 b=cDpDY/+9O7hlyDtySLFmlDT+3TIR5xCBT1tUChytimVSKx2Z21vcGNl1OSrt/ARjfSKnK5
 OrW1vAsElkxz2uDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52DFD13780;
 Wed, 18 Oct 2023 19:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QFayB7sxMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:27:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 04/12] tests/qtest: Introduce qtest_has_machine_with_env
Date: Wed, 18 Oct 2023 16:27:33 -0300
Message-Id: <20231018192741.25885-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.03
X-Spamd-Result: default: False [-2.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.93)[99.71%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Add a variant of qtest_has_machine() that receives an environment
variable containing an alternate QEMU binary path.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 +++++++--
 tests/qtest/libqtest.h | 9 +++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 3cc7bf3076..603d900e7d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1565,12 +1565,12 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     }
 }
 
-bool qtest_has_machine(const char *machine)
+bool qtest_has_machine_with_env(const char *var, const char *machine)
 {
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines(NULL);
+    machines = qtest_get_machines(var);
 
     for (i = 0; machines[i].name != NULL; i++) {
         if (g_str_equal(machine, machines[i].name) ||
@@ -1582,6 +1582,11 @@ bool qtest_has_machine(const char *machine)
     return false;
 }
 
+bool qtest_has_machine(const char *machine)
+{
+    return qtest_has_machine_with_env(NULL, machine);
+}
+
 bool qtest_has_device(const char *device)
 {
     static QList *list;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 76fc195f1c..d16deb9891 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -930,6 +930,15 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
  */
 bool qtest_has_machine(const char *machine);
 
+/**
+ * qtest_has_machine_with_env:
+ * @var: Environment variable from where to take the QEMU binary
+ * @machine: The machine to look for
+ *
+ * Returns: true if the machine is available in the specified binary.
+ */
+bool qtest_has_machine_with_env(const char *var, const char *machine);
+
 /**
  * qtest_has_device:
  * @device: The device to look for
-- 
2.35.3


