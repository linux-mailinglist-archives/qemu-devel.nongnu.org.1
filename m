Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639C82A346
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNg6J-0001ko-Lo; Wed, 10 Jan 2024 16:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mQufZQcKCmAIMKJMBGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--komlodi.bounces.google.com>)
 id 1rNg69-0001iI-0I
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:53 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mQufZQcKCmAIMKJMBGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--komlodi.bounces.google.com>)
 id 1rNg67-00010y-Im
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:52 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5f9e5455db1so29584897b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922010; x=1705526810; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=y123XMP/caBorPk6crLzl1eoEJf2Tw2ucYeM6ljh3JY=;
 b=PmD9ftRL4WEraqxuAV3trWvQbRa0eJjMA0nllMpe4tA3CkB9Tbie48rFIVZfhRZqSe
 b+ztgskOYFhZRavyFEORshv6YmT3mJub8AUz0+lvGn8inPfs00AZTFM/MEbqT0g6BkJ4
 f2fDaokR1O2B1NhGa870bqkqVoFxJU895iNntvjIsyqW02nY05ky7CvTxTE7gfuiFFkh
 tARfkO2GoGpWh5aFdJtwCRvJVhwO2veZ1Jil8u/rjzCUL9TMvXLDbz3JUCR8GMX0m8KH
 FysdEg/jkRf71Hq4kzsz8qxRRl3lRWUpUnVwujBtvGo43UoLrf7/6i35YsBTuytyESWe
 026A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922010; x=1705526810;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y123XMP/caBorPk6crLzl1eoEJf2Tw2ucYeM6ljh3JY=;
 b=rf4BEVhQjklp9iCzqmA5kFFI1/t2sbflEKNeRWk0+sJreLYuTV9OJnOOOC/VXU1Avp
 ECWhpCW3ryMvYGC+qjx3c3SScs5GSkmEo4Lf5SVhkvI20iOALuuoiqElpFe2PtNwFZqd
 tZyH8BqosaHvLD7yvL/5Kww9hLprnBGH705mvtNNe8UcLUBkcgG2wA2Tay90p8RyhsF3
 t3WhLColUi5MKzNgUbhE1sykCGnE3cIWWXGLr7L0uuLTVvmQufG8o4hhELUrQTffaM05
 p76D9jAd/BpYL9KdpsyxOgfvuc8WQlYU+VpXt3wNuXpDZ4P4QZw5h+oX/SRWqng/lbGM
 Taig==
X-Gm-Message-State: AOJu0YyEi4j3R+tqZOI+MU9GZk9592i9UMk6V6E13STc8KRrIes2hNnz
 OejFK/pcNq9jBm9UW5pPa5M+RQIDcQsYYIPUS3dVHpIBXibrNpj4kGiRfrL7Qt1fWIKx/CPbP2e
 FFy89gsgdSW2Obu5aJQU6QDi3sLYHNe66WD10FROxDT8scF5QHp5t32MZMI/HVQDue7iFow==
X-Google-Smtp-Source: AGHT+IEStgegXrEJ13kAZArqrt8JrYPRLjgklROeQnl0tT/sQd2sXO0f9s9/5fdQm22vi/7vYHsAzzXmWR+J
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a81:df01:0:b0:5f9:2515:19a5 with SMTP id
 c1-20020a81df01000000b005f9251519a5mr103380ywn.5.1704922009581; Wed, 10 Jan
 2024 13:26:49 -0800 (PST)
Date: Wed, 10 Jan 2024 21:26:40 +0000
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110212641.1916202-4-komlodi@google.com>
Subject: [PATCH 3/4] hw/i2c: smbus_slave: Reset state on reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3mQufZQcKCmAIMKJMBGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

If a reset comes while the SMBus device is not in its idle state, it's
possible for it to get confused on valid transactions post-reset.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/smbus_slave.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index e24a1ef472..58abde29de 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,10 +201,19 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
+static void smbus_device_enter_reset(Object *obj, ResetType type)
+{
+    SMBusDevice *dev = SMBUS_DEVICE(obj);
+    dev->mode = SMBUS_IDLE;
+    dev->data_len = 0;
+}
+
 static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.enter = smbus_device_enter_reset;
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
-- 
2.43.0.472.g3155946c3a-goog


