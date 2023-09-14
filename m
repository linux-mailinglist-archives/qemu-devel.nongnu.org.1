Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2679F869
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLa-0000dW-VT; Wed, 13 Sep 2023 22:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLY-0000cU-HM
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLW-0000gc-F0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c336f3f449so3736415ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659485; x=1695264285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSI6jMDyGvSeRKAEMOfAI3CC7dsAbVaOANUJ8Ij2cAM=;
 b=WpqQRwm9KzpxEoHZcb3KzAYt4paeRjBEcT3xKoY8XKks6EJw0BoTwEhCOsrDSJSLyD
 szdk53mEL9z9WwKZ3FuHOD9pz9q/dBIwHjqVmb5ZRgiwGHuw8hApk56MPXLPJNagqyO6
 +02FVAMZYidtDZ+kCSfTKKsiQJ1z4oBLp34RLFCsZfNnlsC+QV3ANx9aWagGm/hPJW7d
 KigWNV3n65vWUd9YU9/N8Aek4arGZsjeyNoUlgaVarC36SXqOE5FPcbMl+rccPDVEn4Y
 bMd3zqJ3wDp8RQUffMJQHcQxZGP6Jum3sT1wEciJPFJtSE4IsQgT1M0/X9OuWSq0wGQh
 cJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659485; x=1695264285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSI6jMDyGvSeRKAEMOfAI3CC7dsAbVaOANUJ8Ij2cAM=;
 b=E9IM6pbTP4WV8qxTt4j9LoUpYGQKA9goQJwxsJdNie71VBt34ZFVJ9Hyq+s4WTLe2J
 Nhr49PN4YRAt4L/mM/5E5y5Fzv9Wts3Y75fYpCaUxpLe57hcc2zenAHCB07H/VZP1hI3
 70F14iY8rhFeXJaEBvv+dCn3T7fK/vdvmhpguiu0hAfRtnocOGjO4HCWXwhyTtyDylhU
 o+F6lkbxLjLdWPcJknze7z1JM3StJrxOgqrnx2IzrrsGc3H1SB0QYyDR38Ta0etzXoq0
 5pbJjjEUE/PZIfs3SvycXLklgKroHrosDn7pFsPpdYfhADu3kelEXlQwm6SF84YCdTLL
 RVfg==
X-Gm-Message-State: AOJu0YxXuImOYNv+QgooXzQUoiAnKLnresP56wkrCZoXSYfTchcuTkNC
 wkbYhkyrxnPOYiW5uLiiMYbH+1KDsMf/ivD0n7Y=
X-Google-Smtp-Source: AGHT+IEZsSFqH4ZrbKRF1AkBGLopbc+XeHURNZDwGXHrj67DrNeVOUSoUnH415WynWLwn/Qy9ZOR/A==
X-Received: by 2002:a17:902:cec4:b0:1bb:ce4a:5893 with SMTP id
 d4-20020a170902cec400b001bbce4a5893mr5771520plg.30.1694659484979; 
 Wed, 13 Sep 2023 19:44:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 09/24] accel/tcg: Remove CPUState.icount_decr_ptr
Date: Wed, 13 Sep 2023 19:44:20 -0700
Message-Id: <20230914024435.1381329-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 include/hw/core/cpu.h  | 2 --
 hw/core/cpu-common.c   | 4 ++--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c3c78ed8ab..3b01e4ee25 100644
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
index 1f289136ec..44955af3bc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -440,7 +440,6 @@ struct qemu_work_item;
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
  * @env_ptr: Pointer to subclass-specific CPUArchState field.
- * @icount_decr_ptr: Pointer to IcountDecr field within subclass.
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
@@ -512,7 +511,6 @@ struct CPUState {
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


