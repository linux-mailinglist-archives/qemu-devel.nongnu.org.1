Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA85AA8EE3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 11:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrmP-0004rD-Ps; Mon, 05 May 2025 05:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrl0-0003Zc-OT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkw-0005lW-Rf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uG+eMff4v/DO/91eYXSXdK5N45eASxvptJIXXsF3tI=;
 b=LaihZVYh0sp27qBBquXJ7hW7yEHcUih8DS4JF2yRX54Tq7Wn+N5K1gCJ250hwIsaNgWCPf
 xdQRqQ4PKWAbZaZVyTnYNCLxvtwMMnEJlOsURJHw+IeE+VHV1aqc0zMEO88hSbr6ApDQcF
 wudg9RCApaBu5lnI9xT0oS3lSzHHiyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-XB73IaDLOyKKfNF8UU3NHg-1; Mon, 05 May 2025 05:04:56 -0400
X-MC-Unique: XB73IaDLOyKKfNF8UU3NHg-1
X-Mimecast-MFC-AGG-ID: XB73IaDLOyKKfNF8UU3NHg_1746435895
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so18263405e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435894; x=1747040694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uG+eMff4v/DO/91eYXSXdK5N45eASxvptJIXXsF3tI=;
 b=Fpnusz7ZwH5rrDqSkHg4HFbVgPO//ncjKjtYO1ueCUQOJqkUWw/+CroWI15DsiATWW
 6hMP6DqFL3Zgj5OXCjgANK1lKrF7adZvJ37X+Q+yCPWCESwFpX/xzJutItnc6AtmmmXq
 kz7UP9Zeo7DGWP03DqKkFB4Dpc1XfN24jvL4vQVe9lD5Hkcdvt+/647q7Q30gyKNHAiq
 V02PFzjoLVV/ewwbbK/0olcvdguFDq651PhMkBCO+y18e+vo3/pmwPEEOKiM73zm2dKY
 y/3QhthP4lPxB3AYFnFoaHqdgpwamBZc5gD5Lo1bFVaIhMXRg2j9Ri6aKbBS1fo6woeQ
 13IA==
X-Gm-Message-State: AOJu0YzBn7aNMc6m4Hp85mt6N5xh0IC4fmDrqyKrDGfkPQoptbAgjJql
 +b+PKH/DAy6SiVTDgoO/om3L2kUsYrC36zHgSSa6YuKkzqQrQNxgJq7z0ByJaYviiTYMbn9cqxe
 ZZcv6+w9j5gkFsh9xr81RknhjLkz2WEtB0WpZw1S66w1ZyFLfs1GVOMW1mOpPwPjvh47G/kobAc
 YxR7aSKSGmCy7Z2dQSsqTVvw3MWcT+DQrq9mCG
X-Gm-Gg: ASbGncsre1NhDIHo9iNXd3juamyOAC6ImbC/5n0y35sTM8Glyw9s+vUPy3LITvbNL4i
 luLZqPPBrq2+dR60AloSO1X8HLIPsrtEDCyvfZsZMjtJXuxA15KUhiDwrd+CtNdePQa7QRFiq0J
 BfCtgAXrht4KVjyVjFbt9Nj6/hBNepIfPI8N6DLasSvF3g5d8kSrjOKiTsPb7EUTfuncFwmnzXx
 iIaUGRxI/1gffb32J80SVW+Z+HAX6EfClc7DTw2ValYvVxmTwbZkpPTL1q3j70sAsWQVUtVT2UB
 Srtf9o+otNfvr20=
X-Received: by 2002:a05:600c:4e13:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-441c48bdf70mr52568775e9.8.1746435894383; 
 Mon, 05 May 2025 02:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmmV4LvsQ2cKHtXkGBI0WXsvIvJNS1zQFrMpCWRXBfVKswm8fM86s/Mj7lnZfoCC8EqHzlBw==
X-Received: by 2002:a05:600c:4e13:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-441c48bdf70mr52568405e9.8.1746435893850; 
 Mon, 05 May 2025 02:04:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315c8sm125948095e9.35.2025.05.05.02.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 06/11] rust: use MaybeUninit::zeroed() in const context
Date: Mon,  5 May 2025 11:04:31 +0200
Message-ID: <20250505090438.24992-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |   4 --
 rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
 rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
 3 files changed, 18 insertions(+), 96 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 8167ff49aa9..13a002cfe69 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -83,10 +83,6 @@ are missing:
 * "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
   the pinned-init create).
 
-* ``MaybeUninit::zeroed()`` as a ``const`` function (1.75.0).  QEMU's
-  ``Zeroable`` trait can be implemented without ``MaybeUninit::zeroed()``,
-  so this would be just a cleanup.
-
 * ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
   to define ``CStr`` constants easily
 
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index bef03727ea3..aa08d283519 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -4,7 +4,7 @@
 
 use std::ptr::addr_of_mut;
 
-use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
+use qemu_api::{cell::bql_locked, zeroable::Zeroable};
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
@@ -18,7 +18,7 @@ pub struct HPETFwEntry {
     pub min_tick: u16,
     pub page_prot: u8,
 }
