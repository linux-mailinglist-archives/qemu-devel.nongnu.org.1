Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2950C7BE9FB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvED-0007dy-GC; Mon, 09 Oct 2023 14:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEA-0007dI-Dy
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:38 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvE9-0000m1-0R
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECDCE21889;
 Mon,  9 Oct 2023 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LgUa6vFyc7ocW6ZF4d2p5x14/UNi9yWeqYmjBPM5wE=;
 b=Y7KM7qyStZe1ghc4iT+xKUfpvcVGlmye5wPaTLbOk68AQwlMZX+POC48fy2q1Nke0MH0fE
 HV/XB1R4aH4gdHhfGHyHxDkV5MxWo6CYrQ9S94a5ymtX51na3gw51G1P7X7gGElA+kzEwb
 VWUesn0XJpIr5Qmw/Y0faEMp6Wxanig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LgUa6vFyc7ocW6ZF4d2p5x14/UNi9yWeqYmjBPM5wE=;
 b=YsGb41ostYHzEcU7lWjeZ+GtzWThtnwZ0bJFZ1ylXswaL59ZIKJ+4ATzwucKh1/HyJVSBN
 dmTxHk4jAWb2G+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEDB713586;
 Mon,  9 Oct 2023 18:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wCilIdVJJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 2/6] migration: Fix analyze-migration.py 'configuration'
 parsing
Date: Mon,  9 Oct 2023 15:43:22 -0300
Message-Id: <20231009184326.15777-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The 'configuration' state subsections are currently not being parsed
and the script fails when analyzing an aarch64 stream:

Traceback (most recent call last):
  File "./scripts/analyze-migration.py", line 625, in <module>
    dump.read(dump_memory = args.memory)
  File "./scripts/analyze-migration.py", line 571, in read
    raise Exception("Unknown section type: %d" % section_type)
Exception: Unknown section type: 5

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 082424558b..24687db497 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -261,12 +261,21 @@ def getDict(self):
 
 
 class ConfigurationSection(object):
-    def __init__(self, file):
+    def __init__(self, file, desc):
         self.file = file
+        self.desc = desc
 
     def read(self):
-        name_len = self.file.read32()
-        name = self.file.readstr(len = name_len)
+        if self.desc:
+            version_id = self.desc['version']
+            section = VMSDSection(self.file, version_id, self.desc,
+                                  'configuration')
+            section.read()
+        else:
+            # backward compatibility for older streams that don't have
+            # the configuration section in the json
+            name_len = self.file.read32()
+            name = self.file.readstr(len = name_len)
 
 class VMSDFieldGeneric(object):
     def __init__(self, desc, file):
@@ -532,7 +541,8 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
             if section_type == self.QEMU_VM_EOF:
                 break
             elif section_type == self.QEMU_VM_CONFIGURATION:
-                section = ConfigurationSection(file)
+                config_desc = self.vmsd_desc.get('configuration')
+                section = ConfigurationSection(file, config_desc)
                 section.read()
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
-- 
2.35.3


