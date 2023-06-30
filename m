Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D612E744209
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFId6-0005jA-RA; Fri, 30 Jun 2023 14:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIci-0005PW-7J
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIce-0003W8-1G
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-314172bb818so2401013f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148810; x=1690740810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Dv1TJKAgvOjRuScSXc6KvO/+t9ISNh+7I3S8hdzvEw=;
 b=IjRTo8+6BQ3Ebxy1aldztooiW/vlRCsJvKFDdNiAaKHoPuEpkotRC5wX5qwJ1HeUpF
 ke2Ue2eePkapN4YHzuv5Z32e/o/GfH5nWC5DnAeOrap2wuIzaj9UOTrqLoF2UNPYj+YK
 ttw0GRWpY5rWX2I2ZVa7w0A9rnfiNkN5+i4yuhiYvSw8mwxRiZFZOYtVNe9kPImyyEAP
 HN644H6ZoB+YMIZkoEgKH7jkxAnJGZwqQrY2w/kikxEKIRZX+XRDfrJps6D5yUJZIAbK
 2M0xeTK3UiZkxwmw3XtlM8ZUp0p/WqjtcYFpbcJqkBJTgW64q5ItoL3TOceQpOu6hQWL
 6LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148810; x=1690740810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Dv1TJKAgvOjRuScSXc6KvO/+t9ISNh+7I3S8hdzvEw=;
 b=OzlDyF+0UqdTVVC304hUTEqGKgl1bPqAvyCBRxPB2NHhPMXhv6bYWoiAqB3OvESwNy
 iB04YVdZYQPc6aIpoKiOCzSz51yGfIe+uCbN6Vvc5qyOLC1jumpUMQhLITkkifDQ63rh
 L3SffRT9lBht2y0boECRfj0jxFF2xQWEWIosKcB3i/r9p1cNo5/Hr6TvlgIjFCVlXQoV
 /EBPelWVkbTd4lrdmlS/Ysz1x2eQeYv1kUZ9fitKHscTP04RdCW0bXppIwiusivmrDaX
 IOSzbbu6FSwDVcaZDoKfTscsj6adMvSsfbqzKHeQCp1aE3y1i2rCuerA+29TN50mPxNb
 pAGA==
X-Gm-Message-State: ABy/qLarR5zY884KZt2I09+lNNZt/Pf5IV2aMnXC/ENHYxks2Z41H6wU
 yf2hieUcE646bYdtLYoNn2BjJQ==
X-Google-Smtp-Source: APBJJlFTZarqSLdYAFR6DDYagiWWTMhfP4ckXwbCbj7qA5b3MCVOzlaiGaY0xT96uc862oYURJBY4A==
X-Received: by 2002:adf:ea87:0:b0:311:1f3e:e79 with SMTP id
 s7-20020adfea87000000b003111f3e0e79mr3260550wrm.13.1688148810551; 
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v1-20020adfe281000000b00311299df211sm18857193wri.77.2023.06.30.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D09D1FFC0;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 27/38] docs/devel: introduce some key concepts for QOM
 development
Date: Fri, 30 Jun 2023 19:04:12 +0100
Message-Id: <20230630180423.558337-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Using QOM correctly is increasingly important to maintaining a modern
code base. However the current documentation skips some important
concepts before launching into a simple example. Lets:

  - at least mention properties
  - mention TYPE_OBJECT and TYPE_DEVICE
  - talk about why we have realize/unrealize
  - mention the QOM tree
  - lightly re-arrange the order we mention things

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


