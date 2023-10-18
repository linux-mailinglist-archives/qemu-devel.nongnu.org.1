Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA887CE7BD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCCv-0003GR-2d; Wed, 18 Oct 2023 15:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCCs-0003ER-NZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:50 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCCq-000538-Ql
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14E2621B6E;
 Wed, 18 Oct 2023 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x2HjRfd811KtDTii/XZxalm1QSMi/9lpXLX92+a5oas=;
 b=n0iO2sAYhCvb27DWRiIcgxMaUiFgdbCp2Gxhh2+P0BG9CoAUC+MGn5t85kxgcUNUCgbOBk
 QWn6L1jYupBbluwjllHIFvFjKUwgDSGxhx9YMGHNIxgyMHcmcSeDuV+mwSBUCPxWYpTiQz
 NXbsAuWc10PUAAuE5gBHLpDTZhaeUMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x2HjRfd811KtDTii/XZxalm1QSMi/9lpXLX92+a5oas=;
 b=mC8KtmZyTM86zXjgvIRdMoKGmh0ArqkoL44ptJ4k2faWIP9flNW1NOy4SlaIg2H/e+fmi3
 D/1wQ0VMGSq4MDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D37AB13780;
 Wed, 18 Oct 2023 19:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DdF5Jq8xMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:27:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 00/12] tests/migration-test: Allow testing older machine
 types
Date: Wed, 18 Oct 2023 16:27:29 -0300
Message-Id: <20231018192741.25885-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

(please ignore v3 which was bogus, but don't miss the discussion in it
about the caveats of this approach:
https://lore.kernel.org/r/87jzrkdne2.fsf@suse.de)

This adds support for running migration-test with two different QEMU
versions to test migration compatibility. The tests automatically
choose the latest machine type supported by both QEMU versions.

changes:

- added a cleanup function for the allocated strings in the machine
  list. The suggestion of making a copy of the list won't work because
  keeping the structure around to avoid freeing memory, and caching
  the list are two separate things that only make sense together at
  qtest_get_machines(). Outside of it, code can just free memory
  normally and caching doesn't make sense because there's no QMP call;

- kept strdups for the reasons mentioned above;

- added a message when we're unable to find a common machine type
  (should never happen);

- changed the default x86_64 machine to q35;

- new patch to fix booting with the a-b bootsector on q35;

- added machine_opts for the options after the comma;

- used machine_alias and machine for the variable names;

- added support for specifying the machine type;

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1041561223

v3:
https://lore.kernel.org/r/20231018140736.3618-1-farosas@suse.de

v2:
https://lore.kernel.org/r/20231006123910.17759-1-farosas@suse.de

changes:

- introduce *_with_env variants of the relevant functions [Daniel, Juan]

- keep the requirement for having the QTEST_QEMU_BINARY always
  present. qtest_get_arch() is used extensively in the qtest_add*
  functions. It would be too much churn to pass a different binary
  into it.

- with this^ we also need to keep the requirement for using only one
  of SRC|DST. Otherwise it would be confusing to have three binaries
  listed.

- query the alias to find out the machine types [Daniel]

I haven't looked into the docker part for now. I think Daniel's
suggestion of QTEST_QEMU_BINARY_SRC='podman run ... qemu-system-foo'
looks interesting. Do we have the latest release already built in the
registry at any given point?

Thanks

v1:
https://lore.kernel.org/r/20231003141932.2367-1-farosas@suse.de

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

Fabiano Rosas (12):
  tests/qtest: Allow qtest_qemu_binary to use a custom environment
    variable
  tests/qtest: Introduce qtest_init_with_env
  tests/qtest: Allow qtest_get_machines to use an alternate QEMU binary
  tests/qtest: Introduce qtest_has_machine_with_env
  tests/qtest: Introduce qtest_resolve_machine_alias
  tests/qtest/migration: Introduce find_common_machine_version
  tests/qtest/migration: Define a machine for all architectures
  tests/qtest/migration: Specify the geometry of the bootsector
  tests/qtest/migration: Set q35 as the default machine for x86_86
  tests/qtest/migration: Support more than one QEMU binary
  tests/qtest/migration: Allow user to specify a machine type
  tests/qtest: Don't print messages from query instances

 tests/qtest/libqtest.c          | 98 ++++++++++++++++++++++++++++-----
 tests/qtest/libqtest.h          | 32 +++++++++++
 tests/qtest/migration-helpers.c | 52 +++++++++++++++++
 tests/qtest/migration-helpers.h |  4 ++
 tests/qtest/migration-test.c    | 50 +++++++++++++++--
 5 files changed, 215 insertions(+), 21 deletions(-)

-- 
2.35.3


