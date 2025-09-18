Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21EAB3CC1A
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNFX-0006RI-7D; Sat, 30 Aug 2025 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwy9-0008TI-7b
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwy7-0001hh-Ls
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756465710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSdjMYWo+86VX8GX3Xm4s2LHLgpFxbBibOQ/p953Ays=;
 b=Akr8ZEoCf2B/mpFMQUAYEjc0x4PffkD6d1gcI9N4jNaR1xm/aa7k1CeFX7MMiewR49+D/k
 jJjsPr6cMtk3hHFPdxT8V3YQg0vRdTcX8NieElj+jCVUDxgWTjsAoiM6zOlO+in7zZiZvd
 n2+rRgUvY6rMOVDXfAduuHNLBF5yyxk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-6wZ0-10JN12Z8Tt9Cl6ZIQ-1; Fri,
 29 Aug 2025 07:08:26 -0400
X-MC-Unique: 6wZ0-10JN12Z8Tt9Cl6ZIQ-1
X-Mimecast-MFC-AGG-ID: 6wZ0-10JN12Z8Tt9Cl6ZIQ_1756465704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9342195E908; Fri, 29 Aug 2025 11:08:24 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2234730001B5; Fri, 29 Aug 2025 11:08:22 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/9] qga-vss: Replace asserts with condition and report error
Date: Fri, 29 Aug 2025 14:08:07 +0300
Message-ID: <20250829110813.50286-4-kkostiuk@redhat.com>
In-Reply-To: <20250829110813.50286-1-kkostiuk@redhat.com>
References: <20250829110813.50286-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250825145241.170717-2-kkostiuk@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 4401d55e3a..bc260abb96 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -347,7 +347,12 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         goto out;
     }
 
-    assert(pCreateVssBackupComponents != NULL);
+    if (!pCreateVssBackupComponents) {
+        err_set(errset, (HRESULT)ERROR_PROC_NOT_FOUND,
+                "CreateVssBackupComponents proc address absent. Did you call requester_init()?");
+        goto out;
+    }
+
     hr = pCreateVssBackupComponents(&vss_ctx.pVssbc);
     if (FAILED(hr)) {
         err_set(errset, hr, "failed to create VSS backup components");
@@ -579,8 +584,16 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
     /* Tell the provider that the snapshot is finished. */
     SetEvent(vss_ctx.hEventThaw);
 
-    assert(vss_ctx.pVssbc);
-    assert(vss_ctx.pAsyncSnapshot);
+    if (!vss_ctx.pVssbc) {
+        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
+                "CreateVssBackupComponents is missing. Did you freeze the volumes?");
+        return;
+    }
+    if (!vss_ctx.pAsyncSnapshot) {
+        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
+                "AsyncSnapshot set is missing. Did you freeze the volumes?");
+        return;
+    }
 
     HRESULT hr = WaitForAsync(vss_ctx.pAsyncSnapshot);
     switch (hr) {
-- 
2.50.1


