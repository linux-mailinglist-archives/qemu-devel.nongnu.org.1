Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955886B30E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 16:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkt-0006a2-8t; Wed, 28 Feb 2024 10:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkq-0006ZR-Uy
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:56 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkk-0004wp-Uq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C41D4225B3;
 Wed, 28 Feb 2024 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o46sFjZsEWeR+R8yfcC+7u4ABouxUZnc1C4VudIOCY=;
 b=Bsg10aj7PHDu5Aki8aImFLwSV8gysmf36sMeI46QiwPHGjnUjYDMFOa0S7h2mvWtDaGill
 V7TWyf/UZteX2+y8C/obcHL3O/rhPG8zgGJG5vJl55ir0qUb/37vxh56fr41M8ykA/U8/J
 +NuB8KH0ePPBG/dfmvWRd4MqmfBcUR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o46sFjZsEWeR+R8yfcC+7u4ABouxUZnc1C4VudIOCY=;
 b=n2PEjjvVzvZMdlya1NTR7DsIaZaY8WYywZg0a8ThayVUAcFD3E/51+41eEn0D3+haJyBkK
 Qa578Zs2UzR0eLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o46sFjZsEWeR+R8yfcC+7u4ABouxUZnc1C4VudIOCY=;
 b=Bsg10aj7PHDu5Aki8aImFLwSV8gysmf36sMeI46QiwPHGjnUjYDMFOa0S7h2mvWtDaGill
 V7TWyf/UZteX2+y8C/obcHL3O/rhPG8zgGJG5vJl55ir0qUb/37vxh56fr41M8ykA/U8/J
 +NuB8KH0ePPBG/dfmvWRd4MqmfBcUR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+o46sFjZsEWeR+R8yfcC+7u4ABouxUZnc1C4VudIOCY=;
 b=n2PEjjvVzvZMdlya1NTR7DsIaZaY8WYywZg0a8ThayVUAcFD3E/51+41eEn0D3+haJyBkK
 Qa578Zs2UzR0eLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3054313A5D;
 Wed, 28 Feb 2024 15:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLQXOotP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 08/23] migration: Add mapped-ram URI compatibility check
Date: Wed, 28 Feb 2024 12:21:12 -0300
Message-Id: <20240228152127.18769-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bsg10aj7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n2PEjjvV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: C41D4225B3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The mapped-ram migration format needs a channel that supports seeking
to be able to write each page to an arbitrary offset in the migration
stream.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 25f01d7818..c1cc003b99 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -147,10 +147,39 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     return false;
 }
 
+static bool migration_needs_seekable_channel(void)
+{
+    return migrate_mapped_ram();
+}
+
+static bool transport_supports_seeking(MigrationAddress *addr)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        return true;
+    }
+
+    /*
+     * At this point, the user might not yet have passed the file
+     * descriptor to QEMU, so we cannot know for sure whether it
+     * refers to a plain file or a socket. Let it through anyway.
+     */
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
+    }
+
+    return false;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
 {
+    if (migration_needs_seekable_channel() &&
+        !transport_supports_seeking(addr)) {
+        error_setg(errp, "Migration requires seekable transport (e.g. file)");
+        return false;
+    }
+
     if (migration_needs_multiple_sockets() &&
         !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
-- 
2.35.3


