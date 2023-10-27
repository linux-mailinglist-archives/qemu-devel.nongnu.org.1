Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DA7D93EA
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:38:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHS-0002NL-AQ; Fri, 27 Oct 2023 05:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHP-0002M6-EL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHO-0002kb-1p
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfKV4Wmcj2IFfSf8qrmIR+on92b5inTdWwqBINKhRi4=;
 b=U3o6k2t5X18yPcDJWF1Lqjv0hLpCZkO0dKRXpAUxLEtJAe9nRQPefdFi73dTSnmUsPDSfU
 qI8xPv1FMDBoQQsSiwW5qWWcCzbEV0Zq6wItJLepBQ36bGbBe56h9ff0s5bZ6VWqOkeMxb
 4sLPZrI5+rxQZKMjzCLT0R1j+Nsn9uI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-mTI2C3GKNiGZV6axrg7HYQ-1; Fri,
 27 Oct 2023 05:37:17 -0400
X-MC-Unique: mTI2C3GKNiGZV6axrg7HYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D2B23C0E645;
 Fri, 27 Oct 2023 09:37:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C121121319;
 Fri, 27 Oct 2023 09:37:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 04/11] tests/cdrom-test: Clean up global variable shadowing in
 prepare_image()
Date: Fri, 27 Oct 2023 11:37:03 +0200
Message-ID: <20231027093710.273558-5-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename the variable to fix:

  tests/qtest/cdrom-test.c:40:50: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static int prepare_image(const char *arch, char *isoimage)
                                                   ^
  tests/qtest/cdrom-test.c:18:13: note: previous declaration is here
  static char isoimage[] = "cdrom-boot-iso-XXXXXX";
              ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-ID: <20231009100251.56019-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index f2a8d91929..0945383789 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -37,17 +37,17 @@ static int exec_xorrisofs(const char **args)
     return exit_status;
 }
 
-static int prepare_image(const char *arch, char *isoimage)
+static int prepare_image(const char *arch, char *isoimagepath)
 {
     char srcdir[] = "cdrom-test-dir-XXXXXX";
     char *codefile = NULL;
     int ifh, ret = -1;
     const char *args[] = {
         "xorrisofs", "-quiet", "-l", "-no-emul-boot",
-        "-b", NULL, "-o", isoimage, srcdir, NULL
+        "-b", NULL, "-o", isoimagepath, srcdir, NULL
     };
 
-    ifh = mkstemp(isoimage);
+    ifh = mkstemp(isoimagepath);
     if (ifh < 0) {
         perror("Error creating temporary iso image file");
         return -1;
-- 
2.41.0


