Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAA7C8640
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHj2-000476-1i; Fri, 13 Oct 2023 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHiy-0003tC-RL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHiu-0002au-O5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:04 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so3851686a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201819; x=1697806619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMHL7SlFgEKR/BV5pB4UE16riBf0bBquF0WSFLpL7CU=;
 b=lsGUCWnBQzgeVzvpEM80AK15HsCBc86I9+U//ZAYfiSPd/FkFfgGLN4O6n9p1qAHFo
 qcr06dFVvSxZ31O0J/VTQZ0nd+w7m6OeSfQv4M6CwgKhd3fM2KxoZWxBASGpyjGVxLF6
 7u7As1dkIO9+p8VFclBUBYRyfItEv1X/ETLDnH57w6k6dORL9mOvzzL5ci3Xuejd4jQ9
 K2yDnMVYsbzdbuy4hfyFyQFKYhRYjBQ3jwx26bzaMUBh9zkCKFVKTSpRZRR8SxQ93MoK
 3YDZ5+SHjggW6FgmpdJSUxrBwfDd4+M+Bzxn6WLR74hXHPJH5v4A4RbckfhmEl2JD9Ua
 pUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201819; x=1697806619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMHL7SlFgEKR/BV5pB4UE16riBf0bBquF0WSFLpL7CU=;
 b=rkOMH6cb21dQPMSjJeBz2tRie1KbN9QtayKYiFsdT4rXdK5L3hVXX6S28nkTIUCsen
 +4lzV0dUoCzUb/IAj/JOY6D0P2gyH8/s4AFBjpI0KQvUtBp0G6K+f0MKbKDQEbs30FPI
 6+MPPNII0Hes+BUJI/ZAXJKths3CD2MHs+sF3EwXKb7eF7FXeoe0V7T8caB3TQd+oldI
 6jD2cnU4dUH0kisnuo0YbpDJQ4NYbvhiJ6SXVMlOwGOs/LyiIgdnqcIdT3YGdkx5V5cY
 xLJUMx8IE3mQqZfAStqxAJ7Wsp8TD5p4S2mptTqeSQ9YcOwOrDU5L2MxXwf2Zw2crjZ8
 C/5w==
X-Gm-Message-State: AOJu0YwXXr6YFGlHAy98zhbKLwTsdZSWGgR/rjTq18BUgYhDENaS1Zg9
 uZQAojje0dClsldWVQ0sk1rkNYkU9oyjmxfP6A8=
X-Google-Smtp-Source: AGHT+IElywHzfHGdFo9aLzAq9N5cOQvpIK0GcFJQFcG/NJKElObWy3FeLghGIEAGIeA4RPkjtyUmqA==
X-Received: by 2002:a05:6402:1777:b0:53d:bf95:5402 with SMTP id
 da23-20020a056402177700b0053dbf955402mr5089943edb.42.1697201819212; 
 Fri, 13 Oct 2023 05:56:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 h14-20020aa7de0e000000b00532eba07773sm11554780edv.25.2023.10.13.05.56.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:56:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/7] target/ppc: Move PowerPCCPUClass definition to 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:27 +0200
Message-ID: <20231013125630.95116-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

The OBJECT_DECLARE_CPU_TYPE() macro forward-declares the
PowerPCCPUClass type. This forward declaration is sufficient
for code in hw/ to use the QOM definitions. No need to expose
the structure definition. Keep it local to target/ppc/ by
moving it to target/ppc/cpu.h.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/ppc.h |  2 +-
 target/ppc/cpu-qom.h | 56 --------------------------------------------
 target/ppc/cpu.h     | 51 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 17a8dfc107..d5d119ea7f 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -1,7 +1,7 @@
 #ifndef HW_PPC_H
 #define HW_PPC_H
 
-#include "target/ppc/cpu-qom.h"
+#include "target/ppc/cpu.h"
 
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 3dc92a852e..41e97a0ea1 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -21,7 +21,6 @@
 #define QEMU_PPC_CPU_QOM_H
 
 #include "hw/core/cpu.h"
-#include "qom/object.h"
 
 #ifdef TARGET_PPC64
 #define TYPE_POWERPC_CPU "powerpc64-cpu"
@@ -37,10 +36,6 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
-typedef struct CPUArchState CPUPPCState;
-typedef struct ppc_tb_t ppc_tb_t;
-typedef struct ppc_dcr_t ppc_dcr_t;
-
 /*****************************************************************************/
 /* MMU model                                                                 */
 typedef enum powerpc_mmu_t powerpc_mmu_t;
