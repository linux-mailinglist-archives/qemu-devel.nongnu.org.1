Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269A716C73
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q442X-0001RC-QS; Tue, 30 May 2023 14:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442U-0001PG-3w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442R-0000cv-S6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGtkd/VOEqR1Ouq/Wg8DwRbxBOulP2LrMmjMkxNN4GY=;
 b=aVXjpYWcpvnpjT92jejvlbeGjmboacbSOxqKp+Hj/0ELJHNq5UwJC011O/IYEWI3a8oF7B
 xk4BblZPH/tMjblfafYK8ecUlAQJ/awVf9p1kZLDrYUTBGynWEv24KU/hWXBnYqhRMQdTu
 emxr1VcRwWHEvKK9oOySmLsw85cCDiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-87UOXOyzPLGGO2EGhyAPGQ-1; Tue, 30 May 2023 14:25:37 -0400
X-MC-Unique: 87UOXOyzPLGGO2EGhyAPGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 846A6185A78B;
 Tue, 30 May 2023 18:25:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 744D217103;
 Tue, 30 May 2023 18:25:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 03/21] runstate: drop unused runstate_store()
Date: Tue, 30 May 2023 20:25:13 +0200
Message-Id: <20230530182531.6371-4-quintela@redhat.com>
In-Reply-To: <20230530182531.6371-1-quintela@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The function is unused since previous commit. Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230517123752.21615-4-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/sysemu/runstate.h |  1 -
 softmmu/runstate.c        | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 85f5d9a419..7beb29c2e2 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -9,7 +9,6 @@ void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
 bool runstate_needs_reset(void);
-bool runstate_store(char *str, size_t size);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1e6f0bcecc..0370230a5e 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -175,18 +175,6 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
-bool runstate_store(char *str, size_t size)
-{
-    const char *state = RunState_str(current_run_state);
-    size_t len = strlen(state) + 1;
-
-    if (len > size) {
-        return false;
-    }
-    memcpy(str, state, len);
-    return true;
-}
-
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.40.1


