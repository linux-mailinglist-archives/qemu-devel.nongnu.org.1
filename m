Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3A7BB6AB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9M-0005AA-9g; Fri, 06 Oct 2023 07:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj91-000536-53
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8u-0000At-06
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIOyFaY/QbKQ6FUrXSBQAI+VMkM1XrPbnGAUCmyopoM=;
 b=DAfQxFDja3gh6mIvIj68b+5/aiCz+1ghOqq8+b70cdvgScIEXxk41woZFC3ZlsoE+smL6N
 FKskLxMgMq2qrf5iuzSToEMhLLFy8c48wU9CrsqcdUxXj7WN5m3P0cAveKQhx9yUeHTpL+
 WJ4BOFiZdhqymo1vCfrWqxELvyuWkL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-1YUzYP4kNvCsMiv_16ESyg-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: 1YUzYP4kNvCsMiv_16ESyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3B25803D6A;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D37F863F46;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8BC021E6892; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 29/32] linux-user/mmap.c: clean up local variable shadowing
Date: Fri,  6 Oct 2023 13:36:54 +0200
Message-ID: <20231006113657.3803180-30-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Laurent Vivier <laurent@vivier.eu>

Fix following warnings:

.../linux-user/mmap.c: In function 'target_mremap':
.../linux-user/mmap.c:913:13: warning: declaration of 'prot' shadows a previous local [-Wshadow=compatible-local]
  913 |         int prot = 0;
      |             ^~~~
../../../Projects/qemu/linux-user/mmap.c:871:9: note: shadowed declaration is here
  871 |     int prot;
      |         ^~~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20230925151029.461358-3-laurent@vivier.eu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8eaf57b208..8ccaab7859 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -910,16 +910,16 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
             }
         }
     } else {
-        int prot = 0;
+        int page_flags = 0;
         if (reserved_va && old_size < new_size) {
             abi_ulong addr;
             for (addr = old_addr + old_size;
                  addr < old_addr + new_size;
                  addr++) {
-                prot |= page_get_flags(addr);
+                page_flags |= page_get_flags(addr);
             }
         }
-        if (prot == 0) {
+        if (page_flags == 0) {
             host_addr = mremap(g2h_untagged(old_addr),
                                old_size, new_size, flags);
 
-- 
2.41.0


