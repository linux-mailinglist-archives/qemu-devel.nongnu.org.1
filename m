Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2F77E37C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSb-0003qo-Cs; Wed, 16 Aug 2023 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSa-0003qM-5u
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:20 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSW-0003g3-Ic
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56D22211AE;
 Wed, 16 Aug 2023 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692195914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PhUELTTum7IhhBh6UKFhYbWo9uwRpZtijafGvFsHP8A=;
 b=I/mR9z140RYHnHVCHsd0HI+mayDMhfth+XlB6MUoekplLM6Nlx1Tw+e/GE3bfkM87Qrcnk
 tCA6poqclwmh9JVQg5jxEdpRbtJesAaCXOw19AZrNfcq8rLLLrzJuYbH5Dpl1Wz7Mn+AgB
 Rx+9TOElkALmv+WTltnrx7H22dlxI2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692195914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PhUELTTum7IhhBh6UKFhYbWo9uwRpZtijafGvFsHP8A=;
 b=t2fIigQecRUoD2XFwpJYRyPtKLa1NuThT4G/GONyLNGOCqDA/IsutzO5U1Q3heGt0+nHQT
 Hn9ohEHzfKc+iYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0971C133F2;
 Wed, 16 Aug 2023 14:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9vUgMUjc3GShdwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 14:25:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v4 0/8] Fix segfault on migration return path
Date: Wed, 16 Aug 2023 11:25:02 -0300
Message-Id: <20230816142510.5637-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The major change from v3 is the dropping of shutdown() before close()
as suggested by Peter.

I also added a yank handler to rp_state.from_dst_file.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/969570891

v3:
https://lore.kernel.org/r/20230811150836.2895-1-farosas@suse.de

I decided to fix the issues with the shutdown instead of complaining
about them. First 5 patches address all of the possible races I
found. The only problem left to figure out is the -EIO on shutdown
which will need more thought.

Patches 6 & 7 fix the original segfault.

Patches 8-10 make the cleanup of migration files more predictable and
centralized.

I also adjusted some small things that were mentioned by Peter:

- moved the rp.error = false outside of the thread;
- stopped checking for errors during postcopy_pause();
- dropped the tracepoint;

CI run: https://gitlab.com/farosas/qemu/-/pipelines/963407228

v2:
https://lore.kernel.org/r/20230802143644.7534-1-farosas@suse.de

- moved the await into postcopy_pause() as Peter suggested;

- brought back the mark_source_rp_bad call. Turns out that piece of
code is filled with nuance. I just moved it aside since it doesn't
make sense during pause/resume. We can tackle that when we get the
chance.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/953420150
Also ran the switchover and preempt tests for 1000 times each on
x86_64.

v1:
https://lore.kernel.org/r/20230728121516.16258-1-farosas@suse.de

The /x86_64/migration/postcopy/preempt/recovery/plain test is
sometimes failing due a segmentation fault on the migration return
path. There is a race involving the retry logic of the return path and
the migration resume command.

The issue happens when the retry logic tries to cleanup the current
return path file, but ends up cleaning the new one and trying to use
it right after. Tracing shows it clearly:

open_return_path_on_source  <-- at migration start
open_return_path_on_source_continue <-- rp thread created
postcopy_pause_incoming
postcopy_pause_fast_load
qemu-system-x86_64: Detected IO failure for postcopy. Migration paused. (incoming)
postcopy_pause_fault_thread
qemu-system-x86_64: Detected IO failure for postcopy. Migration paused. (source)
postcopy_pause_incoming_continued
open_return_path_on_source   <-- NOK, too soon
postcopy_pause_continued
postcopy_pause_return_path   <-- too late, already operating on the new from_dst_file
postcopy_pause_return_path_continued <-- will continue and crash
postcopy_pause_incoming
qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
postcopy_pause_incoming_continued

We could solve this by adding some form of synchronization to ensure
that we always do the cleanup before setting up the new file, but I
find it more straight-forward to move the retry logic outside of the
thread by letting it finish and starting a new thread when resuming
the migration.

More details on the commit message.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/947875609

Fabiano Rosas (8):
  migration: Fix possible race when setting rp_state.error
  migration: Fix possible races when shutting down the return path
  migration: Fix possible race when shutting down to_dst_file
  migration: Remove redundant cleanup of postcopy_qemufile_src
  migration: Consolidate return path closing code
  migration: Replace the return path retry logic
  migration: Move return path cleanup to main migration thread
  migration: Add a wrapper to cleanup migration files

 migration/migration.c | 229 +++++++++++++++---------------------------
 migration/migration.h |   1 -
 2 files changed, 80 insertions(+), 150 deletions(-)

-- 
2.35.3


