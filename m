Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9317082EA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdlN-0006Lo-4D; Thu, 18 May 2023 09:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyp-0000Fc-MZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbym-0002Xg-Qn
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f41d087b3bso19468795e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684409971; x=1687001971; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eOz27V0lI0dX2ZuXz8KIfQYa/IppOOHJuB9W329sPI=;
 b=lMNqOU6zGV4tndIicGV3eQuyX02QHa5XXzYsBhW5l8ft76TBjWi542QZBi34ToRzWz
 a7W083eALazlwErB2WgdEfhNgIAjE76PuwZr/BAsf3PysqONi+89vVeePm/mZR0W5gtE
 GpCS2qKL5AUKb/R8kazrmNlntPsDvwBTZHd8lUKnvA8d2gQFe2oYgEu0qsEZl8qupxaC
 DFdrocRvd154vFJqtJRrVWk64MnIXAh59Ag4tutYyojVJ0HnQnIfy29er6l4vRD/pygb
 HxaRakVaSC/ABIlAs1neu+eMKgLPaHGxeHrMAfFIs/KGKVwRiUMOwPTQydqqH4AowKGI
 YhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409971; x=1687001971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eOz27V0lI0dX2ZuXz8KIfQYa/IppOOHJuB9W329sPI=;
 b=UC1Sc0BI+2IGWNAH1I6GQ6ZEZTuLDy7ecReoQTMk3wP+0B6NIcDLaX9LrmdvZewFfr
 Sp9lPqn0qrCvrXOk3qu74L07qUpeISuwTDWd8fVFMfq9Lfchl3Og+5LZh4DNS2F5Nqcm
 d2LeonXQDw1I7/CuyVkVvNndky0GYfFu8mN9HTTcQXY2Xthy12MroxSlgToX4wgydJ/P
 9RtXN3QEYEaDQT6WzLpB+Rbr8JZUrtnQ35aZEuiHV8fnX6RinUlroBbymYhNB4dC+fre
 9Ye8dUdnYJ5nrCo5vQ8pUrwULuXi3imIYdDlobBZ2V206ZpSpwjztDO5M2DFcwT0Hy/T
 kQDw==
X-Gm-Message-State: AC+VfDwbhqqzD6mzMoGFS9S7FmJlysOi59MBjPAdvu7CmJe4BlyQNPJz
 fyfZK9R6r9y9d/udmiowqbtDAw==
X-Google-Smtp-Source: ACHHUZ6199r23dDQdHE2EedKFP59sZaG8oxNrOnvdPnqJDBQET9LrUHNPce8xQfuTsEMGtyepfXenA==
X-Received: by 2002:a1c:7910:0:b0:3f4:27ff:7d54 with SMTP id
 l16-20020a1c7910000000b003f427ff7d54mr1348036wme.3.1684409971518; 
 Thu, 18 May 2023 04:39:31 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1c7406000000b003f4272c2d10sm5083982wmc.1.2023.05.18.04.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:39:31 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH 6/6] target/riscv: Add HS-mode virtual interrupt and IRQ
 filtering support.
Date: Thu, 18 May 2023 12:38:38 +0100
Message-Id: <20230518113838.130084-7-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113838.130084-1-rkanwal@rivosinc.com>
References: <20230518113838.130084-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 May 2023 09:33:46 -0400
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

This change adds support for inserting virtual interrupts from HS-mode
into VS-mode using hvien and hvip csrs. This also allows for IRQ filtering
from HS-mode.

Also, the spec doesn't mandate the interrupt to be actually supported
in hardware. Which allows HS-mode to assert virtual interrupts to VS-mode
that have no connection to any real interrupt events.

This is defined as part of the AIA specification [0], "6.3.2 Virtual
interrupts for VS level".

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.c        |   3 +-
 target/riscv/cpu.h        |  14 +++
 target/riscv/cpu_helper.c |  48 +++++++---
 target/riscv/csr.c        | 196 ++++++++++++++++++++++++++++++++++----
 target/riscv/machine.c    |   3 +
 5 files changed, 234 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9557194a21..c2b05d4c37 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -713,7 +713,8 @@ static bool riscv_cpu_has_work(CPUState *cs)
      * mode and delegation registers, but respect individual enables
      */
     return riscv_cpu_all_pending(env) != 0 ||
