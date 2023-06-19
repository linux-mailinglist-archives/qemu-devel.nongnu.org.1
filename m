Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080D735BBD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGL-0001Pu-TU; Mon, 19 Jun 2023 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFZ-0000KZ-IU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:05 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFX-0005D6-77
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:04 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b47354c658so22577591fa.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190221; x=1689782221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ap8KT7Fdb3QAGckdPQs2Rsqw5VJ2qYfoq7+vsVO9Zvg=;
 b=SOhYYQeC9eTa2ro3tpInUwonWWoUaaRNHZKzQ3GWNCJLZM6ltljPHBp1eQT+DT9U5j
 Rs1L2TVFMJi5sKfG5bLPd45NQVHciyzkDA4UQgxnZ1VW5A/kD6JCx3VpWfjlW6Tmr37t
 mZTVa8xxQznW3I7DYZzU9o2neLyJguVJE5RAOl5I+08AMIT7v1Wz+KjwkPj/T+A5tYky
 spgbRamFQmdSYuplLc5sBJTtumDvSCG1vuD9yG0iBIu+RtIBH375H69Kcv2EFOz4zmx5
 9KE9UaiE6WKcDfDbQ9buiHK6m/6SV1bq5ib5ybTKSTmRqEMtBZcrjyL0KBcYeaQ6z8Vr
 LRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190221; x=1689782221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ap8KT7Fdb3QAGckdPQs2Rsqw5VJ2qYfoq7+vsVO9Zvg=;
 b=NUqO4M9KjW0PTfWtL8WFIttrviQ7wG1xFSZzWLIGhF/QX43qi2txJOAcib911lXCkR
 jfX/yecKk3XOptYz91/i/+y2H02p/xdWRRGbcypHP1J2rGwc22/UAUDPFw68fXtE/MBS
 nxIwZi7oQakvZSA8d9A1vvTA5nzXahPWlRGr3poQeBbdR3mH4Vw/1PhxNJrZQKMw+3/K
 SCWplCxEskrCzz5wnVVp6PbWV1ROzsEHFZPYEksQFX+SPb0nZFOKtQArKntJzOPCwPn4
 kyXLfAHi7yCEeugf5tldKCUecRtfu69LNL7SLU9mgms9g30I1i0o6wOt1y6cFfqD5/ZW
 qX2A==
X-Gm-Message-State: AC+VfDy3VCGoCfd7joVLf/EBBymo49FGNqZYFYkDYU6AK8p/fWANNIi8
 BDm1Kvf3JbhAr64pbmgrpucoT5goXL6oXiuLNH5SZw==
X-Google-Smtp-Source: ACHHUZ619hIrThIVtEUH6VjveF3dpX/fan/tVmJAPxfG4QXc5K+3Mj1I5K2TxdV8SEHKMhsAlcYbgA==
X-Received: by 2002:a2e:888f:0:b0:2b4:85d1:e299 with SMTP id
 k15-20020a2e888f000000b002b485d1e299mr223619lji.5.1687190220783; 
 Mon, 19 Jun 2023 08:57:00 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 lo25-20020a170906fa1900b0098692f1b803sm4425818ejb.166.2023.06.19.08.56.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/34] target/arm/tcg: Extract MemTag definitions to
 'helper-mte.h.inc'
Date: Mon, 19 Jun 2023 17:55:02 +0200
Message-Id: <20230619155510.80991-14-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

helper.h is used by all units, but not all require the crypto
definitions. Move them to a new header, which we only include
where necessary, removing the need for "exec/helper-proto.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/helper-a64.h.inc | 16 ----------------
 target/arm/tcg/helper-mte.h.inc | 23 +++++++++++++++++++++++
 target/arm/tcg/mte_helper.c     |  4 +++-
 target/arm/tcg/translate-a64.c  |  6 ++++++
 4 files changed, 32 insertions(+), 17 deletions(-)
 create mode 100644 target/arm/tcg/helper-mte.h.inc

diff --git a/target/arm/tcg/helper-a64.h.inc b/target/arm/tcg/helper-a64.h.inc
index 2f1aeb3ea5..e975f44bef 100644
--- a/target/arm/tcg/helper-a64.h.inc
+++ b/target/arm/tcg/helper-a64.h.inc
@@ -68,21 +68,5 @@ DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
-
-DEF_HELPER_FLAGS_3(mte_check, TCG_CALL_NO_WG, i64, env, i32, i64)
-DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
-DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
-DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
-
 DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
diff --git a/target/arm/tcg/helper-mte.h.inc b/target/arm/tcg/helper-mte.h.inc
new file mode 100644
index 0000000000..dc954d49a0
--- /dev/null
+++ b/target/arm/tcg/helper-mte.h.inc
@@ -0,0 +1,23 @@
+/*
+ * ARM v8.5-MemTag helper definitions
+ *
+ * Copyright (c) 2020 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+DEF_HELPER_FLAGS_3(mte_check, TCG_CALL_NO_WG, i64, env, i32, i64)
+DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
+
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
+DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9c64def081..89840c6f7e 100644
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
 
+#define HELPER_H "tcg/helper-mte.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0d74e5b6e4..a3d4265f85 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -46,6 +46,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-mte.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-pauth.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
-- 
2.38.1


