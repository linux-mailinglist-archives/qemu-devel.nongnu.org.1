Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CE85C0C0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 17:08:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdg-00028S-71; Tue, 20 Feb 2024 11:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdb-00026W-QT
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdY-0005F0-J8
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4126f48411dso4930975e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445187; x=1709049987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HnwHWnmE66bJ5KZzVID8fJ3qSazlGzlBgZNC57rU+s=;
 b=ACo7/si7HBiM8/Z93QSdbXr4HZD0caSv3Kbp6ryPVeUf7rbSr9OifnR+SCoV8GqYEg
 gEeUtEua84mNz9fQkaSwa6i65F5N1/s6o9ViOWZb4aGFvB0bLhdk2JyHqWhwaKPOi5SN
 huZAvyGA9tOm/YPxClqZpsoZZyXPuu126bkTuAm6MGqzDGWktxjMjJnRdpd66TnYITM2
 sQ9fgu5JrsBD186rS8Ca+8ugT1rrr5ViQMD5eGfdcnNNxBnVwtviID/Hvba84JLF/OBD
 n+Iw34pgPU1NUhFypy8LSAu7XMDuUVaOLzGtl2yAvKL2oIvkG1KbYxf5Hj2Te3Pz8xjj
 KJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445187; x=1709049987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HnwHWnmE66bJ5KZzVID8fJ3qSazlGzlBgZNC57rU+s=;
 b=Rnn2G9KXoCKRdS2i6t5MAcQ7B3Uh3Ayg2pfpaOFLo4jDEZ3nBiuqCQTR0u8BdvtnK8
 mh5l+s4FbKN0I6xxjqrdoUL/Vn1xsbEPH48Ak3HYA0eqZZJmRvNtOJ+jYf5bWkn3JWXI
 9AIiLkdyeV3BctjO004TkvJv5koSC6muzOX5mBdEAgb8HlpsIK6pQ4M+jD4GTvyBneit
 vlCmSQFVKwWAntoYELSJIkh6Pdi/01+RLM3r9LDs4QBATklop3qiP896nmmXa1s0oOpp
 Z5oEJRa46gQjQARVBe3TtMMh9+H09XSHtA6ZosCjYmXKbFpzYcLzDEpIrW7dfUsC5lwW
 cNmg==
X-Gm-Message-State: AOJu0YxJk+z1kJcNaZ4f/iNl9kb3knYQ1szMOsqKtgNzitpbsu/OPwIi
 6K5K40vBlsW3WlipoOoWKVztbbSJfogtivtGrzsZaCaikq2tZTelvGlXP+S2XqAqmwcKvWCv8C/
 g
X-Google-Smtp-Source: AGHT+IHWwpEYkU3V3rbr6dCWboC6iHviqdeymbJ31jTDGnEHxvy1lDWm4eqU/SefGIZ7VxM3rq8z6w==
X-Received: by 2002:a05:600c:358b:b0:412:6e83:b89d with SMTP id
 p11-20020a05600c358b00b004126e83b89dmr2125103wmq.8.1708445187036; 
 Tue, 20 Feb 2024 08:06:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 04/10] include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{,
 _WITH_INTERFACES} macros
Date: Tue, 20 Feb 2024 16:06:16 +0000
Message-Id: <20240220160622.114437-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

We have an OBJECT_DEFINE_TYPE_EXTENDED macro, plus several variations
on it, which emits the boilerplate for the TypeInfo and ensures it is
registered with the type system.  However, all the existing macros
insist that the type being defined has its own FooClass struct, so
they aren't useful for the common case of a simple leaf class which
doesn't have any new methods or any other need for its own class
struct (that is, for the kind of type that OBJECT_DECLARE_SIMPLE_TYPE
declares).

Pull the actual implementation of OBJECT_DEFINE_TYPE_EXTENDED out
into a new DO_OBJECT_DEFINE_TYPE_EXTENDED which parameterizes the
value we use for the class_size field.  This lets us add a new
OBJECT_DEFINE_SIMPLE_TYPE which does the same job as the various
existing OBJECT_DEFINE_*_TYPE_* family macros for this kind of simple
type, and the variant OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES for
when the type will implement some interfaces.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/qom.rst   |  34 +++++++++++--
 include/qom/object.h | 114 +++++++++++++++++++++++++++++++++----------
 2 files changed, 117 insertions(+), 31 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 9918fac7f21..0889ca949c1 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -348,12 +348,14 @@ used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
 the 'struct MyDeviceClass' definition.
 
 To implement the type, the OBJECT_DEFINE macro family is available.
-In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
+For the simplest case of a leaf class which doesn't need any of its
+own virtual functions (i.e. which was declared with OBJECT_DECLARE_SIMPLE_TYPE)
+the OBJECT_DEFINE_SIMPLE_TYPE macro is suitable:
 
 .. code-block:: c
    :caption: Defining a simple type
 
-   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DEFINE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
 
 This is equivalent to the following:
 
@@ -370,7 +372,6 @@ This is equivalent to the following:
        .instance_size = sizeof(MyDevice),
        .instance_init = my_device_init,
        .instance_finalize = my_device_finalize,
-       .class_size = sizeof(MyDeviceClass),
        .class_init = my_device_class_init,
    };
 
@@ -385,13 +386,36 @@ This is sufficient to get the type registered with the type
 system, and the three standard methods now need to be implemented
 along with any other logic required for the type.
 
