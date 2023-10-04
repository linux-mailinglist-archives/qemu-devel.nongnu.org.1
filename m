Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B387B9714
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xe-0005I7-HJ; Wed, 04 Oct 2023 18:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xc-0005Ck-NB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xN-0003wk-9k
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG5URcj0LvXiyzkErTJOYCEY51A9yYuyYymueU+c8k8=;
 b=AkHtPCjrQytpiSVy7HA9Pz2+6eGBZyovx2c0v+Vmx5jAAfm9XswSJTXZgXXxFZRtszKujr
 g/Pzkds1P7VItjwIVt0wpRteUtoKhEapHM/nB+xFzrziThVVoJNN9pPXDAbhEaBXljeaP3
 SCtjiJqBPNcxTLmY/nMv7DtvxcmdLZg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-IDl0XMZjNJiqRVj1TZaIWA-1; Wed, 04 Oct 2023 18:02:44 -0400
X-MC-Unique: IDl0XMZjNJiqRVj1TZaIWA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso495806d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456963; x=1697061763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bG5URcj0LvXiyzkErTJOYCEY51A9yYuyYymueU+c8k8=;
 b=Ip2wKK26W/DeCF84ZpK3c5+PLGz+CnExO2Rs8AgKhAQIPnPrbnMhZhub1+FOMibMvt
 zfxns6tPsB7Sq37atHTEt65ejXHRa8qUTKY0SVJepvXxyjBmSEnEIuROhOII1jhcX1cF
 xG/a9UICaBSqVUKXp3/y81WJyimF3mErnc1HJBInhrB8zCnLTClUJTcJEK5J6ziwg+tZ
 qh2cZtTG3UUWI9OfxdGiRj/oyWO9YVo3U/VyPnjxx7dSpr2P5sjwWqCHqkLD+0fBxQAY
 QYcOLoJnD3qHcoad92hZYd9DDCqxepA2BzoMMc9PxszFHCACdxTj90TzybS36JujwO6m
 h6Vg==
X-Gm-Message-State: AOJu0Yw4gSAkodPSM+fg3GVMC4YVtqgInVR35TLwlfg9w4/nbcfX11ye
 O4YAoFwk3XhP+avN3wPDnaAw0eyrqNPmlsKjHYCQWro+jAD3e20AIzBgTraAv1L3K4Bhi4H3qrv
 e+V68bLqRze/D1ZgAH1TqGajSPsc3rH1KM4fhchl32v9Yfg/zDZE4iIe+x7GyWfzbRqLYDVSL
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr3691511qvb.1.1696456963462; 
 Wed, 04 Oct 2023 15:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkNSH2PDNeC6AUkshGDZ10vEV1esuQBC9JhWZ7PplECEjNuObrfLuKcPPLzVwBcxuAWKnU3A==
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr3691479qvb.1.1696456962953; 
 Wed, 04 Oct 2023 15:02:42 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 01/10] migration: Display error in query-migrate irrelevant
 of status
Date: Wed,  4 Oct 2023 18:02:31 -0400
Message-ID: <20231004220240.167175-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This will change QAPI behavior by showing up error message outside !FAILED
status, but it's intended and doesn't expect to break anyone.

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
index 585d3c8f55..010056d6f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1057,9 +1057,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
-        if (s->error) {
-            info->error_desc = g_strdup(error_get_pretty(s->error));
-        }
         break;
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
@@ -1069,6 +1066,11 @@ static void fill_source_migration_info(MigrationInfo *info)
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


