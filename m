Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CD7A50FE
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI32-0006lh-Hz; Mon, 18 Sep 2023 13:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI2w-0006k4-CN
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI2t-0004Ry-Rh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5EE921F2D;
 Mon, 18 Sep 2023 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695058105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MAEC0EDj8pm2jcF6lwKXv7yxPTYAPdRop/Jtlnu6s9A=;
 b=P5gO+R+b3iZhBWUgq8oMH/BRJf3DFnfdkushvfGSwJQ65mDtpbPG4O8itjRKMx8PnLGfh3
 9Xo1gNeSL2nVFdmGq2dyIsGBf0pnuo4O36+jD1SIjE2gxyf9g5Dza8ajcgRFDXpVR9Ibr2
 l5S50/3e7OEExdAmsZQ8kKCRRhkyjIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695058105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MAEC0EDj8pm2jcF6lwKXv7yxPTYAPdRop/Jtlnu6s9A=;
 b=H7mvwvt+uDDOyvGXXSHQuhjgE47nUu3RZrl92jt9ccP+cm+NY5ZniCoscbGSN5ycx7KAHu
 ha9f1PTapuvs5RBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C9741358A;
 Mon, 18 Sep 2023 17:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F4X1GLiICGUoGAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:28:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/8] migration fixes
Date: Mon, 18 Sep 2023 14:28:14 -0300
Message-Id: <20230918172822.19052-1-farosas@suse.de>
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

This series contains fixes for the two currently know failures that
show up in migration tests plus a set of fixes for some theoretical
race conditions around QEMUFile handling.

Patch 1 addresses the issue found in the postcopy/preempt/plain test:
https://gitlab.com/qemu-project/qemu/-/issues/1886

Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain test:

  Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
      0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
      154         return f->last_error;

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837

Fabiano Rosas (7):
  migration: Fix possible race when setting rp_state.error
  migration: Fix possible races when shutting down the return path
  migration: Fix possible race when shutting down to_dst_file
  migration: Remove redundant cleanup of postcopy_qemufile_src
  migration: Consolidate return path closing code
  migration: Replace the return path retry logic
  migration: Move return path cleanup to main migration thread

Peter Xu (1):
  migration: Fix race that dest preempt thread close too early

 migration/migration.c    | 145 +++++++++++++++------------------------
 migration/migration.h    |  14 +++-
 migration/postcopy-ram.c |  38 +++++++++-
 3 files changed, 106 insertions(+), 91 deletions(-)

-- 
2.35.3