@@ -134,55 +129,4 @@ enum powerpc_input_t {
     PPC_FLAGS_INPUT_RCPU,
 };
 
-typedef struct PPCHash64Options PPCHash64Options;
-
-/**
- * PowerPCCPUClass:
- * @parent_realize: The parent class' realize handler.
- * @parent_phases: The parent class' reset phase handlers.
- *
- * A PowerPC CPU model.
- */
-struct PowerPCCPUClass {
-    /*< private >*/
-    CPUClass parent_class;
-    /*< public >*/
-
-    DeviceRealize parent_realize;
-    DeviceUnrealize parent_unrealize;
-    ResettablePhases parent_phases;
-    void (*parent_parse_features)(const char *type, char *str, Error **errp);
-
-    uint32_t pvr;
-    /*
-     * If @best is false, match if pcc is in the family of pvr
-     * Else match only if pcc is the best match for pvr in this family.
-     */
-    bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr, bool best);
-    uint64_t pcr_mask;          /* Available bits in PCR register */
-    uint64_t pcr_supported;     /* Bits for supported PowerISA versions */
-    uint32_t svr;
-    uint64_t insns_flags;
-    uint64_t insns_flags2;
-    uint64_t msr_mask;
-    uint64_t lpcr_mask;         /* Available bits in the LPCR */
-    uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable bits */
-    powerpc_mmu_t   mmu_model;
-    powerpc_excp_t  excp_model;
-    powerpc_input_t bus_model;
-    uint32_t flags;
-    int bfd_mach;
-    uint32_t l1_dcache_size, l1_icache_size;
-#ifndef CONFIG_USER_ONLY
-    unsigned int gdb_num_sprs;
-    const char *gdb_spr_xml;
-#endif
-    const PPCHash64Options *hash64_opts;
-    struct ppc_radix_page_info *radix_page_info;
-    uint32_t lrg_decr_bits;
-    int n_host_threads;
-    void (*init_proc)(CPUPPCState *env);
-    int  (*check_pow)(CPUPPCState *env);
-};
-
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8bb66fbea4..d521ee97bb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -198,9 +198,14 @@ typedef struct opc_handler_t opc_handler_t;
 /*****************************************************************************/
 /* Types used to describe some PowerPC registers etc. */
 typedef struct DisasContext DisasContext;
+typedef struct ppc_dcr_t ppc_dcr_t;
 typedef struct ppc_spr_t ppc_spr_t;
+typedef struct ppc_tb_t ppc_tb_t;
 typedef union ppc_tlb_t ppc_tlb_t;
 typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
+typedef struct PPCHash64Options PPCHash64Options;
+
+typedef struct CPUArchState CPUPPCState;
 
 /* SPR access micro-ops generations callbacks */
 struct ppc_spr_t {
@@ -1341,6 +1346,52 @@ struct ArchCPU {
     int32_t mig_slb_nr;
 };
 
+/**
+ * PowerPCCPUClass:
+ * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
+ *
+ * A PowerPC CPU model.
+ */
+struct PowerPCCPUClass {
+    CPUClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+    ResettablePhases parent_phases;
+    void (*parent_parse_features)(const char *type, char *str, Error **errp);
+
+    uint32_t pvr;
+    /*
+     * If @best is false, match if pcc is in the family of pvr
+     * Else match only if pcc is the best match for pvr in this family.
+     */
+    bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr, bool best);
+    uint64_t pcr_mask;          /* Available bits in PCR register */
+    uint64_t pcr_supported;     /* Bits for supported PowerISA versions */
+    uint32_t svr;
+    uint64_t insns_flags;
+    uint64_t insns_flags2;
+    uint64_t msr_mask;
+    uint64_t lpcr_mask;         /* Available bits in the LPCR */
+    uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable bits */
+    powerpc_mmu_t   mmu_model;
+    powerpc_excp_t  excp_model;
+    powerpc_input_t bus_model;
+    uint32_t flags;
+    int bfd_mach;
+    uint32_t l1_dcache_size, l1_icache_size;
+#ifndef CONFIG_USER_ONLY
+    unsigned int gdb_num_sprs;
+    const char *gdb_spr_xml;
+#endif
+    const PPCHash64Options *hash64_opts;
+    struct ppc_radix_page_info *radix_page_info;
+    uint32_t lrg_decr_bits;
+    int n_host_threads;
+    void (*init_proc)(CPUPPCState *env);
+    int  (*check_pow)(CPUPPCState *env);
+};
 
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
-- 
2.41.0


