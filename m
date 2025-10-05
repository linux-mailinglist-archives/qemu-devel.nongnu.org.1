Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D0BB945A
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 08:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5If7-0004mr-1n; Sun, 05 Oct 2025 02:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Iey-0004lc-Vb; Sun, 05 Oct 2025 02:55:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Iev-0007vr-Bx; Sun, 05 Oct 2025 02:55:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B704015A8E5;
 Sun, 05 Oct 2025 09:55:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5587829947A;
 Sun,  5 Oct 2025 09:55:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/8] Trivial patches for 2025-10-05
Date: Sun,  5 Oct 2025 09:55:28 +0300
Message-ID: <20251005065538.436862-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit bd6aa0d1e59d71218c3eee055bc8d222c6e1a628:

  Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-10-04 09:10:58 -0700)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 0af5926a0feb0b69a127f5c24eaa605408fed2ec:

  system/runstate: remove duplicate in runstate transitions (2025-10-05 09:46:06 +0300)

----------------------------------------------------------------
trivial patches for 2025-10-05

Just a bunch of tiny fixes everywhere.

----------------------------------------------------------------
Filip Hejsek (1):
      ui/gtk: Fix callback function signature

Marco Cavenati (1):
      system/runstate: remove duplicate in runstate transitions

Michael Tokarev (1):
      vhost-user-test: remove trailing newlines in g_test_message() calls

Peter Maydell (1):
      docs/specs/spdm.rst: Fix typo in x86_64 architecture name

ShengYi Hung (2):
      hid: fix incorrect return value for hid
      wdt_i6300esb: fix incorrect mask for interrupt type

SillyZ (1):
      hw/net/can: Remove redundant status bit setting in can_sja1000

nanliu (1):
      docs/devel: Correct uefi-vars-x64 device name

 docs/devel/uefi-vars.rst      |  4 ++--
 docs/specs/spdm.rst           |  2 +-
 hw/input/hid.c                |  1 +
 hw/net/can/can_sja1000.c      |  1 -
 hw/watchdog/wdt_i6300esb.c    |  2 +-
 system/runstate.c             |  4 +---
 tests/qtest/vhost-user-test.c | 14 +++++++-------
 ui/gtk.c                      |  4 ++--
 8 files changed, 15 insertions(+), 17 deletions(-)

