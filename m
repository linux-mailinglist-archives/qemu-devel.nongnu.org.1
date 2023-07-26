Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 629027642EB
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 02:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOoFx-00083A-MY; Wed, 26 Jul 2023 19:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOoFt-00082y-Sd
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOoFr-0005aE-Rl
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 19:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690415358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1lNSAjE5zkEJdXuWDNJe38D8ktC2xZmwPGQBM27cd9g=;
 b=BDjGUYsAQMcKI+k+HPsMGdjrpiupXjwC6m6NpiBZOJUwZBcYga8tC1G0nXNPDAryo69aE5
 NuPLsBvTqUKv0ed2eWA7efiV2MBdL+ZVKwip6NVJoy8mRVzOEcCL1qZmogaeEU9ZJSUOLZ
 owqcRSeLwr+QTPwDB8uE70pHgHcmxcI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-tlcS6Rf1PomYIDLH_5j-Tg-1; Wed, 26 Jul 2023 19:49:16 -0400
X-MC-Unique: tlcS6Rf1PomYIDLH_5j-Tg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63d289847dcso875746d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 16:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690415356; x=1691020156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lNSAjE5zkEJdXuWDNJe38D8ktC2xZmwPGQBM27cd9g=;
 b=Ze1vAEHtJtL59aR0gzEHlORdrk7hSr1QDmYpYSIZlWr3Sgm8SOJcFEgJZryoAkhTxb
 vSYPOM000RTwBjjDCXJ2WfeakRhtdg1to04GFRsi/Sc7oEiSDTfl2pJuqO0WKgL7QXHZ
 JexOz23vkV77JCCPNkKCLESaPE4HmcDzF+YUXQ6AltwsUikLyzgTddabzjVJFvT/TgNC
 jryAvIlTEpgx1pZR37Lud2PhOCqMuaBDjUhDpW1cr50EFi4LVYsZ7fZxPBKmWWi5+W88
 dEKDXacqxjefBvLhZy1HAmFpHZ1ORnKlAEcbiW3JSKchpUHlYB9jooWJm5ZPGXNZyApj
 LlwA==
X-Gm-Message-State: ABy/qLY14Ghj5fBof9ovk3iREZRD9+cTI7kHaYDEMNDx3FY/T/7pHae0
 0ZM6TQYPRUKV+JBBeln8mCLGOtoJ/MWOIIOL0fDjSe/Mi2e2BstwmtGyR0al18xclU2wbZJ5kEe
 4sbrIu4oNuETAJLlS5+HSzTu/U9NRwoe2X46ZOKyS6mPoXTfxGugYGKPe61SPy6vHN3gUD3gd
X-Received: by 2002:ad4:5c69:0:b0:63d:ee8:4127 with SMTP id
 i9-20020ad45c69000000b0063d0ee84127mr3950943qvh.2.1690415356282; 
 Wed, 26 Jul 2023 16:49:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPgG9E0iH6mBPbLaq0kEhk5Z/1tnpbW+xNI+ekhvIraIRoVVwiknrLMcbA+WmKt3RMzYSwwA==
X-Received: by 2002:ad4:5c69:0:b0:63d:ee8:4127 with SMTP id
 i9-20020ad45c69000000b0063d0ee84127mr3950933qvh.2.1690415355906; 
 Wed, 26 Jul 2023 16:49:15 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a37c408000000b00767b4fa5d96sm17090qki.27.2023.07.26.16.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 16:49:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH] tests/migration-test: Remove arch_target
Date: Wed, 26 Jul 2023 19:49:14 -0400
Message-ID: <20230726234914.1218167-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

It is always NULL, so drop it.

Cc: Juan Quintela <quintela@redhat.com>
Fixes: Coverity CID 1518101
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..7ce1379ba8 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -701,7 +701,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                               const char *uri, MigrateStart *args)
 {
     g_autofree gchar *arch_source = NULL;
-    g_autofree gchar *arch_target = NULL;
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
     g_autofree gchar *cmd_source = NULL;
@@ -810,12 +809,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s",
                                  args->use_dirty_ring ?
                                  ",dirty-ring-size=4096" : "",
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
-                                 arch_target ? arch_target : "",
                                  shmem_opts,
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-- 
2.41.0


