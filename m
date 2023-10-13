Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3E7C8C24
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgW-0001Ro-By; Fri, 13 Oct 2023 13:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgC-00013Z-7t
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg8-0005Zw-IN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:27 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b5ef5b947so1425740eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217023; x=1697821823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=IzYvn2T8OuS3mczGb7W2maZalHlQwg/D3g5MItOQ3So0xqsLG/rz5IdS8A3iQc0tLR
 mcmKqhKT9BRQaVfPpA0xia7UVgNdtWLzMJTi47+tqzb5vCFIaUxulyX9rkZJgSTLqoLQ
 q8ff4YUB0MdoF6TW1TO+H88ZETfGzXnIg7/Hh/mqMjkX9wOQkbbENBgNYaKPl8C/J+DI
 pMBSLXbbeETf3SlghKlIh9Xr8Ggmu92ovOVbY8iOs1K+4943TEOy1XRfj1Vx5X0KDHrl
 BlI2eZ1GpXspWEymcG/lHzIRkB7rIxcI5RhVKbqAGvR1wzp05mlOqbfIV1W1HnVYhfXZ
 0DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217023; x=1697821823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=fN7mW21Ul4g9/3Bzv5/RjvNF69npknPkTCIUELZXzX9m/a0LPQeschIC0lVSm2ss9T
 jSNUaQVRK+r0Dmslsnzv/UbBh9Z/DXexZdb4EPeiQiHT67LVoNGyzkrZhQaJaTlvrc+F
 IFxpcvwAsMt+bSYCYEEU7S0OAQARbg/q35l5NBtMH1BOZUrlqEINIvoxSxvqjSYlG56s
 IfBGIpUQTRzp5wyT/zoVdJzqkn6W1WHj7xC9vZbyMDCsFdxhikJnipopocFzyxXPFM1I
 gLwLSUPJRPTnaqa6GXpIFrMYg93czttm52gx8Q/yiZBUlQPTUn1Q5+qEoOEh8II71uD+
 8SFQ==
X-Gm-Message-State: AOJu0YzqRW/aughOLDMH99yS8b9ChyphTTU18/dDygeO+JED8FIOi+4E
 ZB2U04gsyHl/t05g7TKIZiZ/LRms4Eo93GFdwmw=
X-Google-Smtp-Source: AGHT+IE10jjwMz01BbXRt/U22jGVp5oQ/l3FENRjOrM0k0AluIcuZFOcBxWiWHwNLgMx6gNwEp4dnw==
X-Received: by 2002:a05:6358:917:b0:14a:e358:f436 with SMTP id
 r23-20020a056358091700b0014ae358f436mr34972246rwi.1.1697217023263; 
 Fri, 13 Oct 2023 10:10:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 10/13] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Fri, 13 Oct 2023 10:10:09 -0700
Message-Id: <20231013171012.122980-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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


