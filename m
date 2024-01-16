Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258682E836
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPZzj-0005fb-ON; Mon, 15 Jan 2024 22:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzg-0005fA-Uk
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzf-0002lS-7A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAZOWz1VDAEpIhk2J3/myKMXglpqBFV6L3QJoHCSdrk=;
 b=Kv9O1YPFzn7AkZ17YvgntJBxjvQ6kqYW52Lq8jkpwIFunjULQCLRLEB3jCVlxI/+G+sttt
 2+aW4BGpXgT/1Vsc4BslrbHdppYiqDubmDfrzTd4IXt2ZXy06fuCa2vjCSfPQ9P4ASVklD
 +74D/wYEEIGlNz0I7sreoFm+b2otoI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-fC1v7L7oMyyedHkMLoWj3w-1; Mon, 15 Jan 2024 22:19:59 -0500
X-MC-Unique: fC1v7L7oMyyedHkMLoWj3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31370102587D;
 Tue, 16 Jan 2024 03:19:59 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC6213C25;
 Tue, 16 Jan 2024 03:19:56 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/20] migration/multifd: Remove MultiFDPages_t::packet_num
Date: Tue, 16 Jan 2024 11:19:29 +0800
Message-ID: <20240116031947.69017-3-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

This was introduced by commit 34c55a94b1 ("migration: Create multipage
support") and never used.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240104142144.9680-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 2 --
 migration/multifd.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..b0ff610c37 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -58,8 +58,6 @@ typedef struct {
     uint32_t num;
     /* number of allocated pages */
     uint32_t allocated;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
     /* offset of each page */
     ram_addr_t *offset;
     RAMBlock *block;
diff --git a/migration/multifd.c b/migration/multifd.c
index 9f353aecfa..3e650f5da0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -250,7 +250,6 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
 {
     pages->num = 0;
     pages->allocated = 0;
-    pages->packet_num = 0;
     pages->block = NULL;
     g_free(pages->offset);
     pages->offset = NULL;
-- 
2.43.0


