Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A191C7400A6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMG-0000zC-JR; Tue, 27 Jun 2023 12:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMD-0000xw-G7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBM7-000877-4f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fba9daf043so5606675e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882549; x=1690474549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4ci5VE+k1gGIJE6LmmjZ/ph4n9gVg3oZR4Aey8XFSs=;
 b=XkEzaguorrSddSTVJnXO5+U2kD2x6oBkwBvupyQZScS07eXwG4JTG3kg7HlnjkzqiX
 QTOz6Es3kaxH/ssrICwtYeQpYZ1+GH/Tz6Xe019qkVysP4MTxvMSAEQezb9OP5oXzqzR
 iAkz7PpEn2iS+L0QbPKUSdRpoeVSIMWqYLYw9lNBQw7OyqrLo2jKPtwNNlXx03KWUn4i
 Rbz6yshw2+DBNwmLrqI5RNMqIRxnH3NOUuTzi1T31+L99bvWmkECBZxQeJQ+aCsBY9c+
 D+vVZ6QUMB99uJxEKtCXmjNLgIrorDOyGfN0SHvHRDlTluQHxCF3AlC6C1KkHosAuZL1
 mYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882549; x=1690474549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4ci5VE+k1gGIJE6LmmjZ/ph4n9gVg3oZR4Aey8XFSs=;
 b=HgWR2CUiQqeVm4N7P5W1zGiUHSRjhUo6FHndCfGXFb8wgjnsjWavqABLzeEY+nZJKd
 8Ml0DsBHGjkzJvtWG2tIUqqXXnbC0fQdfuHaY/M2ZzTEWPDdiQMRSRFXa6pHLZdA3mkD
 F/zZxZqj9YvKYfpyu3AuIp1YT8O0j6vWHee5hkx+RMxiPuXviQO21oU43PUJMAxzRzE2
 LoZ2BkegkoxeKwfBITJ1pVWD6HVpB21CaJkKlaTxOOYiXnKtnzeO9WdFcT+iQvzBX6Xi
 /nfBSbfWcGqT1PBDWUk1L48A3zNrRpnJQd+erluzFpmoEe5a/JOOAGSPaFWpdxooDxn9
 QeCA==
X-Gm-Message-State: AC+VfDwvVow0OuQEg0c2WNZbrBRqSM9Pz7gyFSMdj1OFGumx3WgzkGCF
 7kn6Ri2vq2p7WmJGtsJBjDer5w==
X-Google-Smtp-Source: ACHHUZ6JbK6tCVYCfBNM9KqeUaytmbrQozd28P8FN9c4Df3uhGgzDFyjnRv1t289F53vvH4FgBffdA==
X-Received: by 2002:a05:600c:231a:b0:3f9:b430:199b with SMTP id
 26-20020a05600c231a00b003f9b430199bmr19322052wmo.15.1687882548949; 
 Tue, 27 Jun 2023 09:15:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adffc06000000b00313e421c620sm9996187wrr.54.2023.06.27.09.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90F841FFCF;
 Tue, 27 Jun 2023 17:09:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 22/36] include/hw/qdev-core: fixup kerneldoc annotations
Date: Tue, 27 Jun 2023 17:09:29 +0100
Message-Id: <20230627160943.2956928-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fix up the kerneldoc markup and start documenting the various fields
in QDEV related structures. This involved:

 - moving overall description to a DOC: comment at top
 - fixing various markup issues for types and structures
 - adding missing Return: statements
 - adding some typedefs to hide QLIST macros in headers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-4-alex.bennee@linaro.org>

---
v3
  - checkpatch cleanups
---
 include/hw/qdev-core.h | 367 ++++++++++++++++++++++++++++-------------
 1 file changed, 253 insertions(+), 114 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1070d6dc7..102e226d90 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -10,6 +10,65 @@
 #include "hw/hotplug.h"
 #include "hw/resettable.h"
 
