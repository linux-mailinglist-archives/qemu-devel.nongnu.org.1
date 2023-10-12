Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF727C6F90
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvzF-0000Bm-CG; Thu, 12 Oct 2023 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyl-0008R0-8g
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:43:57 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyj-0003Tq-33
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:43:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5911F88E;
 Thu, 12 Oct 2023 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697118230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdKi/AKt4d0+MduaGijwk50/kvp6fptXM6PBPW+ZtHE=;
 b=NSovvzAIqf1UaVyKoesDlJydj/ijcKAodt0kIE4VKQSL/kOeSNa/fnEr+6FCyPyxx5D6d/
 In78O9GCcFg+lv/Hum+qYnlb3UKIEyKAps6OqAy6iEUIyqIo8na43mQ1BgU4dmCToDwU7e
 DHkFJbNsGibAD2FBVEZt3tejgxbPuz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697118230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdKi/AKt4d0+MduaGijwk50/kvp6fptXM6PBPW+ZtHE=;
 b=UY34hh485iAous2JebVhZ0+gSXojQy22OrkN7Q728RWCMN7cDyEhiJoHVxAU9Q58IQD3z5
 IakRyhmXiRn53iDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BC4A13A87;
 Thu, 12 Oct 2023 13:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aK8yBhX4J2UQfAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 13:43:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/3] migration/multifd: Unify multifd_send_thread error paths
Date: Thu, 12 Oct 2023 10:43:42 -0300
Message-Id: <20231012134343.23757-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012134343.23757-1-farosas@suse.de>
References: <20231012134343.23757-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.89
X-Spamd-Result: default: False [0.89 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[50.63%]
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

The preferred usage of the Error type is to always set both the return
code and the error when a failure happens. As all code called from the
send thread follows this pattern, we'll always have the return code
and the error set at the same time.

Aside from the convention, in this piece of code this must be the
case, otherwise the if (ret != 0) would be exiting the thread without
calling multifd_send_terminate_threads() which is incorrect.

Unify both paths to make it clear that both are taken when there's an
error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a7c7a947e3..bc3994c567 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -752,19 +752,13 @@ static void *multifd_send_thread(void *opaque)
     }
 
 out:
-    if (local_err) {
+    if (ret) {
+        assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        error_free(local_err);
-    }
-
-    /*
-     * Error happen, I will exit, but I can't just leave, tell
-     * who pay attention to me.
-     */
-    if (ret != 0) {
         qemu_sem_post(&p->sem_sync);
         qemu_sem_post(&multifd_send_state->channels_ready);
+        error_free(local_err);
     }
 
     qemu_mutex_lock(&p->mutex);
-- 
2.35.3