-impl_zeroable!(HPETFwEntry);
+unsafe impl Zeroable for HPETFwEntry {}
 
 #[repr(C, packed)]
 #[derive(Copy, Clone, Default)]
@@ -26,7 +26,7 @@ pub struct HPETFwConfig {
     pub count: u8,
     pub hpet: [HPETFwEntry; HPET_MAX_NUM_EVENT_TIMER_BLOCK],
 }
-impl_zeroable!(HPETFwConfig);
+unsafe impl Zeroable for HPETFwConfig {}
 
 #[allow(non_upper_case_globals)]
 #[no_mangle]
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index a3415a2ebcc..e0720345495 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -4,89 +4,15 @@
 
 /// Encapsulates the requirement that
 /// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
-/// behavior.  This trait in principle could be implemented as just:
-///
-/// ```
-/// pub unsafe trait Zeroable: Default {
-///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
-/// }
-/// ```
-///
-/// The need for a manual implementation is only because `zeroed()` cannot
-/// be used as a `const fn` prior to Rust 1.75.0. Once we can assume a new
-/// enough version of the compiler, we could provide a `#[derive(Zeroable)]`
-/// macro to check at compile-time that all struct fields are Zeroable, and
-/// use the above blanket implementation of the `ZERO` constant.
+/// behavior.
 ///
 /// # Safety
 ///
-/// Because the implementation of `ZERO` is manual, it does not make
-/// any assumption on the safety of `zeroed()`.  However, other users of the
-/// trait could use it that way.  Do not add this trait to a type unless
-/// all-zeroes is a valid value for the type.  In particular, remember that
-/// raw pointers can be zero, but references and `NonNull<T>` cannot
+/// Do not add this trait to a type unless all-zeroes is a valid value for the
+/// type.  In particular, raw pointers can be zero, but references and
+/// `NonNull<T>` cannot.
 pub unsafe trait Zeroable: Default {
-    const ZERO: Self;
-}
-
-/// A macro that acts similarly to [`core::mem::zeroed()`], only is const
-///
-/// ## Safety
-///
-/// Similar to `core::mem::zeroed()`, except this zeroes padding bits. Zeroed
-/// padding usually isn't relevant to safety, but might be if a C union is used.
-///
-/// Just like for `core::mem::zeroed()`, an all zero byte pattern might not
-/// be a valid value for a type, as is the case for references `&T` and `&mut
-/// T`. Reference types trigger a (denied by default) lint and cause immediate
-/// undefined behavior if the lint is ignored
-///
-/// ```rust compile_fail
-/// use const_zero::const_zero;
-/// // error: any use of this value will cause an error
-/// // note: `#[deny(const_err)]` on by default
-/// const STR: &str = unsafe{const_zero!(&'static str)};
-/// ```
-///
-/// `const_zero` does not work on unsized types:
-///
-/// ```rust compile_fail
-/// use const_zero::const_zero;
-/// // error[E0277]: the size for values of type `[u8]` cannot be known at compilation time
-/// const BYTES: [u8] = unsafe{const_zero!([u8])};
-/// ```
-/// ## Differences with `core::mem::zeroed`
-///
-/// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
-#[macro_export]
-macro_rules! const_zero {
-    // This macro to produce a type-generic zero constant is taken from the
-    // const_zero crate (v0.1.1):
-    //
-    //     https://docs.rs/const-zero/latest/src/const_zero/lib.rs.html
-    //
-    // and used under MIT license
-    ($type_:ty) => {{
-        const TYPE_SIZE: ::core::primitive::usize = ::core::mem::size_of::<$type_>();
-        union TypeAsBytes {
-            bytes: [::core::primitive::u8; TYPE_SIZE],
-            inner: ::core::mem::ManuallyDrop<$type_>,
-        }
-        const ZERO_BYTES: TypeAsBytes = TypeAsBytes {
-            bytes: [0; TYPE_SIZE],
-        };
-        ::core::mem::ManuallyDrop::<$type_>::into_inner(ZERO_BYTES.inner)
-    }};
-}
-
-/// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
-#[macro_export]
-macro_rules! impl_zeroable {
-    ($type:ty) => {
-        unsafe impl $crate::zeroable::Zeroable for $type {
-            const ZERO: Self = unsafe { $crate::const_zero!($type) };
-        }
-    };
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
 }
 
 // bindgen does not derive Default here
@@ -97,13 +23,13 @@ fn default() -> Self {
     }
 }
 
-impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
-impl_zeroable!(crate::bindings::Property);
-impl_zeroable!(crate::bindings::VMStateFlags);
-impl_zeroable!(crate::bindings::VMStateField);
-impl_zeroable!(crate::bindings::VMStateDescription);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
-impl_zeroable!(crate::bindings::MemoryRegionOps);
-impl_zeroable!(crate::bindings::MemTxAttrs);
-impl_zeroable!(crate::bindings::CharBackend);
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateFlags {}
+unsafe impl Zeroable for crate::bindings::VMStateField {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
+unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
+unsafe impl Zeroable for crate::bindings::CharBackend {}
-- 
2.49.0


