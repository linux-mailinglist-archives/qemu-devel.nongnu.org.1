Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE6832D4A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpy-0000n8-6M; Fri, 19 Jan 2024 11:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpw-0000lh-8P
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpu-0004mY-9T
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso10739735e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682117; x=1706286917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyBXToJHpERthhZrSNsFcfkP84TYfgOcTgP/HWJh+Ms=;
 b=n2pa5JkGq8zjQAqJNCk1joHUQtV+jYa76KV3WW/EJ8L1UlYF/QE21DlWbGuaPaexHR
 wz7b9mL7jN5gvR7X/vgSuns5bEfvj3P3mlg1qs0pf+4HMnJg/oCLKilwO6q24+WRRdIQ
 YUTxdlxS/oPv5RZQk06CC2p4YLnIRSKYnBqs1J1x8mfRfVwXMlODr6viU+80m50vyV0Z
 E4Hm2+oPzhf9oorb4NvWFf5eXHY5iNwcF4/aPgpCHM3Zrp9OtBSvImlJI2Cw5PrayKKV
 pgU0a9iNWQtNuCyJZ+z2icO1m2hCpJbxb5S/SFFL62MpwLZkwBuaSq/IyaaT7vwBBJza
 Z2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682117; x=1706286917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyBXToJHpERthhZrSNsFcfkP84TYfgOcTgP/HWJh+Ms=;
 b=XR9eg/8tARFM8WLj6Ve0dUvMUE5FYvDQ1gI/6nyVCmL/QPqtluymFWaYXaUc/hsTV1
 ZCCztGN73qoQlNDIGAOneg2Dzb/0x53p+jQFYPjH/qGa80/winjcmI3eog0XG6Tc58FN
 9wkSqN3HDkwHZKEm5ib5e2xMUPcGe/BAQBD1J+pJ4vKp0SdXlV2iRUW9iWeoPPsR3Anl
 KOEmBEIzbdakx1JSmdJCeReVV9lMGm0tJMH9i9nkUs0Qxvt4eMATcnKAfPPcb4ioH/mG
 nD+s3OGhVozHwTMUsqQsmQIXNIFSW7WgxUXnpXNN4Kfo8xl6/TwO2kopTmTAp5uhgnAN
 0RRw==
X-Gm-Message-State: AOJu0Ywr+hgiShxmmCH6SO7tRxGt3KbuD9I3QtSKzgc/qNfUMAeWslqX
 n8/aqSAf+1VQMNxDKPlRFifM4wDip3kvVBjtceFxbttWhgXTUa2lysamYF2stxoMFODIDcgneyS
 P
X-Google-Smtp-Source: AGHT+IH3a+tlM5QPbqyDtWEfGdrAH79HECjArr30S2qR6lnNedKtNWuRgVMQbAGHW2puUtaR6AFVwA==
X-Received: by 2002:a05:600c:29a:b0:40e:586b:e980 with SMTP id
 26-20020a05600c029a00b0040e586be980mr6365wmk.271.1705682116910; 
 Fri, 19 Jan 2024 08:35:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/core: Remove transitional infrastructure from BusClass
Date: Fri, 19 Jan 2024 16:35:12 +0000
Message-Id: <20240119163512.3810301-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BusClass currently has transitional infrastructure to support
subclasses which implement the legacy BusClass::reset method rather
than the Resettable interface.  We have now removed all the users of
BusClass::reset in the tree, so we can remove the transitional
infrastructure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h |  2 --
 hw/core/bus.c          | 67 ------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d9682380..986c924fa55 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -329,8 +329,6 @@ struct BusClass {
      */
     char *(*get_fw_dev_path)(DeviceState *dev);
 
-    void (*reset)(BusState *bus);
-
     /*
      * Return whether the device can be added to @bus,
      * based on the address that was set (via device properties)
diff --git a/hw/core/bus.c b/hw/core/bus.c
index c7831b5293b..b9d89495cdf 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -232,57 +232,6 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
 
-/**
- * bus_phases_reset:
- * Transition reset method for buses to allow moving
- * smoothly from legacy reset method to multi-phases
- */
-static void bus_phases_reset(BusState *bus)
-{
-    ResettableClass *rc = RESETTABLE_GET_CLASS(bus);
-
-    if (rc->phases.enter) {
-        rc->phases.enter(OBJECT(bus), RESET_TYPE_COLD);
-    }
-    if (rc->phases.hold) {
-        rc->phases.hold(OBJECT(bus));
-    }
-    if (rc->phases.exit) {
-        rc->phases.exit(OBJECT(bus));
-    }
-}
-
-static void bus_transitional_reset(Object *obj)
-{
-    BusClass *bc = BUS_GET_CLASS(obj);
-
-    /*
-     * This will call either @bus_phases_reset (for multi-phases transitioned
-     * buses) or a bus's specific method for not-yet transitioned buses.
-     * In both case, it does not reset children.
-     */
-    if (bc->reset) {
-        bc->reset(BUS(obj));
-    }
-}
-
-/**
- * bus_get_transitional_reset:
- * check if the bus's class is ready for multi-phase
- */
-static ResettableTrFunction bus_get_transitional_reset(Object *obj)
-{
-    BusClass *dc = BUS_GET_CLASS(obj);
-    if (dc->reset != bus_phases_reset) {
-        /*
-         * dc->reset has been overridden by a subclass,
-         * the bus is not ready for multi phase yet.
-         */
-        return bus_transitional_reset;
-    }
-    return NULL;
-}
-
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
@@ -293,22 +242,6 @@ static void bus_class_init(ObjectClass *class, void *data)
 
     rc->get_state = bus_get_reset_state;
     rc->child_foreach = bus_reset_child_foreach;
-
-    /*
-     * @bus_phases_reset is put as the default reset method below, allowing
-     * to do the multi-phase transition from base classes to leaf classes. It
-     * allows a legacy-reset Bus class to extend a multi-phases-reset
-     * Bus class for the following reason:
-     * + If a base class B has been moved to multi-phase, then it does not
-     *   override this default reset method and may have defined phase methods.
-     * + A child class C (extending class B) which uses
-     *   bus_class_set_parent_reset() (or similar means) to override the
-     *   reset method will still work as expected. @bus_phases_reset function
-     *   will be registered as the parent reset method and effectively call
-     *   parent reset phases.
-     */
-    bc->reset = bus_phases_reset;
-    rc->get_transitional_function = bus_get_transitional_reset;
 }
 
 static void qbus_finalize(Object *obj)
-- 
2.34.1


