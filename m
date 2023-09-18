Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C57A5103
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI35-0006mn-6L; Mon, 18 Sep 2023 13:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI2y-0006lf-SU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI2x-0004SL-Bl
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D77052003E;
 Mon, 18 Sep 2023 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695058109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7m6ZhfyJCfU+LqraU6Ps/zeNxE5mlr1xY4cZUtnPWNA=;
 b=ky/YbMd5m7akAzDp6ONouzIbesb3/wanx7rp0Wvt2koshNTbgcU6vyBPoAMF0Y130EzZMv
 /KxxsB4SJ5q61SfNJAuugbOBN9YfN8qqdX+Ad1epAWBRc0N/Fop9IVhdrQjPbElJjn95B3
 npfLcq5WYtrTt84Egff9GOZ/CV8VUJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695058109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7m6ZhfyJCfU+LqraU6Ps/zeNxE5mlr1xY4cZUtnPWNA=;
 b=kyOIZpN5U+nwtrDkgHVzRRydZBbjPppZCsSCtT71jZnmDkvWK/m7nUxS6KnehgERl+QmFA
 pgUzWEWK2RY8ypBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 599901358A;
 Mon, 18 Sep 2023 17:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yGdTCbyICGUoGAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:28:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/8] migration: Fix possible race when setting rp_state.error
Date: Mon, 18 Sep 2023 14:28:16 -0300
Message-Id: <20230918172822.19052-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
References: <20230918172822.19052-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

We don't need to set the rp_state.error right after a shutdown because
qemu_file_shutdown() always sets the QEMUFile error, so the return
path thread would have seen it and set the rp error itself.

Setting the error outside of the thread is also racy because the
thread could clear it after we set it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ee1e6b0d6..d426b69ada 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2074,7 +2074,6 @@ static int await_return_path_close_on_source(MigrationState *ms)
          * waiting for the destination.
          */
         qemu_file_shutdown(ms->rp_state.from_dst_file);
-        mark_source_rp_bad(ms);
     }
     trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
-- 
2.35.3


