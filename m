Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F4A7CCF3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Apr 2025 09:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2o-0002wJ-8m; Sun, 06 Apr 2025 03:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2M-0002sz-MT
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2J-0001zu-M0
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fF5nZBB8wjpatUzj5sqS5a4NtL1KFO+85G96YZqcBM=;
 b=T76FkhWoNmmb8Wc+yD498NttL4gwytlCgAjOTa5HfO2iFOuxIvY644y+RSmM3WrfuMaKQd
 yFtgceEMN0wSLik/uDRE1ht9jJirehblw3tpLj+7MxWCa/3cHKRIzNCH+H7TBLIsEpzv1U
 Nf1b8k2PlDUCY305nhSlzUoBTWl8YAE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-jiUbx8KKOaym5l--UliD5A-1; Sun, 06 Apr 2025 03:03:17 -0400
X-MC-Unique: jiUbx8KKOaym5l--UliD5A-1
X-Mimecast-MFC-AGG-ID: jiUbx8KKOaym5l--UliD5A_1743922996
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so1937602f8f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922995; x=1744527795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fF5nZBB8wjpatUzj5sqS5a4NtL1KFO+85G96YZqcBM=;
 b=CQaISRjjfeJlL8hO54LIx2lqdc7rdYMEelXUehfBj5ouZ79E9Gk8895SdjfHV2ZATh
 3tTxhN+RBkNhaVv1iWKtgzUN+8ytdAk7Ukvm/0bsoDHLKWD7O4LjTbNkjUkiQBVZrQWl
 D5IxhgWkgCY6TumtYxWFhrWZOAdXTBQiPQqV3BPZ5B7WG9UHlGAjzcReyTZhW6KuAy21
 ghT8wIv1Xd/J6Pe4OOPfWa7hAHsbD62Mxn/MYPVVvPvebO67LZR5YOwocmDblLihllu1
 +7WBEPTKRJnh0vp1cQ0s/e762Yfkm76ezkFgZbqADilqSz+tiQsyzA40I8DWqYbkzvSY
 Q22Q==
X-Gm-Message-State: AOJu0YyEvHIjVmQoNWtK8Cck7mPRW2wf2inazb4lbdVYz47l2LXPgkDO
 8heyuqrXXjbDVKj/rSc7UTcarhLhS4BjpTKf+o1vSOUrO+WXMCLsVMzQda6KmZrevUep1aHcm61
 dAsB9c/vY7gE7FE3jnKBhvUsxAkHggWkf7s/V56VAy9z74FxNu3Ap7HnmzTtX8wH1xRhiHooQ9H
 cJFQWXJVYNL9YQbO00wGqufUL2A8eNSOgD/n4p
X-Gm-Gg: ASbGnctsgMe0lgmydNSpsSuVmvLov7jVZD2k/Ma9eS07B+HseiHHCipojVXrepTOIwL
 k/jjRGyBdIPgFx7nF8yJxJcpaivE5VPDnt1C4ZUiDcNbGql8YJgrroEzMeo7I9ESoQdCoHZdeZb
 0HJY4yTLsPN7JRyX6V5hIxtlfI3yUobaK/asCY5nkT7o5v1yE7bVF6IYo3Oqo6LOMrbzxX/+NuB
 HGPLErxQB/gbH7VEVFS3io2O/nACL9QqCQNw7mn8J6qNvlpRCr/DoeU1zEo60lHXXUzuyMpM0V8
 IPo+xRY/SFaYF1jO9g==
X-Received: by 2002:a05:6000:2506:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-39d0de12554mr6593354f8f.13.1743922994975; 
 Sun, 06 Apr 2025 00:03:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG6CPILGoPv//UPprpDpkFi9RNZqg2rxCbABVrgobjuBwiatZuTylNj0jAsIgqbhHPAyV+kg==
X-Received: by 2002:a05:6000:2506:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-39d0de12554mr6593334f8f.13.1743922994501; 
 Sun, 06 Apr 2025 00:03:14 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b18easm94824585e9.38.2025.04.06.00.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:12 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 06/27] target/riscv: move satp_mode.{map,
 init} out of CPUConfig