+/**
+ * DOC: The QEMU Device API
+ *
+ * All modern devices should represented as a derived QOM class of
+ * TYPE_DEVICE. The device API introduces the additional methods of
+ * @realize and @unrealize to represent additional stages in a device
+ * objects life cycle.
+ *
+ * Realization
+ * -----------
+ *
+ * Devices are constructed in two stages:
+ *
+ * 1) object instantiation via object_initialize() and
+ * 2) device realization via the #DeviceState.realized property
+ *
+ * The former may not fail (and must not abort or exit, since it is called
+ * during device introspection already), and the latter may return error
+ * information to the caller and must be re-entrant.
+ * Trivial field initializations should go into #TypeInfo.instance_init.
+ * Operations depending on @props static properties should go into @realize.
+ * After successful realization, setting static properties will fail.
+ *
+ * As an interim step, the #DeviceState.realized property can also be
+ * set with qdev_realize(). In the future, devices will propagate this
+ * state change to their children and along busses they expose. The
+ * point in time will be deferred to machine creation, so that values
+ * set in @realize will not be introspectable beforehand. Therefore
+ * devices must not create children during @realize; they should
+ * initialize them via object_initialize() in their own
+ * #TypeInfo.instance_init and forward the realization events
+ * appropriately.
+ *
+ * Any type may override the @realize and/or @unrealize callbacks but needs
+ * to call the parent type's implementation if keeping their functionality
+ * is desired. Refer to QOM documentation for further discussion and examples.
+ *
+ * .. note::
+ *   Since TYPE_DEVICE doesn't implement @realize and @unrealize, types
+ *   derived directly from it need not call their parent's @realize and
+ *   @unrealize. For other types consult the documentation and
+ *   implementation of the respective parent types.
+ *
+ * Hiding a device
+ * ---------------
+ *
+ * To hide a device, a DeviceListener function hide_device() needs to
+ * be registered. It can be used to defer adding a device and
+ * therefore hide it from the guest. The handler registering to this
+ * DeviceListener can save the QOpts passed to it for re-using it
+ * later. It must return if it wants the device to be hidden or
+ * visible. When the handler function decides the device shall be
+ * visible it will be added with qdev_device_add() and realized as any
+ * other device. Otherwise qdev_device_add() will return early without
+ * adding the device. The guest will not see a "hidden" device until
+ * it was marked visible and qdev_device_add called again.
+ *
+ */
+
 enum {
     DEV_NVECTORS_UNSPECIFIED = -1,
 };
@@ -38,7 +97,7 @@ typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
 
 /**
- * DeviceClass:
+ * struct DeviceClass - The base class for all devices.
  * @props: Properties accessing state fields.
  * @realize: Callback function invoked when the #DeviceState:realized
  * property is changed to %true.
@@ -47,72 +106,36 @@ typedef void (*BusUnrealize)(BusState *bus);
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
  * as readonly "hotpluggable" property of #DeviceState instance
  *
- * # Realization #
- * Devices are constructed in two stages,
- * 1) object instantiation via object_initialize() and
- * 2) device realization via #DeviceState:realized property.
- * The former may not fail (and must not abort or exit, since it is called
- * during device introspection already), and the latter may return error
- * information to the caller and must be re-entrant.
- * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
- * After successful realization, setting static properties will fail.
- *
- * As an interim step, the #DeviceState:realized property can also be
- * set with qdev_realize().
- * In the future, devices will propagate this state change to their children
- * and along busses they expose.
- * The point in time will be deferred to machine creation, so that values
- * set in @realize will not be introspectable beforehand. Therefore devices
- * must not create children during @realize; they should initialize them via
- * object_initialize() in their own #TypeInfo.instance_init and forward the
- * realization events appropriately.
- *
- * Any type may override the @realize and/or @unrealize callbacks but needs
- * to call the parent type's implementation if keeping their functionality
- * is desired. Refer to QOM documentation for further discussion and examples.
- *
- * <note>
- *   <para>
- * Since TYPE_DEVICE doesn't implement @realize and @unrealize, types
- * derived directly from it need not call their parent's @realize and
- * @unrealize.
- * For other types consult the documentation and implementation of the
- * respective parent types.
- *   </para>
- * </note>
- *
- * # Hiding a device #
- * To hide a device, a DeviceListener function hide_device() needs to
- * be registered.
- * It can be used to defer adding a device and therefore hide it from
- * the guest. The handler registering to this DeviceListener can save
- * the QOpts passed to it for re-using it later. It must return if it
- * wants the device to be hidden or visible. When the handler function
- * decides the device shall be visible it will be added with
- * qdev_device_add() and realized as any other device. Otherwise
- * qdev_device_add() will return early without adding the device. The
- * guest will not see a "hidden" device until it was marked visible
- * and qdev_device_add called again.
- *
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
+     * @user_creatable: Can user instantiate with -device / device_add?
+     *
      * All devices should support instantiation with device_add, and
      * this flag should not exist.  But we're not there, yet.  Some
      * devices fail to instantiate with cryptic error messages.
@@ -120,25 +143,35 @@ struct DeviceClass {
      * behavior would be cruel; clearing this flag will protect them.
      * It should never be cleared without a comment explaining why it
      * is cleared.
+     *
      * TODO remove once we're there
      */
     bool user_creatable;
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
 
