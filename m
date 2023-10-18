Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353F7CDD56
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6eB-00089F-Pt; Wed, 18 Oct 2023 09:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6e9-00085y-ME
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6e7-0004lw-JG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso5776961f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635893; x=1698240693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LiT9JTo43Z+vjp2dLyhikt+0rMd61MGWoGcd0rivsU=;
 b=VBgNqKbZvtmMXG3Cfl5qYCx1laV9C36ZGDuC1HFfBH1cMTrma2Fb0YYYFtg2TD5hxF
 B50GSYa807yJSoFW9uL3J5aO0toFge+sx1OkUZLh+LSu0FqhLxDsTlDGKjzu/30KD0GP
 VR3Z6c86eagoSo/4vdzx6Fkl51WiFAWUGF3Lja73PjFWixHWLRbB9vpIip/U4jN1/HWR
 W5Rq1ipmWEWmU/U7OJOlkm2kQjc0FY3WNmGz/eE2rrScpKfyx8O8g6W1OGk2KvLc35a4
 1gUwyee7M6NTe2KjMGPlT//oigrpDGaHb82DUPo4Qtgm+g2vV8nY8v/cd32xGzZZRc7l
 GsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635893; x=1698240693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LiT9JTo43Z+vjp2dLyhikt+0rMd61MGWoGcd0rivsU=;
 b=utLLQa/4IXZ8IxuBvVhDq9FePnH93rmyW5dQM9Ptb08buG0SB+6qwOw4ZkAmVWVfgM
 6O6cYiA3NuIlG1FnU6qQ3Z+pXKMTNqezsQiLhtohSSg/y+MghKVV/aGv9Hfs5Khv0hVC
 rmzl1ky78crc4VEuMJdkj4PMIHo/9ozs+LYMfCUc2QfPcXi08tftaWTNdRJF8DUk8Coz
 SjIdkqtft8SlMXwNcU2c642fg6Bppq6MG9Hf7NTAl+usl7RN42kSmJrmixms4iS6Zi0b
 SJkNyRdFFuNoKx8Uk8wj0D6cT+Ew4ukHe+fHTIxK2AfnWGLDNY2jdBXFIyoMXXs1bry7
 RXKg==
X-Gm-Message-State: AOJu0Yzbc9//11/Jk4CVH3Yq1uBiccx3uSeiqq4fZEOrrevE55in07dd
 n+AJomNZgl7MxqMxnP016SPgPdntEzhG0GS/nBA=
X-Google-Smtp-Source: AGHT+IEIITG7d/4nNpJXJ1zKdRWbiPc4D0FgLsxV0rNMKRi8LetQrEdmiIg48t6ZcVWU7huA2hZnHw==
X-Received: by 2002:a5d:4842:0:b0:32d:a211:798a with SMTP id
 n2-20020a5d4842000000b0032da211798amr3817524wrs.6.1697635893417; 
 Wed, 18 Oct 2023 06:31:33 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfcc8e000000b0032db1d741a6sm2129389wrj.99.2023.10.18.06.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
Date: Wed, 18 Oct 2023 15:30:58 +0200
Message-ID: <20231018133059.85765-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In order to make the next commit trivial, move sysbus_init_mmio()
calls just before the corresponding sysbus_mmio_map() calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/spapr_xive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 7f701d414b..12057ffe5b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -316,7 +316,6 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
 
     /*
      * Initialize the END ESB source
@@ -328,7 +327,6 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
 
     /* Set the mapping address of the END ESB pages after the source ESBs */
     xive->end_base = xive->vc_base + xive_source_esb_len(xsrc);
@@ -347,14 +345,16 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_ops,
                           xive, "xive.tima", 4ull << TM_SHIFT);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
 
     /*
      * Map all regions. These will be enabled or disabled at reset and
      * can also be overridden by KVM memory regions if active
      */
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
 
-- 
2.41.0


