Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176CA3F6B2
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbB-00087B-Tj; Fri, 21 Feb 2025 09:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWt-0006Vs-In
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWr-00016J-PL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:03 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id BD416204E5BD; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD416204E5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=WQmAzQIs09wjuC0d/dITbHT8nhrCnS/qgIZyixe90jk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eoUxXFd3mHI7SMFwQz5QZPIlZHOmj9mHHrjeowP8tvD0W1uuRt365H1whR9VVMoe2
 NUIypw1n6CMdQjbj+LHJLg02MT+G0GiWvLqKJk/roMVN8cFBbtt+QrXIlE054jBngV
 p1kr9Zx7AItbTrz9EB8zO9VgOgaykAGTdImHYtwQ=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 10/19] taret/i386/hvf: provide and use write_mem in
 emul_ops
Date: Fri, 21 Feb 2025 00:36:18 -0800
Message-Id: <1740126987-8483-11-git-send-email-liuwe@linux.microsoft.com>
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
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:00 -0500
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c     | 6 ++++++
 target/i386/hvf/x86_emu.c | 8 ++++----
 target/i386/hvf/x86_emu.h | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 533b05577d..e108e2bbe6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -242,8 +242,14 @@ static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
     vmx_read_mem(cpu, data, gva, bytes);
 }
 
+static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    vmx_write_mem(cpu, gva, data, bytes);
+}
+
 static const struct x86_emul_ops hvf_x86_emul_ops = {
     .read_mem = hvf_read_mem,
+    .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
 };
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index f1244640e6..ef4b77b10e 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -178,7 +178,7 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
         write_val_to_reg(ptr, val, size);
         return;
     }
-    vmx_write_mem(env_cpu(env), ptr, &val, size);
+    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
 }
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
@@ -488,8 +488,8 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->mmio_buf, 0,
                         decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->mmio_buf,
-                  decode->operand_size);
+    emul_ops->write_mem(env_cpu(env), env->mmio_buf, addr,
+                        decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -595,7 +595,7 @@ static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    vmx_write_mem(env_cpu(env), addr, &val, decode->operand_size);
+    emul_ops->write_mem(env_cpu(env), &val, addr, decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 3bca541bae..a1d1dc7d74 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -25,6 +25,7 @@
 
 struct x86_emul_ops {
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
-- 
2.39.5 (Apple Git-154)


