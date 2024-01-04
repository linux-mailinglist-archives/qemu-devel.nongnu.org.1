Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A68243AC
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:23:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOc3-0001Li-FS; Thu, 04 Jan 2024 09:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc1-0001LI-Ie
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLObz-0008UZ-56
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D659F1F814;
 Thu,  4 Jan 2024 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+M8hpWCZSRHakpkPJLXsLslueaCgeKuxkEmbx9C5k4=;
 b=mTBwhTuvMOOMf+SZs4/retD+qPjPmFN3OAQcXXaQigsn9e7N+MIWDWjXG8RJpIIrS4l8rH
 mWlU6VdqaoD+UDl0oSzgqAX2LzKbjT3uunhenpGOJF1YGWfLVyWZuaTfvjcr2d/6c4ZLLG
 0bCWXWT7lQKuujHRgj9Lg+F/JM5Frx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+M8hpWCZSRHakpkPJLXsLslueaCgeKuxkEmbx9C5k4=;
 b=IFYtXwP7s7mm7qilNnhJWgV6o06vOmfiEABW5IN5dbbp7jn2uTwQGxLL6MSU8rtC+GJXNs
 /MjT/q6rAbwTp0Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+M8hpWCZSRHakpkPJLXsLslueaCgeKuxkEmbx9C5k4=;
 b=mTBwhTuvMOOMf+SZs4/retD+qPjPmFN3OAQcXXaQigsn9e7N+MIWDWjXG8RJpIIrS4l8rH
 mWlU6VdqaoD+UDl0oSzgqAX2LzKbjT3uunhenpGOJF1YGWfLVyWZuaTfvjcr2d/6c4ZLLG
 0bCWXWT7lQKuujHRgj9Lg+F/JM5Frx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G+M8hpWCZSRHakpkPJLXsLslueaCgeKuxkEmbx9C5k4=;
 b=IFYtXwP7s7mm7qilNnhJWgV6o06vOmfiEABW5IN5dbbp7jn2uTwQGxLL6MSU8rtC+GJXNs
 /MjT/q6rAbwTp0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3876137E8;
 Thu,  4 Jan 2024 14:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P53jKRe/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 0/7] migration cleanups and testing improvements
Date: Thu,  4 Jan 2024 11:21:37 -0300
Message-Id: <20240104142144.9680-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.73
X-Spamd-Result: default: False [4.73 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.17)[69.71%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

No change, just rebased on latest migration PR:

[PULL 00/26] Migration 20240104 patches
https://lore.kernel.org/r/20240104043213.431566-1-peterx@redhat.com

v1:
https://lore.kernel.org/r/20231124161432.3515-1-farosas@suse.de

These are some general cleanups and improvements to testing and
debugging that I collected over the past month.

Fabiano Rosas (7):
  migration/multifd: Remove MultiFDPages_t::packet_num
  migration/multifd: Remove QEMUFile from where it is not needed
  migration/multifd: Change multifd_pages_init argument
  migration: Report error in incoming migration
  tests/qtest/migration: Print migration incoming errors
  tests/qtest/migration: Add a wrapper to print test names
  tests/qtest/migration: Use the new migration_test_add

 migration/migration.c           |   7 ++
 migration/multifd.c             |  19 ++-
 migration/multifd.h             |   6 +-
 migration/ram.c                 |  15 ++-
 tests/qtest/migration-helpers.c |  38 ++++++
 tests/qtest/migration-helpers.h |   1 +
 tests/qtest/migration-test.c    | 215 +++++++++++++++++---------------
 7 files changed, 176 insertions(+), 125 deletions(-)

-- 
2.35.3


