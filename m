Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B5381906B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWr-0001pT-6t; Tue, 19 Dec 2023 14:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001lW-2q
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWj-0001lX-Nx
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so727485e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013192; x=1703617992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=135l4jPTDgYjvIL4sef6Tds4MaZV2O2YSPv0Rtlb/8c=;
 b=P92X0m2E9jDxHwZZNTrzRF3zUeiFmcLZlVHvWPBsqZucpZZXpOdbiHjLNc/WPPS6zD
 XrPpBDAutM6BgK6qKJr8y/tsAPWHjrIQhFe+2DMBHeown8RcXYdI9VEcwMNzecRCtIQq
 DR3dzsMb7xWD7cG76W1sLzsiwMdFHghXccZS75NxqaFpyA9gMD49KdAhOnuxym6cF9kW
 Hkk1WgiZkXYfx+U2XXjUdV8Gz1aASxrH7oh1327gE1MLB+LyNVZDsCP3UDqcGY4USSCs
 P/Z1+8Dw0XrWHyhEjLn8CEMhhMfHlp9zxkObMbUGRP2vhaNtwVh9uISJSZzMaEldsfjQ
 klNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013192; x=1703617992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=135l4jPTDgYjvIL4sef6Tds4MaZV2O2YSPv0Rtlb/8c=;
 b=FmkRA3td47S796rLHtKN1cyMv0yN/vv5da5kPskCSJoXTMGd2H7YhsVrpZWnyGVYm9
 bzodh1LSCJgFzbAcy6D0z+hsybc8RNP7e3rgK9vzXSF/jsNeQ9yyefb5DSr0PdBZOvtq
 zcQH1HNctNpYOJlXE6O41KXiLKU8Y4qCNUHHy63SDhneUEp3FiUjdiMGVYo0owReGGoT
 5NcT/VnEx66Fni/odU5i18k6IgAtWvchuk7midHkfJ6u61x+punyS6Aip1xFqkINBYCg
 zCfNz9CTUQ809zq53QRReIk0Rw7vcAH7XztUJnWLTjS9FrhozAqnooH6vO/1mdr8YqaO
 YAQA==
X-Gm-Message-State: AOJu0YxjKfJHmeLs0OZ9+Nl0wKSm9iP1IbiwgOQa+pCK7gZmoxkS/atF
 CWY8BA/nbittOwjPmz+kg7rGN0PKXO1072O8MjE=
X-Google-Smtp-Source: AGHT+IGdA4v2Ml+WUZSh4XlM8Z+OnLxL6P8/6OJexSvRVra9dWyXwAON4HNhXYPBu06XLiaKlw0BdQ==
X-Received: by 2002:a05:600c:1c90:b0:401:b6f6:d8fd with SMTP id
 k16-20020a05600c1c9000b00401b6f6d8fdmr9088316wms.6.1703013192202; 
 Tue, 19 Dec 2023 11:13:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] target/arm/kvm: Move kvm_arm_hw_debug_active and unexport
Date: Tue, 19 Dec 2023 19:12:30 +0000
Message-Id: <20231219191307.2895919-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     | 11 +++++++++++
 target/arm/kvm64.c   |  5 -----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 207b7f21b0a..ac4856cb46e 100644
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
index 2898e680fc5..4608bea7df4 100644
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
index ac3120adaff..352643e0665 100644
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


