Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4448C7919CB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhO-0002Cy-Lb; Mon, 04 Sep 2023 10:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhL-000281-9j
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhG-0001jf-8J
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:03 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-nfqoTtuOOUGTWVKOMLUz5w-1; Mon, 04 Sep 2023 10:36:56 -0400
X-MC-Unique: nfqoTtuOOUGTWVKOMLUz5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E605C29DD98A;
 Mon,  4 Sep 2023 14:36:55 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 554E0400F54;
 Mon,  4 Sep 2023 14:36:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/14] qemu-img: Update documentation for compressed images
Date: Mon,  4 Sep 2023 16:36:37 +0200
Message-ID: <20230904143643.259916-9-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Document the 'compression_type' option for qcow2, and mention that
streamOptimized vmdk supports compression, too.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230901102430.23856-1-kwolf@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 15aeddc6d8..ca5a2773cf 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -106,7 +106,11 @@ by the used format or see the format descriptions below for details.
 
 .. option:: -c
 
-  Indicates that target image must be compressed (qcow format only).
+  Indicates that target image must be compressed (qcow/qcow2 and vmdk with
+  streamOptimized subformat only).
+
+  For qcow2, the compression algorithm can be specified with the ``-o
+  compression_type=...`` option (see below).
 
 .. option:: -h
 
@@ -776,7 +780,7 @@ Supported image file formats:
 
   QEMU image format, the most versatile format. Use it to have smaller
   images (useful if your filesystem does not supports holes, for example
-  on Windows), optional AES encryption, zlib based compression and
+  on Windows), optional AES encryption, zlib or zstd based compression and
   support of multiple VM snapshots.
 
   Supported options:
@@ -794,6 +798,17 @@ Supported image file formats:
   ``backing_fmt``
     Image format of the base image
 
+  ``compression_type``
+    This option configures which compression algorithm will be used for
+    compressed clusters on the image. Note that setting this option doesn't yet
+    cause the image to actually receive compressed writes. It is most commonly
+    used with the ``-c`` option of ``qemu-img convert``, but can also be used
+    with the ``compress`` filter driver or backup block jobs with compression
+    enabled.
+
+    Valid values are ``zlib`` and ``zstd``. For images that use
+    ``compat=0.10``, only ``zlib`` compression is available.
+
   ``encryption``
     If this option is set to ``on``, the image is encrypted with
     128-bit AES-CBC.
-- 
2.41.0


