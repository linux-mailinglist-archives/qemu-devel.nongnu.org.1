Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E579801B49
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwD-0004Pk-3d; Sat, 02 Dec 2023 03:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvv-0004Mh-Kd
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:04 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvt-00051Q-49
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:03 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35d396ae91fso10315205ab.3
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504060; x=1702108860;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FtHitzkUtA9s8p+8tFrhebFAAv44x+6SLPyGvXp0SkM=;
 b=IL9QxYvh1BMyCo4CVdKMX8Utf66FpjiMk3MfMPIKTwM5yac0lHBcHwt5fuVo5pBzPV
 FEVFZ6iMaSRwBk3WgTWSrF6F9MNShlUDwurhTaqBdQEg777OGCrWirg4FV48bY+PIAf+
 YPaYqIADTAVnF1h18QieNRXZaHof8Gh4bpEgMrgZNMPCbX52uOeSPhTtQu49lTJWM7aR
 oo/kJkPnopVSfXCqZfxpPbl2kFNCKCzf/SLuZHlJYa2dccmqc+JPVVl6Y0ahNkmPMNej
 TsfFuJJ75gwIjHSC8rh2XvnnYTBH/zhUISmgT8zJcaFvXMgn+1O/O1G4S5MuXasg8HW4
 mraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504060; x=1702108860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtHitzkUtA9s8p+8tFrhebFAAv44x+6SLPyGvXp0SkM=;
 b=CUZ7ha7cgBZiqh496Apr4R/zio3A17NBnqo408wns5ZWeagdBt6/dhLzaYHEapchpl
 goB9w0dZFa6FEU/3H4j4dW+5eTxwN67o0jAiZDRpk3YnJDBFE+VZdfx9/DCh3x8bczun
 ZDvWxC6zgJ8CzU/RPtiDIcasgPPAdNA5es6GPm+jqk7ph+R5PJsdkGiHotkAt4Ejsxpm
 6yLCIWRB1fXjcWu+Hao1sSdrDFXjiTo4jyZhDL4J1k6VnFKtq3CcdrG43yW/BR4dg2Xh
 +JSs7ai5pkWqWJUaiz5wBIeneejAtKWn/8IXE1OHpOBeiOGsDO6Icf6Qjir3SZPw2DGz
 IRpw==
X-Gm-Message-State: AOJu0YzXLHQkXNQhylDdf7c/tRl2NQvu0X9jmaHDpYQ9Ahj7/E8Rkn/w
 2X2+Cbg2fXELAg2CtI+X/OtDCg==
X-Google-Smtp-Source: AGHT+IGcx+erN1zGqRmllSQfRVjs05PCWY8p+aRCrjJ9b9gyZwc4QuuWB8kCWb379lfuRW8j8InqOw==
X-Received: by 2002:a05:6e02:154b:b0:35d:59a2:332d with SMTP id
 j11-20020a056e02154b00b0035d59a2332dmr1098657ilu.49.1701504060175; 
 Sat, 02 Dec 2023 00:01:00 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q11-20020a170902a3cb00b001a98f844e60sm4587690plb.263.2023.12.02.00.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:29 +0900
Subject: [PATCH 06/14] qdev: Remove DeviceListener::hide_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-6-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x135.google.com
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-core.h | 24 ------------------------
 hw/core/qdev.c         | 18 ------------------
 system/qdev-monitor.c  |  9 ---------
 3 files changed, 51 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index de221b6f02..9acf6f79c4 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -306,17 +306,6 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
-    /*
-     * This callback is called upon init of the DeviceState and
-     * informs qdev if a device should be visible or hidden.  We can
-     * hide a failover device depending for example on the device
-     * opts.
-     *
-     * On errors, it returns false and errp is set. Device creation
-     * should fail in this case.
-     */
-    bool (*hide_device)(DeviceListener *listener, const QDict *device_opts,
-                        bool from_json, Error **errp);
     QTAILQ_ENTRY(DeviceListener) link;
 };
 
@@ -1054,19 +1043,6 @@ static inline void qbus_mark_full(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
-/**
- * qdev_should_hide_device() - check if device should be hidden
- *
- * @opts: options QDict
- * @from_json: true if @opts entries are typed, false for all strings
- * @errp: pointer to error object
- *
- * When a device is added via qdev_device_add() this will be called.
- *
- * Return: if the device should be added now or not.
- */
-bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp);
-
 typedef enum MachineInitPhase {
     /* current_machine is NULL.  */
     PHASE_NO_MACHINE,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c98691a90d..e61a147016 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -224,24 +224,6 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
-bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp)
-{
-    ERRP_GUARD();
-    DeviceListener *listener;
-
-    QTAILQ_FOREACH(listener, &device_listeners, link) {
-        if (listener->hide_device) {
-            if (listener->hide_device(listener, opts, from_json, errp)) {
-                return true;
-            } else if (*errp) {
-                return false;
-            }
-        }
-    }
-
-    return false;
-}
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 639beabc5f..42aac94b8c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -660,15 +660,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         }
     }
 
-    if (qdev_should_hide_device(opts, from_json, errp)) {
-        if (bus && !qbus_is_hotpluggable(bus)) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
-        }
-        return NULL;
-    } else if (*errp) {
-        return NULL;
-    }
-
     if (dc->hide) {
         if (dc->hide(dc, opts, from_json, errp)) {
             if (bus && !qbus_is_hotpluggable(bus)) {

-- 
2.43.0


