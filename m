Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D897E41C6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0H-0004Lg-Jz; Tue, 07 Nov 2023 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzu-0004Dh-NH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzq-0007YQ-2i
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40850b244beso43394485e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367039; x=1699971839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6TivXK1QWn2IjcuBDpLpSu+yTjCXvnnkWK/ZS63otI=;
 b=QV+53/hul0ahXtkH1gbYKDpBP0vuVj6CSaHUSxjqSLE9ws95X3Jb5Mjo2eG1xpQM3F
 avD6wTseNzsG0WorQDweQkeU07W/DSMyubU4m5TPJ2cEJ0rHrbhFQyyhsJouaqGHeiJN
 FPlfEo4NPeHBswGV/+yJXK/HD25+thi4q3dBAxEGjg5jN59dXRZjiv/d8nDYJf6gdAyl
 THxIDPCdT3pbpQP/EE6+FLiPBUbgsQQXitmPSwe47FqHsNRAHiyZLFaKs4NE7VlUXX7Z
 Rr//Ttankqz7hbbEI2XBGu8hRedU6+ljs+gRrkEDp7If0EVW607omxpga8djSbmZxAlW
 XPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367039; x=1699971839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6TivXK1QWn2IjcuBDpLpSu+yTjCXvnnkWK/ZS63otI=;
 b=xLd+UBUYe0vxaqGCu0+hWZypl+4PwJn6f6nGtXUnci8COfhYSO7EC2f4f6hZ/RS/KC
 +/+rWTIj9HGANniB4RTdSs22q3RhEfaCQdGh1srFdKFbENNquyn/p7cFhaGIADrQtxHV
 adcIKeVQBf4WTax+fJfoxwJyH4YFUv2c97TkYN6KknENfEIQ5OTx8n/GqD/cibLS2wdv
 61rVX3x4/qwI7/vmmSOyfvW+H1NZBzZcHeR3juPZj24hG+3RjROZ/cbVElRWyzR0JRFA
 95vcaYVHBDEQCZOnINLsc691KV2OsUK5hiQ+HGbgP11feK82/MYZ3ckFtde7NxoXqzdt
 PncA==
X-Gm-Message-State: AOJu0YzaY67dLhdUXiIgF6latfceE6hBFD89mZXGE7d6vCc61Hf2COl0
 xpamQ1GyzK0sOwisYCktlKJN0X3ezY1OAj/Qr7cZEg==
X-Google-Smtp-Source: AGHT+IHLrvKxauX65NkKzDbgI5IQE725HayVhU+u+m6wg2sjfSMca0X03L+R1ImXtZ074pOLaWMXWQ==
X-Received: by 2002:a05:600c:4451:b0:409:5a1a:fe16 with SMTP id
 v17-20020a05600c445100b004095a1afe16mr2604121wmn.28.1699367039043; 
 Tue, 07 Nov 2023 06:23:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv12-20020a05600c548c00b0040641a9d49bsm16047128wmb.17.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13CB66575A;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 05/23] target/arm: hide aliased MIDR from gdbstub
Date: Tue,  7 Nov 2023 14:23:36 +0000
Message-Id: <20231107142354.3151266-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This is just a constant alias register with the same value as the
"other" MIDR so it serves no purpose being presented to gdbstub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231106185112.2755262-6-alex.bennee@linaro.org>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6acd87f5b9..ff1970981e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9000,7 +9000,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
         };
         ARMCPRegInfo id_v8_midr_alias_cp_reginfo = {
-            .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST,
+            .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST | ARM_CP_NO_GDB,
             .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 4,
             .access = PL1_R, .resetvalue = cpu->midr
         };
-- 
2.39.2


