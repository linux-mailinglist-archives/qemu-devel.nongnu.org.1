Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 167CA729787
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZgZ-0001Ve-N4; Fri, 09 Jun 2023 06:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZgV-00014u-Ew
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZgR-0001iR-RQ
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so15787845e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307770; x=1688899770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e3yMzYK/XMG3H3RL9muHnEQj6ptqEInvr2skv+z8Do=;
 b=J7oWhGuuky/+oIjIXc9KxOpWt0+gTFaCBKpT7EQyKKxe4HHyJ+B8Ph5+N5NcEjkKsu
 Dzy+7mmMtgRZZc776V2jWDJBchDmJEQVrvos1vNMGMwG8oJK2V1Z35WS8yidli50f61P
 JCG1FqoDqBBvdF6jxIsz1+ZZSdvtnQ6OgJuWi9kdECsiya8QXoWlWnyYpyn9aTFtw2Q1
 1hKjCULjU9FwzsPoJbnL3GrIUbQdAphGU8sDh9drr8xBDMMS/zHoJ6bJThYqns+NzAgF
 Aty7ebbtt1MB7jjhjMfb1Kad1WemfHeq4ApCyeLp3Yw5B4gEq2+Zk1yhSVhNZRiGdSbv
 1nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307770; x=1688899770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5e3yMzYK/XMG3H3RL9muHnEQj6ptqEInvr2skv+z8Do=;
 b=E1YCohIidLx3lkwj7sBpmA7vrbWfWBE95+8a5K9hGwN+Wbv+RpfQFlq+5PhCvHm4Tf
 6x+rTLQ0DzOxqpVdggtHeD4QcuKNBOvd/R9TH29E5n04pvnsBDZbwPJ8Hnp78ICAr8nT
 jVG0iH6fe/U14WgYlFsqzOjRehxxgRTpFI6wchLAXogSaBoQddPUpbD9gAfTLxNeFXhg
 q7hdlx6Lj3IwewJNlUrQoJ1vIHuaGJPni3wJBHHcenyU5Kx+DcMTDy9AherzGQePOJgR
 aR9Gsc+6g62Oqv8+QH0LgsSZ0gQERrGgvL5cBYyWMQl21p9HsnwCfbun3TJ6nyy3M8Xh
 lrBg==
X-Gm-Message-State: AC+VfDzfiYgWGoYX7tEXme8i94SrILvztL2xTCqwqhQ4mZd5IWlYNuqd
 B9Gf3ucoV8Gcg0o9+E8Wt1QC3ep6qLfqXI8AnGek/w==
X-Google-Smtp-Source: ACHHUZ5DyfMelH8qEBjSbF6yPZNsXLi6NuBXjlDBOAYX+S4axCqFVQ2+oAzm/p20zjUHJcga16G5jQ==
X-Received: by 2002:a05:600c:3793:b0:3f4:2255:8608 with SMTP id
 o19-20020a05600c379300b003f422558608mr793429wmr.31.1686307770056; 
 Fri, 09 Jun 2023 03:49:30 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d650f000000b0030adfa48e1esm4086814wru.29.2023.06.09.03.49.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:49:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/22] target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
Date: Fri,  9 Jun 2023 12:47:15 +0200
Message-Id: <20230609104717.95555-21-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Instead of including helper-a64.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 1 -
 target/arm/tcg/helper-a64.c    | 5 +++++
 target/arm/tcg/mte_helper.c    | 4 ++++
 target/arm/tcg/pauth_helper.c  | 4 ++++
 target/arm/tcg/sve_helper.c    | 5 +++++
 target/arm/tcg/translate-a64.c | 6 ++++++
 target/arm/tcg/vec_helper.c    | 5 +++++
 7 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c1fb9b7b50..9cdfe6c148 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -557,6 +557,5 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 #ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h.inc"
 DEF_HELPER_FLAGS_3(set_svcr, TCG_CALL_NO_RWG, void, env, i32, i32) /* SME */
 #endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1c9370f07b..f5abca6774 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -35,6 +35,11 @@
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
 uint64_t HELPER(udiv64)(uint64_t num, uint64_t den)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9c64def081..4a5fa185ae 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,6 +29,10 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
 {
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 62af569341..1bcdcec5ab 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -26,6 +26,10 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 static uint64_t pac_cell_shuffle(uint64_t i)
 {
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 01dd13c955..42c81de0c3 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -39,6 +39,11 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
  * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 06ad40a568..150a9ad821 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -36,6 +36,12 @@
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
index 972f538c63..8fb44a8b7f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -40,6 +40,11 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


