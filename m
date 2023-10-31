Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B818B7DCB1C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmFg-0007Kd-A9; Tue, 31 Oct 2023 06:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFe-0007Jy-J2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFc-0000xJ-IT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698749135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RR2f6kNKNB8BsIq7NE6xEzIcdIs8Qp1OPAV4jNj7xfs=;
 b=ahYG81ODHTiCgxLKw6u2dWNhL+cy9rjfHO25cvY8LUNGk6zDRoK66H3qHBFiyhPWfFSc2Q
 ojmWzgIxx2Pnb6BDkaOyuP17ydjvU7avUQn3tIU64Xhni9ZahPk+GeNG1ue5CIsYYxFL8Q
 6zz89B7z5HWavhFsLebbmILyzAHuzP8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-DE_ys_tlO4aDguhJLLB2iQ-1; Tue,
 31 Oct 2023 06:45:33 -0400
X-MC-Unique: DE_ys_tlO4aDguhJLLB2iQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71C8C2812942;
 Tue, 31 Oct 2023 10:45:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FF9F2166B26;
 Tue, 31 Oct 2023 10:45:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33B6F21E6922; Tue, 31 Oct 2023 11:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org
Subject: [PATCH v2 5/5] dump: Drop redundant check for empty dump
Date: Tue, 31 Oct 2023 11:45:31 +0100
Message-ID: <20231031104531.3169721-6-armbru@redhat.com>
In-Reply-To: <20231031104531.3169721-1-armbru@redhat.com>
References: <20231031104531.3169721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 dump/dump.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 66f62d0891..ea15c5d221 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1672,26 +1672,6 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
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
@@ -1839,12 +1819,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
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


