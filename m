Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78DBB7579
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 17:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4htG-0004fj-Ga; Fri, 03 Oct 2025 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htD-0004ZP-Np
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4ht3-0007Mq-Si
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759505999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+YHlJ2nLWpl5OKcyvtU38uTkVZG45VSCaiO3qL/KPo=;
 b=iXu37PutZyNhlK6PuuDzQInKf0GoiOximcq2VBVDHk2uo3CQRYP4Ldj57eNMmg/TNkzFwj
 NUtu3WU8RODUS1d+cY+ccZdNjFSH4TKIDKyp9X/dhRl9/HuPBiqa5FKzQ5AcmLxFLbY/g+
 pxeW/KMhPfO1A4CasMBiXs/ENdLo2U8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42--BRZidjVO7iGWBmp_Qfz0Q-1; Fri, 03 Oct 2025 11:39:58 -0400
X-MC-Unique: -BRZidjVO7iGWBmp_Qfz0Q-1
X-Mimecast-MFC-AGG-ID: -BRZidjVO7iGWBmp_Qfz0Q_1759505998
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78efb3e2738so3637836d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505998; x=1760110798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+YHlJ2nLWpl5OKcyvtU38uTkVZG45VSCaiO3qL/KPo=;
 b=DLI6fnWKxw7E2wZYkwoSsyMWrpvZYqD5Yyp7UQKxUJaW5Jdw+O/r6vpuhnPn/4TMm3
 UbF9NkCohAZ4+g8w07hqua+1/lkibrRFvbUrHyZuVEuhd1zRd0zHMhPJFaJhkmxcghN6
 BcCn2QmzwQPxCKxgl7QO0oh7s4bQcNBnWmpDM+cWHmoXOlyqNqsVkfdepypfPptu7dy+
 wBlmwjKOuA6/PdAMpks6CSXscF+1GCOmmkdiiWTHPiiT0oyg8K3MoCehTvbfejnYGfzp
 1ktjqxPU1LVBdT+sCldU2eGszO+ZHU9P41WJRPSdOpbw6emECqIgsbZFclAvL9Tcfqer
 brYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiRWqQot7c3AIlohKPuBOt55cbO9FC5DTGegnv8qgXLGsjOE1dV117ZMSdji+l3w5pAeKoxwc16oNf@nongnu.org
X-Gm-Message-State: AOJu0YwTkOKeooxbZtw2ct3b4huBgW65MsVctim2N8NBJJEPeOba58Qu
 h+W7MQojzCVks/2PUPrSOzWUss4EYsXl5prmE7OP1Ym6wiNdmP1ISxZBczmXZqZU43cElF/xz+I
 KvcQYlfcx2yyyjaqfS27aYoZ0Ex2lVOM04z6IND7XxjyJaLqlXsxRwyoQ
X-Gm-Gg: ASbGnctLu6Q4TeHfbPwbqVQiH+eXDXkCdbRGsEWLa/EylU7GRYlTgmjE7v5lr71jUjZ
 ry1PDe0zNyx5dJH5TaU/+g0fM3y0GN6im4HbngKhOH2AjEWahpY1dJXfM9MIr1aO9+QUuFLGxDl
 Pr0PLVIM2RBlPKF0cEN6hH0e0+3Ioim6S7w2d+8mPXZ+qbzPHS0dfjvM27KyclEc3R/3M/TExJN
 Jgvq/LAZwWXna//BXLX9D2WVQ72eIk/bqGaMM2UEYrEVnoSmR9jWgX+sDsUk8u3Bos1uT6A5O9W
 bwllGHhZKRo85aVWWxNG9twhxhGFIhiLkWWokg==
X-Received: by 2002:ad4:5ca3:0:b0:796:dc45:8034 with SMTP id
 6a1803df08f44-879dc852938mr56385556d6.45.1759505997560; 
 Fri, 03 Oct 2025 08:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ubpG9CHE9H86cTfWQs/SLalfgMURJEuddDNJ9ynRbRBZ4//y8xHnVS7RwxCf+haCndnCxQ==
X-Received: by 2002:ad4:5ca3:0:b0:796:dc45:8034 with SMTP id
 6a1803df08f44-879dc852938mr56385006d6.45.1759505997037; 
 Fri, 03 Oct 2025 08:39:57 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 03/45] migration: push Error **errp into
 qemu_loadvm_state_header()
Date: Fri,  3 Oct 2025 11:39:06 -0400
Message-ID: <20251003153948.1304776-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-3-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 55c99e0902..8ac3d33814 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,38 +2814,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
-    Error *local_err = NULL;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, magic: %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp,
+                   "SaveVM v2 format is obsolete and no longer supported");
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 &local_err);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -3121,8 +3126,9 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
-- 
2.50.1


