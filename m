Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF616726590
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vmy-0004kH-N2; Wed, 07 Jun 2023 12:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6vmh-0004j2-UG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:13:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6vmc-0001M4-8m
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:13:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57F171FDB2;
 Wed,  7 Jun 2023 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686154391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47PSzAM6ByJ+JnwZix2edGS4IVcu44SF/ttfq9G+3Po=;
 b=tFrh4mQ7Mco+BuoSjJPFeivdFAFu7J/TaoB9qBHsF5OIHPpLUCIu/gM7oKIA+U7ZxqHemS
 7nfKrJp0jWi4DPVeQ5T5yg4Mc+r0G6wCWC8/Mzt8poIoZSTK3QC6oLrtW+NizRLSAWzYfI
 8MLRN2ZvHzUFibIbht7E74ucowwJWvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686154391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47PSzAM6ByJ+JnwZix2edGS4IVcu44SF/ttfq9G+3Po=;
 b=VzRrArFTwHeFEct8kWcQsaT+zNyQpLoBKbt4G4k70YGz4TOStmuwUFWpbStbTog6OwSJ82
 z8857n30CStDzhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FA2213776;
 Wed,  7 Jun 2023 16:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VVpGDZWsgGSfRgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 07 Jun 2023 16:13:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 0/3] migration: Fix multifd cancel test
Date: Wed,  7 Jun 2023 13:13:03 -0300
Message-Id: <20230607161306.31425-1-farosas@suse.de>
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

v2:
- patch 1: dropped the qmp_ prefix;

- patch 2: dropped the qemu_mutex_destroy;

	   stopped moving the _remove functions (don't strictly need it
           anymore since not destroying the mutex explicitly);

	   added the lock to protect the loop in
	   qmp_query_migrationthreads;

	   added __attribute__((constructor)).

CI run: https://gitlab.com/farosas/qemu/-/pipelines/892563231

v1:
https://lore.kernel.org/r/20230606144551.24367-1-farosas@suse.de

When doing cleanup of the multifd send threads we're calling
QLIST_REMOVE concurrently on the migration_threads list. This seems to
be the source of the crashes we've seen on the
multifd/tcp/plain/cancel tests.

I'm running the test in a loop and after a few dozen iterations I see
the crash in dmesg.

  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
  QEMU_TEST_FLAKY_TESTS=1 \
  ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/cancel

  multifdsend_10[11382]: segfault at 18 ip 0000564b77de1e25 sp
  00007fdf767fb610 error 6 in qemu-system-x86_64[564b777b4000+e1c000]
  Code: ec 10 48 89 7d f8 48 83 7d f8 00 74 58 48 8b 45 f8 48 8b 40 10
  48 85 c0 74 14 48 8b 45 f8 48 8b 40 10 48 8b 55 f8 48 8b 52 18 <48> 89
  50 18 48 8b 45 f8 48 8b 40 18 48 8b 55 f8 48 8b 52 10 48 89

the offending instruction is a mov dereferencing the
thread->node.le_next pointer at QLIST_REMOVE in MigrationThreadDel:

  void MigrationThreadDel(MigrationThread *thread)
  {
      if (thread) {
          QLIST_REMOVE(thread, node);
          g_free(thread);
      }
  }

where:
  #define QLIST_REMOVE(elm, field) do {                   \
          if ((elm)->field.le_next != NULL)               \
                  (elm)->field.le_next->field.le_prev =   \ <-- HERE
                      (elm)->field.le_prev;               \
          *(elm)->field.le_prev = (elm)->field.le_next;   \
          (elm)->field.le_next = NULL;                    \
          (elm)->field.le_prev = NULL;                    \
  } while (/*CONSTCOND*/0)

The MigrationThreadDel function is called from the multifd threads and
is not under any lock, so several calls can race when accessing the
list.

(I actually hit this first on my fixed-ram branch which changes some
synchronization in multifd and makes the issue more frequent)

CI run: https://gitlab.com/farosas/qemu/-/pipelines/891000519

Fabiano Rosas (3):
  migration/multifd: Rename threadinfo.c functions
  migration/multifd: Protect accesses to migration_threads
  tests/qtest: Re-enable multifd cancel test

 migration/migration.c        |  4 ++--
 migration/multifd.c          |  4 ++--
 migration/threadinfo.c       | 19 ++++++++++++++++---
 migration/threadinfo.h       |  7 ++-----
 tests/qtest/migration-test.c | 10 ++--------
 5 files changed, 24 insertions(+), 20 deletions(-)

-- 
2.35.3


