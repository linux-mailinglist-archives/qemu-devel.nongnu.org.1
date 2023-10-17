Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66677CBABA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKJ-0000XA-BK; Tue, 17 Oct 2023 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKF-0000Ox-S9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKD-0003tf-Qy
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso34706385ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523184; x=1698127984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHyb+yTWTZ+oy0MAnuQnnj1Y8pCLIHb/0+zWR2D9dU8=;
 b=wu4EuWG1mu9easul8wW6D9Tzr+6Eu5PdzU9YiM/GEEP3WVtwj0ouQKcmVzNaUzadKu
 w5uTW+fSet8ovDzB3XOAWfyMNdsHi6f2oCSu7jsbLMPaJgDVonePGziMI0kzO7pWFkRH
 cl7yp0OMZd2KYL26LV1VLP6rZcGdL3qa8+l0rLQ/V8l7C6iaCimbPAqopxJfQrkVzeKl
 uLQYeac0hGI4aruzmtk0QP55T52zL11xnnsQyEPLM5u6utR4Ju2fINguTDdhs7mCpaXh
 ZAoDHXHRmSZJENZqvJCOKCGTsQSl7tn7G/9sXwpeaUDfeZPZj9obXCUqdAXoxrxBYlCB
 y3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523184; x=1698127984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHyb+yTWTZ+oy0MAnuQnnj1Y8pCLIHb/0+zWR2D9dU8=;
 b=WvqUGKWqcFxQLqNNbHYKqXKtdWtvpWb4YlQ/IfjnfQx01HbLZCiXaeSJwmtJ8iTQIF
 ZAnAe7h71QG7cqM3C9Pdzu+eFN+06qdtRsZ1uT/rNQMV9nQYUH6JfNPh+Kas1CGkfcqX
 Yqml+MHsa51wuodzF+DqY+TqsTX+/LSrH8a5flGqJOvLnuGqpT2t5xBmCPPZelwaXGz8
 CddXtzu033rVIIGO/TIk54duMW9lpZTbbl5H2c7+JcT+CxHb8vtxQoUXtazK1qaxmJ85
 TOydulftBBJEWzml4gmgYCiUZZvxhO5uSSvXK91XBWC/zn69MoauDrotU4m00VQlTvu3
 +ImQ==
X-Gm-Message-State: AOJu0YyJ6vyqNBlqBVEigzEbjFXeHcNSXe0HrJ1tfDSPIW+urQYp+qdR
 X0OUX4+21l8ZN0drJcQ90X0kMqjq0gLwghXaEfc=
X-Google-Smtp-Source: AGHT+IGnFxCf7vZuHhpprHSefF7bCEK8jMah+9r+Cb6yLPGslVlhHBZk6wwBjToJRfetn5mer5i9kQ==
X-Received: by 2002:a17:903:78f:b0:1ca:86db:1d31 with SMTP id
 kn15-20020a170903078f00b001ca86db1d31mr1067709plb.7.1697523184516; 
 Mon, 16 Oct 2023 23:13:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 22/90] target/sparc: Move RDPSR, RDHPR to decodetree
Date: Mon, 16 Oct 2023 23:11:36 -0700
Message-Id: <20231017061244.681584-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/sparc/insns.decode |  10 ++++
 target/sparc/translate.c  | 112 ++++++++++++++++++++++++--------------
 2 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b3291ea771..8b05b9d8f1 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -45,3 +45,13 @@ Tcc     10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
+
+{
+  RDPSR             10 rd:5  101001 00000 0 0000000000000
+  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+}
+# RDHPR_tstate
+RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0fd454c635..cdfe353596 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -36,7 +36,9 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifndef TARGET_SPARC64
+#ifdef TARGET_SPARC64
+#define gen_helper_rdpsr(D, E)     qemu_build_not_reached()
+#else
 #define gen_helper_rdccr(D, E)     qemu_build_not_reached()
 #endif
 
@@ -260,15 +262,14 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 /* moves */
 #ifdef CONFIG_USER_ONLY
 #define supervisor(dc) 0
-#ifdef TARGET_SPARC64
 #define hypervisor(dc) 0
-#endif
 #else
 #ifdef TARGET_SPARC64
 #define hypervisor(dc) (dc->hypervisor)
 #define supervisor(dc) (dc->supervisor | dc->hypervisor)
 #else
 #define supervisor(dc) (dc->supervisor)
+#define hypervisor(dc) 0
 #endif
 #endif
 
@@ -3337,6 +3338,72 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
 TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
+static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
+{
+    update_psr(dc);
+    gen_helper_rdpsr(dst, tcg_env);
+    return dst;
+}
+
+TRANS(RDPSR, 32, do_rd_special, supervisor(dc), a->rd, do_rdpsr)
+
+static TCGv do_rdhpstate(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld_i64(dst, tcg_env, offsetof(CPUSPARCState, hpstate));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hpstate, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhpstate)
+
+static TCGv do_rdhintp(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hintp;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hintp, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhintp)
+
+static TCGv do_rdhtba(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_htba;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_htba, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtba)
+
+static TCGv do_rdhver(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hver;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hver, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhver)
+
+static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hstick_cmpr;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
+      do_rdhstick_cmpr)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3368,45 +3435,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_tmp0 __attribute__((unused));
 
 #if !defined(CONFIG_USER_ONLY)
-            if (xop == 0x29) { /* rdpsr / UA2005 rdhpr */
-#ifndef TARGET_SPARC64
-                if (!supervisor(dc)) {
-                    goto priv_insn;
-                }
-                update_psr(dc);
-                gen_helper_rdpsr(cpu_dst, tcg_env);
-#else
-                CHECK_IU_FEATURE(dc, HYPV);
-                if (!hypervisor(dc))
-                    goto priv_insn;
-                rs1 = GET_FIELD(insn, 13, 17);
-                switch (rs1) {
-                case 0: // hpstate
-                    tcg_gen_ld_i64(cpu_dst, tcg_env,
-                                   offsetof(CPUSPARCState, hpstate));
-                    break;
-                case 1: // htstate
-                    // gen_op_rdhtstate();
-                    break;
-                case 3: // hintp
-                    tcg_gen_mov_tl(cpu_dst, cpu_hintp);
-                    break;
-                case 5: // htba
-                    tcg_gen_mov_tl(cpu_dst, cpu_htba);
-                    break;
-                case 6: // hver
-                    tcg_gen_mov_tl(cpu_dst, cpu_hver);
-                    break;
-                case 31: // hstick_cmpr
-                    tcg_gen_mov_tl(cpu_dst, cpu_hstick_cmpr);
-                    break;
-                default:
-                    goto illegal_insn;
-                }
-#endif
-                gen_store_gpr(dc, rd, cpu_dst);
-                break;
-            }
             if (xop == 0x2a) { /* rdwim / V9 rdpr */
                 if (!supervisor(dc)) {
                     goto priv_insn;
-- 
2.34.1


