Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF6373598C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtS-0001Rr-If; Mon, 19 Jun 2023 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsv-0000g5-Nq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsq-0002Ht-LZ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3d8so7238395e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184971; x=1689776971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=79CNzgIoquxBlIAhz4j7SvzU/NO7uQSo19o8spaDBRU=;
 b=CBCWSwNnbt0tH1Kyaq6X+YOkD1h3/UodamiTf83kSyEWcrW/60eipoPzIZadQa1wxp
 hj9U4GUJDgQkLR8cOzukYg7lhnSl3i5xS0BlhypHmyUdwRztKnpARpf9aSrVBFuvWOR0
 WJEFQ59t1mnuHY2RSNliU679z99FUaJx+O/GWngO98XvKf/DW3nT8pU/oWXqMbYSzuTj
 pgZa6LOuAdJvtzsfWsoHIFyMRNJ2qgs4WvQZ/eal8Nnp5kxlogKKoWgCBk7K2S8OAedP
 43ml4XmO6ZBR0qnwGDRnP/Kc9VDVoK1e+t26SLMy+yPfvk2g/R+Z9hbC++MYcuXu+88n
 XmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184971; x=1689776971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79CNzgIoquxBlIAhz4j7SvzU/NO7uQSo19o8spaDBRU=;
 b=MHevx6WqLdfMXTvEo7Go59SQiRVUnkwZM8eGdgNdvK9BOF0fodaE/J8epfDN1C5Neg
 eE83WonDWAPWdtHX8Kv5UZG55ul1o+Yoh5PuTIWe1iNaJxhdUsYpzFUXK43laNMN6rXd
 17BzPbqaxhCLcHrKJET6WjNpPcyaTyeMlZDGZQB9Nsx5f2OBZOYlsa0Qiy7Uw9fd3NTv
 b6wmBIYAAueotDLap7yajAuQ2FQakSDBxlKMiAteAvwXui2hSaE0wSu58s2Bh/2PfRcG
 KwPWAmT8RS43+YfvTurQ0RPkSyE2aHQp3BBi6e6F9Ita0ml4kBHNH9vz4VErSLKRh3SM
 h63A==
X-Gm-Message-State: AC+VfDwdYlWN5rDuGE5wr7WxwVAq1OzbdVIvEGb+F+nZdowFCcZ0M7lT
 VQoXcPm9OXbuiYqniJUB7Mf2SpG82REk8gDF7cQ=
X-Google-Smtp-Source: ACHHUZ4keMvZ+JEDPy4az00b2Bhd/qesbuD0Qw/b6fPVOUc6QVSZJFNx0yOeou/yjE9anaddW6kn4w==
X-Received: by 2002:a7b:c450:0:b0:3f7:367a:bd28 with SMTP id
 l16-20020a7bc450000000b003f7367abd28mr8275684wmi.4.1687184971221; 
 Mon, 19 Jun 2023 07:29:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/33] hw/misc/bcm2835_property: Handle CORE_CLK_ID firmware
 property
Date: Mon, 19 Jun 2023 15:29:14 +0100
Message-Id: <20230619142914.963184-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Sergey Kambalin <sergey.kambalin@auriga.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230612223456.33824-5-philmd@linaro.org
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
[PMD: Split from bigger patch: 3/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: added a comment about RPI_FIRMWARE_CORE_CLK_RATE
 really being SoC-specific]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspi_platform.h | 5 +++++
 hw/misc/bcm2835_property.c      | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 83f2588fc52..ede98e63c33 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -173,6 +173,11 @@
 /* Clock rates */
 #define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
 #define RPI_FIRMWARE_UART_CLK_RATE    3000000
+/*
+ * TODO: this is really SoC-specific; we might want to
+ * set it per-SoC if it turns out any guests care.
+ */
+#define RPI_FIRMWARE_CORE_CLK_RATE    350000000
 #define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000
 
 #endif
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 2e4fe969bf8..4ed9faa54a1 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -127,6 +127,9 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             case RPI_FIRMWARE_UART_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
                 break;
+            case RPI_FIRMWARE_CORE_CLK_ID:
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_CORE_CLK_RATE);
+                break;
             default:
                 stl_le_phys(&s->dma_as, value + 16,
                             RPI_FIRMWARE_DEFAULT_CLK_RATE);
-- 
2.34.1


