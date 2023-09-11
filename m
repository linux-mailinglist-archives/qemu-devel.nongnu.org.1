Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81579AA85
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTh-0002lW-Pk; Mon, 11 Sep 2023 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTg-0002ks-Aw
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTY-00008G-9c
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0215621853;
 Mon, 11 Sep 2023 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4wnevA5jpALeNCM8x6kA1cAdwLqDJ57HnqL9dMnDta0=;
 b=asfqUCXhjVA3sk5MMkXg8Epfxx0JLPT2VIXlzoxE0yxHhAT400kWkrHqs8r8VQLhZ+YFgy
 /mvhNS0jByVBR6DtVaEoWjdjZEZP6r7nfnh3q/GfSXllVmibBwYijJtIWVyrcpApeV2vXy
 Ldn44xRFPJ7LqxRuUSL7SPH8M1xTQDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4wnevA5jpALeNCM8x6kA1cAdwLqDJ57HnqL9dMnDta0=;
 b=4RNF0c1fw9OKIXta5/EumJlzhhchCCwy1iJaJ6mdyCU5cs471AVbwqYy72JnfqKBEZifFt
 j9X1yKY32D4+HgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4820139CC;
 Mon, 11 Sep 2023 17:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zn2GGLNK/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v6 00/10] Fix segfault on migration return path
Date: Mon, 11 Sep 2023 14:13:10 -0300
Message-Id: <20230911171320.24372-1-farosas@suse.de>
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

This version adds migration-specific tracking for the yank functions.

We've estabilished that using the ioc refcount is a layer violation
and that relaxing the abort() on yank.c is undesirable, so we're left
with making the migration code keep track of how many QEMUFiles are
still using the QIOChannel and (consequently) the yank function.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/999810871

v5:
https://lore.kernel.org/r/20230831183916.13203-1-farosas@suse.de
v4:
https://lore.kernel.org/r/20230816142510.5637-1-farosas@suse.de
v3:
https://lore.kernel.org/r/20230811150836.2895-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20230802143644.7534-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20230728121516.16258-1-farosas@suse.de

Fabiano Rosas (10):
  migration: Fix possible race when setting rp_state.error
  migration: Fix possible races when shutting down the return path
  migration: Fix possible race when shutting down to_dst_file
  migration: Remove redundant cleanup of postcopy_qemufile_src
  migration: Consolidate return path closing code
  migration: Replace the return path retry logic
  migration: Move return path cleanup to main migration thread
  migration/yank: Use channel features
  migration/yank: Keep track of registered yank instances
  migration: Add a wrapper to cleanup migration files

 migration/migration.c      | 227 +++++++++++++------------------------
 migration/migration.h      |   1 -
 migration/yank_functions.c |  87 +++++++++++---
 migration/yank_functions.h |   8 ++
 4 files changed, 160 insertions(+), 163 deletions(-)

-- 
2.35.3


