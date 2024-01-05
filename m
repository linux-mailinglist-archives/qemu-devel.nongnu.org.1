Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381AE8259A9
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:05:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoZ5-0006PL-8H; Fri, 05 Jan 2024 13:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ3-0006Ox-1N
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ1-00016M-BA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 059D6220B3;
 Fri,  5 Jan 2024 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=630TBmlQNvcwX+ZgdkgR0QR0/uTN4yJgX1lkZ0e3b70=;
 b=NOvpYhZND2mn5xA7Lo+vuPeT8IfABtKpFwwWILI7Q8bHEgbmigLuVz5/gcK6lJxvUyMW45
 2URZEUIyd7/LoyuI5Y3FQhshrWCB0S323aWtQ4hPOfCJ/iDsq1rmsyRw67yEdTpjFVZDSQ
 /i2bvUv4C6KeQZv0TMi4vdqP8sXC1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=630TBmlQNvcwX+ZgdkgR0QR0/uTN4yJgX1lkZ0e3b70=;
 b=MtmupeZwmGkwH4TQutISQin+dpaUUzpyKNFZMK7uzZaRbvZLVE1P+v5tN31cFY1Bh0NEuQ
 M7NdVtlZGLu1poAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=630TBmlQNvcwX+ZgdkgR0QR0/uTN4yJgX1lkZ0e3b70=;
 b=NOvpYhZND2mn5xA7Lo+vuPeT8IfABtKpFwwWILI7Q8bHEgbmigLuVz5/gcK6lJxvUyMW45
 2URZEUIyd7/LoyuI5Y3FQhshrWCB0S323aWtQ4hPOfCJ/iDsq1rmsyRw67yEdTpjFVZDSQ
 /i2bvUv4C6KeQZv0TMi4vdqP8sXC1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=630TBmlQNvcwX+ZgdkgR0QR0/uTN4yJgX1lkZ0e3b70=;
 b=MtmupeZwmGkwH4TQutISQin+dpaUUzpyKNFZMK7uzZaRbvZLVE1P+v5tN31cFY1Bh0NEuQ
 M7NdVtlZGLu1poAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D9A137E8;
 Fri,  5 Jan 2024 18:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CJiTK8ZEmGXFWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jan 2024 18:04:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 1/4] tests/qtest: Add a helper to query the QEMU version
Date: Fri,  5 Jan 2024 15:04:46 -0300
Message-Id: <20240105180449.11562-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240105180449.11562-1-farosas@suse.de>
References: <20240105180449.11562-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 2.37
X-Spamd-Result: default: False [2.37 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-1.33)[90.31%]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h | 10 ++++++++++
 tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6e3d3525bf..5ec758242b 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1085,4 +1085,14 @@ bool have_qemu_img(void);
  */
 bool mkimg(const char *file, const char *fmt, unsigned size_mb);
 
+/**
+ * qtest_query_version:
+ * @qts: QTestState instance to operate on
+ * @major: Pointer to where to store the major version number
+ * @minor: Pointer to where to store the minor version number
+ * @micro: Pointer to where to store the micro version number
+ *
+ */
+void qtest_query_version(QTestState *qts, int *major, int *minor, int *micro);
+
 #endif
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f33a210861..af779a3248 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -337,6 +337,30 @@ void qtest_remove_abrt_handler(void *data)
     }
 }
 
+void qtest_query_version(QTestState *qts, int *major, int *minor, int *micro)
+{
+    QDict *rsp, *version;
+
+    rsp = qtest_qmp_assert_success_ref(qts, "{ 'execute': 'query-version' }");
+    g_assert(rsp);
+
+    version = qdict_get_qdict(rsp, "qemu");
+
+    if (major) {
+        *major = qdict_get_int(version, "major");
+    }
+
+    if (minor) {
+        *minor = qdict_get_int(version, "minor");
+    }
+
+    if (micro) {
+        *micro = qdict_get_int(version, "micro");
+    }
+
+    qobject_unref(rsp);
+}
+
 static const char *qtest_qemu_binary(const char *var)
 {
     const char *qemu_bin;
-- 
2.35.3


