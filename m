Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEA73EE74
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:10:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuMT-0004UC-U5; Mon, 26 Jun 2023 18:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLO-0003BT-R0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLJ-00071p-Dm
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so17176685e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817151; x=1690409151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iMtZ+QxrIdtSm3RSwhWDx4L6tPX96mwOLg/Wme4Yys=;
 b=mXj/AcoO36v9I9gg+XNKQD4oEPUngzrjeVqDU5I8lUH7IscD3QB95PwW/GnCzoumI+
 rAEKJwLpLs65OJZp0zmBkSl2dQ99E0XItDOxJpmx+Y03sopi5NVBE7wWpp80RT6vtpB2
 Fk5jlIpcFYxai42CVaorjK0hIPgutMaEV++jynyS3121fVlS5R8rUI5dmNfQLVrMyCUJ
 OIZ5M3iygOAUGniqoH65oMwUedcdjkZWQizP/6DmmF+psqOFgTSyYCuYyQG2ljz6jIYe
 AxsbyarBMB16MPyjIGmQZjhpLqZpVPN9gTiy48HQBwq3rLu6RX1OwngpybaXzOV8dY+g
 P6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817151; x=1690409151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iMtZ+QxrIdtSm3RSwhWDx4L6tPX96mwOLg/Wme4Yys=;
 b=YsTpRUmbdu9BSF/Wvp7Fen9JICYZQOSonZDm9bMh4DVvxHLZxXYk4dVpQ+8Qp/WFsE
 ELZ5JH6hURlb50v2LiGmrr9Z74pxloUrFc0DTzOLfg7vYfiNX/HcyxYzagwCqiNsIjWa
 3Jn222RwbJTfLxQQ37wuWZtuy/iR2pRnIbgG32nEa+JbyVhpMtu2VWnw9kfgnxwGPIDQ
 sUyzzpTkp7EOV8vy6tfaenRQfPrUnIBroTdH/q57TRUkxpfcsal1wTM87iRmSEOETAOo
 IV+aMNCBXxV0/XckdtoKo7M0pbK5ntX1psRgDbv+JFah3CxxTcWCq85pdGosOImsu4u9
 Ki8w==
X-Gm-Message-State: AC+VfDyAYGR6IY+jTQ3uiS+cWW01eNh+Dii7Yzk1lBTz1lTB7oa2m6aP
 YXqRbeGnoDIyEU6tXxm2JNpGYKqQNcf7v8LcNvE=
X-Google-Smtp-Source: ACHHUZ6r0dyGM79hvmoaKBTrtpN+AQtFmmZuuUc80cU8oNE5+mcCswo7y09+4L0GxwIN9vuRNLx1mw==
X-Received: by 2002:a05:600c:230b:b0:3fa:8874:fe69 with SMTP id
 11-20020a05600c230b00b003fa8874fe69mr4027230wmo.29.1687817151393; 
 Mon, 26 Jun 2023 15:05:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z24-20020a05600c221800b003fa96fe2bd9sm3901038wml.22.2023.06.26.15.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E54811FFCF;
 Mon, 26 Jun 2023 22:59:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 25/26] docs/devel: introduce some key concepts for QOM
 development
Date: Mon, 26 Jun 2023 22:59:25 +0100
Message-Id: <20230626215926.2522656-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-6-alex.bennee@linaro.org>

---
v3
  - moved around as per Paolo's review
---
 docs/devel/qom.rst | 58 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

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


