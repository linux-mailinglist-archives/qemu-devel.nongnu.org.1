Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D49A0361
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Oct 2024 09:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yu5-0003Zz-Na; Wed, 16 Oct 2024 03:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu2-0003Yj-3D
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0ytz-0000h1-LK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cb7088cbcso35256205ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729065422; x=1729670222;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPCILjRi6VdBAXe5YCsoUa6w4039+pCXbLXnN2JBo9s=;
 b=DO6G4h9HcTOgg+vP6JXLy2OeJnh0gUAV0crQLaLKH4i/AJsGyTFv9M95ahkOv4bIA/
 bZ2KM7BEv8UMfc/1VjJwqEqKvBnmM5IOHXcundf4/uGs+eamSn/vCGyNK5w0Es0yz5BM
 OHltCM3i5s7nXc2iMTy6iMVDSlPcQsl7SiQh7a3gcD4VKL+RbPGbapptzpuChkM165u1
 Y6XoGQfFeDAx3yAje4Fxc3WK9gtp4YkS4QZVUHyL9ufX0DhkJTZTN829N2SokuYfu3x5
 OUNqIBP5AUpABGjR1oGLIaXJEnfFHb8iHAW7SIBVV+gn5z6allK3grvO9w/O6OTa9mGh
 Ii3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065422; x=1729670222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPCILjRi6VdBAXe5YCsoUa6w4039+pCXbLXnN2JBo9s=;
 b=HVjLL2Dc4XEBXnDwur2mktGoLeAekj2sBYKI7AGP9NyVA6c4B9DQUkkPeTB1WTACXG
 nNVQfRPiuYNbpvBkJOwlgO5H2qSGydx1I5I8uTcJK6fNHaPfbFN7KRyuYLWtdKyl1xm8
 eWzKq1HmCKlmMBNvhZZrk+B5uFapkVEGxEB+H+UkAEwn1pPxXAm5MRkJbmVpWfN5Z70L
 bjBnoO5wfIDUBF7slbHjFCogYyzFn/aovHFA58yHdxlkDq/ssqeOZV4UAd8gRXian359
 7QkYyxWhtf4unksfFRfDBzPgJzOCYkBrte5SLDUIeHhyMPjwtsdAWvFDHZf8F9FrNkgG
 LjCQ==
X-Gm-Message-State: AOJu0Yw1Dx1qjOwr/xgS3KgdVYNAnnXt/KaikF00APgeegih3+ph088l
 ObHyV6jYqQieFfrBAHTljYdFcL0+mwMVExih4bR6rQ3ummVOCz31RstFtrywdimHhiLeJtzwKwS
 1QutQnw==
X-Google-Smtp-Source: AGHT+IHxC9QA4Iqd3SqdUdzurOWdLLrjStHMmA4Ci6b9FoCmcFj/a6d5Os89fRePtlGUcCMr6nrf9Q==
X-Received: by 2002:a17:902:db12:b0:20c:5ba1:e8e5 with SMTP id
 d9443c01a7336-20ca145d515mr261043765ad.19.1729065421626; 
 Wed, 16 Oct 2024 00:57:01 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dd1sm23608365ad.43.2024.10.16.00.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:57:01 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v3 2/4] migration: Remove "rs" parameter in
 migration_bitmap_sync_precopy
Date: Wed, 16 Oct 2024 15:56:43 +0800
Message-Id: <63b04591ecd6fcd1ffe570e1005fc3040168ad42.1729064919.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729064919.git.yong.huang@smartx.com>
References: <cover.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

The global static variable ram_state in fact is referred to by the
"rs" parameter in migration_bitmap_sync_precopy. For ease of calling
by the callees, use the global variable directly in
migration_bitmap_sync_precopy and remove "rs" parameter.

The migration_bitmap_sync_precopy will be exported in the next commit.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 54d352b152..9b5b350405 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1088,9 +1088,10 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     }
 }
 
-static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
+static void migration_bitmap_sync_precopy(bool last_stage)
 {
     Error *local_err = NULL;
+    assert(ram_state);
 
     /*
      * The current notifier usage is just an optimization to migration, so we
@@ -1101,7 +1102,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
         local_err = NULL;
     }
 
-    migration_bitmap_sync(rs, last_stage);
+    migration_bitmap_sync(ram_state, last_stage);
 
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2782,7 +2783,7 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
     }
 out_unlock:
@@ -3248,7 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(rs, true);
+            migration_bitmap_sync_precopy(true);
         }
 
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
@@ -3330,7 +3331,7 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
     if (!migration_in_postcopy()) {
         bql_lock();
         WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
         bql_unlock();
     }
-- 
2.27.0


