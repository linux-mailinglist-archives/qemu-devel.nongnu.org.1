Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663BA0901C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 13:19:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDua-0001UY-6u; Fri, 10 Jan 2025 07:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuX-0001U6-Et
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:45 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuV-0003MX-SF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C95821177;
 Fri, 10 Jan 2025 12:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xgxcPNXD8/1JJMtCAc0UgSzFRJ8xnbkzFW1a99qkqQ=;
 b=n3xSvOQciEkSCOEb/jhQ9IxXV+Yq+YWa6lbxYTaAH1uC8LjPw1//3ySuptrROPT93X4nXR
 d5nigZeKMErMIyouDS0VsyHHqqJtWeY3xwwq1B3329/9WVV6QDtFeIEqkIV3RQH6dMA1G/
 lgpNvuZBDe+WftxByZXA1ErXimMVunE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xgxcPNXD8/1JJMtCAc0UgSzFRJ8xnbkzFW1a99qkqQ=;
 b=NSqOjf77YLkKaO9c9fNYqEttW3CvIAMwhDRW+sjgI/3KhiYNKoU843ZdbMmxZL0kLoBNsK
 EvV9dGf65zDX+eBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n3xSvOQc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NSqOjf77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xgxcPNXD8/1JJMtCAc0UgSzFRJ8xnbkzFW1a99qkqQ=;
 b=n3xSvOQciEkSCOEb/jhQ9IxXV+Yq+YWa6lbxYTaAH1uC8LjPw1//3ySuptrROPT93X4nXR
 d5nigZeKMErMIyouDS0VsyHHqqJtWeY3xwwq1B3329/9WVV6QDtFeIEqkIV3RQH6dMA1G/
 lgpNvuZBDe+WftxByZXA1ErXimMVunE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xgxcPNXD8/1JJMtCAc0UgSzFRJ8xnbkzFW1a99qkqQ=;
 b=NSqOjf77YLkKaO9c9fNYqEttW3CvIAMwhDRW+sjgI/3KhiYNKoU843ZdbMmxZL0kLoBNsK
 EvV9dGf65zDX+eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C37513A86;
 Fri, 10 Jan 2025 12:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKMNGDEPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 17/25] migration: Remove unused argument in vmsd_desc_field_end
Date: Fri, 10 Jan 2025 09:14:05 -0300
Message-Id: <20250110121413.12336-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C95821177
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-3-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fa002b24e8..aa2821dec6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -311,7 +311,7 @@ static void vmsd_desc_field_start(const VMStateDescription *vmsd,
 
 static void vmsd_desc_field_end(const VMStateDescription *vmsd,
                                 JSONWriter *vmdesc,
-                                const VMStateField *field, size_t size, int i)
+                                const VMStateField *field, size_t size)
 {
     if (!vmdesc) {
         return;
@@ -420,7 +420,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
+                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes);
 
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
-- 
2.35.3


