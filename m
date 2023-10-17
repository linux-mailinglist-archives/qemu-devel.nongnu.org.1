Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A787CBD83
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfTw-00059J-1F; Tue, 17 Oct 2023 04:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTI-0004lX-Tt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTF-0005Dx-OV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgBXJVG2FXMkoYZfQFS2MXTZrE0PKxCZsr7T55cn8vk=;
 b=JMJNG/764yDJa/ArYlqOahU4VuDPwojjUeQ3WuR+aYJWmbvMw7d3etL/nywCLTdrOpoSQs
 J7+mKOK4swtWvST2OPp4dc9crz/54l2ihs8teZ/M6wEqjFE+n3hES6JVn9tQJ7p21bJWqw
 RS9NKfb66QTV9FaMFurIxradWodwYCQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-3Fs-s7ObOwarpow1agc1hQ-1; Tue, 17 Oct 2023 04:30:29 -0400
X-MC-Unique: 3Fs-s7ObOwarpow1agc1hQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BA802932486;
 Tue, 17 Oct 2023 08:30:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 895241C060AE;
 Tue, 17 Oct 2023 08:30:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 07/38] migration: Add capability parsing to analyze-migration.py
Date: Tue, 17 Oct 2023 10:29:32 +0200
Message-ID: <20231017083003.15951-8-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The script is broken when the configuration/capabilities section is
present. Add support for parsing the capabilities so we can fix it in
the next patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-4-farosas@suse.de>
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
2.41.0


