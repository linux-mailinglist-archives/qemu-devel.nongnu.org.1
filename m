Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23818BF1C53
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Oct 2025 16:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqdN-0004SC-9F; Mon, 20 Oct 2025 10:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqd5-0004Om-1U
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqcz-0007L9-6M
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760969567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxLE1DkwIX2gmEDG0+NGb7STB3ydJHOzEc424XDCMtw=;
 b=SHrBQmyH+ppde9iLah5rUHVQqNhj6kbErtmccoDrq2j7TeIkermDeUR5xv1EDWvSZ4oEde
 J7Gx1NFcDNWiKwqSvK+P/PyclpMIW4A0V0e6JSX8GfoGxqTxx5tk6f/NcoQO4EQNXvUjhE
 27Ewx5wJrIK1k/LqfHNjfmg5Yo2C0UI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-0Z779hikO1eVpYvsB5u7eg-1; Mon,
 20 Oct 2025 10:12:46 -0400
X-MC-Unique: 0Z779hikO1eVpYvsB5u7eg-1
X-Mimecast-MFC-AGG-ID: 0Z779hikO1eVpYvsB5u7eg_1760969565
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063F41801BFB
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 14:12:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12F541800451; Mon, 20 Oct 2025 14:12:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 3/7] crypto: validate an error is reported in test expected
 fails
Date: Mon, 20 Oct 2025 15:12:33 +0100
Message-ID: <20251020141237.2621796-4-berrange@redhat.com>
In-Reply-To: <20251020141237.2621796-1-berrange@redhat.com>
References: <20251020141237.2621796-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There was a bug where TLS x509 credentials validation failed
to fill out the Error object. Validate this in the failure
scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-tlscredsx509.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index a7ea5f422d..85f51aee1b 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -73,6 +73,7 @@ static void test_tls_creds(const void *opaque)
     struct QCryptoTLSCredsTestData *data =
         (struct QCryptoTLSCredsTestData *)opaque;
     QCryptoTLSCreds *creds;
+    Error *err = NULL;
 
 #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
     g_mkdir_with_parents(CERT_DIR, 0700);
@@ -111,10 +112,12 @@ static void test_tls_creds(const void *opaque)
          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER :
          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT),
         CERT_DIR,
-        data->expectFail ? NULL : &error_abort);
+        data->expectFail ? &err : &error_abort);
 
     if (data->expectFail) {
         g_assert(creds == NULL);
+        g_assert(err != NULL);
+        error_free(err);
     } else {
         g_assert(creds != NULL);
     }
-- 
2.50.1


