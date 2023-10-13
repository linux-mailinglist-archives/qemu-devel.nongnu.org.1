Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E437C8639
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHip-0003Md-83; Fri, 13 Oct 2023 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHij-0003B4-JT
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:50 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHii-0002ZI-5A
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:49 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so314559466b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201806; x=1697806606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKmgf4fJPI4uE5NPSl+oCRC22RI7AomCq3WOdsU22V0=;
 b=tPRA2lcGPUZciHEhAjuia5nsna6na5q+CaKt8HajFiZvNR8UQIbjVCUPF5w5U5fEFO
 8hMJMVxiYUm4qyLI8pCmhH9iGWBKDbpbSMn8fLFt/ag9ibjVbtQIAuSEqyBIsfkJZk0f
 OQpsa8u9yUx3lxbb1hVS2bFUJTaMs/rmMs2/VKsE091y7ep8QYQfgMhIpAfruAdLkIa4
 xWoz2Af0XaxyBYIecUWp8VmZIJ9yfCu6jsX395/k/NL1KKefTgUcdCi+0GUbNhEvYLs7
 2JR3K1DIr2e+YfJ7gn8pyrMKFthjPZXarWYuz7Tnp82ny26GJmypnkBwMPyvc559XLV6
 /Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201806; x=1697806606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKmgf4fJPI4uE5NPSl+oCRC22RI7AomCq3WOdsU22V0=;
 b=cWiob/+IIsJja8cQq8FPNgU15N+s2wwo9/YuGe4rQHstFwjDdvCouTdfe3FJT/ns4G
 aNZS9K14jF2jU5wxmLTk6+TqjZj3imvzD/9rIRm0rD1vL4uOM90GSZ3A7QBrR49yw+15
 dqqNibkAQByM3TGHUNIda71AIYUHa/tcI35ESYd2DkRedH1mSUa03h/knGuo1atRLuQN
 pQrsILuvt+gxVztIed4zXy/tyIR4ce9fHG40Zu5544QK+S1fEMw+kYGZbIUnIR5qNqEa
 YeepKA6tatG/mYltIH0cJVnqUOmjMfXB+RM35SN3GGFqizxDVXYWaXJ5dfZLBm9gNq/t
 YHCg==
X-Gm-Message-State: AOJu0YxpwelxS00QNVaVmnCo8BtYziahnhTViCXpIWe6BJIKeHNl/A/P
 SDixiLZ/0jPehoqyGbhdLu0lO8hiuUTL3M7A6KQ=
X-Google-Smtp-Source: AGHT+IHu6vZO7t1EQSwY9D1tpCT6rQ2X31onWjTcnxEjf3O4xa80SnSgcCQje7HxKIcgulFOGvgdyA==
X-Received: by 2002:a17:907:1dd8:b0:9ba:3434:482b with SMTP id
 og24-20020a1709071dd800b009ba3434482bmr9424526ejc.26.1697201806373; 
 Fri, 13 Oct 2023 05:56:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a17090627da00b0099b7276235esm12540897ejc.93.2023.10.13.05.56.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] target/ppc: Define powerpc_pm_insn_t in 'internal.h'
Date: Fri, 13 Oct 2023 14:56:25 +0200
Message-ID: <20231013125630.95116-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

PM instructions are only used by TCG helpers. No need to
expose to other hardware.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h  | 10 ----------
 target/ppc/internal.h |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index b5deef5ca5..b86fd46d25 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -115,16 +115,6 @@ enum powerpc_excp_t {
     POWERPC_EXCP_POWER10,
 };
 
-/*****************************************************************************/
-/* PM instructions */
-typedef enum {
-    PPC_PM_DOZE,
-    PPC_PM_NAP,
-    PPC_PM_SLEEP,
-    PPC_PM_RVWINKLE,
-    PPC_PM_STOP,
-} powerpc_pm_insn_t;
-
 /*****************************************************************************/
 /* Input pins model                                                          */
 typedef enum powerpc_input_t powerpc_input_t;
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index c881c67a8b..5b20ecbd33 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -20,6 +20,15 @@
 
 #include "hw/registerfields.h"
 
+/* PM instructions */
+typedef enum {
+    PPC_PM_DOZE,
+    PPC_PM_NAP,
+    PPC_PM_SLEEP,
+    PPC_PM_RVWINKLE,
+    PPC_PM_STOP,
+} powerpc_pm_insn_t;
+
 #define FUNC_MASK(name, ret_type, size, max_val)                  \
 static inline ret_type name(uint##size##_t start,                 \
                               uint##size##_t end)                 \
-- 
2.41.0


