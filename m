Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E4766DEE
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMNw-0008Qp-QY; Fri, 28 Jul 2023 08:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNS-0008Kr-L7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:45 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNQ-0001b8-Tw
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F73621982;
 Fri, 28 Jul 2023 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690546522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqUR9NR2BE8TI0OGnkTqmfoEcr2dPERzkp1LvcIZOGc=;
 b=E6aa+qhGjRg3hRuciC424OBJydQon7mC4Od3FeEnT56czTFHsq0sFuPsr8cd7fI8GICdzw
 Xyoo6qp73WtnzLb7hZ3CVEnAkmIbsfYbRJEZe7DjHI35IlW3ouMvh0FSTdKzFBRxs49dxI
 u7FAeD4cGkOTPOrdPIRRoDeorpnf2l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690546522;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqUR9NR2BE8TI0OGnkTqmfoEcr2dPERzkp1LvcIZOGc=;
 b=HRi7SY4brqxE966DRUkrrbMTWD3CLNLtBvdlPy5eejt491nBFBYwMU4SryZQ+TXWiq2JiG
 ClBU48SHAm8M63CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D667013276;
 Fri, 28 Jul 2023 12:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0MFuJ1ixw2RBYQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 28 Jul 2023 12:15:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 1/3] migration: Stop marking RP bad after shutdown
Date: Fri, 28 Jul 2023 09:15:14 -0300
Message-Id: <20230728121516.16258-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230728121516.16258-1-farosas@suse.de>
References: <20230728121516.16258-1-farosas@suse.de>
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

When waiting for the return path (RP) thread to finish, there is
really nothing wrong in the RP if the destination end of the migration
stops responding, leaving it stuck.

Stop returning an error at that point and leave it to other parts of
the code to catch. One such part is the very next routine run by
migration_completion() which checks 'to_dst_file' for an error and fails
the migration. Another is the RP thread itself when the recvmsg()
returns an error.

With this we stop marking RP bad from outside of the thread and can
reuse await_return_path_close_on_source() in the next patches to wait
on the thread during a paused migration.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..051067f8c5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2049,7 +2049,6 @@ static int await_return_path_close_on_source(MigrationState *ms)
          * waiting for the destination.
          */
         qemu_file_shutdown(ms->rp_state.from_dst_file);
-        mark_source_rp_bad(ms);
     }
     trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
-- 
2.35.3


