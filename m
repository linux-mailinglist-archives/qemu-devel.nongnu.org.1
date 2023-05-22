Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4370BC6A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144L-0005hR-GD; Mon, 22 May 2023 07:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143m-0005GC-15
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143k-0007cz-EI
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf9D44r/0HhU06/EUF5GhbYgULRU1H7EmFZrtEZn/1c=;
 b=F5FNrVR6X4L2QL0kJKfVVU/5Fb9BSxtoInDD499/3GfbVZLCJFMeQ+a7ffn4do84RsTXKz
 woSSCVoMkLhQI3mD/xnXvWIn25f1qKg7G5rwCpC9+N6pKkKBv953/BlWgLmC7tn60t+i/I
 NyXg51OdfgtvnBwgrPnsjM7UQJkTh3o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-V-F5jp47OxS77R4P_SS0fw-1; Mon, 22 May 2023 07:50:35 -0400
X-MC-Unique: V-F5jp47OxS77R4P_SS0fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 202B1381D1E4;
 Mon, 22 May 2023 11:50:35 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA992166B26;
 Mon, 22 May 2023 11:50:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/20] tests/qtest/meson.build: Run the net filter tests only
 with default devices
Date: Mon, 22 May 2023 13:50:10 +0200
Message-Id: <20230522115014.1110840-17-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These tests rely on a default NIC to be available. Skip them if we
used the "--without-default-devices" configure option.

Message-Id: <20230512124033.502654-17-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ab422772d3..4c5585ac0f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -34,10 +34,12 @@ qtests_pci = \
 qtests_cxl = \
   (config_all_devices.has_key('CONFIG_CXL') ? ['cxl-test'] : [])
 
+# FIXME: Get rid of get_option('default_devices') here and check
+#        for the availability of the default NICs in the tests
 qtests_filter = \
-  (slirp.found() ? ['test-netfilter'] : []) + \
-  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) + \
-  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : [])
+  (get_option('default_devices') and slirp.found() ? ['test-netfilter'] : []) + \
+  (get_option('default_devices') and config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) + \
+  (get_option('default_devices') and config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : [])
 
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
@@ -221,9 +223,7 @@ qtests_aarch64 = \
    'migration-test']
 
 qtests_s390x = \
-  (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +                 \
-  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                         \
-  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : []) +                     \
+  qtests_filter + \
   ['boot-serial-test',
    'drive_del-test',
    'device-plug-test',
-- 
2.31.1


