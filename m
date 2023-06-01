Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7A71F6C9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ryF-00067s-HF; Thu, 01 Jun 2023 19:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryC-0005xT-NM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ry9-0000wN-Mk
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGtkd/VOEqR1Ouq/Wg8DwRbxBOulP2LrMmjMkxNN4GY=;
 b=U4R4x2Y0gz8tDQkFurU6L/AoiuTEhFLJFHtMFjG1Z0qz6gk/tnGjX13T032WBuHnsw0kp3
 U502Oj4cNToXpU0ljkIZ8O40CyiltOG/u4E/TGOzLTb5KKsPIGz6d78ygi8NHXm0ubA5mm
 vfHcL1huTs52avP/fd+MGoPsh3DjcEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-wwpCj7dcMzWxf7Id36ktOQ-1; Thu, 01 Jun 2023 19:44:34 -0400
X-MC-Unique: wwpCj7dcMzWxf7Id36ktOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3DD085A5AA;
 Thu,  1 Jun 2023 23:44:32 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2571492B00;
 Thu,  1 Jun 2023 23:44:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 3/6] runstate: drop unused runstate_store()
Date: Fri,  2 Jun 2023 01:44:23 +0200
Message-Id: <20230601234426.29984-4-quintela@redhat.com>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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


