Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0627CE7B2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCDB-0003KT-I5; Wed, 18 Oct 2023 15:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCD8-0003Ju-Vo
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:07 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCD7-00055P-8O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0FDF218E0;
 Wed, 18 Oct 2023 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWvfyNVlzQd5bdqAZJAzom4C9GdQVcpoysZO5J6iKrA=;
 b=SezuT35YbcxSl6kElJTZZxoNwPgMOczy5qgADQCY8Ey8JHczZ+SFLc3HZcEAioL4NBaVuV
 YEnao6M/SReZBI1UP10Y/SNd+dY0pmQ+9Vb5c4gMdJpQIx86hKg29HzgBvkwfdsho6IjHa
 F5B9z3l6zPBh3lQSmye4XlUhOh3mZlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWvfyNVlzQd5bdqAZJAzom4C9GdQVcpoysZO5J6iKrA=;
 b=snOU3iAozGH8rrkhBcKhqiu84ctXTFCzDbPqwpia5r2jcDYxcwFf9k94lH47tL0B1XPRoA
 fTNrdDSdnbsU1wCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4106113780;
 Wed, 18 Oct 2023 19:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uGpwA8ExMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:28:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 06/12] tests/qtest/migration: Introduce
 find_common_machine_version
Date: Wed, 18 Oct 2023 16:27:35 -0300
Message-Id: <20231018192741.25885-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.27
X-Spamd-Result: default: False [-0.27 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.17)[88.88%]
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

When using two different QEMU binaries for migration testing, we'll
need to find what is the machine version that will work with both
binaries. Add a helper for that.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0c185db450..13449c1fe1 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -240,3 +240,29 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     g_assert(qdict_get_bool(rsp_return, "running"));
     qobject_unref(rsp_return);
 }
+
+char *find_common_machine_version(const char *mtype, const char *var1,
+                                  const char *var2)
+{
+    g_autofree char *type1 = qtest_resolve_machine_alias(var1, mtype);
+    g_autofree char *type2 = qtest_resolve_machine_alias(var2, mtype);
+
+    g_assert(type1 && type2);
+
+    if (g_str_equal(type1, type2)) {
+        /* either can be used */
+        return g_strdup(type1);
+    }
+
+    if (qtest_has_machine_with_env(var2, type1)) {
+        return g_strdup(type1);
+    }
+
+    if (qtest_has_machine_with_env(var1, type2)) {
+        return g_strdup(type2);
+    }
+
+    g_test_message("No common machine version for machine type '%s' between "
+                   "binaries %s and %s", mtype, getenv(var1), getenv(var2));
+    g_assert_not_reached();
+}
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4f51d0f8bc..d1c2351d33 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -43,4 +43,6 @@ void wait_for_migration_complete(QTestState *who);
 
 void wait_for_migration_fail(QTestState *from, bool allow_active);
 
+char *find_common_machine_version(const char *mtype, const char *var1,
+                                  const char *var2);
 #endif /* MIGRATION_HELPERS_H */
-- 
2.35.3


