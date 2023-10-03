Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10687B6FC8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF6-0008Tf-TO; Tue, 03 Oct 2023 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEt-0008Ii-JB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEp-0007U1-Ip
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-694ed84c981so924580b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354271; x=1696959071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pt8dQd6UGfaYWBNN9HhM3+Zxek/2pX3pD+IzbngjTFs=;
 b=O773SiyW5ZpFdeC9wwEK/z4IKPIBb2nXGq9Cuv7Y/Sl44p5NYqSx5uDr9iHMWSGJ3G
 BCMgdvc67vgxUqLDkQOsl4+cXVbzwUGrmEtdTFQfcPwULfRNAgUzbsS/Tke86QMVA8Ew
 aHPQyxGje4J/ZZYqTWzC9eEimxLJL4WtLpwXBHMqOi6778jWW97jzDx1l9GUZRYf0xm5
 m32RvwVnF7w/ANBaQ8iIf2Ej+3dYN6aBm1HIDwLfwPtSxLAnWRYYJHJLEnSuawhdwQI8
 UWXigGQ3JazA0uiWjySBSNdBHxWTeqa9ZWkzS/ifbJ8Ru2aKDKa3IFpSH2uUJU+PR+pE
 4rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354271; x=1696959071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pt8dQd6UGfaYWBNN9HhM3+Zxek/2pX3pD+IzbngjTFs=;
 b=SwQAB9EfsIf65eZ+MjoGax4NPXcEfGODPfRr327MKw/25CSnDocFb+j+OUgiyvWtc/
 lvkZeLn4yx+WJyM2cIbF99FizgcR3l6bDyuZOMDpYdceWNmcX26rMVnqWQYPK8p3xuuI
 IDMLt87S43dTMi9nWrrm+LuuxP9yqzVvkZ1E2L1R5t4U8Ko4vzHRVY+OdFX+vWaqqG3b
 yqyXr2U83gREM7N2+bphpoB/2dncORiPrK3zhmKWC0h7381hljJyUXbKR//n6nEXXLP7
 h0u3pPjUM6hpde5au5/HDuNS9lI9kcS9EgL8iOw3RfVljYtBVM4sBSBVsZ4UQrHpRnbu
 q3CQ==
X-Gm-Message-State: AOJu0YzflCM4kZE0HpX0hHDHLRYCn0slS7CrbBCD7uUpsNfFR26auHBM
 ec4hGNWcxMMNTvH9VWXVDBqLNjQfefpQIyAfSfQ=
X-Google-Smtp-Source: AGHT+IHhIWmqfU7Uprb+eSegtP9WiUD7AhQOHXf4A3QnL8ICa3XeQuQRK4kcW0pOZ258+AJZ9Nro2A==
X-Received: by 2002:a05:6a00:b90:b0:690:d5d5:8d24 with SMTP id
 g16-20020a056a000b9000b00690d5d58d24mr247371pfj.20.1696354270764; 
 Tue, 03 Oct 2023 10:31:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 15/47] accel/tcg: Remove CPUState.icount_decr_ptr
Date: Tue,  3 Oct 2023 10:30:20 -0700
Message-Id: <20231003173052.1601813-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

We can now access icount_decr directly.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 include/hw/core/cpu.h  | 2 --
 hw/core/cpu-common.c   | 4 ++--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 0dd32cb0e9..25cd63e1b8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -432,7 +432,6 @@ int cpu_exec(CPUState *cpu);
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
-    cpu->parent_obj.icount_decr_ptr = &cpu->parent_obj.neg.icount_decr;
 }
 
 /* Validate correct placement of CPUArchState. */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 115ddf6d8a..973ff9d106 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -429,7 +429,6 @@ struct qemu_work_item;
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
  * @env_ptr: Pointer to subclass-specific CPUArchState field.
- * @icount_decr_ptr: Pointer to IcountDecr field within subclass.
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
@@ -504,7 +503,6 @@ struct CPUState {
     MemoryRegion *memory;
 
     CPUArchState *env_ptr;
-    IcountDecr *icount_decr_ptr;
 
     CPUJumpCache *tb_jmp_cache;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ced66c2b34..08d5bbc873 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -86,7 +86,7 @@ void cpu_exit(CPUState *cpu)
     qatomic_set(&cpu->exit_request, 1);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
-    qatomic_set(&cpu->icount_decr_ptr->u16.high, -1);
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
 }
 
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
@@ -130,7 +130,7 @@ static void cpu_common_reset_hold(Object *obj)
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
-    qatomic_set(&cpu->icount_decr_ptr->u32, 0);
+    qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->can_do_io = 1;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
-- 
2.34.1


