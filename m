Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B10AC337A
	for <lists+qemu-devel@lfdr.de>; Sun, 25 May 2025 11:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7qQ-0004Az-1q; Sun, 25 May 2025 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7qN-00049h-Aq; Sun, 25 May 2025 05:40:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7qL-0004Hg-Mi; Sun, 25 May 2025 05:40:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF980124DC8;
 Sun, 25 May 2025 12:40:24 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2F8A215EFA;
 Sun, 25 May 2025 12:40:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Icenowy Zheng <uwu@icenowy.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 20/21] common-user/host/riscv: use tail
 pseudoinstruction for calling tail
Date: Sun, 25 May 2025 12:40:21 +0300
Message-Id: <20250525094025.174507-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250525111620@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250525111620@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Icenowy Zheng <uwu@icenowy.me>

The j pseudoinstruction maps to a JAL instruction, which can only handle
a jump to somewhere with a signed 20-bit destination. In case of static
linking and LTO'ing this easily leads to "relocation truncated to fit"
error.

Switch to use tail pseudoinstruction, which is the standard way to
tail-call a function in medium code model (emits AUIPC+JALR).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250417072206.364008-1-uwu@icenowy.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 22b448ccc6611a59d4aa54419f4d88c1f343cb35)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv/safe-syscall.inc.S
index dfe83c300e..c8b81e33d0 100644
--- a/common-user/host/riscv/safe-syscall.inc.S
+++ b/common-user/host/riscv/safe-syscall.inc.S
@@ -69,11 +69,11 @@ safe_syscall_end:
 
         /* code path setting errno */
 0:      neg     a0, a0
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         /* code path when we didn't execute the syscall */
 2:      li      a0, QEMU_ERESTARTSYS
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         .cfi_endproc
         .size   safe_syscall_base, .-safe_syscall_base
-- 
2.39.5


