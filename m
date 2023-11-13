Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C17E9EF3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:40:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Y63-0006LG-IM; Mon, 13 Nov 2023 09:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <potin.lai.pt@gmail.com>)
 id 1r2QWk-00062a-HO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:34:31 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <potin.lai.pt@gmail.com>)
 id 1r2QWh-0000hW-PU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:34:30 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso30664465ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 22:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699857257; x=1700462057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3wZ7CYuE2VDasYRy4f/EaKf4pvD1GRLnzVdlSy29Vzs=;
 b=lrPSuE38yVIrivxc5WYkJayqukCTyxyDaMCDaBIKgQeyuHNjCwmk7MtODuDUkFOVVp
 d924hnoNqsUkxcUHQQZ9pyuJGPn70jMBlbidW/+A65Jau+y3UbElAoLsYbKsOeOv7srg
 mLnnVY6rbWfTC9ncZZ4ROjmYijhlBtSEqeOD4+jYbSj6bDojh0f2a2iiScJPIRe7VJjK
 ET/1sfXZfBWYNiL3oMzJonE899f4s6A2V96VXL34A1j+xgmogwnxTjdkBJ500R+KiUbV
 J9lbLLUTqF3YqwpKV0R7UFpr8t5kUZQ778yKcnZP9aoZScrQdujKIBt3nniPd28dXUNC
 iCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699857257; x=1700462057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wZ7CYuE2VDasYRy4f/EaKf4pvD1GRLnzVdlSy29Vzs=;
 b=M7c9EGGNPaz3ZfIph+rrGkhWPs6/SNvqtGW4011GIt2/Hfr7IZi6tKeSW7fmIHkqhZ
 Rv0C0NiNdErvt/wzTb8+ey7+jmgKI4G4IG/0ZnMOLDJwqxGbbflpcCYfe4VJgME6WGIu
 dbd0H9vpQSx4v7M+829iJbT5Nomcr9A8xe/gKn64ATsRxFSrWHaSLBN+tONkVhYavbm3
 H7neMYwwEU25bBldx+61QP8JT5LUEBmWYG2ZfRiIc413RlCiP8PzS+hZh1u0FYpEGlvm
 duMq5XW1wRkM0XJgkNmPcCsxNEAx966F+FpMXkWPLM0XPsLk08x+BdvC4NAUV0Jubp2o
 C8tA==
X-Gm-Message-State: AOJu0Yzfy3gBy1PH9XLfk+G+qCb0pVsHmZrJ4pl0Mgs18ytrFbfSr+Nj
 wUAekMdBsQwFtEy8Y2ZlNQQ=
X-Google-Smtp-Source: AGHT+IFa3+YDERqt1kFFNfOXSBUGDLQ75jaiskVwXDBxt+z0Zi20gs6o/548Fvf1jH6zDa1Goi53rw==
X-Received: by 2002:a17:902:d506:b0:1cc:467a:338f with SMTP id
 b6-20020a170902d50600b001cc467a338fmr8948062plg.4.1699857256875; 
 Sun, 12 Nov 2023 22:34:16 -0800 (PST)
Received: from localhost.localdomain (1-34-21-66.hinet-ip.hinet.net.
 [1.34.21.66]) by smtp.gmail.com with ESMTPSA id
 iw14-20020a170903044e00b001c5076ae6absm3409329plb.126.2023.11.12.22.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 22:34:16 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Patrick Venture <venture@google.com>
Cc: qemu-devel@nongnu.org,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/1] hw/i2c: add pca9543 i2c-mux switch
Date: Mon, 13 Nov 2023 14:31:56 +0800
Message-Id: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=potin.lai.pt@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Nov 2023 09:39:17 -0500
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

Add pca9543 2-channel i2c-mux switch support.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
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
2.31.1


