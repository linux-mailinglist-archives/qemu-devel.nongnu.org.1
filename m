Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2A79DBCE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlc-0007mj-RU; Tue, 12 Sep 2023 18:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlZ-0007lj-Sw
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlX-0003Gs-2p
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvq5IlCtFKtt9HwA7RP+yrEXQL9cf5tHRMuJHvBx/MM=;
 b=FZSYDuX5vaVFZu36T2I4BE9I33wzrZ3dhDX4pRncMxAmYBt0VeoQPs5g4ITpOWDCEpTQcS
 DDgBVnp7kf51q2p8+z3Qn/1jgCnUHnCfuZDiozjOw67+clTOjDDATpmbsL3ElDtaCBZZUY
 nYqf2rknteZo9y2jGN4EtTX34eQT0TE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-WdScp9WvMcWHqsoJgTZkQg-1; Tue, 12 Sep 2023 18:21:49 -0400
X-MC-Unique: WdScp9WvMcWHqsoJgTZkQg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f1cc68e65so159926185a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557308; x=1695162108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uvq5IlCtFKtt9HwA7RP+yrEXQL9cf5tHRMuJHvBx/MM=;
 b=VFKsCgiL6XHoxGrXzjvRFoxvlvN5w3u2EZHFyItMRTlS/ZilkfkCNb4p3/888C+Uhv
 EGFuO8j7nk5Cx4zZXfuDKA13oGiVlMZIFQesmA8iAdtAeVfi0inpzsIzNciDac4xj5rs
 ES+8zrX0BHl2AkhzjilDR/JydWiJISRaEdJrQh9Hs3dffompD/srv+yHfKh5SYA0p7qh
 egIZPKgCHh+D2f7l/W7TV/zj/ICm3zuPT8UDUDB8NUK9TlwQ/BWvnMWID+uP5FpVAqt6
 KOlGIT2/SC060/JVI8YljfsSMvlfZSsO1W2omotC/tJ7/neSjBtCQLbKgXiQXTKapWG9
 zxSA==
X-Gm-Message-State: AOJu0YzDVgqhaSUg9h1C55eLQAv0+fnKHVYT4ffEvg1AV7syVo+RT0D6
 VCiJyrG5kQkVQ91tOHnKzGeZJhXTqJNZO/C33hZfb7zJ+Ul7VR3gvaKvPy5VmXkEYevZQFuB7ov
 /qLTefIkSMSboJ7Ucf2IwUZFjXWQar3D9YI37Fm3IVVQKkQ2VCx6yYst3cI3Ir7X6K58gSE29
X-Received: by 2002:a05:6214:f6e:b0:63d:2a0b:3f91 with SMTP id
 iy14-20020a0562140f6e00b0063d2a0b3f91mr775053qvb.2.1694557308554; 
 Tue, 12 Sep 2023 15:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK/W4GlaGonNgUjEHtzuFxH8DytI6COmDicp8canMW0Y03XPT+lJDLDgnLo6hawvGy6VUdxg==
X-Received: by 2002:a05:6214:f6e:b0:63d:2a0b:3f91 with SMTP id
 iy14-20020a0562140f6e00b0063d2a0b3f91mr775039qvb.2.1694557308200; 
 Tue, 12 Sep 2023 15:21:48 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 01/11] migration: Display error in query-migrate irrelevant
 of status
Date: Tue, 12 Sep 2023 18:21:35 -0400
Message-ID: <20230912222145.731099-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d61e572742..61e91f61af 100644
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


