Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C5735CDF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISu-0003N7-EL; Mon, 19 Jun 2023 13:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISi-0003Ju-El
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:44 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISg-000252-6r
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:44 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so1466838e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194880; x=1689786880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkFrDIIweegbRGGdzIcZRYuzCjxf5L+g2rFiEeEv9p8=;
 b=mSKcXI5DQE4Su5jqxyGvl/qrP5DBmSzZqy/gEm4lvCpKCmxu9A8Gmy+atJy0oVRBlm
 T3cd+wpsCTcpavEjhaOImcL+Cz7JnYIs5vtdpuH/14rlRVmnRfwPCNWxiNUyfmGyUrQi
 VrHI3YxVKU0ebc1RZ2ww0aDBP3k4aFoKxzaH6JxxW56Ctwp6UnAERJcgwyeBct7CNOeX
 5VCpc9LIdGs2Jn/TRAkA2gdlwmP7S//NV74FTih7i3VKzHqPMhwhlVKOap9k/SHlHi3A
 nH6A+xUAEfdEPG4T2f4vbpc8AEiPAXTFPIJo4XCqLEc3o1MzOPDmtgYYr2JfaKCOMIci
 ANUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194880; x=1689786880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkFrDIIweegbRGGdzIcZRYuzCjxf5L+g2rFiEeEv9p8=;
 b=O6EXN8DrAdk+e3g/CPsGIY+LwtISrh/G5ZbiHsyVJ8bIoSBDF4+aZ7t/aT3m/5igQ9
 se6Q+z/30Az1+Bp2eXzUWARQ0HkhxIQzYnzBfGj9AFVhjRDtJPZ9DaQIb7X/ILv/SbRp
 pXZxTp7qTzIx+/CAhELqqaiASyosJg+bg5BSE70W99SsDvpNthsBmk5c0Jg64QQQZZuN
 rDtf1/ARzpYXCzUka0Naoo3dUxQNv1waLQTxJcyo/alfuUmJhgO4APXGuZTHhPpSlgQc
 pSBIA/Rr2elHz6JvF9NQ4ckt9dr1BPOnsXjnbq5iG+6Mg+pOyZtrD2gaegtIf+GJszP+
 ukmg==
X-Gm-Message-State: AC+VfDz9SWafH/CJLy6wS/jAB7inpMmQl9H9sNwpceQeMtOwL0JdYgY4
 fQqi6r7QEVgsqQF7vIyWlFkD8w==
X-Google-Smtp-Source: ACHHUZ7LA14Q5MOFCl75+yq8/Q25+YyTaT3zW5z+Tl9CIaXSTvbUjNMHfadhxm58faiDKBqEJ8wT2Q==
X-Received: by 2002:a19:915d:0:b0:4f6:1805:6095 with SMTP id
 y29-20020a19915d000000b004f618056095mr5872109lfj.8.1687194880433; 
 Mon, 19 Jun 2023 10:14:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a1cf313000000b003f7361ca753sm11154563wmq.24.2023.06.19.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B06E31FFBE;
 Mon, 19 Jun 2023 18:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/5] include/hw/qdev-core: fixup kerneldoc annotations
 (!COMPLETE)
Date: Mon, 19 Jun 2023 18:14:35 +0100
Message-Id: <20230619171437.357374-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619171437.357374-1-alex.bennee@linaro.org>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

Fix up the kerneldoc markup and start documenting the various fields
in QDEV related structures. Unfortunately this is not enough include
the documentation because kerneldoc currently chokes on some of our
macros such as:

    /**
     * @gpios: list of named GPIOs the device provides.
     */
    QLIST_HEAD(, NamedGPIOList) gpios;

