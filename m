Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A87E8355
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XiQ-00021I-Ew; Fri, 10 Nov 2023 15:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiK-0001yI-Tx
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r1XiJ-0004bd-8L
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:02:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08212219B2;
 Fri, 10 Nov 2023 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699646565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZXX+6EFbIwN1A5TtRW0vUsnttmRUbTPgjIIiJ5wDYUg=;
 b=ktJms19WmWnzLf4qJ4byxnlWD8D9WTEB0BrzbZaxVrwVzfeYuQ7GYdZB5vuuhKEecIojh1
 PfSMDTdz5596TUBwWuB17cV5inl5lSrxugG817d5ePE9uhrf6KkRuk8uKjuanOMptCF0cV
 mf2ATc/0EBeuf9BFv7UevZuioASYcNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699646565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZXX+6EFbIwN1A5TtRW0vUsnttmRUbTPgjIIiJ5wDYUg=;
 b=poeSZLeSwz+Vg5wfwhjzBh7bNHMCT0v8srZFzkBfWXBY/zsd6dIlLWdF7lx/ipH7z3D+k3
 g7RGEV7jsDu0xsBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86601138FC;
 Fri, 10 Nov 2023 20:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3bdVFGOMTmWiaQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 10 Nov 2023 20:02:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 0/4] migration: Fix multifd qemu_mutex_destroy race
Date: Fri, 10 Nov 2023 17:02:37 -0300
Message-Id: <20231110200241.20679-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

changes:
- dropped the Error patch
- removed p->running
- joined the TLS thread

v1:
https://lore.kernel.org/r/20231109165856.15224-1-farosas@suse.de

We're calling qemu_sem_post() in threads other than the multifd
channel and the migration thread. This is vulnerable to a race with
multifd_save_cleanup() which calls qemu_sem_destroy(). If we attempt
to destroy the semaphore mutex with the lock taken, the code asserts.

We're hitting this in the current master and we've had reports of this
in the past already:

[PATCH] migrate/multifd: fix coredump when the multifd thread cleanup
https://lore.kernel.org/r/20230621081826.3203053-1-zhangjianguo18@huawei.com

Fabiano Rosas (4):
  migration/multifd: Stop setting p->ioc before connecting
  migration/multifd: Join the TLS thread
  migration/multifd: Remove p->running
  migration/multifd: Move semaphore release into main thread

 migration/migration.c |  4 +-
 migration/multifd.c   | 87 +++++++++++++++++++++++--------------------
 migration/multifd.h   |  9 ++---
 3 files changed, 53 insertions(+), 47 deletions(-)

-- 
2.35.3


