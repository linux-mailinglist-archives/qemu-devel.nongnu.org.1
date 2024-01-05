Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37C8259AC
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:05:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoZ6-0006Px-9I; Fri, 05 Jan 2024 13:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ3-0006Oy-4W
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ1-0000ux-B6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76536220AD;
 Fri,  5 Jan 2024 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O67hFbBiLsN4OT8u53p9UuoNb8/tq7lr5M0/3WbT07Y=;
 b=Ukt4y18+TB+M6NSi2ZHvCQQjRqEUM4LyeJ0wjVsTdpKYQksnE3C54Y2PDhLHv2CkaJamNI
 W5ABnhGFhjeu76rGd5TExEM284xX9NBCSKOEjSofgkJCKV2oKUQodgG2dykroS+XeHbRkG
 pdcnRLyeHVWlaN2pCGlhGQCfbNqI7pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O67hFbBiLsN4OT8u53p9UuoNb8/tq7lr5M0/3WbT07Y=;
 b=a8Za7rxYQggYkukaDiL8b3pkZDEYQLLa3nI86Uu9TOpcWIKvaMtlgA9VSjtsBRXEh1nARa
 8qEY7Jdsu5h1hvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O67hFbBiLsN4OT8u53p9UuoNb8/tq7lr5M0/3WbT07Y=;
 b=Ukt4y18+TB+M6NSi2ZHvCQQjRqEUM4LyeJ0wjVsTdpKYQksnE3C54Y2PDhLHv2CkaJamNI
 W5ABnhGFhjeu76rGd5TExEM284xX9NBCSKOEjSofgkJCKV2oKUQodgG2dykroS+XeHbRkG
 pdcnRLyeHVWlaN2pCGlhGQCfbNqI7pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O67hFbBiLsN4OT8u53p9UuoNb8/tq7lr5M0/3WbT07Y=;
 b=a8Za7rxYQggYkukaDiL8b3pkZDEYQLLa3nI86Uu9TOpcWIKvaMtlgA9VSjtsBRXEh1nARa
 8qEY7Jdsu5h1hvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D065F137E8;
 Fri,  5 Jan 2024 18:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FwJJJcREmGXFWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jan 2024 18:04:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 0/4] migration & CI: Add a CI job for migration compat
 testing
Date: Fri,  5 Jan 2024 15:04:45 -0300
Message-Id: <20240105180449.11562-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.51
X-Spamd-Result: default: False [3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.19)[70.71%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Here's the second half of adding a migration compatibility test to CI.

We've already added support for running the full set of migration
tests with two QEMU binaries since commit 5050ad2a380
("tests/qtest/migration: Support more than one QEMU binary"), now
what's left is adding it to the CI.

I included patches that solve the problem of testing older QEMUs with
new test code. The old QEMU might lack features, bug fixes, etc. that
the tests expect to be present. After this series we can specify a
minimal QEMU version that a specific test supports.

changes since v2:
 - fixed version comparison once again

 - removed the 8.2 fixes. We don't need them anymore because we're now
   testing two 8.2 streams (8.2.0 vs. 8.2.50).

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1128168149

v2:
https://lore.kernel.org/r/20240104171857.20108-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20231207155809.25673-1-farosas@suse.de

Fabiano Rosas (4):
  tests/qtest: Add a helper to query the QEMU version
  tests/qtest/migration: Add infrastructure to skip tests on older QEMUs
  ci: Add a migration compatibility test job
  [NOT FOR MERGE] tests/qtest/migration: Adapt tests to use older QEMUs

 tests/qtest/libqtest.h          | 10 ++++++
 tests/qtest/migration-helpers.h |  1 +
 tests/qtest/libqtest.c          | 24 +++++++++++++
 tests/qtest/migration-helpers.c | 48 +++++++++++++++++++++++++
 tests/qtest/migration-test.c    | 63 +++++++++++++++++++++++++++++----
 .gitlab-ci.d/buildtest.yml      | 53 +++++++++++++++++++++++++++
 6 files changed, 192 insertions(+), 7 deletions(-)

-- 
2.35.3


