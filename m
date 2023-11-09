Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1A47E6FC4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:59:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18N1-0000Uw-6X; Thu, 09 Nov 2023 11:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18Mx-0000SY-7F
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r18Mv-00043X-Kz
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:59:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E1671F8B0;
 Thu,  9 Nov 2023 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699549140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RRX53T9Pomzm8l74hcJ0IxFEl+Cu6VysA73syB3Fju8=;
 b=cAt6a7r5bBOEmmz2C4QlyhMURvnamZpEK8GKBbkzCvGhb7Ws0QwQty7wce2+COwG29a7YP
 mMYq0TLsiDW4FE48Hi5Z6JdByCyIralW1tiONKIvFvvXhMxjYYD7iBPKpbZcicqyjwqr9S
 /1juXE2viWZoP9EHnZ5A6JpV5CAgAuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699549140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RRX53T9Pomzm8l74hcJ0IxFEl+Cu6VysA73syB3Fju8=;
 b=zQis+0krCoAzgN0zCYBFLpoEswaJrR9pQAkgwlbvcm20E5U1MZFJysBR2hNBaWYs7jlNEq
 CRAqNLMrq3cCQpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91D0D138E5;
 Thu,  9 Nov 2023 16:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O2QBF9IPTWVXNwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 09 Nov 2023 16:58:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] migration: Fix multifd qemu_mutex_destroy race
Date: Thu,  9 Nov 2023 13:58:54 -0300
Message-Id: <20231109165856.15224-1-farosas@suse.de>
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

We're calling qemu_sem_post() in threads other than the multifd
channel and the migration thread. This is vulnerable to a race with
multifd_save_cleanup() which calls qemu_sem_destroy(). If we attempt
to destroy the semaphore mutex with the lock taken, the code asserts.

We're hitting this in the current master and we've had reports of this
in the past already:

[PATCH] migrate/multifd: fix coredump when the multifd thread cleanup
https://lore.kernel.org/r/20230621081826.3203053-1-zhangjianguo18@huawei.com

Fabiano Rosas (2):
  migration: Report error in incoming migration
  migration/multifd: Move semaphore release into main thread

 migration/migration.c | 11 ++++++++++-
 migration/multifd.c   | 29 +++++++++++------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.35.3


