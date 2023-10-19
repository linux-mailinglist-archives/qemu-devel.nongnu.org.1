Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24F7D03E4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaQM-0005s6-Rz; Thu, 19 Oct 2023 17:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQL-0005rA-RK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQI-00051T-Ms
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso999885e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750357; x=1698355157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fejYroQSsxnLZIKfcKraO7+R46FW2xsffxb069wCoCk=;
 b=huNWD51/eCLMiYcpAtfNCK3faHAPLcfBRHa5k+wFx+QgaaflRFf5veWrEXPx8JHOVT
 1AbAyU1DGSWEqXVbd7SG3nu0GUVqJOJn8biTZb9KxIiguuVe8SQqn/NOTbmv3qJ+Zm8x
 eFitUUa+Hqd9lgdwUJjr86eNeqxQJuaoEKVUTuJJqSUgxBxXsjRD4yh376vv+do732oD
 zP0/TWnuYokXEdkbrZubAXYAD3RWJsMPYbtyzbjSao9vin+VQNP20NQNwYKVWC68exQq
 D3LvDpiV86vcS849caPMx73hQ2ZJZqj9bra56dsgqdTYZxO5JeqZZTMy36scxLycbxnq
 oRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750357; x=1698355157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fejYroQSsxnLZIKfcKraO7+R46FW2xsffxb069wCoCk=;
 b=dR27Hq6x30sBVRNgFzbBpaLRs8SMzeVmj8Dkc77yQeBBjowTxyhI8C0I0EzGU7gBmj
 qt4Ki10BA9HKZXDTg6NQtaz/BUnYOFOudKUDKhOlCHrJdHA6dC0oaeNoX1sqtwpNFxO2
 MrkltPGTsncPvu7la0T7wk9IpynLvqpxaI3gg2dwmmETMq8kxWLSoR5Vc1Z+1ETuLwC0
 9TXnEtvSYyrJcpmLrQbv3NKC+1bAshGgw/2wtMlceL5kTjYdA1Qhco2YcllNoErX8tR8
 G0hxM2DA/zsk06ZnqUj9fmwJhHCKkwO3WALpwlGwbL244ZAekExP/8BXkLi3Spb8NUtj
 BcOQ==
X-Gm-Message-State: AOJu0YwZ9syVhOX55ASuN0JhLW0eKbr+kfYUn8vyhQOvgApKnVlpsPBm
 7duKL5hX0EhRKcxVveMnXnElWR6FhWMk0ZSZBM8Lag==
X-Google-Smtp-Source: AGHT+IHB0BCBGz71FLJ+5Qj3hw3mtlZMyOMYYAArWiWHpwzcmivH12djbd8eBqXxRjPqQ45qtyaFYg==
X-Received: by 2002:adf:f30b:0:b0:32d:cd02:d4f3 with SMTP id
 i11-20020adff30b000000b0032dcd02d4f3mr2998039wro.40.1697750357189; 
 Thu, 19 Oct 2023 14:19:17 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 n15-20020adfe78f000000b003197869bcd7sm228642wrm.13.2023.10.19.14.19.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:19:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 09/46] memory: follow Error API guidelines
Date: Thu, 19 Oct 2023 23:17:34 +0200
Message-ID: <20231019211814.30576-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Return true/false on success/failure.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231009075310.153617-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h             |  4 +++-
 include/hw/core/sysemu-cpu-ops.h  |  2 +-
 include/sysemu/memory_mapping.h   |  2 +-
 target/i386/cpu.h                 |  2 +-
 hw/core/cpu-sysemu.c              |  6 +++---
 system/memory_mapping.c           | 13 ++++++-------
 target/i386/arch_memory_mapping.c |  6 ++++--
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3968369554..18593db5b2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -618,8 +618,10 @@ bool cpu_paging_enabled(const CPUState *cpu);
  * @cpu: The CPU whose memory mappings are to be obtained.
  * @list: Where to write the memory mappings to.
  * @errp: Pointer for reporting an #Error.
+ *
+ * Returns: %true on success, %false otherwise.
  */
-void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index ee169b872c..24d003fe04 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,7 +19,7 @@ typedef struct SysemuCPUOps {
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
-    void (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
+    bool (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
                                Error **errp);
     /**
      * @get_paging_enabled: Callback for inquiring whether paging is enabled.
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapping.h
index 3bbeb1bcb4..021e0a6230 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -71,7 +71,7 @@ void guest_phys_blocks_free(GuestPhysBlockList *list);
 void guest_phys_blocks_init(GuestPhysBlockList *list);
 void guest_phys_blocks_append(GuestPhysBlockList *list);
 
-void qemu_get_guest_memory_mapping(MemoryMappingList *list,
+bool qemu_get_guest_memory_mapping(MemoryMappingList *list,
                                    const GuestPhysBlockList *guest_phys_blocks,
                                    Error **errp);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1875466b9..471e71dbc5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2055,7 +2055,7 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                                  DumpState *s);
 
-void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index 5eaf2e79e6..d0d6a910f9 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -34,17 +34,17 @@ bool cpu_paging_enabled(const CPUState *cpu)
     return false;
 }
 
-void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
+bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->sysemu_ops->get_memory_mapping) {
-        cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
-        return;
+        return cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
     }
 
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
+    return false;
 }
 
 hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index 8ba9968f8c..6f884c5b90 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -304,10 +304,11 @@ static CPUState *find_paging_enabled_cpu(void)
     return NULL;
 }
 
-void qemu_get_guest_memory_mapping(MemoryMappingList *list,
+bool qemu_get_guest_memory_mapping(MemoryMappingList *list,
                                    const GuestPhysBlockList *guest_phys_blocks,
                                    Error **errp)
 {
+    ERRP_GUARD();
     CPUState *cpu, *first_paging_enabled_cpu;
     GuestPhysBlock *block;
     ram_addr_t offset, length;
@@ -316,14 +317,11 @@ void qemu_get_guest_memory_mapping(MemoryMappingList *list,
     if (first_paging_enabled_cpu) {
         for (cpu = first_paging_enabled_cpu; cpu != NULL;
              cpu = CPU_NEXT(cpu)) {
-            Error *err = NULL;
-            cpu_get_memory_mapping(cpu, list, &err);
-            if (err) {
-                error_propagate(errp, err);
-                return;
+            if (!cpu_get_memory_mapping(cpu, list, errp)) {
+                return false;
             }
         }
-        return;
+        return true;
     }
 
     /*
@@ -335,6 +333,7 @@ void qemu_get_guest_memory_mapping(MemoryMappingList *list,
         length = block->target_end - block->target_start;
         create_new_memory_mapping(list, offset, offset, length);
     }
+    return true;
 }
 
 void qemu_get_guest_simple_memory_mapping(MemoryMappingList *list,
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 271cb5e41b..d1ff659128 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -266,7 +266,7 @@ static void walk_pml5e(MemoryMappingList *list, AddressSpace *as,
 }
 #endif
 
-void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
+bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
                                 Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -275,7 +275,7 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
 
     if (!cpu_paging_enabled(cs)) {
         /* paging is disabled */
-        return;
+        return true;
     }
 
     a20_mask = x86_get_a20_mask(env);
@@ -310,5 +310,7 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
         pse = !!(env->cr[4] & CR4_PSE_MASK);
         walk_pde2(list, cs->as, pde_addr, a20_mask, pse);
     }
+
+    return true;
 }
 
-- 
2.41.0


