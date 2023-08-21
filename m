Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DA782D4D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY6s2-0002Rv-HN; Mon, 21 Aug 2023 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qY6rz-0002Qv-Ms; Mon, 21 Aug 2023 11:31:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qY6rx-0003IR-5k; Mon, 21 Aug 2023 11:31:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso23226925ad.0; 
 Mon, 21 Aug 2023 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692631863; x=1693236663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X2LPhUW3SN75wkeBtuhWPs9a+AL16jdU+jvPoUBrxtE=;
 b=geIKqbiJ9PASmP4m2AS98W/vDF6vVYrGs/NEP6fe/+ZPNw0elfPZzGlKLAdfFEzbRG
 mS7PseS63a6TXTqr9VXwSeSIn49rj9/voZBfBd8lq1XFg6T+k9L8pj+x2CU+i+LlA25O
 ZhcWgkJjUhodUjw1HGZj/z+VI+OTfjKGlnFoCmPAnR5mwOcjXpAgFLvX1ULGjQ0phm90
 4rLBfq8v55XS0MsUo4lnbpz8Nr2CB6S4NfYEkrIN/et+XGOeqhCd7/s28RpizQJXHmOz
 RVslwBiUfC4gBMgUxE6app8GpSRZe+q6s461zjiIgRG+SRRJx8vj/Kcz/6x6LiAJUG8c
 ib5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692631863; x=1693236663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2LPhUW3SN75wkeBtuhWPs9a+AL16jdU+jvPoUBrxtE=;
 b=aWiYsYsUGaHm20nlKj9oOMpmVtvokq8ZNKD2ALMhup+eTVzgXxkrAD4AJhcqIsaJ/z
 OsmJdvMuxIKJQ1d+4K4q8zsQFb8yuyEfPTUxUE1AMWbWQjLX8tMKF8Ds0u3PEGk3ohZS
 GoPyYAQAhgjsx+a5jwXg5Z2MEmOG9xKIQg4zevTopmuH5xTF9de9hH6jjAU4csApjv9g
 34g5jdrv9mBhPcYSFfaraXaL68zQOUBq520e9c0dfK6jeVWQ17cXuvW8HG38Z6MXcMeA
 w2G1+yWPYlcOHdrIH89yu+/AxBFgVcBZSwfQS6oFF6VjcbIRpRaiK7ksLNL/wmX9I6zm
 LBAw==
X-Gm-Message-State: AOJu0Yzn2sJJ0aentOxEZZrNABQ8C3X9ohm3znHRLwIbhJnHZKwrLRZ4
 RIVMddW4xWvs8CeI4JHYDzc=
X-Google-Smtp-Source: AGHT+IHuYZb/GiXemuG+Ew9lck3SN8jb6DX2gLc23oID4sBmViZAhoUTWBxAwMgv5Aeo+su4YIeuCw==
X-Received: by 2002:a17:902:e806:b0:1be:f37f:a8d5 with SMTP id
 u6-20020a170902e80600b001bef37fa8d5mr11834572plg.10.1692631862838; 
 Mon, 21 Aug 2023 08:31:02 -0700 (PDT)
Received: from wheely.local0.net ([203.220.228.132])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902eacc00b001b9df8f14d7sm7156241pld.267.2023.08.21.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 08:31:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Ivan Warren <ivan@vmfacility.fr>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH] target/ppc: Fix LQ, STQ register-pair order for big-endian
Date: Tue, 22 Aug 2023 01:30:51 +1000
Message-Id: <20230821153051.93658-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

LQ, STQ have the same register-pair ordering as LQARX/STQARX., which is
the even (lower) register contains the most significant bits. This is
not implemented correctly for big-endian.

do_ldst_quad() has variables low_addr_gpr and high_addr_gpr which is
confusing because they are low and high addresses, whereas LQARX/STQARX.
and most such things use the low and high values for lo/hi variables.
The conversion to native 128-bit memory access functions missed this
strangeness.

Fix this by changing the if condition, and change the variable names to
hi/lo to match convention.

Cc: qemu-stable@nongnu.org
Reported-by: Ivan Warren <ivan@vmfacility.fr>
Fixes: 57b38ffd0c6f ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1836
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi Ivan,

Thanks for your report. This gets AIX7.2 booting for me again with TCG,
if you would be able to confirm that it works there, it would be great.

Thanks,
Nick

 target/ppc/translate/fixedpoint-impl.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index f47f1a50e8..b423c09c26 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -71,7 +71,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 {
 #if defined(TARGET_PPC64)
     TCGv ea;
-    TCGv_i64 low_addr_gpr, high_addr_gpr;
+    TCGv_i64 lo, hi;
     TCGv_i128 t16;
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
@@ -94,21 +94,21 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
     gen_set_access_type(ctx, ACCESS_INT);
     ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
 
-    if (prefixed || !ctx->le_mode) {
-        low_addr_gpr = cpu_gpr[a->rt];
-        high_addr_gpr = cpu_gpr[a->rt + 1];
+    if (ctx->le_mode && prefixed) {
+        lo = cpu_gpr[a->rt];
+        hi = cpu_gpr[a->rt + 1];
     } else {
-        low_addr_gpr = cpu_gpr[a->rt + 1];
-        high_addr_gpr = cpu_gpr[a->rt];
+        lo = cpu_gpr[a->rt + 1];
+        hi = cpu_gpr[a->rt];
     }
     t16 = tcg_temp_new_i128();
 
     if (store) {
-        tcg_gen_concat_i64_i128(t16, low_addr_gpr, high_addr_gpr);
+        tcg_gen_concat_i64_i128(t16, lo, hi);
         tcg_gen_qemu_st_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
     } else {
         tcg_gen_qemu_ld_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
-        tcg_gen_extr_i128_i64(low_addr_gpr, high_addr_gpr, t16);
+        tcg_gen_extr_i128_i64(lo, hi, t16);
     }
 #else
     qemu_build_not_reached();
-- 
2.40.1


