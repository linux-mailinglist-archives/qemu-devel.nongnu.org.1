Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21337736C46
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaj2-0001jl-JW; Tue, 20 Jun 2023 08:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiy-0001hR-6a
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiw-000278-Gv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so6490116a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265081; x=1689857081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HLF4JtJNvNK+eLsSqEMWXzm1BweGNtst+0wJav7KZ8=;
 b=cEQNTNWnXzbUArmvjExoCMRgyEWQMbY8gI3YT+jyej1n1i4FTL5XEWhurZnVAiorRI
 WsHMWz8cYWR0qJCSFihP6pIONUEq2Hi2cPJ6CLmVsU8dSIlT9o3LNcC5Isye/IQb6D1x
 BwhvrZmQi9cUFiz+AA2DKG7zCN9m98IB+KYHXNx6oOi4NSu3Pk7NEgitAWB1OWRrWEKC
 nlwo1pMo1GCB3wAM/0aCBHqtrXC45Xft38Up14Jnp1PM63FNhrlvA0vCCCHJwlySQ21f
 QTl+C3Wdq4Ua2uUrSsTrFD5t0KrTtKbSCvkdl4/Gm7ZV7Psh8LGcRb7qjM1c7nDY3O7H
 O1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265081; x=1689857081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HLF4JtJNvNK+eLsSqEMWXzm1BweGNtst+0wJav7KZ8=;
 b=Bk/6NpOp0BHOdSUARzQiyY82fLtBWSXguplb7QwgEEO9dQc3wfq8Vx+XRxKRHXb7HC
 6o3girLedYw6KdZlD8olEskRELDZzLtYoBhLfRFMet4ecF1ViFMbo0yMBOy0MUwXjEVP
 7JIx2a4nB5kS+TQ5RfqzkSYSmQxq7NV+5IhdhKMRSDou970TSjxjRFFeazB8fQUdLt0M
 D2EjYmiP9UBcxDF6Bqwi2ClUiF8OHZ5kMqjCXlrXin2QEsPKKlhw1HELFvIKYAWF3nVu
 zsVCfFK0hFvay3b3ZuE7VmISOIQ6OZzLTUR52ri062CwWS+bkr9LTU4p1nzBlhG6mUe9
 eZ/Q==
X-Gm-Message-State: AC+VfDzZgb+QOucmt04YDR6ugXFjLGwjdCRbIikLoGZlIAeOjjzzkroK
 QvcyQV3UlPX8tF7H3qwVGByCJRPE3A+uh/180W7sj6oz
X-Google-Smtp-Source: ACHHUZ6mLPKwyOCW13z+8946Dei74BeM8zP3+QyePOoV5lSO2rcV/igNoxgSgu2w8ylP0dNeT/qE8A==
X-Received: by 2002:aa7:d585:0:b0:51a:3b59:20f with SMTP id
 r5-20020aa7d585000000b0051a3b59020fmr8433356edq.36.1687265081139; 
 Tue, 20 Jun 2023 05:44:41 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 20/20] target/arm: Add cpu properties for enabling FEAT_RME
Date: Tue, 20 Jun 2023 14:44:18 +0200
Message-Id: <20230620124418.805717-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

Add an x-rme cpu property to enable FEAT_RME.
Add an x-l0gptsz property to set GPCCR_EL3.L0GPTSZ,
for testing various possible configurations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2976f94ae4..6fec2d8a57 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -142,6 +142,56 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
     cpu->sve_max_vq = max_vq;
 }
 
+static bool cpu_arm_get_rme(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    return cpu_isar_feature(aa64_rme, cpu);
+}
+
+static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t t;
+
+    t = cpu->isar.id_aa64pfr0;
+    t = FIELD_DP64(t, ID_AA64PFR0, RME, value);
+    cpu->isar.id_aa64pfr0 = t;
+}
+
+static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    /* Encode the value for the GPCCR_EL3 field. */
+    switch (value) {
+    case 30:
+    case 34:
+    case 36:
+    case 39:
+        cpu->reset_l0gptsz = value - 30;
+        break;
+    default:
+        error_setg(errp, "invalid value for l0gptsz");
+        error_append_hint(errp, "valid values are 30, 34, 36, 39\n");
+        break;
+    }
+}
+
+static void cpu_max_get_l0gptsz(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint32_t value = cpu->reset_l0gptsz + 30;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
 static Property arm_cpu_lpa2_property =
     DEFINE_PROP_BOOL("lpa2", ARMCPU, prop_lpa2, true);
 
@@ -700,6 +750,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     aarch64_add_sme_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL);
+    object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
+    object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
+                        cpu_max_set_l0gptsz, NULL, NULL);
     qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
 
-- 
2.34.1


