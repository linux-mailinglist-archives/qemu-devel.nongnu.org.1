Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A266D9BD301
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 17:59:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MtL-0007mY-Cl; Tue, 05 Nov 2024 11:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8MtI-0007lv-R2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8MtH-0005Rr-A6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730825929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfcMQy9UqXEevUjanhabMm9WwGID4mhs+ajxATJcGU0=;
 b=FVIMYokUqOyl/pcDJwew96p1W1oIJT9xlxN/58stcd4gOUkRRjLcIiczsBgsZ6KY9EYE6Z
 gLefmkmX3ZkjF4eZ4q3psXySwo4ty0OXP4ustDSbApNmi5DcoGuHxKYlqAOJmTAUfqNy2X
 xK5ZiZ4NwREonelNJwbVsx4DV2x/CT8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-iDryoA-APdO9OLf3tFCY0w-1; Tue,
 05 Nov 2024 11:58:48 -0500
X-MC-Unique: iDryoA-APdO9OLf3tFCY0w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3729619560A7; Tue,  5 Nov 2024 16:58:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8D7B3000198; Tue,  5 Nov 2024 16:58:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 1/2] vfio/migration: Add save_{iterate,
 complete_precopy}_start trace events
Date: Tue,  5 Nov 2024 17:58:40 +0100
Message-ID: <20241105165841.3086136-2-clg@redhat.com>
In-Reply-To: <20241105165841.3086136-1-clg@redhat.com>
References: <20241105165841.3086136-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This way both the start and end points of migrating a particular VFIO
device are known.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/hw/vfio/vfio-common.h | 2 ++
 hw/vfio/migration.c           | 9 +++++++++
 hw/vfio/trace-events          | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fed499b199f09bbd8da90e3df7eb6c904c11a466..282eadf4ebf5a27a3f7168868fbc2a20d94252c0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,6 +73,8 @@ typedef struct VFIOMigration {
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
     bool initial_data_sent;
+
+    bool event_save_iterate_started;
 } VFIOMigration;
 
 struct VFIOGroup;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 992dc3b1025729877d9fbe6ce9a4dbaf4dbd8a07..87ddc210578f4ecbaf30fa5d8816ce182cbcbcb0 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -472,6 +472,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         return -ENOMEM;
     }
 
+    migration->event_save_iterate_started = false;
+
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
@@ -602,6 +604,11 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
 
+    if (!migration->event_save_iterate_started) {
+        trace_vfio_save_iterate_start(vbasedev->name);
+        migration->event_save_iterate_started = true;
+    }
+
     data_size = vfio_save_block(f, migration);
     if (data_size < 0) {
         return data_size;
@@ -630,6 +637,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    trace_vfio_save_complete_precopy_start(vbasedev->name);
+
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
                                    VFIO_DEVICE_STATE_STOP, &local_err);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 29789e8d276dcd39270edb3636d7f329452e9186..032a51a10592fdab3dd9b2be6506d034275678e7 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,8 +159,10 @@ vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
+vfio_save_complete_precopy_start(const char *name) " (%s)"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
+vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
-- 
2.47.0


