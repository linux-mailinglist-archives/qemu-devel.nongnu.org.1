Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2407D3ED1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQx-0005X6-Uv; Mon, 23 Oct 2023 14:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQv-0005Vv-Ki
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQr-00086O-6o
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso2610056b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084819; x=1698689619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=QKMmiCplK/iJXS1XYv4o+C3ELvZmOsait1wOf3MykKISkFtO8GEMpp1b7FPcSp40LI
 6IHkgSIfGwdfzyNuypLWjT73y5ToTUo4wr1ZNpzDrr9rhvhjM0VBXzxQSUESa5xPacDn
 v1SmRiph9W/NuhMLlenkMbJg1K1x7Pf+MJ7P6GSTCW93BS9C+IhgHcfv+YuPG8YdEbRy
 Hkwj+pb4t3oShSiwBvoG4+mq/pTKBnOdRyugfFeQPNC+lfyvFuXyv96C0VpkUSiVwglY
 2x3FC4PBMnQyv5W2MW+ODJ0ek1FW8jl1E55tPSMr61CUHXZPPn7DLjGR5rsGj9WWRMYj
 F5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084819; x=1698689619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=EJlDCWHuRrOw/RqAVD2w4WVuhHli4LKDJIpAJtpHx9SdV8KtZF19lmSpQiBS1GsRgA
 RuZeOidkwDQi05Zy3XSk9SmRzI8fwAI3sA4GWS/GDgilAfUPp8c7vnWSCHQTpMie//Fh
 nVp4R3cZ/YnoPHOl8JpIm95fpDrxTSWK/7+wnq7uktdy9vMi5xS0vcSF62JiLdJE1BNv
 BrlW0BZitLYJlB51iCxPPeTow4AyHXdMIz0n+ZsVYzO7sS39Qj0HcPGa2Xe4tq0+uybm
 Iauq0Y/RMjoUfQI5xWAkeysgXAe4Fbmnlk68ezNHqABx8JLYxWciyBdOtJ2cE25mc6FR
 MBtw==
X-Gm-Message-State: AOJu0Yy13vvblHKRvCN1RWePMRdEtcGwRQ5w5nhmkysnwzLEE6wrmYnf
 mlhVwugLxf+Nnr3ZTV1IFwXSinC0BV4SqbCVm3s=
X-Google-Smtp-Source: AGHT+IHu7H7AF2zbNA9/8Nm0dfuNGqDph1laLiCCd9f4gJ2Z1bbkoZlHcTw9+nsqzI5cOWSaj7t1FA==
X-Received: by 2002:a62:f246:0:b0:691:27b:15b4 with SMTP id
 y6-20020a62f246000000b00691027b15b4mr16940176pfl.5.1698084819628; 
 Mon, 23 Oct 2023 11:13:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/38] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Mon, 23 Oct 2023 11:13:01 -0700
Message-Id: <20231023181329.171490-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The prefixed instruction has a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 34df9144cc..79e82d2f94 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -101,6 +101,10 @@
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
 
+#ifndef R_PPC64_PCREL34
+#define R_PPC64_PCREL34  132
+#endif
+
 #define have_isel  (cpuinfo & CPUINFO_ISEL)
 
 #ifndef CONFIG_SOFTMMU
@@ -266,6 +270,19 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, src_rx);
+
+    if (disp == sextract64(disp, 0, 34)) {
+        src_rw[0] = (src_rw[0] & ~0x3ffff) | ((disp >> 16) & 0x3ffff);
+        src_rw[1] = (src_rw[1] & ~0xffff) | (disp & 0xffff);
+        return true;
+    }
+    return false;
+}
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
@@ -696,6 +713,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc14(code_ptr, target);
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
+    case R_PPC64_PCREL34:
+        return reloc_pc34(code_ptr, target);
     case R_PPC_ADDR16:
         /*
          * We are (slightly) abusing this relocation type.  In particular,
@@ -1155,6 +1174,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_10) {
+        tcg_out_8ls_d(s, PLD, ret, 0, 0, 1);
+        new_pool_label(s, arg, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        return;
+    }
     if (have_isa_3_00) {
         tcg_out_addpcis(s, TCG_REG_TMP2, 0);
         new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
-- 
2.34.1


