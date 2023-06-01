Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A30371F6CE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ryD-0005wy-Jj; Thu, 01 Jun 2023 19:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ry7-0005wL-Vx
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ry6-0000vu-74
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HIuK2JuDsuMAWMzDLOmEGJIdWcuvp6JGlclttbw8+Y=;
 b=fTsNJzKP3Mrs2Vx+KHipvqavo+80R7DjjUAaHlcbeO4BE6C/vqg/U9caLeN6t2yCpLO9if
 icHwzsek86TIBPFepZlu5JTg3koJ6mPFqrr9rYBCa1MNRbdzRe2qykkBukDpiSMc+3W2SZ
 IO+0ZXjaf+SRlG8CpGvimMiZ8FMFOVo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-bw1nyl0eNhar2gDwFO1FGw-1; Thu, 01 Jun 2023 19:44:30 -0400
X-MC-Unique: bw1nyl0eNhar2gDwFO1FGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FA583C00086;
 Thu,  1 Jun 2023 23:44:30 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E38F9492B00;
 Thu,  1 Jun 2023 23:44:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 1/6] runstate: add runstate_get()
Date: Fri,  2 Jun 2023 01:44:21 +0200
Message-Id: <20230601234426.29984-2-quintela@redhat.com>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

It's necessary to restore the state after failed/cancelled migration in
further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230517123752.21615-2-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/sysemu/runstate.h | 1 +
 softmmu/runstate.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index f3ed52548e..85f5d9a419 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -6,6 +6,7 @@
 
 bool runstate_check(RunState state);
 void runstate_set(RunState new_state);
+RunState runstate_get(void);
 bool runstate_is_running(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 2f2396c819..1e6f0bcecc 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -221,6 +221,11 @@ void runstate_set(RunState new_state)
     current_run_state = new_state;
 }
 
+RunState runstate_get(void)
+{
+    return current_run_state;
+}
+
 bool runstate_is_running(void)
 {
     return runstate_check(RUN_STATE_RUNNING);
-- 
2.40.1


