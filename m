Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4FEC20BC6
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 15:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyc-0000tG-Ih; Thu, 30 Oct 2025 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyW-0000lS-Fm
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyK-0001Pj-KS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=km7AsvS0Hy+p+cOLwUHk2GTaBgkLMSAGv7etznpKIRw=;
 b=H2kWXcHBhwHcqandy2/doPzq9E4bZlMWRphT5/zkFGcJ1r+b1I1p8i3Ab1fmSN6By5qeSy
 R5Ggq1HQ6xLDzhIxqHaaN2sey23f7mj8voECW5a8oiYpeY9ZnyvGjvGb99zi4fhQ1Oz5rT
 ccMvp5CjlrrfRKfXT2A7eK5nPhjkTUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-zDVRx_NEO3KUE1ILHvplpg-1; Thu,
 30 Oct 2025 10:49:40 -0400
X-MC-Unique: zDVRx_NEO3KUE1ILHvplpg-1
X-Mimecast-MFC-AGG-ID: zDVRx_NEO3KUE1ILHvplpg_1761835779
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 877D61809C9F; Thu, 30 Oct 2025 14:49:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36C9E30001A6; Thu, 30 Oct 2025 14:49:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 05/21] crypto: move check for TLS creds 'dir' property
Date: Thu, 30 Oct 2025 14:49:11 +0000
Message-ID: <20251030144927.2241109-6-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The check for the 'dir' property is being repeated for every
credential file to be loaded, but this results in incorrect
logic for optional credentials. The 'dir' property is mandatory
for PSK and x509 creds, even if some individual files are
optional. Address this by separating the check for the 'dir'
property.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c     | 9 ---------
 crypto/tlscredsanon.c | 3 ++-
 crypto/tlscredspsk.c  | 5 +++++
 crypto/tlscredsx509.c | 8 ++++++--
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 208a7e6d8f..65e97ddd11 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -102,15 +102,6 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
 {
     int ret = -1;
 
-    if (!creds->dir) {
-        if (required) {
-            error_setg(errp, "Missing 'dir' property value");
-            return -1;
-        } else {
-            return 0;
-        }
-    }
-
     *cred = g_strdup_printf("%s/%s", creds->dir, filename);
 
     if (access(*cred, R_OK) < 0) {
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 44af9e6c9a..bc3351b5d6 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -43,7 +43,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
             creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
 
     if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+        if (creds->parent_obj.dir &&
+            qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             return -1;
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 5b68a6b7ba..545d3e45db 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -81,6 +81,11 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
     trace_qcrypto_tls_creds_psk_load(creds,
             creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
 
+    if (!creds->parent_obj.dir) {
+        error_setg(errp, "Missing 'dir' property value");
+        goto cleanup;
+    }
+
     if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
         if (creds->username) {
             error_setg(errp, "username should not be set when endpoint=server");
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 0acb17b6ec..8fe6cc8e93 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -567,8 +567,12 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     int ret;
     int rv = -1;
 
-    trace_qcrypto_tls_creds_x509_load(creds,
-            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+    if (!creds->parent_obj.dir) {
+        error_setg(errp, "Missing 'dir' property value");
+        return -1;
+    }
+
+    trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
 
     if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-- 
2.51.1


