Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EF7C8F1D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPil-0006NH-J3; Fri, 13 Oct 2023 17:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPij-0006Lz-8P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPie-0000VI-5h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:20 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d425a2dd0so746079a91.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232554; x=1697837354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cismShWEXg2ImkjVEKY2vqS+gdpfbJRGVLz/tWtNjxs=;
 b=fG8o5FkRg0JQrGomFTZntCFS8LibUPNsR/TPdf4CX6IMkZTw7/azlwYWn5wUNUzL1L
 QiB6ebpN61J/NX5zAldteVWSnEo/4Q9SXUGILJOJuqS2y5m5i7OAq6mJTFUQkBPR0S8T
 DAgYbX978Xy8bFhsPhrqP95nRCNmcyANeZIwPflH1S6PoB7/KrwXIsWw+SCOOqDQ/WKa
 AfMVD019ashvmPwiHKkWQ3dPokqZTVcKuyiIDWfCPGfTBFR4BolgLUNi6+j3RUop1g2Z
 XKZ+GLgBGQ8S52okTV/GfHFxwgWv+XP6kBbVDcbOVs8p5RIpqIPGk6XTzsL8jURDa9nw
 0HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232554; x=1697837354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cismShWEXg2ImkjVEKY2vqS+gdpfbJRGVLz/tWtNjxs=;
 b=VjO2MY1EoRUcb1F90EWfYbSgLk5xu5IQEKLLRQy2TNsPUuMuiHGfyzcEzQwTI7gtu8
 LKc7ADwVjJexjcZn25Bdp7yVD8bYGdykd2zy423E61tm8tyYSzt9LuDNSagtkPHOfrOg
 pHZm0YlkDZss2BlAsdG7eY/qgsHvbnMCb4RwhCIRdQ6KuX6Uo/iPGRH8axEVV+gRfGw9
 h6FfvKLoarA1XpJ+2IwBF41/GKrTfiHB238GJnFzIJLI1JcLvohFl3JD4wyTq+jdC1XG
 fCtwqL3pv0xXEEZZCOLc7aBGSLxEUgfKyDPtQxNGWcgNU0qclf/+CDG5jpzOY7C28Q6m
 MYYg==
X-Gm-Message-State: AOJu0Yyv+rBI1mtAMLYNEA1b1VFf59zhy36o1ULiVli7OYb/vlp/piLq
 0WdDrtDJsvUsvX70GG3GxPmHNeGmMJ4ceo/mqxI=
X-Google-Smtp-Source: AGHT+IGG9SRfJi7fiJNLqbIdnuORsc+scbFy79iCZeQH63PnymsD1+yFyP4aHtK+S2FTdIhg1RitsQ==
X-Received: by 2002:a17:90b:4b4d:b0:278:fb87:43e3 with SMTP id
 mi13-20020a17090b4b4d00b00278fb8743e3mr27690000pjb.12.1697232554552; 
 Fri, 13 Oct 2023 14:29:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 28/85] target/sparc: Move SUBC to decodetree
Date: Fri, 13 Oct 2023 14:27:49 -0700
Message-Id: <20231013212846.165724-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
index 9cd89cf03b..69b3e82ae9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -179,3 +179,5 @@ UMUL        10 ..... 001010 ..... . .............          @r_r_ri
 UMULcc      10 ..... 011010 ..... . .............          @r_r_ri
 SMUL        10 ..... 001011 ..... . .............          @r_r_ri
 SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
+SUBC        10 ..... 001100 ..... . .............          @r_r_ri
+SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 38c1f2f79a..1ddf5f3f60 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4201,6 +4201,30 @@ static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
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
@@ -4625,10 +4649,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


