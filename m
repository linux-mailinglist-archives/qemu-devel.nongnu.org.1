Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B0739570
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9qi-00085T-Ox; Wed, 21 Jun 2023 22:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qL-00072O-F7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qI-00055I-NB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C3D7iNM38aBqhdSOuDcDrLT+thUiibV5CBvo7gXvFw=;
 b=HArC8Wv+sAdSid7L4Rszv/aSEPh4mR23Sc81X5PnCs+b0LBaQ31K3LNeQ1wdEBSFf/r9we
 t7G072E2ketaSRE9G95SgUc2Lvy3LxuXBwxiC2TmVW6MoBdjpZ3aR4wCzZW3Cy1kKBGZya
 Zs5xDgUIAplLMY0l/Mcm6D7M60otEys=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-VxIyhA7gMAyJo7Ue8WJ9Xw-1; Wed, 21 Jun 2023 22:14:35 -0400
X-MC-Unique: VxIyhA7gMAyJo7Ue8WJ9Xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3B3C1C06EDE;
 Thu, 22 Jun 2023 02:14:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC0B0112132C;
 Thu, 22 Jun 2023 02:14:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 18/30] migration-test: dirtylimit checks for x86_64 arch before
Date: Thu, 22 Jun 2023 04:13:08 +0200
Message-Id: <20230622021320.66124-19-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

So no need to assert we are in x86_64.
Once there, refactor the function to remove useless variables.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-11-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index eb6a11e758..fbe9db23cf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2515,10 +2515,7 @@ static int64_t get_limit_rate(QTestState *who)
 static QTestState *dirtylimit_start_vm(void)
 {
     QTestState *vm = NULL;
-    g_autofree gchar *cmd = NULL;
-    const char *arch = qtest_get_arch();
-
-    assert((strcmp(arch, "x86_64") == 0));
+    g_autofree gchar *
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
-- 
2.40.1


