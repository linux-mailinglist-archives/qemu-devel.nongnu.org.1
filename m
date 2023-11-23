Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40F7F5785
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YH-0006W9-Vr; Wed, 22 Nov 2023 23:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xt-0006MS-2P
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:34 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xo-00066I-TQ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:32 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b58d96a3bbso316891b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714547; x=1701319347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jov1TIQPq3PcKK+UAq7hY3OrlerxFsiiZxK31xZdzhs=;
 b=Zf4oCIprXg7lz+h439gF4Jy9lbsVuL+f9Aw5nSEqWajgbozKr7tmXR3gaUTpZ/fB6H
 ZnVcmFKbgpmvp5vFqCOSICchFBLTIhmSXX7LRbc5pVohI3DVM3KBUcP7xOfsc9v3WxI2
 /2ZT8246Lzkc/6lCh5dYe2E5ZEh4ss49+HFzuZTBigIbGqU9R2GYS9INvPHLxSWxoIon
 qcEAOSeT8KlbFXDY1OISnQoF1XpUdyVfEWrNQSx7U1zpqxQc9XG8/z7sL40qzKl4zFmC
 GsbjJK+2iSK5MqCKFvUpBxQiPf+NAjgw8ObVXaNfHA/+bErWEzrGtbnXGr0XuVgUNtgP
 x3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714547; x=1701319347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jov1TIQPq3PcKK+UAq7hY3OrlerxFsiiZxK31xZdzhs=;
 b=eTIxwmxl0LcZ7XNky7x2bJOAnyhd5nKMi1/21Mt1TnjshIomzKAGXgZUu5PNM2m8kD
 l6f868YME16sHU+xiFr8n7MDlUZA1TP6+ZNhxm/K2V0zdYyxnrEPU5iYHnPovKNKmPhm
 F+KaIgxzYGtWu6QYwu6paXWMzi27ZUwGLqtDFtljE9K5IcNINi9IaesRMO7CWj7wFH31
 UzE3ANKUyNiW/oWCWzKJyIxebBzU6cAVUwr6dpx6YeQOQwdIx364j5m7BgLBhVGt5o+O
 sI5lcNt9wdVRljFVlsYG79wXXOHy/xDLRETIk4OZ719s9GqbGW+Xurppq2OHw6x4rG0u
 XNYQ==
X-Gm-Message-State: AOJu0YyoL8CIuynRe9rLdHBMadXtOLf3jGmk4LDokiaBjmcuPldOiab3
 +quUINScrdmlKze9uzUL1i3J84kpCwtNzjSDgYPr+VSC
X-Google-Smtp-Source: AGHT+IGIWS2S0x0jnDsCZQA8GwPlf9RVAqYH/PtqDIsoPCfgRr+fQu9A8d2K5xXpB1xhYFzCKF3GjQ==
X-Received: by 2002:a05:6808:1719:b0:3b2:ef9c:d1b1 with SMTP id
 bc25-20020a056808171900b003b2ef9cd1b1mr6239417oib.6.1700714547604; 
 Wed, 22 Nov 2023 20:42:27 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/21] target/arm/kvm: Move kvm_arm_hw_debug_active and
 unexport
Date: Wed, 22 Nov 2023 22:42:04 -0600
Message-Id: <20231123044219.896776-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     | 11 +++++++++++
 target/arm/kvm64.c   |  5 -----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 207b7f21b0..ac4856cb46 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -454,12 +454,4 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
  */
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
 
-/**
- * kvm_arm_hw_debug_active:
- * @cs: CPU State
- *
- * Return: TRUE if any hardware breakpoints in use.
- */
-bool kvm_arm_hw_debug_active(CPUState *cs);
-
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 2898e680fc..4608bea7df 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1021,6 +1021,17 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
+/**
+ * kvm_arm_hw_debug_active:
+ * @cs: CPU State
+ *
+ * Return: TRUE if any hardware breakpoints in use.
+ */
+static bool kvm_arm_hw_debug_active(CPUState *cs)
+{
+    return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
+}
+
 /**
  * kvm_arm_copy_hw_debug_data:
  * @ptr: kvm_guest_debug_arch structure
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ac3120adaf..352643e066 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -73,11 +73,6 @@ void kvm_arch_remove_all_hw_breakpoints(void)
     }
 }
 
-bool kvm_arm_hw_debug_active(CPUState *cs)
-{
-    return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
-}
-
 static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
                                     const char *name)
 {
-- 
2.34.1


