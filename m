Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8982AD16
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssj-0001gF-T7; Thu, 11 Jan 2024 06:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssE-0001OC-Ed
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssC-0004To-HV
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso66500435e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971119; x=1705575919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J8usOgs71gAybFdal5YqRiowxIC5H4fgmIvlWyQXChc=;
 b=kpvpAiA1OQKhMZ4a3ow+BvfnCrLsBqbAhHLeHAgW4bw8O/3atAUw5C7vktnwW95/Fd
 cIvdz5RGTP3GkZQgaNgsOsUMy6iaBcLHgiGCvQe7P7FAlvXHXrmh94ZKjNEJCiEIKVVv
 QJqGdDlW5xtctFUhe812aHQib0yrU4uB9SJBAOBhcEMqqwx1ceLZ8x05Oj/O9N2HED63
 SVFXrpw8C+f8K5LrlLYAj688b/dGq0OsoD2wAvbY1qEsm1YnahZNidPUfK9ut/B0tv2H
 B7M4HK5X0zu0Q9KTGp+xFTULSkI6aB6xwUruMB3jickXAhf2ItxKsSAx3m/3BOOQNJt9
 006w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971119; x=1705575919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8usOgs71gAybFdal5YqRiowxIC5H4fgmIvlWyQXChc=;
 b=pOvMuvV8PSxR8094WPq882gXCFZpze3iqdcMaOTpQwSiBffL6z/gy52Kc3ut7xD21s
 E5MC1LZvLvegYrDVQvHYRJMVQZMc4rWgeMmOvCi+0BAPJYcupLe2G3vcFFmd+q1RsXo6
 8TrkqdDeTolThrMaoZ8vMXs4GMhPmgzfMCdRf33RdLU9OO+OfCMuMadwwf65f9C28pn5
 2ubQVrgUKpoXZG6p8QBLh/UG/65br0SgkYjL/BRTQ0dg/MbD0g0Kv/Aqiy/7O0oVSDEE
 tgrWDjtVKv1xfNg7N/iQz+AlPwID2SaD96ldyILNlVq1nmnVd1r2gBV2ioLcsSl545cQ
 qAtw==
X-Gm-Message-State: AOJu0YzokDdYJBpPNrPb7eGOdgvmm6/7tUW38rGl3/E27643VbgJpKml
 JOsNGNR86mGymzmNvnzZGYIr6RwHgLBXhj2Xi08Z2Vaq61w=
X-Google-Smtp-Source: AGHT+IEZFMZJ7DLCUYDKgI8vPK7IP05faPlhLAklipsVPZZ6bWtUzhrS01ii9BK/1JOc2hm2e3znAw==
X-Received: by 2002:a05:600c:314f:b0:40d:94df:dac4 with SMTP id
 h15-20020a05600c314f00b0040d94dfdac4mr311971wmo.153.1704971119209; 
 Thu, 11 Jan 2024 03:05:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] target/arm: Handle HCR_EL2 accesses for FEAT_NV2 bits
Date: Thu, 11 Jan 2024 11:04:52 +0000
Message-Id: <20240111110505.1563291-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

FEAT_NV2 defines another new bit in HCR_EL2: NV2. When the
feature is enabled, allow this bit to be written in HCR_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/helper.c       | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3a43c328d9e..7a590c824cf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -844,6 +844,11 @@ static inline bool isar_feature_aa64_nv(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) != 0;
 }
 
+static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, NV) >= 2;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 24751e05b24..e3e56539594 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5857,6 +5857,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_nv, cpu)) {
             valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
         }
+        if (cpu_isar_feature(aa64_nv2, cpu)) {
+            valid_mask |= HCR_NV2;
+        }
     }
 
     if (cpu_isar_feature(any_evt, cpu)) {
-- 
2.34.1


