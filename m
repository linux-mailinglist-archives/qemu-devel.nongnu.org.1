Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D8B1E072
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 04:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCW4-0008Qc-2h; Thu, 07 Aug 2025 22:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVr-00087V-8L
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVl-0003U9-Va
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bde897110so1439753b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618832; x=1755223632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB76hTGMecyehi/uoRAfInFa2pW6hNBiyLO8Wo7oktk=;
 b=EwICLwvqJGYcVwYSy8DZl+1LtGpoJhfkcaLtwjEeFDRWd3XagB4oGju9EL5rohoRkV
 RyCdgreSPDMCVY57EY6ViaWwarFVPnpVu5A9O/ipLHZX4ZWz6rUyCjVPE4kJj/PfCb2E
 56pY8ezTp3Ts9dyoV1DiLhCKFtSxc1urs07dy+at/+TR/C++/tTW60Ks46vxTQjt36pA
 AViSBX6oXwzGAOVd2d/QhD3c3MqP0vKMR2OV85SHMNwpsfa4oll2lQDqS3Ptpkmw3not
 mNDc61qEM5tyqqQpF0ZeR840e9zwYYLXG09tfVLx6xKsJZdPtfTr+9c5o74IQQhHD4DJ
 wV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618832; x=1755223632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB76hTGMecyehi/uoRAfInFa2pW6hNBiyLO8Wo7oktk=;
 b=c+ufeP123PDtcCtf41D/4xo2jHkamSUp12NEJ3a9FgtfDCur7f6XzbKvj7YSvz5CwF
 uLKHKydbH4sSijuD7xhdBoqOJSDJXRgtq1ReU6j4kR2w21NW4Xk8SBa/sdtvHGxLaKnf
 4OvBZq/CQNfDtDjoZeNSErSoM1diNA87dfsQpk6FAS98TzWPc799fsbFqVV9b4iiBISH
 xbBPWMZk1jEN7/hNFUH8R59aNXq2bdQZwh6wcGgOfZv31X2dvmu11Ip2gfBN717XODJ8
 wo4f5vqZ0LGSr7ufVNIJoysEdlGwUEe0VNfo2LG2nglpmAX5b1H4+LDgzS0FKfpDFIl+
 8k0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIRzYdeS42fVhMOboAn242zzGLp3yPU1KsgMth+wJK1q5UOyKwRkzgXeViPY7cJBsZqMWKYSqfrqnU@nongnu.org
X-Gm-Message-State: AOJu0YyyGCsamITRBth6sdPRa6GXboZDexYrqHWOwRFL5mEZt3/sbb5B
 DYKq9EYz8hItA3GpyB9PArtaLzRJ1vTQWfUho4DGP5JE4Y9T4yLk0/kZMLg1aqBCT14=
X-Gm-Gg: ASbGnct7ubkQljBcAlTs+edBNsDyzcg58gNbStYzfKsocYMApQHzwbanVMBFyYLLu6E
 wtDXmcTE2W82ZsPv6Sg1R27Mn7zKZAsnNh5kmekD8rmCKX8mrBc2nmC0NZ8+Cj9Qjt/AHKJlYm4
 v/0qi8xnydRiF+VLup+gHDVK3Pdr7FeY4k3e6mHR+iEo5rvnAPQbBE6a3JDj8E/oZ6RcCoEPk36
 21N30s+mZ1C/eZMMWPxUh1gfizy/rRVzqL+JM3QmYbVn5NxOzjpCm7EdAtMpVWxRj8YB45iH7/6
 MsqRFQEo2/8nutYYuCo1BDavoFFbwmkfSn0C/Itu699FEBuisy49PVKwNzAMUcdXiZmkv16oALk
 0nDWgLTm6z5avxJeMZwgCZg==
X-Google-Smtp-Source: AGHT+IFowEEQjtGcmFoCey0zjA5Em8028eEBDLhC1NKGOlC53Snv+cAPRcMVIl6lXbqH+6M6rjyYQA==
X-Received: by 2002:a05:6a20:748b:b0:235:4a12:6adb with SMTP id
 adf61e73a8af0-240551c9f2bmr1789399637.33.1754618831769; 
 Thu, 07 Aug 2025 19:07:11 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/9] contrib/plugins/uftrace: track callstack
