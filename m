Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89E770B0E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qz-0006Dt-JO; Fri, 04 Aug 2023 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qw-00068y-6y
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qs-0001tQ-6T
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bbf0f36ce4so18515105ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184840; x=1691789640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSfXUkEbJi6XSSeczzkehSgMMZNGjw0txB1UvXtXqsU=;
 b=e46yjR1QGQgC3aQQU5JqDJhotcAD2xGjqiPOQeo/qbXypkWLdO9quaFZFY1vzzA65T
 pqAA5ibS/c+iMvCw3FPZLvPZ4XxOUXNYYhgBMbX+gJi7D3CRbzCLnQVOQu/VcLn1JC8V
 7UiuzUtub0Zh4cKNufAQMmdZTtcuxWiTuFcXQRphj7xnkeXWd3WW8jny5cKbeMvcATCn
 L+fQDw+/v0584qdGPYaKXtOIu8TbUa4AcoKquiKhGAsH7OFtK7u7PI3PBlDX5QN2Euwn
 yx5Mj+hwplUKSNUg7ymK21AFT785c1I8jc0Pb/+SF6xkz7Aq9+b4fZoCSwmYIQ/jz/v8
 TEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184840; x=1691789640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSfXUkEbJi6XSSeczzkehSgMMZNGjw0txB1UvXtXqsU=;
 b=HByoDvHLtx5TJhTIiABb5wct5QVEHO3/n1LBTJSeHO7RiWid9qLCTyxQTPS35TVZf4
 I56K/MQpcNnBeOQgaGczDvVIpAfiTeE6mo+bZxFmkBDgI2evT+XYIhJUxQt2uw8+pKel
 xAx9NGdndOYmwJTZUg626imLzaE8WgeLmfS9L9iYuDk7XX6Fssyxo0xoWhAnxdUmm1W/
 ZdUwcptpzdITjbRfataejdiV4BcdCv8ulpb45nMaCz3Xffg53XEyBKMq+3xtgsVdrXzh
 uB7i1I2/x/VXdyOZPjjAqNplotydZ2W62KzSEiotVSZlP9KOT6PxNxfcEe0WYN7hLc7/
 7IzA==
X-Gm-Message-State: AOJu0YyY6ZafKlaGs21tZsrAbCYE/mhlewTH4PXs+UlhZCBlFE/DpcHk
 uKEmnplezOsVLxCbiavEFlclhgKAcMlIS8J0H2Q=
X-Google-Smtp-Source: AGHT+IHWatTGraHggSiSypFaVcTBX9DkrquaG5XZB14a5TePne2gO5ELwzCij36mb852vDSPbDbNSg==
X-Received: by 2002:a17:902:6a85:b0:1bb:7a73:6b59 with SMTP id
 n5-20020a1709026a8500b001bb7a736b59mr2433016plk.32.1691184840155; 
 Fri, 04 Aug 2023 14:34:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:33:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 4/7] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Fri,  4 Aug 2023 14:33:52 -0700
Message-Id: <20230804213355.294443-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index d41c499b7d..a9e48a51c8 100644
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
@@ -260,6 +264,19 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
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
 static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 {
@@ -684,6 +701,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc14(code_ptr, target);
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
+    case R_PPC64_PCREL34:
+        return reloc_pc34(code_ptr, target);
     case R_PPC_ADDR16:
         /*
          * We are (slightly) abusing this relocation type.  In particular,
@@ -1107,6 +1126,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Use the constant pool, if possible.  */
+    if (have_isa_3_10) {
+        tcg_out_8ls_d(s, PLD, ret, 0, 0, 1);
+        new_pool_label(s, arg, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        return;
+    }
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        tcg_tbrel_diff(s, NULL));
-- 
2.34.1


