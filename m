Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 113167B6B4A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngG7-00085J-M6; Tue, 03 Oct 2023 10:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qngG0-00084v-S6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:20:17 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qngFz-0005MF-Cw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:20:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE78E1F45B;
 Tue,  3 Oct 2023 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696342809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W7b8o7DC9s2TVZxeM5XJuha5A6qnJo7MhLBsssLe/KY=;
 b=UrOTtbj2SbouegCxyLaKliuH10iknRTn7t1AcT3vf4BjVHwxm4sok/nZPc10QNKyHInDN3
 FZXptn2fPCFV1ZPw067mxoFQ/XiSRCubkQuXnYp6obKqXywbNPjXGNBKvb6aRTBBgd08iv
 b1YNfeYtKzqSchsdozj3zZRcwqQVMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696342809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W7b8o7DC9s2TVZxeM5XJuha5A6qnJo7MhLBsssLe/KY=;
 b=IvTWfFccldhKkDgwfCgIEa6OKKJzGE7oI3EZTAogr86k0SlEx4wewqued6FD4lAZGmbKOZ
 e0xb2/B/3f4xTyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44097139F9;
 Tue,  3 Oct 2023 14:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2760AxgjHGWuUAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 03 Oct 2023 14:20:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/1] tests/migration-test: Allow testing older machine
 types
Date: Tue,  3 Oct 2023 11:19:31 -0300
Message-Id: <20231003141932.2367-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Hi, I had this WIP patch laying around that seems to fit Juan's vision
about testing older machine types. It is a very rough draft for now,
but it may be useful for kickstarting the discussion.

With this we can give the tests two different QEMU versions. The test
picks the older machine type between the two and runs the whole
migration-test suite.

We'd just need a way to provide the older build. Currently I'm doing
this by hand.

sample output:
 # Using two different QEMU binaries. Common machine type: pc-i440fx-8.1
 ...
 # Using ./qemu-system-x86_64 (v8.1.0-952-g8a940312a2-dirty) as migration source
 ...
 # Using ../build-8.1.0/qemu-system-x86_64 (v8.1.0-dirty) as migration destination

Let me know what you think.

Fabiano Rosas (1):
  qtest/migration: Support more than one QEMU binary

 tests/qtest/migration-helpers.c | 168 ++++++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |   3 +
 tests/qtest/migration-test.c    |  52 ++++++++--
 3 files changed, 216 insertions(+), 7 deletions(-)

-- 
2.35.3


