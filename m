Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5496773B7BB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxM-0002fc-7a; Fri, 23 Jun 2023 08:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0001m5-Si
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0000iF-5B
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so7216975e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RXDnzXYKJnpITKn0hCf0rPzCPQ8pKO8fLi9Oma1Ch/k=;
 b=fqhXESyYOHHt9dyCfVkMixZ4AnbjIt0eZo+M8A5Ko7zpE+F5/RmD6KNZ5NHFnq9DMU
 zHwoVyOf+N/LLNZlB6Pk9JbqwRGi7v1YJB1PSTxc/VyDbP5Akb7lZ6kR4uj+yobMZESe
 gniGvJd2MjWwH7bGAFGQ9TqfxvKqxzeS2lbBeSzW7rzYVg502huk/FYu8ISgI1WrrIj/
 n9+2xIYTDeayMiscrAHQc4qrmYuXZ0W48f6hJiZb7D8nqTM15L8NtVgZQ7GJb2ZgNtuS
 KPlIEFJDKzzpEnzqOUC/lbOQOREzXfXPqfvHTbB7QftFMzw+VBsQ3KRiRiCh5hbPcaT+
 tjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXDnzXYKJnpITKn0hCf0rPzCPQ8pKO8fLi9Oma1Ch/k=;
 b=dpJglO0p/3tGCyJSeBMZc3QpDmBYFpF+jYu1cCnrqhMix30MUKoFD06DF3/AoGp3bs
 pIWVoGqEXeK+yMLZoOzXutSS939Oy1xgmQb/qPfcEpjGm7iXdpc0Dz5gSrHUYw2eHiJm
 38tmiuuNKNRhdjqB/LinkRKxiVU/JSUy0Pp/9QhdgClS0Y/uYFbnolzxj6/y33eTmXvy
 VShJ4MYHRFEZHjI5GXMhZNcgmPlbOxCmtePt0bwRPP2nlKHEumbmqZtqy8qKlJbWL2NQ
 Sx2ALcx1OophzXviljd8j/Dud9Gof+5tY2n1GRvGHbBAmBzndEnXeC+Ap6S6KWrsPDFi
 YCSA==
X-Gm-Message-State: AC+VfDwUS0sXMS6G0JLQFGGGiHKKz/8gOKL4y4KguXBE4Xji+H1DLnSA
 t7moZ7MCAx5R5UZTCPnCIisihvdpXRAHKOXZsf4=
X-Google-Smtp-Source: ACHHUZ6ahJbtJzaIVkXQ6z4oBQlUY0fndHVXFYBcpVr4dS7BkZOUDlX+1KaxD1nLH63q0wR6dgRwxQ==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b45 with SMTP id
 w3-20020a1cf603000000b003f8f80e7b45mr16091683wmc.7.1687523506670; 
 Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] target/arm: Add cpu properties for enabling FEAT_RME
Date: Fri, 23 Jun 2023 13:31:29 +0100
Message-Id: <20230623123135.1788191-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add an x-rme cpu property to enable FEAT_RME.
Add an x-l0gptsz property to set GPCCR_EL3.L0GPTSZ,
for testing various possible configurations.

We're not currently completely sure whether FEAT_RME will
be OK to enable purely as a CPU-level property, or if it will
need board co-operation, so we're making these experimental
x- properties, so that the people developing the system
level software for RME can try to start using this and let
us know how it goes. The command line syntax for enabling
this will change in future, without backwards-compatibility.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-21-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2976f94ae45..6fec2d8a57a 100644
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


