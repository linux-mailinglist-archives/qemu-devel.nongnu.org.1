Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA273D0BF
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 14:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDOSw-0007SB-Lo; Sun, 25 Jun 2023 08:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSu-0007RQ-Gt; Sun, 25 Jun 2023 08:03:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSs-0006b6-J8; Sun, 25 Jun 2023 08:03:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-676f16e0bc4so15754b3a.0; 
 Sun, 25 Jun 2023 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687694613; x=1690286613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tP7CdOhj4mSYtZ7J76n9PPXVafAWPOfShQkSnBW5n4=;
 b=CJeS7ukW4KqgzHTjDFhnvxnxAckLKuFXFQmrBs52QfQZJtHMvoeX+sOddwlbSpaxS0
 dk3ILrvRIF6Wxo+lsVF3FjCzO+YeFlZA2/KcvQ14phaqIUz0NeLI4iRxkumkeYAVVfd/
 87zi1haG5a65kJe8/TpX9LlQlycSPrrMOeNpaLabKgzWe/AJDISRpOD5JhfwGwoistqo
 ker3flEbWTpFloBX06RZ4jtysHSpcGLCSMoxvJESNYPQmr28aUyK2y5rEmS2Qr7QzSPD
 uXEvv+FvltNCeERupJ5N/3EG8g15+ErWDziSAUQt64lGTijjU2B90CADGO05tophd6zb
 pEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687694613; x=1690286613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tP7CdOhj4mSYtZ7J76n9PPXVafAWPOfShQkSnBW5n4=;
 b=Ig/NYMwAoUccZF4gDcgASA3G83QX8Y4zE076UlCC7sV4R1trZ5tp+oReqNGNvuCk7y
 naU1dWo7FyePENHKgcl/F/unueFePhLkmarHvhYex6O9cF+I4oyWXn4Rqk1V6bxFPU5B
 pRsHurklRgZpwwY6cHiaTowA9kfAp7kdgQm6QaeGykzEZeIZc3yxVk9v2i+zHW2Xb/1p
 LrruzPp0jGKk3mqH1nHwgvyV5toi3TOhWn7cO0tfBr0Mu7JqnnFz/CV+20eYHbafFb+B
 ZoYBCNExE9120epQ8FGta5pREuzXYSSJJuQEtjHdp7wrJa5sOFb4CNZS5By5lRNPZv2Q
 2jMA==
X-Gm-Message-State: AC+VfDw+NIqR6uQIxCLaRzPbm7NQOc9UH6ZqlwzJuZziI3vpIjTPdtEl
 N15v3v9r4pUQ9uk5i+HfYXg+RLA3AoA=
X-Google-Smtp-Source: ACHHUZ4DFvtg0ZJOaSTNkkxFwrwDyT3dDCdOBGbx7ZurA2MWG0hAzNgs841K8nW0u3rD/KGbd4nZcw==
X-Received: by 2002:a05:6a00:21d4:b0:668:9bf9:fa70 with SMTP id
 t20-20020a056a0021d400b006689bf9fa70mr12189261pfj.34.1687694612780; 
 Sun, 25 Jun 2023 05:03:32 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa78804000000b0064f51ee5b90sm2190772pfo.62.2023.06.25.05.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 05:03:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 2/2] target/ppc: Add TFMR SPR implementation with read and
 write helpers
Date: Sun, 25 Jun 2023 22:03:17 +1000
Message-Id: <20230625120317.13877-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625120317.13877-1-npiggin@gmail.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

TFMR is the Time Facility Management Register which is specific to
POWER CPUs, and used for the purpose of timebase management (generally
by firmware, not the OS).

Add helpers for the TFMR register, which will form part of the core
timebase facility model in future but for now behaviour is unchanged.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c        |  2 +-
 target/ppc/helper.h          |  2 ++
 target/ppc/spr_common.h      |  2 ++
 target/ppc/timebase_helper.c | 13 +++++++++++++
 target/ppc/translate.c       | 10 ++++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 21ff4861c3..7d1b148fd4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5658,7 +5658,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TFMR, "TFMR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_tfmr, &spr_write_tfmr,
                  0x00000000);
 #endif
 }
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fda40b8a60..eac5e7ab5d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -745,6 +745,8 @@ DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
 DEF_HELPER_2(store_40x_sler, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_1(load_tfmr, tl, env)
+DEF_HELPER_2(store_tfmr, void, env, tl)
 DEF_HELPER_3(store_ibatl, void, env, i32, tl)
 DEF_HELPER_3(store_ibatu, void, env, i32, tl)
 DEF_HELPER_3(store_dbatl, void, env, i32, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 4c0f2bed77..fbf52123b5 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -194,6 +194,8 @@ void spr_write_ebb(DisasContext *ctx, int sprn, int gprn);
 void spr_read_ebb_upper32(DisasContext *ctx, int gprn, int sprn);
 void spr_write_ebb_upper32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
+void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
+void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 #endif
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index b80f56af7e..08a6b47ee0 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -144,6 +144,19 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
     store_booke_tsr(env, val);
 }
 
+#if defined(TARGET_PPC64)
+/* POWER processor Timebase Facility */
+target_ulong helper_load_tfmr(CPUPPCState *env)
+{
+    return env->spr[SPR_TFMR];
+}
+
+void helper_store_tfmr(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_TFMR] = val;
+}
+#endif
+
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eb278c2683..9ce03344de 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1175,6 +1175,16 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
     spr_store_dump_spr(sprn);
 }
 
+void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_tfmr(cpu_gpr[gprn], cpu_env);
+}
+
+void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_tfmr(cpu_env, cpu_gpr[gprn]);
+}
+
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
-- 
2.40.1