+If the class needs its own virtual methods, or has some other
+per-class state it needs to store in its own class struct,
+then you can use the OBJECT_DEFINE_TYPE macro. This does the
+same thing as OBJECT_DEFINE_SIMPLE_TYPE, but it also sets the
+class_size of the type to the size of the class struct.
+
+.. code-block:: c
+   :caption: Defining a type which needs a class struct
+
+   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+
 If the type needs to implement one or more interfaces, then the
-OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
-This accepts an array of interface type names.
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES() and
+OBJECT_DEFINE_TYPE_WITH_INTERFACES() macros can be used instead.
+These accept an array of interface type names. The difference between
+them is that the former is for simple leaf classes that don't need
+a class struct, and the latter is for when you will be defining
+a class struct.
 
 .. code-block:: c
    :caption: Defining a simple type implementing interfaces
 
+   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(MyDevice, my_device,
+                                             MY_DEVICE, DEVICE,
+                                             { TYPE_USER_CREATABLE },
+                                             { NULL })
+
+.. code-block:: c
+   :caption: Defining a type implementing interfaces
+
    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
                                       MY_DEVICE, DEVICE,
                                       { TYPE_USER_CREATABLE },
diff --git a/include/qom/object.h b/include/qom/object.h
index afccd24ca7a..f52ab216cdd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -258,6 +258,51 @@ struct Object
     DECLARE_INSTANCE_CHECKER(InstanceType, MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)
 
 
+/**
+ * DO_OBJECT_DEFINE_TYPE_EXTENDED:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ * @ABSTRACT: boolean flag to indicate whether the object can be instantiated
+ * @CLASS_SIZE: size of the type's class
+ * @...: list of initializers for "InterfaceInfo" to declare implemented interfaces
+ *
+ * This is the base macro used to implement all the OBJECT_DEFINE_*
+ * macros. It should never be used directly in a source file.
+ */
+#define DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                       MODULE_OBJ_NAME, \
+                                       PARENT_MODULE_OBJ_NAME, \
+                                       ABSTRACT, CLASS_SIZE, ...) \
+    static void \
+    module_obj_name##_finalize(Object *obj); \
+    static void \
+    module_obj_name##_class_init(ObjectClass *oc, void *data); \
+    static void \
+    module_obj_name##_init(Object *obj); \
+    \
+    static const TypeInfo module_obj_name##_info = { \
+        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
+        .name = TYPE_##MODULE_OBJ_NAME, \
+        .instance_size = sizeof(ModuleObjName), \
+        .instance_align = __alignof__(ModuleObjName), \
+        .instance_init = module_obj_name##_init, \
+        .instance_finalize = module_obj_name##_finalize, \
+        .class_size = CLASS_SIZE, \
+        .class_init = module_obj_name##_class_init, \
+        .abstract = ABSTRACT, \
+        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
+    }; \
+    \
+    static void \
+    module_obj_name##_register_types(void) \
+    { \
+        type_register_static(&module_obj_name##_info); \
+    } \
+    type_init(module_obj_name##_register_types);
+
 /**
  * OBJECT_DEFINE_TYPE_EXTENDED:
  * @ModuleObjName: the object name with initial caps
@@ -284,32 +329,10 @@ struct Object
 #define OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
                                     MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
                                     ABSTRACT, ...) \
-    static void \
-    module_obj_name##_finalize(Object *obj); \
-    static void \
-    module_obj_name##_class_init(ObjectClass *oc, void *data); \
-    static void \
-    module_obj_name##_init(Object *obj); \
-    \
-    static const TypeInfo module_obj_name##_info = { \
-        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
-        .name = TYPE_##MODULE_OBJ_NAME, \
-        .instance_size = sizeof(ModuleObjName), \
-        .instance_align = __alignof__(ModuleObjName), \
-        .instance_init = module_obj_name##_init, \
-        .instance_finalize = module_obj_name##_finalize, \
-        .class_size = sizeof(ModuleObjName##Class), \
-        .class_init = module_obj_name##_class_init, \
-        .abstract = ABSTRACT, \
-        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
-    }; \
-    \
-    static void \
-    module_obj_name##_register_types(void) \
-    { \
-        type_register_static(&module_obj_name##_info); \
-    } \
-    type_init(module_obj_name##_register_types);
+    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
+                                   ABSTRACT, sizeof(ModuleObjName##Class), \
+                                   __VA_ARGS__)
 
 /**
  * OBJECT_DEFINE_TYPE:
@@ -368,6 +391,45 @@ struct Object
                                 MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
                                 true, { NULL })
 
+/**
+ * OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ *
+ * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
+ * the case of a non-abstract type, with interfaces, and with no requirement
+ * for a class struct.
+ */
+#define OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, \
+                                                  module_obj_name, \
+                                                  MODULE_OBJ_NAME, \
+                                                  PARENT_MODULE_OBJ_NAME, ...) \
+    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
+                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
+                                   false, 0, __VA_ARGS__)
+
+/**
+ * OBJECT_DEFINE_SIMPLE_TYPE:
+ * @ModuleObjName: the object name with initial caps
+ * @module_obj_name: the object name in lowercase with underscore separators
+ * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
+ * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
+ *                          separators
+ *
+ * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
+ * the common case of a non-abstract type, without any interfaces, and with
+ * no requirement for a class struct. If you declared your type with
+ * OBJECT_DECLARE_SIMPLE_TYPE then this is probably the right choice for
+ * defining it.
+ */
+#define OBJECT_DEFINE_SIMPLE_TYPE(ModuleObjName, module_obj_name, \
+                                  MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME) \
+    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, module_obj_name, \
+        MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, { NULL })
+
 /**
  * struct TypeInfo:
  * @name: The name of the type.
-- 
2.34.1


