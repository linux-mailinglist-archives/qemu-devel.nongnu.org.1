Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D084A45A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 20:51:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4yN-0008Ma-Rq; Mon, 05 Feb 2024 14:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX4yL-0008MS-CT
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:49:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX4yH-0004I5-7f
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:49:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 916BE1FB42;
 Mon,  5 Feb 2024 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IAnFU8VjGc03j9aKoWWuWvvtsl/SPRiagmta2AJaUq8=;
 b=BFqIvflNOONMVkOTblBBPcWVWdWt6I9fItle1mgoq0K76rDhJsDy+cYeQcIFhP8LKOUPTf
 u57lu/a45y98RsV2NGRCCer4pxxkdAdfn4WXksuQoY2M+viqY1A0qdtVVDfasKF39PuHvm
 0ctlEL0QfXnmXh66vBfq7YDkuKMM/3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IAnFU8VjGc03j9aKoWWuWvvtsl/SPRiagmta2AJaUq8=;
 b=a0euSwP22VoB3rgG5oW5EBgPD4/q8+chNmLdPkLFPBTzFqNpsYI6GOLR6oclV2iSsx5eyY
 dGFHHRT24IYbqsAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IAnFU8VjGc03j9aKoWWuWvvtsl/SPRiagmta2AJaUq8=;
 b=BFqIvflNOONMVkOTblBBPcWVWdWt6I9fItle1mgoq0K76rDhJsDy+cYeQcIFhP8LKOUPTf
 u57lu/a45y98RsV2NGRCCer4pxxkdAdfn4WXksuQoY2M+viqY1A0qdtVVDfasKF39PuHvm
 0ctlEL0QfXnmXh66vBfq7YDkuKMM/3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IAnFU8VjGc03j9aKoWWuWvvtsl/SPRiagmta2AJaUq8=;
 b=a0euSwP22VoB3rgG5oW5EBgPD4/q8+chNmLdPkLFPBTzFqNpsYI6GOLR6oclV2iSsx5eyY
 dGFHHRT24IYbqsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F152136F5;
 Mon,  5 Feb 2024 19:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F57BOMs7wWWYQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Feb 2024 19:49:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/6] migration/multifd: Fix channel creation vs. cleanup
 races
Date: Mon,  5 Feb 2024 16:49:23 -0300
Message-Id: <20240205194929.28963-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.80
X-Spamd-Result: default: False [0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.10)[-0.475]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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

Based-on: 20240202102857.110210-1-peterx@redhat.com
[PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com

Hi,

In this v2 I made sure NO channel is created after the semaphores are
posted. Feel free to call me out if that's not the case.

Not much changes, except that now both TLS and non-TLS go through the
same code, so there's a centralized place to do error handling and
releasing the semaphore.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1165206107
based on Peter's code: https://gitlab.com/farosas/qemu/-/pipelines/1165303276

v1:
https://lore.kernel.org/r/20240202191128.1901-1-farosas@suse.de

This contains 2 patches from my previous series addressing the
p->running misuse and the TLS thread leak and 3 new patches to fix the
cleanup-while-creating-threads race.

For the p->running I'm keeping the idea from the other series to
remove p->running and use a more narrow p->thread_created flag. This
flag is used only inform whether the thread has been created so we can
join it.

For the cleanup race I have moved some code around and added a
semaphore to make multifd_save_setup() only return once all channel
creation tasks have started.

The idea is that after multifd_save_setup() returns, no new creations
are in flight and the p->thread_created flags will never change again,
so they're enough to cause the cleanup code to wait for the threads to
join.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1162798843

@Peter: I can rebase this on top of your series once we decide about
it.

Fabiano Rosas (6):
  migration/multifd: Join the TLS thread
  migration/multifd: Remove p->running
  migration/multifd: Move multifd_send_setup error handling in to the
    function
  migration/multifd: Move multifd_send_setup into migration thread
  migration/multifd: Unify multifd and TLS connection paths
  migration/multifd: Add a synchronization point for channel creation

 migration/migration.c |  14 ++--
 migration/multifd.c   | 157 +++++++++++++++++++++++-------------------
 migration/multifd.h   |  11 ++-
 3 files changed, 98 insertions(+), 84 deletions(-)

-- 
2.35.3


