Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A37F78B4
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YpF-0008FN-Ph; Fri, 24 Nov 2023 11:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpE-0008F2-5B
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:40 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpC-0001Sn-I6
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF96A21E73;
 Fri, 24 Nov 2023 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700842476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mtGVb8j6K1zHqYAgJi+KNGSDQ97sPw5APY1ey+Irma8=;
 b=rSxdwJx9ogTlHi+TncNwt96byiTNn2XTTxOd6FLYeOlkuSKw4HaHaEdH9hO0Q9i3cErD0y
 F8WJx1pSgpqFG7zeWpOb97FAXmjU8WE7Fwq/q/tbGkopepxbKtRx3cxz33iSpRL12RA1Aj
 yPldQ4Itk1cX1nvF369pZTXYmSeAyIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700842476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mtGVb8j6K1zHqYAgJi+KNGSDQ97sPw5APY1ey+Irma8=;
 b=N35ucjfHmB3kVwupgLv8oL6MeF4Jtr9qYV7ITWVEKBY8uiDNIyf29FenWRUzHyBWM6KVEN
 K4+c/4l3P0htH9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB8613A98;
 Fri, 24 Nov 2023 16:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZYz9DOvLYGXdagAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Nov 2023 16:14:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v1 0/7] migration cleanups and testing improvements
Date: Fri, 24 Nov 2023 13:14:25 -0300
Message-Id: <20231124161432.3515-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 8.54
X-Spamd-Result: default: False [8.54 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.85)[99.38%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
 tests/qtest/migration-test.c    | 201 +++++++++++++++++---------------
 7 files changed, 168 insertions(+), 119 deletions(-)

-- 
2.35.3


