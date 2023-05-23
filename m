Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4E70E783
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Zit-0000HZ-Fz; Tue, 23 May 2023 17:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zir-0000Gt-Gd; Tue, 23 May 2023 17:39:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zip-0004cu-PO; Tue, 23 May 2023 17:39:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0C631FDB8;
 Tue, 23 May 2023 21:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684877948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tl1Ha8/UnXrGmUc3Fh5FuFg4ca4yFMZzzEPaoH5Pt1k=;
 b=04kg//zSlbAdwVF2KFqfYi6FHW4fnJ8V4V5vtpxHsErD2rWIrX5gV98XshYvePlvmZA8h0
 G5nDjwFP6LrP34HHzTxNT3LPso5QPLi7lPqN4LHRhfKTzVaGHK9RX47U9WBcNjNygVd1q4
 dUO6H1zUq93G86D+JMkMtMJSn+HB0Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684877948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tl1Ha8/UnXrGmUc3Fh5FuFg4ca4yFMZzzEPaoH5Pt1k=;
 b=q8K2HRRVOtnb6J1Foxs/Iq7e86FxHiRcV0Y4AKSsMMV3SAlWB7Aq0iB5SMIQ9wb1zS+J9O
 rFV6qCHcF3mAkFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 106EA13588;
 Tue, 23 May 2023 21:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cOjDMnkybWQ7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 21:39:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH 0/6] block: Make raw_co_get_allocated_file_size
 asynchronous
Date: Tue, 23 May 2023 18:38:57 -0300
Message-Id: <20230523213903.18418-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As discussed in another thread [1], here's an RFC addressing a VCPU
softlockup encountered when issuing QMP commands that target a disk
placed on NFS.

Since QMP commands happen with the qemu_global_mutex locked, any
command that takes too long to finish will block other threads waiting
to take the global mutex. One such thread could be a VCPU thread going
out of the guest to handle IO.

This is the case when issuing the QMP command query-block, which
eventually calls raw_co_get_allocated_file_size(). This function makes
an 'fstat' call that has been observed to take a long time (seconds)
over NFS.

NFS latency issues aside, we can improve the situation by not blocking
VCPU threads while the command is running.

Move the 'fstat' call into the thread-pool and make the necessary
adaptations to ensure raw_co_get_allocated_file_size runs in a
coroutine in the block driver aio_context.

1- Question about QMP and BQL
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03141.html

CI run: https://gitlab.com/farosas/qemu/-/pipelines/876583685

Fabiano Rosas (3):
  block: Remove bdrv_query_block_node_info
  block: Mark bdrv_co_get_allocated_file_size() as mixed
  block: Allow bdrv_get_allocated_file_size to run in bdrv context

João Silva (1):
  block: Add a thread-pool version of fstat

Lin Ma (2):
  Convert query-block/info_block to coroutine
  Convert query-block/info_block to coroutine

 block/file-posix.c             | 40 ++++++++++++++++++++++++--
 block/monitor/block-hmp-cmds.c |  2 +-
 block/qapi.c                   | 51 +++++++++++++++-------------------
 blockdev.c                     |  6 ++--
 hmp-commands-info.hx           |  1 +
 include/block/block-hmp-cmds.h |  2 +-
 include/block/block-io.h       |  2 +-
 include/block/qapi.h           |  3 --
 include/block/raw-aio.h        |  4 ++-
 qapi/block-core.json           |  5 ++--
 10 files changed, 72 insertions(+), 44 deletions(-)

-- 
2.35.3


