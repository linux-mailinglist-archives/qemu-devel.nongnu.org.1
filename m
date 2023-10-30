Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1D7DBAFF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:39:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSSN-0003av-3g; Mon, 30 Oct 2023 09:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSI-0003ZS-GL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSF-0005pW-M0
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698673036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/VC6LFBhHfm5THr4OjgMFRd03zwzqEsi7Och3+eKuU=;
 b=Znoe/Xc2HZqI0DoFweitS9f1x8y7OT4O7zb4DZv84EQhzRZ10pNkGtUEEd9IqIsxuKoBb3
 VBeabmRcMO8kqhJyiABAfKbuQQIWwxNiWYSXV5aqOCqm9DIlepgxvV2E3M3YYFQMOfhgy7
 bPE4+XDQ0ikxkGUjoCTcT1yxEZUTRr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-DEYcwUYdPY-pJbWQRI6dCg-1; Mon, 30 Oct 2023 09:37:15 -0400
X-MC-Unique: DEYcwUYdPY-pJbWQRI6dCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D273811E82
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F022E1C060AE
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1B7921E6921; Mon, 30 Oct 2023 14:37:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH 5/5] dump: Drop redundant check for empty dump
Date: Mon, 30 Oct 2023 14:37:12 +0100
Message-ID: <20231030133712.2822276-6-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-1-armbru@redhat.com>
References: <20231030133712.2822276-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

dump_init() first computes the size of the dump, taking the filter
area into account, and fails if its zero.  It then looks for memory in
the filter area, and fails if there is none.

This is redundant: if the size of the dump is zero, there is no
memory, and vice versa.  Delete this check.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d888e4bd3c..03627a4c17 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1674,26 +1674,6 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
     }
 }
 
-static int validate_start_block(DumpState *s)
-{
-    GuestPhysBlock *block;
-
-    if (!dump_has_filter(s)) {
-        return 0;
-    }
-
-    QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
-        /* This block is out of the range */
-        if (block->target_start >= s->filter_area_begin + s->filter_area_length ||
-            block->target_end <= s->filter_area_begin) {
-            continue;
-        }
-        return 0;
-   }
-
-    return -1;
-}
-
 static void get_max_mapnr(DumpState *s)
 {
     GuestPhysBlock *last_block;
@@ -1842,12 +1822,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         goto cleanup;
     }
 
-    /* Is the filter filtering everything? */
-    if (validate_start_block(s) == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "begin");
-        goto cleanup;
-    }
-
     /* get dump info: endian, class and architecture.
      * If the target architecture is not supported, cpu_get_dump_info() will
      * return -1.
-- 
2.41.0


