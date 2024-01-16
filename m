Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27F82F11D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7Q-0006lG-Op; Tue, 16 Jan 2024 10:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7K-0006gR-QP
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:42 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7H-0005s7-AH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-337bcaef29eso458172f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417958; x=1706022758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=imXpClTBvGaeRVjAbq6Mzb0EDwuvuLXSMLzsw/Tl9kw=;
 b=wDiT0omG4gFDmMebYCmyilSH2yZ+6c6LmFpcltBk+oN/aYNDIdZ+qeKbkiQo3aGtw9
 8TUWi/BZqX7x2AFXKA1OjxovJLbAsmioFcI/YrcRV3ezCiBK3JEAXD6f+Pcz2UMQvi0V
 FcmVsAWsaPT0GV2tKtzgwexQX9rrkpwyea3NTR5pYyDdHzZrkzOS6Ysh1aTCon+Wh0or
 9eNfFjcIsboKOItG5vNVDCEIY6ioZO5sSjoJhSxxQf/xAropFJN/PbClERV+zG3tBkqp
 1LApfrFUBCrb+eJWCqxeXyW2lmWjjkPwJ8Y/9yrV/DuvSVzBxrUiqI9dqu8yaBxqYqKM
 BraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417958; x=1706022758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imXpClTBvGaeRVjAbq6Mzb0EDwuvuLXSMLzsw/Tl9kw=;
 b=ZwUMhvspXwo+/suRnzAzbS4k7p1mH0WTXfNL77fn+rKkYECsVvxNpEGQH6MZjpiE41
 P69iZivfc4+BV7cKy5qGOF43UXkz1cnKMIi5DvYfYBpI+iEzo1fkurCU7ary72vvWpT2
 TWIchpuY9sLQ0F342rmHVUU6LIsLNiFrfJwmcUgHwbR+RVE3630oK1hEeVX8tE2ZsDJz
 xamanz0qsCIg62sA1C4IHprke3HounKXpRVlk3X/YoLma8OHPEW2H6LgrVwtdRgFmoOC
 ZnCMCa1ccFu4457e8VAuleWglDJDs5OvK/R8a66aJP3MqZUGk53wFj/LdNWxwG0/WsAF
 XGBQ==
X-Gm-Message-State: AOJu0Yznu3CYMKVVAL5gkVWtv1lMjSA9Le5Q6JIght+BEw0/vwkRf1FU
 IlQarVolmVg7CeEL2X6jemA7TVU7tzq8Kjt6/ucj/pPitv0=
X-Google-Smtp-Source: AGHT+IH15tv1+Skl2XmMtj0Y5xmvHlLoHKFTWFeZ4Wd7bI0uh5ds0MTtNYoowItZISN/z7dNyXFLCw==
X-Received: by 2002:adf:e489:0:b0:336:d8c3:a65c with SMTP id
 i9-20020adfe489000000b00336d8c3a65cmr4026189wrm.36.1705417957778; 
 Tue, 16 Jan 2024 07:12:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] hw/arm/virt: Consolidate valid CPU types
Date: Tue, 16 Jan 2024 15:12:27 +0000
Message-Id: <20240116151228.2430754-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Gavin Shan <gshan@redhat.com>

It's found that some of the CPU type names in the array of valid
CPU types are invalid because their corresponding classes aren't
registered, as reported by Peter Maydell.

[gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
qemu-system-arm: Invalid CPU model: cortex-a9
The valid models are: cortex-a7, cortex-a15, (null), (null), (null),
(null), (null), (null), (null), (null), (null), (null), (null), max

Fix it by consolidating the array of valid CPU types. After it's
applied, we have the following output when TCG is enabled.

[gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
qemu-system-arm: Invalid CPU model: cortex-a9
The valid models are: cortex-a7, cortex-a15, max

[gshan@gshan build]$ ./qemu-system-aarch64 -machine virt -cpu cortex-a9
qemu-system-aarch64: Invalid CPU model: cortex-a9
The valid models are: cortex-a7, cortex-a15, cortex-a35, cortex-a55,
cortex-a72, cortex-a76, cortex-a710, a64fx, neoverse-n1, neoverse-v1,
neoverse-n2, cortex-a53, cortex-a57, max

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2084
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20240111051054.83304-1-gshan@redhat.com
Fixes: fa8c617791 ("hw/arm/virt: Check CPU type in machine_run_board_init()")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2793121cb41..5cbc69dff83 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2905,6 +2905,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TCG
         ARM_CPU_TYPE_NAME("cortex-a7"),
         ARM_CPU_TYPE_NAME("cortex-a15"),
+#ifdef TARGET_AARCH64
         ARM_CPU_TYPE_NAME("cortex-a35"),
         ARM_CPU_TYPE_NAME("cortex-a55"),
         ARM_CPU_TYPE_NAME("cortex-a72"),
@@ -2914,12 +2915,15 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
         ARM_CPU_TYPE_NAME("neoverse-n1"),
         ARM_CPU_TYPE_NAME("neoverse-v1"),
         ARM_CPU_TYPE_NAME("neoverse-n2"),
-#endif
+#endif /* TARGET_AARCH64 */
+#endif /* CONFIG_TCG */
+#ifdef TARGET_AARCH64
         ARM_CPU_TYPE_NAME("cortex-a53"),
         ARM_CPU_TYPE_NAME("cortex-a57"),
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
         ARM_CPU_TYPE_NAME("host"),
-#endif
+#endif /* CONFIG_KVM || CONFIG_HVF */
+#endif /* TARGET_AARCH64 */
         ARM_CPU_TYPE_NAME("max"),
         NULL
     };
-- 
2.34.1


