Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1D9ED3A2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 18:32:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVm-0008RV-Ub; Wed, 11 Dec 2024 12:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVe-0008BH-Sa
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVd-0001I5-Is
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dbk0iGQiY7GXvpl15dvjY7TjSGw5954t/S6EZF9IGYA=;
 b=HAkaYL2n6B2hJkFAsUnd2aE4jGVxtvaUzH9xh3pQvL1bhiPDlL5eQFO0qFrQnKNyTiONl/
 1jrqETaFAS5ijLtcMYvsIPnlzWWj/3Ic4ZsMCyE1wYHdM3+xnln1qMjweeUvniPKZlRFfS
 99WoMx7WxHThD4eympV7s8k6Giu7Amc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-fnB_8M3ZPPmesj-F2gDr1g-1; Wed,
 11 Dec 2024 12:28:21 -0500
X-MC-Unique: fnB_8M3ZPPmesj-F2gDr1g-1
X-Mimecast-MFC-AGG-ID: fnB_8M3ZPPmesj-F2gDr1g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E6BC1955D4E; Wed, 11 Dec 2024 17:28:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E47B1956048; Wed, 11 Dec 2024 17:28:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 31/31] tests/functional: ignore errors when caching assets,
 except for 404
Date: Wed, 11 Dec 2024 17:26:47 +0000
Message-ID: <20241211172648.2893097-32-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We see periodic errors caching assets due to a combination of transient
networking and server problems. With the previous patch to skip running
a test when it has missing assets, we can now treat most cache download
errors as non-fatal.

Only HTTP 404 is retained as fatal, since it is a strong indicator of
a fully broken test rather than a transient error.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 39832b2587..f0730695f0 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -15,6 +15,7 @@
 from time import sleep
 from pathlib import Path
 from shutil import copyfileobj
+from urllib.error import HTTPError
 
 
 # Instances of this class must be declared as class level variables
@@ -170,7 +171,18 @@ def precache_test(test):
         for name, asset in vars(test.__class__).items():
             if name.startswith("ASSET_") and type(asset) == Asset:
                 log.info("Attempting to cache '%s'" % asset)
-                asset.fetch()
+                try:
+                    asset.fetch()
+                except HTTPError as e:
+                    # Treat 404 as fatal, since it is highly likely to
+                    # indicate a broken test rather than a transient
+                    # server or networking problem
+                    if e.code == 404:
+                        raise
+
+                    log.debug(f"HTTP error {e.code} from {asset.url} " +
+                              "skipping asset precache")
+
         log.removeHandler(handler)
 
     def precache_suite(suite):
-- 
2.46.0


