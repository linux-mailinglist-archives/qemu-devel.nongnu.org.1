Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B863801B48
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kvw-0004Kz-Ov; Sat, 02 Dec 2023 03:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvg-0004IS-TG
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:49 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kve-0004yR-NX
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:48 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1fb04b2251bso510056fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504045; x=1702108845;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vEZSvELmMn+CZAABU4UFznXntadvaecyTxpcvBhacJw=;
 b=raG8ubyCjw63i3WfjYpq6JzcDsXn0D8prKKwRLHMavmQFhxFK6vCLi8jbuufkBnvqA
 G6JXqjGIrllo1q4TmmJhO0tloouU4lVajciQ5mfqRmXj7o7XfIbyxsxBoHH9/wNTIlUy
 H/CA2Uz/5ny4n/zIBpSeaUg+jqAPpeH+RLClRpP8FEnIHEYiUMFnuULbgQw5NQRIharU
 8jZOVmlVYgP8dtI+JcLPZ4rKQ8SoGqBvpEUf5EQXtSuH7hOFkaYQ67+ln0djpFfR6abf
 AFEjodNUp+Gt9/1xZkfxXQweiWFIKlnDSIoZScwEj7PFxF65De1XdGBFsuPn3LnGdZFH
 4giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504045; x=1702108845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEZSvELmMn+CZAABU4UFznXntadvaecyTxpcvBhacJw=;
 b=lG0+Rjko8WS753JJKnR93PYRlayAz1g5xo07nYOCx2kqYmD2eBAog5dx0E/87eV6Pg
 hkeSynfcFBVapUFzR1qKBWAMPxXg4ZO/hM/FZvfmIvnwQZjaG2iyp+jOryWCpC/hTmut
 cTa/7+N8U7VyZUbdw8wBpjHqI15yWd1q6bmyRc4pgZr9TKtBBHNPjlPN+XbchtYgKYq3
 db+QdlXvDmXATMlLDlXWR1BH1NBXNO/eZGzFW8MyilCkTlFBv5taKlJkquCT62lwbmQf
 MajxE6lYjgD3D4z3OTLveR7Wo2ELRULgIMEi07jAQJPQ2h4/U/rJvRhxchAkikvoG3Xf
 JMdg==
X-Gm-Message-State: AOJu0YxHEtzMT+wzClaUJduqVBpIZJ16biSwFPhLx2CfZ4emXevk3fuG
 dB1lcHF2fxNkFnIjUEQm1vATQw==
X-Google-Smtp-Source: AGHT+IGAl67z3a/aDV7FWG8vBviS0LIZNv65Vrp/DLSXRuKZijKJCgFo0GYNGuk4Eaaf7OVEg3cizQ==
X-Received: by 2002:a05:6870:c0b:b0:1fa:edc2:892e with SMTP id
 le11-20020a0568700c0b00b001faedc2892emr1224357oab.11.1701504045535; 
 Sat, 02 Dec 2023 00:00:45 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 a11-20020a17090acb8b00b00286541736a4sm2813051pju.29.2023.12.02.00.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:26 +0900
Subject: [PATCH 03/14] qdev: Add DeviceClass::hide()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-3-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

DeviceClass::hide() is a better alternative to
DeviceListener::hide_device() that does not need listener registration
and is contained in specific devices that need the hiding capability.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-core.h | 33 +++++++++++++++++++++++----------
 system/qdev-monitor.c  | 11 +++++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 6befbca311..de221b6f02 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -56,16 +56,15 @@
  * Hiding a device
  * ---------------
  *
- * To hide a device, a DeviceListener function hide_device() needs to
- * be registered. It can be used to defer adding a device and
- * therefore hide it from the guest. The handler registering to this
- * DeviceListener can save the QOpts passed to it for re-using it
- * later. It must return if it wants the device to be hidden or
- * visible. When the handler function decides the device shall be
- * visible it will be added with qdev_device_add() and realized as any
- * other device. Otherwise qdev_device_add() will return early without
- * adding the device. The guest will not see a "hidden" device until
- * it was marked visible and qdev_device_add called again.
+ * To hide a device, a DeviceClass function hide() needs to be registered. It
+ * can be used to defer adding a device and therefore hide it from the guest.
+ * The handler can save the QOpts passed to it for re-using it later. It must
+ * return if it wants the device to be hidden or visible. When the handler
+ * function decides the device shall be visible it will be added with
+ * qdev_device_add() and realized as any other device. Otherwise
+ * qdev_device_add() will return early without adding the device. The guest
+ * will not see a "hidden" device until it was marked visible and
+ * qdev_device_add called again.
  *
  */
 
@@ -90,6 +89,8 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
+typedef bool (*DeviceHide)(DeviceClass *dc, const QDict *device_opts,
+                           bool from_json, Error **errp);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
@@ -151,6 +152,18 @@ struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
+    /**
+     * @hide: informs qdev if a device should be visible or hidden.
+     *
+     * This callback is called upon init of the DeviceState.
+     * We can hide a failover device depending for example on the device
+     * opts.
+     *
+     * On errors, it returns false and errp is set. Device creation
+     * should fail in this case.
+     */
+    DeviceHide hide;
+
     /**
      * @reset: deprecated device reset method pointer
      *
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 71c00f62ee..639beabc5f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -669,6 +669,17 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
+    if (dc->hide) {
+        if (dc->hide(dc, opts, from_json, errp)) {
+            if (bus && !qbus_is_hotpluggable(bus)) {
+                error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+            }
+            return NULL;
+        } else if (*errp) {
+            return NULL;
+        }
+    }
+
     if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
         return NULL;

-- 
2.43.0


