Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D2A67413
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 13:40:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWEU-0002qp-AY; Tue, 18 Mar 2025 08:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWEN-0002gE-Fo
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWEG-0007c8-K2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742301570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPof6sTt4ptR9GIy4E4urQ6PAt+v+dGETnww+PA+Q7c=;
 b=bjkCginmn0dttlrcxmXS56NJ7AvzBBBIXcdcStg8UDWGSGZzLA7+LTjPRQSVBeFE+hLrn8
 DlT57wqRyzQRaUyBTPMemr63x4KH9ieLvEv7prdESzZ22/eg/Wezc3qI9fp6mrpbft73Nr
 LSQ8nPVcT5B4evaeEy766oaK079h8Fg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-BgsRubG-Op6rw14R4nlqdg-1; Tue,
 18 Mar 2025 08:39:27 -0400
X-MC-Unique: BgsRubG-Op6rw14R4nlqdg-1
X-Mimecast-MFC-AGG-ID: BgsRubG-Op6rw14R4nlqdg_1742301566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 827D61801A00; Tue, 18 Mar 2025 12:39:26 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C215180094A; Tue, 18 Mar 2025 12:39:23 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	berrange@redhat.com
Subject: [PATCH v8 6/7] migration: Add save_postcopy_prepare() savevm handler
Date: Tue, 18 Mar 2025 18:08:45 +0530
Message-ID: <20250318123846.1370312-7-ppandit@redhat.com>
In-Reply-To: <20250318123846.1370312-1-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a savevm handler for a module to opt-in sending extra sections right
before postcopy starts, and before VM is stopped.

RAM will start to use this new savevm handler in the next patch to do flush
and sync for multifd pages.

Note that we choose to do it before VM stopped because the current only
potential user is not sensitive to VM status, so doing it before VM is
stopped is preferred to enlarge any postcopy downtime.

It is still a bit unfortunate that we need to introduce such a new savevm
handler just for the only use case, however it's so far the cleanest.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/migration.c        |  4 ++++
 migration/savevm.c           | 33 +++++++++++++++++++++++++++++++++
 migration/savevm.h           |  1 +
 4 files changed, 53 insertions(+)

v8:
- New patch

v7:
- https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t

diff --git a/include/migration/register.h b/include/migration/register.h
index c041ce32f2..b79dc81b8d 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -189,6 +189,21 @@ typedef struct SaveVMHandlers {
 
     /* This runs outside the BQL!  */
 
+    /**
+     * @save_postcopy_prepare
+     *
+     * This hook will be invoked on the source side right before switching
+     * to postcopy (before VM stopped).
+     *
+     * @f:      QEMUFile where to send the data
+     * @opaque: Data pointer passed to register_savevm_live()
+     * @errp:   Error** used to report error message
+     *
+     * Returns: true if succeeded, false if error occured.  When false is
+     * returned, @errp must be set.
+     */
+    bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
+
     /**
      * @state_pending_estimate
      *
diff --git a/migration/migration.c b/migration/migration.c
index f97bb2777f..afb4dda19e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2721,6 +2721,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
+    if (!qemu_savevm_state_postcopy_prepare(ms->to_dst_file, errp)) {
+        return -1;
+    }
+
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..23ef4c7dc9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1523,6 +1523,39 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    bool ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_postcopy_prepare) {
+            continue;
+        }
+
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_PART);
+        ret = se->ops->save_postcopy_prepare(f, se->opaque, errp);
+        save_section_footer(f, se);
+
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+
+        if (!ret) {
+            assert(*errp);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
diff --git a/migration/savevm.h b/migration/savevm.h
index 138c39a7f9..2d5e9c7166 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,6 +45,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.48.1


