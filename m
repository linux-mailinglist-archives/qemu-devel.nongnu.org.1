Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1AA6140F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 15:49:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6L9-0003vn-Ka; Fri, 14 Mar 2025 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6L5-0003uS-HL
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6Kx-0001iY-V7
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10646211D6;
 Fri, 14 Mar 2025 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoDT9fnMqcB0zEYJWHSYNMHut1KvzgiGr2yEN/eewmw=;
 b=bHT8VmK4SyAipoXQpFohc8+6urUhg7MDv0E7B8+uTeAr3yrwnqtWCqQJ4aCcsiqGmLPs4x
 X2Wl47D9LOrRuGZhBlkhYHqH+8spBuYvNNGbhPIkfBg2keRmJKFJTQCj8uF5YyYtsouNrk
 r0RliP8gl9fjwC7z8pDL2wRCngpOBh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoDT9fnMqcB0zEYJWHSYNMHut1KvzgiGr2yEN/eewmw=;
 b=YNgM19800ItwPScKwi5Jj/m3PhxZpTIrSm9FJGEqhNIW4UExC8vZXHvMiqOSyx/At0YQtk
 1KgS1LLo+rN8wRDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoDT9fnMqcB0zEYJWHSYNMHut1KvzgiGr2yEN/eewmw=;
 b=f02nhMn16wXJgiobTeNPNLsYcubpjtdXSLHUQSlOtw4+i3a5I44f8sYW3FDLeSDp0F9qo8
 292sScHc2Qj46W5IoVX2G5v6Th2w9sfqkKMMucEwspORhofJScc55VHVmVFBIDeX7h7uVI
 b24ZRWb0dmuWW3wCXrARj/iuukJj/xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoDT9fnMqcB0zEYJWHSYNMHut1KvzgiGr2yEN/eewmw=;
 b=D6WtqGaZZyjg+cK3Vnzta3BFl9A/+L1e/taVezuZSd7rnriw6Jwtwi3rpEJ7RAZT60Iz5s
 neRfXJYiBTse8CBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0AB7132DD;
 Fri, 14 Mar 2025 14:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCe7JL5B1GeVPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Mar 2025 14:48:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 1/4] migration: cpr_is_incoming
Date: Fri, 14 Mar 2025 11:48:21 -0300
Message-Id: <20250314144824.1707-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250314144824.1707-1-farosas@suse.de>
References: <20250314144824.1707-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Define the cpr_is_incoming helper, to be used in several cpr fix patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <1741380954-341079-2-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h | 1 +
 migration/cpr.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3a6deb7933..7561fc75ad 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -21,6 +21,7 @@ int cpr_find_fd(const char *name, int id);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
+bool cpr_is_incoming(void);
 
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 180faab247..42c46563e5 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -128,6 +128,11 @@ void cpr_set_incoming_mode(MigMode mode)
     incoming_mode = mode;
 }
 
+bool cpr_is_incoming(void)
+{
+    return incoming_mode != MIG_MODE_NONE;
+}
+
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
-- 
2.35.3


