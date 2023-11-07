Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609C7E3FB2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:08:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlX-0000kU-Ry; Tue, 07 Nov 2023 08:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Ll3-0000Ck-Pl
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:43 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lku-00063f-F0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:41 -0500
Received: (qmail 31538 invoked by uid 484); 7 Nov 2023 13:04:20 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.072201 secs); 07 Nov 2023 13:04:20 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:18 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 20/20] mcdstub: updated MAINTAINERS file and fully
 activated the mcdstub in the meson build system
Date: Tue,  7 Nov 2023 14:03:23 +0100
Message-Id: <20231107130323.4126-21-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

---
 MAINTAINERS            | 11 +++++++++++
 mcdstub/meson.build    | 15 +++++++++++++++
 meson.build            |  1 +
 target/arm/meson.build |  1 +
 4 files changed, 28 insertions(+)
 create mode 100644 mcdstub/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8d6b140f..58decd218c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2908,6 +2908,17 @@ F: tests/tcg/multiarch/gdbstub/
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
 
+MCD stub
+M: Nicolas Eder <nicolas.eder@lauterbach.com>
+R: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: mcdstub/*
+F: include/mcdstub/*
+F: include/qemu/debug.h
+F: debug/debug-common.c
+F: debug/debug-mcd.c
+F: target/arm/mcdstub.c
+
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
diff --git a/mcdstub/meson.build b/mcdstub/meson.build
new file mode 100644
index 0000000000..1f9315f9f5
--- /dev/null
+++ b/mcdstub/meson.build
@@ -0,0 +1,15 @@
+# only system emulation is supported over mcd
+mcd_system_ss = ss.source_set()
+mcd_system_ss.add(files('mcdstub.c', '../debug/debug-mcd.c'))
+mcd_system_ss = mcd_system_ss.apply(config_host, strict: false)
+
+libmcd_system = static_library('mcd_system',
+                                mcd_system_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                build_by_default: have_system)
+
+mcd_system = declare_dependency(link_whole: libmcd_system)
+system_ss.add(mcd_system)
+
+# used for gdb (user/system) and mcd:
+common_ss.add(files('../debug/debug-common.c'))
diff --git a/meson.build b/meson.build
index dcef8b1e79..6dfa49160c 100644
--- a/meson.build
+++ b/meson.build
@@ -3348,6 +3348,7 @@ subdir('crypto')
 subdir('ui')
 subdir('hw')
 subdir('gdbstub')
+subdir('mcdstub')
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 5d04a8e94f..84fedbc6e1 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -3,6 +3,7 @@ arm_ss.add(files(
   'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
+  'mcdstub.c',
   'helper.c',
   'vfp_helper.c',
 ))
-- 
2.34.1


