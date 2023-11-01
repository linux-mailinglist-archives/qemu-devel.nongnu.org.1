Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79E7DDBC7
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2a8-0005xG-Vz; Wed, 01 Nov 2023 00:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a4-0005wd-4H
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a2-0007Z9-JL
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso5643771b3a.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811905; x=1699416705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZkO6iqKWX4I1s0DyhknSmjSbYejENxIsODXN3qfxME=;
 b=HHr1fV+zvX+cuV7GAX5khKztBux8EnULqRYzCqJbe4U9OfpQxxmN3OA8RmtSu+2kUx
 pY2MG4gj6ME3QVKiz23MuHbxxiSs8QhvX6eHd8kLs+jE3WfNlZdcqzkLI+llXgqTTHPy
 yI0gIEy6gkKJ9QnJHulTJIknRD29jyrgdZph/1tVMPmlica0L9qIuzQuyY0/sV5DzNNf
 dYwevb/TXDmLbYl+TIqv4MAivX9PA4CWWV9jvxNDNH/QeuiQLvMEbMls+LfyaxvQ+DTo
 NLKD86xKv8+ggcutV2OmkiIIYBhiqg0RunrpoOBKUCZnqcYXjFHrOheST03QHKGEOz24
 7qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811905; x=1699416705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZkO6iqKWX4I1s0DyhknSmjSbYejENxIsODXN3qfxME=;
 b=fKEog6c84pPysCa28ryDv74Dhh5K6FacsRps1uIbsKcgqZfUYUuxmA9HwWKGx5fu5o
 E+1RfaE4UrkcUacYzO4HaZpUGLCHNtAWf2iBd9bLXcGyBh7OceuP+gV72vw4tnmH7Ern
 pJJuBEGYKUqOnOi89OGi4s5xh6KwH1/wIzt0vUsSOahSNvuw2tq/pLa5BSCy7Lrd5zR0
 k68UbJG8iJKpN8FzVPagZOSRfZbAxGThaHZrFBDQx6XXZdvPeWnXv73Wfb2CiTIGjpeL
 a4eHUwEXx6fThto3szd1ivY56bgr6V9NToPWfBqZ4DKP/bbWLMRK/TiBU8gc0wbeU4gy
 7g1g==
X-Gm-Message-State: AOJu0YwcsdAKLkJDJAha9WdqBWrngzY6qniESxA+hl1Gw6WhNL9VZXW0
 6jVP3SeRM4v+bePDTBq4sY0Ps0lss0w23vyBtdo=
X-Google-Smtp-Source: AGHT+IFJaXtVd0kugJhwWDOIdigOmwsOdiOvVZW1U0N6i4Qu/hlybn5vc3cxAehFXWuS4nj+Wl9H9w==
X-Received: by 2002:a05:6a00:1a50:b0:68e:399e:70db with SMTP id
 h16-20020a056a001a5000b0068e399e70dbmr13046017pfv.6.1698811905072; 
 Tue, 31 Oct 2023 21:11:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/21] target/sparc: Merge gen_branch2 into advance_pc
Date: Tue, 31 Oct 2023 21:11:24 -0700
Message-Id: <20231101041132.174501-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The function had only one caller.  Canonicalize the cpu_cond
test to TCG_COND_NE, the "natural" sense of its value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2e7deb5e33..e134ba8821 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -908,19 +908,6 @@ static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
-static void gen_branch2(DisasContext *dc, target_ulong pc1,
-                        target_ulong pc2, TCGv r_cond)
-{
-    TCGLabel *l1 = gen_new_label();
-
-    tcg_gen_brcondi_tl(TCG_COND_EQ, r_cond, 0, l1);
-
-    gen_goto_tb(dc, 0, pc1, pc1 + 4);
-
-    gen_set_label(l1);
-    gen_goto_tb(dc, 1, pc2, pc2 + 4);
-}
-
 static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
@@ -2352,6 +2339,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
+    TCGLabel *l1;
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case DYNAMIC_PC:
@@ -2359,11 +2348,22 @@ static bool advance_pc(DisasContext *dc)
             dc->pc = dc->npc;
             gen_op_next_insn();
             break;
+
         case JUMP_PC:
             /* we can do a static jump */
-            gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
+            l1 = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_cond, 0, l1);
+
+            /* jump not taken */
+            gen_goto_tb(dc, 1, dc->jump_pc[1], dc->jump_pc[1] + 4);
+
+            /* jump taken */
+            gen_set_label(l1);
+            gen_goto_tb(dc, 0, dc->jump_pc[0], dc->jump_pc[0] + 4);
+
             dc->base.is_jmp = DISAS_NORETURN;
             break;
+
         default:
             g_assert_not_reached();
         }
-- 
2.34.1


