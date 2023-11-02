Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3E7DEA5F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:47:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcb-00006i-2K; Wed, 01 Nov 2023 21:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbG-0006cA-3g
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbC-00026J-Ot
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so3138395ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888857; x=1699493657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVaSUdm8wIzLLsLpBUjpNJYI2RdNW+CR3uBhuw+VEbI=;
 b=SrvU+cWSKj9/E1VZzglxJpvxuawlo4YLOlL9v1ig8rLk33u8H0M1eXQ4zNqGJIwSnv
 Je0+sPfFZ2capC3e6fnS6K6aDl4zZvPT+VLC+m6O5dx8aMvlReW0xctxzPqn7VXNpII1
 Z6kxNI5FkZB6tWSzdmYitTrEthpGOcUA1zGuJb6yfq985EYboxXJ1stPDzvo/VeX8Acn
 mzSK6uBgw8JY9ehvKrlh0L1HcZ0n9wf4i2dA6shSl4aGywM33Y+PZuOjetwm+U3Erztp
 Yv8gACupmwSCRhJ/m/o4gEfLcgJezi2aQ43NNO/M1mKF9Ic51FrBSffS2FDP5m5j5wj3
 sFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888857; x=1699493657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVaSUdm8wIzLLsLpBUjpNJYI2RdNW+CR3uBhuw+VEbI=;
 b=Qd/D16+7OF+Y1oNBy94DnAxi68ipUDPQHBwVUBLuK3rs9ZnAS7vvBkdlbTn4BmtdGe
 r3KsVt+9UTibCjm4l1fK4aw8ZESULUamPO3yWKm4N/ItOQ4HSIsoyj/qwsQiyB3vOLjp
 +ogt5O9ZgJAQMB9DwYBbCrso2zq8jytcX1SoXL2GbOKfiksGTBQc1rdAc3c39QpC0EzF
 4W8FwXlD/7dh2n2/+hxYVEWoxrVnoZfZBob3BZCIBoQHO1wixuk9UipSHvQeunlDwEIM
 W27FkfY6DiXwN6v/igsStH1X/XDhCN9RGx0i8g1zpRtzlh5Jmm6STNrdA2HJytK2ToLc
 6UdQ==
X-Gm-Message-State: AOJu0YxiKBqBuaYxq2jq0QtLIGCXii95R2yzt9MyAaj0WRI6K8HEKG+9
 pm+tCO/h6UAREMomCe3fLaqwOBGx/GHGIAFTcNs=
X-Google-Smtp-Source: AGHT+IGSKIq0wZ72BBhq7Uwj6BadZv6jyU0jdlQvLw/IM/6GJFapDgzpWOJlx50/055lcqJSf6cGRw==
X-Received: by 2002:a17:902:bf41:b0:1cc:2095:b90 with SMTP id
 u1-20020a170902bf4100b001cc20950b90mr13002747pls.55.1698888857559; 
 Wed, 01 Nov 2023 18:34:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 70/88] target/hppa: Fix interruption based on default PSW
Date: Wed,  1 Nov 2023 18:29:58 -0700
Message-Id: <20231102013016.369010-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Helge Deller <deller@gmx.de>

The default PSW is set by the operating system with the PDC_PSW
firmware call.  Use that setting to decide if wide mode is to be
enabled for interruptions and EIRR usage.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/int_helper.c | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ea676ba062..ea8e7e99a4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -137,6 +137,8 @@
 #define PSW_SM_W         0x200      /* PA2.0 only : Enable Wide Mode */
 
 #define CR_RC            0
+#define CR_PSW_DEFAULT   6          /* see SeaBIOS PDC_PSW firmware call */
+#define  PDC_PSW_WIDE_BIT 2
 #define CR_PID1          8
 #define CR_PID2          9
 #define CR_PID3          12
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index f355c4c76b..a11d607b31 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -52,9 +52,17 @@ static void io_eir_write(void *opaque, hwaddr addr,
                          uint64_t data, unsigned size)
 {
     HPPACPU *cpu = opaque;
-    int le_bit = ~data & 31;
+    CPUHPPAState *env = &cpu->env;
+    int widthm1 = 31;
+    int le_bit;
 
-    cpu->env.cr[CR_EIRR] |= (target_ulong)1 << le_bit;
+    /* The default PSW.W controls the width of EIRR. */
+    if (hppa_is_pa20(env) && env->cr[CR_PSW_DEFAULT] & PDC_PSW_WIDE_BIT) {
+        widthm1 = 63;
+    }
+    le_bit = ~data & widthm1;
+
+    env->cr[CR_EIRR] |= 1ull << le_bit;
     eval_interrupt(cpu);
 }
 
@@ -104,8 +112,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     /* step 1 */
     env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
 
-    /* step 2 -- note PSW_W == 0 for !HPPA64.  */
-    cpu_hppa_put_psw(env, PSW_W | (i == EXCP_HPMC ? PSW_M : 0));
+    /* step 2 -- Note PSW_W is masked out again for pa1.x */
+    cpu_hppa_put_psw(env,
+                     (env->cr[CR_PSW_DEFAULT] & PDC_PSW_WIDE_BIT ? PSW_W : 0) |
+                     (i == EXCP_HPMC ? PSW_M : 0));
 
     /* step 3 */
     env->cr[CR_IIASQ] = iasq_f >> 32;
-- 
2.34.1


