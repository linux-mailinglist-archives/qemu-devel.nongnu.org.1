Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B097213CB
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:37:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ank-0005bq-EZ; Sat, 03 Jun 2023 19:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anW-0005QI-W0; Sat, 03 Jun 2023 19:36:39 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anV-0003Sx-Al; Sat, 03 Jun 2023 19:36:38 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-b9a7e639656so4262511276.0; 
 Sat, 03 Jun 2023 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685835395; x=1688427395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86G+Ht7nWtcDvX0zUR5cgMSTQKyfzn9nUKwqtGm1JMM=;
 b=i4MwabcfJQGPvYBdCT90d6txlulfFT/WwHFu8mV7nwIqWKiVhjROdlupY/F3Xqs/LM
 B37/HQP303hx4MZQ32Xa/ikn9NrB7Yb6ZfhP/fb2s3rbdsezK4yg4902gZ8F2UvDV9JN
 RJCwkVc/CPs6o8SDPMrx0jteOlKSTO2+lnApPCTZZ6IS4CVZgX2/2J28OUSlU3IcMjMX
 UDWEnvTFMWrWH+qsdZ1zKWsiMClAYYoMwWkl2oLyw6XojK6liWRb2O1lKukO2yQVXZEF
 gpUEFOhf2J92l2RHwzCvyLZLf8YvDZCmYct/95yZWdEKFHh2AXmAhrk+BS+Ek5tlfTRI
 88+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835395; x=1688427395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86G+Ht7nWtcDvX0zUR5cgMSTQKyfzn9nUKwqtGm1JMM=;
 b=lfDP+nH3y6SjC7NC4U1WxUjN7SgrYzCeMh8MDSxebwBLn80UguevQCJ8ISUXbeX44g
 MldbSB10vr7y/pYI6AA3cVNI0ykTnhb58qSuqk+GmhAYDlPD6UACljnKo5brVFLvapqn
 mRLwr/kUP25HUGCqwT7XXupDWI9BIYPyYmzp8OyOLhBUnIPUG0a0bL70dCtaAbve2fqP
 ogDOvdZ29UKpO+KGnLuDh0LzOGH7+g7cgY7Bqk0rF8khVg22aqfYt5m6/hMTMJ5XjDd0
 yZBGpees0ijwWNNWkAQh+6DWzAP0090jwhADldwaIDEde0SKnFwyikjXrPPQ11crSuwj
 JsgA==
X-Gm-Message-State: AC+VfDxqHBvGXRTKl1gzHNmrV/YLVhU4MH3A6UuSuSS97TXpsY3TNDXb
 nI4Hygo+6oW1brdtgz/F3bsVXuMYVCE=
X-Google-Smtp-Source: ACHHUZ72MCeYaBdo/ypfy0SRatetjs5fVef9WlQXddF4p4aU5hvxAE75gmD/NVbw5+ran4/Qoz4CSg==
X-Received: by 2002:a25:4155:0:b0:bac:7294:4faf with SMTP id
 o82-20020a254155000000b00bac72944fafmr2932346yba.27.1685835394888; 
 Sat, 03 Jun 2023 16:36:34 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 io23-20020a17090312d700b001aface7bdd8sm3743533plb.31.2023.06.03.16.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 16:36:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] target/ppc: add TFMR SPR implementation with read and
 write helpers
Date: Sun,  4 Jun 2023 09:36:11 +1000
Message-Id: <20230603233612.125879-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603233612.125879-1-npiggin@gmail.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=npiggin@gmail.com; helo=mail-yb1-xb2e.google.com
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

TFMR is the Time Facility Management Register which is specific to POWER
CPUs, and used for the purpose of timebase management (generally by
firmware, not the OS).

This adds an initial simple TFMR register, which will form part of the
core timebase facility model in the next patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c        |  2 +-
 target/ppc/helper.h          |  2 ++
 target/ppc/spr_common.h      |  2 ++
 target/ppc/timebase_helper.c | 13 +++++++++++++
 target/ppc/translate.c       | 10 ++++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index da0f7a7159..37088021d2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5662,7 +5662,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TFMR, "TFMR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_tfmr, &spr_write_tfmr,
                  0x00000000);
     spr_register_hv(env, SPR_LDBAR, "LDBAR",
                  SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 16bb485c1a..166cacb3f9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -746,6 +746,8 @@ DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
 DEF_HELPER_2(store_40x_sler, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_1(load_tfmr, tl, env)
+DEF_HELPER_2(store_tfmr, void, env, tl)
 DEF_HELPER_3(store_ibatl, void, env, i32, tl)
 DEF_HELPER_3(store_ibatu, void, env, i32, tl)
 DEF_HELPER_3(store_dbatl, void, env, i32, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index d6c679cd99..8ab17123a4 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -196,6 +196,8 @@ void spr_write_ebb(DisasContext *ctx, int sprn, int gprn);
 void spr_read_ebb_upper32(DisasContext *ctx, int gprn, int sprn);
 void spr_write_ebb_upper32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
+void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn);
+void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 #endif
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index de1ee85e0b..34b1d5ad05 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -270,6 +270,19 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
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
index 8b312b46e0..9dcd66eac8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1255,6 +1255,16 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
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


