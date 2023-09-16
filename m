Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924F7A2DB2
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0y-000602-2q; Fri, 15 Sep 2023 23:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0s-0005xj-E3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0q-00081f-RF
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-577f6b414a4so2237635a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835027; x=1695439827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eOYNL0g4TIMOAag4ANmjq3QIDjxlPOz2NzGZ1yhpaw=;
 b=NS1scZ5znpAx2XhMGsS20Yoh85tkmGQ74i2P5IMaRsouCYhBZ3KhQQquHt//38gOAC
 uTsiVIiUYUMF88IXtzxetO+ip5DtiZQ/3ofrME5oJ6/tG5bQi/VYfwbiLwEc7BJ1LcYe
 CU5/Op03aEWUGNUwoTbCtYUmrS4KA/rp7gKkrC/ycvmL3ICLJ26RGNN8wa+ma/Px84me
 7tOLQm/QBYmIzVpfQAXoNR+sgqN3LdBlw48ORK3RKdkZTV9OgaxJ+ILrAskP6BDi3i5J
 kCVHE7UB1EEVcdX1cEUyFKO7VKoBIph2x0xgwJ3nexHxSgOuxH7cXYEylFPdzNylDF2z
 jAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835027; x=1695439827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eOYNL0g4TIMOAag4ANmjq3QIDjxlPOz2NzGZ1yhpaw=;
 b=Iim6vOQyzVmGZi0TnL9J3Q/3SoE3MaKRn0HzTgmxS23iSenN/Rw1GNqjLfwjzSpSp0
 QqL/PmuaZhn4U8G25WHCMZ+6t0nitINePkvPB5+8c7MYfom5lBFZHTN4aLFbLJIFTo5Y
 9cnjg9QBZRkqCh3G8tvdHdVZ70KSYcG6/9fDIDUgYfTugYjLnF1enLODnmMcZcPPr89R
 ne3YySNVEp5ltTI5bOUQA4YI3DaaRuH7BWcgCTqyZCMpgUAyf/zV2R0df9dageKTu3FN
 PdEV6UlMKQZWXhVY9HzimOFGOWzol5QzSDRzawIyErj3xoGGiTdNNpdQZuGfjzXUuc/D
 1geg==
X-Gm-Message-State: AOJu0Yxx1h7gtp2IaUaIvKVljLOsALnCINIeNvQ4dYCNSkQZFcOu4K1D
 P5PM2+w+f5GOysjN218CXaPllc4vYrL2QPfc1Go=
X-Google-Smtp-Source: AGHT+IFdsgajO5I1RishVOdwAjaDVemWre3D9MJ3JKwHzy6VmhaKSBZ7V9tFTuDKMtlYqhjwb3sgWw==
X-Received: by 2002:a05:6a21:4882:b0:137:d14d:79ea with SMTP id
 av2-20020a056a21488200b00137d14d79eamr3332698pzc.25.1694835027397; 
 Fri, 15 Sep 2023 20:30:27 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 15/39] tcg/loongarch64: Lower vector saturated ops
Date: Fri, 15 Sep 2023 20:29:47 -0700
Message-Id: <20230916033011.479144-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

From: Jiajie Chen <c@jia.je>

Lower the following ops:

- ssadd_vec
- usadd_vec
- sssub_vec
- ussub_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-11-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index ec725aaeaa..fa14558275 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -192,7 +192,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bdf22d8807..90c52c38cf 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1713,6 +1713,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn umax_vec_insn[4] = {
         OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU
     };
+    static const LoongArchInsn ssadd_vec_insn[4] = {
+        OPC_VSADD_B, OPC_VSADD_H, OPC_VSADD_W, OPC_VSADD_D
+    };
+    static const LoongArchInsn usadd_vec_insn[4] = {
+        OPC_VSADD_BU, OPC_VSADD_HU, OPC_VSADD_WU, OPC_VSADD_DU
+    };
+    static const LoongArchInsn sssub_vec_insn[4] = {
+        OPC_VSSUB_B, OPC_VSSUB_H, OPC_VSSUB_W, OPC_VSSUB_D
+    };
+    static const LoongArchInsn ussub_vec_insn[4] = {
+        OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1829,6 +1841,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         tcg_out32(s, encode_vdvjvk_insn(umax_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_ssadd_vec:
+        tcg_out32(s, encode_vdvjvk_insn(ssadd_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_usadd_vec:
+        tcg_out32(s, encode_vdvjvk_insn(usadd_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sssub_vec:
+        tcg_out32(s, encode_vdvjvk_insn(sssub_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_ussub_vec:
+        tcg_out32(s, encode_vdvjvk_insn(ussub_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1860,6 +1884,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
         return 1;
     default:
         return 0;
@@ -2039,6 +2067,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
-- 
2.34.1


