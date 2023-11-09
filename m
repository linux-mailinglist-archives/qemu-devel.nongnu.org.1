Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F07E6FC2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:59:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18N2-0000Vb-OU; Thu, 09 Nov 2023 11:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18N0-0000V0-Ic
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:06 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18Mz-00043g-4H
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B55421985;
 Thu,  9 Nov 2023 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699549142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cRpZGCYCqI/ZVcb18vmR0JwPH5yY1dnRm0DCN6UO+w=;
 b=a77sIdrD6O3LXJfI6Q9EsrnfTy5tjqE5pCLzo7fHTkBKVf7FzJeH1QZ+1KqzSOQoxWt4Ak
 lORA1Dd+EbEqYxiA/vlcKLSa/YGHBU5MhV9PtlNGbmh3A1/vL99/GLDwettZtt9y/2jO3i
 NGj4w7BCtSqag7zX3H0k8ZaOf6BmAME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699549142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cRpZGCYCqI/ZVcb18vmR0JwPH5yY1dnRm0DCN6UO+w=;
 b=8di/rt2eVkZs70EuA039Wp2T1rnJEkI4fRIRQYwY+qQEh5y6nkp1qOiNS9tI8B34teomYD
 0YAmFTqSJvYutMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99942138E5;
 Thu,  9 Nov 2023 16:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mMYjGdQPTWVXNwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 09 Nov 2023 16:59:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] migration: Report error in incoming migration
Date: Thu,  9 Nov 2023 13:58:55 -0300
Message-Id: <20231109165856.15224-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231109165856.15224-1-farosas@suse.de>
References: <20231109165856.15224-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We're not currently reporting the errors set with migrate_set_error()
when incoming migration fails.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..cca32c553c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -698,6 +698,13 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
+        MigrationState *s = migrate_get_current();
+
+        if (migrate_has_error(s)) {
+            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+                error_report_err(s->error);
+            }
+        }
         error_report("load of migration failed: %s", strerror(-ret));
         goto fail;
     }
-- 
2.35.3


