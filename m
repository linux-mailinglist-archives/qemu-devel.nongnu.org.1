Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660F971C47
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 16:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfCU-0007to-SL; Mon, 09 Sep 2024 10:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCS-0007oS-KV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCM-0003HL-RF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHge9MB3dqWUcYgb0KJrksuENWfix4LIAEKGj69pBVM=;
 b=Oxu6g4s3os746FuS9kcGlXvCZUeXPnXkDgmK3JVlKrg3XkKBsrNXy8O05mz+zoqclC77Dn
 +sbBZRWtJn5h9yWUsFds2HkqN4RAI9O85Cx2uNGHdnH1rJsjrU6p1QTsM8cUaw3ZJGJtnt
 QFMWFqDtaN3EqSSz+gSnidjvvB9lCOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-FJZMl-bkPs2mGh1p-0zCLw-1; Mon,
 09 Sep 2024 10:16:54 -0400
X-MC-Unique: FJZMl-bkPs2mGh1p-0zCLw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09051955DD2; Mon,  9 Sep 2024 14:16:51 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 317611956054; Mon,  9 Sep 2024 14:16:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/10] iotests: fix expected output from gnutls
Date: Mon,  9 Sep 2024 15:16:26 +0100
Message-ID: <20240909141635.1459701-2-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Error reporting from gnutls was improved by:

  commit 57941c9c86357a6a642f9ee3279d881df4043b6d
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Fri Mar 15 14:07:58 2024 +0000

    crypto: push error reporting into TLS session I/O APIs

This has the effect of changing the output from one of the NBD
tests.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/233.out | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 1910f7df20..d498d55e0e 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -69,8 +69,8 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == check TLS with authorization ==
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
-qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort
+qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option reply: Cannot read from TLS channel: The TLS connection was non-properly terminated.
 
 == check TLS fail over UNIX with no hostname ==
 qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': No hostname for certificate validation
@@ -103,14 +103,14 @@ qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0'
 qemu-nbd: TLS handshake failed: The TLS connection was non-properly terminated.
 
 == final server log ==
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
 qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
 qemu-nbd: option negotiation failed: TLS x509 authz check for DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read from TLS channel: The TLS connection was non-properly terminated.
 qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 qemu-nbd: option negotiation failed: TLS handshake failed: An illegal parameter has been received.
 *** done
-- 
2.45.2


