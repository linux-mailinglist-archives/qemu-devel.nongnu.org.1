Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F77B9712
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xO-0004Nx-VZ; Wed, 04 Oct 2023 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xK-0004JB-SG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xJ-0003vq-70
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vHYMUUZwdgemINSHDTriLnfve6+5EiI4PRPsUAHgjs=;
 b=d5JmZY0fh+4e3qmlv8UwAFmDUyE0ul1KZe9/mOHGFXtl4hUlMUpUoXZNj6+cYjtwgMidqZ
 9sHgEZ2IWT0GI8WdymniR82ZQpMfO/84PEZCuhmzFk/xfCn0O5cv1WGv7whWJ+ZgyBzbji
 +cQ5BUu+C2/vi/x/hCiCJkgR+oGQBro=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-6cbw9iAlMPOrTgEh6dqYyQ-1; Wed, 04 Oct 2023 18:02:50 -0400
X-MC-Unique: 6cbw9iAlMPOrTgEh6dqYyQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41810d0d8c2so702261cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456969; x=1697061769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vHYMUUZwdgemINSHDTriLnfve6+5EiI4PRPsUAHgjs=;
 b=G+5CERwdxDcgsX471Xmok9dCz/KN9MV3kDlVbfAJvOYHjLqeaHeWcpCDf6VhZYLu8S
 0vUCoExt0VAp4ZdCuCCqxCCYFWUQqfU/O96Ubigr5U/k63SaPEL5uIJ0suBDPQgF8dS8
 ntGjCgdJ4Seh8wCrW9gy9afxAdur/3przZdMw++1onlADJm/LHWEf9NTWwkZ5UNnouC5
 Gn54iTWB2eRWpjr0bAfkhSaXXCYyzMcY0s+whuFvt4KJJBYcbp8+MTv3KMdR11rtCVmz
 /kwikrNoKu4sO9G9LZn5kYYXjyrSgnjXgGYGf4MPmubaszTIbX1mJ0s3wCxOuvTZOUBU
 0NaQ==
X-Gm-Message-State: AOJu0YyJYJCCfEvqhvZdAvBiBGycyPBDn4hX5tART292chHnVkB22i1r
 J0tqDFRm0wP6AX45DDt0iuI9xF8vdsHh/u2LghL23R3ErcMifppAuv7Te0At2zgebvNOK4uKRTo
 wd3U2+nBpaAbfeTBJ2xuXZ5Gu8RuSEIjCKDZnCR04hrEq8dSHiG2ZexOMLNnBYCjQApybdpMG
X-Received: by 2002:a05:6214:e62:b0:65a:fd40:24d8 with SMTP id
 jz2-20020a0562140e6200b0065afd4024d8mr3700408qvb.4.1696456969176; 
 Wed, 04 Oct 2023 15:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE99+TLip7o5d37PG2efjr7xA1ZDJgFnB8zquaxa2TXbLIVNXB/pGS+LLzukN2J3hJQ+jrFtQ==
X-Received: by 2002:a05:6214:e62:b0:65a:fd40:24d8 with SMTP id
 jz2-20020a0562140e6200b0065afd4024d8mr3700378qvb.4.1696456968702; 
 Wed, 04 Oct 2023 15:02:48 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 06/10] migration: Remember num of ramblocks to sync during
 recovery
Date: Wed,  4 Oct 2023 18:02:36 -0400
Message-ID: <20231004220240.167175-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Instead of only relying on the count of rp_sem, make the counter be part of
RAMState so it can be used in both threads to synchronize on the process.

rp_sem will be further reused in follow up patches, as a way to kick the
main thread, e.g., on recovery failures.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c54e071ea3..ef4af3fbce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -394,6 +394,14 @@ struct RAMState {
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(, RAMSrcPageRequest) src_page_requests;
+
+    /*
+     * This is only used when postcopy is in recovery phase, to communicate
+     * between the migration thread and the return path thread on dirty
+     * bitmap synchronizations.  This field is unused in other stages of
+     * RAM migration.
+     */
+    unsigned int postcopy_bmap_sync_requested;
 };
 typedef struct RAMState RAMState;
 
@@ -4121,20 +4129,20 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 {
     RAMBlock *block;
     QEMUFile *file = s->to_dst_file;
-    int ramblock_count = 0;
 
     trace_ram_dirty_bitmap_sync_start();
 
+    qatomic_set(&rs->postcopy_bmap_sync_requested, 0);
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         qemu_savevm_send_recv_bitmap(file, block->idstr);
         trace_ram_dirty_bitmap_request(block->idstr);
-        ramblock_count++;
+        qatomic_inc(&rs->postcopy_bmap_sync_requested);
     }
 
     trace_ram_dirty_bitmap_sync_wait();
 
     /* Wait until all the ramblocks' dirty bitmap synced */
-    while (ramblock_count--) {
+    while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
         qemu_sem_wait(&s->rp_state.rp_sem);
     }
 
@@ -4161,6 +4169,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
+    RAMState *rs = ram_state;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
@@ -4226,6 +4235,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     /* We'll recalculate migration_dirty_pages in ram_state_resume_prepare(). */
     trace_ram_dirty_bitmap_reload_complete(block->idstr);
 
+    qatomic_dec(&rs->postcopy_bmap_sync_requested);
+
     /*
      * We succeeded to sync bitmap for current ramblock. If this is
      * the last one to sync, we need to notify the main send thread.
-- 
2.41.0


