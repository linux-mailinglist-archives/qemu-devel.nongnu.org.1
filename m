Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F867B0564F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 11:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbzD-00078p-7L; Tue, 15 Jul 2025 05:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbyr-000753-5t
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbyp-0005Lw-Cg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752571781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZbQcqkzC95PosnA+9tXXdAp2209sgx0D/zHqejOogw=;
 b=ZyXfDpNRbsDugP/urgLFOg6yrtX1ThnvOV8sF8QaDNEGDR/WJXT+v6rsiYG//YQ7mZqAZM
 2dl6yK/13euh6h+yNaWFMSPVCZYbt7Im/hvgcAdkt+UTl6WmPVbFzJBd9ZyLCsIiIxIZnv
 EGvha5BE0QyCP7ldnDv7n5NG5KjzULk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-HvyeK-GYPo6nFM3_bL0zRQ-1; Tue,
 15 Jul 2025 05:29:40 -0400
X-MC-Unique: HvyeK-GYPo6nFM3_bL0zRQ-1
X-Mimecast-MFC-AGG-ID: HvyeK-GYPo6nFM3_bL0zRQ_1752571779
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48F4218001D6
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:29:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E1BA1977029; Tue, 15 Jul 2025 09:29:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/7] crypto: switch to newer gnutls API for distinguished name
Date: Tue, 15 Jul 2025 10:29:27 +0100
Message-ID: <20250715092932.1395271-3-berrange@redhat.com>
In-Reply-To: <20250715092932.1395271-1-berrange@redhat.com>
References: <20250715092932.1395271-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The new API automatically allocates the right amount of memory
to hold the distinguished name, avoiding the need to loop and
realloc.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 6d8f8df623..5034776922 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -373,20 +373,14 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
         }
 
         if (i == 0) {
-            size_t dnameSize = 1024;
-            session->peername = g_malloc(dnameSize);
-        requery:
-            ret = gnutls_x509_crt_get_dn(cert, session->peername, &dnameSize);
+            gnutls_datum_t dname = {};
+            ret = gnutls_x509_crt_get_dn2(cert, &dname);
             if (ret < 0) {
-                if (ret == GNUTLS_E_SHORT_MEMORY_BUFFER) {
-                    session->peername = g_realloc(session->peername,
-                                                  dnameSize);
-                    goto requery;
-                }
                 error_setg(errp, "Cannot get client distinguished name: %s",
                            gnutls_strerror(ret));
                 goto error;
             }
+            session->peername = (char *)g_steal_pointer(&dname.data);
             if (session->authzid) {
                 bool allow;
 
-- 
2.49.0


