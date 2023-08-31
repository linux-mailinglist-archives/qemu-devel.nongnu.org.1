Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515EC78F2CC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 20:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbma4-0001cc-8P; Thu, 31 Aug 2023 14:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZi-0001Q1-5s
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qbmZf-0002EI-Qr
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 14:39:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A37322184E;
 Thu, 31 Aug 2023 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693507160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4aRw5U2OZALuNTxa7TG2E5cwPWJVuQ46x2iy2ZbnvpI=;
 b=dezZ8WS2Wv/wujS/erwd6QyU1LE0+7uMVYjI7Pd63t66GAP9DaI0wLGJkVASC4xK7neXxU
 JKV6wxADv2rTtvmyUlGxGPAO9WCBMc9eAa5sDHj6TNzkxVQONxWGLf/JIcVsh5dX+8tV9/
 f+JQug7xjKTI7WHPztd9A6M4cVrcq6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693507160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4aRw5U2OZALuNTxa7TG2E5cwPWJVuQ46x2iy2ZbnvpI=;
 b=9kkR54pkhUON53ocFyMfMrnWA6dkmBWDXrQVyL7sGGTs4/s8eaz+0MZXBTanUCftlI+Igc
 0llwx/9whTJct6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 592FF13583;
 Thu, 31 Aug 2023 18:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id muAdCVfe8GQhPgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 31 Aug 2023 18:39:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v5 0/8] Fix segfault on migration return path
Date: Thu, 31 Aug 2023 15:39:08 -0300
Message-Id: <20230831183916.13203-1-farosas@suse.de>
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

What was left from v4 was to figure out how to pair the yank
register/unregister for the QEMUFiles.

I noticed that we don't really need to call unregister_yank under the
lock. We just need to make sure the pointer is still valid. So I went
with Peter's first suggestion which was to call the function
individually for the QIOChannels we know yank is registered.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/988224440

v4:
https://lore.kernel.org/r/20230816142510.5637-1-farosas@suse.de
v3:
https://lore.kernel.org/r/20230811150836.2895-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20230802143644.7534-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20230728121516.16258-1-farosas@suse.de

Fabiano Rosas (8):
  migration: Fix possible race when setting rp_state.error
  migration: Fix possible races when shutting down the return path
  migration: Fix possible race when shutting down to_dst_file
  migration: Remove redundant cleanup of postcopy_qemufile_src
  migration: Consolidate return path closing code
  migration: Replace the return path retry logic
  migration: Move return path cleanup to main migration thread
  migration: Add a wrapper to cleanup migration files

 migration/migration.c      | 231 +++++++++++++------------------------
 migration/migration.h      |   1 -
 migration/yank_functions.c |   5 +
 3 files changed, 88 insertions(+), 149 deletions(-)

-- 
2.35.3


