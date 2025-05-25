Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076BAC3390
	for <lists+qemu-devel@lfdr.de>; Sun, 25 May 2025 11:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7tk-0008Bq-TV; Sun, 25 May 2025 05:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7td-00083c-T7; Sun, 25 May 2025 05:43:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7tc-0004eF-EL; Sun, 25 May 2025 05:43:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2C00124DE6;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CD90215F0E;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 52/62] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
Date: Sun, 25 May 2025 12:42:35 +0300
Message-Id: <20250525094246.174612-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

'reglist' is being g-malloc'ed but never freed.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 906af6de9462c5192547cca0beac2c134659a437)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 3ac9798a57..49a8bc34ca 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1111,10 +1111,10 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
+    g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
     struct kvm_one_reg reg;
     struct kvm_reg_list rl_struct;
-    struct kvm_reg_list *reglist;
     uint64_t val, reg_id, *reg_search;
     int i, ret;
 
-- 
2.39.5


