Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7E0745DF0
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzj-0000WP-4b; Mon, 03 Jul 2023 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzg-0000Tm-Rb
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJze-00081o-EJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so40370165e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A17Yk078G+WbyuMB1//no9fohhpFQD0Go8gJ1S9AAiU=;
 b=eZ5PsvLOgBLv4obSKoIdlRCg5HRhIqIe9eX1WpMgTqDeq62la+3crcuEfmXKPfqV/3
 0owkz0G5MeXj60UOqXpQyp+nWSthpmWSiFal/hJ3YhpLpL9w2PTsyXG69Tew1oG5cQuC
 TckuUW1FXspwH2v656whuq9vXNKugscEC4CruzVNGg1wzgo8xa45/b2O/yTJLCrhuqgQ
 Qwi91Syes3zUw8/4KdcWFXpG3nOCMsK23t/ps92gbRc7ThGih8TWWkFd8ZQShASPH7Vo
 4ny9k5fV9h9pk+JnkJEu5XosEgoFS9HxT77zgftBcYpAyEoqiLYmPLas5GHAJ+19yET+
 UU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A17Yk078G+WbyuMB1//no9fohhpFQD0Go8gJ1S9AAiU=;
 b=kweBZXFej/J3vfud4fg1B/syssE2Tu3F+9HAAZJZpPm//cAnlJMMSlA9dlf08RA3U4
 lk0J4PtR3WBMDfPf2DEySlHJCX1jvtmt42QlU627OT93+tKfHqG6N/tF/ilayyljTu+F
 mZQtRLOBLk+x7hIMDAzaE/DTneHaL5kI89AmLKhsn+sJF8C8GhTUvuKyDeSfvpgk9xTf
 HAndN4Wzdf0+46X9HwTDJQM9h2MJ6F+3G0EKFfAqRCOAkgO5Gw+6w+XYrW/gqlnAZUGq
 vsOi1lhgzK2DI1GNmQsX/SpA6+TJu6G0KrD5xHjUCR3yUtXxI0dT/vxtUxahTDGEeT8l
 rTnQ==
X-Gm-Message-State: AC+VfDy/lVeaGyqDDQyKGKA5bKSNTIUR/54Qv3VdfZ06tOY7Pn1nF4Rh
 j4GGM90ZXyfxUkSw7Sf8tPxKHw==
X-Google-Smtp-Source: ACHHUZ68hURcB6WrCJEJwX3Bk1hsRuhO+th/xKOQFGULbNLlIr5auds67n06cHkjOLRmqJlrEAoLxg==
X-Received: by 2002:a1c:7512:0:b0:3f6:58ad:ed85 with SMTP id
 o18-20020a1c7512000000b003f658aded85mr8587791wmc.10.1688392409105; 
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c228400b003fbc216b137sm10762158wmf.3.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02E241FFD1;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 27/38] docs/devel: introduce some key concepts for QOM
 development
Date: Mon,  3 Jul 2023 14:44:16 +0100
Message-Id: <20230703134427.1389440-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Using QOM correctly is increasingly important to maintaining a modern
code base. However the current documentation skips some important
concepts before launching into a simple example. Lets:

  - at least mention properties
  - mention TYPE_OBJECT and TYPE_DEVICE
  - talk about why we have realize/unrealize
  - mention the QOM tree
  - lightly re-arrange the order we mention things

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-28-alex.bennee@linaro.org>

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c342ce18e3..0b506426d7 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -13,6 +13,24 @@ features:
 - System for dynamically registering types
 - Support for single-inheritance of types
 - Multiple inheritance of stateless interfaces
+- Mapping internal members to publicly exposed properties
+
+The root object class is TYPE_OBJECT which provides for the basic
+object methods.
+
+The QOM tree
+============
+
+The QOM tree is a composition tree which represents all of the objects
+that make up a QEMU "machine". You can view this tree by running
+``info qom-tree`` in the :ref:`QEMU monitor`. It will contain both
+objects created by the machine itself as well those created due to
+user configuration.
+
+Creating a QOM class
+====================
+
+A simple minimal device implementation may look something like bellow:
 
 .. code-block:: c
    :caption: Creating a minimal type
@@ -48,6 +66,12 @@ In the above example, we create a simple type that is described by #TypeInfo.
 #TypeInfo describes information about the type including what it inherits
 from, the instance and class size, and constructor/destructor hooks.
 
+The TYPE_DEVICE class is the parent class for all modern devices
+implemented in QEMU and adds some specific methods to handle QEMU
+device model. This includes managing the lifetime of devices from
+creation through to when they become visible to the guest and
+eventually unrealized.
+
 Alternatively several static types could be registered using helper macro
 DEFINE_TYPES()
 
@@ -98,7 +122,7 @@ when the object is needed.
    module_obj(TYPE_MY_DEVICE);
 
 Class Initialization
-====================
+--------------------
 
 Before an object is initialized, the class for the object must be
 initialized.  There is only one class object for all instance objects
@@ -168,7 +192,7 @@ will also have a wrapper function to call it easily:
    }
 
 Interfaces
-==========
+----------
 
 Interfaces allow a limited form of multiple inheritance.  Instances are
 similar to normal types except for the fact that are only defined by
@@ -182,7 +206,7 @@ an argument to a method on its corresponding SomethingIfClass, or to
 dynamically cast it to an object that implements the interface.
 
 Methods
-=======
+-------
 
 A *method* is a function within the namespace scope of
 a class. It usually operates on the object instance by passing it as a
@@ -275,8 +299,8 @@ Alternatively, object_class_by_name() can be used to obtain the class and
 its non-overridden methods for a specific type. This would correspond to
 ``MyClass::method(...)`` in C++.
 
-The first example of such a QOM method was #CPUClass.reset,
-another example is #DeviceClass.realize.
+One example of such methods is ``DeviceClass.reset``. More examples
+can be found at :ref:`device-life-cycle`.
 
 Standard type declaration and definition macros
 ===============================================
@@ -382,10 +406,32 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
    OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device,
                                MY_DEVICE, DEVICE)
 
+.. _device-life-cycle:
+
+Device Life-cycle
+=================
+
+As class initialisation cannot fail devices have an two additional
+methods to handle the creation of dynamic devices. The ``realize``
+function is called with ``Error **`` pointer which should be set if
+the device cannot complete its setup. Otherwise on successful
+completion of the ``realize`` method the device object is added to the
+QOM tree and made visible to the guest.
+
+The reverse function is ``unrealize`` and should be were clean-up
+code lives to tidy up after the system is done with the device.
+
+All devices can be instantiated by C code, however only some can
+created dynamically via the command line or monitor.
 
+Likewise only some can be unplugged after creation and need an
+explicit ``unrealize`` implementation. This is determined by the
+``user_creatable`` variable in the root ``DeviceClass`` structure.
+Devices can only be unplugged if their ``parent_bus`` has a registered
+``HotplugHandler``.
 
 API Reference
--------------
+=============
 
 See the :ref:`QOM API<qom-api>` and :ref:`QDEV API<qdev-api>`
 documents for the complete API description.
-- 
2.39.2


