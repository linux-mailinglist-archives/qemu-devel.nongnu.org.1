Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B60007D7957
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6w-0002Id-Ex; Wed, 25 Oct 2023 20:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6L-0001Rx-9d
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6F-0006tk-DR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so2295715ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279586; x=1698884386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvPbrl15JgqhGwk9JcRkjLrmHs6hD8F59ocp/OQFjPE=;
 b=Ef613KobZB1+X34OVOYNv7+fQ0M0SLeCUoUBefglu36311oTL9aRT/iOfl9Vd9lZuL
 gY1Lu4DGfWm+teMvPdvT7IMiMFovPHrq1SdiSsXU3W3reAt3pSF//xF4aY0UluxG4T/c
 6nRmUFczcPz+iErYuJWS+xsyH+XM2RlIBVUAWOXSWmUDNQ+S5txsOMDlcK33I8OWAuA3
 2gwRrm0DoqNpsV5d/S0BEI+0o99GrigYyQsV5STa9XwBGi5AqCGo8DBXBV0nMA/aDktX
 O8B4ie/9CLM/h0QP79vNSdBV16PJ35cbJnrBCuSLgcNbU+cn93h/5RTyAa82XlAsNAJx
 msSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279586; x=1698884386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PvPbrl15JgqhGwk9JcRkjLrmHs6hD8F59ocp/OQFjPE=;
 b=vOhns/EOQOTycR9/tagGW61fkgfSDZ9V1XQOcRbQUjbBAZ+jHT3lhmstYBOLiR37CE
 f1Cl8vcM74ENi62PZmcRZ8UYUn8NB7VlkTQgPdPFdrQcWAGLoxGJcpeCu0vPLNh7o2e3
 xJho1AbPq1N0TiR53tombiZ0Txo4NF640qZchH14WoI6lzwvx78WqtrcnDBotutVEALo
 uxRetPVM+PsBG/AndRw59X4336Wf9zYIeSnJT0IuRbskxmgntgHtN5G4NKYwder2XetY
 SWuVGJlahXFh1DYAjslYoqJPfe7i8PIv3ONrZ5xYFFN3pOE0/375QqqO27VcobO0x85p
 FHMQ==
X-Gm-Message-State: AOJu0YwA0iihpy9edirMrVVNirnkhmyktnklDBI27Ajdk7qR5qnL79D6
 BHFkUbxewDxAnPM7S9/HVQRPXkGa/3ArOXX/cVk=
X-Google-Smtp-Source: AGHT+IHMHXtvNvkza2uYKqvys5vCeUU5NSbS4D+OBplLics/UI4ZFMaELHX7UfkZqo8sbSNxXiqMcg==
X-Received: by 2002:a17:902:ec8e:b0:1ca:82f0:131a with SMTP id
 x14-20020a170902ec8e00b001ca82f0131amr19214169plg.19.1698279586024; 
 Wed, 25 Oct 2023 17:19:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 46/94] target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
Date: Wed, 25 Oct 2023 17:14:54 -0700
Message-Id: <20231026001542.1141412-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 35 +++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 271789ac13..aa90b5c5bb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -223,6 +223,10 @@ JMPL        10 ..... 111000 ..... . .............          @r_r_ri
   RETT      10 00000 111001 ..... . .............          @n_r_ri
   RETURN    10 00000 111001 ..... . .............          @n_r_ri
 }
+NOP         10 00000 111011 ----- 0 00000000-----          # FLUSH reg+reg
+NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
+SAVE        10 ..... 111100 ..... . .............          @r_r_ri
+RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 91de0b1206..e0a13e5d29 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4077,6 +4077,11 @@ static bool do_saved_restored(DisasContext *dc, bool saved)
 TRANS(SAVED, 64, do_saved_restored, true)
 TRANS(RESTORED, 64, do_saved_restored, false)
 
+static bool trans_NOP(DisasContext *dc, arg_NOP *a)
+{
+    return advance_pc(dc);
+}
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4457,6 +4462,24 @@ static bool do_return(DisasContext *dc, int rd, TCGv src)
 
 TRANS(RETURN, 64, do_add_special, a, do_return)
 
+static bool do_save(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_save(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(SAVE, ALL, do_add_special, a, do_save)
+
+static bool do_restore(DisasContext *dc, int rd, TCGv src)
+{
+    gen_helper_restore(tcg_env);
+    gen_store_gpr(dc, rd, src);
+    return advance_pc(dc);
+}
+
+TRANS(RESTORE, ALL, do_add_special, a, do_restore)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5272,18 +5295,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 switch (xop) {
                 case 0x38:      /* jmpl */
                 case 0x39:      /* rett, V9 return */
-                    g_assert_not_reached();  /* in decode tree */
-                case 0x3b: /* flush */
-                    /* nop */
-                    break;
+                case 0x3b:      /* flush */
                 case 0x3c:      /* save */
-                    gen_helper_save(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
                 case 0x3d:      /* restore */
-                    gen_helper_restore(tcg_env);
-                    gen_store_gpr(dc, rd, cpu_tmp0);
-                    break;
+                    g_assert_not_reached();  /* in decode tree */
 #if !defined(CONFIG_USER_ONLY) && defined(TARGET_SPARC64)
                 case 0x3e:      /* V9 done/retry */
                     {
-- 
2.34.1