-        riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE;
+        riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE ||
+        riscv_cpu_vsirq_pending(env) != RISCV_EXCP_NONE;
 #else
     return true;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 07cf656471..3e10eee38f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -196,6 +196,12 @@ struct CPUArchState {
      */
     uint64_t sie;
 
+    /*
+     * When hideleg[i]=0 and hvien[i]=1, vsie[i] is no more
+     * alias of sie[i] (mie[i]) and needs to be maintained separatly.
+     */
+    uint64_t vsie;
+
     target_ulong satp;   /* since: priv-1.10.0 */
     target_ulong stval;
     target_ulong medeleg;
@@ -230,6 +236,14 @@ struct CPUArchState {
     target_ulong hgeie;
     target_ulong hgeip;
     uint64_t htimedelta;
+    uint64_t hvien;
+
+    /*
+     * Bits VSSIP, VSTIP and VSEIP in hvip are maintained in mip. Other bits
+     * from 0:12 are reserved. Bits 13:63 are not aliased and must be separately
+     * maintain in hvip.
+     */
+    uint64_t hvip;
 
     /* Hypervisor controlled virtual interrupt priorities */
     target_ulong hvictl;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 681b4ae811..80bdd4cf5a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -366,8 +366,9 @@ static int riscv_cpu_pending_to_irq(CPURISCVState *env,
 }
 
 /*
- * Doesn't report interrupts inserted using mvip from M-mode firmware. Those
- * are returned in riscv_cpu_sirq_pending().
+ * Doesn't report interrupts inserted using mvip from M-mode firmware or
+ * using hvip bits 13:63 from HS-mode. Those are returned in
+ * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
  */
 uint64_t riscv_cpu_all_pending(CPURISCVState *env)
 {
@@ -399,16 +400,23 @@ int riscv_cpu_sirq_pending(CPURISCVState *env)
 
 int riscv_cpu_vsirq_pending(CPURISCVState *env)
 {
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg &
-                    (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
+    uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
+    uint64_t vsbits;
+
+    /* Bring VS-level bits to correct position */
+    vsbits = irqs & VS_MODE_INTERRUPTS;
+    irqs &= ~VS_MODE_INTERRUPTS;
+    irqs |= vsbits >> 1;
 
     return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                    irqs >> 1, env->hviprio);
+                                    (irqs | irqs_f_vs), env->hviprio);
 }
 
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
-    uint64_t irqs, pending, mie, hsie, vsie, irqs_f;
+    uint64_t irqs, pending, mie, hsie, vsie, irqs_f, irqs_f_vs;
+    uint64_t vsbits, irq_delegated;
     int virq;
 
     /* Determine interrupt enable state of all privilege modes */
@@ -445,12 +453,26 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
                                         irqs, env->siprio);
     }
 
+    /* Check for virtual VS-mode interrupts. */
+    irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
+
     /* Check VS-mode interrupts */
-    irqs = pending & env->mideleg & env->hideleg & -vsie;
+    irq_delegated = pending & env->mideleg & env->hideleg;
+
+    /* Bring VS-level bits to correct position */
+    vsbits = irq_delegated & VS_MODE_INTERRUPTS;
+    irq_delegated &= ~VS_MODE_INTERRUPTS;
+    irq_delegated |= vsbits >> 1;
+
+    irqs = (irq_delegated | irqs_f_vs) & -vsie;
     if (irqs) {
         virq = riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                        irqs >> 1, env->hviprio);
-        return (virq <= 0) ? virq : virq + 1;
+                                        irqs, env->hviprio);
+        if (virq <= 0 || (virq > 12 && virq <= 63)) {
+            return virq;
+        } else {
+            return virq + 1;
+        }
     }
 
     /* Indicate no pending interrupt */
@@ -625,6 +647,7 @@ void riscv_cpu_interrupt(CPURISCVState *env)
     if (env->virt_enabled) {
         gein = get_field(env->hstatus, HSTATUS_VGEIN);
         vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
+        irqf = env->hvien & env->hvip & env->vsie;
     } else {
         irqf = env->mvien & env->mvip & env->sie;
     }
