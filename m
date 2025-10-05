Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1FBB9A4C
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 19:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Sg4-0000Hb-Fc; Sun, 05 Oct 2025 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfr-0000C8-Tv; Sun, 05 Oct 2025 13:37:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfq-0004c8-1s; Sun, 05 Oct 2025 13:37:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8857F15AA87;
 Sun, 05 Oct 2025 20:37:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 430AD299734;
 Sun,  5 Oct 2025 20:37:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrea Bolognani <abologna@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 45/58] docs/interop/firmware: Add riscv64 to
 FirmwareArchitecture
Date: Sun,  5 Oct 2025 20:36:54 +0300
Message-ID: <20251005173712.445160-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Andrea Bolognani <abologna@redhat.com>

Descriptors using this value have been shipped for years
by distros, so we just need to update the spec to match
reality.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20250910121501.676219-1-abologna@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit da14767b356c2342197708a997eeb0da053262a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 745d21d822..ea88da0fec 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -76,12 +76,14 @@
 #
 # @loongarch64: 64-bit LoongArch. (since: 7.1)
 #
+# @riscv64: 64-bit RISC-V.
+#
 # @x86_64: 64-bit x86.
 #
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareArchitecture',
-  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'riscv64', 'x86_64' ] }
 
 ##
 # @FirmwareTarget:
-- 
2.47.3


