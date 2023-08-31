Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749E78F5E5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqaV-0003uZ-PR; Thu, 31 Aug 2023 18:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaS-0003tO-Bu
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:28 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaP-0002q9-Bg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:28 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99de884ad25so168094966b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522584; x=1694127384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEesyLIbjrA7oeyx/iNQirg7zO4jKel4RvIBPMrDvkc=;
 b=F4jVEE/EC9e8pVSN7jp1DFlKqcEYCPgMMV8Kt3Y42JeEYljU7v5fkFy1wY1OVuYPUD
 YKLN4EOH6ZU4dwVr7wd7qY4HE2FkSJFDnQRx2+rmtiFxKlJME2wen2Y+TujK5dqgizcn
 5CwB/dN/lfSgqGIhhLtJurGa4CIwVf3p7tlH+XY1E10DxCl4P4k1yXTdYu2sPqDl4pQm
 o8lSsoy+wip0ruywOYrEpYLTJoAl2Ydi98FSsp3V9PrkQJtPGhmL2rcTd7nOGzbfVU81
 xt21lZT6yPV64kUaU9cRnvfDHz6rd5LoSDnoapxICq3wwXFDcWU0Nwx0X92Pg8yYZUDy
 /gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522584; x=1694127384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEesyLIbjrA7oeyx/iNQirg7zO4jKel4RvIBPMrDvkc=;
 b=FNK8wuZ7eknYlVywArFbJCKNHsvL3y7tsow4SDxtQ3rz65bXB6vD/JPVsGjInIjBtF
 p3LQFrjJ70N0+FcvluFWOyU9ume0B8qgVXlPTk0RwjYuycraQRJwrazywnhlEVqKEN+C
 xISyv7zEoz9xfqzmuFgag8m26wCJcGJs2bxMml8UxvZPxXv5vVJnGcykaEGUizsCAabW
 iA66OBtjf3WKCAlGTsOUXz7mvXLHSKzs312hcE49BXYwp4ZCqEjMMRpTDhkwgMHY3To/
 iYnlD4icV918XGNbrzA9/TzZgEwX/kGswfASb5i7iWpm+I9190MUwFZnZ7X1EWGYpDEI
 cLhA==
X-Gm-Message-State: AOJu0Yzl4riqE7sEJq9x/BGkMyM3cCw2Cv+Ker622l8ryd1mCj+so1O3
 qE43JiWDblrg2+DfgU4YLW5lTcU09oYhFQYkdKU=
X-Google-Smtp-Source: AGHT+IGz09SR3MM9HeI2VXNe8BYQf+bZoPQ5dXvBf8Xm/0i27u04GXliQL6nWF6DOyCyJIFqDto+NA==
X-Received: by 2002:a17:906:224b:b0:9a1:bee8:9252 with SMTP id
 11-20020a170906224b00b009a1bee89252mr542069ejr.29.1693522583206; 
 Thu, 31 Aug 2023 15:56:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 jw26-20020a17090776ba00b00982a92a849asm1252665ejc.91.2023.08.31.15.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 02/11] target/arm: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:55:57 +0200
Message-ID: <20230831225607.30829-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Fix:

  target/arm/tcg/translate-m-nocp.c:509:18: error: declaration shadows a local variable [-Werror,-Wshadow]
        TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
                 ^
  target/arm/tcg/translate-m-nocp.c:433:14: note: previous declaration is here
    TCGv_i32 tmp;
             ^
  target/arm/tcg/mve_helper.c:2463:17: error: declaration shadows a local variable [-Werror,-Wshadow]
        int64_t extval = sextract64(src << shift, 0, 48);
                ^
  target/arm/tcg/mve_helper.c:2443:18: note: previous declaration is here
    int64_t val, extval;
                 ^
  target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variable [-Werror,-Wshadow]
        int ret = 0;
            ^
  target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
    int ret;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c              | 1 -
 target/arm/tcg/mve_helper.c       | 8 ++++----
 target/arm/tcg/translate-m-nocp.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 486f90be1d..20d534faef 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1933,7 +1933,6 @@ int hvf_vcpu_exec(CPUState *cpu)
         uint32_t rt = (syndrome >> 5) & 0x1f;
         uint32_t reg = syndrome & SYSREG_MASK;
         uint64_t val;
-        int ret = 0;
 
         if (isread) {
             ret = hvf_sysreg_read(cpu, reg, rt);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 403b345ea3..32087b6f0a 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -924,8 +924,8 @@ DO_1OP_IMM(vorri, DO_ORRI)
         bool qc = false;                                                \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
             bool sat = false;                                           \
-            TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
-            mergemask(&d[H##ESIZE(e)], r, mask);                        \
+            TYPE r_ = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);         \
+            mergemask(&d[H##ESIZE(e)], r_, mask);                       \
             qc |= sat & mask & 1;                                       \
         }                                                               \
         if (qc) {                                                       \
@@ -2460,7 +2460,7 @@ static inline int64_t do_sqrshl48_d(int64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        int64_t extval = sextract64(src << shift, 0, 48);
+        extval = sextract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
@@ -2492,7 +2492,7 @@ static inline uint64_t do_uqrshl48_d(uint64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        uint64_t extval = extract64(src << shift, 0, 48);
+        extval = extract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 33f6478bb9..42308c4db5 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -506,7 +506,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
 
         gen_branch_fpInactive(s, TCG_COND_EQ, lab_active);
         /* fpInactive case: reads as FPDSCR_NS */
-        TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
+        tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
         storefn(s, opaque, tmp, true);
         lab_end = gen_new_label();
         tcg_gen_br(lab_end);
-- 
2.41.0


