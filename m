Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449F7D56B6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJW1-0001sI-LM; Tue, 24 Oct 2023 11:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJVz-0001rp-MH
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJVu-0007SI-76
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698162012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dgs3BT9IGQAks27vdQ6lKUM31hGau5if+PgzRKs3KBM=;
 b=E/V8cm9n/oUPShq8NyvX96vkZab0+kc6fKX19L6OLCWJDEcv38cbt2qjXZUmKVGY8QTzxQ
 MyKo9nGP6nxw8CDUDFu/TarF6nF1mSAIVtCe/REEKvB8glweK/UHtcBiksha9GSLWAOFfC
 elmTQogKw3glsl8t1gV8tbU37PDK6M4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-XekE_C1DM-a-EbzjSgGiVA-1; Tue, 24 Oct 2023 11:40:11 -0400
X-MC-Unique: XekE_C1DM-a-EbzjSgGiVA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-581e7b0aa29so1317260eaf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698162010; x=1698766810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dgs3BT9IGQAks27vdQ6lKUM31hGau5if+PgzRKs3KBM=;
 b=jfJDMzwK6NW5Yv8P6BOGM1Rorip3VIlJE1hObEYMJu62EoXxrB9kqee5iykVPIpsmW
 mDmLlzbI2AhdY88huaAFrC7fec9gziLrKH0Mw2WM3owDDVE12hA4D8xaCKlQZYmddjkI
 tiDyxSM+g9nj2+7i1dG2KG0s0Hwx3lSDoUVOLtFWknU2bMrxz2JkSCKiX67SCwM1XyS7
 Uvpinmq4o6irysQUrN/3c70zimV49OWfa51FwjRYQA0Dnv6w6a7JBuMM2Ew0rFCZxj0M
 6upADHpbqXvgibX4cmdw0tDXSSTwg/JG1cS7F9o4C2Odlik91wBl/c52ZFxAT2ct0L60
 5v3g==
X-Gm-Message-State: AOJu0YwREC9/CbhV7ftlXHcT5tIOBhF10Nkk2rIRKMaFUR+cyuPo27jM
 3lqjpe0wdaVTlCcYeGq8IpvdOG+/9B80oKjyBE+7swzv39/uP8H+R60YHtJ7IQZlIsa/4Ne65tk
 TbdgNGMnjPGCDG1W2NzXFrW4yegpceL7QG+h/ckWrS8UoY8Tvl6RjwcveR1NG5EQzoNCSgwAq
X-Received: by 2002:a4a:b985:0:b0:586:7095:126d with SMTP id
 e5-20020a4ab985000000b005867095126dmr2448896oop.0.1698162010374; 
 Tue, 24 Oct 2023 08:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHwRLQnZ9xXi0oYG6sJiZOC7o2CX0Lf9vMIhdpCwyT/jq6h35UBeJBZagQpDkJYYCfhf6Nqg==
X-Received: by 2002:a4a:b985:0:b0:586:7095:126d with SMTP id
 e5-20020a4ab985000000b005867095126dmr2448869oop.0.1698162009971; 
 Tue, 24 Oct 2023 08:40:09 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 e20-20020ad442b4000000b0063c71b62239sm3727703qvr.42.2023.10.24.08.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:40:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] migration: Stop migration immediately in RDMA error paths
Date: Tue, 24 Oct 2023 11:40:08 -0400
Message-ID: <20231024154008.512222-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
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

In multiple places, RDMA errors are handled in a strange way, where it only
sets qemu_file_set_error() but not stop the migration immediately.

It's not obvious what will happen later if there is already an error.  Make
all such failures stop migration immediately.

Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

v2:
- One more line squashed into to fix the build error...  Please ignore v1,
  sorry for the noise.

This patch is based on Thomas's patch:

[PATCH v2] migration/ram: Fix compilation with -Wshadow=local
https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com

Above patch should have been queued by both Markus and Juan.
---
 migration/ram.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 212add4481..1473bb593a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+        return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+        return ret;
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
@@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            goto out;
         }
 
         t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
-        int rdma_reg_ret;
-
         if (!migration_in_postcopy()) {
             migration_bitmap_sync_precopy(rs, true);
         }
@@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            break;
         }
 
         /* try transferring iterative blocks of memory */
@@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
         ram_flush_compressed_data(rs);
 
-        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
-        if (rdma_reg_ret < 0) {
-            qemu_file_set_error(f, rdma_reg_ret);
+        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            break;
         }
     }
 
-- 
2.41.0


