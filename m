Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1DCAF98B6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 18:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjH0-000135-0A; Fri, 04 Jul 2025 12:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFb-0005yc-Oi
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:27:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFY-0006zQ-W1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so6170425e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646413; x=1752251213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iXUqnSNoGZ/jACB187vp1qlCyYhfeg4tsmRJqb3n4HQ=;
 b=b1yNKWG0qZFlfyUHyuJrCSAQrGM2XHXs8E2IF7Y934yS+zkmZn0lc3YAJj+d6JvfSJ
 67jfhg4JOSY8kzI9me8QWByV0kYyzsaOCyul2iAhoG2IXUWsu2tnY/i5b/RjyNfyjgHw
 VOkNOqkLbP+30goNVTvN5a3aBFi9znM7iBvETlWA/i9sys1Jc4gdN2QJA4/q+w6F8NIW
 VMtMrxKsrvu04V0p87oFymEBmpmmcM21B1YyDcgQWXEY2F4bcNwF9SAFlcuf9Y+6Zzd0
 w6iPRZbagNWl+0Fcmnv8r6lm1dC9UXl5DGkfwitv+tGDOl36c05k9oeInT+oEUhT76xZ
 u9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646413; x=1752251213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXUqnSNoGZ/jACB187vp1qlCyYhfeg4tsmRJqb3n4HQ=;
 b=qM449Dfoo2IGfvKB97QMq/CgGS4/CAo+CDIB49qns/Lpe/NxPHnUuXXTW+XmoYEmG2
 pjoD+4hpP46O46OwCuuXnsfX2CYWCgMAPZOfDcsbo3ACqSpw/Jdtmjf5nE4Ipxnfkdxx
 OIHaqgapSOuQMe/41aBexU6FOUWSDwZFYr4RE0FvZd/ahjdfKBdCMZrYCUVXqiWRAtzM
 wfp3JroKgJkgOzHt49SH5NPOiTUBR4NtbZmsSFaEuckKb5I2aFJJjehtZegp+Bjjx4nH
 4x82wK7V5FyRYx/8+c2PFdxuwEtfoHgOWE9FafP+ors9KL881SMfr0hVDufOTxYdlpqJ
 GhpQ==
X-Gm-Message-State: AOJu0Yx9rTl0Q6vjf4+mdLaiZ3aw0mWBoQEZdeO5bxWaWYkpmFtbOLd2
 KFtRU+Tx/vj3kCL6TzWKr51tUDwVky5GcxwKVktSefsyHh/xZynOEXMWticHMO1ci1qoJRIUDMB
 D9+bb
X-Gm-Gg: ASbGncuTQtt4aBAugf0pqJJM20Kq5hP2MHDlQD/xML8NIw3/QGKA1VykMD5HIsKjULT
 ay0jBHo5wCvueCicg/l6Ko0bwsMw+XCDaic0vIZfRgFIIeLKC/3x4ZfUdJFwAaHcS/t4uDI4Zf0
 hQYyntAj1JtePKRMVet5KuvJ7BmdGZlV4sn0NySBbR4eVURzKXDt7xkcMyEGnqCQAZMqo2dMytG
 GOGvhN7KSYnBJ7+VYT0rbgiLndavgI0EYrPGG21fSN+pbEX74N/uXsUpnPsD86PjoN+0CnX+CwO
 ayzINJJtjiLEXZAXTUkSexogGTQndwObRjcj+9GXNvjUyvfcfyqDIrWLui7PPbf1ajRn
X-Google-Smtp-Source: AGHT+IEXTDQ2ATsFpNb6SaO9pC0H9mDCELowHCGLeDQsvbgCauMRE63Lv2bvoGQYy362r0o+X9lwgA==
X-Received: by 2002:a05:600c:1c98:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-454b948f789mr8604645e9.17.1751646413165; 
 Fri, 04 Jul 2025 09:26:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 117/119] target/arm: Implement SME2 BFMOPA (non-widening)
Date: Fri,  4 Jul 2025 17:24:57 +0100
Message-ID: <20250704162501.249138-118-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-106-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/sme_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 ++++
 4 files changed, 64 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index fac70a82b92..1fc756bec6e 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -145,6 +145,8 @@ DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
@@ -156,6 +158,8 @@ DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_bfmops, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
@@ -167,6 +171,8 @@ DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_bfmops_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_bfmops, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3c58fdd2a0e..6bb9aa2a90e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -191,6 +191,8 @@ FMOPA_h         10000001 100 ..... ... ... ..... . 100 .        @op_16
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
+BFMOPA          10000001 101 ..... ... ... ..... . 100 .        @op_16
+
 BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index d23d9f08d29..bb8ed1ed0e2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1144,6 +1144,57 @@ void HELPER(sme_ah_fmops_d)(void *vza, void *vzn, void *vzm, void *vpn,
                float_muladd_negate_product);
 }
 
+static void do_bfmopa(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                      uint16_t *pm, float_status *fpst, uint32_t desc,
+                      uint16_t negx, int negf)
+{
+    intptr_t row, col, oprsz = simd_maxsz(desc);
+
+    for (row = 0; row < oprsz; ) {
+        uint16_t pa = pn[H2(row >> 4)];
+        do {
+            if (pa & 1) {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint16_t n = *(uint32_t *)(vzn + H1_2(row)) ^ negx;
+
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pb = pm[H2(col >> 4)];
+                    do {
+                        if (pb & 1) {
+                            uint16_t *a = vza_row + H1_2(col);
+                            uint16_t *m = vzm + H1_2(col);
+                            *a = bfloat16_muladd(n, *m, *a, negf, fpst);
+                        }
+                        col += 2;
+                        pb >>= 2;
+                    } while (col & 15);
+                }
+            }
+            row += 2;
+            pa >>= 2;
+        } while (row & 15);
+    }
+}
+
+void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
+                        void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_bfmops)(void *vza, void *vzn, void *vzm, void *vpn,
+                        void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 15, 0);
+}
+
+void HELPER(sme_ah_bfmops)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+              float_muladd_negate_product);
+}
+
 /*
  * Alter PAIR as needed for controlling predicates being false,
  * and for NEG on an enabled row element.
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 119a5665e67..65fc8bc9b2f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -582,6 +582,11 @@ TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a, MO_64, FPST_ZA,
            : !s->fpcr_ah ? gen_helper_sme_fmops_d
            : gen_helper_sme_ah_fmops_d)
 
+TRANS_FEAT(BFMOPA, aa64_sme_b16b16, do_outprod_fpst, a, MO_16, FPST_ZA,
+           !a->sub ? gen_helper_sme_bfmopa
+           : !s->fpcr_ah ? gen_helper_sme_bfmops
+           : gen_helper_sme_ah_bfmops)
+
 TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            !a->sub ? gen_helper_sme_bfmopa_w
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
-- 
2.43.0


