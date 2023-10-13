Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525407C863D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHj4-0004CR-N7; Fri, 13 Oct 2023 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHj2-00048P-Tm
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:08 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHj1-0002d9-6l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:08 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso2997068a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201825; x=1697806625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnGehjCRe7N5NlcitFMO+yrUN4cOF8jWvzxKACAW5h8=;
 b=AVEkOjIyt4nNmvF/1K+YRfQQigF1vcv06TgapS74Hq/EgVTcZUtD+wx3rpRtFABAHV
 JMX8GynDx0MRaNxaLSn2+SS03XPWhmAivAjE04VRanlYe4QLZxcmuvF/r3DlnC+M0aca
 9EUjkxTgMCS1oI3RV+0/6TmHayH22n6nDJOFdEAhUob3daOK089zyDHAWeaej7T+maXy
 V1c2aMjcOdnWBonXEhnu/ZB0Zcz8luxoEX7FyGLwRaVu/uJYf38Njk8NyYeLyn9C1jzb
 tKiRMrS5ByojiTnC4AcNb5E7KARJ+ImSjOqBMeYSv8OTFHg6wNGsKLn2BziTkWQJtqr1
 boHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201825; x=1697806625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnGehjCRe7N5NlcitFMO+yrUN4cOF8jWvzxKACAW5h8=;
 b=M9sJhhqdq7hvsml1ejMx8H1TF81HmTdCHS2DkvI+VFI2IsHVhBVCWOA5OucWuWmCDw
 khkj2nVhZx7uyvBURNTmKwH4C5eN8pNZFlRNKeWERQGeRDeQ4SV/6CZ1rl0RKLO5foWi
 GQ6KSmWheyO0+MDtKBHA/ZCPlYJu3WS5G88X647HhxBJObknbSGOE31QVyToohWjEzGK
 VgioMlfiFaHmTgZ+wyUBAZvwlNSCUj9Vp6aGv8u9VkRqbHwIgWr8P5CoC3Ay26KxhR72
 kZzp/Lsaa/1EaYPbIn5HrofBWlfW8Fo+K+cXY2yYc8SXP0j3/1vDL3yHMR/g8gZlae5N
 d9lA==
X-Gm-Message-State: AOJu0YzjqiBVYF3X/g+SsaSVKQ0Z8lXZ5mHV1eemsmTNe9IVNaiAUhhY
 0dCil/CyM5Etg/p6BItr2euplnCPp/Lykn4o7rI=
X-Google-Smtp-Source: AGHT+IEp5Gsm7LoTVb1+v7PsmVpG/R9w+deQLvUMhmRaVoO6/HCVB6GqSdaIq00WbVwYWSuSK1NH6Q==
X-Received: by 2002:a05:6402:14c7:b0:51d:f5bd:5a88 with SMTP id
 f7-20020a05640214c700b0051df5bd5a88mr23977902edx.38.1697201825324; 
 Fri, 13 Oct 2023 05:57:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a508a92000000b0053deb97e8e6sm3069380edj.28.2023.10.13.05.57.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:57:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] target/ppc: Move powerpc_excp_t definition to 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:28 +0200
Message-ID: <20231013125630.95116-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The powerpc_excp_t definition is only used by target/ppc/, no need
to expose it. Restrict it by moving it to "target/ppc/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 29 -----------------------------
 target/ppc/cpu.h     | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 41e97a0ea1..b2e42c2996 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -79,35 +79,6 @@ static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
     return mmu_model & POWERPC_MMU_64;
 }
 
-/*****************************************************************************/
-/* Exception model                                                           */
-typedef enum powerpc_excp_t powerpc_excp_t;
-enum powerpc_excp_t {
-    POWERPC_EXCP_UNKNOWN   = 0,
-    /* Standard PowerPC exception model */
-    POWERPC_EXCP_STD,
-    /* PowerPC 40x exception model      */
-    POWERPC_EXCP_40x,
-    /* PowerPC 603/604/G2 exception model */
-    POWERPC_EXCP_6xx,
-    /* PowerPC 7xx exception model      */
-    POWERPC_EXCP_7xx,
-    /* PowerPC 74xx exception model     */
-    POWERPC_EXCP_74xx,
-    /* BookE exception model            */
-    POWERPC_EXCP_BOOKE,
-    /* PowerPC 970 exception model      */
-    POWERPC_EXCP_970,
-    /* POWER7 exception model           */
-    POWERPC_EXCP_POWER7,
-    /* POWER8 exception model           */
-    POWERPC_EXCP_POWER8,
-    /* POWER9 exception model           */
-    POWERPC_EXCP_POWER9,
-    /* POWER10 exception model           */
-    POWERPC_EXCP_POWER10,
-};
-
 /*****************************************************************************/
 /* Input pins model                                                          */
 typedef enum powerpc_input_t powerpc_input_t;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d521ee97bb..d8cf4c03bf 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -190,6 +190,33 @@ enum {
     POWERPC_EXCP_TRAP          = 0x40,
 };
 
+/* Exception model                                                           */
+typedef enum powerpc_excp_t {
+    POWERPC_EXCP_UNKNOWN   = 0,
+    /* Standard PowerPC exception model */
+    POWERPC_EXCP_STD,
+    /* PowerPC 40x exception model      */
+    POWERPC_EXCP_40x,
+    /* PowerPC 603/604/G2 exception model */
+    POWERPC_EXCP_6xx,
+    /* PowerPC 7xx exception model      */
+    POWERPC_EXCP_7xx,
+    /* PowerPC 74xx exception model     */
+    POWERPC_EXCP_74xx,
+    /* BookE exception model            */
+    POWERPC_EXCP_BOOKE,
+    /* PowerPC 970 exception model      */
+    POWERPC_EXCP_970,
+    /* POWER7 exception model           */
+    POWERPC_EXCP_POWER7,
+    /* POWER8 exception model           */
+    POWERPC_EXCP_POWER8,
+    /* POWER9 exception model           */
+    POWERPC_EXCP_POWER9,
+    /* POWER10 exception model           */
+    POWERPC_EXCP_POWER10,
+} powerpc_excp_t;
+
 #define PPC_INPUT(env) ((env)->bus_model)
 
 /*****************************************************************************/
-- 
2.41.0