@@ -1620,6 +1643,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t deleg = async ? env->mideleg : env->medeleg;
     bool s_injected = env->mvip & (1 << cause) & env->mvien &&
         !(env->mip & (1 << cause));
+    bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
+        !(env->mip & (1 << cause));
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1711,12 +1736,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   riscv_cpu_get_trap_name(cause, async));
 
     if (env->priv <= PRV_S && cause < 64 &&
-        (((deleg >> cause) & 1) || s_injected)) {
+        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
         /* handle the trap in S-mode */
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
 
-            if (env->virt_enabled && ((hdeleg >> cause) & 1)) {
+            if (env->virt_enabled &&
+                (((hdeleg >> cause) & 1) || vs_injected)) {
                 /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c1ca065a81..1929d5fa7b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,6 +30,11 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
+
+static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
+                                 uint64_t *ret_val,
+                                 uint64_t new_val, uint64_t wr_mask);
+
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
 {
@@ -1176,6 +1181,8 @@ static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
 static const target_ulong hip_writable_mask = MIP_VSSIP;
 static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
                                     MIP_VSEIP | LOCAL_INTERRUPTS;
+static const target_ulong hvien_writable_mask = LOCAL_INTERRUPTS;
+
 static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
 const bool valid_vm_1_10_32[16] = {
@@ -2584,16 +2591,36 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
 {
+    uint64_t alias_mask = (LOCAL_INTERRUPTS | VS_MODE_INTERRUPTS) &
+                            env->hideleg;
+    uint64_t nalias_mask = LOCAL_INTERRUPTS & (~env->hideleg & env->hvien);
+    uint64_t rval, rval_vs, vsbits;
+    uint64_t wr_mask_vsie;
+    uint64_t wr_mask_mie;
     RISCVException ret;
-    uint64_t rval, mask = env->hideleg & VS_MODE_INTERRUPTS;
 
     /* Bring VS-level bits to correct position */
-    new_val = (new_val & (VS_MODE_INTERRUPTS >> 1)) << 1;
-    wr_mask = (wr_mask & (VS_MODE_INTERRUPTS >> 1)) << 1;
+    vsbits = new_val & (VS_MODE_INTERRUPTS >> 1);
+    new_val &= ~(VS_MODE_INTERRUPTS >> 1);
+    new_val |= vsbits << 1;
+
+    vsbits = wr_mask & (VS_MODE_INTERRUPTS >> 1);
+    wr_mask &= ~(VS_MODE_INTERRUPTS >> 1);
+    wr_mask |= vsbits << 1;
+
+    wr_mask_mie = wr_mask & alias_mask;
+    wr_mask_vsie = wr_mask & nalias_mask;
+
+    ret = rmw_mie64(env, csrno, &rval, new_val, wr_mask_mie);
+
+    rval_vs = env->vsie & nalias_mask;
+    env->vsie = (env->vsie & ~wr_mask_vsie) | (new_val & wr_mask_vsie);
 
-    ret = rmw_mie64(env, csrno, &rval, new_val, wr_mask & mask);
     if (ret_val) {
-        *ret_val = (rval & mask) >> 1;
+        rval &= alias_mask;
+        vsbits = rval & VS_MODE_INTERRUPTS;
+        rval &= ~VS_MODE_INTERRUPTS;
+        *ret_val = rval | (vsbits >> 1) | rval_vs;
     }
 
     return ret;
@@ -2812,15 +2839,26 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
 {
     RISCVException ret;
     uint64_t rval, mask = env->hideleg & VS_MODE_INTERRUPTS;
+    uint64_t vsbits;
 
-    /* Bring VS-level bits to correct position */
-    new_val = (new_val & (VS_MODE_INTERRUPTS >> 1)) << 1;
-    wr_mask = (wr_mask & (VS_MODE_INTERRUPTS >> 1)) << 1;
+    /* Add virtualized bits into vsip mask. */
+    mask |= env->hvien & ~env->hideleg;
 
-    ret = rmw_mip64(env, csrno, &rval, new_val,
-                    wr_mask & mask & vsip_writable_mask);
+    /* Bring VS-level bits to correct position */
+    vsbits = new_val & (VS_MODE_INTERRUPTS >> 1);
+    new_val &= ~(VS_MODE_INTERRUPTS >> 1);
+    new_val |= vsbits << 1;
+    vsbits = wr_mask & (VS_MODE_INTERRUPTS >> 1);
+    wr_mask &= ~(VS_MODE_INTERRUPTS >> 1);
+    wr_mask |= vsbits << 1;
+
+    ret = rmw_hvip64(env, csrno, &rval, new_val,
+                     wr_mask & mask & vsip_writable_mask);
     if (ret_val) {
-        *ret_val = (rval & mask) >> 1;
+        rval &= mask;
+        vsbits = rval & VS_MODE_INTERRUPTS;
+        rval &= ~VS_MODE_INTERRUPTS;
+        *ret_val = rval | (vsbits >> 1);
     }
 
     return ret;
@@ -3112,6 +3150,52 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
+                                    uint64_t *ret_val,
+                                    uint64_t new_val, uint64_t wr_mask)
+{
+    uint64_t mask = wr_mask & hvien_writable_mask;
+
+    if (ret_val) {
+        *ret_val = env->hvien;
+    }
+
+    env->hvien = (env->hvien & ~mask) | (new_val & mask);
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_hvien(CPURISCVState *env, int csrno,
+                               target_ulong *ret_val,
+                               target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t rval;
+    RISCVException ret;
+
+    ret = rmw_hvien64(env, csrno, &rval, new_val, wr_mask);
+    if (ret_val) {
+        *ret_val = rval;
+    }
+
+    return ret;
+}
+
+static RISCVException rmw_hvienh(CPURISCVState *env, int csrno,
+                                   target_ulong *ret_val,
+                                   target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t rval;
+    RISCVException ret;
+
+    ret = rmw_hvien64(env, csrno, &rval,
+        ((uint64_t)new_val) << 32, ((uint64_t)wr_mask) << 32);
+    if (ret_val) {
+        *ret_val = rval >> 32;
+    }
+
+    return ret;
+}
+
 static RISCVException rmw_hideleg64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
@@ -3157,16 +3241,94 @@ static RISCVException rmw_hidelegh(CPURISCVState *env, int csrno,
     return ret;
 }
 
+/*
+ * The function is written for two use-cases:
+ * 1- To access hvip csr as is for HS-mode access.
+ * 2- To access vsip as a combination of hvip, and mip for vs-mode.
+ *
+ * Both report bits 2, 6, 10 and 13:63.
+ * vsip needs to be read-only zero when both hideleg[i] and
+ * hvien[i] are zero.
+ */
 static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
 {
     RISCVException ret;
+    uint64_t old_hvip;
+    uint64_t ret_mip;
+
+    /*
+     * For bits 10, 6 and 2, vsip[i] is an alias of hip[i]. These bits are
+     * present in hip, hvip and mip. Where mip[i] is alias of hip[i] and hvip[i]
+     * is OR'ed in hip[i] to inject virtual interrupts from hypervisor. These
+     * bits are actually being maintained in mip so we read them from there.
+     * This way we have a single source of truth and allows for easier
+     * implementation.
+     *
+     * For bits 13:63 we have:
+     *
+     * hideleg[i]  hvien[i]
+     *   0           0      No delegation. vsip[i] readonly zero.
+     *   0           1      vsip[i] is alias of hvip[i], sip bypassed.
+     *   1           X      vsip[i] is alias of sip[i], hvip bypassed.
+     *
+     *  alias_mask denotes the bits that come from sip (mip here given we
+     *  maintain all bits there). nalias_mask denotes bits that come from
+     *  hvip.
+     */
+    uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;
+    uint64_t nalias_mask = (~env->hideleg & env->hvien);
+    uint64_t wr_mask_hvip;
+    uint64_t wr_mask_mip;
+
+    /*
+     * Both alias and non-alias mask remain same for vsip except:
+     *  1- For VS* bits if they are zero in hideleg.
+     *  2- For 13:63 bits if they are zero in both hideleg and hvien.
+     */
+    if (csrno == CSR_VSIP) {
+        /* zero-out VS* bits that are not delegated to VS mode. */
+        alias_mask &= (env->hideleg | ~VS_MODE_INTERRUPTS);
+
+        /*
+         * zero-out 13:63 bits that are zero in both hideleg and hvien.
+         * nalias_mask mask can not contain any VS* bits so only second
+         * condition applies on it.
+         */
+        nalias_mask &= (env->hideleg | env->hvien);
+        alias_mask &= (env->hideleg | env->hvien);
+    }
+
+    wr_mask_hvip = wr_mask & nalias_mask & hvip_writable_mask;
+    wr_mask_mip = wr_mask & alias_mask & hvip_writable_mask;
+
+    /* Aliased bits, bits 10, 6, 2 need to come from mip. */
+    ret = rmw_mip64(env, csrno, &ret_mip, new_val, wr_mask_mip);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    old_hvip = env->hvip;
+
+    if (wr_mask_hvip) {
+        env->hvip = (env->hvip & ~wr_mask_hvip) | (new_val & wr_mask_hvip);
+
+        /*
+         * Given hvip is separate source from mip, we need to trigger interrupt
+         * from here separately. Normally this happen from riscv_cpu_update_mip.
+         */
+        riscv_cpu_interrupt(env);
+    }
 
-    ret = rmw_mip64(env, csrno, ret_val, new_val,
-                    wr_mask & hvip_writable_mask);
     if (ret_val) {
-        *ret_val &= VS_MODE_INTERRUPTS;
+        /* Only take VS* bits from mip. */
+        ret_mip &= alias_mask;
+
+        /* Take in non-delegated 13:63 bits from hvip. */
+        old_hvip &= nalias_mask;
+
+        *ret_val = ret_mip | old_hvip;
     }
 
     return ret;
@@ -4527,14 +4689,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                           .min_priv_ver = PRIV_VERSION_1_12_0                },
 
     /* Virtual Interrupts and Interrupt Priorities (H-extension with AIA) */
-    [CSR_HVIEN]       = { "hvien",       aia_hmode, read_zero, write_ignore },
+    [CSR_HVIEN]       = { "hvien",       aia_hmode, NULL, NULL, rmw_hvien },
     [CSR_HVICTL]      = { "hvictl",      aia_hmode, read_hvictl,
                           write_hvictl                                      },
     [CSR_HVIPRIO1]    = { "hviprio1",    aia_hmode, read_hviprio1,
                           write_hviprio1                                    },
     [CSR_HVIPRIO2]    = { "hviprio2",    aia_hmode, read_hviprio2,
                           write_hviprio2                                    },
-
     /*
      * VS-Level Window to Indirectly Accessed Registers (H-extension with AIA)
      */
@@ -4549,8 +4710,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Hypervisor and VS-Level High-Half CSRs (H-extension with AIA) */
     [CSR_HIDELEGH]    = { "hidelegh",    aia_hmode32, NULL, NULL,
                           rmw_hidelegh                                      },
-    [CSR_HVIENH]      = { "hvienh",      aia_hmode32, read_zero,
-                          write_ignore                                      },
+    [CSR_HVIENH]      = { "hvienh",      aia_hmode32, NULL, NULL, rmw_hvienh },
     [CSR_HVIPH]       = { "hviph",       aia_hmode32, NULL, NULL, rmw_hviph },
     [CSR_HVIPRIO1H]   = { "hviprio1h",   aia_hmode32, read_hviprio1h,
                           write_hviprio1h                                   },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index dd7bdbb691..3fff230a1c 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -92,6 +92,8 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINTTL(env.hgatp, RISCVCPU),
         VMSTATE_UINTTL(env.hgeie, RISCVCPU),
         VMSTATE_UINTTL(env.hgeip, RISCVCPU),
+        VMSTATE_UINT64(env.hvien, RISCVCPU),
+        VMSTATE_UINT64(env.hvip, RISCVCPU),
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
         VMSTATE_UINT64(env.vstimecmp, RISCVCPU),
 
@@ -106,6 +108,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINTTL(env.vstval, RISCVCPU),
         VMSTATE_UINTTL(env.vsatp, RISCVCPU),
         VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
+        VMSTATE_UINT64(env.vsie, RISCVCPU),
 
         VMSTATE_UINTTL(env.mtval2, RISCVCPU),
         VMSTATE_UINTTL(env.mtinst, RISCVCPU),
-- 
2.25.1