@@ -167,37 +200,96 @@ typedef struct {
     bool engaged_in_io;
 } MemReentrancyGuard;
 
+
+typedef QLIST_HEAD(, NamedGPIOList) NamedGPIOListHead;
+typedef QLIST_HEAD(, NamedClockList) NamedClockListHead;
+typedef QLIST_HEAD(, BusState) BusStateHead;
+
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
-    QLIST_HEAD(, NamedGPIOList) gpios;
-    QLIST_HEAD(, NamedClockList) clocks;
-    QLIST_HEAD(, BusState) child_bus;
+    /**
+     * @gpios: QLIST of named GPIOs the device provides.
+     */
+    NamedGPIOListHead gpios;
+    /**
+     * @clocks: QLIST of named clocks the device provides.
+     */
+    NamedClockListHead clocks;
+    /**
+     * @child_bus: QLIST of child buses
+     */
+    BusStateHead child_bus;
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
-
-    /* Is the device currently in mmio/pio/dma? Used to prevent re-entrancy */
+    /**
+     * @mem_reentrancy_guard: Is the device currently in mmio/pio/dma?
+     *
+     * Used to prevent re-entrancy confusing things.
+     */
     MemReentrancyGuard mem_reentrancy_guard;
 };
 
@@ -264,13 +356,24 @@ typedef struct BusChild {
 
 #define QDEV_HOTPLUG_HANDLER_PROPERTY "hotplug-handler"
 
+typedef QTAILQ_HEAD(, BusChild) BusChildHead;
+typedef QLIST_ENTRY(BusState) BusStateEntry;
+
 /**
- * BusState:
+ * struct BusState:
+ * @obj: parent object
+ * @parent: parent Device
+ * @name: name of bus
  * @hotplug_handler: link to a hotplug handler associated with bus.
- * @reset: ResettableState for the bus; handled by Resettable interface.
+ * @max_index: max number of child buses
+ * @realized: is the bus itself realized?
+ * @full: is the bus full?
+ * @num_children: current number of child buses
  */
 struct BusState {
+    /* private: */
     Object obj;
+    /* public: */
     DeviceState *parent;
     char *name;
     HotplugHandler *hotplug_handler;
@@ -279,18 +382,24 @@ struct BusState {
     bool full;
     int num_children;
 
-    /*
-     * children is a RCU QTAILQ, thus readers must use RCU to access it,
-     * and writers must hold the big qemu lock
+    /**
+     * @children: an RCU protected QTAILQ, thus readers must use RCU
+     * to access it, and writers must hold the big qemu lock
+     */
+    BusChildHead children;
+    /**
+     * @sibling: next bus
+     */
+    BusStateEntry sibling;
+    /**
+     * @reset: ResettableState for the bus; handled by Resettable interface.
      */
-
-    QTAILQ_HEAD(, BusChild) children;
-    QLIST_ENTRY(BusState) sibling;
     ResettableState reset;
 };
 
 /**
- * GlobalProperty:
+ * typedef GlobalProperty - a global property type
+ *
  * @used: Set to true if property was used when initializing a device.
  * @optional: If set to true, GlobalProperty will be skipped without errors
  *            if the property doesn't exist.
@@ -324,7 +433,8 @@ compat_props_add(GPtrArray *arr,
  * This only allocates the memory and initializes the device state
  * structure, ready for the caller to set properties if they wish.
  * The device still needs to be realized.
- * The returned object has a reference count of 1.
+ *
+ * Return: a derived DeviceState object with a reference count of 1.
  */
 DeviceState *qdev_new(const char *name);
 
@@ -334,16 +444,18 @@ DeviceState *qdev_new(const char *name);
  *
  * This is like qdev_new(), except it returns %NULL when type @name
  * does not exist, rather than asserting.
+ *
+ * Return: a derived DeviceState object with a reference count of 1 or
+ * NULL if type @name does not exist.
  */
 DeviceState *qdev_try_new(const char *name);
 
 /**
- * qdev_is_realized:
+ * qdev_is_realized() - check if device is realized
  * @dev: The device to check.
  *
- * May be called outside big qemu lock.
- *
- * Returns: %true% if the device has been fully constructed, %false% otherwise.
+ * Context: May be called outside big qemu lock.
+ * Return: true if the device has been fully constructed, false otherwise.
  */
 static inline bool qdev_is_realized(DeviceState *dev)
 {
@@ -361,11 +473,11 @@ static inline bool qdev_is_realized(DeviceState *dev)
  * @dev must not be plugged into a bus already.
  * If @bus, plug @dev into @bus.  This takes a reference to @dev.
  * If @dev has no QOM parent, make one up, taking another reference.
- * On success, return true.
- * On failure, store an error through @errp and return false.
  *
  * If you created @dev using qdev_new(), you probably want to use
  * qdev_realize_and_unref() instead.
+ *
+ * Return: true on success, else false setting @errp with error
  */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
 
@@ -392,6 +504,8 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
  * for the only reference to the child device to be held by the parent
  * via the child<> property, and so the reference-count-drop done here
  * would be incorrect. For that use case you want qdev_realize().
+ *
+ * Return: true on success, else false setting @errp with error
  */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 
@@ -420,16 +534,16 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
+
 /**
- * qdev_get_hotplug_handler: Get handler responsible for device wiring
- *
- * Find HOTPLUG_HANDLER for @dev that provides [pre|un]plug callbacks for it.
+ * qdev_get_hotplug_handler() - Get handler responsible for device wiring
+ * @dev: the device we want the HOTPLUG_HANDLER for.
  *
  * Note: in case @dev has a parent bus, it will be returned as handler unless
  * machine handler overrides it.
  *
- * Returns: pointer to object that implements TYPE_HOTPLUG_HANDLER interface
- *          or NULL if there aren't any.
+ * Return: pointer to object that implements TYPE_HOTPLUG_HANDLER interface
+ * or NULL if there aren't any.
  */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
@@ -459,15 +573,15 @@ void qdev_del_unplug_blocker(DeviceState *dev, Error *reason);
  * qdev_unplug_blocked: Confirm if a device is blocked from unplug
  *
  * @dev: Device to be tested
- * @reason: Returns one of the reasons why the device is blocked,
- *          if any
+ * @errp: The reasons why the device is blocked, if any
  *
- * Returns: true if device is blocked from unplug, false otherwise
+ * Returns: true (also setting @errp) if device is blocked from unplug,
+ * false otherwise
  */
 bool qdev_unplug_blocked(DeviceState *dev, Error **errp);
 
 /**
- * GpioPolarity: Polarity of a GPIO line
+ * typedef GpioPolarity - Polarity of a GPIO line
  *
  * GPIO lines use either positive (active-high) logic,
  * or negative (active-low) logic.
@@ -499,6 +613,8 @@ typedef enum {
  * connect another device's output GPIO line to this input.
  *
  * For named input GPIO lines, use qdev_get_gpio_in_named().
+ *
+ * Return: qemu_irq corresponding to anonymous input GPIO line
  */
 qemu_irq qdev_get_gpio_in(DeviceState *dev, int n);
 
@@ -516,6 +632,8 @@ qemu_irq qdev_get_gpio_in(DeviceState *dev, int n);
  * array); this function will assert() if passed an invalid name or index.
  *
  * For anonymous input GPIO lines, use qdev_get_gpio_in().
+ *
+ * Return: qemu_irq corresponding to named input GPIO line
  */
 qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n);
 
@@ -523,7 +641,7 @@ qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n);
  * qdev_connect_gpio_out: Connect one of a device's anonymous output GPIO lines
  * @dev: Device whose GPIO to connect
  * @n: Number of the anonymous output GPIO line (which must be in range)
