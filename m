Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662D74894E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TM-0001ba-6w; Wed, 05 Jul 2023 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TB-0001VN-Kz
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5T9-0003b1-R1
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1IaGXK1wBtXrLilN+yF3vXwn+M9gw6WL28vnSu7RWk=;
 b=Wm8ysF7caJyQI8tJVlgiaMbHnZE249zN17aEtGcL1q80PfFhner3QWt1eL8Ajj5Hfcd+4m
 TlMHTxxFnZbmARKxBgd+/rcvi5yNMOb3kSvxZlwnNxOFbJFJGGgufdmmdqfKv5zIESfhAy
 lASoavQYjMMCA9z+OoitNAKuDf3XEl0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-FPi4OSR2Ohq9xHRlrW_QAg-1; Wed, 05 Jul 2023 12:35:05 -0400
X-MC-Unique: FPi4OSR2Ohq9xHRlrW_QAg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-401e1fc831fso10171611cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574905; x=1691166905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1IaGXK1wBtXrLilN+yF3vXwn+M9gw6WL28vnSu7RWk=;
 b=djMzMp3HhCUcGqrlVRAZpYwpN48jaeIjEpzC5fD07F60KHzCqw8PEaiSjlpVTZTje+
 2SzAVJM1Yxj0qbBjZVDCG0oSnoCXowN1ONkC7lcC7P4CRvdOaGVYhxrpUiYRxaiNggDw
 GWqj1rRlYdHE3c/24E41xZaUZuPL//ShwDe0VFDDENthgB37iHGTQs/FOiC78kkYDUoi
 As87HuylN6/0W3fjRa7LXhZ7xFv1Lh8R7R+Ae22dn0o6wjgotTF4ZzhPavi+U5t5U2th
 WJaF215StEN2vwRpjzftBBgyiUsG51hdbfBryeU7p7gyJfM38YNB5Zeci6SOSoNjWIr7
 Mujg==
X-Gm-Message-State: AC+VfDyIFOyu+vFvNCe4qh3WILxE+wCoo9tV7/ueADkb4XIV/L2d9o4P
 nr6rWMWlzFgz/cKLINNKS6RhWesKo4ARSlRpOcO3KS0R4sPw+PsyIflNY5Tiaur6bMb3g1XWh01
 fnnJB9/YsUYqaQ4mnhRr9gvj8Z5WAQCOe7RvmWrGT1wFqG6GTxRWthkllCiKJuB39T7HlBb2n
X-Received: by 2002:a05:620a:45a7:b0:767:1a23:137 with SMTP id
 bp39-20020a05620a45a700b007671a230137mr19543413qkb.2.1688574904834; 
 Wed, 05 Jul 2023 09:35:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EhDq2otfPQCoLFdr2sg+XMJP6hTo9FbH3eNFRjblWkNkJfjlidleQp1BMALbEKYN3dmHoaA==
X-Received: by 2002:a05:620a:45a7:b0:767:1a23:137 with SMTP id
 bp39-20020a05620a45a700b007671a230137mr19543393qkb.2.1688574904551; 
 Wed, 05 Jul 2023 09:35:04 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 1/7] migration: Display error in query-migrate irrelevant
 of status
Date: Wed,  5 Jul 2023 12:34:56 -0400
Message-ID: <20230705163502.331007-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
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
index c050081555..ade45d564d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -222,9 +222,8 @@
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
index d75c2bd63c..6a4c245f74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1039,9 +1039,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
-        if (s->error) {
-            info->error_desc = g_strdup(error_get_pretty(s->error));
-        }
         break;
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
@@ -1051,6 +1048,11 @@ static void fill_source_migration_info(MigrationInfo *info)
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


