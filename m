Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA01B7E3384
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPS-0000yt-09; Mon, 06 Nov 2023 22:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COV-00076f-Hu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gA-5u
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso39010755ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326264; x=1699931064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGX0hLDU7mlzZf7pxJoVlwonVpBOzxX6m78i0jjhfjQ=;
 b=es+Ekx7Iz1seWAF2X3OfYC0O8k2u9HNO44BoFOFuvD/19ku4lwTDfxgPoQTqdJGfLr
 5q2seIyo7OyKVjq3G9A1XeekWsRoHpmzpeW+yHbxWeXxCiQgo4dZBVuvenFxupEvfkEF
 DZ7QmnAA5+K4rkHW/Q/YHxXm8RbvSZhAhGiTr+sHHqATwz0+ikmSpfrnLmlnH0q3n/YT
 LADIlrb/4FOqxujg8j+lHCbeW2vE1Mg5fBCzGS5ngw8nTQ9REat3QbOAnqGBGlxOJTF4
 JGGzHXQq90g/qgFALgRo3iCIay5Uteofvy7e7G4hjNmTEQNw6+MgeC19iViiSgadp0Or
 xm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326264; x=1699931064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGX0hLDU7mlzZf7pxJoVlwonVpBOzxX6m78i0jjhfjQ=;
 b=jXJni24OZIBiLFGS8fJFj5RY2SY/8kikWuSWzyDiMqZwIhSWzy+Hu2x3C5Ha8ofHNI
 /04K8f+18hylIq75K9VCGS8Wa2h5PQ2b32etATPneWEgf/sMYFS8tsEOVvEZZK0Dt4xz
 AGHIfVPYQhrFUNeThDGcFF8uS8h083In0JIiI0j0R4GUr2BpXBu+AHCMpgu556fZT28Y
 71Y0CQclpfg6AOFZxk6bS+cYcy9aw0XYUvi94KVC8Pz7CCxWQ4F0q7zrnjWUhWqfvohA
 OrwEhWTupdeBefAaVlsfD38nJYV2wItdfdL9CrJJqe8cMRsvwoEefX+anQc+MVNX/Luk
 sFpA==
X-Gm-Message-State: AOJu0YxDzIN8IlN6l4Wvg0Ku4yO3g25clijWNqlLJqX0Pqx8oL2HbTcd
 9IF5I4jMm7A/veiHbF71rEChcgyRYqiaGBmgz+8=
X-Google-Smtp-Source: AGHT+IG81zIZ6t3HLffbEs2QJVeqtRjCtN22pUUSyhoJtZs9A9FEM2ARGJ1xaWsGQpKC2uyWaU5MDQ==
X-Received: by 2002:a17:903:41cc:b0:1cc:5dd4:7ce5 with SMTP id
 u12-20020a17090341cc00b001cc5dd47ce5mr23641924ple.19.1699326264322; 
 Mon, 06 Nov 2023 19:04:24 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/85] target/hppa: Update cpu_hppa_get/put_psw for hppa64
Date: Mon,  6 Nov 2023 19:03:03 -0800
Message-Id: <20231107030407.8979-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

With 64-bit registers, there are 16 carry bits in the PSW.
Clear reserved bits based on cpu revision.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.c | 63 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index cba8160b3d..fa17fe6931 100644
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
+    if (hppa_is_pa20(env)) {
+        psw = (psw & 0xff00000000ull) | ((psw & 0xff) << 8);
+    } else {
+        psw = (psw & 0xff) << 8;
+    }
 
     psw |= env->psw_n * PSW_N;
     psw |= (env->psw_v < 0) * PSW_V;
@@ -51,13 +67,38 @@ target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 {
+    uint64_t reserved;
     target_ureg cb = 0;
 
+    /* Do not allow reserved bits to be set. */
+    if (hppa_is_pa20(env)) {
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