- * @input_pin: qemu_irq to connect the output line to
+ * @pin: qemu_irq to connect the output line to
  *
  * This function connects an anonymous output GPIO line on a device
  * up to an arbitrary qemu_irq, so that when the device asserts that
@@ -594,6 +712,8 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
  *
  * You probably don't need to use this function -- it is used only
  * by the platform-bus subsystem.
+ *
+ * Return: qemu_irq associated with GPIO or NULL if un-wired.
  */
 qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
 
@@ -604,14 +724,17 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
  * @name: Name of the output GPIO array
  * @n: Number of the GPIO line in the array
  *
- * This function is provided only for use by the qtest testing framework
- * and is not suitable for use in non-testing parts of QEMU.
+ * .. note::
+ *   This function is provided only for use by the qtest testing framework
+ *   and is not suitable for use in non-testing parts of QEMU.
  *
  * This function breaks an existing connection of an outbound GPIO
  * line from @dev, and replaces it with the new qemu_irq @icpt, as if
  * ``qdev_connect_gpio_out_named(dev, icpt, name, n)`` had been called.
  * The previously connected qemu_irq is returned, so it can be restored
  * by a second call to qdev_intercept_gpio_out() if desired.
+ *
+ * Return: old disconnected qemu_irq if one existed
  */
 qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
                                  const char *name, int n);
