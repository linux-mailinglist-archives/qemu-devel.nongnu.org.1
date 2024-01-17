Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B618300E6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:00:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0pL-000782-Oe; Wed, 17 Jan 2024 02:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0pK-00077m-EF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0pI-00027V-VT
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705478348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4szyQrnHzrYkL2h4yzGCzHjCPfkkzLtPUyuvC80BU3U=;
 b=EzBInvQyB4b5iL35B472gFP7zZUERgxrMZZTapXqLeqEqzpJSUAZKu43jUWybZ0MaqVQe5
 ZdR9HL4+sDw47GJyPuydkOIdsKw3jxjuWcMqYRgVJpzkEnDeBo4z4KkP6jt+eazduu/j3l
 TWqbWtssuzJzbIf6rqbWazRW8MxpAtY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-C06tPBHFMFiiPwxL3c2vEg-1; Wed,
 17 Jan 2024 02:59:06 -0500
X-MC-Unique: C06tPBHFMFiiPwxL3c2vEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D9C31C060C2;
 Wed, 17 Jan 2024 07:59:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3620C15A0C;
 Wed, 17 Jan 2024 07:59:02 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Julia Suvorova <jusual@redhat.com>
Subject: [PATCH 3/3] analyze-migration.py: Remove trick on parsing ramblocks
Date: Wed, 17 Jan 2024 15:58:48 +0800
Message-ID: <20240117075848.139045-4-peterx@redhat.com>
In-Reply-To: <20240117075848.139045-1-peterx@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

RAM_SAVE_FLAG_MEM_SIZE contains the total length of ramblock idstr to know
whether scanning of ramblocks is complete.  Drop the trick.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/analyze-migration.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index a39dfb8766..8a254a5b6a 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -151,17 +151,12 @@ def read(self):
             addr &= ~(self.TARGET_PAGE_SIZE - 1)
 
             if flags & self.RAM_SAVE_FLAG_MEM_SIZE:
-                while True:
+                total_length = addr
+                while total_length > 0:
                     namelen = self.file.read8()
-                    # We assume that no RAM chunk is big enough to ever
-                    # hit the first byte of the address, so when we see
-                    # a zero here we know it has to be an address, not the
-                    # length of the next block.
-                    if namelen == 0:
-                        self.file.file.seek(-1, 1)
-                        break
                     self.name = self.file.readstr(len = namelen)
                     len = self.file.read64()
+                    total_length -= len
                     self.sizeinfo[self.name] = '0x%016x' % len
                     if self.write_memory:
                         print(self.name)
-- 
2.43.0


