Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0686D745F07
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKpj-0003EO-Vc; Mon, 03 Jul 2023 10:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpb-000387-4b
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:12 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpY-0007Dm-VI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABC8B21A44;
 Mon,  3 Jul 2023 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688395627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFnlVPKGcsaYlD+CasZxuR7XddMqs6Qfy/HGR6C0GS4=;
 b=0j6s3VMtfmVMmynaToR7LZfU9izfHSRRScNq5FMdVFYmoMJVRKLp9aHqTs34jV+e374GJV
 y+twJ4Zc5kYsLkRztTO3fy613ve3gjwJof57P6PlLLjIiVKhKPsBFngCCIenRWC2G1EDeJ
 f/e5Ei1UGyDK/xqmyx/u56kiBezR/ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688395627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFnlVPKGcsaYlD+CasZxuR7XddMqs6Qfy/HGR6C0GS4=;
 b=Jk8nJqnKG1ULciFFMnrAKZXfblD7prN/cYQrlygSZtLRxwJkC7289iqdBEngBWa/a9GDAu
 royrIDcI46QB8fCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89F111358E;
 Mon,  3 Jul 2023 14:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mFwjFWnfomRoSAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 03 Jul 2023 14:47:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 1/2] tests/qtest: Add a script to gather migration tests
 list
Date: Mon,  3 Jul 2023 11:46:59 -0300
Message-Id: <20230703144700.13536-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703144700.13536-1-farosas@suse.de>
References: <20230703144700.13536-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

This is a workaround for limitations with meson.

We'd like to have each migration (sub)test registered with meson's
test() function, but since they are all inside the single
migration-test.c there's no way for meson to see the tests. We need an
external way to generate the list of tests and pass it to meson.

We cannot call 'migration-test -l' because we'd need to build the
migration-test binary first and while that is possible, there's no
subsequent way to get the generated list into a meson variable for
consumption. None of meson's routines support retrieving an arbitrary
list of strings from a command at build (vs. configure) time.

We also cannot use generators to have 'migration-test' write to a file
because that would happen at build time and meson does not support
reading from a file in the build directory.

So the only approach left is to either have the list of tests
committed into the source code or to grep the source code for the
list. Committing the file would be harder to maintain and the test
registration in migration-test.c is pretty static, so this patch uses
the grep approach. But using python because it is more portable.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/gen_migration_tests_list.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tests/qtest/gen_migration_tests_list.py

diff --git a/tests/qtest/gen_migration_tests_list.py b/tests/qtest/gen_migration_tests_list.py
new file mode 100644
index 0000000000..5127f976fa
--- /dev/null
+++ b/tests/qtest/gen_migration_tests_list.py
@@ -0,0 +1,12 @@
+#!/usr/bin/env python3
+
+import re
+import sys
+
+file_path = sys.argv[1]
+
+with open(file_path, 'r') as f:
+    for line in f.readlines():
+        match = re.search('\"(/migration/.*)\"', line)
+        if match:
+            print(match.groups()[0])
-- 
2.35.3


