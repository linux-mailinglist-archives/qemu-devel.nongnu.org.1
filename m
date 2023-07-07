Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B079874B019
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjig-0007Sl-8w; Fri, 07 Jul 2023 07:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjie-0007IK-1D; Fri, 07 Jul 2023 07:33:48 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiY-00072y-DK; Fri, 07 Jul 2023 07:33:47 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b7206f106cso1570111a34.1; 
 Fri, 07 Jul 2023 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729621; x=1691321621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDKExs6NtxIsCQTLBz0+Bcsnjt4SIwcZ12J5QEQKJfE=;
 b=DsKv+nPRfXaXnd5GB6U8m9uSFvC3Bqjl7RkV+6cw3dpsltuXQXORtBCyqGJpGKz/2y
 wXiZyCtOCs97Fwm1gbDMjF63qanMsDWXB7z1ME6OUJofcDV00IqtsDNCrxNBcNoCYzCS
 A02D1dTzioonljVzdLlXLxYKtr2zI/jhLHJIrXV7Bt2q2lUe3jA01Vz7kQmi6bSHnlFW
 G+fUH0kURZQVV+olcs2HD+2mkONWlGtbsEXowyXu0XIBbLbCnmK1MZbXDoTIwdLCvSje
 cuD/d8N1FfhE2u+zoY7TUc9hcBD3zwRO1KESOghZ4FzLbhFHRh/62Y/wc/r7UazH+fE7
 J4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729621; x=1691321621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDKExs6NtxIsCQTLBz0+Bcsnjt4SIwcZ12J5QEQKJfE=;
 b=E8nuULl/ds6iDVrqjs8EU5BdWSm2rIc4xbFBZHLqpcpa9gEj2/xTk+uFN5yt4Wbp80
 ut6wIOeQf+PV/ePLYY3NP1T5qu98x0PEBcTjrUYJ/5VNDV3ifa98/nvQJooCPI7nxMAa
 8Zod3+pnBwsFzLaInXn9cM1xrZuO2Ewg6cVAFLql3LF4RIPfdez1aZS9ll+mSx45mtP9
 /5Cz7NoNnPj4MzbBDdf9WlP67ERfD2Wf36QmzQBYwJhNSEBtGCDzdzWczvaaS2jfBrfC
 +2YsFmUwMI7hi6R9Tf9xMHvJG/mcYd9/tPbuidzvtS9MVwxTx8YhO1Vs6WmPXMngOQUx
 sl9w==
X-Gm-Message-State: ABy/qLZ6UaeuA82yY/lMso/jW2dcbUtut4SA7XJ4/PdUwG/n5QrXTr34
 CudMUHbKHIm9Qtxhg7fUyRGA6ZmUWAI=
X-Google-Smtp-Source: APBJJlE/UiYoy25XSu+EUUVwOweiooriIr1UjcutNo1ZkRsbr3LNsgyFK91Qt1MoalZE+f46wOfY3A==
X-Received: by 2002:a05:6830:1d5b:b0:6b8:9a14:91f5 with SMTP id
 p27-20020a0568301d5b00b006b89a1491f5mr4971172oth.21.1688729620845; 
 Fri, 07 Jul 2023 04:33:40 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:40 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 55/60] target/ppc: Move CPU QOM definitions to cpu-qom.h
Date: Fri,  7 Jul 2023 08:31:03 -0300
Message-ID: <20230707113108.7145-56-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230627115124.19632-4-philmd@linaro.org>
[dhb: keep cpu_list define in target/ppc/cpu.h]
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu-qom.h | 4 ++++
 target/ppc/cpu.h     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 9666f54f65..c2a66a90f7 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -31,6 +31,10 @@
 
 OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
+#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
+#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
+
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 
 typedef struct CPUArchState CPUPPCState;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b269b0d090..25fac9577a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1471,10 +1471,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
-#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
-
 #define cpu_list ppc_cpu_list
 
 /* MMU modes definitions */
-- 
2.41.0


