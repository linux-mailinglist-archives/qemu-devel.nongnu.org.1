Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E762A06E4A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Jan 2025 07:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm5J-0003c8-Jz; Thu, 09 Jan 2025 01:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm5F-0003Nd-K5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:57 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm5D-0003tL-U3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:57 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so1044540a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404314; x=1737009114;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fLF5NIhJzJ88eyADmFhWZLwmz6xmXA70tRWoalaM1Gg=;
 b=byluxbQwpQTSmgUUdf+FLA/8vuNZQJpv9cwcxLz20xPgt5er11vsLqzDdmAWIopNbQ
 A1Kso0H02JGKiyP19CkqZhRSkr6a3hrnDIzC5zQfYrfl+TgP12Zu5KBz7ptPOfYAgA6u
 1VNtnY6vs68kcZH93nO7KGHq7CchG4S6Ka8t8Mjn7TSciUXdjF+LOk/MInZyk806Y2tc
 m8h/jcyeut3vgomReQLZigUmlaZc6Ctv5ESmw1K3m6v4dZT8ymSXUSZ2pyrwqho8UcCl
 XhfjoadU3kedSDiGDgdwdtHNw9lYoIpfJfMmiaMPSNULfNAavXEewdb8SvyfTMVCksGa
 8gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404314; x=1737009114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLF5NIhJzJ88eyADmFhWZLwmz6xmXA70tRWoalaM1Gg=;
 b=FMOpFHl6zuXnj4VryY5rgmP4sIvzEPlzq1zMrsBqjDYAf+wsFwgAQKjotXW9KqGC4d
 ZneUp6eN9GWmQhkCFIBVA+9NZ0yKqOD323x/LYAHvaqvcZ3Y+/cVhn3L7E54kKpwiwxT
 FuhJnwHJy0eP2cEpRs/pl9Sga8rH0TnmJSwkWVlDOWCBMh6jJIvDrqmJHJcFYz3k8ea8
 t0+xaxgsBwvBilXfc0lfA7TB89u/X8QFIA65pR95k9BnplPeZov2LO3qpDY0lfWW8yYu
 cuFPttjQxbhKaSSl0/iSPaW85e/2RLTwqDYYEeLSyhkTpBjU1OaoQKczgsdNiMcZ3Ffw
 LCoA==
X-Gm-Message-State: AOJu0YwzVnbG3wNYJaFJE6SuuEVw3oaV9mLRCj/78s9Mx1rL9bLDVMG1
 4nfLtOT6E3W8MfmOsZTyaUyEchNBKtv8Hf/kYetqSkOOJcX8VMp5iEGX74z60X0=
X-Gm-Gg: ASbGnctHy44Ld+zSILfa3ONXYdT2Xk2Oy8RTVUd7Fry7WrvlUfbylhSN4amGsRfiAyw
 9sE+Mrqt+j5iSUFMx6Cs1TBjpbR3BFIaVUIYZE5FXxo1syS6KtJBL2SmiAn5CSZ7uvHOX03DdBB
 3qkJwf18jJiz6wQ2MIcohTlnoG+12cZhtM/p+1+lI9Tj+MXHqs4/Je2O+6wj5W1+Rhx/qQ0XmID
 WBaVpyM2ikQ3rKdvc6rHlUr4omrfAO1dtUxsvZgomtRG3nSTofTfKeADmM=
X-Google-Smtp-Source: AGHT+IH1ic3J9A7DWwO7LhVwctj89aLaUxT/L0w1AMYfPbV3QV4FiwBIN0mCTwZNH9xxaXE16v4B6g==
X-Received: by 2002:a05:6a00:124a:b0:725:f376:f4ff with SMTP id
 d2e1a72fcca58-72d21f7bc51mr8263736b3a.13.1736404314344; 
 Wed, 08 Jan 2025 22:31:54 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad81575fsm36187477b3a.36.2025.01.08.22.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:59 +0900
Subject: [PATCH v19 14/14] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250109-reuse-v19-14-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0e..c4d3dc39064c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -248,10 +248,6 @@ struct DeviceState {
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
index 57c1d9df3a7f..09c4489e3c41 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -691,7 +691,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f5380255..6a38b5678760 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -631,6 +631,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -712,13 +713,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.47.1


