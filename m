Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2CA5728E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 20:56:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnM-0007yw-Vp; Fri, 07 Mar 2025 14:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnJ-0007yQ-7a
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:41 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnG-0005hy-Og
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:40 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 2E09D2038F3D; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E09D2038F3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=miv4OPHeMLs6aaNnPGemC0XjqsaIxq0piyStqw2p9Q8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GmV6ClCL04di8di1RZ8M2PHGACxPmMcQ9aXCXUYrbe7axNxWRaDBXM5S1sm1NVAzH
 4y1w0rBXXVhVt9HZkxuK8IGGCYgum95iRyQT5+XkDq0y+hGi5ypozjWtrf6zp4K+hC
 7E419UBjWlKGZja2dTxBPHt8Gn3wRKbkJdwd7ezc=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 03/14] target/i386/hvf: provide and use handle_io in
 emul_ops
Date: Fri,  7 Mar 2025 11:55:14 -0800
Message-Id: <1741377325-28175-4-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
References: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This drops the calls to hvf_handle_io from x86_emu.c.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c     |  1 +
 target/i386/hvf/x86_emu.c | 29 +++++++++++++++--------------
 target/i386/hvf/x86_emu.h |  2 ++
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 03456ffbc705..7da03f9c0811 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -245,6 +245,7 @@ static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 static const struct x86_emul_ops hvf_x86_emul_ops = {
     .read_mem = hvf_read_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
+    .handle_io = hvf_handle_io,
 };
 
 int hvf_arch_init_vcpu(CPUState *cpu)
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index c15b5a7ca850..7b01ccde5d3e 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -396,18 +396,18 @@ static void exec_out(CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->opcode[0]) {
     case 0xe6:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 1, 1, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &AL(env), 1, 1, 1);
         break;
     case 0xe7:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &RAX(env), 1,
-                      decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &RAX(env), 1,
+                            decode->operand_size, 1);
         break;
     case 0xee:
-        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 1, 1, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &AL(env), 1, 1, 1);
         break;
     case 0xef:
-        hvf_handle_io(env_cpu(env), DX(env), &RAX(env), 1,
-                      decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &RAX(env), 1,
+                            decode->operand_size, 1);
         break;
     default:
         VM_PANIC("Bad out opcode\n");
@@ -421,10 +421,10 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
     switch (decode->opcode[0]) {
     case 0xe4:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 0, 1, 1);
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &AL(env), 0, 1, 1);
         break;
     case 0xe5:
-        hvf_handle_io(env_cpu(env), decode->op[0].val, &val, 0,
+        emul_ops->handle_io(env_cpu(env), decode->op[0].val, &val, 0,
                       decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
@@ -433,10 +433,11 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
         }
         break;
     case 0xec:
-        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 0, 1, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &AL(env), 0, 1, 1);
         break;
     case 0xed:
-        hvf_handle_io(env_cpu(env), DX(env), &val, 0, decode->operand_size, 1);
+        emul_ops->handle_io(env_cpu(env), DX(env), &val, 0,
+                            decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
         } else {
@@ -486,8 +487,8 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
-                  decode->operand_size, 1);
+    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
+                        decode->operand_size, 1);
     vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
                   decode->operand_size);
 
@@ -511,8 +512,8 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 
     vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
                  decode->operand_size);
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
-                  decode->operand_size, 1);
+    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
+                        decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
 }
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 1422d06ea184..40cc786694e1 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -27,6 +27,8 @@ struct x86_emul_ops {
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
+    void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
+                      int size, int count);
 };
 
 extern const struct x86_emul_ops *emul_ops;
-- 
2.47.2


