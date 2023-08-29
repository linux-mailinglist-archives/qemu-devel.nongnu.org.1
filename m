Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEF78D06D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mt-0000hZ-Q6; Tue, 29 Aug 2023 19:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U9-0006MF-GV
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U5-0000i2-OT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVwbEdq8b6KesgpVfASU2UdXgKGIo5bfRsC+mh3xplY=;
 b=Hf9yoNj20/weaWPSkrL+GVI3xS4LuZxMj6Uv4ybqb9Hl8WrZgoDhzNyBh7TqYgNmxe9aMI
 LlaFdL9yf9apitvBznk6Tp9M2CDTEDUnwSvDYWaiNm2ClxZuth8wlzxWQvGBd1FVMb9/RZ
 nQ1t5CpWRphhwKxkytQzQSJRiT0RSqg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-scNWx1PiPWKz0LOQFaeUOQ-1; Tue, 29 Aug 2023 17:42:47 -0400
X-MC-Unique: scNWx1PiPWKz0LOQFaeUOQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76f191e26f5so50537685a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345367; x=1693950167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVwbEdq8b6KesgpVfASU2UdXgKGIo5bfRsC+mh3xplY=;
 b=elBX9kp2VTJ40Ol9KUKb9cHMfQ7YODv9MUniCiWShQuCHzdhsEPUoJoRKNyArHJB2c
 /xNNL83DgU/kamXdRI7HDlxFOPoTK4QZ2JK2PgL6EYjrohmhJsDekx8yFGC8CuFtDuwU
 Tie8wIeQ2cX3NrQVyyktLZ5rs6RrK1iHQAe7iWMRN4UYCutr0zfiXyCoMaSQYT1J8xFL
 GlCO3MsAma48OhS3rg+/xJ2hxIplS/1D6b20579QGdY5uHHg83HBOHXBdbflyu4DN8Ix
 U/jYT761LyyH1VO2TSkS/lO34bzYr9mHtSgP4pjR56lpMgyYSdVii9T6nuE0Pf8utWho
 pvHw==
X-Gm-Message-State: AOJu0YwnLQSdJPgM8/3I572ucXMssXeAmHQm5Y9p/3Hv0JbzKCmX1t+f
 TV2/w8ivISZ8jhU4EL9QFDiDZDyEui1uBqXxJauKDCYnLdUFF3iK2X3TH7BqJrdkpnmzwPT2E45
 j9XtbNNGLfFhMzc4uEJQi3a+iX52FVJqzoFP3QQwBri3f4OL/nXbm40/z3QBLFgq48BTHcAaS
X-Received: by 2002:a05:622a:1a20:b0:412:1c5f:4781 with SMTP id
 f32-20020a05622a1a2000b004121c5f4781mr245381qtb.4.1693345366877; 
 Tue, 29 Aug 2023 14:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGhApLw/OiKZI2tSWJGC4HyuIW0836e2eSghK5mQCbJnorE8D+wMv0wvRyevjLGCSgJhT/mg==
X-Received: by 2002:a05:622a:1a20:b0:412:1c5f:4781 with SMTP id
 f32-20020a05622a1a2000b004121c5f4781mr245360qtb.4.1693345366504; 
 Tue, 29 Aug 2023 14:42:46 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 7/9] migration: Remember num of ramblocks to sync during
 recovery
Date: Tue, 29 Aug 2023 17:42:33 -0400
Message-ID: <20230829214235.69309-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

rp_sem will be further reused as a way to kick the main thread, e.g., on
recovery failures.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 814c59c17b..a9541c60b4 100644
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
 
@@ -4135,20 +4143,20 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
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
 
@@ -4175,6 +4183,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
+    RAMState *rs = ram_state;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
@@ -4240,6 +4249,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     /* We'll recalculate migration_dirty_pages in ram_state_resume_prepare(). */
     trace_ram_dirty_bitmap_reload_complete(block->idstr);
 
+    qatomic_dec(&rs->postcopy_bmap_sync_requested);
+
     /*
      * We succeeded to sync bitmap for current ramblock. If this is
      * the last one to sync, we need to notify the main send thread.
-- 
2.41.0


