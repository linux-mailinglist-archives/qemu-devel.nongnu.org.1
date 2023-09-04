Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605C791B3A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDJ-0003TD-Dp; Mon, 04 Sep 2023 12:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCx-00038V-RM
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:49 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCt-0007cH-Nw
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:47 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500d13a8fafso2879212e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844020; x=1694448820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KLx6XBhwZsbEqcvd2/L0DAF2KnkpBlHb/IZBmOztIQ=;
 b=UbgwP/1sUC1Jy1pfP9nRxaVE8csU+f6ng6UvVedVPktD4YzquZhwCL5BEAPG/NnkTe
 tymlOnhlkgGmou+4o0W/vX3UMInYVvws3M6SMZzGJGwRkbBPQojz1zJTTh1jVnYc8/ii
 X9kTiNseanj99ImRbwtr/wFrTb7/RZbAzm9bHdw7wMaYsdPVEbWII281o/JWrfiKr//1
 Kz7RgWqCOED9Fy1MIocqxHQHaic9Z1AKv0aVZdRF5HUso3DMQtQIoh6QWxX4e1QgeB60
 iYK4qJc7CZWXOIxYEZsPoqOQidimvSG/yrEOq2IJXkW22Sou6vullEJqLt8lEgccJWqP
 Nhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844020; x=1694448820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KLx6XBhwZsbEqcvd2/L0DAF2KnkpBlHb/IZBmOztIQ=;
 b=kH2wply3Ku39Dz739OX2hKURzQDqpVKv39NJxgyKUBmZ2lMPRFzuTnLDVpH/Dgj8B/
 eogrg+wC6sVUawmR+L9VmYYzCzXzmYGWVIP92pHzLrMHv5yBFeGAzDk6rz9h2OJ5bLdJ
 NF2QmHq5BF3sjC7rJIf6ExgwEMAXo4dYVx4hEl+TKEgzsfC9jY0euQ5f50ojH/OqWwgA
 xfc02kCA7Pq8A1j/wjyioOz59j1puW/YZqtM6e9ZrYOsiBPnqnb/32DZVrbFgFj9ILe+
 /ZHoeYbzOdvPW3vBzpKRQI/sQi8eCNaTIO4JIVcnF32n1xYZcKakka20rwu3DxkygPWj
 l9hA==
X-Gm-Message-State: AOJu0Yy25rJHZtRyBd/AGIJPl7OWfRyimd58NG4voHUQ4BL6tKtATf35
 Sm8rnT5s+V8kZrRjIMAzqAtU1w==
X-Google-Smtp-Source: AGHT+IFBQ/yBEMIAy1tSD4vVn96CKnMxMg1fnZooefY+Yy3FCBC29W4MI+VXnaMmlNv93qRp0h0Q0g==
X-Received: by 2002:a19:6914:0:b0:500:b2be:61e1 with SMTP id
 e20-20020a196914000000b00500b2be61e1mr6672295lfc.58.1693844020699; 
 Mon, 04 Sep 2023 09:13:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a1709067e1300b009a198078c53sm6306103ejr.214.2023.09.04.09.13.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 11/22] hw/ide/ahci: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:23 +0200
Message-ID: <20230904161235.84651-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

  hw/ide/ahci.c:1577:23: error: declaration shadows a local variable [-Werror,-Wshadow]
            IDEState *s = &ad->port.ifs[j];
                      ^
  hw/ide/ahci.c:1569:29: note: previous declaration is here
    void ahci_uninit(AHCIState *s)
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 48d550f633..8c9a7c2117 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1573,10 +1573,8 @@ void ahci_uninit(AHCIState *s)
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
-        for (j = 0; j < 2; j++) {
-            IDEState *s = &ad->port.ifs[j];
-
-            ide_exit(s);
+        for (j = 0; j < ARRAY_SIZE(ad->port.ifs); j++) {
+            ide_exit(&ad->port.ifs[j]);
         }
         object_unparent(OBJECT(&ad->port));
     }
-- 
2.41.0


