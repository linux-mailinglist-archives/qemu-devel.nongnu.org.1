Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571868251E2
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNe-0007ld-Mo; Fri, 05 Jan 2024 05:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNd-0007lI-8j
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNb-0004Lw-LF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d894764e7so14739245e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450281; x=1705055081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUJ6l0OkyKg584UzrfGAsqs56Rbvr/1CMcQmKL/iGrw=;
 b=DRVZfQ4snrT8pzOduqa4/68XX7AQCEVkDtWlNTsFibq6O0VL47vSBErDJpGadnol6R
 BLTEEHcd4w9aTY6pd3ozRzshqIbgRDfTcy1nZzNA9CLEmtMCywXREtDMdxcY4iyd3kso
 dHwUm1VoaAjUT/nat/k2h8JPJwnJQPPzoSF8Yn5nJDjbAaVEB/qQ5LXRH/hUtsQoMMYb
 s7RdxBCi7X4xZU0YrzgpzrRbj0Uu7OzvDmFVYN/Pia1Bo6xwBuhH/RZ+jRi0H4tCZZOf
 LyAyCuHPZu9POBP5KcpVisAI3tIZXOXogEh0JBzPiZ2Jq1FAMZzCY6/3ZuaexMNOleFv
 WGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450281; x=1705055081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUJ6l0OkyKg584UzrfGAsqs56Rbvr/1CMcQmKL/iGrw=;
 b=dybQQrm/1bXpbmzP8qas7KVjrZYmyXQ+Ytm0aps1dGit8+r3+h8L63XutDpcuA+LwY
 uu6HsipxCeBMiJIqE6OtJ8zD4rXgYBZivzYz0pScB4fRSMHZyuwlD4fjhcS67JhFcB2v
 jRsOdb/3Qt54xj5g2kbrp/8JBT/D8tdZ204s4EjQupq71Kji/1UUh7vz91f69HFTKauA
 PhPrhiRr1f30f6e2oMAbhpwqcUZaZFulyTxvkx1qY66kfCJWajVacuEba/0UauLLzALH
 VGwVNoMoREeqSphSX9Xh41I4tPT1DGrwHkQRv3pF3hCdrcIXY5w8YHYHVr+5YynBt7Mr
 4D+g==
X-Gm-Message-State: AOJu0Ywd4UxOOeAaS8VJoj/YGxyMK4pDHvt8i60GjsujYjvODVGxvylL
 c/R2VGoxmL1gnCRMjn4Zt9elYGkNt7YZNLVoYsH0s1XZyQ==
X-Google-Smtp-Source: AGHT+IE/hVblsS/6QiS0GUM5yeRUP4aspV3fLTmaYo+CfWYszB+mQbh+rc3oVI6vWZJsau1FejRbXA==
X-Received: by 2002:a05:600c:2d8c:b0:40c:4b4e:95a6 with SMTP id
 i12-20020a05600c2d8c00b0040c4b4e95a6mr653703wmg.94.1704450281563; 
 Fri, 05 Jan 2024 02:24:41 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:40 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 5/9] target/sparc: implement asr17 feature for smp
Date: Fri,  5 Jan 2024 11:24:17 +0100
Message-Id: <20240105102421.163554-6-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x335.google.com
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

This allows the guest program to know its cpu id.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 target/sparc/helper.c    | 16 ++++++++++++++++
 target/sparc/helper.h    |  1 +
 target/sparc/translate.c | 13 +++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index bd10b60e4b..2247e243b5 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -212,4 +212,20 @@ void helper_power_down(CPUSPARCState *env)
     env->npc = env->pc + 4;
     cpu_loop_exit(cs);
 }
+
+target_ulong helper_rdasr17(CPUSPARCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong val;
+
+    /*
+     * TODO: There are many more fields to be filled,
+     * some of which are writable.
+     */
+    val = env->def.nwindows - 1;    /* [4:0]   NWIN   */
+    val |= 1 << 8;                  /* [8]      V8    */
+    val |= (cs->cpu_index) << 28;   /* [31:28] INDEX  */
+
+    return val;
+}
 #endif
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..fc818b8678 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -2,6 +2,7 @@
 DEF_HELPER_1(rett, void, env)
 DEF_HELPER_2(wrpsr, void, env, tl)
 DEF_HELPER_1(rdpsr, tl, env)
+DEF_HELPER_1(rdasr17, tl, env)
 DEF_HELPER_1(power_down, void, env)
 #else
 DEF_HELPER_FLAGS_2(wrpil, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..1cabda9565 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,6 +37,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rdasr17(D, E)               qemu_build_not_reached()
 # define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
@@ -2681,16 +2682,8 @@ static bool trans_RDY(DisasContext *dc, arg_RDY *a)
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 {
-    uint32_t val;
-
-    /*
-     * TODO: There are many more fields to be filled,
-     * some of which are writable.
-     */
-    val = dc->def->nwindows - 1;   /* [4:0] NWIN */
-    val |= 1 << 8;                 /* [8]   V8   */
-
-    return tcg_constant_tl(val);
+    gen_helper_rdasr17(dst, tcg_env);
+    return dst;
 }
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
-- 
2.25.1


