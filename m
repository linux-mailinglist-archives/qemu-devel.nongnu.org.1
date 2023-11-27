Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB65A7FAB7A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:28:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iBT-0002Px-LT; Mon, 27 Nov 2023 15:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBR-0002OF-ST
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBQ-0002g8-0W
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D39701FB60;
 Mon, 27 Nov 2023 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GcqBd7XCxbMGOe6gXPNFD4KK9St3tAi8yRsYTbv52hA=;
 b=FuGOjR/vWPmed0P0/Tlc3O/B4O6TYEHuzgA60j6tI1O15WemjCjjSQBJ7O+kTGkYEfeZV1
 Ix0Av2bbZB01YLVAI2anBv6ksY1HC7UbZClY7vF7ZW71w31HO15W72NYILIEvSePjIDhJS
 ESvcA2oYIe5tY+0+tY/3ROJGpbpQLaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GcqBd7XCxbMGOe6gXPNFD4KK9St3tAi8yRsYTbv52hA=;
 b=qEu5tgz0QUJNr3Lzqhd5CSL+Gt3u4VXPq01KVie4ed0VX8HMW6oRn2CRoxNn1kyckuNXNR
 TubWAoQcogT9KzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF96D1379A;
 Mon, 27 Nov 2023 20:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ss8jIWb7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 00/30] migration: File based migration with multifd and
 fixed-ram
Date: Mon, 27 Nov 2023 17:25:42 -0300
Message-Id: <20231127202612.23012-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

In this v3:

Added support for the "file:/dev/fdset/" syntax to receive multiple
file descriptors. This allows the management layer to open the
migration file beforehand and pass the file descriptors to QEMU. We
need more than one fd to be able to use O_DIRECT concurrently with
unaligned writes.

Dropped the auto-pause capability. That discussion was kind of
stuck. We can revisit optimizations for non-live scenarios once the
series is more mature/merged.

Changed the multifd incoming side to use a more generic data structure
instead of MultiFDPages_t. This allows multifd to restore the ram
using larger chunks.

The rest are minor changes, I have noted them in the patches
themselves.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1086786947

v2:
https://lore.kernel.org/r/20231023203608.26370-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de

Fabiano Rosas (24):
  io: fsync before closing a file channel
  migration/ram: Introduce 'fixed-ram' migration capability
  migration: Add fixed-ram URI compatibility check
  migration/ram: Add incoming 'fixed-ram' migration
  migration/multifd: Allow multifd without packets
  migration/multifd: Allow QIOTask error reporting without an object
  migration/multifd: Add outgoing QIOChannelFile support
  migration/multifd: Add incoming QIOChannelFile support
  io: Add a pwritev/preadv version that takes a discontiguous iovec
  multifd: Rename MultiFDSendParams::data to compress_data
  migration/multifd: Decouple recv method from pages
  migration/multifd: Allow receiving pages without packets
  migration/ram: Ignore multifd flush when doing fixed-ram migration
  migration/multifd: Support outgoing fixed-ram stream format
  migration/multifd: Support incoming fixed-ram stream format
  tests/qtest: Add a multifd + fixed-ram migration test
  migration: Add direct-io parameter
  tests/qtest: Add a test for migration with direct-io and multifd
  monitor: Honor QMP request for fd removal immediately
  monitor: Extract fdset fd flags comparison into a function
  monitor: fdset: Match against O_DIRECT
  docs/devel/migration.rst: Document the file transport
  migration: Add support for fdset with multifd + file
  tests/qtest: Add a test for fixed-ram with passing of fds

Nikolay Borisov (6):
  io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
  io: Add generic pwritev/preadv interface
  io: implement io_pwritev/preadv for QIOChannelFile
  migration/qemu-file: add utility methods for working with seekable
    channels
  migration/ram: Add outgoing 'fixed-ram' migration
  tests/qtest: migration-test: Add tests for fixed-ram file-based
    migration

 docs/devel/migration.rst            |  43 ++++
 include/exec/ramblock.h             |   8 +
 include/io/channel.h                | 109 ++++++++
 include/migration/qemu-file-types.h |   2 +
 include/qemu/bitops.h               |  13 +
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |  69 +++++
 io/channel.c                        | 128 ++++++++++
 migration/file.c                    | 191 +++++++++++++-
 migration/file.h                    |   5 +
 migration/migration-hmp-cmds.c      |  11 +
 migration/migration.c               |  38 ++-
 migration/multifd-zlib.c            |  22 +-
 migration/multifd-zstd.c            |  22 +-
 migration/multifd.c                 | 376 ++++++++++++++++++++++------
 migration/multifd.h                 |  30 ++-
 migration/options.c                 |  70 ++++++
 migration/options.h                 |   4 +
 migration/qemu-file.c               |  82 ++++++
 migration/qemu-file.h               |   7 +-
 migration/ram.c                     | 291 ++++++++++++++++++++-
 migration/ram.h                     |   1 +
 migration/savevm.c                  |   1 +
 monitor/fds.c                       |  27 +-
 qapi/migration.json                 |  24 +-
 tests/qtest/migration-helpers.c     |  42 ++++
 tests/qtest/migration-helpers.h     |   1 +
 tests/qtest/migration-test.c        | 206 +++++++++++++++
 util/osdep.c                        |   9 +
 29 files changed, 1686 insertions(+), 148 deletions(-)

-- 
2.35.3


