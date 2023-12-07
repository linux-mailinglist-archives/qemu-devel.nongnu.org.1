Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E5807E10
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 02:43:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB3P2-0005YO-9v; Wed, 06 Dec 2023 20:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3Oz-0005Y4-97
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:09 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3Ou-0005Km-Rk
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:09 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b9de2332e3so76898b6e.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701913323; x=1702518123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBxHn8pPY9Z5FdN+k7OtNFF2y23J51ZbRWvqj66+tuw=;
 b=j3Gv+l2n6iMtg9GIEuLFe4HZZ09jgXTAc5yRwW++45g0W1CN7smuCBwEePpUfL2Izd
 UOE4HRQYKOkuFJxYWMKjoA14GAtPCrYZaKhVP2X+Ru84JR1jMw/uWqqpmcLXS1i9W1dQ
 q/sQsb4611Zez6EYB2uzJPC5IxlKeZyFmVUcLZohCLCCQZvsfBPaMVBexmdAJSg3WFcR
 Q3YsqarzcfARh+ib2BmDJeDDdF3YM6YhMhEjDRi/QPWJP3RjquoENfAFxw/Gg2uxLwoT
 689COsxY6EJhlrMtcJeWxt+hsK6Bwo5vOYf5zZvPfmy01+xksbLFsqKdsm+yvKhUnCtD
 LzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701913323; x=1702518123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nBxHn8pPY9Z5FdN+k7OtNFF2y23J51ZbRWvqj66+tuw=;
 b=wvO8bpWIuHrjKPXCQQ13X9T4/u5Vxh5ujOzFO1v7lYx2y6JBaewJvTLPmvmSlBEEvU
 j3avv2D0JNq7SMW42sWz9DHry7piBFRo1+HLTFX7aZFDHnPySlqpZjfX9s7FsSgatpnf
 +3PevbHvyXM1BhFB6FWdwDtf2y8DMjN8fT7AhJPGltKQ3Avim9Pp937DY3MCCqBxqOz5
 YglYgxX8RqLTXH61QLvm1FOlVO/UH4qwWzY55+GS7WeEha0ttU9FptgLeJhQb4MZV92/
 Uc6vw2C2wBDv9Y38DTBZCMLqCTWX0xMxe16nx/7Y3EstKcp2K8YhTJq6kFMxpFQYtCuM
 +t0Q==
X-Gm-Message-State: AOJu0YyelVIc50MdZgIL4qKjnfqTNk+T9blcgoaKe4sHWN2Qre5wX4/3
 PzUXIiwLNHH05eoZTY0o+w==
X-Google-Smtp-Source: AGHT+IECfDKy7qgVt3DrtWqB9mGaRcUWA9H3+6hbTsNc/qT/L9gIimJny/ajs2jYtZClp70dFsBvWQ==
X-Received: by 2002:a05:6808:3023:b0:3b8:9906:c267 with SMTP id
 ay35-20020a056808302300b003b89906c267mr2182417oib.56.1701913323558; 
 Wed, 06 Dec 2023 17:42:03 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05680813d000b003b9d00ce109sm57795oiw.34.2023.12.06.17.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 17:42:02 -0800 (PST)
Received: from dell1.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8ff4:f8fd:ca3:53c6])
 by serve.minyard.net (Postfix) with ESMTPA id 78CA51800C6;
 Thu,  7 Dec 2023 01:42:02 +0000 (UTC)
From: minyard@acm.org
To: qemu-devel@nongnu.org
Cc: Potin Lai <potin.lai.pt@gmail.com>, Patrick Venture <venture@google.com>,
 Hao Wu <wuhaotsh@google.com>, Titus Rwantare <titusr@google.com>,
 Corey Minyard <minyard@acm.org>
Subject: [PULL 2/2] hw/i2c: add pca9543 i2c-mux switch
Date: Wed,  6 Dec 2023 19:41:48 -0600
Message-Id: <20231207014148.3116889-3-minyard@acm.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207014148.3116889-1-minyard@acm.org>
References: <20231207014148.3116889-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Potin Lai <potin.lai.pt@gmail.com>

Add pca9543 2-channel i2c-mux switch support.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Reviewed-by: Patrick Venture <venture@google.com>
Message-Id: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
Signed-off-by: Corey Minyard <minyard@acm.org>
---
 hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
 include/hw/i2c/i2c_mux_pca954x.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index db5db956a6..6aace0fc47 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -30,6 +30,7 @@
 
 #define PCA9548_CHANNEL_COUNT 8
 #define PCA9546_CHANNEL_COUNT 4
+#define PCA9543_CHANNEL_COUNT 2
 
 /*
  * struct Pca954xState - The pca954x state object.
@@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
     return pca954x->bus[channel];
 }
 
+static void pca9543_class_init(ObjectClass *klass, void *data)
+{
+    Pca954xClass *s = PCA954X_CLASS(klass);
+    s->nchans = PCA9543_CHANNEL_COUNT;
+}
+
 static void pca9546_class_init(ObjectClass *klass, void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
@@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] = {
         .class_init    = pca954x_class_init,
         .abstract      = true,
     },
+    {
+        .name          = TYPE_PCA9543,
+        .parent        = TYPE_PCA954X,
+        .class_init    = pca9543_class_init,
+    },
     {
         .name          = TYPE_PCA9546,
         .parent        = TYPE_PCA954X,
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
index 3dd25ec983..1da5508ed5 100644
--- a/include/hw/i2c/i2c_mux_pca954x.h
+++ b/include/hw/i2c/i2c_mux_pca954x.h
@@ -3,6 +3,7 @@
 
 #include "hw/i2c/i2c.h"
 
+#define TYPE_PCA9543 "pca9543"
 #define TYPE_PCA9546 "pca9546"
 #define TYPE_PCA9548 "pca9548"
 
-- 
2.34.1


