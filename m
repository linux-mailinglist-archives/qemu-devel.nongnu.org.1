Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8897A0E91
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsOY-0006JQ-UX; Thu, 14 Sep 2023 15:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOX-0006IV-DX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgsOV-0006oP-OF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:52:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52eed139ec2so1536781a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694721174; x=1695325974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lC0eqEcpZkzcebyqzBpj4lWhTpO2Tul/IUzv4m4V3NM=;
 b=YmEhr+zix4f82ecf50zwAaci9Z9aEsISrk4hb/Wg6AfRobG9MTwq2BCUvZGOOZuoL1
 oTdoQWQz4UsVO5HCBgfLgVXl6rhQBSYoCDK/kfGPRECKi8carT26ckLTbhn50Z63kUap
 XOvLZnR3R71IcIYuKZAFbvykZTsNGUNMged5UWTKqX8fci6FqVxlxhZMCwOJ6hyVrix8
 UtgYw+j7gfVvVsIbS4yX+22JLcCHyZJ7mDuQO6rO+syDeruVdKieIHEaoCj+vTfJMpMV
 scJYsW3I9uQ8zt0OUuHOepDRWyab3epAHQU3xpSCtYlVbHZmet5uU2p5Z1wetkk11yzO
 pu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721174; x=1695325974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lC0eqEcpZkzcebyqzBpj4lWhTpO2Tul/IUzv4m4V3NM=;
 b=Z3KshpOR9PlYHrBH4bIfsS6+DCagTGAIwzSbyE15LN8eX53fixB8yIV4ckk5TrREmM
 fT4h7WOkk0GhmRRbvqWWo36mvx48PY1+lcCqDH0kOUPCQs032inq2dMteTm8x4fRywqd
 fAuT2A7Yb5Dj0twit4kEFkJaa4hJa7D6ga8DeH/6gJ6pnKjmn4+Ebcrf8F8DzD+4eYVi
 90xT4/W/k/PQpxWLa4rzzZ/qQl/3JmpmF1PbMKL9NsH7cCLI8MHyBBhwVTqGv+Sf8o4l
 8MK1HpIq4a0msc9ku4d7CoGGqJ5W9tokQHibELOPTCm5miAOVO9ZRJBjEfX6E1FI/l8C
 wg8w==
X-Gm-Message-State: AOJu0YxxX1povpVI2GKx+JOwrIQln9mjlOD/7I7Vc593+sqjQci1dC9L
 sGme4LP20pACcnKwnKffejrXX/5AYk3ZboEcOPI=
X-Google-Smtp-Source: AGHT+IFwUZe+V2eUxtg9kGV8Cdl25J+77hOenL8QToVrM88NUMgWw5fkRyY6jaeKNFoxo2YbWRNqow==
X-Received: by 2002:a05:6402:1355:b0:522:b929:9f01 with SMTP id
 y21-20020a056402135500b00522b9299f01mr5472979edw.9.1694721173836; 
 Thu, 14 Sep 2023 12:52:53 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 ba30-20020a0564021ade00b00525c01f91b0sm1315928edb.42.2023.09.14.12.52.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 12:52:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [RFC PATCH 3/4] accel/tcg: Guard tb_flush() with tcg_enabled() and
 remove the stub
Date: Thu, 14 Sep 2023 21:52:28 +0200
Message-ID: <20230914195229.78244-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914195229.78244-1-philmd@linaro.org>
References: <20230914195229.78244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The check on tcg_enabled() make it clearer we want
this call under TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/tcg-stub.c |  4 ----
 cpu.c                  | 15 +++++++++------
 gdbstub/softmmu.c      |  5 ++++-
 hw/ppc/spapr_hcall.c   |  2 +-
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index dd890d6cf6..7d9846f7f2 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -14,10 +14,6 @@
 #include "exec/tb-flush.h"
 #include "exec/exec-all.h"
 
-void tb_flush(CPUState *cpu)
-{
-}
-
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
diff --git a/cpu.c b/cpu.c
index 0769b0b153..ce3b04f21f 100644
--- a/cpu.c
+++ b/cpu.c
@@ -57,12 +57,15 @@ static int cpu_common_post_load(void *opaque, int version_id)
     cpu->interrupt_request &= ~0x01;
     tlb_flush(cpu);
 
-    /* loadvm has just updated the content of RAM, bypassing the
-     * usual mechanisms that ensure we flush TBs for writes to
-     * memory we've translated code from. So we must flush all TBs,
-     * which will now be stale.
-     */
-    tb_flush(cpu);
+    if (tcg_enabled()) {
+        /*
+         * loadvm has just updated the content of RAM, bypassing the
+         * usual mechanisms that ensure we flush TBs for writes to
+         * memory we've translated code from. So we must flush all TBs,
+         * which will now be stale.
+         */
+        tb_flush(cpu);
+    }
 
     return 0;
 }
diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 9f0b8b5497..edd13f047d 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -21,6 +21,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/runstate.h"
 #include "sysemu/replay.h"
+#include "sysemu/tcg.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
@@ -170,7 +171,9 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         } else {
             trace_gdbstub_hit_break();
         }
-        tb_flush(cpu);
+        if (tcg_enabled()) {
+            tb_flush(cpu);
+        }
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b7dc388f2f..306f8fdf55 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -296,7 +296,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (flags & (H_ICACHE_SYNCHRONIZE | H_ICACHE_INVALIDATE)) {
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
-        } else {
+        } else if (tcg_enabled()) {
             tb_flush(CPU(cpu));
         }
     }
-- 
2.41.0


