Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9237A32BD
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2s-00056A-A9; Sat, 16 Sep 2023 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2l-00055V-Kd
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:35 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2j-0000Qy-MZ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:34 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57325fcd970so1985680eaf.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900492; x=1695505292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HEEMFcGWCyxqTgAPUxdG/wjpw2eKp2fOJzvzeuqm9E=;
 b=ihi4ZrGwJoUA0KCQtUf7z6VC1n5nkoVp7ugXLmALbBZZvTpJ+rM3le3GEsyZ4+t/ZH
 UV5kDHYDv+qU153oygWmx1Bm49Mn+UnhW1pnCDqj0oTIkR4C/DNjwPco3oK32AVURFH+
 KmJoEy6FcrKW8og3pJuDr0ZeLftBxRoIMWgfXcp8205ytRqnUqjefwofVuT+VS9PDHbw
 N6B/aw4pJmLWQ465+cOd0VU8hNJQPNRcmT70rgSP2MrYnwpAOvlpbnTcGzFckH613WGv
 3Cy2a1fI23oPMA4kWIu8Hz0EGJKiSUnx0lqh9hqq+vnjRcgIh21IsTxMkKFgY5A+9w7x
 nvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900492; x=1695505292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HEEMFcGWCyxqTgAPUxdG/wjpw2eKp2fOJzvzeuqm9E=;
 b=qj3NXZeznmjIj2OTaYvFgTTkrYa6Fi1+CqxKeYpucBuaz7WIyLbJOsA0+ft5uy2/Ku
 xqZbgzDL5/5FrlXbRZVyEya+kBUP93UqUxgCy83Oxuj4eJ+hSOdXeLXFqEzjDKlkzGJY
 5se/ej0/F0jIMsRUKToMib5C8aUAgKmkASgmqqa9oYFHRpXaKLGTA2ljaE+/jt8JyJZO
 O4a4qYM1MAfB1dKj+DPdcDaqjiKtHvtwUaWZr9yOMEkmaGSq67B9B4uZCpqyiTYHKNX/
 xEMHWC8Z2PJ0GQrmb5aRSzENrDByigBmqJ9lHpO2MwjWbQAtC3AaMN2LgxJ7eS4mVoAg
 VrdQ==
X-Gm-Message-State: AOJu0YxwANNQApSkTUEx+/NnaIAIIqIwiqCEMq86EgMiI9zfyuhD6w2q
 ezgkckYqUyujxVmmNiFSdf/m6MXwczKCYWNDy9I=
X-Google-Smtp-Source: AGHT+IF7MkPq+iitWogy7NUgfjckz2J//JOxxg6H1fd9Dm4vLtLkwRy8gGk2O/fABggREf9wIHdJtQ==
X-Received: by 2002:a05:6358:9389:b0:142:fd2b:d30c with SMTP id
 h9-20020a056358938900b00142fd2bd30cmr5866353rwb.23.1694900492427; 
 Sat, 16 Sep 2023 14:41:32 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 08/39] accel/tcg: Remove CPUState.icount_decr_ptr
Date: Sat, 16 Sep 2023 14:40:52 -0700
Message-Id: <20230916214123.525796-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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
index 165a271642..94fe80c979 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -434,7 +434,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
-    cpu->parent_obj.icount_decr_ptr = &cpu->parent_obj.neg.icount_decr;
 }
 
 /* Validate correct placement of CPUArchState. */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ed1bf8dbf1..4609cf1ae0 100644
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


