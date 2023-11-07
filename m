Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23047E3373
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CO0-0006K3-RT; Mon, 06 Nov 2023 22:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNx-0006J6-P2
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNv-0000d6-Nz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so39074335ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326250; x=1699931050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QSghWCh0/B7R9F9ofg2fe1rpCsLVBNYGTwryZzXKsFo=;
 b=biIBshsO9hUhDlIEsrW8dBaqk6LWVAq1YRcBVdXQ+Z0XhSTHq3S6rbhXDAkZ08iWyl
 HztHgD7nCy22fQ5nya1nIixKJKtNGgRn39tmto8dzp1wYMXoih5lvhCWsr8Hr35HJlv5
 xl6uwek5RY/HY0ue3W3ZUa8PCLLWpXmHx1Ilhb+eHFVXB7AWUxvpa2VOJwVdAEq+HgU8
 mPMBtREaGgb4hslt1ntfDK2Z0ZR30baI3vkq/KJ7SoDr5DyQqRmlEzf+aIwQcoeID7rA
 CRUCGSszvuLOv1BYI43QLRe6r9G7P6OfhunS2aAxryDcuEpijkTKNzp0cyNy6LYiVfmV
 fghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326250; x=1699931050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSghWCh0/B7R9F9ofg2fe1rpCsLVBNYGTwryZzXKsFo=;
 b=TQXc7PMiLwHmxakvZpTJ+8HW3JkfcnKRqWiDw/vWN5aHyUcVs8dseSOnUH7gR7fqpL
 qhpNr3EbHTqpFG/DQ+nZlpP1j7hcPC6sAGfCytXgWDo4aDp6o4NGfXWx0/Zp69O+v1Lf
 lh1NxbrhJyWUflqhAYm08VUV6v7lbxwlz8OX04YiUDoQGgXE/XVVr/7yESUukXOq9nEm
 qXxRveEDKyVBWS1aTxIbuG6fEvrWOa7WOK1ZLK20ovwbczBV0ASKqBZCeLBPeyvWAw2r
 VQwPtkOoy0r296+c0JeZaUucZk3DsQqXlimsYLnFeyDs9V48dkwsue7OVRTxpP6cYIZg
 bKSQ==
X-Gm-Message-State: AOJu0Yw/FwCMEFXBYB2WbUffSRFnFL8w3IgixG+PXXoFXHfyubMmMNVz
 sM2XbEPJhSQzj4CsGTXjedAHvQynDKH1HFhSlik=
X-Google-Smtp-Source: AGHT+IFLM+HDl6OSike8ku9iHOBeU1pYSYtRMzBMU0v01dnFcRdOivYogV3Jf/AYckt3+5C6hJCh4Q==
X-Received: by 2002:a17:902:d50d:b0:1cc:339e:c228 with SMTP id
 b13-20020a170902d50d00b001cc339ec228mr28001178plg.58.1699326250314; 
 Mon, 06 Nov 2023 19:04:10 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/85] target/hppa: Rename hppa_tlb_entry to HPPATLBEntry
Date: Mon,  6 Nov 2023 19:02:44 -0800
Message-Id: <20231107030407.8979-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Rename to CamelCase per coding style.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  8 ++++----
 target/hppa/machine.c    |  6 +++---
 target/hppa/mem_helper.c | 30 +++++++++++++++---------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 48d735929e..22edfc955d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -174,7 +174,7 @@ typedef int64_t  target_sreg;
 #define TREG_FMT_ld   "%"PRId64
 #endif
 
