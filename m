Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F34AF74B01A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjia-0007DA-2L; Fri, 07 Jul 2023 07:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiX-00078E-K1; Fri, 07 Jul 2023 07:33:41 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiW-00072a-0P; Fri, 07 Jul 2023 07:33:41 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-19fa4346498so1678630fac.1; 
 Fri, 07 Jul 2023 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729618; x=1691321618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyRl/W7ZNZqVgECRppBCmUJyOD4zjvRr0STjlJCdpG0=;
 b=ocBbeUdv/ZXn0vgVUDNw0gJ7buGeZIBxp/nOufRXXAtFmJPA1O5LaETQ3uNjjhQZkQ
 P4l9QIcg7yYu8M0SkDDIoYWzLMbCicNY5Psrzc8pbLwedisRIsPnLPY9DbSVEKJuu1fp
 ssVQVhVjLAd+xvyjhoJYpDX7MkMFiWyTryv5TTeh8w6DSfd8+MvZplRUAtFHAhiMHc7P
 uiUpc1Sm4NhcOzB9B7vwt8PJznqXXFHYavGO4nj9ujJESDxEcNS1gZ4WmsQM1gvdevE7
 JY81RByiZlQiJ6l0nrecq7AV5upMIxeHC9yByz2HhKsElTWxhLbZinTZk8gUW8SuTI0H
 9vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729618; x=1691321618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyRl/W7ZNZqVgECRppBCmUJyOD4zjvRr0STjlJCdpG0=;
 b=bboWGCWXLW6jPWtf3na+tS40LkGZ5vRpxduomAzgFH3eW1XAnsiIEJCB0gxb67P7qt
 mDInDXZyHaxYwb7m53PUMpsLLuoWQQH1HcHMdbvrAg+++GRGarS54oBpqgiq7gnI6bAC
 5H/0l7E8CX8VwlT008sfpy2VvzimawRtXyLsD1BPagfBZAepERnRLMcTBOcobgDSqkR+
 lHSNiy7IK6tfVbQMh7fT9k4TzG8ndy+86PkeRZtc4LPmDFBDXdQQj8S637kW/zpAT7O0
 i7f4EHwhEbZw+aSvy0poIXbM2gtBNFgJCm2lejByZcYCZpdRJucbElYlraZT2AjWc56T
 th/g==
X-Gm-Message-State: ABy/qLZRsYXG0q0iyOtKZDTsNoAdByY4MKx2tzZjbPYS5ocbm42orgtj
 t62Z/MKX5aQQrPo+nUtVOAT+Cvnn2qs=
X-Google-Smtp-Source: APBJJlG2pzIpt46LXHOcjLoT04BUJWgi2FJsgDFxWFWnyDwyJI5lsac6NM79RLbYgeyVulrblVvMhQ==
X-Received: by 2002:a05:6870:fba7:b0:1b0:3075:2f9d with SMTP id
 kv39-20020a056870fba700b001b030752f9dmr5400269oab.34.1688729618282; 
 Fri, 07 Jul 2023 04:33:38 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 54/60] target/ppc: Reorder #ifdef'ry in kvm_ppc.h
Date: Fri,  7 Jul 2023 08:31:02 -0300
Message-ID: <20230707113108.7145-55-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep a single if/else/endif block checking CONFIG_KVM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230627115124.19632-3-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/kvm_ppc.h | 62 ++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 2e395416f0..49954a300b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -93,7 +93,34 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
 
 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
 
-#else
+#define kvmppc_eieio() \
+    do {                                          \
+        if (kvm_enabled()) {                          \
+            asm volatile("eieio" : : : "memory"); \
+        } \
+    } while (0)
+
+/* Store data cache blocks back to memory */
+static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, int len)
+{
+    uint8_t *p;
+
+    for (p = addr; p < addr + len; p += cpu->env.dcache_line_size) {
+        asm volatile("dcbst 0,%0" : : "r"(p) : "memory");
+    }
+}
+
+/* Invalidate instruction cache blocks */
+static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int len)
+{
+    uint8_t *p;
+
+    for (p = addr; p < addr + len; p += cpu->env.icache_line_size) {
+        asm volatile("icbi 0,%0" : : "r"(p));
+    }
+}
+
+#else /* !CONFIG_KVM */
 
 static inline uint32_t kvmppc_get_tbfreq(void)
 {
@@ -440,10 +467,6 @@ static inline bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
     return false;
 }
 
-#endif
-
-#ifndef CONFIG_KVM
-
 #define kvmppc_eieio() do { } while (0)
 
 static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, int len)
@@ -454,35 +477,6 @@ static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int len)
 {
 }
 
-#else   /* CONFIG_KVM */
-
-#define kvmppc_eieio() \
-    do {                                          \
-        if (kvm_enabled()) {                          \
-            asm volatile("eieio" : : : "memory"); \
-        } \
-    } while (0)
-
-/* Store data cache blocks back to memory */
-static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, int len)
-{
-    uint8_t *p;
-
-    for (p = addr; p < addr + len; p += cpu->env.dcache_line_size) {
-        asm volatile("dcbst 0,%0" : : "r"(p) : "memory");
-    }
-}
-
-/* Invalidate instruction cache blocks */
-static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int len)
-{
-    uint8_t *p;
-
-    for (p = addr; p < addr + len; p += cpu->env.icache_line_size) {
-        asm volatile("icbi 0,%0" : : "r"(p));
-    }
-}
-
 #endif  /* CONFIG_KVM */
 
 #endif /* KVM_PPC_H */
-- 
2.41.0