@@ -683,9 +806,7 @@ void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
                               const char *name, int n);
 
 /**
- * qdev_init_gpio_in_named_with_opaque: create an array of input GPIO lines
- *   for the specified device
- *
+ * qdev_init_gpio_in_named_with_opaque() - create an array of input GPIO lines
  * @dev: Device to create input GPIOs for
  * @handler: Function to call when GPIO line value is set
  * @opaque: Opaque data pointer to pass to @handler
@@ -698,8 +819,11 @@ void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
                                          const char *name, int n);
 
 /**
- * qdev_init_gpio_in_named: create an array of input GPIO lines
- *   for the specified device
+ * qdev_init_gpio_in_named() - create an array of input GPIO lines
+ * @dev: device to add array to
+ * @handler: a &typedef qemu_irq_handler function to call when GPIO is set
+ * @name: Name of the GPIO input (must be unique for this device)
+ * @n: Number of GPIO lines in this input set
  *
  * Like qdev_init_gpio_in_named_with_opaque(), but the opaque pointer
  * passed to the handler is @dev (which is the most commonly desired behaviour).
@@ -762,14 +886,17 @@ int qdev_walk_children(DeviceState *dev,
                        void *opaque);
 
 /**
- * device_cold_reset:
+ * device_cold_reset() - perform a recursive cold reset on a device
+ * @dev: device to reset.
+ *
  * Reset device @dev and perform a recursive processing using the resettable
  * interface. It triggers a RESET_TYPE_COLD.
  */
 void device_cold_reset(DeviceState *dev);
 
 /**
- * bus_cold_reset:
+ * bus_cold_reset() - perform a recursive cold reset on a bus
+ * @bus: bus to reset
  *
  * Reset bus @bus and perform a recursive processing using the resettable
  * interface. It triggers a RESET_TYPE_COLD.
@@ -777,14 +904,18 @@ void device_cold_reset(DeviceState *dev);
 void bus_cold_reset(BusState *bus);
 
 /**
- * device_is_in_reset:
- * Return true if the device @dev is currently being reset.
+ * device_is_in_reset() - check device reset state
+ * @dev: device to check
+ *
+ * Return: true if the device @dev is currently being reset.
  */
 bool device_is_in_reset(DeviceState *dev);
 
 /**
- * bus_is_in_reset:
- * Return true if the bus @bus is currently being reset.
+ * bus_is_in_reset() - check bus reset state
+ * @bus: bus to check
+ *
+ * Return: true if the bus @bus is currently being reset.
  */
 bool bus_is_in_reset(BusState *bus);
 
@@ -797,7 +928,14 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 void device_class_set_props(DeviceClass *dc, Property *props);
 
 /**
- * device_class_set_parent_reset:
+ * device_class_set_parent_reset() - legacy set device reset handlers
+ * @dc: device class
+ * @dev_reset: function pointer to reset handler
+ * @parent_reset: function pointer to parents reset handler
+ *
+ * Modern code should use the ResettableClass interface to
+ * implement a multi-phase reset instead.
+ *
  * TODO: remove the function when DeviceClass's reset method
  * is not used anymore.
  */
@@ -871,14 +1009,15 @@ void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
 /**
- * @qdev_should_hide_device:
+ * qdev_should_hide_device() - check if device should be hidden
+ *
  * @opts: options QDict
  * @from_json: true if @opts entries are typed, false for all strings
  * @errp: pointer to error object
  *
- * Check if a device should be added.
- * When a device is added via qdev_device_add() this will be called,
- * and return if the device should be added now or not.
+ * When a device is added via qdev_device_add() this will be called.
+ *
+ * Return: if the device should be added now or not.
  */
 bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp);
 
-- 
2.39.2


