Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAF7D5688
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJPj-0005v6-JW; Tue, 24 Oct 2023 11:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJPS-0005oc-Lw
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJPM-0005bU-Oh
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698161607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v7bqzGCFF8VkryMs01BNfXRb7Lsfvnn64+CqMhHBtlQ=;
 b=Ps4pxth3gvZXwUXwrdXvOPxa6RVU7HkuVHTsSkt3yEa3Xs39f0/v+YWgM9p2axXAOf/rbM
 eqO0HUABiYMhZyT+km9bWjilBUfZiOH1HBLAYR1XC/fqZQjkFHD7270IxTktU90K+zOQVZ
 JqByltSBjgLqft9ON0gnqIUVkMXHTeI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-FrfcfVyLMi-8hIElojmxQg-1; Tue, 24 Oct 2023 11:33:15 -0400
X-MC-Unique: FrfcfVyLMi-8hIElojmxQg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77898c3fbd3so49176785a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161595; x=1698766395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7bqzGCFF8VkryMs01BNfXRb7Lsfvnn64+CqMhHBtlQ=;
 b=GBbgZRqEw0tTYJVJWJCTH6LbNMrDNKxi+9s494MNIGYEaqzreJPmzpn00nvi1hgYS3
 i2YTmi8aCudPeO9XumxtDcBP49OUPFVjA6DRSwQXG2MsKMTy4UXFoQVvn/HThhAfSSPI
 PHSy7ZuY+aaZ4uhLtOz6cQEHKZqCJuR+gC0DLlhQOGOEUHSzHXzMmdYCOPuFzv0yLKWW
 BWrnyKQPXMs1/vTXTHQ5ofPpMkRNIbV8I8hs8SwKk87DpQCOpQXJVwYRq3O1/EdB9WOi
 dR0hgkO2jUfOh96CsxRsDtATKhOJ9ZB/Ij1YomiQvKUD87MNMhF32rj+7nQPI4W7wbxU
 0krA==
X-Gm-Message-State: AOJu0YxVzOVMnMZzRIo/Nw+3TyPgLnPzwMjGcGjcnAk4BycnnZmETuaZ
 AQXpXIg2sJg04oc98jl01kjAZo1ZLFAYAYv9OKVY1ei3IeWfl71bRmipUbDjgKVbP1PCSfqjN/J
 GzLcIi/Ubr7k8zq9NP5BPaB4wneHJAStUb+r77gkGNOoY27YDzpOBnX/AU3cnuzjL1z6IQucQ
X-Received: by 2002:a05:620a:6a85:b0:775:8fab:8c6d with SMTP id
 ud5-20020a05620a6a8500b007758fab8c6dmr11890638qkn.1.1698161595244; 
 Tue, 24 Oct 2023 08:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOE0WeMVqvCoH8Nik17twd+gUEteRcFTaKkYs9s0S3S0XoZ+Tg4EFc1bxp076mj4stMzK5ww==
X-Received: by 2002:a05:620a:6a85:b0:775:8fab:8c6d with SMTP id
 ud5-20020a05620a6a8500b007758fab8c6dmr11890615qkn.1.1698161594915; 
 Tue, 24 Oct 2023 08:33:14 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a05620a109500b007659935ce64sm3510327qkk.71.2023.10.24.08.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:33:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] migration: Stop migration immediately in RDMA error paths
Date: Tue, 24 Oct 2023 11:33:13 -0400
Message-ID: <20231024153313.500783-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch is based on Thomas's patch:

[PATCH v2] migration/ram: Fix compilation with -Wshadow=local
https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com

Above patch should have been queued by both Markus and Juan.
---
 migration/ram.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 212add4481..28cb2deffb 100644
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
+        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        if (ret < 0) {
             qemu_file_set_error(f, rdma_reg_ret);
+            break;
         }
     }
 
-- 
2.41.0


