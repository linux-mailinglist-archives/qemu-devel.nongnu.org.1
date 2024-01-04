Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D3B8243B6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:24:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOcD-0001Nq-Kh; Thu, 04 Jan 2024 09:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc4-0001MR-3H
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc1-0008Uh-Bf
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49DA21FCD8;
 Thu,  4 Jan 2024 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVql7tiWBTeK4WI1qaBzlhALh8DU+rKjXn3TGzSv2Yg=;
 b=TOOveeA9gb/gqasM8lfIF6lL02wPfmVYGk2BRtgO6G8UZ7EdTScYUu7mf6a4NDN7e+QPQ1
 bmshlplkIq+fnm3LJ5rhi8cPBBBLMxxK2tnQ2xhuuBDbEqStO+GH3uHXCPXOzZRClE8GQ/
 9OOYgB6CbTHlhNTv6aJ3rh824COOP34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVql7tiWBTeK4WI1qaBzlhALh8DU+rKjXn3TGzSv2Yg=;
 b=m1lQ0fSUIUH//GdKZ+344TtIZWKXmoP0+LJp2zzQ1GIbDnKenvRDDW4KsKjVs1npFQH1yc
 Q9sFtvzjcaS+uZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVql7tiWBTeK4WI1qaBzlhALh8DU+rKjXn3TGzSv2Yg=;
 b=TOOveeA9gb/gqasM8lfIF6lL02wPfmVYGk2BRtgO6G8UZ7EdTScYUu7mf6a4NDN7e+QPQ1
 bmshlplkIq+fnm3LJ5rhi8cPBBBLMxxK2tnQ2xhuuBDbEqStO+GH3uHXCPXOzZRClE8GQ/
 9OOYgB6CbTHlhNTv6aJ3rh824COOP34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVql7tiWBTeK4WI1qaBzlhALh8DU+rKjXn3TGzSv2Yg=;
 b=m1lQ0fSUIUH//GdKZ+344TtIZWKXmoP0+LJp2zzQ1GIbDnKenvRDDW4KsKjVs1npFQH1yc
 Q9sFtvzjcaS+uZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57802137E8;
 Thu,  4 Jan 2024 14:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFlZBxm/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/7] migration/multifd: Remove MultiFDPages_t::packet_num
Date: Thu,  4 Jan 2024 11:21:38 -0300
Message-Id: <20240104142144.9680-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 10.00
X-Spamd-Result: default: False [10.00 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[99.99%]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

This was introduced by commit 34c55a94b1 ("migration: Create multipage
support") and never used.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 1 -
 migration/multifd.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9f353aecfa..3e650f5da0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -250,7 +250,6 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
 {
     pages->num = 0;
     pages->allocated = 0;
-    pages->packet_num = 0;
     pages->block = NULL;
     g_free(pages->offset);
     pages->offset = NULL;
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..b0ff610c37 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -58,8 +58,6 @@ typedef struct {
     uint32_t num;
     /* number of allocated pages */
     uint32_t allocated;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
     /* offset of each page */
     ram_addr_t *offset;
     RAMBlock *block;
-- 
2.35.3


