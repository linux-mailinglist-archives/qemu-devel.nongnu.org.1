Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927D766DED
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMNw-0008QG-5d; Fri, 28 Jul 2023 08:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNS-0008Ks-Ll
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNQ-0001ae-Tj
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69A611F891;
 Fri, 28 Jul 2023 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690546520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EyDsNG7/DRBWdT1NAu98/x0LJvnahFIUEYZ7+RTJgfI=;
 b=16XVTPEY0HirJroH2tTV0sMFqasp267kQNij5qiPhWgpbI6viZdtyZoTZz8GLWatmgqhlu
 Gr6BmiO5Ge/etL8/kNXQ0rQn8F+RAhxLYkeDLWll8Jo4ClSW1SGK6cxC0M2NmAeBB8evCH
 a5JCVfVFkJbCbS1tcVxb6Sqr4XlUzaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690546520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EyDsNG7/DRBWdT1NAu98/x0LJvnahFIUEYZ7+RTJgfI=;
 b=o0icBZiakVZRoOJ21q4JcVVV0/TYnhw//P7w01H5yKAQVZ9mrrQ9uYsauejYtyMIxjd50A
 /gguMvxmeu/MANDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5387213276;
 Fri, 28 Jul 2023 12:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7NXNB1exw2RBYQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 28 Jul 2023 12:15:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/3] Fix segfault on migration return path
Date: Fri, 28 Jul 2023 09:15:13 -0300
Message-Id: <20230728121516.16258-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Fabiano Rosas (3):
  migration: Stop marking RP bad after shutdown
  migration: Simplify calling of await_return_path_close_on_source
  migration: Replace the return path retry logic

 migration/migration.c  | 94 ++++++++++++++----------------------------
 migration/migration.h  |  1 -
 migration/trace-events |  3 +-
 3 files changed, 33 insertions(+), 65 deletions(-)

-- 
2.35.3


