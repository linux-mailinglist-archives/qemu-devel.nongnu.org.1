Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B68B48A8F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 12:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZT9-0006ma-U1; Mon, 08 Sep 2025 06:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT5-0006m1-PA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSm-00067u-DS
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fi9ZNmLCU3tcVI7gEOdl6O60AzieMuumjcbcJPc176k=;
 b=Vk0D7aAolFxcOUrZJRuyw11YWYgbguMMOyHl7XGNKhKjUHdIERLfoTbozyri58EBsgsJ+h
 +SZj35sZK9xusSffpny7Z1QC8qNnBFzktAd5PNGYFtlKem+r+YxcatQFiRYi2ATfCuNmSN
 bPRDnQmjncekuU7WwIEs8/kDT1zkGGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-6V8rtDIZN0yalZaYRadN2w-1; Mon, 08 Sep 2025 06:51:03 -0400
X-MC-Unique: 6V8rtDIZN0yalZaYRadN2w-1
X-Mimecast-MFC-AGG-ID: 6V8rtDIZN0yalZaYRadN2w_1757328662
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45de59f92aaso5922905e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328661; x=1757933461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fi9ZNmLCU3tcVI7gEOdl6O60AzieMuumjcbcJPc176k=;
 b=sZaGLIdBnk9xKMqycPK3uHa236NojadQgTknRTWfJFea7+dhnoMuC0+GHqRxA7PhGc
 eWKoJsYdxzY07XRW2vYO+TZZj6A5MuhnheKXDADlLk0CIfgXwv1WguCfpbGvj/3d8iie
 1W4IdFA68HjpuxJx4xlSvdPH/uBVHr833vEKfGiIgp6RCB12bZ46ImXtR1gleykOt4ZI
 TF7doPjBiZGwb+vmZjljavXP3BNKrJHWtQOlFxeyxeG3KAriKLQ0PFdUpgmWFPqmg8O/
 RnN4vdnpEXIqwZo1qaQn3pScPq0yCHbS++WvrBk7342arjEL6bo6JicxV70/9gsRJVUL
 2pJA==
X-Gm-Message-State: AOJu0YzFcZ+HYD7W03pBaC9BLlIjuCK4mvnJ+s3VmviIBrIEX7y9Jy2k
 FI2bxJ1b2IbKrrQ9oEvvIoi6fcMcu7cQGBQU0xd9xMHxfxun54MigT9ODWwPt89t3R9y9L2lV2z
 19000XEeQPG4irt9AP2p+EKwXKuVg1/vhJwNkV0xPZnAPFoRfusSWNEhZ+zGA6sWW0iVSDYyJF3
 nw8FLp8E9NdP3nqy5Mr6CGDCiYEWnYya/xK8gQg/5h
X-Gm-Gg: ASbGnctq2UV+NtjhcjUa+Btfje2NKh+q/pKNmA3rNSToPsQMfKliyBXD/HOBd8xfTj1
 /cmcVVlhlRlho/UM29N4gaKPT/MIpTRF4TmPCdssyxl/jyKKKagWk6ZtF4yOPctGFFywtUh4ziZ
 ofKPLT80Oa8UufzaOjFie2s8gjHfOkpVfDvdi0aOKTyjDRtl3UELxtQWuJB+rbxfGh5VAcjlV4G
 RPnwwQiKRBCifQuSE8y3d+ugSdzjCwcDb3HWTjy5P3uMtOSDkoQVpSgHcYGDXt5T6zKsNfNBf4z
 /0ZPDeZvvK/CiXZUBF6o9Z7d1V39LjihWALCCKV//dFP/6XiZQczGEgzjtKqQ81vmdimAQlSZkG
 7tCXm29o+TBpYpHUJ4A42ns5piFlVqs20vlS+lUJ/oZ0=
X-Received: by 2002:a05:600c:c4ac:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-45dddecdaf1mr51743075e9.21.1757328661244; 
 Mon, 08 Sep 2025 03:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmmh6QVfB6muLdNt2Ur0MEchC052xq5c5uQxhXpWwM/XQyXfPNgN29hEoboomi4ABXn0Nz4g==
X-Received: by 2002:a05:600c:c4ac:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-45dddecdaf1mr51742715e9.21.1757328660599; 
 Mon, 08 Sep 2025 03:51:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd3aadbcesm164891435e9.17.2025.09.08.03.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 22/33] rust: split "chardev" crate
