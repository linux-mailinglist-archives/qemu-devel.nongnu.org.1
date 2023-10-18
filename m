Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B37CEB31
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzU-00085u-0S; Wed, 18 Oct 2023 18:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzQ-00084X-Rh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:08 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzP-0002TJ-5U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:08 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso4541066a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667965; x=1698272765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=Br+uZt44LqQLFnY7sWum+dgFTNGGc3UtqeB++I2B9vI+GlrkvFT8v1Q0qEnAPuWRyR
 rRCBvsGScHkMOHIV7TLd3Q8sCubNFyvf2Z5cM/hYA3oqi+hJ93YdV6saw7C6CJmQNMCP
 ZVKh2neM2SxtiRDjioiDVZhzr562XMPPyYAYvkFRsz7V9K0R1YF1/ejzLndT0r6zjjzs
 fAi57s6ODorzrbV/5EXK7x2EvLEekS9uz3UfTw3lX3trPRXcA+1F9E97EKc57ME7Lv+V
 LcdtBUwf4EADDWjEW9W+SUGhZZYUFC6RSpo/CpnW+t/V0rY0kGg8EItQffC+ulEk3CbA
 5BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667965; x=1698272765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcT+t2NWvvAgl7ag7U9fcr97JnnF4drB4JEVTRDmT40=;
 b=d5nDblBkRkC+NQq6wc+hkPvz0Q5U3otjOqkphWfOK7/9PwRfeolnzdwgWjFVk2rbTE
 HBsT80oQ6CVsWdpUAY78LLVgmwg+LaksrKwGD39CeGsAGgdRhGVkqvW3r4P34/NX0LTE
 0RGun0BJw0E/fFnhox5OcRBk6haWmJXNOLHdpqPkrNT4A2aDwQFV/umYN3zRAC7iqWLF
 ahOW1sIwPjtLKc8wNEOvynSS3n8/INa5KarvEN5uoL2fsqKPl3d8EeFyFO+ugbFLZ9Nv
 /oDqr0NGLiJeiGyosiEp3dd/TH6/q9Ndtu4K09p+4fuVDw+KaP0f5cTaTmGyxvQOe7sB
 vz3g==
X-Gm-Message-State: AOJu0Yzkdk0T15NIyPYX2dcGXCTd9w9KAmY8O/WZzVBc0bJ5o5zR6EEL
 Ad3UpEFvintlKtulktLXsfXR8vcLOrbPMW63MaY=
X-Google-Smtp-Source: AGHT+IHv+gQklcvjv3kle42MOUSroOcJSFU+l3di9KoEkjqsjm9m2QrIOuwEZ542IVaqOH/iE1LYvw==
X-Received: by 2002:a05:6a20:da93:b0:17b:2c56:70b8 with SMTP id
 iy19-20020a056a20da9300b0017b2c5670b8mr681861pzb.22.1697667965647; 
 Wed, 18 Oct 2023 15:26:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL 08/29] tcg/ppc: Use PADDI in tcg_out_movi
Date: Wed, 18 Oct 2023 15:25:36 -0700
Message-Id: <20231018222557.1562065-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

PADDI can load 34-bit immediates and 34-bit pc-relative addresses.

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6337b1e8be..f4235383c6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -719,6 +719,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     return true;
 }
 
+/* Ensure that the prefixed instruction does not cross a 64-byte boundary. */
+static bool tcg_out_need_prefix_align(TCGContext *s)
+{
+    return ((uintptr_t)s->code_ptr & 0x3f) == 0x3c;
+}
+
+static void tcg_out_prefix_align(TCGContext *s)
+{
+    if (tcg_out_need_prefix_align(s)) {
+        tcg_out32(s, NOP);
+    }
+}
+
+static ptrdiff_t tcg_pcrel_diff_for_prefix(TCGContext *s, const void *target)
+{
+    return tcg_pcrel_diff(s, target) - (tcg_out_need_prefix_align(s) ? 4 : 0);
+}
+
+/* Output Type 10 Prefix - Modified Load/Store Form (MLS:D) */
+static void tcg_out_mls_d(TCGContext *s, tcg_insn_unit opc, unsigned rt,
+                          unsigned ra, tcg_target_long imm, bool r)
+{
+    tcg_insn_unit p, i;
+
+    p = OPCD(1) | (2 << 24) | (r << 20) | ((imm >> 16) & 0x3ffff);
+    i = opc | TAI(rt, ra, imm);
+
+    tcg_out_prefix_align(s);
+    tcg_out32(s, p);
+    tcg_out32(s, i);
+}
+
 static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset);
 
@@ -1017,6 +1049,25 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /*
+     * Load values up to 34 bits, and pc-relative addresses,
+     * with one prefixed insn.
+     */
+    if (have_isa_3_10) {
+        if (arg == sextract64(arg, 0, 34)) {
+            /* pli ret,value = paddi ret,0,value,0 */
+            tcg_out_mls_d(s, ADDI, ret, 0, arg, 0);
+            return;
+        }
+
+        tmp = tcg_pcrel_diff_for_prefix(s, (void *)arg);
+        if (tmp == sextract64(tmp, 0, 34)) {
+            /* pla ret,value = paddi ret,0,value,1 */
+            tcg_out_mls_d(s, ADDI, ret, 0, tmp, 1);
+            return;
+        }
+    }
+
     /* Load 32-bit immediates with two insns.  Note that we've already
        eliminated bare ADDIS, so we know both insns are required.  */
     if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
-- 
2.34.1


