Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A983C7CA50F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:15:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKWA-0001ul-HB; Mon, 16 Oct 2023 06:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVv-0001eT-6k
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVs-0007U3-Lp
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQrJJj8cnkwI58f6W+s3WKgHXwW2iUFFtgjvNeZ6coM=;
 b=HbsnLdqfnRMYOKLPe4qrOS3T2Iz2GgLrh+xc5A37rJqyi+OSuMeld5fAOyxylfy5eZJSdx
 2te8/fdzqR8clz83YOHU1A4u2ERwwGVpl82m/z9xg3+IfKqjGtuPp7QrWR2T+iCtS/1Ffs
 gLpReeLwKqmtG6APE6ALIM850EJYN+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-WsV-JspzPU29Y3_9zeqFiQ-1; Mon, 16 Oct 2023 06:07:39 -0400
X-MC-Unique: WsV-JspzPU29Y3_9zeqFiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFBE229ABA24;
 Mon, 16 Oct 2023 10:07:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DEB263F21;
 Mon, 16 Oct 2023 10:07:36 +0000 (UTC)
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
Subject: [PULL 09/38] migration: Fix analyze-migration read operation
 signedness
Date: Mon, 16 Oct 2023 12:06:37 +0200
Message-ID: <20231016100706.2551-10-quintela@redhat.com>
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

The migration code uses unsigned values for 16, 32 and 64-bit
operations. Fix the script to do the same.

This was causing an issue when parsing the migration stream generated
on the ppc64 target because one of instance_ids was larger than the
32bit signed maximum:

Traceback (most recent call last):
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 658, in <module>
    dump.read(dump_memory = args.memory)
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 592, in read
    classdesc = self.section_classes[section_key]
KeyError: ('spapr_iommu', -2147483648)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-6-farosas@suse.de>
---
 scripts/analyze-migration.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 56ab04dd2d..de506cb8bf 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -38,13 +38,13 @@ def __init__(self, filename):
         self.file = open(self.filename, "rb")
 
     def read64(self):
-        return int.from_bytes(self.file.read(8), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(8), byteorder='big', signed=False)
 
     def read32(self):
-        return int.from_bytes(self.file.read(4), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(4), byteorder='big', signed=False)
 
     def read16(self):
-        return int.from_bytes(self.file.read(2), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(2), byteorder='big', signed=False)
 
     def read8(self):
         return int.from_bytes(self.file.read(1), byteorder='big', signed=True)
-- 
2.41.0


