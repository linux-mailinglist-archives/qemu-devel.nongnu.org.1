Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A47510E3
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJf6c-0000tW-64; Wed, 12 Jul 2023 15:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf6L-0000p9-Us
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:15 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf6K-0006Z8-BQ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:13 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a425ef874dso765039b6e.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689188531; x=1691780531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISGp9WhmlakO4roPRO9/GdVvd2qgHOTCTKibkwihSgI=;
 b=JFqlSPmm8p73PvbU8WuCQbESvpOjhU1Dg9OGeaQrqr4PuJ5lc+lqqOTaFYv5KdKt4E
 I6tmfv9l0ZBGBYR+dLka+rOwTelc+DwUgbALOF3x8OwOLRxujUuin7KHJ615u5oDKeio
 mXRopax1tG49f6dU+S22uiCGkteRy+sB2CGWg6T0RA2hefvb14GhoSMXTiidb+HAMgQ4
 JxfT3bwbRPWua8h/W0IdpUjogVUjKcEiqwLrHRhXwyGlhEKVAcv5cg2Hs7hQSTEsNAbO
 FtqZOIIqkzSgH+qkTy4P/Nq2pfIyU2Xp//yVw7uuKIBE6quG6F4q2St+BLfEDP70Zv9t
 OYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689188531; x=1691780531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISGp9WhmlakO4roPRO9/GdVvd2qgHOTCTKibkwihSgI=;
 b=hpcb/+XwEg/VY9oJN3cAva3C1fUWI37gTV6H4Yiei2MbJa/3RnpOqIkP6mN+x8rdSm
 gjf3eEv11VVrImQc7XaEgE7JbNLjVxWkNAVIiaJOiX1vgKe3L/3Q1H38LpMQpUqPJGgY
 jz/xVV38DP0UmYamYePLOnyumOKz8INY6UBYSCK9c1DtsPIq2E5f5gKtCCLF4l6DWc8h
 z6dBPQh2PTSOG0Pj83FKfrHush26ntc/HmN7+tvAJ0MVagHIig4YAQWEPSBw3ESFgfXH
 xsnV6q6KivWsAqjqXLGF6UCS5tDNBd3+Chjo4Ajji2VZN7cFguAcu8+Vwir8AQ2gaOVZ
 ayhA==
X-Gm-Message-State: ABy/qLbDB3WuaS04oSWSldWk9UlDIcf2kwGgK0MeOX9MyR5wB6/Lhm2D
 V0mzYjGYMR3/xkB4ifLUP5D8FIao1bJXPehRB1I=
X-Google-Smtp-Source: APBJJlEBR0EZBSkfc+0m1yWErHUOfhH/6G+zdsTkd3RTzEMfAht2KXMTobwxUn87HDcCKUOPmIBchg==
X-Received: by 2002:a05:6808:290e:b0:3a0:5ee3:ea67 with SMTP id
 ev14-20020a056808290e00b003a05ee3ea67mr16873295oib.16.1689188530848; 
 Wed, 12 Jul 2023 12:02:10 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a05680802c900b003a020d24d7dsm2174435oid.56.2023.07.12.12.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 12:02:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 5/7] target/riscv/cpu.c: add a
 ADD_CPU_PROPERTIES_ARRAY() macro
Date: Wed, 12 Jul 2023 16:01:47 -0300
Message-ID: <20230712190149.424675-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712190149.424675-1-dbarboza@ventanamicro.com>
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
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

The code inside riscv_cpu_add_user_properties() became quite repetitive
after recent changes. Add a macro to hide the repetition away.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0826b449d..b61465c8c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1881,6 +1881,11 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
+#define ADD_CPU_PROPERTIES_ARRAY(_dev, _array) \
+    for (prop = _array; prop && prop->name; prop++) { \
+        qdev_property_add_static(_dev, prop); \
+    } \
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1924,17 +1929,9 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
-    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
-
-    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
-
-    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
-    }
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_options);
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_vendor_exts);
+    ADD_CPU_PROPERTIES_ARRAY(dev, riscv_cpu_experimental_exts);
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


