Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0488B6D99
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 10:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jIb-0003eg-Dt; Tue, 30 Apr 2024 04:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIZ-0003eM-OX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:15 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIM-0000vb-Ev
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id D208160CBF;
 Tue, 30 Apr 2024 11:56:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id muME9V11IOs0-TYcrE1n4; Tue, 30 Apr 2024 11:56:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714467418;
 bh=VHC9RZigAVNyKAky4lkPW6oU5AWLhFjsdBC4IrMfUKY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qreyKnoarbG1F0z5nYaK9xplDSppXHlBbQnIWKi8LDWwpmNeHnZoXL6uX+fBlFN9X
 VqrnsU7kikk2TFOkwrNgU3MYgsMoFNxdRghzQC8aglDT4ErUjYRyCeCRXQ9uaubvYF
 mjjmFEazyo8pMEmHABJvoSnANUB8fF/QhsTFGV9g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v6 1/5] migration: move trace-point from migrate_fd_error to
 migrate_set_error
Date: Tue, 30 Apr 2024 11:56:42 +0300
Message-Id: <20240430085646.2359711-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
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

Cover more cases by trace-point.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 4 +++-
 migration/trace-events | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5105..2dc6a063e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1421,6 +1421,9 @@ static void migrate_fd_cleanup_bh(void *opaque)
 void migrate_set_error(MigrationState *s, const Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
+
+    trace_migrate_error(error_get_pretty(error));
+
     if (!s->error) {
         s->error = error_copy(error);
     }
@@ -1444,7 +1447,6 @@ static void migrate_error_free(MigrationState *s)
 
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
-    trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_FAILED);
diff --git a/migration/trace-events b/migration/trace-events
index f0e1cb80c7..d0c44c3853 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -152,7 +152,7 @@ multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostnam
 # migration.c
 migrate_set_state(const char *new_state) "new state %s"
 migrate_fd_cleanup(void) ""
-migrate_fd_error(const char *error_desc) "error=%s"
+migrate_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
 migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
-- 
2.34.1


