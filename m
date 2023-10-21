Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F97D1AF9
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4am-00075s-6S; Sat, 21 Oct 2023 01:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4aj-00074f-9b
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:05 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ah-0008Kc-IQ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:05 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3af609c5736so1023087b6e.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866322; x=1698471122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=VQSp9eFcQmDg/0hGE39bZLai9vnV783sa+qxUlTmR8kPT6gYM9LSapIB7Peuv/YYV9
 5h9GRV2yKCW5a80MQlgc+lAZ9J2+VyKHUD7rQvibsL0dQkAq38hOSS8rNOTGAJRDRokv
 rWkbyJ4ABStFHh0eoP1CzxQ4EeTqmbCFzNgqzKkLmBI3LO7cb5iL3WUJw8umNHAKKS08
 f8tCLdXukalGxYMFqUjLi/+++n0Sfkx8wgGcSagGKaS6HmoPPx/RnKd+equwzy6Idaiw
 7vqg6x98Q+0Cg9EU6hQhJMByLV0+dHlZ9dCjCEeB2lJAwwIbuofbFebHqNVH5GaaOsBc
 4m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866322; x=1698471122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T5XaZy2rs7d2UUVgUOSmmRBHeDvLpxjj7qjWAVo54c=;
 b=SY8az4HUrB3KupMGYdx0RHxFmzEAlWJTsBF0Na6ykh2mh1Bsxjhg9NbxIlDLrS4Dp/
 /z2w0M3zVtZdjon6qW52jfpgyaVZGBSfey4qXqWolwVWbgMsKvIHXu6IreV8h0C+8M7C
 z+QkLyeHnIGdPMKxVj0uIiiZr4fiAnp5phzwluw+9qnPdwssBXY2LnOYnlmxJVRWH2AA
 chhXD1lZP4u1eFAqJNzFCCQN7YTRCnlaSOqYxyaKl42BeUQT9wn9GYdRic9XilIbzGz2
 qU2crj3VFcb93QP79ZmzTbt3DB30TnO0IPoFlj5HmiR6tFcMxVFv3kdZBp1j8Ay4yvPS
 iVyg==
X-Gm-Message-State: AOJu0Yw6yX1bwMjatJQeH2HaqYSAsfviiKbDZDGqI5DKqC3KcEyvPMVN
 b7CZhQNITTPugjSLi8OQEW8CaYq2m32XUOjGdpQ=
X-Google-Smtp-Source: AGHT+IEnWyyEdOdYR/ykxnOcyUaF3VSAZpriJs3BtAG2gsVBszmauNzBUSGbO2vtd08wskTr2ECMxA==
X-Received: by 2002:a05:6808:10d1:b0:3ad:f3e6:66f8 with SMTP id
 s17-20020a05680810d100b003adf3e666f8mr4233940ois.41.1697866322323; 
 Fri, 20 Oct 2023 22:32:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 03/90] target/sparc: Avoid helper_raise_exception in
 helper_st_asi
Date: Fri, 20 Oct 2023 22:30:31 -0700
Message-Id: <20231021053158.278135-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Always use cpu_raise_exception_ra with GETPC for unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 246de86c98..09066d5487 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1650,7 +1650,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->dmmu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x33:
@@ -1662,7 +1662,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x35:
@@ -1679,7 +1679,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->immu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
       break;
     case 0x37:
@@ -1691,7 +1691,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-          helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case ASI_UPA_CONFIG: /* UPA config */
@@ -1920,6 +1920,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     default:
         sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
+    illegal_insn:
+        cpu_raise_exception_ra(env, TT_ILL_INSN, GETPC());
     }
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.34.1


