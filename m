Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466572B0F6
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GxG-0003iz-O8; Sun, 11 Jun 2023 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvn-0002iV-Uk
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvl-00041C-FQ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso33983065e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474011; x=1689066011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMWaSEeC21286qg08dnBXfstMJP9JJH0vEjQ7Wn/jbk=;
 b=EbpgekJsiQZYZ/R2odpsxmHdAEsV8Y3uyOTPwDsDRv74HougKNUPFsh8DzW9wcnwyp
 pI3+kYYbXh0JF5hNED4YatHWAzpDMkDwIKrLvT1lLPzM/urmUJvHbA619JPlP8w5prOR
 VCpvbOkjxYMX4IQC/CmLxfcT2WMS7NjbhOLt+17+elu5rC/p22SU2qhyNTP4TVtjexgv
 GSdpRs09FKU75Yz6PHuMpHdXAnN+Pc0FzIL+Z+ODRal/Xyda4nfQG9BSAJqF4dfxBh6A
 k3EtHaUZXOA3S/zkc4J4tsH/kfHEKKf7zv60VcXUh2h0DIyaKZmi/NbGI/4/DYexxGeD
 EI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474011; x=1689066011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMWaSEeC21286qg08dnBXfstMJP9JJH0vEjQ7Wn/jbk=;
 b=C9L5kiByubfKKMdOzoXBFCCsO7hHXheMtxuVBMA5OPkoFF6L5m69UY3N1fGIF9HzuN
 Vy9eyJHe59j7/QLOwDWRTIWNtrULxSYHHldsoPkRhvIQKlD5e7bAsitu4OiUz+vuzxsF
 weDawEbFz3u2H7NluCr6XeZezubK+EB4rNMJ1pULkTyKzxlqPnSBbDz49Bl6ZxRtCTjB
 g7wOdSqpSMgOQLkZGNgTMXepYymzbhF5OGX3XF6+tHvSc0XfIQuOc1Rpw/Qn1jsaK4vC
 owFX1jVShMQl29BuIpli6C1FlJgGPc5ksfnKV4uXkjjdDG0Y48D9VE+2gfqyS67HNFyP
 rIzQ==
X-Gm-Message-State: AC+VfDyc0/0xD5EcFBbHVAFjjlct4grTUBgzzfW5v7AhiZy2QowrEyIH
 tYxH+rzE6k5BBeEDeGZfgS8S6CykDWNDu0sDos8=
X-Google-Smtp-Source: ACHHUZ5Do8M2CQyMM4GT6D96gXMWkBBo0axG3Pvhrm9KBbG5CgSQaAt4jHIoBIVdhPbf7G7jnsKeNg==
X-Received: by 2002:a7b:c8d3:0:b0:3f7:f584:5792 with SMTP id
 f19-20020a7bc8d3000000b003f7f5845792mr5269513wml.0.1686474010623; 
 Sun, 11 Jun 2023 02:00:10 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c28d100b003f080b2f9f4sm7895759wmd.27.2023.06.11.02.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/26] target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:39 +0200
Message-Id: <20230611085846.21415-20-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Instead of including helper-a64.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 4 ----
 target/arm/tcg/helper-a64.c    | 4 ++++
 target/arm/tcg/mte_helper.c    | 4 +++-
 target/arm/tcg/pauth_helper.c  | 4 +++-
 target/arm/tcg/sve_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c | 6 ++++++
 target/arm/tcg/vec_helper.c    | 4 ++++
 7 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b7201eb89c..71e2cd5580 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -536,7 +536,3 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-
-#ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h.inc"
-#endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1c9370f07b..86133c6e0d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -35,6 +35,10 @@
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
 uint64_t HELPER(udiv64)(uint64_t num, uint64_t den)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9c64def081..f29715869f 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -24,11 +24,13 @@
 #include "exec/exec-all.h"
 #include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
-#include "exec/helper-proto.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
 {
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 62af569341..3a8f0d820f 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -22,10 +22,12 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 static uint64_t pac_cell_shuffle(uint64_t i)
 {
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 79a42af591..64f744bf6a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
@@ -37,6 +36,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
  * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d1ab1edf6d..6047f07f8c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -38,6 +38,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d93960198f..9dd7e0f5e1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -37,6 +37,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


