Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DB7C5B8C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeDn-0001BT-II; Wed, 11 Oct 2023 14:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDk-0000z8-0C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDh-0003eE-6E
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 043681F37C;
 Wed, 11 Oct 2023 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697049968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b+0DjIVgc36E0ANdDDYa89QSF3kE77hBKE0H/Sq14Vs=;
 b=yIjlcs3eAt7ZNyue+fTQY6QXFvS+upSq6DMgtUS7Zfka6Nh8yFhoRT7wH7jNk+3s2OXxCz
 ycqE/2RzNE3oaz5jO0zWXCkLTe2dA65TOOif81v5dKpWfved+lCeDycMR6Uz+qtpNsna8p
 VtaSbC3F4UGJYKVIWtwGiv23W8QEetM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697049968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b+0DjIVgc36E0ANdDDYa89QSF3kE77hBKE0H/Sq14Vs=;
 b=5+GKYj9nNxcJ1LYLKKCkPR5BIa63an17ni/v3KJamQHivFPiJyDU15AHOOfHBJCRQjri7x
 wEIzAHb+x6QuiuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E782E134F5;
 Wed, 11 Oct 2023 18:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lKU8LG7tJmU1bQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 18:46:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH RESEND 0/7] migration pending patches
Date: Wed, 11 Oct 2023 15:45:57 -0300
Message-Id: <20231011184604.32364-1-farosas@suse.de>
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

Hi, this is a resend of a few patches that lingered behind in the past
months. They are all reviewed and tested.

patch 1 is the test for the file transport which missed the last pull;

patches 2-6 are two small refactorings to ram.c that are prerequisite
for the fixed ram work;

patch 7 enables the multifd cancel test which has been fixed for a
while now since commit 01ec0f3a92 ("migration/multifd: Protect
accesses to migration_threads").

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1033679993

Thanks!

Fabiano Rosas (6):
  tests/qtest: migration-test: Add tests for file-based migration
  migration/ram: Remove RAMState from xbzrle_cache_zero_page
  migration/ram: Stop passing QEMUFile around in save_zero_page
  migration/ram: Move xbzrle zero page handling into save_zero_page
  migration/ram: Merge save_zero_page functions
  tests/qtest: Re-enable multifd cancel test

Nikolay Borisov (1):
  migration/ram: Refactor precopy ram loading code

 migration/ram.c              | 216 ++++++++++++++++++-----------------
 tests/qtest/migration-test.c | 157 +++++++++++++++++++++++--
 2 files changed, 258 insertions(+), 115 deletions(-)

-- 
2.35.3