-typedef struct {
+typedef struct HPPATLBEntry {
     uint64_t va_b;
     uint64_t va_e;
     target_ureg pa;
@@ -188,7 +188,7 @@ typedef struct {
     unsigned ar_pl2 : 2;
     unsigned entry_valid : 1;
     unsigned access_id : 16;
-} hppa_tlb_entry;
+} HPPATLBEntry;
 
 typedef struct CPUArchState {
     target_ureg iaoq_f;      /* front */
@@ -234,7 +234,7 @@ typedef struct CPUArchState {
 
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
-    hppa_tlb_entry tlb[HPPA_TLB_ENTRIES];
+    HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
     uint32_t tlb_last;
 } CPUHPPAState;
 
@@ -362,7 +362,7 @@ void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
-                              hppa_tlb_entry **tlb_entry);
+                              HPPATLBEntry **tlb_entry);
 extern const MemoryRegionOps hppa_io_eir_ops;
 extern const VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 905991d7f9..1d3f9b639d 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -69,7 +69,7 @@ static const VMStateInfo vmstate_psw = {
 static int get_tlb(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field)
 {
-    hppa_tlb_entry *ent = opaque;
+    HPPATLBEntry *ent = opaque;
     uint32_t val;
 
     memset(ent, 0, sizeof(*ent));
@@ -95,7 +95,7 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t size,
 static int put_tlb(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field, JSONWriter *vmdesc)
 {
-    hppa_tlb_entry *ent = opaque;
+    HPPATLBEntry *ent = opaque;
     uint32_t val = 0;
 
     if (ent->entry_valid) {
@@ -153,7 +153,7 @@ static VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32(fr0_shadow, CPUHPPAState),
 
     VMSTATE_ARRAY(tlb, CPUHPPAState, ARRAY_SIZE(((CPUHPPAState *)0)->tlb),
-                  0, vmstate_tlb, hppa_tlb_entry),
+                  0, vmstate_tlb, HPPATLBEntry),
     VMSTATE_UINT32(tlb_last, CPUHPPAState),
 
     VMSTATE_END_OF_LIST()
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 729032288d..a22de81a48 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,12 +25,12 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
-static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
+static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 {
     int i;
 
     for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
-        hppa_tlb_entry *ent = &env->tlb[i];
+        HPPATLBEntry *ent = &env->tlb[i];
         if (ent->va_b <= addr && addr <= ent->va_e) {
             trace_hppa_tlb_find_entry(env, ent + i, ent->entry_valid,
                                       ent->va_b, ent->va_e, ent->pa);
@@ -41,7 +41,7 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
     return NULL;
 }
 
-static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent,
+static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
                                bool force_flush_btlb)
 {
     CPUState *cs = env_cpu(env);
@@ -65,9 +65,9 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent,
     ent->va_b = -1;
 }
 
-static hppa_tlb_entry *hppa_alloc_tlb_ent(CPUHPPAState *env)
+static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 {
-    hppa_tlb_entry *ent;
+    HPPATLBEntry *ent;
     uint32_t i;
 
     if (env->tlb_last < HPPA_BTLB_ENTRIES || env->tlb_last >= ARRAY_SIZE(env->tlb)) {
@@ -86,11 +86,11 @@ static hppa_tlb_entry *hppa_alloc_tlb_ent(CPUHPPAState *env)
 
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
-                              hppa_tlb_entry **tlb_entry)
+                              HPPATLBEntry **tlb_entry)
 {
     hwaddr phys;
     int prot, r_prot, w_prot, x_prot, priv;
-    hppa_tlb_entry *ent;
+    HPPATLBEntry *ent;
     int ret = -1;
 
     if (tlb_entry) {
@@ -231,7 +231,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    hppa_tlb_entry *ent;
+    HPPATLBEntry *ent;
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -275,12 +275,12 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    hppa_tlb_entry *empty = NULL;
+    HPPATLBEntry *empty = NULL;
     int i;
 
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
     for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
-        hppa_tlb_entry *ent = &env->tlb[i];
+        HPPATLBEntry *ent = &env->tlb[i];
         if (ent->va_b <= addr && addr <= ent->va_e) {
             if (ent->entry_valid) {
                 hppa_flush_tlb_ent(env, ent, false);
@@ -303,7 +303,7 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
 }
 
-static void set_access_bits(CPUHPPAState *env, hppa_tlb_entry *ent, target_ureg reg)
+static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg reg)
 {
     ent->access_id = extract32(reg, 1, 18);
     ent->u = extract32(reg, 19, 1);
@@ -321,7 +321,7 @@ static void set_access_bits(CPUHPPAState *env, hppa_tlb_entry *ent, target_ureg
 /* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
 void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
-    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
+    HPPATLBEntry *ent = hppa_find_tlb(env, addr);
 
     if (unlikely(ent == NULL)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
@@ -337,7 +337,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUHPPAState *env = cpu_env(cpu);
     target_ulong addr = (target_ulong) data.target_ptr;
-    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
+    HPPATLBEntry *ent = hppa_find_tlb(env, addr);
 
     if (ent && ent->entry_valid) {
         hppa_flush_tlb_ent(env, ent, false);
@@ -407,7 +407,7 @@ target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
 /* Return the ar_type of the TLB at VADDR, or -1.  */
 int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr)
 {
-    hppa_tlb_entry *ent = hppa_find_tlb(env, vaddr);
+    HPPATLBEntry *ent = hppa_find_tlb(env, vaddr);
     return ent ? ent->ar_type : -1;
 }
 
@@ -422,7 +422,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     unsigned int phys_page, len, slot;
     int mmu_idx = cpu_mmu_index(env, 0);
     uintptr_t ra = GETPC();
-    hppa_tlb_entry *btlb;
+    HPPATLBEntry *btlb;
     uint64_t virt_page;
     uint32_t *vaddr;
 
-- 
2.34.1


