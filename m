Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8277E3319
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Brc-0002jY-Al; Mon, 06 Nov 2023 21:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrW-0002im-T9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:42 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrN-0002Uf-4F
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc3388621cso47725525ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324231; x=1699929031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+OuzrMxYoRanrtTejNPKoMrFDlZh16BMgvfItqAf/A=;
 b=lEplQCPWisVXSCJpQ5tHb8Zkg66gu5hnfvtwpnk4Edz+PezL3RcRrGYjxBdJmtCBk8
 MxGhaXLQ6TU/mmH05nnHHuUf9uRxVKrRZrJxINrIu5ekOoFP+4YAcz3akv/t+a/8149o
 uFToNtUBDWpRVLXIf33zbrhzf9rCnHrHHIQq3dp53i+YtcELLwdTmv3CULURjFxea/s5
 vCx4uiSPB/thD15CKbi6flBwicfO+oU3b3UzHIqJBtESsK+AcCMdYQdXD8+n6GhICWhb
 5YRQIClxdwSxypo/A58lZbueqAn3709Gpo6mFqG2F4HjyYfSYJf8t9BgaguhT9bgCnyf
 1nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324231; x=1699929031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+OuzrMxYoRanrtTejNPKoMrFDlZh16BMgvfItqAf/A=;
 b=jK8gLhIMm5fvIBYWoGPPqCfD8vwZxTm9sJijsLWOYko46qYNq+O8AOAIbZxaEo0Wlj
 aTL9c37Jo+TpUMIrUhscYIaJBU+D+5bkeNbQIGhv4m0+5zEIUQCWWncIDI+5XHYAy+dP
 dXxAGeesFNFYxiWRq9a6gY9JVLjrMCV0V+Viy6zcfkVqYFRw4nglpDWC/m+GjsPBeP7d
 zug9O9EM2askfP4eedS24TIVNGilzuevHkuH8IZ61poTnujbaTgu3mKKeKrhBk6vAfPm
 UZ8DHa8Xg+DlfmgUf0jM3IdJik81ih+1W1Aywlfrsj+LzkSmHWlHwxJhAwqUzrnaDLvO
 /TSg==
X-Gm-Message-State: AOJu0YyqCxodqL8uNuIcK7MaZn0sh0007OCUnNCdR2HU1VCIYumkj1XZ
 JZ76JYfr5ydncLIbHQ3hh6tiYrdGCoZ4Aw==
X-Google-Smtp-Source: AGHT+IG7hIsrczC1+ZSt7yOXjjkqNcmeuhlm07dyZppHzSTpvum74COgcZ82I0ag6sJfGWYjic4jrA==
X-Received: by 2002:a17:903:187:b0:1bc:edd:e891 with SMTP id
 z7-20020a170903018700b001bc0edde891mr1642723plg.1.1699324230926; 
 Mon, 06 Nov 2023 18:30:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/49] target/riscv: Add HS-mode virtual interrupt and IRQ
 filtering support.
Date: Tue,  7 Nov 2023 12:29:06 +1000
Message-ID: <20231107022946.1055027-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

This change adds support for inserting virtual interrupts from HS-mode
into VS-mode using hvien and hvip csrs. This also allows for IRQ filtering
from HS-mode.

Also, the spec doesn't mandate the interrupt to be actually supported
in hardware. Which allows HS-mode to assert virtual interrupts to VS-mode
that have no connection to any real interrupt events.

This is defined as part of the AIA specification [0], "6.3.2 Virtual
interrupts for VS level".

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231016111736.28721-7-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  14 +++
 target/riscv/cpu.c        |   3 +-
 target/riscv/cpu_helper.c |  48 +++++++---
 target/riscv/csr.c        | 196 ++++++++++++++++++++++++++++++++++----
 target/riscv/machine.c    |   7 +-
 5 files changed, 236 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 30f9481f45..7f61e17202 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -208,6 +208,12 @@ struct CPUArchState {
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
@@ -242,6 +248,14 @@ struct CPUArchState {
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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 859ac59c6c..2f98ce56e0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -814,7 +814,8 @@ static bool riscv_cpu_has_work(CPUState *cs)
      * mode and delegation registers, but respect individual enables
      */
     return riscv_cpu_all_pending(env) != 0 ||
-        riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE;
+        riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE ||
+        riscv_cpu_vsirq_pending(env) != RISCV_EXCP_NONE;
 #else
     return true;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b36161708a..b7af69de53 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -377,8 +377,9 @@ static int riscv_cpu_pending_to_irq(CPURISCVState *env,
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
@@ -410,16 +411,23 @@ int riscv_cpu_sirq_pending(CPURISCVState *env)
 
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
@@ -456,12 +464,26 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
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
@@ -638,6 +660,7 @@ void riscv_cpu_interrupt(CPURISCVState *env)
     if (env->virt_enabled) {
         gein = get_field(env->hstatus, HSTATUS_VGEIN);
         vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
+        irqf = env->hvien & env->hvip & env->vsie;
     } else {
         irqf = env->mvien & env->mvip & env->sie;
     }
@@ -1623,6 +1646,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t deleg = async ? env->mideleg : env->medeleg;
     bool s_injected = env->mvip & (1 << cause) & env->mvien &&
         !(env->mip & (1 << cause));
+    bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
+        !(env->mip & (1 << cause));
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1712,12 +1737,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 645f30f028..a5be1c202c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,6 +30,7 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
+
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
 {
@@ -1180,6 +1181,8 @@ static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
 static const target_ulong hip_writable_mask = MIP_VSSIP;
 static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
                                     MIP_VSEIP | LOCAL_INTERRUPTS;
+static const target_ulong hvien_writable_mask = LOCAL_INTERRUPTS;
+
 static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
 const bool valid_vm_1_10_32[16] = {
@@ -2608,16 +2611,36 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
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
@@ -2830,21 +2853,36 @@ static RISCVException write_stval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
+                                 uint64_t *ret_val,
+                                 uint64_t new_val, uint64_t wr_mask);
+
 static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
                                  uint64_t *ret_val,
                                  uint64_t new_val, uint64_t wr_mask)
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
@@ -3136,6 +3174,52 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
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
@@ -3181,16 +3265,94 @@ static RISCVException rmw_hidelegh(CPURISCVState *env, int csrno,
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
@@ -4569,14 +4731,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -4591,8 +4752,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
index f65a95f9e7..14bb2d7819 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -79,8 +79,8 @@ static bool hyper_needed(void *opaque)
 
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = hyper_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL(env.hstatus, RISCVCPU),
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
2.41.0


