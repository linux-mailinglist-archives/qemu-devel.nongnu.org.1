Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7071EF0C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lDE-0002Yf-IO; Thu, 01 Jun 2023 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lDB-0002YA-72
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lD9-0007IS-Lm
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685637098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23vcARQxIY7gh1NYVRtuGbogmRD03bZ7QlD5l2q1H+U=;
 b=D7pP4orsVSKHuL6D6jHuKvvENNjRShUs6PHqJxFHqU2Wmx/JcQXzhh8ORAbvk9n2Zjk/Kz
 rG6wwSvHHbLVyZ+ebreg/sBSAWPz8BqJjp2uW6eA0PfTt/oY/aBB1YVtzN6t3pBDGPI5x5
 T05nfj6+iIFUR7XOGb1lPOmh0a2RLeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-rK08IfCONKKFfKcn6WNWMQ-1; Thu, 01 Jun 2023 12:31:37 -0400
X-MC-Unique: rK08IfCONKKFfKcn6WNWMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B50688582BE;
 Thu,  1 Jun 2023 16:31:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A452D2166B28;
 Thu,  1 Jun 2023 16:31:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] mtest2make: stop disabling meson test timeouts
Date: Thu,  1 Jun 2023 17:31:23 +0100
Message-Id: <20230601163123.1805282-7-berrange@redhat.com>
In-Reply-To: <20230601163123.1805282-1-berrange@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The mtest2make.py script passes the arg '-t 0' to 'meson test' which
disables all test timeouts. This is a major source of pain when running
in GitLab CI and a test gets stuck. It will stall until GitLab kills the
CI job. This leaves us with little easily consumable information about
the stalled test. The TAP format doesn't show the test name until it is
completed, and TAP output from multiple tests it interleaved. So we
have to analyse the log to figure out what tests had un-finished TAP
output present and thus infer which test case caused the hang. This is
very time consuming and error prone.

By allowing meson to kill stalled tests, we get a direct display of what
test program got stuck, which lets us more directly focus in on what
specific test case within the test program hung.

The other issue with disabling meson test timeouts by default is that it
makes it more likely that maintainers inadvertantly introduce slowdowns.
For example the recent-ish change that accidentally made migrate-test
take 15-20 minutes instead of around 1 minute.

The main risk of this change is that the individual test timeouts might
be too short to allow completion in high load scenarios. Thus, there is
likely to be some short term pain where we have to bump the timeouts for
certain tests to make them reliable enough. The preceeding few patches
raised the timeouts for all failures that were immediately apparent
in GitLab CI.

Even with the possible short term instability, this should still be a
net win for debuggability of failed CI pipelines over the long term.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/mtest2make.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 179dd54871..eb01a05ddb 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -27,7 +27,8 @@ def names(self, base):
 .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
 .speed.thorough = $(foreach s,$(sort $1), --suite $s)
 
-.mtestargs = --no-rebuild -t 0
+TIMEOUT_MULTIPLIER = 1
+.mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
 ifneq ($(SPEED), quick)
 .mtestargs += --setup $(SPEED)
 endif
-- 
2.40.1


