Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5718B61CE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 21:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WT0-00073t-8s; Mon, 29 Apr 2024 15:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1WSw-00071P-GQ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:06 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1WSo-0004xq-4e
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:06 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id BE79260C03;
 Mon, 29 Apr 2024 22:14:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hEWuLX0IkKo0-PZlO9RVV; Mon, 29 Apr 2024 22:14:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714418094;
 bh=B4lb0xAY50iptOjN0OivH1864Aq3iVwhsMVxS2PuLw4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lg+3OYspBrvaV0zPIkmTeCGOpH5yBG+9uvp07MRQhEKUjXbPfZUKP3uZPkpJ7ezE1
 5U/zuHqRtssz8RWFgW0sorggNrgkNOOrBka35PUXmBqN9VI5JYnVxyH7gI1h3aOynY
 iq3e/5NtyhlZkoXNL3dVrQ7lAYdMIEYMGVJef3tI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v5 2/5] migration: process_incoming_migration_co(): complete
 cleanup on failure
Date: Mon, 29 Apr 2024 22:14:23 +0300
Message-Id: <20240429191426.2327225-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make call to migration_incoming_state_destroy(), instead of doing only
partial of it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2dc6a063e9..0d26db47f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -799,10 +799,7 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    qemu_fclose(mis->from_src_file);
-
-    multifd_recv_cleanup();
-    compress_threads_load_cleanup();
+    migration_incoming_state_destroy();
 
     exit(EXIT_FAILURE);
 }
-- 
2.34.1


