Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C1A3A545
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 19:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSDm-00068O-VT; Tue, 18 Feb 2025 13:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD7-0005wO-Rq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD5-0007Yl-M3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=923xhTGa1MCQDYQdzI+21XRBNKdcC2JDyuZNJd+hNLk=;
 b=jUR3BRcMSsTimG+hBrYHXtENQhBEaoF7uu2KOHtPcFw3laMT7M3IPvoMnxVgY8RcnKjziL
 s208SMScRoqUWP0BTXpkseP4ci8qV4kt48dVn7mWPRVQsQehnuSKc18YLV79KBnIKQDJNE
 g/YnkvKOgrfdL8Slv3nHy18bCaWNij0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-1uDDRAxWPw-SHzEhDdFyNQ-1; Tue,
 18 Feb 2025 13:20:38 -0500
X-MC-Unique: 1uDDRAxWPw-SHzEhDdFyNQ-1
X-Mimecast-MFC-AGG-ID: 1uDDRAxWPw-SHzEhDdFyNQ_1739902837
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB58D19030A5; Tue, 18 Feb 2025 18:20:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47AC1180034D; Tue, 18 Feb 2025 18:20:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 03/11] rust: Add some block layer bindings
Date: Tue, 18 Feb 2025 19:20:11 +0100
Message-ID: <20250218182019.111467-4-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/wrapper.h                | 4 ++++
 rust/qemu-api/src/zeroable.rs | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index f203fd13ac..303d7bba7f 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -54,3 +54,7 @@ typedef enum memory_order {
 #include "qapi/error.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
+#include "block/block.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+#include "qapi/qapi-visit-block-core.h"
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index bec5093366..4e1e54cf57 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -58,7 +58,6 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
-#[allow(unused)]
 #[macro_export]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
@@ -81,7 +80,6 @@ union TypeAsBytes {
 }
 
 /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
-#[allow(unused)]
 #[macro_export]
 macro_rules! impl_zeroable {
     ($type:ty) => {
@@ -111,3 +109,6 @@ fn default() -> Self {
     impl_zeroable!(crate::bindings::MemoryRegionOps);
     impl_zeroable!(crate::bindings::MemTxAttrs);
 }
+
+impl_zeroable!(crate::bindings::BlockDriver);
+impl_zeroable!(crate::bindings::BlockDriver__bindgen_ty_1);
-- 
2.48.1


