Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5EB48A92
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 12:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZT3-0006lP-5C; Mon, 08 Sep 2025 06:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT1-0006bT-W9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSl-00067M-Ac
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8ZhvQgGFLTnbV+zoXQPLXJ6IavGqqQ034UUBrxG/XM=;
 b=Gl/YhWi80BlETB4TYjdMJLwrbbXvd4G/m2ExlaYFlVruiTpP5rgKBy5vvYiL8nFoVnMHFG
 vrv7Wrgz0GrI0T3rnjMgL44QtVx27A2HLS0Uipf280fIFXYGZMhLi2Md0v/1hH/MHPm2Ei
 j26XFADx8+DEWqo3QVKMmNFPudCtXmg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-vZ2TxKjpPdi0moKn8j_Jsw-1; Mon, 08 Sep 2025 06:51:00 -0400
X-MC-Unique: vZ2TxKjpPdi0moKn8j_Jsw-1
X-Mimecast-MFC-AGG-ID: vZ2TxKjpPdi0moKn8j_Jsw_1757328659
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e2055ce94bso2516001f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328658; x=1757933458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8ZhvQgGFLTnbV+zoXQPLXJ6IavGqqQ034UUBrxG/XM=;
 b=H2bODQEHa5XsIOFvywA1s+ZpmVb/3WzYtIsvd0dIgt+qOiV5Ebhydu67T3x98Y22l+
 bJBUTvvPf5nkx3XUQmdU2T/t4j16m1FQ34Q9encCxUaKwgnO1KVrBsFhH04MmyhxhoJS
 F7vX4Dk/EHrCoWkDn8bLrsxkE6uvMrwJxhpWjZDs6ecH9RPvKz2+MouVZ+8lnDa1AwtB
 gSzfhRn0YHaA89Rlj09gJPELb0XRet8juZmZOwL5dxvcf5f88vSYVORBy0/pnLImlOaB
 hoBgqRQB8+M8/1+lTJj/DXeSFD+mXD0VwIheAJKYBGx7ujqX0PyG+WFueUCZWZ8Kkkoj
 Ntrg==
X-Gm-Message-State: AOJu0YxewefLvA35RGp1uKJn2LfooFMsUp08inhd/Y6moG23C0UqLlin
 HmdHO0UobUtJUF4nX8XMmQerdbxs7bDBzqXz19pYpV/pnen+drKgapXxaNxlUlowZNVJBA7wcQ5
 /xH++j7Bj/RcWEY6FHeNUUm/sgDzD9zZ9+e4Emaegs8/a5bT3x7F2/yvyQR3JAtYKCvjzhg5ig0
 NC1HgSYpreHxK8nTpJFas43y6IzJk8EMl1d+cYF68B
X-Gm-Gg: ASbGncs3z2PZqQKwy7Y/tobh45Sw4vfxU1jfckwhRMYtgAFJ5gn6YnF1gHLeZp8UBib
 viVsHmR4OnQccQTn9KgYNRJpYTYLpkraoqnbKqeOYSndaXChNxY29fU9LgSYyEBCnYXJBHj+d6Z
 nK9nvJ0QXAHsjpTOSDJx16vMa0CHfeb+IK1S+Zxlwz7g0mzIXj5Ey08pMY2kZQAVbG1GtXrRaFJ
 iLAtodDkbILXwaQCsVu9wfyd7UePyTyDLN2DMaZx7RoIquhDcQGpGcuJU0i3xkyblxdYY1enw1n
 L5adxey6OmJ+XSLwPHwYaqiM543qBQQiHs2LGr0/7EhkeYtD+aAptN2s2fSzhOP4m9jhIH5uCJv
 HnFyqN/xtFtuxZcrH5JRioE6lbF1N1VrLyCwui1GQ9k8=
X-Received: by 2002:a05:6000:40c8:b0:3d7:d444:da19 with SMTP id
 ffacd0b85a97d-3e643b18bf1mr6533022f8f.55.1757328658066; 
 Mon, 08 Sep 2025 03:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeP7In2c19yo0fIT7pqgEcif8tYdiiHUDsqmFKRnzcmXjImr1XqQMVy5RTmpKAxJiZ0zqu7w==
