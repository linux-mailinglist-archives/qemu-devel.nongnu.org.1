Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8C80B8CF
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5W-0005Sw-MZ; Sat, 09 Dec 2023 23:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5R-0005S9-O9
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:37 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5Q-0005C4-2J
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:37 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c66e7eafabso2821249a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181194; x=1702785994;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GziVlMjvsZ2sl/wXrFvNG0jm8Ze2df5208TL7Jvr540=;
 b=Q4s3HOERzqC/DO5GX4RIZE9zuyG3Kdn1u48pHrwwwD3Fjo0NEqcAr1nExcat1Z0KuV
 hGkB67ZXdh/eLUKvpDG78D5YXZwx3vFF9q+HACYGvaOP6lS20kDq15JNMDasOY/SoEgG
 QyrCqS568BAmapxIzDtywoiJjDvpQkHUgSPNHvzNbQBArWXNLg+SeSHZjgkFtVN99ZgX
 ODlfgxw5mjtcry2xRbjlpKPipWcn5tjeaX0hSi6756TxF7E0NNk3rA/NFR5z+8CJmhfb
 95lzdsltHhlmL1psnXs1CMuFv5KP2Fa9F9ZOyQjVtoGjoZsCKfiQduaUSQ3RlI8qwrwB
 weWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181194; x=1702785994;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GziVlMjvsZ2sl/wXrFvNG0jm8Ze2df5208TL7Jvr540=;
 b=aKiYk2iqWEX0Pd49IPtbSaHWT/GLP4Gau/0ytGXOjWcY0H43POCOMmARo2XMvUGZO5
 lIW98CSzmXDNyyVK48PpRoPrSHAohREGMfyYiW42Mbl18i9b0nyPgefKhjeK2Q4okajB
 fmYvaQ8qF9w3ELC7qi/fJ26Nw6XNZlauhXtApvdSLYM1OcnJasbPVAi+dbtXlAvn/WgL
 Da0xak8SN5MbOwoUGtA7+hFwlWYFh9N2ObdQPnoJZB+JSfMmNOaI/7TXVCj/dG+e4Xus
 glgKromI2EOZD0SoGAfTPacYuTFpkewRgxEh5KWzRamaGIn5Y8m87lC6Tr7irGNVfb24
 HRuw==
X-Gm-Message-State: AOJu0YwQRi3VDKsUFjLKyVIRG0axsfaVVEQXwqJTydopdxTpID8wkXBd
 wAC0fu+lKuFs1V2hErJEBFwp9Q==
X-Google-Smtp-Source: AGHT+IF0wyaWpgOspPIZP8yzkpQnNgWzfQxlrwqX1rC+Lilu3Xe1dZjo+vTJWk+1qZBRgtu3Fchcpg==
X-Received: by 2002:a17:902:e5ce:b0:1d2:fa04:7cb2 with SMTP id
 u14-20020a170902e5ce00b001d2fa047cb2mr2472358plf.18.1702181194528; 
 Sat, 09 Dec 2023 20:06:34 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm4109411pld.150.2023.12.09.20.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:48 +0900
Subject: [PATCH RFC v2 05/12] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-5-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..6befbca311 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -237,10 +237,6 @@ struct DeviceState {
      * @pending_deleted_expires_ms: optional timeout for deletion events
      */
     int64_t pending_deleted_expires_ms;
-    /**
-     * @opts: QDict of options for the device
-     */
-    QDict *opts;
     /**
      * @hotplugged: was device added after PHASE_MACHINE_READY?
      */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c98691a90d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..71c00f62ee 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* set properties */
-    dev->opts = qdict_clone_shallow(opts);
-    qdict_del(dev->opts, "driver");
-    qdict_del(dev->opts, "bus");
-    qdict_del(dev->opts, "id");
+    properties = qdict_clone_shallow(opts);
+    qdict_del(properties, "driver");
+    qdict_del(properties, "bus");
+    qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
+    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
                                       errp);
+    qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
     }

-- 
2.43.0


