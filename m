Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 098EEA31833
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 22:49:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy7m-00055P-K8; Tue, 11 Feb 2025 16:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3d-00082q-3F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3b-0005SX-8S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=haheJ5bpjRBjbwxH7eaaz7CF0vcGhATS04334Z3InTo=;
 b=N180bO5TvpogyNy0fNL27rpGyWKa8Kc2qEA08bTxvNGT9MYND7py8CDV1QrDzAKtdbAi33
 qkhHm6f/IA1bazpBDqcgSug4bKMw3Awnw2DIkTWQkZUZMVbLbcYe0GFDXdn3qPZYnCsqZW
 Av1N1xiJ+tW5zBpBKI7eqCrB6NGc+hQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-kYVvKMFWPDibMpEgJQxqQA-1; Tue,
 11 Feb 2025 16:44:34 -0500
X-MC-Unique: kYVvKMFWPDibMpEgJQxqQA-1
X-Mimecast-MFC-AGG-ID: kYVvKMFWPDibMpEgJQxqQA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAEA31800874; Tue, 11 Feb 2025 21:44:32 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A6D7195608D; Tue, 11 Feb 2025 21:44:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 09/11] rust/block: Add read support for block drivers
Date: Tue, 11 Feb 2025 22:43:26 +0100
Message-ID: <20250211214328.640374-10-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This adds a map() function to the BlockDriver trait and makes use of it
to implement reading from an image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/block/src/driver.rs | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
index 5c7c46bfa0..2849ef6949 100644
--- a/rust/block/src/driver.rs
+++ b/rust/block/src/driver.rs
@@ -9,11 +9,46 @@
 
 use crate::{IoBuffer, SizedIoBuffer};
 use qemu_api::bindings;
+use qemu_api::futures::qemu_co_run_future;
+use std::cmp::min;
 use std::ffi::c_void;
 use std::io::{self, Error, ErrorKind};
 use std::mem::MaybeUninit;
 use std::ptr;
 
+/// A request to a block driver
+pub enum Request {
+    Read { offset: u64, len: u64 },
+}
+
+/// The target for a number of guest blocks, e.g. a location in a child node or the information
+/// that the described blocks are unmapped.
+// FIXME Actually use node
+#[allow(dead_code)]
+pub enum MappingTarget {
+    /// The described blocks are unallocated. Reading from them yields zeros.
+    Unmapped,
+
+    /// The described blocks are stored in a child node.
+    Data {
+        /// Child node in which the data is stored
+        node: (),
+
+        /// Offset in the child node at which the data is stored
+        offset: u64,
+    },
+}
+
+/// A mapping for a number of contiguous guest blocks
+pub struct Mapping {
+    /// Offset of the mapped blocks from the perspective of the guest
+    pub offset: u64,
+    /// Length of the mapping in bytes
+    pub len: u64,
+    /// Where the data for the described blocks is stored
+    pub target: MappingTarget,
+}
+
 /// A trait for writing block drivers.
 ///
 /// Types that implement this trait can be registered as QEMU block drivers using the
@@ -37,6 +72,11 @@ unsafe fn open(
 
     /// Returns the size of the image in bytes
     fn size(&self) -> u64;
+
+    /// Returns the mapping for the first part of `req`. If the returned mapping is shorter than
+    /// the request, the function can be called again with a shortened request to get the mapping
+    /// for the remaining part.
+    async fn map(&self, req: &Request) -> io::Result<Mapping>;
 }
 
 /// Represents the connection between a parent and its child node.
@@ -161,6 +201,65 @@ pub async fn read_uninit<T: SizedIoBuffer>(
     }
 }
 
+#[doc(hidden)]
+pub unsafe extern "C" fn bdrv_co_preadv_part<D: BlockDriver>(
+    bs: *mut bindings::BlockDriverState,
+    offset: i64,
+    bytes: i64,
+    qiov: *mut bindings::QEMUIOVector,
+    mut qiov_offset: usize,
+    flags: bindings::BdrvRequestFlags,
+) -> std::os::raw::c_int {
+    let s = unsafe { &mut *((*bs).opaque as *mut D) };
+
+    let mut offset = offset as u64;
+    let mut bytes = bytes as u64;
+
+    while bytes > 0 {
+        let req = Request::Read { offset, len: bytes };
+        let mapping = match qemu_co_run_future(s.map(&req)) {
+            Ok(mapping) => mapping,
+            Err(e) => {
+                return e
+                    .raw_os_error()
+                    .unwrap_or(-(bindings::EIO as std::os::raw::c_int))
+            }
+        };
+
+        let mapping_offset = offset - mapping.offset;
+        let cur_bytes = min(bytes, mapping.len - mapping_offset);
+
+        match mapping.target {
+            MappingTarget::Unmapped => unsafe {
+                bindings::qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes.try_into().unwrap());
+            },
+            MappingTarget::Data {
+                node: _,
+                offset: target_offset,
+            } => unsafe {
+                // TODO Support using child nodes other than bs->file
+                let ret = bindings::bdrv_co_preadv_part(
+                    (*bs).file,
+                    (target_offset + mapping_offset) as i64,
+                    cur_bytes as i64,
+                    qiov,
+                    qiov_offset,
+                    flags,
+                );
+                if ret < 0 {
+                    return ret;
+                }
+            },
+        }
+
+        offset += cur_bytes;
+        qiov_offset += cur_bytes as usize;
+        bytes -= cur_bytes;
+    }
+
+    0
+}
+
 /// Declare a format block driver. This macro is meant to be used at the top level.
 ///
 /// `typ` is a type implementing the [`BlockDriver`] trait to handle the image format with the
@@ -174,6 +273,7 @@ macro_rules! block_driver {
                     instance_size: ::std::mem::size_of::<$typ>() as i32,
                     bdrv_open: Some($crate::driver::bdrv_open::<$typ>),
                     bdrv_close: Some($crate::driver::bdrv_close::<$typ>),
+                    bdrv_co_preadv_part: Some($crate::driver::bdrv_co_preadv_part::<$typ>),
                     bdrv_child_perm: Some(::qemu_api::bindings::bdrv_default_perms),
                     is_format: true,
                     ..::qemu_api::zeroable::Zeroable::ZERO
-- 
2.48.1


