Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD5FB48B05
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 13:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTK-0006qq-Pi; Mon, 08 Sep 2025 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT9-0006n8-IJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSs-00069P-7g
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAOVTQn5CTh78jCiAMClQwZXPz1uUrN/qjmiu1nVz+c=;
 b=Vg7MvVQHzgJMVZNdtA6qac6S9fXtbZKAG1gqa86fg+f3JrqkcKstC3H9xnxM1gB8oqxGKn
 TaNkH3dpkKcWUrK/HmIfdHVBvK84m26EXerV/eb5E6sy8RDkj0vqGEheAFKvkEOlA/fc/G
 nAofCYUcBweFmveKn3zLl026BPpUIm8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-70MOUFyyMlCvYoycFKqtVA-1; Mon, 08 Sep 2025 06:51:10 -0400
X-MC-Unique: 70MOUFyyMlCvYoycFKqtVA-1
X-Mimecast-MFC-AGG-ID: 70MOUFyyMlCvYoycFKqtVA_1757328669
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3dbf3054ac4so2475689f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328668; x=1757933468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAOVTQn5CTh78jCiAMClQwZXPz1uUrN/qjmiu1nVz+c=;
 b=IbU7gQPMKBsQDva45p568F1spaaHGs85OPJs1CSCpHobe1mhADvr77Yjs2opnHGtEv
 eukS3q2XHrs3qnsjSyTUTZseZZyWa2WdBS24WVV9fFLPVRvg7S6D15g65ttDbTCaVF5s
 qwzH/s+pHk1j3tuS7eWntwkm0J3mWEK9GrH5Pif9eF60zctMvxL/t7Dh9s4tSSjmK3EU
 xfBIbNqTIHtnD9MvCGAM0fSyUhhvaywwnkofBXSiD030A3V5TQq3/6kMLFiMN4v2Erz1
 oeaK9lOGo3DiSlWkyFrWN3FKg0JW30E4dB6a3Kpodmn9kRrZjEeXCPwU6wAA+KOp0yIk
 UI5Q==
X-Gm-Message-State: AOJu0Yw4LLbL7q8bebVcjXws8GFDDMT8dUxz3jjNeQmB0X4DxOHXRyVi
 ZmkpBlPnXLLc89ICSFriFrt2Xfmvif4bAAAkYAoU+XpdidTgnnkR0cMHQCrdJSqZWmv4AtN1LaI
 c+cDHQFs+6NyiGDvheGSwV0qopJSHPKx8gw7geL7EXYzoVjd09mmKts3Pj7jKEkixUeyoMnkFCH
 MkB8lH6Ewm8pHT4IB82FxjEn40cpIVFs1RAuSF4vgr
X-Gm-Gg: ASbGncutMrq4tkgCFSpxNuZ239XbxVatZ63bOR/cYpuAIc6GhzKebkwJK7CeQTiYNLJ
 gCSKA0Zpi6w6yks+gyuv6ZTif2jQgukCZt5myjLtJdtq1a/lEF+GPpb/BZDRq4Sgr3de9dtne9x
 68urhX6XijYKiS9cYS4eNKXBKlmPA6Kgu551p7v6u1V50rGVVOVFDKgiwowNDOQ6qceuBGJVoA+
 R2NImPtEwBU1wfCZO9m5108teZpnW5ps4tHmwfEJNaYHkzCc9cQJe4XbzccZKSYa6pNyhO9O7ss
 r2RLjIT8f22i334rwb+gYLh74sSSRvUCqPTnIER6PoxkMOwYnT7OmWycWb5RuqRz/pt+HsYrmWj
 +8rXgBjd1/0kcgQFLVcG6TfnAMqC+RiLqDGpqZBO46w0=
X-Received: by 2002:a05:6000:2005:b0:3e3:e7a0:1ff8 with SMTP id
 ffacd0b85a97d-3e636d8ffc3mr5602786f8f.6.1757328667966; 
 Mon, 08 Sep 2025 03:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0hAX0iAO3Na69cubXvEC3HO9wsm+Mmz7cvkRsICcb13K2ISEZ6qA5hT0+Adev83QYkjRK2g==
X-Received: by 2002:a05:6000:2005:b0:3e3:e7a0:1ff8 with SMTP id
 ffacd0b85a97d-3e636d8ffc3mr5602747f8f.6.1757328667314; 
 Mon, 08 Sep 2025 03:51:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e74b28a108sm2095160f8f.16.2025.09.08.03.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 25/33] rust: rename qemu_api_macros -> qemu_macros
