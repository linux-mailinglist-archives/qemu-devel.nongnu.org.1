Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772B78CFEF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nQ-0000wT-4L; Tue, 29 Aug 2023 19:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U2-0006KO-CG
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6Tz-0000d4-2q
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JlJsdxT1usV5bXAnIEbEDfMePHILK1A36pxGg3ZqUo=;
 b=NhBnyFXOUksiJNbhuXJH9TmjwoROFkLEUBdxeBmpMBs9aJQtVEqhfB0RgnGNpi6lew40BC
 G/AxZADLNPRNXkU5AU1XoA0znJ9QuRjuHD2MxSGPNI69JkMxSTwem/LBHFATBZT/aJtCDM
 LTQuYjx1qyoaKZn9nYHn9Ehg24CyWiQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-rQwPNAOJMBKlLCBw0v6BCw-1; Tue, 29 Aug 2023 17:42:40 -0400
X-MC-Unique: rQwPNAOJMBKlLCBw0v6BCw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-410a8a0ba9eso13031601cf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345360; x=1693950160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JlJsdxT1usV5bXAnIEbEDfMePHILK1A36pxGg3ZqUo=;
 b=g1FiGY+M3/KQR9sdbz6CoOE0Y/rIckV4qB3dy1NvObAHFEBtDYSzPk9TFnh1MqvTNY
 7oT0w8FSKDPCt9SXf1Wn58h0kwP+hYBZ2CHZnJkcZ/Ep/QUnxC5vPwdZxOHnwW58v5Ak
 wUTkN2hKDMAYOt3rApRbPaihf84zocfHxf3hDFlUJ6dR42bFKnAIabz4HFjN7M4jICYY
 o6XcpMix1br+HaxsuwIVSkW93Qj94eYsW28q+StbGT+xQU56ur/pZI8kQ0Xy17EYRuW/
 T4N4vjGyyHogG6XT0rBBOcuHglHDY6RN7Ab7P6wBDLCK84yW+Gtb2IeTsILMzfZyuxme
 UAww==
X-Gm-Message-State: AOJu0YxFXI6j7/B1byW6Ixcj01KPYf1ek7AsHiafJ1ddH1Fl9Gn0lF0a
 NdRAnexyqK2YqiOx3K4XbhqlLxNMZ5ELasKbD7Z5Rw9QJZzj3CvfnUT56RpHLQpJ2TlM+Rf7KZk
 dbOzagj9iVkxfYvYPdIXQ+S56Wzy83VCgr5mZYk65H8zoLXWuVnHXOzvQRYszw1XdhjXmXHMN
X-Received: by 2002:ac8:7d02:0:b0:3ff:2a6b:5a76 with SMTP id
 g2-20020ac87d02000000b003ff2a6b5a76mr186684qtb.5.1693345359762; 
 Tue, 29 Aug 2023 14:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDFWqhYIQkU0GDs5xm7pm/GyK8t/ZrvXi6M1NVzU4+tfZdLA9Psq1nPdCUKkWgxsNq8iU0lg==
X-Received: by 2002:ac8:7d02:0:b0:3ff:2a6b:5a76 with SMTP id
 g2-20020ac87d02000000b003ff2a6b5a76mr186672qtb.5.1693345359331; 
 Tue, 29 Aug 2023 14:42:39 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 1/9] migration: Display error in query-migrate irrelevant of
 status
Date: Tue, 29 Aug 2023 17:42:27 -0400
Message-ID: <20230829214235.69309-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
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

Display it as long as being set, irrelevant of FAILED status.  E.g., it may
also be applicable to PAUSED stage of postcopy, to provide hint on what has
gone wrong.

The error_mutex seems to be overlooked when referencing the error, add it
to be very safe.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   | 5 ++---
 migration/migration.c | 8 +++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..c241b6d318 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -230,9 +230,8 @@
 #     throttled during auto-converge.  This is only present when
 #     auto-converge has started throttling guest cpus.  (Since 2.7)
 #
-# @error-desc: the human readable error description string, when
-#     @status is 'failed'. Clients should not attempt to parse the
-#     error strings.  (Since 2.7)
+# @error-desc: the human readable error description string. Clients
+#     should not attempt to parse the error strings.  (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during
 #     postcopy live migration.  This is only present when the
diff --git a/migration/migration.c b/migration/migration.c
index 5528acb65e..c60064d48e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1052,9 +1052,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
-        if (s->error) {
-            info->error_desc = g_strdup(error_get_pretty(s->error));
-        }
         break;
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
@@ -1064,6 +1061,11 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     }
     info->status = state;
+
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    if (s->error) {
+        info->error_desc = g_strdup(error_get_pretty(s->error));
+    }
 }
 
 static void fill_destination_migration_info(MigrationInfo *info)
-- 
2.41.0


