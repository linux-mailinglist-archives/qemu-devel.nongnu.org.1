Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5E7B86CE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5jV-00037Z-Um; Wed, 04 Oct 2023 13:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jO-00034S-P3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jI-0000rX-Ag
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405417465aaso470035e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440729; x=1697045529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxIwwvtSDa6HXj+GPDZLsyAAO0jyEUx+3zbxHDZan+w=;
 b=JKSryxNaBE1PTWpdgxnn43dbHu+jRpoFB1yG5VMCSmWw4z3yk0tXX1juZXZNo/Ulv1
 s9aEvPDZnZkNw5xAFne54Ztuyu7C5O9ekC6J46a4d4G1cQIbaPVvR6TuFi2oaGUGyOFk
 VQo9BHG1kq3wXe3Q+yyXMpNzr8/9AKdYyj1IJUxn8lo0en2Zi/JSfZesYlNuLy7PpnRd
 I2l3x0lhI9rfb0XCgD2YbB6qaoyfbb/+NcdVucXiYHnO1fy6rVWm3e2un/XnZ54MtT+b
 tpqnNNAgsByX67YyTJSqj1HOs1C+kYLweA8bgbNxlnRsTHQsQ27DaJaQQfLC1QBBDkLu
 akQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440729; x=1697045529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxIwwvtSDa6HXj+GPDZLsyAAO0jyEUx+3zbxHDZan+w=;
 b=vy6bYRQvGCyADzFd0dXq12ZpBnFq1wykPXyQK67G8AOKypDyVVcJo0wz22FhgdOpYF
 Qcv9L332Z+IIjSc4b+bGGHB9VeTvb2igU3wvKGJveIchIM0TglJzTSguyqDIEeeA8hTE
 X+Nw6LOzQQAqW7g/AL4HwWOncBn9LNAQMQtSsh7sHqpWbQ9geHR9UcnttxRWFgUDVkTi
 8AoDvs1Y3ZCAxkMHJDApaucVwl4N+T4WG7+BnwTQbl4ZeBg0yxB/2Nb0Nkb3j6UIiHKC
 GKThJQZ2jdO7RppYUM0SoKzC0ccHY71q5wa6X1r2FA1VDXsRLZ2Td4HIYdcFUMtihnx5
 0A/g==
X-Gm-Message-State: AOJu0YyECb6vQRLsbfkmVS1WHJmziIfnpNdJ3AWkdDUwlkJRBe1BpcI4
 GtOlpapQX0k2vaXOb1d89Oe4TevzEEO9TG6FyQw=
X-Google-Smtp-Source: AGHT+IHFJRiWgiXxCNCuOhksrc/+zJJyQyXst+sPuVqWTmmvISnQXpGX+DAcLS0uGP8mE0QrohYoFQ==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr2874935wmk.38.1696440729211; 
 Wed, 04 Oct 2023 10:32:09 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 m15-20020a7bcb8f000000b003fc0505be19sm2002229wmi.37.2023.10.04.10.32.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 01/21] qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
Date: Wed,  4 Oct 2023 19:31:36 +0200
Message-ID: <20231004173158.42591-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/ppc/spapr_pci.c        | 4 ++--
 softmmu/qdev-monitor.c    | 8 +++++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 8dd9fcb071..1a9c2d3502 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_BUS_NO_HOTPLUG \
-    "Bus '%s' does not support hotplugging"
-
 #define QERR_DEVICE_HAS_NO_MEDIUM \
     "Device '%s' has no medium"
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 370c5a90f2..7f063f5852 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1550,7 +1550,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
          * we need to let them know it's not enabled
          */
         if (plugged_dev->hotplugged) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG,
+            error_setg(errp, "Bus '%s' does not support hotplugging",
                        object_get_typename(OBJECT(phb)));
             return;
         }
@@ -1671,7 +1671,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     if (!phb->dr_enabled) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG,
+        error_setg(errp, "Bus '%s' does not support hotplugging",
                    object_get_typename(OBJECT(phb)));
         return;
     }
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 74f4e41338..3a9740dcbd 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -656,7 +656,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     if (qdev_should_hide_device(opts, from_json, errp)) {
         if (bus && !qbus_is_hotpluggable(bus)) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
         }
         return NULL;
     } else if (*errp) {
@@ -664,7 +665,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging", bus->name);
         return NULL;
     }
 
@@ -904,7 +905,8 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     }
 
     if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging",
+                   dev->parent_bus->name);
         return;
     }
 
-- 
2.41.0


