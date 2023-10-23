Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979037D40F1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1ex-0002iL-Pu; Mon, 23 Oct 2023 16:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1es-0002hz-EB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1eo-0001mY-KN
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 120941FE32;
 Mon, 23 Oct 2023 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wAjnyfkR5anQQOysjvg5DcIaen25L5N/kjABb7QhSrM=;
 b=VfVu14eGyGW+BXNiDGHGK4szME/Buifaey+9ShGcWejZ8cC893J0N93mzYXdQS4IWtVXCt
 u35dHIRr7dAS6vppbRuTH218Ho0i854FOlkhtzxQzXIiNGuNCOMGY9/gHjkAmTpTWIF7TZ
 80EHCzLaKbWaoU9JjUuUw7NIMWdkGPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wAjnyfkR5anQQOysjvg5DcIaen25L5N/kjABb7QhSrM=;
 b=+9Uf25zm5Hpx6GtRLhog1IkBYiwLIXwA7beNihdxlLP369U6RgnQ2ZJSS2FXdMeY7nLjDF
 flzymDOMHbEelWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A645132FD;
 Mon, 23 Oct 2023 20:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8913NTrZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 00/29] migration: File based migration with multifd and
 fixed-ram
Date: Mon, 23 Oct 2023 17:35:39 -0300
Message-Id: <20231023203608.26370-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

Hi,

Here's the migration to file using fixed offsets for each RAM
page. We're calling it fixed-ram migration.

There's 3 big pieces in this series:

1) Fixed-ram: The single-threaded (no multifd) implementation of the
fixed-ram migration. This adds:
  - infrastructure for preadv/pwritev;
  - a bitmap to keep track of which pages are written to the file;
  - a migration header containing fixed-ram-specific information;
  - a capability to enable the feature;
  - the /x86/migration/multifd/file/fixed-ram/* tests.

2) Multifd support: Changes to multifd to support fixed-ram. The main
point here is that we don't need the synchronous parts of multifd,
only the page-queuing, multi-threading and IO is of interest. This
adds:
  - the use_packets() option to skip sending packets when doing fixed-ram;

  - the concept of pages to the receiving side. We want to collect the
    pages from the file using multifd as well.

3) Auto-pause capability: A new capability to allow QEMU to pause the
VM when the type of migration selected would already result in a
paused VM at the end of migration (snapshots, file migration). This is
intended to allow QEMU to implement optimizations for the migration
types that don't need the live migration infrastructure.

The feature is opt-in for new migration code in QEMU, but opt-out for
QEMU users. I.e. new migration code must declare that it supports
auto-pause, but the management layer needs to turn the capability off
to force a live migration.

Thanks

v1:
https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de

Fabiano Rosas (21):
  tests/qtest: Move QTestMigrationState to libqtest
  tests/qtest: Allow waiting for migration events
  migration: Return the saved state from global_state_store
  migration: Introduce global_state_store_once
  migration: Add auto-pause capability
  migration: Run "file:" migration with a stopped VM
  tests/qtest: File migration auto-pause tests
  migration: fixed-ram: Add URI compatibility check
  migration/ram: Introduce 'fixed-ram' migration capability
  migration/multifd: Allow multifd without packets
  migration/multifd: Add outgoing QIOChannelFile support
  migration/multifd: Add incoming QIOChannelFile support
  migration/multifd: Add pages to the receiving side
  io: Add a pwritev/preadv version that takes a discontiguous iovec
  migration/ram: Add a wrapper for fixed-ram shadow bitmap
  migration/ram: Ignore multifd flush when doing fixed-ram migration
  migration/multifd: Support outgoing fixed-ram stream format
  migration/multifd: Support incoming fixed-ram stream format
  tests/qtest: Add a multifd + fixed-ram migration test
  migration: Add direct-io parameter
  tests/qtest: Add a test for migration with direct-io and multifd

Nikolay Borisov (7):
  io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
  io: Add generic pwritev/preadv interface
  io: implement io_pwritev/preadv for QIOChannelFile
  migration/qemu-file: add utility methods for working with seekable
    channels
  migration/ram: Add support for 'fixed-ram' outgoing migration
  migration/ram: Add support for 'fixed-ram' migration restore
  tests/qtest: migration-test: Add tests for fixed-ram file-based
    migration

Steve Sistare (1):
  tests/qtest: migration events

 docs/devel/migration.rst            |  14 ++
 include/exec/ramblock.h             |   8 +
 include/io/channel.h                | 133 ++++++++++++
 include/migration/global_state.h    |   3 +-
 include/migration/qemu-file-types.h |   2 +
 include/qemu/bitops.h               |  13 ++
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |  60 ++++++
 io/channel.c                        | 140 +++++++++++++
 migration/file.c                    | 114 ++++++++--
 migration/file.h                    |  10 +-
 migration/global_state.c            |  20 +-
 migration/migration-hmp-cmds.c      |  10 +
 migration/migration.c               |  55 ++++-
 migration/multifd.c                 | 313 +++++++++++++++++++++++-----
 migration/multifd.h                 |  14 +-
 migration/options.c                 |  79 +++++++
 migration/options.h                 |   5 +
 migration/qemu-file.c               |  80 +++++++
 migration/qemu-file.h               |   4 +
 migration/ram.c                     | 203 +++++++++++++++++-
 migration/ram.h                     |   1 +
 migration/savevm.c                  |   1 +
 qapi/migration.json                 |  26 ++-
 tests/qtest/libqtest.c              |  14 ++
 tests/qtest/libqtest.h              |  25 +++
 tests/qtest/migration-helpers.c     | 108 +++++++---
 tests/qtest/migration-helpers.h     |  10 +-
 tests/qtest/migration-test.c        | 219 ++++++++++++++-----
 util/osdep.c                        |   9 +
 30 files changed, 1520 insertions(+), 175 deletions(-)

-- 
2.35.3