Date: Mon,  8 Sep 2025 12:49:57 +0200
Message-ID: <20250908105005.2119297-26-pbonzini@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since "qemu_api" is no longer the unique crate to provide APIs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-17-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 rust/Cargo.lock                               | 22 +++++++++----------
 rust/Cargo.toml                               |  2 +-
 rust/bits/Cargo.toml                          |  2 +-
 rust/bits/meson.build                         |  2 +-
 rust/bits/src/lib.rs                          |  4 ++--
 rust/chardev/Cargo.toml                       |  2 +-
 rust/chardev/meson.build                      |  4 ++--
 rust/chardev/src/chardev.rs                   |  2 +-
 rust/common/src/opaque.rs                     |  4 ++--
 rust/hw/char/pl011/Cargo.toml                 |  2 +-
 rust/hw/char/pl011/meson.build                |  4 ++--
 rust/hw/char/pl011/src/device.rs              |  4 ++--
 rust/hw/char/pl011/src/registers.rs           |  2 +-
 rust/hw/core/Cargo.toml                       |  2 +-
 rust/hw/core/meson.build                      |  4 ++--
 rust/hw/core/src/irq.rs                       |  2 +-
 rust/hw/core/src/qdev.rs                      |  6 ++---
 rust/hw/core/src/sysbus.rs                    |  2 +-
 rust/hw/core/tests/tests.rs                   |  4 ++--
 rust/hw/timer/hpet/Cargo.toml                 |  2 +-
 rust/hw/timer/hpet/meson.build                |  4 ++--
 rust/hw/timer/hpet/src/device.rs              |  6 ++---
 rust/meson.build                              |  2 +-
 rust/migration/Cargo.toml                     |  2 +-
 rust/qemu-api/Cargo.toml                      |  2 +-
 rust/qemu-api/meson.build                     |  4 ++--
 .../Cargo.toml                                |  2 +-
 .../meson.build                               | 10 ++++-----
 .../src/bits.rs                               |  0
 .../src/lib.rs                                |  0
 .../src/tests.rs                              |  0
 rust/qom/Cargo.toml                           |  2 +-
 rust/qom/meson.build                          |  4 ++--
 rust/qom/src/qom.rs                           |  4 ++--
 rust/system/Cargo.toml                        |  2 +-
 rust/system/meson.build                       |  4 ++--
 rust/system/src/memory.rs                     |  2 +-
 rust/util/Cargo.toml                          |  2 +-
 rust/util/meson.build                         |  2 +-
 rust/util/src/timer.rs                        |  4 ++--
 41 files changed, 69 insertions(+), 69 deletions(-)
 rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
 rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
 rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50dda5d119e..92cf6929bd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3519,7 +3519,7 @@ F: rust/common/
 F: rust/hw/core/
 F: rust/migration/
 F: rust/qemu-api
-F: rust/qemu-api-macros
+F: rust/qemu-macros/
 F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/system/
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 77118e882b5..021ce6dd48c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -41,7 +41,7 @@ dependencies = [
 name = "bits"
 version = "0.1.0"
 dependencies = [
- "qemu_api_macros",
+ "qemu_macros",
 ]
 
 [[package]]
@@ -58,7 +58,7 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "util",
 ]
@@ -94,7 +94,7 @@ dependencies = [
  "hwcore",
  "migration",
  "qemu_api",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -108,7 +108,7 @@ dependencies = [
  "chardev",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -134,7 +134,7 @@ name = "migration"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_api_macros",
+ "qemu_macros",
  "util",
 ]
 
@@ -151,7 +151,7 @@ dependencies = [
  "hwcore",
  "migration",
  "qemu_api",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
@@ -198,14 +198,14 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "system",
  "util",
 ]
 
 [[package]]
-name = "qemu_api_macros"
+name = "qemu_macros"
 version = "0.1.0"
 dependencies = [
  "proc-macro2",
@@ -220,7 +220,7 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_api_macros",
+ "qemu_macros",
  "util",
 ]
 
@@ -249,7 +249,7 @@ name = "system"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_api_macros",
+ "qemu_macros",
  "qom",
  "util",
 ]
