Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1C70685B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGQW-0006dM-2U; Wed, 17 May 2023 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQT-0006ci-Hg
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:41 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQR-00019d-Py
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id BF3FC5E7F1;
 Wed, 17 May 2023 15:38:32 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown
 [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KcbvG13OqeA0-Kg48OSgG; Wed, 17 May 2023 15:38:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684327111; bh=qmNKOzCEih1cUmj+W6WaTzBuYOWTTnQ0arLgcpBXT1k=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OB/n0N2Zwi2G/ABhJCRESN+AGC8TU5Jpxc+FEew3tqqGUToeRLk+LGWliFuc8Jv5t
 69C4LH3Lm9t7bUo2AlmEjgJoNXP/Cvxk4zck63IFSFxhFVxjRvVCeyQ2pRNH1Rxkpr
 gmiETeg4ZWw9r9BubweJQHGFTv5mJDFzdHuhUubE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, leobras@redhat.com, peterx@redhat.com,
 quintela@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH 1/5] runstate: add runstate_get()
Date: Wed, 17 May 2023 15:37:48 +0300
Message-Id: <20230517123752.21615-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517123752.21615-1-vsementsov@yandex-team.ru>
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

It's necessary to restore the state after failed/cancelled migration in
further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.34.1


