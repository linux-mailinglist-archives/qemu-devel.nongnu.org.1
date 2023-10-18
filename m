Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7917CEA90
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESh-0001ml-3w; Wed, 18 Oct 2023 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESH-00017b-7z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:54 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESF-0004P8-IL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:53 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57f02eeabcaso4483952eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665910; x=1698270710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPk9VlCAjpCD8p3ZbSvb+o08mQKrjmWkggjvcwFuWFk=;
 b=rFx9Bv/MTRbEoI4GcHbtb8Ev+Jvvyq9OUZ/WSft2c1xZ2FC8EZ5GtC3iS5bt702Tzg
 osooo9FGLK2xF8Z6TZe4VFDx8AX4Him8ctHBKa+1zgfWg7EuiCwvGu/0pv2NipOJBFui
 Hmt4fjUje5lzW1ddI6fKVOIpmU0bG/hIoJ+qgyPCde2XGDnJqpuht6C4S/waMDFo8OKA
 XnRcjLzUB6P5BHFr+I52wDPZid/WTAWFdJorKnqYLUKz8Bpp6mvLQCekumga8T0deIHq
 7BRgIbcMHzIC/X3iwVMMOdRpo/4AOTpMjj/BXfFLRn/MNSVXVnPetiu8avsdVLwJb2qc
 oMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665910; x=1698270710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPk9VlCAjpCD8p3ZbSvb+o08mQKrjmWkggjvcwFuWFk=;
 b=fg7Qup6fkhUljhWWztdEq5p/6iwHB+bcK/tzTHZkwpNe/WzRLVv9TJp+zqWkXD5cqD
 pRv25h2cDaOC2l2C6Uo3yavJi/+RA92LZMPLaF6exnGAxzztos1eS75wZjBw2MecoGCs
 SIr4lPkBvNuca6/IsQOAy3wOlPmU4l6WRkOE5IBGB0mPtam7NxMYY1A7Q7DBqLU2AyO9
 5Bw3bKTrvcWzW58nmZ4pFGDz8xmB3dcxBUpweaEEd8uXWW8Sq29FDCYDu6Y0wLwexTME
 1Cc8O+RyhG3yNrhgik+5ZYCnwD2ErTvbSPTZDSiUbvE7F7YVb0W+xRVxC6ymIy2X9ice
 xf6w==
X-Gm-Message-State: AOJu0Yy8+ygBWLd5SHp7rcM0WVnPHe7FwrkYGhWT4j3A/yD8KQAJNqjN
 Hw56SXg8EmFqvHj6PyyKUFfvJ5w7QSs8W3liZPk=
X-Google-Smtp-Source: AGHT+IEu6lRcHaIH6mRZQWe+8u9dv1OSOVnVU2fUalGkde9aQEE9LM9o15ALjEopuAivZFuX5aQ4Dw==
X-Received: by 2002:a05:6359:6e8c:b0:166:e779:7ce7 with SMTP id
 ti12-20020a0563596e8c00b00166e7797ce7mr212479rwb.32.1697665909864; 
 Wed, 18 Oct 2023 14:51:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 16/61] target/hppa: Update cpu_hppa_get/put_psw for hppa64
Date: Wed, 18 Oct 2023 14:50:50 -0700
Message-Id: <20231018215135.1561375-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

