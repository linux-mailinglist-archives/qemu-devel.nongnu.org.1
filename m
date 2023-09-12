Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA0479DBD8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBli-0007q7-3Y; Tue, 12 Sep 2023 18:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBle-0007p2-Mr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlc-0003I3-EU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndMphvI1GfCI57YnKOFypaBZKAB21uqUhgqAbjivef0=;
 b=h4R8g0jRbvqcnhYc0VmWbmjMVprFWnUN7qhJgrOB6xYikFhzgxKQoX5sdorvWn6ZFvPwl3
 2JE/+dq/vOzacby9MFklx/fdglCnSCCX5O2CHmSvnkp3WQUSanS2A0Jx8qNmUEm0LApJOf
 +y+GOlN1WF4U09T+cpdA83F1gg+UIDo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-gH0npMlGOj6V6A7Or7katQ-1; Tue, 12 Sep 2023 18:21:54 -0400
X-MC-Unique: gH0npMlGOj6V6A7Or7katQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-770544d0501so132078385a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557314; x=1695162114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndMphvI1GfCI57YnKOFypaBZKAB21uqUhgqAbjivef0=;
 b=JaN8hfr7A4Ef0P2+PqRBQmAjd4ELeApdmtkBNv4aCXsBW27fSk20kHCeIym41vdPVe
 HSIs8LY9jjNvviArijpwwBEUp7I2LpYIWBHCGsAGDUWH4znzHgfVvm4zyCeTvo54sM5c
 0Kk4Y72SnxMXkBbRDw9E1vq3e4y13T9PzyJXRFEqoFnrLmD6lGmzxLADQj8PDB91qdE7
 TyC06Wr74OoUQuJz89Li8sakAUZTB3+bhjXGDM/YIBvAmGNzDpHVD/jText6Nkp/vc3/
 cYvMHghs3tPB9GuTUgT8yAJyBA4pQLSqVbsTbMd15/imHpY4JMFs1pbtQCF6Clu0sGal
 eNXw==
X-Gm-Message-State: AOJu0Ywbxvb8FfvKyZhaf67mONpKTlPQXZYzmvzVrHvQmj1eO3dDpHaA
 OSBMRUkAvOqsL02U29OkqN8vkkaUyapyH2Qhxt6IvD0lsqSXaY78ueysagDECFYh7Xl0yRvRNC/
 Wl8+fKmhQt+8f2ifaVQv2Gn1VZ96YENnGqilTezvVZ2d48EKJZ4lxiUo5cGrBpaKxOXQVuQxz
X-Received: by 2002:a05:620a:4055:b0:770:fad0:146 with SMTP id
 i21-20020a05620a405500b00770fad00146mr844422qko.0.1694557313873; 
 Tue, 12 Sep 2023 15:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfbqggF6DNxq4S86EuZcwq007fVFf3Mi0Iwp5sVd30Xv4zMME0/F0/Qa/O8lCVIDzkxb9ecg==
X-Received: by 2002:a05:620a:4055:b0:770:fad0:146 with SMTP id
 i21-20020a05620a405500b00770fad00146mr844409qko.0.1694557313506; 
 Tue, 12 Sep 2023 15:21:53 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 07/11] migration: Remember num of ramblocks to sync during
 recovery
Date: Tue, 12 Sep 2023 18:21:41 -0400
Message-ID: <20230912222145.731099-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