@@ -268,7 +268,7 @@ dependencies = [
  "common",
  "foreign",
  "libc",
- "qemu_api_macros",
+ "qemu_macros",
 ]
 
 [[package]]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 8ec07d20651..b2a5c230fa2 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -5,7 +5,7 @@ members = [
     "bql",
     "common",
     "migration",
-    "qemu-api-macros",
+    "qemu-macros",
     "qemu-api",
     "qom",
     "system",
diff --git a/rust/bits/Cargo.toml b/rust/bits/Cargo.toml
index 1ff38a41175..7fce972b270 100644
--- a/rust/bits/Cargo.toml
+++ b/rust/bits/Cargo.toml
@@ -13,7 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
index 2a41e138c54..359ca86f155 100644
--- a/rust/bits/meson.build
+++ b/rust/bits/meson.build
@@ -3,7 +3,7 @@ _bits_rs = static_library(
   'src/lib.rs',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [qemu_api_macros],
+  dependencies: [qemu_macros],
 )
 
 bits_rs = declare_dependency(link_with: _bits_rs)
diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index e9d15ad0cb5..1bc882fde18 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -380,11 +380,11 @@ fn from(x: $type) -> Self {
     };
 
     { $type:ty: $expr:expr } => {
-        ::qemu_api_macros::bits_const_internal! { $type @ ($expr) }
+        ::qemu_macros::bits_const_internal! { $type @ ($expr) }
     };
 
     { $type:ty as $int_type:ty: $expr:expr } => {
-        (::qemu_api_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
+        (::qemu_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
     };
 }
 
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index 7df9c677fc7..c1391773078 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -18,7 +18,7 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 5d333e232bd..a2fa3268d21 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -35,7 +35,7 @@ _chardev_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [common_rs, qemu_api_macros],
+  dependencies: [common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_api_macros, chardev, qemuutil])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_macros, chardev, qemuutil])
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index 072d806e4a3..cb6f99398eb 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -26,7 +26,7 @@
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct Chardev(Opaque<bindings::Chardev>);
 
 pub type ChardevClass = bindings::ChardevClass;
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
index 97ed3e84522..3b3263acaa3 100644
--- a/rust/common/src/opaque.rs
+++ b/rust/common/src/opaque.rs
@@ -192,7 +192,7 @@ pub unsafe fn new() -> Self {
 
 /// Annotates [`Self`] as a transparent wrapper for another type.
 ///
-/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
+/// Usually defined via the [`qemu_macros::Wrapper`] derive macro.
 ///
 /// # Examples
 ///
@@ -228,7 +228,7 @@ pub unsafe fn new() -> Self {
 ///
 /// They are not defined here to allow them to be `const`.
 ///
-/// [`qemu_api_macros::Wrapper`]: ../../qemu_api_macros/derive.Wrapper.html
+/// [`qemu_macros::Wrapper`]: ../../qemu_macros/derive.Wrapper.html
 pub unsafe trait Wrapper {
     type Wrapped;
 }
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 830d88586bb..9e451fc0aa8 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -25,7 +25,7 @@ chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
 qemu_api = { path = "../../../qemu-api" }
-qemu_api_macros = { path = "../../../qemu-api-macros" }
+qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index fac04321133..bad6a839c39 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -12,7 +12,7 @@ _libpl011_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_api_macros,
+    qemu_macros,
     qom_rs,
     chardev_rs,
     system_rs,
@@ -24,6 +24,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_rs, qemu_api_macros],
+  dependencies: [bilge_impl_rs, qemu_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index a6a17d9f2dc..3010b6d9839 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -97,7 +97,7 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
+#[derive(qemu_macros::Object, qemu_macros::Device)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
@@ -683,7 +683,7 @@ pub fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError>
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
+#[derive(qemu_macros::Object, qemu_macros::Device)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 2bfbd81095e..a1c41347ed5 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -16,7 +16,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
+#[derive(Debug, Eq, PartialEq, qemu_macros::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 0b353802644..0eb9ffee263 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -20,7 +20,7 @@ chardev = { path = "../../chardev" }
 migration = { path = "../../migration" }
 system = { path = "../../system" }
 util = { path = "../../util" }
-qemu_api_macros = { path = "../../qemu-api-macros" }
+qemu_macros = { path = "../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 7dd1ade6f0f..67eacf854fe 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -58,7 +58,7 @@ _hwcore_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _system_rs, _util_rs],
-  dependencies: [qemu_api_macros, common_rs],
+  dependencies: [qemu_macros, common_rs],
 )
 
 hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
@@ -71,7 +71,7 @@ test('rust-hwcore-rs-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_api_macros, util_rs]),
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_macros, util_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index fead2bbe8e0..d8d964cad27 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -18,7 +18,7 @@
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct IRQState(Opaque<bindings::IRQState>);
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 8e9702ce0bb..c9faf44a71d 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -23,7 +23,7 @@
 
 /// A safe wrapper around [`bindings::Clock`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Clock(Opaque<bindings::Clock>);
 
 unsafe impl Send for Clock {}
@@ -31,7 +31,7 @@ unsafe impl Sync for Clock {}
 
 /// A safe wrapper around [`bindings::DeviceState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct DeviceState(Opaque<bindings::DeviceState>);
 
 unsafe impl Send for DeviceState {}
@@ -101,7 +101,7 @@ pub trait ResettablePhasesImpl {
 
 /// Helper trait to return pointer to a [`bindings::PropertyInfo`] for a type.
 ///
-/// This trait is used by [`qemu_api_macros::Device`] derive macro.
+/// This trait is used by [`qemu_macros::Device`] derive macro.
 ///
 /// Base types that already have `qdev_prop_*` globals in the QEMU API should
 /// use those values as exported by the [`bindings`] module, instead of
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index dda71ebda70..92c7449b802 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -19,7 +19,7 @@
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
 
 unsafe impl Send for SysBusDevice {}
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 21ee301fa68..2f08b8f3bfe 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -17,7 +17,7 @@
     .build();
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
+#[derive(qemu_macros::Object, qemu_macros::Device)]
 pub struct DummyState {
     parent: ParentField<DeviceState>,
     #[property(rename = "migrate-clk", default = true)]
@@ -54,7 +54,7 @@ impl DeviceImpl for DummyState {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
+#[derive(qemu_macros::Object, qemu_macros::Device)]
 pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index e28d66f6457..68e8187bb82 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -18,7 +18,7 @@ bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
-qemu_api_macros = { path = "../../../qemu-api-macros" }
+qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
 [lints]
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index e6f99b67785..3b94d5ec0a7 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -9,7 +9,7 @@ _libhpet_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_api_macros,
+    qemu_macros,
     qom_rs,
     system_rs,
     hwcore_rs,
@@ -20,6 +20,6 @@ rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [qemu_api_macros],
+  dependencies: [qemu_macros],
   variables: {'crate': 'hpet'},
 )])
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3031539744f..07e0f639fc4 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -97,7 +97,7 @@
 /// Timer N Interrupt Routing Capability (bits 32:63)
 const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
 
-#[derive(qemu_api_macros::TryInto)]
+#[derive(qemu_macros::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Timer registers, masked by 0x18
@@ -110,7 +110,7 @@ enum TimerRegister {
     ROUTE = 16,
 }
 
-#[derive(qemu_api_macros::TryInto)]
+#[derive(qemu_macros::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Global registers
@@ -520,7 +520,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_macros::Object)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
diff --git a/rust/meson.build b/rust/meson.build
index 041b0a473e5..9f6a0b161d2 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -23,7 +23,7 @@ qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 genrs = []
 
 subdir('common')
-subdir('qemu-api-macros')
+subdir('qemu-macros')
 subdir('bits')
 subdir('util')
 subdir('migration')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 98e6df2109d..66af81e0a35 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,7 +15,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 9e7afc7e3ad..9abb88aa1f8 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,9 +20,9 @@ hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
+qemu_macros = { path = "../qemu-macros" }
 qom = { path = "../qom" }
 system = { path = "../system" }
-qemu_api_macros = { path = "../qemu-api-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2dc638782ca..fe81f16d990 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -52,12 +52,12 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, hwcore_rs, libc_rs, migration_rs, qemu_api_macros,
+  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, hwcore_rs, libc_rs, migration_rs, qemu_macros,
                  qom_rs, system_rs, util_rs, hwcore],
 )
 
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
-  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
+  dependencies: [qemu_macros, qom, hwcore, chardev, migration])
 
 test('rust-qemu-api-integration',
     executable(
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-macros/Cargo.toml
similarity index 94%
rename from rust/qemu-api-macros/Cargo.toml
rename to rust/qemu-macros/Cargo.toml
index 0cd40c8e168..3b6f1d337f8 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-macros/Cargo.toml
@@ -1,5 +1,5 @@
 [package]
-name = "qemu_api_macros"
+name = "qemu_macros"
 version = "0.1.0"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
 description = "Rust bindings for QEMU - Utility macros"
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-macros/meson.build
similarity index 63%
rename from rust/qemu-api-macros/meson.build
rename to rust/qemu-macros/meson.build
index 2152bcb99b3..d0b2992e204 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -1,5 +1,5 @@
-_qemu_api_macros_rs = rust.proc_macro(
-  'qemu_api_macros',
+_qemu_macros_rs = rust.proc_macro(
+  'qemu_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
@@ -14,9 +14,9 @@ _qemu_api_macros_rs = rust.proc_macro(
   ],
 )
 
-qemu_api_macros = declare_dependency(
-  link_with: _qemu_api_macros_rs,
+qemu_macros = declare_dependency(
+  link_with: _qemu_macros_rs,
 )
 
-rust.test('rust-qemu-api-macros-tests', _qemu_api_macros_rs,
+rust.test('rust-qemu-macros-tests', _qemu_macros_rs,
           suite: ['unit', 'rust'])
diff --git a/rust/qemu-api-macros/src/bits.rs b/rust/qemu-macros/src/bits.rs
similarity index 100%
rename from rust/qemu-api-macros/src/bits.rs
rename to rust/qemu-macros/src/bits.rs
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
similarity index 100%
rename from rust/qemu-api-macros/src/lib.rs
rename to rust/qemu-macros/src/lib.rs
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
similarity index 100%
rename from rust/qemu-api-macros/src/tests.rs
rename to rust/qemu-macros/src/tests.rs
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
index 46bbf7c7fe4..060ad2ec349 100644
--- a/rust/qom/Cargo.toml
+++ b/rust/qom/Cargo.toml
@@ -16,7 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 bql = { path = "../bql" }
 migration = { path = "../migration" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
 
 [lints]
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 84a65cb737e..40c51b71b23 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -28,10 +28,10 @@ _qom_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs],
-  dependencies: [common_rs, qemu_api_macros],
+  dependencies: [common_rs, qemu_macros],
 )
 
-qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_api_macros, qom])
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index 3ea1ad9c5be..2cd1d850112 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -112,7 +112,7 @@
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Object(Opaque<bindings::Object>);
 
 unsafe impl Send for Object {}
@@ -173,7 +173,7 @@ fn as_ref(&self) -> &$parent {
 ///
 /// ```ignore
 /// #[repr(C)]
-/// #[derive(qemu_api_macros::Object)]
+/// #[derive(qemu_macros::Object)]
 /// pub struct MyDevice {
 ///     parent: ParentField<DeviceState>,
 ///     ...
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index 6803895e080..d8338c8348d 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,7 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/system/meson.build b/rust/system/meson.build
index ae9b932d29d..9f88166f3d3 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -35,8 +35,8 @@ _system_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [common_rs, qemu_api_macros],
+  dependencies: [common_rs, qemu_macros],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
-  dependencies: [qemu_api_macros, hwcore])
+  dependencies: [qemu_macros, hwcore])
diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 29568ed7676..7312f809f51 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -129,7 +129,7 @@ fn default() -> Self {
 
 /// A safe wrapper around [`bindings::MemoryRegion`].
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
 
 unsafe impl Send for MemoryRegion {}
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 637df61060a..18e6619ca06 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,7 +17,7 @@ anyhow = { workspace = true }
 foreign = { workspace = true }
 libc = { workspace = true }
 common = { path = "../common" }
-qemu_api_macros = { path = "../qemu-api-macros" }
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 56e929349b8..197872c9b23 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,7 +39,7 @@ _util_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qemu_api_macros, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qemu_macros, qom, qemuutil],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 383e1a6e774..622b6ee3097 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -15,14 +15,14 @@
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
 #[repr(transparent)]
-#[derive(Debug, qemu_api_macros::Wrapper)]
+#[derive(Debug, qemu_macros::Wrapper)]
 pub struct Timer(Opaque<bindings::QEMUTimer>);
 
 unsafe impl Send for Timer {}
 unsafe impl Sync for Timer {}
 
 #[repr(transparent)]
-#[derive(qemu_api_macros::Wrapper)]
+#[derive(qemu_macros::Wrapper)]
 pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
 
 unsafe impl Send for TimerListGroup {}
-- 
2.51.0


