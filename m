Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3480B91F
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:35:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCSl-00054u-E1; Sun, 10 Dec 2023 00:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCSf-00050O-N6
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:34:41 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCSe-0003m2-0N
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:34:41 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35d77fb7d94so14111045ab.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186478; x=1702791278;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BBcDYo7+RkPWNies+zq0eFCRukVsPbfSClQvBCISWAw=;
 b=gC+rDT0goHJpjEQ6iegMCdiBbPP9+K1xDFpi6bhQ9sxV9mpPrWPA+kQnfQFk7QjFyN
 GBxc7+TdsxxWj0+p3gg6h+WHV+nCchUwS3SrergpnDK5sZrTpW5BwB5UpisNAXr9FLV2
 Xa+tpZSsMhx3e8V2mPkEbIwMhx5zbm3He+SNmf7Ol+JllUbxF9HkW5yyVduaUWZY+hWF
 PUBLpnvE4u4SiWhL3Ky3y9oCm8EupRVLO7jSMWmXRHKV8FEPHZS4v5WmY7tfT24pIe8k
 xaBgWd1A44xH0wFdIehrqVAtZPiuDdjr8FL6nKOMsg/zEWY8WaKtpcLXQXrx+31QB6IG
 3lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186478; x=1702791278;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBcDYo7+RkPWNies+zq0eFCRukVsPbfSClQvBCISWAw=;
 b=qp38PxLXMtxp4imWorj3/VcrFDpoftk79mQcgnmlBa81a0qwnD2irGyLKoHto7ft/x
 h+ZwOoGQfkJlP+1SrhepaBd0MRec6KY5ahGuz5FF0CZopy2mbIhPGb9IENH2iEOAal9j
 dwaP+r4M/5f+sZUm/pvzIj4czW1xP8CzNYBetuFzBLedgLEmE3lecmQGdZ7Y0PhEh2/S
 sJbHDBUwiWnDYxcqqiW0eIHZBmlwyqHsknhL89q7EOrmmddMVYAn920Hh5zNkNql966X
 Oq1laVTBXeySfFyrlUoY4FYIRuo6kWqqmfK7u+HT0wQDvCerF7FfP6a4CIxoHmR6aCNg
 nAvw==
X-Gm-Message-State: AOJu0YxX6pkyMMgcTrhVgMy37VU4ZAeWaaTaqfX8Rl1mlc4RWGImo3CU
 2Gx5ehcOYXGvuWAFhfiREMmd0gSNkVEVavB13qxZIA==
X-Google-Smtp-Source: AGHT+IE9gHlaTUSgC0UexfAyQnInd5fdL+xkqHN91pGwG4d08Yru1vGisOvUvb+RabIyAjJ0OWCvaw==
X-Received: by 2002:a05:6e02:1648:b0:35d:4db2:4ed3 with SMTP id
 v8-20020a056e02164800b0035d4db24ed3mr4282306ilu.3.1702186478756; 
 Sat, 09 Dec 2023 21:34:38 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 az4-20020a170902a58400b001c71ec1866fsm4229405plb.258.2023.12.09.21.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:34:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:34:36 +0900
Subject: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOtNdWUC/1WMwQ7CIBBEf6XZs5hCwVpP/ofpAWFr9yAYUNKm4
 d9de/MyyZvMvA0yJsIMl2aDhIUyxcCgDg242YYHCvLMoFrVSQ5x/2TRG6uNdsYPZgBevhJOtOy
 W28g8U37HtO7SIn/t/79IIcXUG91iZ8/+pK7eroGWo4tPGGutX9VYPeeXAAAA
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The HotplugHandler of the machine will be used when the parent bus does
not exist, but the machine may not have one. Report an error in such a
case instead of aborting.

Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Fixed indention.
- Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
---
 system/qdev-monitor.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..5fe5d49c20 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     qdev_hot_removed = true;
 
     hotplug_ctrl = qdev_get_hotplug_handler(dev);
-    /* hotpluggable device MUST have HotplugHandler, if it doesn't
-     * then something is very wrong with it */
-    g_assert(hotplug_ctrl);
+    if (!hotplug_ctrl) {
+        /*
+         * hotpluggable bus MUST have HotplugHandler, if it doesn't
+         * then something is very wrong with it
+         */
+        assert(!dev->parent_bus);
+
+        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
+        return;
+    }
 
     /* If device supports async unplug just request it to be done,
      * otherwise just remove it synchronously */

---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231202-bus-75a454c5d959

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


