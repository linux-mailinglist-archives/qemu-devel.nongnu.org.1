Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8237D4120
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fT-0002vf-SW; Mon, 23 Oct 2023 16:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fO-0002oN-Mz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:50 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fN-0001pf-8a
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A35121FE32;
 Mon, 23 Oct 2023 20:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAVFxiDFeacmkca8s9WK4yCViaCO1YWTERbARIPhDI8=;
 b=bcw9NZsxz04Ko6jGlR+OsyJDzlb65Wn0FPZj544/m6tWMMSDwFF+mPM7ZZpub4zcNzYR6X
 iK5SLHZevF7DgsPiMd5A64q1i0O0rzIWhWpFV53xg7OyxIruuuTfYb7mmCJ8oaol1bMNEe
 P2lAqWeE6IhwzP07yJUpYgM5E1vfVoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAVFxiDFeacmkca8s9WK4yCViaCO1YWTERbARIPhDI8=;
 b=/8mGSE9pY596x5sn2ezfveEezartCd1kqhl6vLkFTRen8aUWR2JnnjK4ppRXw4NTgVU9qq
 8/F3Xc00lhqxqOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0DE2132FD;
 Mon, 23 Oct 2023 20:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4PjLHl3ZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 13/29] migration: fixed-ram: Add URI compatibility check
Date: Mon, 23 Oct 2023 17:35:52 -0300
Message-Id: <20231023203608.26370-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.20)[96.17%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The fixed-ram migration format needs a channel that supports seeking
to be able to write each page to an arbitrary offset in the migration
stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 692fbc5ad6..cabb3ad3a5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -106,22 +106,40 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
+static bool migration_needs_seekable_channel(void)
+{
+    return migrate_fixed_ram();
+}
+
 static bool uri_supports_multi_channels(const char *uri)
 {
     return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
            strstart(uri, "vsock:", NULL);
 }
 
+static bool uri_supports_seeking(const char *uri)
+{
+    return strstart(uri, "file:", NULL);
+}
+
 static bool
 migration_channels_and_uri_compatible(const char *uri, Error **errp)
 {
+    bool compatible = true;
+
+    if (migration_needs_seekable_channel() &&
+        !uri_supports_seeking(uri)) {
+        error_setg(errp, "Migration requires seekable transport (e.g. file)");
+        compatible = false;
+    }
+
     if (migration_needs_multiple_sockets() &&
         !uri_supports_multi_channels(uri)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
-        return false;
+        compatible = false;
     }
 
-    return true;
+    return compatible;
 }
 
 static bool migration_should_pause(const char *uri)
-- 
2.35.3


