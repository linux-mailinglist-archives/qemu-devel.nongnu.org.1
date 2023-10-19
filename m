Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B87CFB47
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCS-0002R0-Og; Thu, 19 Oct 2023 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBm-0001rJ-CW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBe-0001CP-W3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:47 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso88268641fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722541; x=1698327341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IBNdIJqab6Bc866cHoB7OouTeU7VDOxNyDZhbOToj3g=;
 b=P2eb2tv4eD0mQrAC6wO8dWi4Gm1qLljoeulktyhWJ0aMFZKqQccR/wVsMg26QOJTa5
 EPNft9evIPBdQm2D5jFbILp/Hl9YXvgmotpDGgRe5trXmdA2SWD7SBRV+OtNuY6tPmCn
 g9IgutCp5L4Z2lXpu+n9ze/fa0bBb1pauZbqaCGx7uHDqj/TNaJ76PXPKlK4s+9eIoBJ
 14GFslX1UlOeV6WBkUH80VZ+tS1QjM9wD+3pI6Yx9GhmwQwuSxQrbVLxpGMgcg9yew1Q
 PB37Jgi/XdGPvDEfCMMLBJgzO9v38kelTU9fZDrog5pPzQUT3R0UjqP6Ec/XO0llSYuB
 RQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722541; x=1698327341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBNdIJqab6Bc866cHoB7OouTeU7VDOxNyDZhbOToj3g=;
 b=vgF58540fz+mQYYLbifSxSr7j8hNhU6C5dYuNCYJdFVV8ysE69F1JIXnJnlGtSMEFQ
 rneODGzknUWhG2wydEJ7r9dyavcTtixjF2Bl1JsOMP7+wFsv+I/eQPOOWQTwaqn2llSa
 tLSTsZWNn49soMp7nHQv4dR5ahqe9yLbyI4G0Za7ljIaGI0IoRyaDpYhIUbUCTKUKDY0
 GDghES7xgfGcZnZHWAZXcAwgvgKKLrBNsqd2DeX6jcWIZVYHJMJO+7tYQSfbKbRwsMAa
 BMpGnnZakOOoxkoftDbTnVcLqIj45VZ+pWamjkKyfUYUciGqRur8qbTCcRCloMWW/ABe
 Y8Mg==
X-Gm-Message-State: AOJu0YzPHlOSHmw8PEguTVJx0vbrfpgX8DrcnL3yC1NldxeOuMw+k2un
 KkYtnQuzXNDKFtei1TP7apNcxme3jbFP5TePGCM=
X-Google-Smtp-Source: AGHT+IFKg0u5THdgEy54HYhM5DiqEyCOjIxiuv1S5XtpvUA6ZaO+SU8NRuCXYQ8MUU5Xxm5+ArpvWQ==
X-Received: by 2002:ac2:4c8a:0:b0:507:973f:39bf with SMTP id
 d10-20020ac24c8a000000b00507973f39bfmr1579860lfl.38.1697722540620; 
 Thu, 19 Oct 2023 06:35:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] xlnx-bbram: hw/nvram: Remove deprecated device reset
Date: Thu, 19 Oct 2023 14:35:16 +0100
Message-Id: <20231019133537.2114929-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

From: Tong Ho <tong.ho@amd.com>

This change implements the ResettableClass interface for the device.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231003052345.199725-1-tong.ho@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-bbram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index c6b484cc85b..e18e7770e1e 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -2,6 +2,7 @@
  * QEMU model of the Xilinx BBRAM Battery Backed RAM
  *
  * Copyright (c) 2014-2021 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -416,9 +417,9 @@ static RegisterAccessInfo bbram_ctrl_regs_info[] = {
     }
 };
 
-static void bbram_ctrl_reset(DeviceState *dev)
+static void bbram_ctrl_reset_hold(Object *obj)
 {
-    XlnxBBRam *s = XLNX_BBRAM(dev);
+    XlnxBBRam *s = XLNX_BBRAM(obj);
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
@@ -522,8 +523,9 @@ static Property bbram_ctrl_props[] = {
 static void bbram_ctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->reset = bbram_ctrl_reset;
+    rc->phases.hold = bbram_ctrl_reset_hold;
     dc->realize = bbram_ctrl_realize;
     dc->vmsd = &vmstate_bbram_ctrl;
     device_class_set_props(dc, bbram_ctrl_props);
-- 
2.34.1


