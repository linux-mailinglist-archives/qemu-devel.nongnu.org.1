Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CFD8331A4
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySS-0001uW-8H; Fri, 19 Jan 2024 18:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySP-0001s3-Tj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySO-0001xa-3t
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA4B21C1A;
 Fri, 19 Jan 2024 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8tA8YZta+98oXyF8JjF9c6rgBvZkhTQyUJ47bWLuiEQ=;
 b=dl7fU4og85JdACzaLVKT9og2a04pqrVBEvS8s7/dILBbq2748z3CKsM74ugewhINSVLTlO
 WNpkvQYtmN61iOyQmOHfB5bA5rgUo0FCaWRSFGkgAWqwLRG+AYv5RbQU5tsZx3ceivBcMC
 6Wx/m6AUso6tVarvqAvZoB8XOv3dxNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8tA8YZta+98oXyF8JjF9c6rgBvZkhTQyUJ47bWLuiEQ=;
 b=K3/wHaA7OmHyCfAdBVkLfCuWB//vyxexoPGj80e7zEnasnq/stRrwBjwMKLtFcnpT5njaU
 iFctZoYsFMG9WZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8tA8YZta+98oXyF8JjF9c6rgBvZkhTQyUJ47bWLuiEQ=;
 b=dl7fU4og85JdACzaLVKT9og2a04pqrVBEvS8s7/dILBbq2748z3CKsM74ugewhINSVLTlO
 WNpkvQYtmN61iOyQmOHfB5bA5rgUo0FCaWRSFGkgAWqwLRG+AYv5RbQU5tsZx3ceivBcMC
 6Wx/m6AUso6tVarvqAvZoB8XOv3dxNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8tA8YZta+98oXyF8JjF9c6rgBvZkhTQyUJ47bWLuiEQ=;
 b=K3/wHaA7OmHyCfAdBVkLfCuWB//vyxexoPGj80e7zEnasnq/stRrwBjwMKLtFcnpT5njaU
 iFctZoYsFMG9WZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55CA91375D;
 Fri, 19 Jan 2024 23:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7f7pBi0Iq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/5] migration: Fix migration state reference counting
Date: Fri, 19 Jan 2024 20:39:17 -0300
Message-Id: <20240119233922.32588-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.44
X-Spamd-Result: default: False [3.44 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.26)[73.79%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

We currently have a bug when running migration code in bottom
halves. The issue has already been reported in Gitlab[1] and it
started happening very frequently on my machine for some reason.

The issue is that we're dropping the last reference to the
MigrationState object while the cleanup bottom half is still running
and it leads to an use after free. More details on the commit message.

This series fixes the issue and does a refactoring around the
migration BH scheduling aiming to consolidate some code so that it is
less error prone.

1- https://gitlab.com/qemu-project/qemu/-/issues/1969

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1144927625

Fabiano Rosas (5):
  migration: Fix use-after-free of migration state object
  migration: Take reference to migration state around
    bg_migration_vm_start_bh
  migration: Reference migration state around
    loadvm_postcopy_handle_run_bh
  migration: Add a wrapper to qemu_bh_schedule
  migration: Centralize BH creation and dispatch

 migration/migration.c | 82 +++++++++++++++++++++++++------------------
 migration/migration.h |  5 +--
 migration/savevm.c    |  5 +--
 3 files changed, 49 insertions(+), 43 deletions(-)

-- 
2.35.3


