Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68397D176B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLt-0007pL-72; Fri, 20 Oct 2023 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLY-0007jc-2d
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLV-0008B2-Mo
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so1176085b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834628; x=1698439428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Td/Ysv7eoH4uj7r0UKubRW7kAk7MGHOo1UhYXHuswg=;
 b=jW/ul2Slp828MP+g9H2aGmAcE6rfJS84M1qrSQhvBpG9uDxMxzfg43tzMCzGnWyFUh
 RHKB1r52nWEtu7EHS7aFf+lyuoB7vXUdf9YZu0+OqGzDLC0/16rIgpmOxxywcpp/tq6z
 dn7C1LJEn9tJg7zRmyl/VA/32Pd9BV/tts21SyCy5ssoYTqHWCCUr7RSfodtv7Yn2Orv
 xnCEJ/+hve8m8miHpCIjTjo2IWfTMgm6jnMDQR5fZZlyy4tdC6QY4aIB8qdO2tgxr4eW
 mJyv1Ms2+ZeaCWQGBhe7CJ+/o1JvB7KwExvNrKx/djw7qJb7A2m+vYKCbQuvC60Df0/M
 mR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834628; x=1698439428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Td/Ysv7eoH4uj7r0UKubRW7kAk7MGHOo1UhYXHuswg=;
 b=acuBzn0V4onwTRhABNmHkC7npzKjJA7Y5tcmUmBU1PjN5LzM4OdzDybLyHryUDFMGR
 /WU+Kt+QTgTUFxgFjasTMRWLSIhCc/ZOiaUKHPQZoa65IXehHJ1uz10nm3Dzasq9w1CC
 LFxeUeq7Yg0czLsZ4Oj7YvUFYTpBnX5xaoflDUR4PEYoUXESDtUN+jXi6AXVKNgxwbzo
 J1wuvFSKjznQ8Y7CcPPZrIEmUV4pPHPGXvkQ3qBIbqBK/XbUHTXVaEyuRd3jP3pBaXq+
 vfbwOI/M1Uzc5xznVJQbZBM7k5b2vnpk77qt3yDdF6QyDZZXOdgfMtGDm/vsgY+7lYjP
 YB3A==
X-Gm-Message-State: AOJu0YyNKxF84YboBHUv1peRFlDnuvatNCsDil2UPvVdTXaUHwOO59DQ
 Zbmml2aW+5Tba5cgUR7qbcHS5eYpk/B6JSKLIH8=
X-Google-Smtp-Source: AGHT+IEzM4bAcBvwJOt0gYevFx0yP49REFNMh2Bqnh409jBtYHB7nDYtH4N1EmfXAU3BnAR+/5UU/A==
X-Received: by 2002:a05:6a20:7fa6:b0:17a:eddb:ac6a with SMTP id
 d38-20020a056a207fa600b0017aeddbac6amr4113829pzj.6.1697834628432; 
 Fri, 20 Oct 2023 13:43:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 17/65] target/hppa: Update cpu_hppa_get/put_psw for hppa64
Date: Fri, 20 Oct 2023 13:42:43 -0700
Message-Id: <20231020204331.139847-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index a8d3f456ee..534a9e374c 100644
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
@@ -51,14 +67,39 @@ target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 {
+    uint64_t reserved;
     target_ureg old_psw = env->psw;
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


