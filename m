Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EC820E99
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3GD-0001IA-8p; Sun, 31 Dec 2023 16:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2ux-00078o-Ql
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:21 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2uw-0007R2-7x
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:19 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78117c8b6ccso718713485a.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056416; x=1704661216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx5Gp3ZN3was01fuqRCdwquRS0vzzG9/+/KGXjA3ANg=;
 b=Psp6gfltC3f9/o1sIpvppqJk4G5xx0xb3vizcJJSv88XT/mPZx/q3PSClIYHadK+/0
 5azQ1XpiR/KJiS59LXxvn73cv0CnWZTSLn3lKby6lKlRnXssmnTw8R7gH0jkMsW/d/Aw
 +Cv8YTddRdlYhH/EzINdLq8Ig2uGeCIIxMZV5SaJXvAnSRjdwCZ402eQ0CsP6BzTBH6B
 UU51EweyLTaMRD8cC1f12r3cHv+HZ5j4AUgdDFLWr1uSI3ZDDDOp+aJw/OXLTvwiuEB9
 /ZWZ+BRqxRukhcrbRJHsEoeFtdiNMjIG1R/EnSuooQ5VHQN8gFCw6I+0RoSyLYwezSwh
 wDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056416; x=1704661216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx5Gp3ZN3was01fuqRCdwquRS0vzzG9/+/KGXjA3ANg=;
 b=DJZ8mnF0cTTn0H3kiHBA3KcE/o9aPu2K7+/1LgDpR0/+GwsF2q0J/43CEodrM2Ysb+
 iXAhpOS2u2qu/o11iNXcVnOXDXXgjWiOUd61uA+R9bRbTmK3601fIac7fm6NVtPB49vw
 bOWFDsm+RAMBzNFLslmbRgaE0NPbfb0TlI0+VlPEyMa9afoijj23fQFlYdXPQ2OIXwpP
 lHV3XQsmZcrcfJIHSwZIGx7QMo9YBpR3/z/C1/uLrmFDJNyGlNcFSr+0PDHvFbTWtGWg
 UvduRj/8z3kNArhAlA0rxDhw8YZY38kAH8p5W/wIUJUMJyJSrEoFq2Wzlqoymfusq+N+
 N9bA==
X-Gm-Message-State: AOJu0YyZXOqH22Dr/eln56l0eRk+DTXxqasl1bzOdV6WvdoxcvQMGQKe
 RfHb0P1Wqr5g3T98p3CJe/V+WIcm2HCwlzmd5m5BzVL93q0=
X-Google-Smtp-Source: AGHT+IEPFrTMQw2PT19k9dSAdDAC0QWydgGqvsidIku3o/85bHMVITuq8E0L+afFfiGyh6nQW6BWPQ==
X-Received: by 2002:a05:620a:838e:b0:781:4233:3808 with SMTP id
 pb14-20020a05620a838e00b0078142333808mr19315741qkn.138.1704056416775; 
 Sun, 31 Dec 2023 13:00:16 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:16 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 5/5] migration: Add integration test for 'qatzip' compression
 method
Date: Sun, 31 Dec 2023 20:58:04 +0000
Message-Id: <20231231205804.2366509-6-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:09 -0500
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

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/meson.build      |  4 ++++
 tests/qtest/migration-test.c | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d0..5931bd6418 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -302,6 +302,10 @@ if gnutls.found()
   endif
 endif
 
+if qatzip.found()
+  migration_files += [qatzip]
+endif
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d520c587f7..f51bc4056f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -35,6 +35,10 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
+#ifdef CONFIG_QATZIP
+#include <qatzip.h>
+#endif /* CONFIG_QATZIP */
+
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
@@ -2572,6 +2576,15 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QATZIP
+static void *
+test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                              QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 static void test_multifd_tcp_none(void)
 {
     MigrateCommon args = {
@@ -2607,6 +2620,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QATZIP
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_GNUTLS
 static void *
 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
@@ -3480,6 +3504,19 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/multifd/tcp/plain/zstd",
                    test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    /*
+     * Use QATzip's qzInit() function as a runtime hardware check.
+     * Ideally there might be a cleaner way to probe for the presence of QAT.
+     */
+    QzSession_T sess;
+    memset(&sess, 0, sizeof(QzSession_T));
+    if (qzInit(&sess, 0) == QZ_OK) {
+        qzClose(&sess);
+        qtest_add_func("/migration/multifd/tcp/plain/qatzip",
+                    test_multifd_tcp_qatzip);
+    }
+#endif
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/multifd/tcp/tls/psk/match",
                    test_multifd_tcp_tls_psk_match);
-- 
2.30.2


