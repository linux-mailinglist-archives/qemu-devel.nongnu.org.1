Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBF7B168F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlmm1-0006Wt-HX; Thu, 28 Sep 2023 04:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmlx-0006Vu-JR
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:25 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmlu-0004vB-2p
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5I3hxpXIo/Aj9WtZLitXsFXjv/wDHOVI3zcJt8ymVSQ=; b=Kv/6qw79kCtTIX5X1TOuh7s07F
 oGnRzdNuwfTTJsrv+Q4MufjbhHcTNWfWjVITwO8jFggtH11ENGLVA7gCGlwzOFYfeLIUOiHZ7eUsD
 B9GY54NHxsOIbIFJRIS061uWz/w8a5C2k/e3QJSbOXlnA9YuRskfuvFM0RXyfrkak2U4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 02/21] target/tricore: Implement CRCN insn
Date: Thu, 28 Sep 2023 10:52:44 +0200
Message-ID: <20230928085303.511518-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
References: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.28.84518, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.28.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=83833, da=183500262, mc=21, sc=0,
 hc=21, sp=0, fso=83833, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

reported in https://gitlab.com/qemu-project/qemu/-/issues/1667

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-3-kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.h                   |  1 +
 target/tricore/op_helper.c                | 63 +++++++++++++++++++++++
 target/tricore/translate.c                |  8 +++
 target/tricore/tricore-opcodes.h          |  1 +
 tests/tcg/tricore/Makefile.softmmu-target |  1 +
 tests/tcg/tricore/asm/test_crcn.S         |  9 ++++
 6 files changed, 83 insertions(+)
 create mode 100644 tests/tcg/tricore/asm/test_crcn.S

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 31d71eac7a..190645413a 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -134,6 +134,7 @@ DEF_HELPER_FLAGS_5(mulr_h, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32b, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32_be, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32_le, TCG_CALL_NO_RWG_SE, i32, i32, i32)
+DEF_HELPER_FLAGS_3(crcn, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_2(shuffle, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 /* CSA */
 DEF_HELPER_2(call, void, env, i32)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 89be1ed648..0cf8eb50bd 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2308,6 +2308,69 @@ uint32_t helper_crc32_le(uint32_t arg0, uint32_t arg1)
     return crc32(arg1, buf, 4);
 }
 
+static uint32_t crc_div(uint32_t crc_in, uint32_t data, uint32_t gen,
+                        uint32_t n, uint32_t m)
+{
+    uint32_t i;
+
+    data = data << n;
+    for (i = 0; i < m; i++) {
+        if (crc_in & (1u << (n - 1))) {
+            crc_in <<= 1;
+            if (data & (1u << (m - 1))) {
+                crc_in++;
+            }
+            crc_in ^= gen;
+        } else {
+            crc_in <<= 1;
+            if (data & (1u << (m - 1))) {
+                crc_in++;
+            }
+        }
+        data <<= 1;
+    }
+
+    return crc_in;
+}
+
+uint32_t helper_crcn(uint32_t arg0, uint32_t arg1, uint32_t arg2)
+{
+    uint32_t crc_out, crc_in;
+    uint32_t n = extract32(arg0, 12, 4) + 1;
+    uint32_t gen = extract32(arg0, 16, n);
+    uint32_t inv = extract32(arg0, 9, 1);
+    uint32_t le = extract32(arg0, 8, 1);
+    uint32_t m = extract32(arg0, 0, 3) + 1;
+    uint32_t data = extract32(arg1, 0, m);
+    uint32_t seed = extract32(arg2, 0, n);
+
+    if (le == 1) {
+        if (m == 0) {
+            data = 0;
+        } else {
+            data = revbit32(data) >> (32 - m);
+        }
+    }
+
+    if (inv == 1) {
+        seed = ~seed;
+    }
+
+    if (m > n) {
+        crc_in = (data >> (m - n)) ^ seed;
+    } else {
+        crc_in = (data << (n - m)) ^ seed;
+    }
+
+    crc_out = crc_div(crc_in, data, gen, n, m);
+
+    if (inv) {
+        crc_out = ~crc_out;
+    }
+
+    return extract32(crc_out, 0, n);
+}
+
 uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
 {
     uint32_t resb;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6ae5ccbf72..4e7e18f985 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6669,6 +6669,14 @@ static void decode_rrr_divide(DisasContext *ctx)
         gen_helper_pack(cpu_gpr_d[r4], cpu_PSW_C, cpu_gpr_d[r3],
                         cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RRR_CRCN:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            gen_helper_crcn(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r2],
+                            cpu_gpr_d[r3]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RRR_ADD_F:
         gen_helper_fadd(cpu_gpr_d[r4], cpu_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index bc62b73173..f070571665 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1247,6 +1247,7 @@ enum {
     OPC2_32_RRR_SUB_F                            = 0x03,
     OPC2_32_RRR_MADD_F                           = 0x06,
     OPC2_32_RRR_MSUB_F                           = 0x07,
+    OPC2_32_RRR_CRCN                             = 0x01, /* 1.6.2 up */
 };
 /*
  * RRR1 Format
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index d556201b07..b8d9b33933 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -9,6 +9,7 @@ CFLAGS = -mtc162 -c -I$(TESTS_PATH)
 TESTS += test_abs.asm.tst
 TESTS += test_bmerge.asm.tst
 TESTS += test_clz.asm.tst
+TESTS += test_crcn.asm.tst
 TESTS += test_dextr.asm.tst
 TESTS += test_dvstep.asm.tst
 TESTS += test_fadd.asm.tst
diff --git a/tests/tcg/tricore/asm/test_crcn.S b/tests/tcg/tricore/asm/test_crcn.S
new file mode 100644
index 0000000000..51a22722a3
--- /dev/null
+++ b/tests/tcg/tricore/asm/test_crcn.S
@@ -0,0 +1,9 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+#                insn num    result   rs1    rs2     rs3
+#                 |     |      |      |       |       |
+    TEST_D_DDD(crcn, 1, 0x00002bed, 0x0, 0xa10ddeed, 0x0)
+
+    TEST_PASSFAIL
-- 
2.42.0


