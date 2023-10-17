Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168D7CBDAD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfTv-00052l-0N; Tue, 17 Oct 2023 04:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfT8-0004hw-G9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfT5-000581-Iq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCa7UV0SBwBCZHaFVezeV/WwGdhZrZhL/rnYvsu7CJQ=;
 b=PmmQIdEXV9czYn7QEpAssET3yoX6tih1iYDiApcUSuphxOkuEvqLwuNXVlmwo/CdDsEylW
 5/8zLpNlkgqkZ0hlmHch8QWAsdFM+twB4DI0LApj0fVPTrF30NKsJz+YCoqZy92ARPGEsn
 Z8kBCwYsNOAcp6RqqfEHRnjfH/v7Pjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-EVLYXZakPvu5H8i2db3yAQ-1; Tue, 17 Oct 2023 04:30:14 -0400
X-MC-Unique: EVLYXZakPvu5H8i2db3yAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012F685A5A8;
 Tue, 17 Oct 2023 08:30:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46C511C060AE;
 Tue, 17 Oct 2023 08:30:11 +0000 (UTC)
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
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/38] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
Date: Tue, 17 Oct 2023 10:29:27 +0200
Message-ID: <20231017083003.15951-3-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011023627.86691-1-philmd@linaro.org>
---
 migration/ram.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2f5ce4d60b..24d91de8b3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4159,7 +4159,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
     QEMUFile *file = s->rp_state.from_dst_file;
-    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
+    g_autofree unsigned long *le_bitmap = NULL;
+    unsigned long nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
     RAMState *rs = ram_state;
@@ -4188,8 +4189,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
         error_report("%s: ramblock '%s' bitmap size mismatch "
                      "(0x%"PRIx64" != 0x%"PRIx64")", __func__,
                      block->idstr, size, local_size);
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
@@ -4200,15 +4200,13 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
         error_report("%s: read bitmap failed for ramblock '%s': %d"
                      " (size 0x%"PRIx64", got: 0x%"PRIx64")",
                      __func__, block->idstr, ret, local_size, size);
-        ret = -EIO;
-        goto out;
+        return -EIO;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
         error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
                      __func__, block->idstr, end_mark);
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     /*
@@ -4240,10 +4238,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
      */
     migration_rp_kick(s);
 
-    ret = 0;
-out:
-    g_free(le_bitmap);
-    return ret;
+    return 0;
 }
 
 static int ram_resume_prepare(MigrationState *s, void *opaque)
-- 
2.41.0