Date: Thu,  7 Aug 2025 19:06:56 -0700
Message-ID: <20250808020702.410109-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We now track callstack, based on frame pointer analysis. We can detect
function calls, returns, and discontinuities.
We implement a frame pointer based unwinding that is used for
discontinuities.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 160 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 4b1a2f38143..d51faceb344 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -15,6 +15,15 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+typedef struct {
+    GArray *s;
+} Callstack;
+
+typedef struct {
+    uint64_t pc;
+    uint64_t frame_pointer;
+} CallstackEntry;
+
 typedef struct Cpu Cpu;
 
 typedef struct {
@@ -25,6 +34,7 @@ typedef struct {
 } CpuOps;
 
 typedef struct Cpu {
+    Callstack *cs;
     GByteArray *buf;
     CpuOps ops;
     void *arch;
@@ -37,6 +47,71 @@ typedef struct {
 static struct qemu_plugin_scoreboard *score;
 static CpuOps arch_ops;
 
+static Callstack *callstack_new(void)
+{
+    Callstack *cs = g_new0(Callstack, 1);
+    cs->s = g_array_new(false, false, sizeof(CallstackEntry));
+    return cs;
+}
+
+static void callstack_free(Callstack *cs)
+{
+    g_array_free(cs->s, true);
+    cs->s = NULL;
+    g_free(cs);
+}
+
+static size_t callstack_depth(const Callstack *cs)
+{
+    return cs->s->len;
+}
+
+static size_t callstack_empty(const Callstack *cs)
+{
+    return callstack_depth(cs) == 0;
+}
+
+static void callstack_clear(Callstack *cs)
+{
+    g_array_set_size(cs->s, 0);
+}
+
+static const CallstackEntry *callstack_at(const Callstack *cs, size_t depth)
+{
+    g_assert(depth > 0);
+    g_assert(depth <= callstack_depth(cs));
+    return &g_array_index(cs->s, CallstackEntry, depth - 1);
+}
+
+static CallstackEntry callstack_top(const Callstack *cs)
+{
+    if (callstack_depth(cs) >= 1) {
+        return *callstack_at(cs, callstack_depth(cs));
+    }
+    return (CallstackEntry){};
+}
+
+static CallstackEntry callstack_caller(const Callstack *cs)
+{
+    if (callstack_depth(cs) >= 2) {
+        return *callstack_at(cs, callstack_depth(cs) - 1);
+    }
+    return (CallstackEntry){};
+}
+
+static void callstack_push(Callstack *cs, CallstackEntry e)
+{
+    g_array_append_val(cs->s, e);
+}
+
+static CallstackEntry callstack_pop(Callstack *cs)
+{
+    g_assert(!callstack_empty(cs));
+    CallstackEntry e = callstack_top(cs);
+    g_array_set_size(cs->s, callstack_depth(cs) - 1);
+    return e;
+}
+
 static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
@@ -47,6 +122,50 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
     return *((uint64_t *) buf->data);
 }
 
+static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
+{
+    g_assert(addr);
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    bool read = qemu_plugin_read_memory_vaddr(addr, buf, 8);
+    if (!read) {
+        return 0;
+    }
+    g_assert(buf->len == 8);
+    return *((uint64_t *) buf->data);
+}
+
+static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
+{
+    g_assert(callstack_empty(cpu->cs));
+
+    #define UNWIND_STACK_MAX_DEPTH 1024
+    CallstackEntry unwind[UNWIND_STACK_MAX_DEPTH];
+    size_t depth = 0;
+    do {
+        /* check we don't have an infinite stack */
+        for (size_t i = 0; i < depth; ++i) {
+            if (frame_pointer == unwind[i].frame_pointer) {
+                break;
+            }
+        }
+        CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
+        unwind[depth] = e;
+        depth++;
+        if (frame_pointer) {
+            frame_pointer = cpu_read_memory64(cpu, frame_pointer);
+        }
+        pc = cpu_read_memory64(cpu, frame_pointer + 8); /* read previous lr */
+    } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
+    #undef UNWIND_STACK_MAX_DEPTH
+
+    /* push it from bottom to top */
+    while (depth) {
+        callstack_push(cpu->cs, unwind[depth - 1]);
+        --depth;
+    }
+}
+
 static struct qemu_plugin_register *plugin_find_register(const char *name)
 {
     g_autoptr(GArray) regs = qemu_plugin_get_registers();
@@ -102,6 +221,43 @@ static CpuOps aarch64_ops = {
 
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
+    uint64_t pc = (uintptr_t) udata;
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    Callstack *cs = cpu->cs;
+
+    uint64_t fp = cpu->ops.get_frame_pointer(cpu);
+    if (!fp && callstack_empty(cs)) {
+        /*
+         * We simply push current pc. Note that we won't detect symbol change as
+         * long as a proper call does not happen.
+         */
+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        return;
+    }
+
+    CallstackEntry top = callstack_top(cs);
+    if (fp == top.frame_pointer) {
+        /* same function */
+        return;
+    }
+
+    CallstackEntry caller = callstack_caller(cs);
+    if (fp == caller.frame_pointer) {
+        /* return */
+        callstack_pop(cs);
+        return;
+    }
+
+    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
+    if (caller_fp == top.frame_pointer) {
+        /* call */
+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        return;
+    }
+
+    /* discontinuity, exit current stack and unwind new one */
+    callstack_clear(cs);
+    cpu_unwind_stack(cpu, fp, pc);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -139,12 +295,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
+
+    cpu->cs = callstack_new();
 }
 
 static void vcpu_end(unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
+
+    callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
 
-- 
2.47.2


