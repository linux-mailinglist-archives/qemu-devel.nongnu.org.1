Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B9A3F6BA
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbf-0000Zh-7N; Fri, 21 Feb 2025 09:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWl-0006SU-TW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:57 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWg-000166-66
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:55 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id B0120204E5BC; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0120204E5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=24jpQ3ywdwX2kk6QPe3nYALV/cxBiKoSuAeM+PYw2BQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=of6fa+gHTxrppVmYplSNhm34no/CdFhgX92j3CkVccwrfWLVm4X30tXfR4Cm6CAbu
 AXX7kMbNP2FY9WMn76/F5sP5d8Y1T3VfpWByCHmMEAOAydwflEGySCnd/bL/w7vDIM
 F7tDklfIN2cKmU1teXZLUTzaa/rH6mazwKlX1ycg=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 09/19] target/i386/hvf: use emul_ops->read_mem in
 x86_emu.c
Date: Fri, 21 Feb 2025 00:36:17 -0800
Message-Id: <1740126987-8483-10-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:00:57 -0500
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

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86_emu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index d0a8e221ea..f1244640e6 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -183,7 +183,7 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->mmio_buf, ptr, bytes);
+    emul_ops->read_mem(env_cpu(env), env->mmio_buf, ptr, bytes);
     return env->mmio_buf;
 }
 
@@ -509,8 +509,8 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->mmio_buf, addr,
-                 decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), env->mmio_buf, addr,
+                       decode->operand_size);
     emul_ops->handle_io(env_cpu(env), DX(env), env->mmio_buf, 1,
                         decode->operand_size, 1);
 
@@ -619,7 +619,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    vmx_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -644,7 +644,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    vmx_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.39.5 (Apple Git-154)


