Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E178EAC7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfB3-0003Mc-KC; Thu, 31 Aug 2023 06:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB0-0003IA-Tn
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAx-00042S-IM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4020b88bd03so6205185e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478722; x=1694083522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WPpMGXQPxV6Gd1haLOeww5avLvhBkPk1RqCrlh/RzWQ=;
 b=GSiaO5Mrq0HBtOTm7BIT8SaQRCJ/P7rnQ6lSUAfvHJPC8ti7TmR6amdaIHAE9Q1Kf2
 RVFuqzkfHi9UEs0RKCqj+e0mPKBXwhOCBvqQuTL3MR33OFHlxBNBYoQkXO/B6INjD5QV
 NNDOEUMjonyIu04dj5p6wM+4zPAPmFIVqieQwP6ti359KY36TQ10EYujUxebA7yRTIfp
 EN7NOweN3p19TTHE+sMuvVoh0l0pu0k7UJwVed4A0dNqbJ4sbym5ZeKN5K2voD4AT6LV
 HuG22nbOLo8YdvwhCXNB9q0RId3GFico8kjW9FVsREC6RdwEzQ4c9hJ6wdtRG0j2YsBU
 iZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478722; x=1694083522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPpMGXQPxV6Gd1haLOeww5avLvhBkPk1RqCrlh/RzWQ=;
 b=f3g1dca25L6RBZ1wd1+DLQgWdtfAHU2PFr+3N8GkFIfilZqpPlagIXIytRr8A6x5H8
 wBwPDF1LH8o7GxmWlWEvQiV83BYh1F3GxxSGAzI2FekFJ/UPkz3g4DlaBpduO6SFAMHl
 Bs3ceWRaWQ/XIP455ICQiaIDaLHVFA+l6CHhJrVu1lbdiOkU5o5dR54cDuY9R98c1B6b
 PDSK4obu0fVYdIrL2q/HYuRlrQTJhvFonEo9zRdmz1rYgStlionB0Qejn+RN7lpkDHf3
 R+oGyRZr1YCGNGSZ717wC9WE88IGXqJGAwhTorloAuLQF6bSD6JkTwLrkSiyF2Uigg4B
 WFMA==
X-Gm-Message-State: AOJu0Yzec6wEAd2gKy2m/F0/huL9StqHujHLIJbz1gezOl0IWhHx/yCt
 hXFAX8G2+XH+df7cbRlD419dVPvKKpO4aPt4XR8=
X-Google-Smtp-Source: AGHT+IGaHFGV1zViONlP5OLtLg19sT4V43IRUVssamJcSgGNsTGcyhpksmeWMmi3/AFLGlYMZ0Z6YQ==
X-Received: by 2002:a5d:4089:0:b0:31a:d6cb:7f94 with SMTP id
 o9-20020a5d4089000000b0031ad6cb7f94mr3528262wrp.23.1693478722121; 
 Thu, 31 Aug 2023 03:45:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] target/arm: When tag memory is not present, set MTE=1
Date: Thu, 31 Aug 2023 11:44:59 +0100
Message-Id: <20230831104519.3520658-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

When the cpu support MTE, but the system does not, reduce cpu
support to user instructions at EL0 instead of completely
disabling MTE.  If we encounter a cpu implementation which does
something else, we can revisit this setting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index fe73fd8af75..23901121ac6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2067,12 +2067,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
         /*
-         * Disable the MTE feature bits if we do not have tag-memory
-         * provided by the machine.
+         * If we do not have tag-memory provided by the machine,
+         * reduce MTE support to instructions enabled at EL0.
+         * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
         if (cpu->tag_memory == NULL) {
             cpu->isar.id_aa64pfr1 =
-                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
         }
 #endif
     }
-- 
2.34.1