With 64-bit registers, there are 16 carry bits in the PSW.
Clear reserved bits based on cpu revision.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.c | 63 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index a8d3f456ee..40e859ba08 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -28,19 +28,35 @@
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 {
     target_ureg psw;
+    target_ureg mask1 = (target_ureg)-1 / 0xf;
+    target_ureg maskf = (target_ureg)-1 / 0xffff * 0xf;
 
     /* Fold carry bits down to 8 consecutive bits.  */
-    /* ??? Needs tweaking for hppa64.  */
-    /* .......b...c...d...e...f...g...h */
-    psw = (env->psw_cb >> 4) & 0x01111111;
-    /* .......b..bc..cd..de..ef..fg..gh */
+    /* ^^^b^^^c^^^d^^^e^^^f^^^g^^^h^^^i^^^j^^^k^^^l^^^m^^^n^^^o^^^p^^^^ */
+    /*                                 ^^^b^^^c^^^d^^^e^^^f^^^g^^^h^^^^ */
+    psw = (env->psw_cb >> 4) & mask1;
+    /* .......b...c...d...e...f...g...h...i...j...k...l...m...n...o...p */
+    /*                                 .......b...c...d...e...f...g...h */
     psw |= psw >> 3;
-    /* .............bcd............efgh */
-    psw |= (psw >> 6) & 0x000f000f;
-    /* .........................bcdefgh */
-    psw |= (psw >> 12) & 0xf;
-    psw |= env->psw_cb_msb << 7;
-    psw = (psw & 0xff) << 8;
+    /* .......b..bc..cd..de..ef..fg..gh..hi..ij..jk..kl..lm..mn..no..op */
+    /*                                 .......b..bc..cd..de..ef..fg..gh */
+    psw |= psw >> 6;
+    psw &= maskf;
+    /* .............bcd............efgh............ijkl............mnop */
+    /*                                 .............bcd............efgh */
+    psw |= psw >> 12;
+    /* .............bcd.........bcdefgh........efghijkl........ijklmnop */
+    /*                                 .............bcd.........bcdefgh */
+    psw |= env->psw_cb_msb << (TARGET_REGISTER_BITS == 64 ? 39 : 7);
+    /* .............bcd........abcdefgh........efghijkl........ijklmnop */
+    /*                                 .............bcd........abcdefgh */
+
+    /* For hppa64, the two 8-bit fields are discontiguous. */
+    if (env_archcpu(env)->is_pa20) {
+        psw = (psw & 0xff00000000ull) | ((psw & 0xff) << 8);
+    } else {
+        psw = (psw & 0xff) << 8;
+    }
 
     psw |= env->psw_n * PSW_N;
     psw |= (env->psw_v < 0) * PSW_V;
@@ -51,14 +67,39 @@ target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 {
+    uint64_t reserved;
     target_ureg old_psw = env->psw;
     target_ureg cb = 0;
 
+    /* Do not allow reserved bits to be set. */
+    if (env_archcpu(env)->is_pa20) {
+        reserved = MAKE_64BIT_MASK(40, 24) | MAKE_64BIT_MASK(28, 4);
+        reserved |= PSW_G;                  /* PA1.x only */
+        reserved |= PSW_E;                  /* not implemented */
+    } else {
+        reserved = MAKE_64BIT_MASK(32, 32) | MAKE_64BIT_MASK(28, 2);
+        reserved |= PSW_O | PSW_W;          /* PA2.0 only */
+        reserved |= PSW_E | PSW_Y | PSW_Z;  /* not implemented */
+    }
+    psw &= ~reserved;
+
     env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
-    env->psw_cb_msb = (psw >> 15) & 1;
 
+#if TARGET_REGISTER_BITS == 32
+    env->psw_cb_msb = (psw >> 15) & 1;
+#else
+    env->psw_cb_msb = (psw >> 39) & 1;
+    cb |= ((psw >> 38) & 1) << 60;
+    cb |= ((psw >> 37) & 1) << 56;
+    cb |= ((psw >> 36) & 1) << 52;
+    cb |= ((psw >> 35) & 1) << 48;
+    cb |= ((psw >> 34) & 1) << 44;
+    cb |= ((psw >> 33) & 1) << 40;
+    cb |= ((psw >> 32) & 1) << 36;
+    cb |= ((psw >> 15) & 1) << 32;
+#endif
     cb |= ((psw >> 14) & 1) << 28;
     cb |= ((psw >> 13) & 1) << 24;
     cb |= ((psw >> 12) & 1) << 20;
-- 
2.34.1


