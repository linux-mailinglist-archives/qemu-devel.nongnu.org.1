Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CE741B2B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3U-0001MI-Fl; Wed, 28 Jun 2023 17:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3G-0001J3-D7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3D-0008Oy-V6
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vupwd0bgT3VbYEETQv3z7JejUbkc4mPBy77gLSet1rk=;
 b=B9P24ajrC+f1oc4JcfnBlGE7sM5kE/EDxf5nU7OV7xSaoIthtrk6MeBR2+PW2VS8HKeoSq
 0vQO+RgCj+ktF4lmphE2bF+YrLa+TbLk7Fk2yNxUT5DN0OXVmFahKKeQbTz/+z197iDQCU
 kscntGvjBIKdHsvaXItpbHHliUBxqWI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-J5uvn_wqOVO_k4oYAhf1eQ-1; Wed, 28 Jun 2023 17:50:10 -0400
X-MC-Unique: J5uvn_wqOVO_k4oYAhf1eQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4009ad15222so22471cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989009; x=1690581009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vupwd0bgT3VbYEETQv3z7JejUbkc4mPBy77gLSet1rk=;
 b=WnHJoNSWMo9cpZarP6glvzrCHet8CtOyf5cmp9GBTOw1MZENsWDTvgwWMoBx7bddly
 y5XfuRHF8hWBVUC6YtQ+TFYBwbj5P+gl13aht2a6izSOvEk8YpdRKoaQYu6IeCp6MBbQ
 46nI4RGGwqGfy+5z3YDKwyCM8PtdQF8pA+CyY6GdobNnHCqov8SszxLAWZnDpMhiqkeR
 /gByxc9ysNIkro/EJmxc7FvJo0ussRTeVAnktYKYWVGMTNaUbDkRowBpjRCAF+7lkkh1
 dXM9FOsgIS6a0Oxz1vaAzm7P/2BEvEj7v3KcCB6nYtXReU98DnEPiKZZSYXm6Ry9Snjq
 Iw8w==
X-Gm-Message-State: AC+VfDyFSAXosJDZkRjZs6xMCFj4SVizw301+txIGWfKr5em9pq2IwA0
 Y6K2kAjSC3uAvbnJwZ7r5q64MUjzEhyK816D2Tnl4wYhW3SxVrcJNprKF+Wob3U4BEiQwOe5m/x
 cNdwbez+MpRyDegJt4loFQgzNePYGZAbeWvv3f+CzL9mQOAdFc7lIYcYHejP7swu5EdM53GOL
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id
 z18-20020a05622a029200b003ff3151a8a7mr32376618qtw.3.1687989009372; 
 Wed, 28 Jun 2023 14:50:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64JLRuwfLgP0W6kzlJZ9btHAmrUUEY5dCCburW0AnVGS+UMr/2JzV4P8TCiZGW03z43kgXvA==
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id
 z18-20020a05622a029200b003ff3151a8a7mr32376600qtw.3.1687989009064; 
 Wed, 28 Jun 2023 14:50:09 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 5/7] migration: Display error in query-migrate irrelevant of
 status
Date: Wed, 28 Jun 2023 17:50:00 -0400
Message-ID: <20230628215002.73546-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 234dd3601d..7455353918 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1033,9 +1033,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
-        if (s->error) {
-            info->error_desc = g_strdup(error_get_pretty(s->error));
-        }
         break;
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
@@ -1045,6 +1042,11 @@ static void fill_source_migration_info(MigrationInfo *info)
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


