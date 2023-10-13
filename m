Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8A7C863F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHjS-0004uo-Sh; Fri, 13 Oct 2023 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHjE-0004Vh-Rn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:21 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHjD-0002gC-6d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so3589869a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201837; x=1697806637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGRDbNMY2n5Kz87q0HF9aXN56DMXen4g7m78MIw8aHE=;
 b=lhcKCGooGJrBtjITWM0vjZRURdJA4A9AvdfPrGFvkn0up8s2oritGNBNa3dAg2wX6C
 MtaVCWoyTq3O7r4tdxtcCiXLQd1VUtos88LdZ6qlnrkGEJLW1wkX3qkxfPMY9TCtQZ+X
 4Rf9ZHmAz9xUDQslEaXZFgrW8Ow0R3X6ik9PAvo+EGu2Vpf6ZERd+FehQALeMrivZC5p
 79hqJsbAc3q0V3cjtJcoFq8wMfJucmK5XPRlhCR0JRQlBVL6d5zfOrNZp3d67cPGIwKn
 XrPxfbjyWRjZUmyXkXinW+ZYjI3NRBLhTgPO+YAiPHCYTDzUKOR/zgvKpY8kRg+RsXZy
 v6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201837; x=1697806637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGRDbNMY2n5Kz87q0HF9aXN56DMXen4g7m78MIw8aHE=;
 b=tpeOu4Xjvv8TsqhXG/Hja+C/+SWA4l94H/zbAEXNmFnY3exP/Y9zjieOo57FKWQrLZ
 6twpuznLsr+wlT9BVrrRyHpknDBV4UVNHMsmUVdxnpGU4hxsJFUZCRiiGIdZn99tysi3
 QL2Zca6b66gvpxRRfeCdAsa3qwbsKVMeFiz+JoZ4KJhL2xJ6CYTlYMteFz1f6lbZqW07
 3lzTVdiB8sbm96unurMV/Y1Rfk35Em9BJxfGJfSR0J2P6QnO2TaQGJLaUXWBcRuhHrnl
 Z+wOQLJL6j5+e3NGw9zjvliH6QYyMHa9i8DNbLUdQmTIcqvqNoNBDpL4I1v3l8cKmOXr
 Rt6Q==
X-Gm-Message-State: AOJu0YyP6LaKTWcONxkSpL7WWk9bFX4ea3Zwb3H8BGHziae2ZywEgJZN
 Emb2qgHGJwfF3etmhFDgqFm0INk/cZ2ag9YEHHg=
X-Google-Smtp-Source: AGHT+IHKdqliaFV7BpwPLKIdtW69Wadn7mv1Do3CXR3zMjtFb19abla3eFRsaLO//JqceQ0T8PzlvQ==
X-Received: by 2002:a17:906:6a01:b0:9bd:ac0f:83dc with SMTP id
 qw1-20020a1709066a0100b009bdac0f83dcmr1246237ejc.54.1697201837451; 
 Fri, 13 Oct 2023 05:57:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a17090619cd00b009ae587ce135sm12309552ejd.223.2023.10.13.05.57.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:57:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] target/ppc: Move powerpc_input_t definition to 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:30 +0200
Message-ID: <20231013125630.95116-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

The powerpc_input_t definition is only used by target/ppc/, no need
to expose it. Restrict it by moving it to "target/ppc/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 21 ---------------------
 target/ppc/cpu.h     | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 5bdca472be..6d39ad451c 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -36,25 +36,4 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
-/*****************************************************************************/
-/* Input pins model                                                          */
-typedef enum powerpc_input_t powerpc_input_t;
-enum powerpc_input_t {
-    PPC_FLAGS_INPUT_UNKNOWN = 0,
-    /* PowerPC 6xx bus                  */
-    PPC_FLAGS_INPUT_6xx,
-    /* BookE bus                        */
-    PPC_FLAGS_INPUT_BookE,
-    /* PowerPC 405 bus                  */
-    PPC_FLAGS_INPUT_405,
-    /* PowerPC 970 bus                  */
-    PPC_FLAGS_INPUT_970,
-    /* PowerPC POWER7 bus               */
-    PPC_FLAGS_INPUT_POWER7,
-    /* PowerPC POWER9 bus               */
-    PPC_FLAGS_INPUT_POWER9,
-    /* Freescale RCPU bus               */
-    PPC_FLAGS_INPUT_RCPU,
-};
-
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c2cd069095..4b8b5d3d3e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -259,6 +259,26 @@ static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
     return mmu_model & POWERPC_MMU_64;
 }
 
+/*****************************************************************************/
+/* Input pins model                                                          */
+typedef enum powerpc_input_t {
+    PPC_FLAGS_INPUT_UNKNOWN = 0,
+    /* PowerPC 6xx bus                  */
+    PPC_FLAGS_INPUT_6xx,
+    /* BookE bus                        */
+    PPC_FLAGS_INPUT_BookE,
+    /* PowerPC 405 bus                  */
+    PPC_FLAGS_INPUT_405,
+    /* PowerPC 970 bus                  */
+    PPC_FLAGS_INPUT_970,
+    /* PowerPC POWER7 bus               */
+    PPC_FLAGS_INPUT_POWER7,
+    /* PowerPC POWER9 bus               */
+    PPC_FLAGS_INPUT_POWER9,
+    /* Freescale RCPU bus               */
+    PPC_FLAGS_INPUT_RCPU,
+} powerpc_input_t;
+
 #define PPC_INPUT(env) ((env)->bus_model)
 
 /*****************************************************************************/
-- 
2.41.0


