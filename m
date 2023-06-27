Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479B73FB6D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Ec-0001uE-IT; Tue, 27 Jun 2023 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EW-0001s8-HZ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:45 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7ET-0004jc-Eu
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-991fe70f21bso133754666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866699; x=1690458699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EM+qSWWOslftV8HcBXpILD27b+3+W5mkalItnU32xI=;
 b=zK/wO1TEMHYu1s8XH1PAIG4ggr3gqj0hxpHfpqqesgDccWWASPBRBwTqjxvaLS7OM/
 RhMBJrthSW8x7Vdiz/3rk8ib0FJBohtxOdjRkOHHxTNXzMH+9mJodaN5iBmJDghhQe6C
 aVf9y97NdoZtReSmqCSzF/SPOBoo2Rjd66wYrVJqBLCSDW5Y7Tb/1uD2lswOQV6Uqs7r
 jnrJYC9q6Z3xfVRXCLZ6b7P1d9qfr1IAeVNRqpWnYkEGqA9L6MTYjxDAlFpbQ2oSEOZ6
 On/49dj0L5K/TeWwyPNO6VoamET9qq1TBnwFBHI8G5Y7JBnd3tCu6O2RlijPXj4RAXqe
 gaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866699; x=1690458699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EM+qSWWOslftV8HcBXpILD27b+3+W5mkalItnU32xI=;
 b=I8FpUhTDNUHhwnll75rqgNtsaesvmkZ0WZn9E1M233YsxfdmKbfAtbjsOjUoJC6G/B
 Yatv74/BAFRg2XByClKQ/MHM1pRwPvIQkLdm1avY/6HN/SOOUR4Axh4umKfVKUIu+XEr
 rV0BWZ5S3wehOLgEzz4x6OnfQjN0jJysfOqEoEBJjGOAdcU3G7TaQc/Po5QXhY64jJpi
 aIk9/U6OBoctOCi4RS0vjYTgErpzqNcwwCSKsSnJruJNgSr0n0zEkXLNUh1ftZYJ7/fO
 mhOLgUfv11SIfhmqL8u0n6bpeJIFaqPu0woBFOBm9lDcSsWmFRvaH4MDFrcJIfQhvqXs
 vziQ==
X-Gm-Message-State: AC+VfDxq1NPdj2FmNARCxJSYBzVrmiWAwN50kDjdm4rqiho8aZgqh17d
 eJEbiH6+SGNluLTh5tfvtKloIlSlDfHUgd4Uaqs=
X-Google-Smtp-Source: ACHHUZ6IqFkk/UBT9Y/2spa5T+pGGl9y+Nj7mw+jrVqROYCX1zp6Lg0qSp29vM1gcaCZRbjsPfXHcA==
X-Received: by 2002:a17:906:684c:b0:98e:4c96:6e18 with SMTP id
 a12-20020a170906684c00b0098e4c966e18mr4150187ejs.5.1687866699521; 
 Tue, 27 Jun 2023 04:51:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 ce23-20020a170906b25700b009920f18a5f0sm791874ejb.185.2023.06.27.04.51.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/6] target/ppc: Reorder #ifdef'ry in kvm_ppc.h
Date: Tue, 27 Jun 2023 13:51:20 +0200
Message-Id: <20230627115124.19632-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Keep a single if/else/endif block checking CONFIG_KVM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.38.1


