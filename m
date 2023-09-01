Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5778FD51
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3KI-0006P3-AI; Fri, 01 Sep 2023 08:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc3KG-0006Og-25
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc3KC-0000uc-KA
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693571551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4qjcwZML5WNcqa2TqT8DipTZtsUBetYmXXLYlwc2OtE=;
 b=ga0KkUA27VyuyoHxhIzlGqOyqGJUTpJgEBMqPQiTU1iiS43KaWdOzprO2FnH3UmU6N0wRM
 oQUdFJyyeR53+Vs+AAIt3SmgyXeJNn4du0VbTm0hP7Fr5bVGIMwKuqiPJMow92IgazeOI+
 Rfzt7XqJ9XyHPC/ftAomqJBoreLnYsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-Nu1OyHSkM_GVPAdt1G6xtw-1; Fri, 01 Sep 2023 08:32:27 -0400
X-MC-Unique: Nu1OyHSkM_GVPAdt1G6xtw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9302810264F3;
 Fri,  1 Sep 2023 12:32:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40F7C493110;
 Fri,  1 Sep 2023 12:32:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BA0221E692A; Fri,  1 Sep 2023 14:32:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: helei.sig11@bytedance.com,
	pizhenwei@bytedance.com,
	berrange@redhat.com
Subject: [PATCH] crypto/rsakey-builtin.c.inc: Clean up two error paths
Date: Fri,  1 Sep 2023 14:32:26 +0200
Message-ID: <20230901123226.3656164-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When qcrypto_builtin_rsa_public_key_parse() is about to fail, but no
error has been set, it makes one up.  Actually, there's just one way
to fail without setting an error.  Set it there instead.

Same for qcrypto_builtin_rsa_private_key_parse().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/rsakey-builtin.c.inc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/crypto/rsakey-builtin.c.inc b/crypto/rsakey-builtin.c.inc
index aeeacc8f9b..46cc7afe87 100644
--- a/crypto/rsakey-builtin.c.inc
+++ b/crypto/rsakey-builtin.c.inc
@@ -88,15 +88,13 @@ static QCryptoAkCipherRSAKey *qcrypto_builtin_rsa_public_key_parse(
         goto error;
     }
     if (seq_length != 0) {
+        error_setg(errp, "Invalid RSA public key");
         goto error;
     }
 
     return rsa;
 
 error:
-    if (errp && !*errp) {
-        error_setg(errp, "Invalid RSA public key");
-    }
     qcrypto_akcipher_rsakey_free(rsa);
     return NULL;
 }
@@ -169,15 +167,13 @@ static QCryptoAkCipherRSAKey *qcrypto_builtin_rsa_private_key_parse(
         return rsa;
     }
     if (seq_length != 0) {
+        error_setg(errp, "Invalid RSA private key");
         goto error;
     }
 
     return rsa;
 
 error:
-    if (errp && !*errp) {
-        error_setg(errp, "Invalid RSA private key");
-    }
     qcrypto_akcipher_rsakey_free(rsa);
     return NULL;
 }
-- 
2.41.0


