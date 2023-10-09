Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718E7BE9FE
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvE8-0007cu-E3; Mon, 09 Oct 2023 14:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvE6-0007cM-A3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvE4-0000lT-Nl
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E865D1F38D;
 Mon,  9 Oct 2023 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gsi2s4sTWYGAic/y3KaKHieHyCSDpLxuJ5EB3ODMllE=;
 b=xB6sjq24X4O/bK0r9w97MdwryENfcVU4JiwjvK1KeftyL52rBedOy+c2zoM//IAxRWt5oL
 SUofFIIem3MhFSJR7qA3TJ9sMokO3pV4YDBT9dqrVeetpAWXvU/1RtM89xCRxX2wmB2A3Y
 91abEj4s1PM9GpfPCEu0vl7zoExiryk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gsi2s4sTWYGAic/y3KaKHieHyCSDpLxuJ5EB3ODMllE=;
 b=SJDKuxCP1KozBfxbwLyJ+/berO/vaIvvuvzB3PP9DPGOOeJvLo/RPWQxvmp8dCszpIXD/r
 Hf2Y6V6iNlB1UcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3304A13586;
 Mon,  9 Oct 2023 18:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /FtXO9BJJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 0/6] scripts/migration: Fix analyze-migration.py and add a
 test
Date: Mon,  9 Oct 2023 15:43:20 -0300
Message-Id: <20231009184326.15777-1-farosas@suse.de>
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

was: [PATCH] qtest/migration: Add a test for the analyze-migration script
https://lore.kernel.org/r/20230927214756.14117-1-farosas@suse.de

The analyze-migration.py script should be kept in sync with the code
that generates the migration stream. The addition/removal of sections
and flags from the stream can cause the script to break. Issues when
parsing the stream mostly manifest in the form of cryptic python
errors such as:

Looking at git log, it seems that this is a fairly useful script for
people debugging issues with the migration stream. Let's add a test
for it to catch bugs early avoid keeping a broken script in the tree.

People suggested putting this in avocado or a dedicated shell
script. I hope looking at the patches it becomes clear that it's best
to have this along with migration-test. Mostly to avoid duplicating
capabilities code and arch-specific flags.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1030789937

Fabiano Rosas (5):
  migration: Fix analyze-migration.py 'configuration' parsing
  migration: Add capability parsing to analyze-migration.py
  migration: Fix analyze-migration.py when ignore-shared is used
  migration: Fix analyze-migration read operation signedness
  tests/qtest/migration: Add a test for the analyze-migration script

Nikolay Borisov (1):
  migration: Add the configuration vmstate to the json writer

 migration/migration.c        |  1 +
 migration/savevm.c           | 20 ++++++++---
 scripts/analyze-migration.py | 67 ++++++++++++++++++++++++++++++++----
 tests/qtest/meson.build      |  2 ++
 tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 11 deletions(-)

-- 
2.35.3


