Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 274807CBAB2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKc-0000rk-Qd; Tue, 17 Oct 2023 02:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0000k0-EK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKO-0003x7-IP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so3139945b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523194; x=1698127994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff/T6JqgX72ZlfkHP0G9H5xez7GKCi6wISPu3JqSWUY=;
 b=PNC8/B5ZlktFPG5QvRHvHpGCms4TP2Nl1f6YwVDaL3HfujVvDqBwsi/8/eIYrxkB0y
 Vzl1Aolfpr8gSzucXtqs7JsZsbDsQyt/HDAYEVnNqH2uZWCPID/z+8qfHGKaXxXCqFSF
 1Zfv1AmhWvsQha1w1Ft8AE3reAessH0rsodHlNtagS4seyNGjxkWw2mNt1sIR0XstGut
 DvFnFjxp5GLqeSSYMFHqmJCrMl8VHt91m95EPvn5IO3w/S62VLxHzQ6aoQUYiCXjqGaE
 Q4xjxtULhZlfUd/aKUNxM0thgUJ0VGAmPNk7cqGb4pV/M8ATf/UOjJi09cjDoVXZ3CwE
 tcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523194; x=1698127994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff/T6JqgX72ZlfkHP0G9H5xez7GKCi6wISPu3JqSWUY=;
 b=TpbM6eIgBa1JVl2B2Llig9X1Ty0Tpg4oQGTiLksTJK9bedHET88Hl/WHOGLhqimZP9
 yDkvfsPHbrl4uORwIS9IVLOWJVdjl2kkYOkZtME+QbeFil6mkcWtoFKyh7C4ar3vHgyg
 hr7HhU5HwG0KLOkKXFFztQQuUf1iqK4gCx4h1/G7hFYZfmvTAleuSdXxhtOuSb0mej91
 dCeHA8sgKGwS6blwus4SsxnnEstZbF+k9Ae0kFfONRCasD1srW5/Tw0JMBK0pjdSg/V+
 yCe1tNtTLqcJ9Ykcbk/PDXHiu/3ZmlxMLsHVnJAu8GZ+K8MEEW8Zr19BkOOyZo8y9zo2
 JB+g==
X-Gm-Message-State: AOJu0YxtsaDR7aOyb7cvzBW05xbMD/o51bEf3drAz4as2QQMc1YKhxwQ
 lqRaeFut6M2IsBlotY6Bv/ZEizw2c6w475NSAHQ=
X-Google-Smtp-Source: AGHT+IFVYDn4s3Nb3qbVEHoGaIxN3HG2Lui2pUeyHgUYKOgrDLyEoWikIF1bDIZ+Wp5rBQrbJ7phog==
X-Received: by 2002:a05:6a21:71ca:b0:169:cd02:65e9 with SMTP id
 ay10-20020a056a2171ca00b00169cd0265e9mr1292003pzc.33.1697523193721; 
 Mon, 16 Oct 2023 23:13:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 33/90] target/sparc: Move SUBC to decodetree
Date: Mon, 16 Oct 2023 23:11:47 -0700
Message-Id: <20231017061244.681584-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c114a13f1d..64f5885e67 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -176,5 +176,7 @@ UMUL        10 ..... 001010 ..... . .............          @r_r_ri
 UMULcc      10 ..... 011010 ..... . .............          @r_r_ri
 SMUL        10 ..... 001011 ..... . .............          @r_r_ri
 SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
+SUBC        10 ..... 001100 ..... . .............          @r_r_ri
+SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b6ec7d5cfd..30eb9bf94b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4236,6 +4236,30 @@ static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
     return advance_pc(dc);
 }
 
+static bool trans_SUBC(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_subx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, false);
+    return advance_pc(dc);
+}
+
+static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_subx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, true);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4660,10 +4684,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xc: /* subx, V9 subc */
-                        gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0xd: /* V9 udivx */
                         gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-- 
2.34.1


