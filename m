Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F5B3678F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Aug 2025 16:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJB-00068L-8j; Tue, 26 Aug 2025 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJ3-00064A-Ca
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIt-00072S-H1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmT1dEKaRl4M6Vu85AUODd3c7+AYcnMdCM+EQuaUcmg=;
 b=KX5uiFNq74KGceMNHQD/8dtZ761Ptc/ugKZZiRyL4t8Qq566OIP151x3tvmoy2+uoetdSu
 SPcRYcZmqrNhjPvIkjs+ghFrV4xyUnDl21Opgo/f2t449pTqyXcw2BfzOEz5s7upcyzZx0
 bIKelyGvD0+aigE/GOYozCIQPFu9YKs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-ovozX8_pNl29YiHehVD1vA-1; Tue,
 26 Aug 2025 10:05:34 -0400
X-MC-Unique: ovozX8_pNl29YiHehVD1vA-1
X-Mimecast-MFC-AGG-ID: ovozX8_pNl29YiHehVD1vA_1756217133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F7B1956095; Tue, 26 Aug 2025 14:05:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89F1818004A3; Tue, 26 Aug 2025 14:05:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 07/18] rust: move Cell vmstate impl
Date: Tue, 26 Aug 2025 18:04:35 +0400
Message-ID: <20250826140449.4190022-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/qemu-api/src/cell.rs    |  5 ++++-
 rust/qemu-api/src/vmstate.rs | 16 +++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 98d720caf9..4bce526e45 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -152,7 +152,7 @@
     ptr::NonNull,
 };
 
-use crate::bindings;
+use crate::{bindings, impl_vmstate_transparent};
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
@@ -866,3 +866,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         (**self).fmt(f)
     }
 }
+
+impl_vmstate_transparent!(BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(BqlRefCell<T> where T: VMState);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index c1e2b06390..9d33997c57 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -29,8 +29,7 @@
 
 use common::{callbacks::FnCall, Zeroable};
 
-use crate::bindings::VMStateFlags;
-pub use crate::bindings::{VMStateDescription, VMStateField};
+pub use crate::bindings::{VMStateDescription, VMStateField, VMStateFlags};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -325,15 +324,16 @@ unsafe impl $crate::vmstate::VMState for $tuple {
 
 // Transparent wrappers: just use the internal type
 
+#[macro_export]
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const SCALAR_TYPE: VMStateFieldType = <$base as VMState>::SCALAR_TYPE;
-            const BASE: VMStateField = VMStateField {
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType = <$base as $crate::vmstate::VMState>::SCALAR_TYPE;
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
                 size: mem::size_of::<$type>(),
-                ..<$base as VMState>::BASE
+                ..<$base as $crate::vmstate::VMState>::BASE
             };
-            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
+            const VARRAY_FLAG: $crate::vmstate::VMStateFlags = <$base as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
     };
 }
@@ -341,8 +341,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(::common::Opaque<T> where T: VMState);
 
 #[macro_export]
-- 
2.50.1


