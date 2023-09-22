Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C107AB587
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjigE-0001Ua-4Z; Fri, 22 Sep 2023 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjig7-0001Ap-Hu
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjig5-00088f-UU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695398808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24WuyQ1scz0PFBfqnH8zGPOT+2di+fXBWZSPsO4PP44=;
 b=XXcjSNGGPp0wXghuSCWjT/VMdxXaKZl3RLBmkIpoPtGUcyhl+JkHrNUD4kKl8XJumvKYc0
 zlgLDfCc3566aov1IrfNHNJiCmh5LJFMLYa38XRBE6D1l/CV7Wb3lb1VyOLtTEMfildaJD
 p5tFhRoCkUIsc4HKYD2DmlraM7YVS7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-__O4IgC3NJKimjbOK9Qkuw-1; Fri, 22 Sep 2023 12:06:47 -0400
X-MC-Unique: __O4IgC3NJKimjbOK9Qkuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEF7E8030CB
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 16:06:46 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E27C40C2064;
 Fri, 22 Sep 2023 16:06:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] crypto: remove shadowed 'ret' variable
Date: Fri, 22 Sep 2023 17:06:43 +0100
Message-ID: <20230922160644.438631-2-berrange@redhat.com>
In-Reply-To: <20230922160644.438631-1-berrange@redhat.com>
References: <20230922160644.438631-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Both instances of 'ret' are used to store a gnutls API return code.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tls-cipher-suites.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index 5e4f597464..d0df4badc0 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -52,7 +52,6 @@ GByteArray *qcrypto_tls_cipher_suites_get_data(QCryptoTLSCipherSuites *obj,
     byte_array = g_byte_array_new();
 
     for (i = 0;; i++) {
-        int ret;
         unsigned idx;
         const char *name;
         IANA_TLS_CIPHER cipher;
-- 
2.41.0


