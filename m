Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C17CDE50
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7E0-0003zN-4S; Wed, 18 Oct 2023 10:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DJ-0003iz-Du
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:07:59 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DH-0003dd-CV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:07:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44D9421BB0;
 Wed, 18 Oct 2023 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFxrQB1OKRp0DQowy/J5dUjl98UviTobg7eTqwWWNj4=;
 b=gmOHMhKpyhZ0x57Fjita91QzfUqMj5sq5draFOnweMeyuFUdrsmNofBCM9uUFVcKbh35/M
 5mI4RuMAs8ObZUm/snUApQjBgF0hO73eri9s94DOoIfU/Y9BC5RX/xB2wmK24+8h5nPBbs
 R7Csgth8QaD2M07AdwgAJujVKk+AIZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFxrQB1OKRp0DQowy/J5dUjl98UviTobg7eTqwWWNj4=;
 b=F5U/V1ifih8qnE/bpiqiRjoeq9jkVIX5Bevz29XzJgr2XXaiyhN4yXdsT1I8JgVqMo+/yQ
 eJ1vhga2TgUXUJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF4FF13915;
 Wed, 18 Oct 2023 14:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wCVhIrbmL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:07:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/11] tests/qtest: Introduce qtest_has_machine_with_env
Date: Wed, 18 Oct 2023 11:07:29 -0300
Message-Id: <20231018140736.3618-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.04
X-Spamd-Result: default: False [-2.04 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.94)[99.75%]
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
index c52fab373f..7c5628e0dc 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1553,12 +1553,12 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
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
@@ -1570,6 +1570,11 @@ bool qtest_has_machine(const char *machine)
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