Date: Sun,  6 Apr 2025 09:02:33 +0200
Message-ID: <20250406070254.274797-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Paolo Bonzini <pbonzini@redhat.com>
From:  Paolo Bonzini via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

They are used to provide the nice QOM properties for svNN,
but the canonical source of the CPU configuration is now
cpu->cfg.max_satp_mode.  Store them in the ArchCPU struct.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h     | 14 ++++++++++++++
 target/riscv/cpu_cfg.h | 14 --------------
 target/riscv/cpu.c     | 32 ++++++++++++++++----------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e9c46120215..7e10c08a771 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -502,6 +502,19 @@ struct CPUArchState {
     uint64_t rnmi_excpvec;
 };
 
+/*
+ * map is a 16-bit bitmap: the most significant set bit in map is the maximum
+ * satp mode that is supported. It may be chosen by the user and must respect
+ * what qemu implements (valid_1_10_32/64) and what the hw is capable of
+ * (supported bitmap below).
+ *
+ * init is a 16-bit bitmap used to make sure the user selected a correct
+ * configuration as per the specification.
+ */
+typedef struct {
+    uint16_t map, init;
+} RISCVSATPModes;
+
 /*
  * RISCVCPU:
  * @env: #CPURISCVState
@@ -518,6 +531,7 @@ struct ArchCPU {
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
+    RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 4a6f0d76522..7143c40f625 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -21,19 +21,6 @@
 #ifndef RISCV_CPU_CFG_H
 #define RISCV_CPU_CFG_H
 
-/*
- * map is a 16-bit bitmap: the most significant set bit in map is the maximum
- * satp mode that is supported. It may be chosen by the user and must respect
- * what qemu implements (valid_1_10_32/64) and what the hw is capable of
- * (supported bitmap below).
- *
- * init is a 16-bit bitmap used to make sure the user selected a correct
- * configuration as per the specification.
- */
-typedef struct {
-    uint16_t map, init;
-} RISCVSATPMap;
-
 struct RISCVCPUConfig {
     bool ext_zba;
     bool ext_zbb;
@@ -196,7 +183,6 @@ struct RISCVCPUConfig {
 
 #ifndef CONFIG_USER_ONLY
     int8_t max_satp_mode;
-    RISCVSATPMap satp_mode;
 #endif
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7df3e8b7cd5..9603f8985b3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1200,8 +1200,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.satp_mode.map == 0) {
-        if (cpu->cfg.satp_mode.init == 0) {
+    if (cpu->satp_modes.map == 0) {
+        if (cpu->satp_modes.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
             set_satp_mode_default_map(cpu);
         } else {
@@ -1211,7 +1211,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              * valid_vm_1_10_32/64.
              */
             for (int i = 1; i < 16; ++i) {
-                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
+                if ((cpu->satp_modes.init & (1 << i)) &&
                     supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (supported & (1 << j)) {
@@ -1225,7 +1225,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    satp_mode_map_max = satp_mode_max_from_map(cpu->satp_modes.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
     if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
@@ -1241,8 +1241,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
      */
     if (!rv32) {
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-            if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
-                (cpu->cfg.satp_mode.init & (1 << i)) &&
+            if (!(cpu->satp_modes.map & (1 << i)) &&
+                (cpu->satp_modes.init & (1 << i)) &&
                 (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
@@ -1330,11 +1330,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
-    value = satp_map->map & (1 << satp);
+    value = satp_modes->map & (1 << satp);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1342,7 +1342,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
@@ -1350,8 +1350,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    satp_map->map = deposit32(satp_map->map, satp, 1, value);
-    satp_map->init |= 1 << satp;
+    satp_modes->map = deposit32(satp_modes->map, satp, 1, value);
+    satp_modes->init |= 1 << satp;
 }
 
 void riscv_add_satp_mode_properties(Object *obj)
@@ -1360,16 +1360,16 @@ void riscv_add_satp_mode_properties(Object *obj)
 
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
         object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
 
-- 
2.49.0


