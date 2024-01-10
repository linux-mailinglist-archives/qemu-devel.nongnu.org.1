Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8182A348
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNg67-0001hp-AL; Wed, 10 Jan 2024 16:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lgufZQcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1rNg65-0001hR-Ki
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:49 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lgufZQcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1rNg64-000108-5H
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:49 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e74c97832aso65182367b3.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922006; x=1705526806; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X73fxUseiD1AEJCI70SmF4TO4nJxvqf3TpYTw9z/euM=;
 b=wIO9v8N3LLlq1M/Al00gZlV0Fa+mErV7+ug/kWTo9CItBN1Jlcy4F1bG6piustExyc
 4WF/wgqaKLHmT9c3ZjRUurricDk/Tg/4KTJfQdLxhdZVOIPfd2DM+LbFKPZYPQtDEwlX
 ROxpUMSeFJ13nfS3F5hVVTN8PqSHE2BVrUgaES+p/4H5Allpt0WSpzj17fbqg3dFcl8X
 4AIlPcSzWc367S338HRQR8VYv3EICdd7WkyKwDk3NL1OgxGhyciOpf+acBqUcYyt5E6Y
 kZmF3DcWORyDoSlyyIc0fF4GarKrx/S+Y7lG6Noa0fkJgvY8N7YAVLQzNHyWIeuuiVpt
 jzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922006; x=1705526806;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X73fxUseiD1AEJCI70SmF4TO4nJxvqf3TpYTw9z/euM=;
 b=jd29dZdsPb/03AeNMdbmdsTMgW2FYRygJUgV5L9Lo3Be4YdyGC5y2mVjFO64arjvvl
 dChCKqw0HosJYRbY4RTRBvl9TMYIc+GI5GDnpdq4UAd/aP+yUQDrpAe8lynbhNn+c7gR
 3l9Pul1sSwc44lfFyS59f4D3zR4JxX5GQH1VsAQSByEshN4IB5mkOSgxW/g8NqZaUdRs
 9y2Hn5IuRAjh4le4/hiBWYOOR3iXB4ZfJH3jmYbTLRYPxCaqXYqlZXjtOtKDFVOR4KlM
 MXuona+YSfhpOlS9mMItMOVgPX3cP0SxABS43mBOYavVbweLxVoE4S0Ju52Y0rCaQUMQ
 e/7g==
X-Gm-Message-State: AOJu0YwR0nyVUu2x/RRZNf0/gDJhQJP94aEp7SlbXkCWQl2gm+TL7HHN
 o8wW4GC3ruF4zEpFIeED3lsFTyL6mcJTN1MyQOTgAgB8TZQGMid8jbIM8y5LLPQDRne3Mq2ZEdd
 Ck9rA75+krDyiFy59Nn1B+dlSNrQ8aPGKKJxR96GaHusVU5W4bdHXrwacfH4EIh2pWe7wiQ==
X-Google-Smtp-Source: AGHT+IEVz1Ak6/6dP8VuNYxH/bM3R7u/MkEGKyaYhYmzvUiFcFSjG+tol/IZoJ1SewjohT/yQY/wrRoj2HI6
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a0d:ce45:0:b0:5f8:e803:4b0d with SMTP id
 q66-20020a0dce45000000b005f8e8034b0dmr121258ywd.2.1704922006030; Wed, 10 Jan
 2024 13:26:46 -0800 (PST)
Date: Wed, 10 Jan 2024 21:26:38 +0000
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110212641.1916202-2-komlodi@google.com>
Subject: [PATCH 1/4] hw/i2c: core: Add reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3lgufZQcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

It's possible for a reset to come in the middle of a transaction, which
causes the bus to be in an old state when a new transaction comes in.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/core.c        | 30 +++++++++++++++++++++++++-----
 include/hw/i2c/i2c.h |  6 +++++-
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..def4f134d0 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -23,11 +23,31 @@ static Property i2c_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const TypeInfo i2c_bus_info = {
-    .name = TYPE_I2C_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(I2CBus),
-};
+static void i2c_bus_enter_reset(Object *obj, ResetType type)
+{
+    I2CBus *bus = I2C_BUS(obj);
+    I2CNode *node, *next;
+
+    bus->broadcast = false;
+    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
+        QLIST_REMOVE(node, next);
+        g_free(node);
+    }
+}
+
+static void i2c_bus_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.enter = i2c_bus_enter_reset;
+}
+
+ static const TypeInfo i2c_bus_info = {
+     .name = TYPE_I2C_BUS,
+     .parent = TYPE_BUS,
+     .instance_size = sizeof(I2CBus),
+     .class_size = sizeof(I2CBusClass),
+     .class_init = i2c_bus_class_init,
+ };
 
 static int i2c_bus_pre_save(void *opaque)
 {
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1b..420868a269 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -64,7 +64,7 @@ struct I2CSlave {
 };
 
 #define TYPE_I2C_BUS "i2c-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
+OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
 
 typedef struct I2CNode I2CNode;
 
@@ -83,6 +83,10 @@ struct I2CPendingMaster {
 typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
 typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingMasters;
 
+struct I2CBusClass {
+    DeviceClass parent_class;
+};
+
 struct I2CBus {
     BusState qbus;
     I2CNodeList current_devs;
-- 
2.43.0.472.g3155946c3a-goog


