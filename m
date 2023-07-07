Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E1D74B00A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgi-0001uz-4C; Fri, 07 Jul 2023 07:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjge-0001tO-P0; Fri, 07 Jul 2023 07:31:44 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgc-0006XD-LV; Fri, 07 Jul 2023 07:31:44 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so300367a34.3; 
 Fri, 07 Jul 2023 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729501; x=1691321501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3B0dEsTKi6C1+bKxVn+pAxhkb0WjZTs06+ifklla1Q=;
 b=MX0Thb8p0z51ZCgw5d1YblY5GQugqvSnaiEgrcvQ14decPWA3rtT13iIj6KSqINRy4
 Ii6DulbGn814nDimypfVCcSYM3Br7Q7UVOKJBWP2GUkf5YNUeKkE8AwY48NBadLIMFGF
 P6HP2ZllhDMo37GPrf+aexIebdMJSlO90+HoTkBsV6B5Ep17/EXtIhz74BkbwHl40SiA
 9KoKtLwsW//MJr/GqK5ZcYbqF7lqFFS6+SJ/TPIRYEi8KrmaTSKHPVfaBhZn2/elRB6/
 FGaNt27Q078YI7+FIsfA4L8jZd7xpy5LPtSer+1n9/iMy6xHPIL2gKLjowOimDIvit/s
 wCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729501; x=1691321501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3B0dEsTKi6C1+bKxVn+pAxhkb0WjZTs06+ifklla1Q=;
 b=OkgcQ36qSy8e0LYAd32qveM8oX85lqi2THTmHfGm2xvob9vtglkRCFSTfLOF1VEqWo
 NHWWvPEcFr8pk/0tzfEPXsCIAW2LC3HWqututAbqybH/ND+GrY7EdyTbUFmb7iQLG5AN
 tLThctL4kpAd6N+H5AO1/q4xrp3Ehdh1/Tq08UViRSJHn50jD+b21SsJY5CKNB2R0tNA
 l8EczQNsFdiRfqsvEibE4NPbQ2SJ9KFbx9tzg6l+f2nojVe8LzXYSFpqF9lvYvdPL9Fd
 usO+GoNUqcfMH35p9BVZFJh1rOpfUSDonDMyPsmOBndeEex1TR2aQj8jt672i/zfShr1
 sOlA==
X-Gm-Message-State: ABy/qLaFtx3iEuh+ihJJ4PmhJx0UfFs3w1l2nGMDVMJpLSfg78lG/rmx
 wH+bL1uHErbwGZVHIrB0Rkreplbk9VQ=
X-Google-Smtp-Source: APBJJlG/kvkfjhot/MmbEuWDUfIdj9HRqvPUfg3SUE8OTpPb4BNG6fm3ZTwOxbuFzNIzH3S9zuPHng==
X-Received: by 2002:a05:6830:1511:b0:6b9:231c:7bcc with SMTP id
 k17-20020a056830151100b006b9231c7bccmr200597otp.34.1688729501001; 
 Fri, 07 Jul 2023 04:31:41 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:40 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 07/60] target/ppc: Add TFMR SPR implementation with read and
 write helpers
Date: Fri,  7 Jul 2023 08:30:15 -0300
Message-ID: <20230707113108.7145-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

TFMR is the Time Facility Management Register which is specific to
POWER CPUs, and used for the purpose of timebase management (generally
by firmware, not the OS).

Add helpers for the TFMR register, which will form part of the core
timebase facility model in future but for now behaviour is unchanged.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230625120317.13877-3-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c        |  2 +-
 target/ppc/helper.h          |  2 ++
 target/ppc/spr_common.h      |  2 ++
 target/ppc/timebase_helper.c | 13 +++++++++++++
 target/ppc/translate.c       | 10 ++++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index dc93581dd3..5f4969664e 100644
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
index fda40b8a60..828f7844c8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -722,6 +722,8 @@ DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(book3s_msgsndp, void, env, tl)
 DEF_HELPER_2(book3s_msgclrp, void, env, tl)
+DEF_HELPER_1(load_tfmr, tl, env)
+DEF_HELPER_2(store_tfmr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
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
index 372ee600b2..599bd4b4f9 100644
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
2.41.0


