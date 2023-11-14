Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D217EB55A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:07:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wln-000894-3i; Tue, 14 Nov 2023 12:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wli-00082n-Dp; Tue, 14 Nov 2023 12:00:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wlg-0005M2-Jk; Tue, 14 Nov 2023 12:00:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AEB3233277;
 Tue, 14 Nov 2023 19:59:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D286351FE;
 Tue, 14 Nov 2023 19:58:43 +0300 (MSK)
Received: (nullmailer pid 2949124 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH trivial 17/21] target/riscv/cpu.h: spelling fix: separatly
Date: Tue, 14 Nov 2023 19:58:30 +0300
Message-Id: <20231114165834.2949011-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fixes: 40336d5b1d4c "target/riscv: Add HS-mode virtual interrupt and IRQ filtering support."
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/riscv/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bf58b0f0b5..d74b361be6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -214,13 +214,13 @@ struct CPUArchState {
 
     /*
      * When mideleg[i]=0 and mvien[i]=1, sie[i] is no more
-     * alias of mie[i] and needs to be maintained separatly.
+     * alias of mie[i] and needs to be maintained separately.
      */
     uint64_t sie;
 
     /*
      * When hideleg[i]=0 and hvien[i]=1, vsie[i] is no more
-     * alias of sie[i] (mie[i]) and needs to be maintained separatly.
+     * alias of sie[i] (mie[i]) and needs to be maintained separately.
      */
     uint64_t vsie;
 
-- 
2.39.2


