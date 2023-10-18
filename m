Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC837CEB3A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzV-00086J-0h; Wed, 18 Oct 2023 18:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzS-000854-3w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzQ-0002TY-CC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1caa371dcd8so12745695ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667967; x=1698272767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=kklKVsv4uP8wBr4z+PD5akacKFx/MT+hn1t/CKeHDEHb38ljpTPYYpzU84IWxjoguT
 tB9Z+VXTuswLvKZU8av/EFmFu/VojmDIsyD+mGUWQ0uQoMC4wRgIbm1ay0tTi7bJOXN4
 sMDqnHPCB2oT+DXYoNnC4rIiA8ANytwB0IRkhwcgCPkrJ79SYCNyDmVOc/1xeqp6dzR5
 gIOTfa7f1z0/BwfzI0upqAnsGIqwl39NC2z6xDOoexMIhv25ANVqHHF8bwAXBET7CpiM
 EDPiXTWhLkU3gavwqaFU9QUlCylZKaehwcncX43cMiMZuztxGUBJz5A64Sip+vsn+Nqo
 2xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667967; x=1698272767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gXGK6fIVAMAIDlPSRafHxXOFGChnJBeeF+QM2JUpio=;
 b=ml2vPUwv6BMD88C5WYJNKsukgPk0mSaNDfvyR+klZpKtsOQWBgyuPe7j/3hy7NB0ei
 /AdfwpH0q44IPz7+60Gv5LnNo29qZTvdPi6D/EHMsfJR5YpUCzQh7/tBZNxpeLukMXVL
 BsfqRdtJbaemrCP7JnZkPyLILggK9Gab3SCxog8VjK2RbC+9gB0yf9Ur0sET59D6OtRv
 KLD//7ESk2vz+Dpx21KW6loxiJ3F8QWi364vy5IgyFx4ZU3HCmBuRfbYuux1ulTZZvdA
 UQWVhfMYAPixJavsWrVDtdo1nt058OqNmdQJcGwU6ln1NhraIpAb+1JztkasL5aws6oY
 vz2g==
X-Gm-Message-State: AOJu0YzQmEjbYV9pviIsSoIUWRtXlaU/7xw0LDCP3pYVb+Vpc8uA8M0F
 ju5Nxt5Ic4rAVVbT1L5rkq76M4kjKOdFpn4nZnM=
X-Google-Smtp-Source: AGHT+IEVxGCGkaNSvdTF93J9ycVR8Mhr6XN2kynjXmoWekUb/hpeLveE1swEKzk0IY0kNYRiL1kWeQ==
X-Received: by 2002:a17:902:f9c3:b0:1c6:30d1:7214 with SMTP id
 kz3-20020a170902f9c300b001c630d17214mr641119plb.55.1697667967188; 
 Wed, 18 Oct 2023 15:26:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Wed, 18 Oct 2023 15:25:38 -0700
Message-Id: <20231018222557.1562065-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


