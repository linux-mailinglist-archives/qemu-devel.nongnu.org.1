Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A177CA4FA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKVi-0001UN-JE; Mon, 16 Oct 2023 06:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVg-0001RY-5L
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVc-0007Rl-1b
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLgoIKGSvRj/MuMbHJyJ96vuuwkZqwzioiIdWY1rNyg=;
 b=MuXgnjyT5n0D/09rcoMguo02ZGsoJS/Sr8DZBuuI/K3+AC1YU1BHcCLoGPRlwy7/+uWMQH
 CeeQAaWLzvUPnrQS8N8hxk7WDa/XtAT/l+IWeGEzbGrehQehmPDwS6mC2amZHyjCQ5/nlG
 Rnj9or5fcbFRlQoH11mIQBFg0zN8fN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-inW0WUK-M2WS13iz6VmMDw-1; Mon, 16 Oct 2023 06:07:30 -0400
X-MC-Unique: inW0WUK-M2WS13iz6VmMDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A9F31029F41;
 Mon, 16 Oct 2023 10:07:30 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D84B463F21;
 Mon, 16 Oct 2023 10:07:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/38] migration: Fix analyze-migration.py 'configuration'
 parsing
Date: Mon, 16 Oct 2023 12:06:34 +0200
Message-ID: <20231016100706.2551-7-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'configuration' state subsections are currently not being parsed
and the script fails when analyzing an aarch64 stream:

Traceback (most recent call last):
  File "./scripts/analyze-migration.py", line 625, in <module>
    dump.read(dump_memory = args.memory)
  File "./scripts/analyze-migration.py", line 571, in read
    raise Exception("Unknown section type: %d" % section_type)
Exception: Unknown section type: 5

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-3-farosas@suse.de>
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
2.41.0


