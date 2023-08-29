Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796E78D08C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83q-0003iF-Aw; Tue, 29 Aug 2023 19:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83m-0003KV-Ft
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83h-0001MD-Px
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:46 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso39077355ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351420; x=1693956220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hb9dMZIAxrLN24ygvHA9pXLZxd+STyR5WIcVAOZOt3k=;
 b=NJ2aySW5dDJ8u3pIIxwpMHZXyjcXe5FJhvqBhqZd2tUFfoq5FXmiJTYewJ+cLK50Yy
 X5WtkkTCtxxy2H0BCqXwwYyGFq8IHzU+GPvJ9z75YILeferAPoAbqvTR/0yh9ddPHKwC
 +DVvgUVX9L175qwh9JCoNxoUs4a/vHMs+nh+ItNEalpuaVblDq38tLTrdE77wwWlLlUa
 +eTLzSp3LFuDQslhmjH2j62ASCtUzhssMJybrN398W8yzTa1ZHNIZQ+2gO6ZbCblL1WK
 v6xlSBwhyO2G8JRENGRocICvGOvjmlU4wryqdN7wdR2LXtigGyQ/nrQdplQmR97eLct/
 g31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351420; x=1693956220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hb9dMZIAxrLN24ygvHA9pXLZxd+STyR5WIcVAOZOt3k=;
 b=fYJqyWdb+MSgYxo4pCpZ2mFIFmAtdOPk9MOMFU54GPXVrr5k8ID5FKiec0eng78wRF
 mid2JYfpjKZ/1JaQR2nZTguz4hiqX4dOIIj16+cmjIhx1fA//r+V4/RDnen03+pzeU0y
 EQwfrpcFCN/IPARd80gGpeicUi6q4VWWelWRmsxtFTE0VdE+BmcInv4fTjmWsfPxndjO
 56dH5udEZzzgIjMiNeXqMZO6JYYB85AC0zZOkgPY+oymrP3TFC/gWyNrgy8LmO7dc5fZ
 Po595KJIEv3I4q4nGeJTo+HFGdG7jIM3ohCUsmFeG9wED4/m91uJFegR0hxC1/bTZOAX
 S54w==
X-Gm-Message-State: AOJu0YxJ0M0z9DVDGsEZDGww92YLBQhBNYCOlqSplRfHoTjpDGs8mbZW
 rcgs/RK5X2bie57YFsoLJ7W8fh7ZWz5C/j33veM=
X-Google-Smtp-Source: AGHT+IGdyWMQ0SsHRPpDFNdO0X/FPoZCq6JFmGQhs48NQXPwSSqX0K5l31vasxnb5DayMz4vMykKGQ==
X-Received: by 2002:a17:902:684c:b0:1c0:9abb:4873 with SMTP id
 f12-20020a170902684c00b001c09abb4873mr503273pln.64.1693351420134; 
 Tue, 29 Aug 2023 16:23:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 03/12] target/arm: Add feature detection for FEAT_Pauth2
 and extensions
Date: Tue, 29 Aug 2023 16:23:26 -0700
Message-Id: <20230829232335.965414-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Rename isar_feature_aa64_pauth_arch to isar_feature_aa64_pauth_qarma5
to distinguish the other architectural algorithm qarma3.

Add ARMPauthFeature and isar_feature_pauth_feature to cover the
other pauth conditions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Message-Id: <20230609172324.982888-3-aaron@os.amperecomputing.com>
[rth: Add ARMPauthFeature and eliminate most other predicates]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h              | 47 +++++++++++++++++++++++++++++------
 target/arm/tcg/pauth_helper.c |  2 +-
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4a5a5e9eb8..0e2545d631 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3801,28 +3801,59 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+/*
+ * These are the values from APA/API/APA3.
+ * In general these must be compared '>=', per the normal Arm ARM
+ * treatment of fields in ID registers.
+ */
+typedef enum {
+    PauthFeat_None         = 0,
+    PauthFeat_1            = 1,
+    PauthFeat_EPAC         = 2,
+    PauthFeat_2            = 3,
+    PauthFeat_FPAC         = 4,
+    PauthFeat_FPACCOMBINED = 5,
+} ARMPauthFeature;
+
+static inline ARMPauthFeature
+isar_feature_pauth_feature(const ARMISARegisters *id)
+{
+    /*
+     * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
+     * and the other two must be zero.  Thus we may avoid conditionals.
+     */
+    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
+            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
+            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
+}
+
 static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
 {
     /*
      * Return true if any form of pauth is enabled, as this
      * predicate controls migration of the 128-bit keys.
      */
-    return (id->id_aa64isar1 &
-            (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, API, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, GPA, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
+    return isar_feature_pauth_feature(id) != PauthFeat_None;
 }
 
-static inline bool isar_feature_aa64_pauth_arch(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
 {
     /*
-     * Return true if pauth is enabled with the architected QARMA algorithm.
-     * QEMU will always set APA+GPA to the same value.
+     * Return true if pauth is enabled with the architected QARMA5 algorithm.
+     * QEMU will always enable or disable both APA and GPA.
      */
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
 }
 
+static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
+{
+    /*
+     * Return true if pauth is enabled with the architected QARMA3 algorithm.
+     * QEMU will always enable or disable both APA3 and GPA3.
+     */
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+}
+
 static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 62af569341..6271a84ec9 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -282,7 +282,7 @@ static uint64_t pauth_computepac_impdef(uint64_t data, uint64_t modifier,
 static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
                                  uint64_t modifier, ARMPACKey key)
 {
-    if (cpu_isar_feature(aa64_pauth_arch, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_pauth_qarma5, env_archcpu(env))) {
         return pauth_computepac_architected(data, modifier, key);
     } else {
         return pauth_computepac_impdef(data, modifier, key);
-- 
2.34.1