Date: Mon,  8 Sep 2025 12:49:54 +0200
Message-ID: <20250908105005.2119297-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/20250827104147.717203-14-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                               |  1 +
 rust/chardev/wrapper.h                    | 28 ++++++++++++++++
 rust/qemu-api/wrapper.h                   |  2 --
 rust/Cargo.lock                           | 14 ++++++++
 rust/chardev/Cargo.toml                   | 24 +++++++++++++
 rust/chardev/build.rs                     |  1 +
 rust/chardev/meson.build                  | 41 +++++++++++++++++++++++
 rust/chardev/src/bindings.rs              | 36 ++++++++++++++++++++
 rust/{qemu-api => chardev}/src/chardev.rs |  0
 rust/chardev/src/lib.rs                   |  6 ++++
 rust/hw/char/pl011/Cargo.toml             |  1 +
 rust/hw/char/pl011/meson.build            |  1 +
 rust/hw/char/pl011/src/device.rs          |  2 +-
 rust/meson.build                          |  1 +
 rust/qemu-api/Cargo.toml                  |  1 +
 rust/qemu-api/meson.build                 |  9 +++--
 rust/qemu-api/src/bindings.rs             |  9 +----
 rust/qemu-api/src/lib.rs                  |  1 -
 rust/qemu-api/src/qdev.rs                 |  6 ++--
 19 files changed, 164 insertions(+), 20 deletions(-)
 create mode 100644 rust/chardev/wrapper.h
 create mode 100644 rust/chardev/Cargo.toml
 create mode 120000 rust/chardev/build.rs
 create mode 100644 rust/chardev/meson.build
 create mode 100644 rust/chardev/src/bindings.rs
 rename rust/{qemu-api => chardev}/src/chardev.rs (100%)
 create mode 100644 rust/chardev/src/lib.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 70840abddc8..0d9b7a36675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,6 +3514,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/bql/
+F: rust/chardev/
 F: rust/common/
 F: rust/migration/
 F: rust/qemu-api
diff --git a/rust/chardev/wrapper.h b/rust/chardev/wrapper.h
new file mode 100644
index 00000000000..65ede6ea6d7
--- /dev/null
+++ b/rust/chardev/wrapper.h
@@ -0,0 +1,28 @@
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
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index b99df9f568a..07dbc9987a8 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -52,13 +52,11 @@ typedef enum memory_order {
 #include "system/system.h"
 #include "hw/sysbus.h"
 #include "system/memory.h"
-#include "chardev/char-fe.h"
 #include "hw/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
-#include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 442eadf08fa..ae852c55508 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -51,6 +51,18 @@ dependencies = [
  "migration",
 ]
 
+[[package]]
+name = "chardev"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "common",
+ "migration",
+ "qemu_api_macros",
+ "qom",
+ "util",
+]
+
 [[package]]
 name = "common"
 version = "0.1.0"
@@ -118,6 +130,7 @@ dependencies = [
  "bilge-impl",
  "bits",
  "bql",
+ "chardev",
  "common",
  "migration",
  "qemu_api",
@@ -163,6 +176,7 @@ name = "qemu_api"
 version = "0.1.0"
 dependencies = [
  "bql",
+ "chardev",
  "common",
  "migration",
  "qemu_api_macros",
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
new file mode 100644
index 00000000000..7df9c677fc7
--- /dev/null
+++ b/rust/chardev/Cargo.toml
@@ -0,0 +1,24 @@
+[package]
+name = "chardev"
+version = "0.1.0"
+description = "Rust bindings for QEMU/chardev"
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
+qom = { path = "../qom" }
+util = { path = "../util" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/chardev/build.rs b/rust/chardev/build.rs
new file mode 120000
index 00000000000..71a3167885c
--- /dev/null
+++ b/rust/chardev/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
new file mode 100644
index 00000000000..5d333e232bd
--- /dev/null
+++ b/rust/chardev/meson.build
@@ -0,0 +1,41 @@
+c_enums = [
+  'QEMUChrEvent',
+]
+_chardev_bindgen_args = []
+foreach enum : c_enums
+  _chardev_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_chardev_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _chardev_bindgen_args,
+)
+
+_chardev_rs = static_library(
+  'chardev',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/chardev.rs',
+    ],
+    {'.': _chardev_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
+  dependencies: [common_rs, qemu_api_macros],
+)
+
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_api_macros, chardev, qemuutil])
diff --git a/rust/chardev/src/bindings.rs b/rust/chardev/src/bindings.rs
new file mode 100644
index 00000000000..2d98026d627
--- /dev/null
+++ b/rust/chardev/src/bindings.rs
@@ -0,0 +1,36 @@
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
+use common::Zeroable;
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+// SAFETY: these are implemented in C; the bindings need to assert that the
+// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
+// When bindings for character devices are introduced, this can be
+// moved to the Opaque<> wrapper in src/chardev.rs.
+unsafe impl Send for CharBackend {}
+unsafe impl Sync for CharBackend {}
+
+unsafe impl Zeroable for CharBackend {}
diff --git a/rust/qemu-api/src/chardev.rs b/rust/chardev/src/chardev.rs
similarity index 100%
rename from rust/qemu-api/src/chardev.rs
rename to rust/chardev/src/chardev.rs
diff --git a/rust/chardev/src/lib.rs b/rust/chardev/src/lib.rs
new file mode 100644
index 00000000000..2e549f99d91
--- /dev/null
+++ b/rust/chardev/src/lib.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+
+mod chardev;
+pub use chardev::*;
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index da89f78727f..f7ad5f8e08f 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -21,6 +21,7 @@ util = { path = "../../../util" }
 bql = { path = "../../../bql" }
 migration = { path = "../../../migration" }
 qom = { path = "../../../qom" }
