Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE027DEA17
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYJ-0005nW-OM; Wed, 01 Nov 2023 21:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXp-0005lV-4X
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXn-0001dG-1X
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5b94489e82eso309372a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888646; x=1699493446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGX0hLDU7mlzZf7pxJoVlwonVpBOzxX6m78i0jjhfjQ=;
 b=SeiyBbQCbKFY0xJHW3r6rfXbwDCKc7DKlBh+6w+Nyhcnf7r/0GN5GPdU6dGSzckylw
 9nKj4NJY4CNt3NJPGSRyztfeCatGxzSMT1CBerOwlgpZC/0858rXVIcRt2wpf4T5hgTq
 0QlfHJlOe/tis8hrLnTBBY2AmpNtpmpSy+hUO8r6nqErVaIdsdI6qjvlvwl/G/Eb+hvw
 KooajPsqs1o54T0TFh1tvMXSEyRR1hgvzBbaEBvQZsSi5FB5uztWwBZQwwIRonxxdVn9
 nBj2N+H1j1RSTkncYoaLx1hz7jdFVpO2pA5d5ax3Qb6UuO6PLGQ/719w8XAsHNuzqKJL
 ZUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888646; x=1699493446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGX0hLDU7mlzZf7pxJoVlwonVpBOzxX6m78i0jjhfjQ=;
 b=kq7tNULXcxHsZFhFVAcfrlEWvUGA714GYw5V0baTxhzvXjyDUZatpmmYEDK+cfIlBA
 x5dP9w+iIDaxMFEjKR6EMW8fKZhvqMSzyNPPIi/Ut0T2DW27xir6mom+a4mBb4PvVs9L
 lRcuFMBl0tv0vgD+mxPwLWSZMUBET5TfpWC5qQWWVO9VYCfN+hi+/An2+vbeYCvoKW+5
 GKklly7+57qB9d7bL0Vr/R8qwQkDTk8sJxFFTR9fs1LH8Q1wZhh/uIxlbPUzM6KLvmhu
 B1Lbo4x2FGYJN4JGpa7XmoDRmCpE+SgI6ICwUnP8Ay3xKWXyEBE8NRssuOYF5los2o1Y
 2IKg==
X-Gm-Message-State: AOJu0YyOW+h64dtHdJKrrVLTrvrJv50cLDcB3iWgCZkMfEcKjONwhPj+
 FhDASPXVbVMjvm7Sb46Pt/sCy1aqwG9PrlDmh3w=
X-Google-Smtp-Source: AGHT+IFJ1N6lxQyaxhC+VaNJv+Nb/oVriiqK3wHIFO1/89tAiBAWoZ0oy+QI1J3z/0njB6aB9tEtBw==
X-Received: by 2002:a05:6a20:431c:b0:181:99d4:8fe9 with SMTP id
 h28-20020a056a20431c00b0018199d48fe9mr668500pzk.58.1698888639875; 
 Wed, 01 Nov 2023 18:30:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 23/88] target/hppa: Update cpu_hppa_get/put_psw for hppa64
Date: Wed,  1 Nov 2023 18:29:11 -0700
Message-Id: <20231102013016.369010-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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


