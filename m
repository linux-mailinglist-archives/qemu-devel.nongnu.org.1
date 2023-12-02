Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9B801B97
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 10:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Luh-0007mM-Hj; Sat, 02 Dec 2023 04:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Lue-0007lv-9i
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 04:03:48 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Luc-00054z-Hc
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 04:03:48 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28659348677so1077601a91.0
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701507823; x=1702112623;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nKw9R5c507ZufmmUq2p+S5Dtt/jVaEYi9Io6H1xqHIc=;
 b=t2sg5c4e23lKStJSrpP+Eg/OPdHL+sW+uI9BJc1gD49kg4+xFpX6OFegHIMdHiMMMV
 Cg+CxA49c4wZUbcKZnLeh9jn3kebbrflG24Btv4qUr75PSDRvJEtG4ywbFwMdJ9d66TZ
 MISGbhKJsjujAkNEcnFhj4N5yZjRROjfs0j5pyq/mV1ou9NRBIvhf8WnFNiQlPzoIVIf
 u5pGfmIXQ0Brzw/5sr0IbWD5d9b8ylD0pqeixclD9dxaFSMMXbmGzckwnsFNNDhawdQU
 8LBRj8kQuBAJfFvCSs9ruoMFZMF9WnJBIcp3ZVp+c0j0OuV27mdm2ZzJgPBmFEBuhyaD
 MH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701507823; x=1702112623;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKw9R5c507ZufmmUq2p+S5Dtt/jVaEYi9Io6H1xqHIc=;
 b=IFWmVOUL2Ulxc+AosYbaCRQbW/ftxLY/3hXbAaVxYxsygxpGSgUr1zneVDIvXNMqZn
 wVAhNUOhn5hyu3rLA/7aujeujHgDJVbOd42rkIXaY2Y1lPPGRu1qCVo38lk0KpWkcbsB
 yrxTAig3A6PwZyxD08DvaZPW+0mg3vPvpEKj68jU6REyTzd4iJadCqXlQDekA1wkGofm
 quJc2MA2BSPYfhOtx7CdQjSEioU0nEpAgIklkNrP4P4UagnHoM09AftOOY9k10raNSdb
 duTKoH8kAQRk49NCCP0BD3MC6OA73YoO4L5fUMZtiR+sPLH9Z6m0sQ0ax4NynqN9Digb
 UjjA==
X-Gm-Message-State: AOJu0Yy40QotWLLamo9GZzJK9O13qBLce7HtXg4IFnxxByIQMjNSbop/
 cTjqDwm4ZvqHn5Kkzm8MsYOOBQ==
X-Google-Smtp-Source: AGHT+IFU+ve/ruOMJwh+ASaRxKE0G5g7bMvXROJfTFVKgvuiACJ3VNzZyyC9NI/BAHJNsfnA4XmPDQ==
X-Received: by 2002:a17:90a:1999:b0:286:6cc0:629d with SMTP id
 25-20020a17090a199900b002866cc0629dmr1045579pji.28.1701507823371; 
 Sat, 02 Dec 2023 01:03:43 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q10-20020a17090a68ca00b00285256be528sm146045pjj.47.2023.12.02.01.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 01:03:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 18:03:36 +0900
Subject: [PATCH] qdev: Report an error for machine without HotplugHandler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-bus-v1-1-f7540e3a8d62@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOfyamUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIKGbVFqsa26aaGJqkmyaYmlqqQRUWVCUmpZZATYlOra2FgB3Od4HVQA
 AAA==
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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
 system/qdev-monitor.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..62246c65f7 100644
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
+}
 
     /* If device supports async unplug just request it to be done,
      * otherwise just remove it synchronously */

---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231202-bus-75a454c5d959

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