+chardev = { path = "../../../chardev" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index af9393c9da9..aaf911c5f42 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -14,6 +14,7 @@ _libpl011_rs = static_library(
     bql_rs,
     qemu_api_macros,
     qom_rs,
+    chardev_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 63651b9dcdf..bc64061fb39 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,13 +5,13 @@
 use std::{ffi::CStr, mem::size_of};
 
 use bql::BqlRefCell;
+use chardev::{CharBackend, Chardev, Event};
 use common::{static_assert, uninit_field_mut};
 use migration::{
     self, impl_vmstate_forward, impl_vmstate_struct, vmstate_fields, vmstate_of,
     vmstate_subsections, vmstate_unused, VMStateDescription, VMStateDescriptionBuilder,
 };
 use qemu_api::{
-    chardev::{CharBackend, Chardev, Event},
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
diff --git a/rust/meson.build b/rust/meson.build
index 043603d4169..4d9e2912232 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -29,6 +29,7 @@ subdir('util')
 subdir('migration')
 subdir('bql')
 subdir('qom')
+subdir('chardev')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 9d11becb284..3bf2dafa6df 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+chardev = { path = "../chardev" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 11e43bb6468..a47f178b698 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -7,7 +7,6 @@ c_enums = [
   'GpioPolarity',
   'MachineInitPhase',
   'MemoryDeviceInfoKind',
-  'QEMUChrEvent',
   'ResetType',
   'device_endian',
 ]
@@ -23,9 +22,10 @@ foreach enum : c_bitfields
 endforeach
 
 blocked_type = [
+  'Chardev',
+  'Error',
   'ObjectClass',
   'VMStateDescription',
-  'Error',
 ]
 foreach type: blocked_type
   _qemu_api_bindgen_args += ['--blocklist-type', type]
@@ -53,7 +53,6 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
-      'src/chardev.rs',
       'src/irq.rs',
       'src/memory.rs',
       'src/prelude.rs',
@@ -65,8 +64,8 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, bql_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
-                 qom_rs, util_rs, hwcore, chardev],
+  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
+                 qom_rs, util_rs, hwcore],
 )
 
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 525f136ae2b..526bcf8e31b 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -20,6 +20,7 @@
 
 //! `bindgen`-generated declarations.
 
+use chardev::bindings::Chardev;
 use common::Zeroable;
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
@@ -31,13 +32,6 @@
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
 
-// SAFETY: these are implemented in C; the bindings need to assert that the
-// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-// When bindings for character devices are introduced, this can be
-// moved to the Opaque<> wrapper in src/chardev.rs.
-unsafe impl Send for CharBackend {}
-unsafe impl Sync for CharBackend {}
-
 // SAFETY: this is a pure data struct
 unsafe impl Send for CoalescedMemoryRange {}
 unsafe impl Sync for CoalescedMemoryRange {}
@@ -59,4 +53,3 @@ unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
 unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
-unsafe impl Zeroable for crate::bindings::CharBackend {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 0541050e667..d96096899d0 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -13,7 +13,6 @@
 #[rustfmt::skip]
 pub mod prelude;
 
-pub mod chardev;
 pub mod irq;
 pub mod memory;
 pub mod qdev;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 3daf9dda2b5..7efc796f502 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -10,6 +10,7 @@
 };
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
+use chardev::Chardev;
 use common::{callbacks::FnCall, Opaque};
 use migration::{impl_vmstate_c_struct, VMStateDescription};
 use qom::{prelude::*, ObjectClass, ObjectImpl, Owned, ParentInit};
@@ -17,7 +18,6 @@
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
-    chardev::Chardev,
     irq::InterruptSource,
 };
 
@@ -137,8 +137,8 @@ unsafe impl QDevProp for u64 {
     const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_uint64 };
 }
 
-/// Use [`bindings::qdev_prop_chr`] for [`crate::chardev::CharBackend`].
-unsafe impl QDevProp for crate::chardev::CharBackend {
+/// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
+unsafe impl QDevProp for chardev::CharBackend {
     const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_chr };
 }
 
-- 
2.51.0


