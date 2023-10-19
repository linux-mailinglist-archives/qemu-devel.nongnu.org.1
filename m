Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F87D027B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYd0-0006HZ-5Z; Thu, 19 Oct 2023 15:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYcy-0006HQ-7T
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:16 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYcw-0004uM-ME
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88CDA21A64;
 Thu, 19 Oct 2023 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wwcd1pzdVabPIOTw4yLra8gja2wtYK4kweAsmx149ac=;
 b=pQieHYIr/YeM/Kf7pJoehtDFJNYUUGj6GobIQIH3l0qxlqI9/Yjm10ByZ+Kg8L7aTHRAmo
 Wed5OoOf+DqH7Njt++AjdJNcxlZs8dbxnXM7drHRUtODXBt4SRy/L2Jppy6CQ4Q1XWYq+l
 xXkz7jr9cgx9HrCeR/22YMT6LLa/MhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wwcd1pzdVabPIOTw4yLra8gja2wtYK4kweAsmx149ac=;
 b=LZXq3Vr74bUArl+SCDanVoHt2nvTMPPJVVH4P0YT+5syan5vk6/qFFXIUDT0GpQqTl2rxY
 6U8JqI8s7d1hGjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D8FD1357F;
 Thu, 19 Oct 2023 19:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MHVBClqCMWWWEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:24:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v14 04/14] fixup! migration: convert migration 'uri' into
 'MigrateAddress'
Date: Thu, 19 Oct 2023 16:23:43 -0300
Message-Id: <20231019192353.31500-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019192353.31500-1-farosas@suse.de>
References: <20231019192353.31500-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.02
X-Spamd-Result: default: False [-2.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SUBJECT_HAS_EXCLAIM(0.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_TWELVE(0.00)[13]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.92)[99.65%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 2 +-
 migration/file.h      | 1 +
 migration/migration.c | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index cf5b1bf365..ec069ef329 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -19,7 +19,7 @@
 
 /* Remove the offset option from @filespec and return it in @offsetp. */
 
-static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
+int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
 {
     char *option = strstr(filespec, OFFSET_OPTION);
     int ret;
diff --git a/migration/file.h b/migration/file.h
index 90fa4849e0..3888a57105 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -11,4 +11,5 @@ void file_start_incoming_migration(const char *filename, Error **errp);
 
 void file_start_outgoing_migration(MigrationState *s, const char *filename,
                                    Error **errp);
+int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index c1108f409c..e3608d7f60 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -465,6 +465,12 @@ static bool migrate_uri_parse(const char *uri,
         }
         addr->u.socket.type = saddr->type;
         addr->u.socket.u = saddr->u;
+    } else if (strstart(uri, "file:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
+        addr->u.file.path = g_strdup(uri + strlen("file:"));
+        if (file_parse_offset(addr->u.file.path, &addr->u.file.offset, errp)) {
+            return false;
+        }
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
         return false;
-- 
2.35.3


