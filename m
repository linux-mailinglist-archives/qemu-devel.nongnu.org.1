Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02858CC8FE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 00:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKN-0005VA-3z; Wed, 22 May 2024 18:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKI-0005Ul-PH
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKE-0003kR-17
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 900D81F8B9;
 Wed, 22 May 2024 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ4OczsCtc4NtIM/xZr3gCkmZSK1dp9Nvgp0JXMSeA0=;
 b=mhwq3A3EU7ixhHMhfWTysOYwLSoowqq2ns5FArGnKI059GcXBFh91S/k3pHcXA8UTJW9/B
 OSbbk8S3283HWkXQsZmIiJ1iVMdU/iPH98kQ3TJ5V0tVWIcMQKt9HgdmEaXWJ8vAi8+L9l
 EUbX0MfNTL+pY9ix0tAdFbTklNeYSlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ4OczsCtc4NtIM/xZr3gCkmZSK1dp9Nvgp0JXMSeA0=;
 b=kTwJ/gotYiW2pF5ZEeNMW8l1bEjIynyJ5PbJ4bCbn/2vN/w944fgamvc7wRsPMfDcmnsn9
 8XyDmfCVrqFjddCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mhwq3A3E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kTwJ/got"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ4OczsCtc4NtIM/xZr3gCkmZSK1dp9Nvgp0JXMSeA0=;
 b=mhwq3A3EU7ixhHMhfWTysOYwLSoowqq2ns5FArGnKI059GcXBFh91S/k3pHcXA8UTJW9/B
 OSbbk8S3283HWkXQsZmIiJ1iVMdU/iPH98kQ3TJ5V0tVWIcMQKt9HgdmEaXWJ8vAi8+L9l
 EUbX0MfNTL+pY9ix0tAdFbTklNeYSlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ4OczsCtc4NtIM/xZr3gCkmZSK1dp9Nvgp0JXMSeA0=;
 b=kTwJ/gotYiW2pF5ZEeNMW8l1bEjIynyJ5PbJ4bCbn/2vN/w944fgamvc7wRsPMfDcmnsn9
 8XyDmfCVrqFjddCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAF8E13A6B;
 Wed, 22 May 2024 22:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EAoqILpvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Zhang Chen <chen.zhang@intel.com>
Subject: [PULL 3/9] migration/colo: Tidy up bql_unlock() around
 bdrv_activate_all()
Date: Wed, 22 May 2024 19:20:28 -0300
Message-Id: <20240522222034.4001-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.99
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 900D81F8B9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.99 / 50.00]; BAYES_HAM(-2.98)[99.91%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Make the code more tight.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
[fixed mangled author email address]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ca37b932ac..f96c2ee069 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -837,12 +837,11 @@ static void *colo_process_incoming_thread(void *opaque)
     /* Make sure all file formats throw away their mutable metadata */
     bql_lock();
     bdrv_activate_all(&local_err);
+    bql_unlock();
     if (local_err) {
-        bql_unlock();
         error_report_err(local_err);
         return NULL;
     }
-    bql_unlock();
 
     failover_init_state();
 
-- 
2.35.3


