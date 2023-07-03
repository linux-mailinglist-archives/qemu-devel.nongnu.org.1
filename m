Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA744745F06
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKpi-0003BR-9X; Mon, 03 Jul 2023 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpY-00037z-Ky
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:12 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpW-0007DY-W9
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20C201FEC2;
 Mon,  3 Jul 2023 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688395625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GX4UjFQnpDCIirhMpFxgE9uajBZkvGif++F5Dd4suts=;
 b=w26LVcZRNiRI636DGYS+Ii/lk5X6HRZsxA4ls0vqN70W/9k4ZMnbaG3XlVI+G8tiAb1z3o
 8cslrnpakqSiF9phhaZyzqYdR2zpIIrKOGs6LBhKC9Zx4zhM0Ljl5wl5V1uIOpJg/wYoq5
 oFs+kqe02utc4OYD0+mRk5/DguVKXgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688395625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GX4UjFQnpDCIirhMpFxgE9uajBZkvGif++F5Dd4suts=;
 b=hxiZtSb3xeY6ehKIPCY/d/9XSrjxvLB9EbmF1vJGxku5MB1+sbVrZZD7UOcBpyTtjnzraU
 EdEvEgQrXctxx0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 332861358E;
 Mon,  3 Jul 2023 14:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0quCO2bfomRoSAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 03 Jul 2023 14:47:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] tests/qtest: Run migration subtests via meson
Date: Mon,  3 Jul 2023 11:46:58 -0300
Message-Id: <20230703144700.13536-1-farosas@suse.de>
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

We've had some issues with the migration-test failing in CI and giving
no clue as to which migration sub-test has failed. I think it would be
an improvement to have each subtest listed individually.

With this we can see which migration test has failed, can set timeouts
individually and can run 'make check-migration' to run only the
migration tests.

It does however increase the amount of lines emitted with make check,
so let me know if this is an issue.

I had to include some hacking due to meson, but I think it is simple
enough and worth the benefits.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/919324510

Fabiano Rosas (2):
  tests/qtest: Add a script to gather migration tests list
  tests/qtest: Pass migration tests individually to meson

 .gitlab-ci.d/windows.yml                |  2 +-
 tests/qtest/gen_migration_tests_list.py | 12 ++++++++
 tests/qtest/meson.build                 | 40 +++++++++++++++++++------
 3 files changed, 44 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/gen_migration_tests_list.py

-- 
2.35.3


