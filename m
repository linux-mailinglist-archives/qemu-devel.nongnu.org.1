Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B478F336
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnAz-0000Gb-Uu; Thu, 31 Aug 2023 15:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAj-00006Y-5C
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAg-0001zI-V7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693509458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7CMVoyE7yLjf7KDSxm6tVnuJMS64Nf0+CSsGrA672Q=;
 b=cjxfzI6gR6B7wFUxHVivHk/c7qpAkkI7OpAQmh3gCZF+iOY7rfkuiU91dxJ2NcfqTlk9aN
 Wt4NJpjjrq/Rf3EiDoyii0kAQ3LXPrOCsUg1yPagGg/xPHXf+jiDKMlbsdxJY4ao2KZeKH
 h6As/7GGd7MFqCWutMvLap1BTpVt/VY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-5yonw1GJOCmwuBDjg2vPqw-1; Thu, 31 Aug 2023 15:17:35 -0400
X-MC-Unique: 5yonw1GJOCmwuBDjg2vPqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C528C101A53C;
 Thu, 31 Aug 2023 19:17:34 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86DA663F78;
 Thu, 31 Aug 2023 19:17:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/7] meson: test for CONFIG_TCG in config_all
Date: Thu, 31 Aug 2023 21:17:19 +0200
Message-Id: <20230831191719.140001-8-thuth@redhat.com>
In-Reply-To: <20230831191719.140001-1-thuth@redhat.com>
References: <20230831191719.140001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Paolo Bonzini <pbonzini@redhat.com>

CONFIG_TCG is not included in *-config-devices.h, so the test is
always failing.

Fixes: 74884cb1a6d ("qtest/meson.build: check CONFIG_TCG for boot-serial-test in qtests_ppc", 2022-03-14)
Fixes: 44d827ea69e ("qtest/meson.build: check CONFIG_TCG for prom-env-test in qtests_ppc", 2022-03-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20230830095347.132485-1-pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b071d400b3..3afe9e9ee3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -155,8 +155,8 @@ qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                      \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                   \
+  (config_all.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
+  (config_all.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
 
 qtests_ppc64 = \
-- 
2.39.3


