Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554679BBBE3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 18:29:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s3-0005FP-Sq; Mon, 04 Nov 2024 12:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s1-0005EL-9K
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rz-0000IK-4v
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJKy0xe3JNrrE6/anLJ268ol41o+r1HxLKUij6otdYI=;
 b=QsexUUcuZTBxgSZXmpx7ru/0V29yose8c/lVQJ+aOJ/yWxfgHqgyqY7NI9K1V5Li3oXWh2
 LaPtUVWA+7D0VG6YSMnNEtXZaHpOFfzkYuFzY2woWlKE8rd4WXQd/p+N/GYMY1uVZ6ZrLA
 8p+Jcowhh6ZJ46yYvjWurgNwM2fM/XI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-msrIovsNMGm1YRnELr-LHA-1; Mon, 04 Nov 2024 12:28:01 -0500
X-MC-Unique: msrIovsNMGm1YRnELr-LHA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315544642eso33004235e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741279; x=1731346079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJKy0xe3JNrrE6/anLJ268ol41o+r1HxLKUij6otdYI=;
 b=Wyopf6mu2BYmGsB8PiK3BO7oy/o707qIAf5sne+j/8+XLnOKfYOgswQdNmS425LRQ8
 fiBgpI7mE3mWMwe+AyRo/EED6AQTjV1CLSIWWQz03znZ7VGX6CTVIgWfaTF9Fqrx/unp
 40n6ufzP6pPEZNHyt+QoYF6w7e8USBqoYJ9Xp0HyE7vr4aAtRYjG3kzBc1dDS8W7Pcxk
 B7NGZ19quZTPGfWUx4eFaIcpK4UoZbHfki1lkq2ioBJUAUnHmIea8jbNJcegt+kxkAuA
 oLtF7LN2CbDRWeG6FWQIDNTtLrrLulwpBNiOmKDxqnz/HL6yY0kbQ/7ZuDz3Avu4oupQ
 vfbw==
X-Gm-Message-State: AOJu0YwFidpqiLHUbB4jeljb8ujrxfth+yU6HRTCXsrV+QW2Op/wkHHg
 816IkvrWtLSTrMBXfEBti+Yqf1Ex6DlxpZdL4uuYgmHA7TBe0niQ46Urb/U3cnw8PK2Q9nxob/W
 t1lMeXBTkxSWkxYk+g3Qdnwysk1Yprb32KEo31Gl7GaeFzU6t9K266Nl+rbCNOoxilj+/jw5Fb3
 6202hT+XC1MkP1VDGTVVBlg5Aq+3wB8dn7jJHjxJo=
X-Received: by 2002:a05:600c:3ca8:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4327b7019ddmr133802315e9.20.1730741279009; 
 Mon, 04 Nov 2024 09:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtJsOfk/ExGhk8VkKisxCH+ZTfwQAioW/TB1c5ruDXm2kgBjGPtQBu8TDGXNoK4fCLD9Mt1g==
X-Received: by 2002:a05:600c:3ca8:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-4327b7019ddmr133801965e9.20.1730741278520; 
 Mon, 04 Nov 2024 09:27:58 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9faesm189516705e9.35.2024.11.04.09.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/40] rust: provide safe wrapper for MaybeUninit::zeroed()
Date: Mon,  4 Nov 2024 18:26:55 +0100
Message-ID: <20241104172721.180255-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MaybeUninit::zeroed() is handy, but it introduces unsafe (and has a
pretty heavy syntax in general).  Introduce a trait that provides the
same functionality while staying within safe Rust.

In addition, MaybeUninit::zeroed() is not available as a "const"
function until Rust 1.75.0, so this also prepares for having handwritten
implementations of the trait until we can assume that version.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs |  4 ++--
 rust/hw/char/pl011/src/memory_ops.rs   |  8 ++++----
 rust/qemu-api/meson.build              |  1 +
 rust/qemu-api/src/device_class.rs      |  8 ++++----
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/zeroable.rs          | 23 +++++++++++++++++++++++
 6 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/zeroable.rs

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 2ad80451e87..08c846aa482 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -4,7 +4,7 @@
 
 use core::ptr::NonNull;
 
-use qemu_api::{bindings::*, definitions::ObjectImpl};
+use qemu_api::{bindings::*, definitions::ObjectImpl, zeroable::Zeroable};
 
 use crate::device::PL011State;
 
@@ -12,7 +12,7 @@
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
     name: PL011State::TYPE_INFO.name,
     unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+    ..Zeroable::ZERO
 };
 
 qemu_api::declare_properties! {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 5a5320e66c3..fc69922fbf3 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -2,9 +2,9 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::{mem::MaybeUninit, ptr::NonNull};
+use core::ptr::NonNull;
 
-use qemu_api::bindings::*;
+use qemu_api::{bindings::*, zeroable::Zeroable};
 
 use crate::device::PL011State;
 
@@ -14,11 +14,11 @@
     read_with_attrs: None,
     write_with_attrs: None,
     endianness: device_endian::DEVICE_NATIVE_ENDIAN,
-    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
+    valid: Zeroable::ZERO,
     impl_: MemoryRegionOps__bindgen_ty_2 {
         min_access_size: 4,
         max_access_size: 4,
-        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().assume_init() }
+        ..Zeroable::ZERO
     },
 };
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1fc36078027..1b0fd406378 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,6 +5,7 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
   ),
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 4b14cb3ffd6..aa6088d9d3d 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -31,7 +31,7 @@ macro_rules! define_property {
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         }
     };
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
@@ -41,7 +41,7 @@ macro_rules! define_property {
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         }
     };
 }
@@ -58,7 +58,7 @@ macro_rules! declare_properties {
             len
         }] = [
             $($prop),*,
-            unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+            $crate::zeroable::Zeroable::ZERO,
         ];
     };
 }
@@ -79,7 +79,7 @@ macro_rules! vm_state_description {
                 $vname.as_ptr()
             },)*
             unmigratable: true,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         };
     }
 }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 6bc68076aae..e94a15bb823 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 
 pub mod definitions;
 pub mod device_class;
+pub mod zeroable;
 
 use std::alloc::{GlobalAlloc, Layout};
 
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
new file mode 100644
index 00000000000..45ec95c9f70
--- /dev/null
+++ b/rust/qemu-api/src/zeroable.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/// Encapsulates the requirement that
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause
+/// undefined behavior.
+///
+/// # Safety
+///
+/// Do not add this trait to a type unless all-zeroes is
+/// a valid value for the type.  In particular, remember that raw
+/// pointers can be zero, but references and `NonNull<T>` cannot
+/// unless wrapped with `Option<>`.
+pub unsafe trait Zeroable: Default {
+    /// SAFETY: If the trait was added to a type, then by definition
+    /// this is safe.
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+}
+
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
-- 
2.47.0