X-Received: by 2002:a05:6000:40c8:b0:3d7:d444:da19 with SMTP id
 ffacd0b85a97d-3e643b18bf1mr6532972f8f.55.1757328657354; 
 Mon, 08 Sep 2025 03:50:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de18f4824sm82761445e9.10.2025.09.08.03.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 21/33] rust: split "qom" crate
Date: Mon,  8 Sep 2025 12:49:53 +0200
Message-ID: <20250908105005.2119297-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250827104147.717203-13-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                       |  1 +
 rust/qom/wrapper.h                | 27 +++++++++++++++++++
 rust/Cargo.lock                   | 14 ++++++++++
 rust/Cargo.toml                   |  1 +
 rust/hw/char/pl011/Cargo.toml     |  1 +
 rust/hw/char/pl011/meson.build    |  1 +
 rust/hw/char/pl011/src/device.rs  |  2 +-
 rust/hw/timer/hpet/Cargo.toml     |  1 +
 rust/hw/timer/hpet/meson.build    |  1 +
 rust/hw/timer/hpet/src/device.rs  |  3 +--
 rust/meson.build                  |  1 +
 rust/migration/src/vmstate.rs     |  2 +-
 rust/qemu-api-macros/src/lib.rs   |  4 +--
 rust/qemu-api-macros/src/tests.rs |  4 +--
 rust/qemu-api/Cargo.toml          |  1 +
 rust/qemu-api/meson.build         | 15 +++++++----
 rust/qemu-api/src/bindings.rs     |  1 +
 rust/qemu-api/src/chardev.rs      |  3 ++-
 rust/qemu-api/src/irq.rs          | 10 +++----
 rust/qemu-api/src/lib.rs          |  1 -
 rust/qemu-api/src/memory.rs       |  7 +++--
 rust/qemu-api/src/prelude.rs      | 11 --------
 rust/qemu-api/src/qdev.rs         |  5 ++--
 rust/qemu-api/src/sysbus.rs       |  4 +--
 rust/qemu-api/tests/tests.rs      |  3 +--
 rust/qom/Cargo.toml               | 23 +++++++++++++++++
 rust/qom/build.rs                 |  1 +
 rust/qom/meson.build              | 43 +++++++++++++++++++++++++++++++
 rust/qom/src/bindings.rs          | 25 ++++++++++++++++++
 rust/qom/src/lib.rs               | 11 ++++++++
 rust/qom/src/prelude.rs           | 12 +++++++++
 rust/{qemu-api => qom}/src/qom.rs |  4 +--
 32 files changed, 199 insertions(+), 44 deletions(-)
 create mode 100644 rust/qom/wrapper.h
 create mode 100644 rust/qom/Cargo.toml
 create mode 120000 rust/qom/build.rs
 create mode 100644 rust/qom/meson.build
 create mode 100644 rust/qom/src/bindings.rs
 create mode 100644 rust/qom/src/lib.rs
 create mode 100644 rust/qom/src/prelude.rs
 rename rust/{qemu-api => qom}/src/qom.rs (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e87f18e2bf..70840abddc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3518,6 +3518,7 @@ F: rust/common/
 F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
+F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
diff --git a/rust/qom/wrapper.h b/rust/qom/wrapper.h
new file mode 100644
index 00000000000..3b71bcd3f5b
--- /dev/null
+++ b/rust/qom/wrapper.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
+#include "qemu/osdep.h"
+
+#include "qom/object.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 73ca9582a56..442eadf08fa 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -82,6 +82,7 @@ dependencies = [
  "migration",
  "qemu_api",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -121,6 +122,7 @@ dependencies = [
  "migration",
  "qemu_api",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -164,6 +166,7 @@ dependencies = [
  "common",
  "migration",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -176,6 +179,17 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "qom"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "common",
+ "migration",
+ "qemu_api_macros",
+ "util",
+]
+
 [[package]]
 name = "quote"
 version = "1.0.36"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 8be90da8ff7..0516c16591c 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,7 @@ members = [
     "migration",
     "qemu-api-macros",
     "qemu-api",
+    "qom",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 1a1d4ba7152..da89f78727f 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -20,6 +20,7 @@ common = { path = "../../../common" }
 util = { path = "../../../util" }
 bql = { path = "../../../bql" }
 migration = { path = "../../../migration" }
+qom = { path = "../../../qom" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 8561c4c14ae..af9393c9da9 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -13,6 +13,7 @@ _libpl011_rs = static_library(
     migration_rs,
     bql_rs,
     qemu_api_macros,
+    qom_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 00ae4328250..63651b9dcdf 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -16,9 +16,9 @@
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, Owned, ParentField, ParentInit},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
 };
+use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 9fcec38bfa6..19456ec72b5 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -15,6 +15,7 @@ common = { path = "../../../common" }
 util = { path = "../../../util" }
 migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
+qom = { path = "../../../qom" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 43a62db0d01..50ccdee4a93 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -10,6 +10,7 @@ _libhpet_rs = static_library(
     migration_rs,
     bql_rs,
     qemu_api_macros,
+    qom_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 9658e071c26..404569aa2de 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -27,10 +27,9 @@
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
-    qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
 };
+use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
diff --git a/rust/meson.build b/rust/meson.build
index 2ba1ea2280d..043603d4169 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -28,6 +28,7 @@ subdir('bits')
 subdir('util')
 subdir('migration')
 subdir('bql')
+subdir('qom')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index d714aacb7e3..c05c4a1fd66 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -137,7 +137,7 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 ///
 /// [`BqlCell`]: ../../bql/cell/struct.BqlCell.html
 /// [`BqlRefCell`]: ../../bql/cell/struct.BqlRefCell.html
-/// [`Owned`]: ../../qemu_api/qom/struct.Owned.html
+/// [`Owned`]: ../../qom/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 67650a9a269..e643e57ebdf 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -98,11 +98,11 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
 
     Ok(quote! {
         ::common::assert_field_type!(#name, #parent,
-            ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
+            ::qom::ParentField<<#name as ::qom::ObjectImpl>::ParentType>);
 
         ::util::module_init! {
             MODULE_INIT_QOM => unsafe {
-                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
+                ::qom::type_register_static(&<#name as ::qom::ObjectImpl>::TYPE_INFO);
             }
         }
     })
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 8e71ac6e677..76e6c57479e 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -168,11 +168,11 @@ struct Foo {
             ::common::assert_field_type!(
                 Foo,
                 _unused,
-                ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
+                ::qom::ParentField<<Foo as ::qom::ObjectImpl>::ParentType>
             );
             ::util::module_init! {
                 MODULE_INIT_QOM => unsafe {
-                    ::qemu_api::bindings::type_register_static(&<Foo as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
+                    ::qom::type_register_static(&<Foo as ::qom::ObjectImpl>::TYPE_INFO);
                 }
             }
         }
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 6e9427f80c8..9d11becb284 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -18,6 +18,7 @@ common = { path = "../common" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
+qom = { path = "../qom" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 
 [lints]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a47ee6c1a3d..11e43bb6468 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -22,9 +22,15 @@ foreach enum : c_bitfields
   _qemu_api_bindgen_args += ['--bitfield-enum', enum]
 endforeach
 
-_qemu_api_bindgen_args += ['--blocklist-type', 'VMStateDescription']
+blocked_type = [
+  'ObjectClass',
+  'VMStateDescription',
+  'Error',
+]
+foreach type: blocked_type
+  _qemu_api_bindgen_args += ['--blocklist-type', type]
+endforeach
 
-_qemu_api_bindgen_args += ['--blocklist-type', 'Error']
 # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
 #
 # Rust bindings generation with `bindgen` might fail in some cases where the
@@ -52,7 +58,6 @@ _qemu_api_rs = static_library(
       'src/memory.rs',
       'src/prelude.rs',
       'src/qdev.rs',
-      'src/qom.rs',
       'src/sysbus.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
@@ -61,7 +66,7 @@ _qemu_api_rs = static_library(
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
   dependencies: [anyhow_rs, bql_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
-                 util_rs, qom, hwcore, chardev],
+                 qom_rs, util_rs, hwcore, chardev],
 )
 
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
@@ -74,7 +79,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qemu_api_rs]),
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qemu_api_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index ce00a6e0e4c..525f136ae2b 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -22,6 +22,7 @@
 
 use common::Zeroable;
 use migration::bindings::VMStateDescription;
+use qom::bindings::ObjectClass;
 use util::bindings::Error;
 
 #[cfg(MESON)]
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 2ec90cc0b2e..072d806e4a3 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -20,8 +20,9 @@
 
 use bql::{BqlRefCell, BqlRefMut};
 use common::{callbacks::FnCall, errno, Opaque};
+use qom::prelude::*;
 
-use crate::{bindings, prelude::*};
+use crate::bindings;
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 3063fbe97aa..fead2bbe8e0 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -12,12 +12,9 @@
 
 use bql::BqlCell;
 use common::Opaque;
+use qom::{prelude::*, ObjectClass};
 
-use crate::{
-    bindings::{self, qemu_set_irq},
-    prelude::*,
-    qom::ObjectClass,
-};
+use crate::bindings::{self, qemu_set_irq};
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
@@ -36,7 +33,7 @@
 ///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
-/// a function such as [`SysBusDeviceMethods::init_irq`], and
+/// a function such as [`crate::sysbus::SysBusDeviceMethods::init_irq`], and
 /// initially leaves the pointer to a NULL value, representing an unconnected
 /// interrupt. To connect it, whoever creates the device fills the pointer with
 /// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
@@ -114,4 +111,5 @@ unsafe impl ObjectType for IRQState {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_IRQ) };
 }
+
 qom_isa!(IRQState: Object);
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 6cd9e5b9905..0541050e667 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -17,7 +17,6 @@
 pub mod irq;
 pub mod memory;
 pub mod qdev;
-pub mod qom;
 pub mod sysbus;
 
 // Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index f790cb5fd2d..ecbbd9b6046 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -11,11 +11,9 @@
 
 pub use bindings::{hwaddr, MemTxAttrs};
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
+use qom::prelude::*;
 
-use crate::{
-    bindings::{self, device_endian, memory_region_init_io},
-    prelude::*,
-};
+use crate::bindings::{self, device_endian, memory_region_init_io};
 
 pub struct MemoryRegionOps<T>(
     bindings::MemoryRegionOps,
@@ -186,6 +184,7 @@ unsafe impl ObjectType for MemoryRegion {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
 }
+
 qom_isa!(MemoryRegion: Object);
 
 /// A special `MemTxAttrs` constant, used to indicate that no memory
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 9da7313016d..9e9d1c82474 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -6,15 +6,4 @@
 
 pub use crate::qdev::DeviceMethods;
 
-pub use crate::qom::InterfaceType;
-pub use crate::qom::IsA;
-pub use crate::qom::Object;
-pub use crate::qom::ObjectCast;
-pub use crate::qom::ObjectClassMethods;
-pub use crate::qom::ObjectDeref;
-pub use crate::qom::ObjectMethods;
-pub use crate::qom::ObjectType;
-
-pub use crate::qom_isa;
-
 pub use crate::sysbus::SysBusDeviceMethods;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 74a82b87105..3daf9dda2b5 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -12,14 +12,13 @@
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
 use migration::{impl_vmstate_c_struct, VMStateDescription};
+use qom::{prelude::*, ObjectClass, ObjectImpl, Owned, ParentInit};
 use util::{Error, Result};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     chardev::Chardev,
     irq::InterruptSource,
-    prelude::*,
-    qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
 };
 
 /// A safe wrapper around [`bindings::Clock`].
@@ -291,6 +290,7 @@ unsafe impl ObjectType for DeviceState {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
+
 qom_isa!(DeviceState: Object);
 
 /// Initialization methods take a [`ParentInit`] and can be called as
@@ -453,6 +453,7 @@ unsafe impl ObjectType for Clock {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
 }
+
 qom_isa!(Clock: Object);
 
 impl_vmstate_c_struct!(Clock, bindings::vmstate_clock);
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index b21883246e9..b883d7eaf18 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -8,14 +8,13 @@
 
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
+use qom::{prelude::*, Owned};
 
 use crate::{
     bindings,
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
-    prelude::*,
     qdev::{DeviceImpl, DeviceState},
-    qom::Owned,
 };
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
@@ -31,6 +30,7 @@ unsafe impl ObjectType for SysBusDevice {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
 }
+
 qom_isa!(SysBusDevice: DeviceState, Object);
 
 // TODO: add virtual methods
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index e72ba08aefe..f2e5eb9f4f4 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -7,11 +7,10 @@
 use bql::BqlCell;
 use migration::{VMStateDescription, VMStateDescriptionBuilder};
 use qemu_api::{
-    prelude::*,
     qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
-    qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
 };
+use qom::{prelude::*, ObjectImpl, ParentField};
 use util::bindings::{module_call_init, module_init_type};
 
 mod vmstate_tests;
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
new file mode 100644
index 00000000000..46bbf7c7fe4
--- /dev/null
+++ b/rust/qom/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "qom"
+version = "0.1.0"
+description = "Rust bindings for QEMU/QOM"
+resolver = "2"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+common = { path = "../common" }
+bql = { path = "../bql" }
+migration = { path = "../migration" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+util = { path = "../util" }
+
+[lints]
+workspace = true
diff --git a/rust/qom/build.rs b/rust/qom/build.rs
new file mode 120000
index 00000000000..71a3167885c
--- /dev/null
+++ b/rust/qom/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
new file mode 100644
index 00000000000..84a65cb737e
--- /dev/null
+++ b/rust/qom/meson.build
@@ -0,0 +1,43 @@
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_qom_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common,
+)
+
+_qom_rs = static_library(
+  'qom',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/prelude.rs',
+      'src/qom.rs',
+    ],
+    {'.': _qom_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [_bql_rs, _migration_rs],
+  dependencies: [common_rs, qemu_api_macros],
+)
+
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_api_macros, qom])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-qom-rs-doctests',
+     _qom_rs,
+     protocol: 'rust',
+     dependencies: qom_rs,
+     suite: ['doc', 'rust'])
diff --git a/rust/qom/src/bindings.rs b/rust/qom/src/bindings.rs
new file mode 100644
index 00000000000..9ffff12cded
--- /dev/null
+++ b/rust/qom/src/bindings.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qom/src/lib.rs b/rust/qom/src/lib.rs
new file mode 100644
index 00000000000..204c6fea2ff
--- /dev/null
+++ b/rust/qom/src/lib.rs
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
+mod qom;
+pub use qom::*;
diff --git a/rust/qom/src/prelude.rs b/rust/qom/src/prelude.rs
new file mode 100644
index 00000000000..00a60959771
--- /dev/null
+++ b/rust/qom/src/prelude.rs
@@ -0,0 +1,12 @@
+//! Traits and essential types intended for blanket imports.
+
+pub use crate::qom::InterfaceType;
+pub use crate::qom::IsA;
+pub use crate::qom::Object;
+pub use crate::qom::ObjectCast;
+pub use crate::qom::ObjectClassMethods;
+pub use crate::qom::ObjectDeref;
+pub use crate::qom::ObjectMethods;
+pub use crate::qom::ObjectType;
+
+pub use crate::qom_isa;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qom/src/qom.rs
similarity index 99%
rename from rust/qemu-api/src/qom.rs
rename to rust/qom/src/qom.rs
index 032701af652..3ea1ad9c5be 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -101,7 +101,6 @@
     ptr::NonNull,
 };
 
-pub use bindings::ObjectClass;
 use common::Opaque;
 use migration::impl_vmstate_pointer;
 
@@ -109,6 +108,7 @@
     self, object_class_dynamic_cast, object_dynamic_cast, object_get_class, object_get_typename,
     object_new, object_ref, object_unref, TypeInfo,
 };
+pub use crate::bindings::{type_register_static, ObjectClass};
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
@@ -146,7 +146,7 @@ macro_rules! qom_isa {
         $(
             // SAFETY: it is the caller responsibility to have $parent as the
             // first field
-            unsafe impl $crate::qom::IsA<$parent> for $struct {}
+            unsafe impl $crate::IsA<$parent> for $struct {}
 
             impl AsRef<$parent> for $struct {
                 fn as_ref(&self) -> &$parent {
-- 
2.51.0


