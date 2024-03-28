Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2515880B72
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 07:51:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmplb-00025h-7c; Wed, 20 Mar 2024 02:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplZ-00025A-1C
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplX-0001QS-Jl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5kYKNHQKi1gk6f/JikJQ1jsOlTCVUQDBhJjU7DU+9A=;
 b=CsISVhbn24gnTAXhSLUNR9fOS0GUUwKlAUei1SNYq1U35+RCT8JaWQm9+3uxMc9g+thXOO
 G39sRYi8vDz917D1/oG569mxNbJFvNgXb8RnyDjAfC9Bhp7xTkrLi0//kGn3caDuaA7PQn
 ttHIO67HDFVa2sNh7Jz5iaAUhuvs9nY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-o-Ww6NikOkGr_Qgj9J6Xzw-1; Wed, 20 Mar 2024 02:49:31 -0400
X-MC-Unique: o-Ww6NikOkGr_Qgj9J6Xzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 190BA8007A4;
 Wed, 20 Mar 2024 06:49:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFDFF1C060A4;
 Wed, 20 Mar 2024 06:49:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH for-9.1 v5 02/14] vfio: Always report an error in
 vfio_save_setup()
Date: Wed, 20 Mar 2024 07:48:58 +0100
Message-ID: <20240320064911.545001-3-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
vfio_save_setup() always sets a new error.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1149c6b3740f7f7bb8febdedf435be1adb223e59..bf5a29ddc15b0dbc7ae9c44f289539dd0cdddb0d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -381,6 +381,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
+    int ret;
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
@@ -395,13 +396,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
     }
 
     if (vfio_precopy_supported(vbasedev)) {
-        int ret;
-
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
                                            VFIO_DEVICE_STATE_RUNNING);
             if (ret) {
+                error_report("%s: Failed to set new PRE_COPY state",
+                             vbasedev->name);
                 return ret;
             }
 
@@ -412,6 +413,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             /* vfio_save_complete_precopy() will go to STOP_COPY */
             break;
         default:
+            error_report("%s: Invalid device state %d", vbasedev->name,
+                         migration->device_state);
             return -EINVAL;
         }
     }
@@ -420,7 +423,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
-    return qemu_file_get_error(f);
+    ret = qemu_file_get_error(f);
+    if (ret < 0) {
+        error_report("%s: save setup failed : %s", vbasedev->name,
+                     strerror(-ret));
+    }
+
+    return ret;
 }
 
 static void vfio_save_cleanup(void *opaque)
-- 
2.44.0


