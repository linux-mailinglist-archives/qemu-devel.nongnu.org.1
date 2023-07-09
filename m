Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22174C18B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 10:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIPUc-00033z-B9; Sun, 09 Jul 2023 04:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIPUY-00032E-Ku; Sun, 09 Jul 2023 04:10:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIPUW-0001Ke-Vx; Sun, 09 Jul 2023 04:10:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso35968655e9.2; 
 Sun, 09 Jul 2023 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688890198; x=1691482198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wJUKUdQraTOTR3cpMkKT33t7dgaHv43fZVpRA2TUHoA=;
 b=kl54Jejg8Sgk6Vv/9Vf/k+mdM0rBc3oyn0j53UPgf/t2se15PGC5K6fklztDPkEu1K
 g+w4oZcUoJCqflryxmHYTS7waGFw45j9NFwxpsT+ewfRcwxH/VPkPwUvvN1fOC3OjwsG
 mDJUZS30cBTbI9QvSwREwfD27cOsWjz0AZwuqqKu3HN92rKc3H3t/yo5jxEKwRLBQXqP
 Q64KFZ6G65I2yWVWm3fK8F5DB3dJkU0zzw34XoT0bH2x1g/6vnUkULw7c5pPuX7B11Ds
 H/vYgY46kHtPEljxqX1Qn++i+gbsaORjRpHJ0lK6HvBq+XCiUrTiLtWoll1xvF2t/sC5
 AkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688890198; x=1691482198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJUKUdQraTOTR3cpMkKT33t7dgaHv43fZVpRA2TUHoA=;
 b=dblYJ9yuZid5ht6fiETgnhueNTP6LH3Wxq4qhQ9aMXeYuCTJgcjCqxxlz3huogY6Z9
 J5sDkO63DWVX8thc65fncJySxJwNsY+OGMlHiTcd7WolW1PJ4p80GgXoHY4YdacUK0u/
 Iv8MyP2pvaxZk2RDr0TZqFwSF87/751yJmSXlmwK8Zoat3E52L825fJB0oVE1qNbMumH
 pddeAUE69DTwYKjrQnXe8xePIWxwJSRZ8z308b+VK1F15/7sGU3cfvXNDHiIpG0bRs6l
 7ocAVTt1D2qcI+33gTLj5tPS/OAdFAGMqRLqjMsYGEyW3l1fEGkpMUBG7zSrfdFo4ob7
 +4yw==
X-Gm-Message-State: ABy/qLaUrmutXMTSrmb6cgK6wjUdORmQrYMTQbk/8jG95PIOrIZFGzOu
 PA7N9qLCFteHH+H4XneHXpJLoSa2C2M=
X-Google-Smtp-Source: APBJJlFenlhnm+QcjTv+jOs1cYVtRkK0mNHr8RW63I2Re42eFops52ZV/Nh0DtDVT9Zp264+x93g9Q==
X-Received: by 2002:a7b:c457:0:b0:3fb:739d:27b2 with SMTP id
 l23-20020a7bc457000000b003fb739d27b2mr8060614wmi.8.1688890198032; 
 Sun, 09 Jul 2023 01:09:58 -0700 (PDT)
Received: from archlinux.. (dynamic-077-011-082-039.77.11.pool.telefonica.de.
 [77.11.82.39]) by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003fb225d414fsm6944342wmf.21.2023.07.09.01.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 01:09:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Date: Sun,  9 Jul 2023 10:09:50 +0200
Message-ID: <20230709080950.92489-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
interfaces" sdhci_common_realize() forces all SD card controllers to use either
sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.

Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
example. Fix this by defaulting the io_ops to little endian and switch to big
endian in sdhci_common_realize() only if there is a matchig big endian variant
available.

Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
interfaces")

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6811f0f1a8..362c2c86aa 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
 
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
+
+    s->io_ops = &sdhci_mmio_le_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
-        s->io_ops = &sdhci_mmio_le_ops;
+        /* s->io_ops is little endian by default */
         break;
     case DEVICE_BIG_ENDIAN:
+        if (s->io_ops != &sdhci_mmio_le_ops) {
+            error_setg(errp, "SD controller doesn't support big endianness");
+            return;
+        }
         s->io_ops = &sdhci_mmio_be_ops;
         break;
     default:
-- 
2.41.0


