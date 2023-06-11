Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0172B375
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 20:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8QBq-00006X-HU; Sun, 11 Jun 2023 14:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBp-00006N-8q
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:25 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBn-0001n8-CE
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VQpNYELafW+779uTstjQWHaGWz+0brh7mugbZGGVmA0=; b=ONL7zMpO864wMj/KE8Y9IWsM/K
 VNpvhB0+I3RkDXt50G91zBlSSMs5cX8v6sZd12Wp8hdqnTTT3c0BoRdmWRYZ8gQokDAHxFH3ChNdb
 oXTEKFpSPJjds3rr8MPmuP5v6+39+LUJpv6/w0e23vTB4iWA8icaSjEZyVshNwoQSaU0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 6/6] target/tricore: Add shuffle insn
Date: Sun, 11 Jun 2023 20:52:13 +0200
Message-Id: <20230611185213.51345-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
References: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.11.183916, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=354492, da=174118665, mc=40, sc=0,
 hc=40, sp=0, fso=354492, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

this is based on code by volumit (https://github.com/volumit/qemu/)

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
v1 -> v2:
    - Shuffle now uses shifts, instead of a buffer
    - Shuffle now does rev8 for all bytes in parallel

 target/tricore/helper.h          |  1 +
 target/tricore/op_helper.c       | 36 ++++++++++++++++++++++++++++++++
 target/tricore/translate.c       |  8 +++++++
 target/tricore/tricore-opcodes.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index a10576e09e..31d71eac7a 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -134,6 +134,7 @@ DEF_HELPER_FLAGS_5(mulr_h, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32b, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32_be, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(crc32_le, TCG_CALL_NO_RWG_SE, i32, i32, i32)
+DEF_HELPER_FLAGS_2(shuffle, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 /* CSA */
 DEF_HELPER_2(call, void, env, i32)
 DEF_HELPER_1(ret, void, env)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index b6ef1462e4..026e15f3e0 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2308,6 +2308,42 @@ uint32_t helper_crc32_le(uint32_t arg0, uint32_t arg1)
     return crc32(arg1, buf, 4);
 }
 
+uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
+{
+    uint32_t resb;
+    uint32_t byte_select;
+    uint32_t res = 0;
+
+    byte_select = arg1 & 0x3;
+    resb = extract32(arg0, byte_select * 8, 8);
+    res |= resb << 0;
+
+    byte_select = (arg1 >> 2) & 0x3;
+    resb = extract32(arg0, byte_select * 8, 8);
+    res |= resb << 8;
+
+    byte_select = (arg1 >> 4) & 0x3;
+    resb = extract32(arg0, byte_select * 8, 8);
+    res |= resb << 16;
+
+    byte_select = (arg1 >> 6) & 0x3;
+    resb = extract32(arg0, byte_select * 8, 8);
+    res |= resb << 24;
+
+    if (arg1 & 0x100) {
+        /* Assign the correct nibble position.  */
+        res = ((res & 0xf0f0f0f0) >> 4)
+          | ((res & 0x0f0f0f0f) << 4);
+        /* Assign the correct bit position.  */
+        res = ((res & 0x88888888) >> 3)
+          | ((res & 0x44444444) >> 1)
+          | ((res & 0x22222222) << 1)
+          | ((res & 0x11111111) << 3);
+    }
+
+    return res;
+}
+
 /* context save area (CSA) related helpers */
 
 static int cdc_increment(target_ulong *psw)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 85526ef4db..a4c60e8ae2 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5011,6 +5011,14 @@ static void decode_rc_logical_shift(DisasContext *ctx)
     case OPC2_32_RC_XOR:
         tcg_gen_xori_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
+    case OPC2_32_RC_SHUFFLE:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            TCGv temp = tcg_constant_i32(const9);
+            gen_helper_shuffle(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 27f80e1702..af63926731 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -885,6 +885,7 @@ enum {
     OPC2_32_RC_SHAS                              = 0x02,
     OPC2_32_RC_XNOR                              = 0x0d,
     OPC2_32_RC_XOR                               = 0x0c,
+    OPC2_32_RC_SHUFFLE                           = 0x07, /* v1.6.2 only */
 };
 /* OPCM_32_RC_ACCUMULATOR                           */
 enum {
-- 
2.40.1


