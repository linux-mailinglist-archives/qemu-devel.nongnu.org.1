Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD49BD30B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 18:03:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Mwz-0001ni-Rj; Tue, 05 Nov 2024 12:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8Mww-0001f3-CS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8Mwt-0005si-0j
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730826153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcSD8D0A1jUOrgR7TmdU9oL1/rBS5lIAGlGLO3nzwnc=;
 b=KOBL3agWZuBCnOISfX779uCbzxmmBe+jXftJcNKw+8XiWxQKF7cCCD3ZylK1jMxKKUWDfF
 GF2MhDc1CQ5CWbCDOaEIlT0CGvWLo6z/kCJaoo1nSCDnqU+2GzAIXBlHsx2MOiVP78Ivuu
 RgjQXCSEedShDSnQ9oW9+83sqaKLwAk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-qZJRSIKdOXCMCvc0M_hl3A-1; Tue,
 05 Nov 2024 11:58:49 -0500
X-MC-Unique: qZJRSIKdOXCMCvc0M_hl3A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDA6A1955EE8; Tue,  5 Nov 2024 16:58:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FBC9300018D; Tue,  5 Nov 2024 16:58:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 2/2] vfio/migration: Add vfio_save_block_precopy_empty_hit
 trace event
Date: Tue,  5 Nov 2024 17:58:41 +0100
Message-ID: <20241105165841.3086136-3-clg@redhat.com>
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

This way it is clearly known when there's no more data to send for that
device.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/migration.c           | 8 ++++++++
 hw/vfio/trace-events          | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 282eadf4ebf5a27a3f7168868fbc2a20d94252c0..e0ce6ec3a9b3245e36811a3383f1d642c5536f3d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -75,6 +75,7 @@ typedef struct VFIOMigration {
     bool initial_data_sent;
 
     bool event_save_iterate_started;
+    bool event_precopy_empty_hit;
 } VFIOMigration;
 
 struct VFIOGroup;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 87ddc210578f4ecbaf30fa5d8816ce182cbcbcb0..01aa11013e42b06696e6af28068f8048d5bfe29a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -370,6 +370,10 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
          * please refer to the Linux kernel VFIO uAPI.
          */
         if (errno == ENOMSG) {
+            if (!migration->event_precopy_empty_hit) {
+                trace_vfio_save_block_precopy_empty_hit(migration->vbasedev->name);
+                migration->event_precopy_empty_hit = true;
+            }
             return 0;
         }
 
@@ -379,6 +383,9 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
         return 0;
     }
 
+    /* Non-empty read: re-arm the trace event */
+    migration->event_precopy_empty_hit = false;
+
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
     qemu_put_be64(f, data_size);
     qemu_put_buffer(f, migration->data_buffer, data_size);
@@ -473,6 +480,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     migration->event_save_iterate_started = false;
+    migration->event_precopy_empty_hit = false;
 
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 032a51a10592fdab3dd9b2be6506d034275678e7..cab1cf1de0a2955efbcf4390d6881fa628eb3f14 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -157,6 +157,7 @@ vfio_migration_set_device_state(const char *name, const char *state) " (%s) stat
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
+vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_complete_precopy_start(const char *name) " (%s)"
-- 
2.47.0


