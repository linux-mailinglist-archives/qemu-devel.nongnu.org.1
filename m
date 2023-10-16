Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B37CA4D4
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKVx-0001eb-8n; Mon, 16 Oct 2023 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVs-0001ds-Ug
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVr-0007Ts-0r
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVifpv6vpiKAT8xGag4okIRbDEc0g0Y0L8lhvY/N+k4=;
 b=P91ktlr4E937lpG4jKVcy9SdawcDZe/g+HmZlN2loNBbHuXH4DkOCE+BbOd59BSc4wLCS5
 ORuRGOCulIp0so65OVGmE89LU7xnxCdhovBXzAEddm635joXvkNKiy39lcochCnjkd1rD1
 m/qB7B0xRA7M9PBAyVMdzf7NWzNY958=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-HIbz3CGyODSQQk7yOurnfA-1; Mon, 16 Oct 2023 06:07:36 -0400
X-MC-Unique: HIbz3CGyODSQQk7yOurnfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DE18800969;
 Mon, 16 Oct 2023 10:07:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9CF63F21;
 Mon, 16 Oct 2023 10:07:33 +0000 (UTC)
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
Subject: [PULL 08/38] migration: Fix analyze-migration.py when ignore-shared
 is used
Date: Mon, 16 Oct 2023 12:06:36 +0200
Message-ID: <20231016100706.2551-9-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The script is currently broken when the x-ignore-shared capability is
used:

Traceback (most recent call last):
  File "./scripts/analyze-migration.py", line 656, in <module>
    dump.read(dump_memory = args.memory)
  File "./scripts/analyze-migration.py", line 593, in read
    section.read()
  File "./scripts/analyze-migration.py", line 163, in read
    self.name = self.file.readstr(len = namelen)
  File "./scripts/analyze-migration.py", line 53, in readstr
    return self.readvar(len).decode('utf-8')
UnicodeDecodeError: 'utf-8' codec can't decode byte 0x82 in position 55: invalid start byte

We're currently adding data to the middle of the ram section depending
on the presence of the capability. As a consequence, any code loading
the ram section needs to know about capabilities so it can interpret
the stream.

Skip the byte that's added when x-ignore-shared is used to fix the
script.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-5-farosas@suse.de>
---
 scripts/analyze-migration.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index c700fed64d..56ab04dd2d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -123,6 +123,7 @@ def __init__(self, file, version_id, ramargs, section_key):
         self.TARGET_PAGE_SIZE = ramargs['page_size']
         self.dump_memory = ramargs['dump_memory']
         self.write_memory = ramargs['write_memory']
+        self.ignore_shared = ramargs['ignore_shared']
         self.sizeinfo = collections.OrderedDict()
         self.data = collections.OrderedDict()
         self.data['section sizes'] = self.sizeinfo
@@ -169,6 +170,8 @@ def read(self):
                         f.truncate(0)
                         f.truncate(len)
                         self.files[self.name] = f
+                    if self.ignore_shared:
+                        mr_addr = self.file.read64()
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
             if flags & self.RAM_SAVE_FLAG_COMPRESS:
@@ -572,6 +575,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
         ramargs['page_size'] = self.vmsd_desc['page_size']
         ramargs['dump_memory'] = dump_memory
         ramargs['write_memory'] = write_memory
+        ramargs['ignore_shared'] = False
         self.section_classes[('ram',0)][1] = ramargs
 
         while True:
@@ -582,6 +586,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
                 config_desc = self.vmsd_desc.get('configuration')
                 section = ConfigurationSection(file, config_desc)
                 section.read()
+                ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
                 name = file.readstr()
-- 
2.41.0


