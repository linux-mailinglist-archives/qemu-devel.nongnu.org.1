Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDC848504
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Feb 2024 10:33:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCO5-000428-5m; Sat, 03 Feb 2024 04:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCO0-0003zP-8H
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:33 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNy-0005ip-Fb
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d93b525959so25779955ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952749; x=1707557549;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EtHvqx0pYo51UarG6u8auC68i9+0d57qDsSmnOr8C/4=;
 b=ixuvQ4Y65maedC0EkbzAi3gleq4OVpAvwflRNALOBw9qpSR/A4w8/Kw1BmuTSBevq+
 pTbmFjfDLmPGF3rhl3JnM8tfK49VqD2V4PFEMI7Em6qHTkXs3Wq8iAEAZqR0ziRekgP0
 P9BfNNPB5emknnX5XvDF4XYYIcWlD8YLoeOjK7sxIJcT+8eiWPBuAqqPEHcmLIwheYWX
 xAn0A4CQ7zLRi2m57+HvNhCfKTkEHNvx+YlPGBRzD4AbHouKLkGmxcBZlxHT7Kw9Ibwz
 JDKzNolgqVxfKZenh41ZdFqkKQAfkqMR7/B9MJpXardPnLLHY7gqBVe1KvdSUGPQ6uxp
 KDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952749; x=1707557549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtHvqx0pYo51UarG6u8auC68i9+0d57qDsSmnOr8C/4=;
 b=bzInMLPS7XL1pqU8oNEy6H2OeEKCfsnGzkNEGeApmcgEI0Z+clfk6HrORVwxIb6dx2
 5Kv7SDvDTG8/P9Oz2k7NZmenMngX93H+3AkW+v7TO3kawOf5flBKpY5x+h36ACEbVwd+
 yNVwqyl5OyaM8mixfu6Vb976uOvQfKfB7O503KSuTlkdFhtTH4OG9lL8gwDinrhy6J2M
 tHkkQYTd9LEyNFbarkrpCczB4UZBOVRczFngHNzz/t5Wwubn/MqRvL417rozdzEU4KFG
 +p3c7DhOlnbjDHMlnKNK6dAIbbHO95hCyIgs3JunVOjSBaxLuRPptJXGn9lY/tdtrIW0
 ChOA==
X-Gm-Message-State: AOJu0Yzf4ZGRyrdpuz9lc44fRhLNriiMAPSgjrf4hpxoUaILas/4ieA7
 K4yYQytfit4HSPYl++L+7UntU1vxCbEGn5iHDxazv7BOT8c2hCieplGJs/IQeVE=
X-Google-Smtp-Source: AGHT+IEacleu1elGvodEq8Gbr/cuF0OM08zPap+G8GNbBnui0R4BJOIxJRoNTk4AjYJesJLbyCV2xg==
X-Received: by 2002:a17:902:ecc6:b0:1d8:cfc9:a323 with SMTP id
 a6-20020a170902ecc600b001d8cfc9a323mr1482124plh.34.1706952749093; 
 Sat, 03 Feb 2024 01:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVQCum7n4aL15VbAV0BDsaBuBMRTfSTzJEBKrwxcnrYcKAg3I35Xech0cI9iBQirAmXxsJU/R05wf7pe6nfH6yMP6LHWhRjR4UHxO5nXxnJeImaZnPX8Y6sdCkJZ0ca+VsvjNJ3IstcIjvDKApTQzKe6WSafGHQfoed5grbftyJI3uDBvnaG5/HgvALNNWTHA2fiEGHMGMzUsWMWw8lnGfElrelP4wkw6qPAsJqXu79OmH5pk7xgaGyM1zt835i4SqpFk1qheoXoFhWdv8Qr+8nUBtMC+U8MAOs4SK/dyEVqxcScENygdt6wT1X+9eQudwX4Rg1Wgv2dHIk5ZesL9ve8HRX3gPpP6jrlVxA1HFEDt3JIt7y7gcDmqmnlSoeIGMmXWDAztGgK77NAwU9dVQiLlQv14Lg0EeB+v4vPw==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 y5-20020a170902ed4500b001d8c8c903c0sm2902310plb.149.2024.02.03.01.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 18:31:57 +0900
Subject: [PATCH 3/6] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-reuse-v1-3-5be8c5ce6338@daynix.com>
References: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
In-Reply-To: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
index 151d9682380d..6befbca31117 100644
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
index 43d863b0c5b0..c98691a90d48 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5dd..71c00f62ee38 100644
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


