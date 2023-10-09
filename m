Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2897BE9FA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvEE-0007eW-TV; Mon, 09 Oct 2023 14:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvED-0007eE-N2
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEB-0000mX-WC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AD8C1F38D;
 Mon,  9 Oct 2023 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZN+FF4c5NG4NoNOeWyE7KUNMgxZnITOcEqT6dqvl+U=;
 b=CKRBVFf3dTOOkecKzYa4NlsQij1Pucb2WfJTgBbnue5CO1ygVChY4Y0SRHqRwijI45ApXw
 P9Bkb4B5RLP+xFBun65+FMc/omN53wcqrXJeqJ0Kjr7vixbBi9cfSl/c561v/XiRaSREeg
 JvUhrvlJFpyj1MYASlMiYyzgnspQaeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZN+FF4c5NG4NoNOeWyE7KUNMgxZnITOcEqT6dqvl+U=;
 b=kV9+P41BT1k4v0gDSUC1xBWmkrQLO1qDnpAxRSAvwIh2mpovQi/gEpaFybSQxVk1IAi9tz
 OHf82FdIoxd4ykBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6264913586;
 Mon,  9 Oct 2023 18:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EA5UC9hJJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 3/6] migration: Add capability parsing to
 analyze-migration.py
Date: Mon,  9 Oct 2023 15:43:23 -0300
Message-Id: <20231009184326.15777-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The script is broken when the configuration/capabilities section is
present. Add support for parsing the capabilities so we can fix it in
the next patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 24687db497..c700fed64d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -264,6 +264,24 @@ class ConfigurationSection(object):
     def __init__(self, file, desc):
         self.file = file
         self.desc = desc
+        self.caps = []
+
+    def parse_capabilities(self, vmsd_caps):
+        if not vmsd_caps:
+            return
+
+        ncaps = vmsd_caps.data['caps_count'].data
+        self.caps = vmsd_caps.data['capabilities']
+
+        if type(self.caps) != list:
+            self.caps = [self.caps]
+
+        if len(self.caps) != ncaps:
+            raise Exception("Number of capabilities doesn't match "
+                            "caps_count field")
+
+    def has_capability(self, cap):
+        return any([str(c) == cap for c in self.caps])
 
     def read(self):
         if self.desc:
@@ -271,6 +289,8 @@ def read(self):
             section = VMSDSection(self.file, version_id, self.desc,
                                   'configuration')
             section.read()
+            self.parse_capabilities(
+                section.data.get("configuration/capabilities"))
         else:
             # backward compatibility for older streams that don't have
             # the configuration section in the json
@@ -297,6 +317,23 @@ def read(self):
         self.data = self.file.readvar(size)
         return self.data
 
+class VMSDFieldCap(object):
+    def __init__(self, desc, file):
+        self.file = file
+        self.desc = desc
+        self.data = ""
+
+    def __repr__(self):
+        return self.data
+
+    def __str__(self):
+        return self.data
+
+    def read(self):
+        len = self.file.read8()
+        self.data = self.file.readstr(len)
+
+
 class VMSDFieldInt(VMSDFieldGeneric):
     def __init__(self, desc, file):
         super(VMSDFieldInt, self).__init__(desc, file)
@@ -471,6 +508,7 @@ def getDict(self):
     "unused_buffer" : VMSDFieldGeneric,
     "bitmap" : VMSDFieldGeneric,
     "struct" : VMSDFieldStruct,
+    "capability": VMSDFieldCap,
     "unknown" : VMSDFieldGeneric,
 }
 
-- 
2.35.3


