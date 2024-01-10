Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8C82A349
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNg6M-0001lS-F6; Wed, 10 Jan 2024 16:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mwufZQcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com>)
 id 1rNg6G-0001kQ-Aw
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:27:00 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mwufZQcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com>)
 id 1rNg6E-00011I-Im
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:27:00 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-28b6d5de7f8so2192847a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922012; x=1705526812; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xFUcLlmYVdoFhksu7OL7gQGTf33CNrJzxpdV8oEWtTI=;
 b=jqFAe860RSqOxkt77lzeraqakE/YhUpaL288rlKc06bipFJR7NOAl57aEY1zWSss8a
 hCcFh85f1B83xCbM/6hYLqN2uZMN/azc+yzSMJDODKEEqOHPQsrFOrrpIxqh7oMRSBPx
 8GZJ+6lTogjK/mDtFvFeFrF/v5ugGKAUQ/LhBSthlT9UHhpPMJq63GL7rGn7YU6mP4D4
 kdE92tN8HxAse5I126z/IXfc55kowq5J8QrLcq4adFALLFYfNhv7rAgU1JBHd9YNa5Go
 UKQglFSEGenn+kW0EPNGHzTAGmKDKU+xJgonktGsPQifYcgvNmf4nHAczb99vlQlQ4EZ
 dJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922012; x=1705526812;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFUcLlmYVdoFhksu7OL7gQGTf33CNrJzxpdV8oEWtTI=;
 b=HSnUSBkj8vDBCvNl4tqduspPJT8z35sUzJrspO/Hz3oYv5Y6M+nqwIqigYASHnN6l9
 3Yz77QY3mtGecH1mTnz6nFNlGMw+AfoDqobFbZmBbkHl5jOtVG/aLq297APWCI9Ak/rs
 vo55eBQfMfTHmarwZHGVxnBXUt94GaZZ5yMw/HlFH7vVJBLM+nT8iYNRwS1TsKykuEpC
 86K7oCe3PKYD0gyAqoF2hgWIoOceeI2xka5Yp4Y501DIzRXpAD/LzxKNpYh05bN6BQRZ
 ZmlXq0QiPRq/KXBwyX1GZ8kqRrUkWy2AWhmAowQcqFSZowiRTKCH+XV6+qMNK0sApPkn
 3E5A==
X-Gm-Message-State: AOJu0YxAR40rGwEz2A1yXBPoUa0sdEyHxfpqAxJ3dKqb3aw5i0bUEGwU
 k/5uZne5dkHwwZl+utTH3g/NBw6Ucpzh9qpL7JkKM/5HYCUR2ZKHqL7JuM6dr3FxLfPd3J6JeNp
 R4yxZzSXbxCIGG4tnbl3vhmN3HtZMtRnMa84aSPAZ7dlzBezsMWuy3MPL5k/mmjA4U01f2g==
X-Google-Smtp-Source: AGHT+IHQMRX2C8NCKsrNHCUJe+7wDV9KFZfOqGRs0Cz7bwX2kgMlph4wFDvz2k5KFc8Q/FX5ypSsMzcypxh+
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90b:5183:b0:28d:c290:29a0 with SMTP id
 se3-20020a17090b518300b0028dc29029a0mr712pjb.3.1704922011662; Wed, 10 Jan
 2024 13:26:51 -0800 (PST)
Date: Wed, 10 Jan 2024 21:26:41 +0000
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110212641.1916202-5-komlodi@google.com>
Subject: [PATCH 4/4] hw/i2c: smbus: mux: Reset SMBusDevice state on reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3mwufZQcKCmIKOMLODIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

When a reset happens, both the SMBusDevice and PCA954x class do their
variable resetting on an enter reset. Because of this, only the PCA954x
has its reset called, which can leave the SMBusDevice in a bad state if
it was in the middle of a transaction.

To fix this we add parent reset functions for the SMBusDevice class, and
have the mux class invoke it when it resets.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/i2c_mux_pca954x.c     | 5 +++++
 hw/i2c/smbus_slave.c         | 3 +++
 include/hw/i2c/smbus_slave.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index db5db956a6..307359a518 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -159,8 +159,13 @@ static uint8_t pca954x_read_byte(SMBusDevice *d)
 static void pca954x_enter_reset(Object *obj, ResetType type)
 {
     Pca954xState *s = PCA954X(obj);
+    Pca954xClass *pc = PCA954X_GET_CLASS(obj);
+
     /* Reset will disable all channels. */
     pca954x_write(s, 0);
+    if (pc->parent.parent_phases.enter) {
+        pc->parent.parent_phases.enter(obj, type);
+    }
 }
 
 I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 58abde29de..81adab8f77 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -212,8 +212,11 @@ static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    SMBusDeviceClass *sdc = SMBUS_DEVICE_CLASS(klass);
 
     rc->phases.enter = smbus_device_enter_reset;
+    resettable_class_set_parent_phases(rc, smbus_device_enter_reset, NULL, NULL,
+                                       &sdc->parent_phases);
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index 86bfe0a79e..0dd14be178 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_TYPE(SMBusDevice, SMBusDeviceClass,
 
 struct SMBusDeviceClass {
     I2CSlaveClass parent_class;
+    ResettablePhases parent_phases;
 
     /*
      * An operation with no data, special in SMBus.
-- 
2.43.0.472.g3155946c3a-goog