where it demands we document QLIST_HEAD and NamedGPIOList despite them
not technically being fields in the structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/qdev-core.h | 123 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 21 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1070d6dc7..74b4971d7e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -38,7 +38,10 @@ typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
 
 /**
- * DeviceClass:
+ * struct DeviceClass:
+ *
+ * The base class for all devices.
+ *
  * @props: Properties accessing state fields.
  * @realize: Callback function invoked when the #DeviceState:realized
  * property is changed to %true.
@@ -97,22 +100,34 @@ typedef void (*BusUnrealize)(BusState *bus);
  *
  */
 struct DeviceClass {
-    /*< private >*/
+    /* private: */
     ObjectClass parent_class;
-    /*< public >*/
+    /* public: */
 
+    /**
+     * @categories: device categories device belongs to
+     */
     DECLARE_BITMAP(categories, DEVICE_CATEGORY_MAX);
+    /**
+     * @fw_name: name used to identify device to firmware interfaces
+     */
     const char *fw_name;
+    /**
+     * @desc: human readable description of device
+     */
     const char *desc;
 
-    /*
-     * The underscore at the end ensures a compile-time error if someone
-     * assigns to dc->props instead of using device_class_set_props.
+    /**
+     * @props_: properties associated with device, should only be
+     * assigned by using device_class_set_props(). The underscore
+     * ensures a compile-time error if someone attempts to assign
+     * dc->props directly.
      */
     Property *props_;
 
-    /*
-     * Can this device be instantiated with -device / device_add?
+    /**
+     * @user_creatable: Can this device be instantiated with -device / device_add?
+     *
      * All devices should support instantiation with device_add, and
      * this flag should not exist.  But we're not there, yet.  Some
      * devices fail to instantiate with cryptic error messages.
@@ -126,19 +141,28 @@ struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
-    /*
-     * Reset method here is deprecated and replaced by methods in the
-     * resettable class interface to implement a multi-phase reset.
+    /**
+     * @reset: deprecated device reset method pointer
+     *
+     * Modern code should use the ResettableClass interface to
+     * implement a multi-phase reset.
+     *
      * TODO: remove once every reset callback is unused
      */
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
-    /* device state */
+    /**
+     * @vmsd: device state serialisation description for
+     * migration/save/restore
+     */
     const VMStateDescription *vmsd;
 
-    /* Private to qdev / bus.  */
+    /**
+     * @bus_type: bus type
+     * private: to qdev / bus.
+     */
     const char *bus_type;
 };
 
@@ -168,36 +192,91 @@ typedef struct {
 } MemReentrancyGuard;
 
 /**
- * DeviceState:
- * @reset: ResettableState for the device; handled by Resettable interface.
+ * struct DeviceState - common device state, accessed with qdev helpers
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
  */
 struct DeviceState {
-    /*< private >*/
+    /* private: */
     Object parent_obj;
-    /*< public >*/
+    /* public: */
 
+    /**
+     * @id: global device id
+     */
     char *id;
+    /**
+     * @canonical_path: canonical path of realized device in the QOM tree
+     */
     char *canonical_path;
+    /**
+     * @realized: has device been realized?
+     */
     bool realized;
+    /**
+     * @pending_deleted_event: track pending deletion events during unplug
+     */
     bool pending_deleted_event;
+    /**
+     * @pending_deleted_expires_ms: optional timeout for deletion events
+     */
     int64_t pending_deleted_expires_ms;
+    /**
+     * @opts: QDict of options for the device
+     */
     QDict *opts;
+    /**
+     * @hotplugged: was device added after PHASE_MACHINE_READY?
+     */
     int hotplugged;
+    /**
+     * @allow_unplug_during_migration: can device be unplugged during migration
+     */
     bool allow_unplug_during_migration;
+    /**
+     * @parent_bus: bus this device belongs to
+     */
     BusState *parent_bus;
+    /**
+     * @gpios: list of named GPIOs the device provides.
+     */
     QLIST_HEAD(, NamedGPIOList) gpios;
+    /**
+     * @clocks: list of named clocks the device provides.
+     */
     QLIST_HEAD(, NamedClockList) clocks;
+    /**
+     * @child_bus: list of child buses
+     */
     QLIST_HEAD(, BusState) child_bus;
+    /**
+     * @num_child_bus: number of @child_bus entries
+     */
     int num_child_bus;
+    /**
+     * @instance_id_alias: device alias for handling legacy migration setups
+     */
     int instance_id_alias;
+    /**
+     * @alias_required_for_version: indicates @instance_id_alias is
+     * needed for migration
+     */
     int alias_required_for_version;
+    /**
+     * @reset: ResettableState for the device; handled by Resettable interface.
+     */
     ResettableState reset;
+    /**
+     * @unplug_blockers: list of reasons to block unplugging of device
+     */
     GSList *unplug_blockers;
 
-    /* Is the device currently in mmio/pio/dma? Used to prevent re-entrancy */
+    /**
+     * @mem_reentrancy_guard: Is the device currently in mmio/pio/dma?
+     *
+     * Used to prevent re-entrancy confusing things.
+     */
     MemReentrancyGuard mem_reentrancy_guard;
 };
 
@@ -265,7 +344,7 @@ typedef struct BusChild {
 #define QDEV_HOTPLUG_HANDLER_PROPERTY "hotplug-handler"
 
 /**
- * BusState:
+ * struct BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
  * @reset: ResettableState for the bus; handled by Resettable interface.
  */
@@ -290,7 +369,8 @@ struct BusState {
 };
 
 /**
- * GlobalProperty:
+ * typedef GlobalProperty - a global property type
+ *
  * @used: Set to true if property was used when initializing a device.
  * @optional: If set to true, GlobalProperty will be skipped without errors
  *            if the property doesn't exist.
@@ -871,7 +951,8 @@ void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
 /**
- * @qdev_should_hide_device:
+ * qdev_should_hide_device() - check if device should be hidden
+ *
  * @opts: options QDict
  * @from_json: true if @opts entries are typed, false for all strings
  * @errp: pointer to error object
-- 
2.39.2


