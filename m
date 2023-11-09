Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC857E70BA
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:48:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r197u-0003YU-Dg; Thu, 09 Nov 2023 12:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r197s-0003YA-VI
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r197r-0005xF-CQ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699552050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgQIatA30Rx8gBQVH2FCDGHn510tnTxiAPrvHrnYkt8=;
 b=AhgL7QOGogi2yYqmzc8yg4C5BSl1z+T3Y8T0OnrgnKXX2RWv5SlpSArYuCbpeZTJYpKjHA
 bl3H7r+cBVeZm7NgFDPP6O+Yprgr3BeV6rhveQ113CZ71yInpXhPHF+Mv/7Ov8k2Dcbcnp
 FLUOdAKiSa31TDG21zQ1dIsjv5ybxYA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-OlRi5YHrOaCT_jnMPSTwOA-1; Thu,
 09 Nov 2023 12:47:23 -0500
X-MC-Unique: OlRi5YHrOaCT_jnMPSTwOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D452829AA3B1;
 Thu,  9 Nov 2023 17:47:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 852B31C060AE;
 Thu,  9 Nov 2023 17:47:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] tests/tsan: Rename the file with the entries that should be
 ignored
Date: Thu,  9 Nov 2023 18:47:20 +0100
Message-ID: <20231109174720.375873-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's use a better file name here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing.rst                     | 4 ++--
 tests/tsan/{blacklist.tsan => ignore.tsan} | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename tests/tsan/{blacklist.tsan => ignore.tsan} (57%)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index b0680cbb22..fef64accc1 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -668,11 +668,11 @@ suppressing it.  More information on the file format can be found here:
 
 https://github.com/google/sanitizers/wiki/ThreadSanitizerSuppressions
 
-tests/tsan/blacklist.tsan - Has TSan warnings we wish to disable
+tests/tsan/ignore.tsan - Has TSan warnings we wish to disable
 at compile time for test or debug.
 Add flags to configure to enable:
 
-"--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/blacklist.tsan"
+"--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/ignore.tsan"
 
 More information on the file format can be found here under "Blacklist Format":
 
diff --git a/tests/tsan/blacklist.tsan b/tests/tsan/ignore.tsan
similarity index 57%
rename from tests/tsan/blacklist.tsan
rename to tests/tsan/ignore.tsan
index 75e444f5dc..423e482d2f 100644
--- a/tests/tsan/blacklist.tsan
+++ b/tests/tsan/ignore.tsan
@@ -1,6 +1,6 @@
-# This is an example blacklist.
-# To enable use of the blacklist add this to configure:
-# "--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/blacklist.tsan"
+# This is an example ignore list.
+# To enable use of the ignore list add this to configure:
+# "--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/ignore.tsan"
 # The eventual goal would be to fix these warnings.
 
 # TSan is not happy about setting/getting of dirty bits,
-- 
2.41.0


