Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDA7145D1
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Xlc-00061J-GI; Mon, 29 May 2023 03:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q3XlW-00060A-R8
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q3XlS-0007dP-Li
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685347081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gk+sv2pHZFnfF0Prbho9iJRfFqLopKW6rALAmj31RcI=;
 b=SzO7/m7Pe042LZH+LjwclcQGUooadiHBwacbo6igrHElXzOtnP4CKw3+uFwtEJZeanPqXF
 T8d5e+rE9KofBcm6WaDnqDziXFfy6FlrSQe2/3iJXCAmnVDc0KOC3wcDZmc8S6JNyCrvsy
 NVHaqe0MO5BIOd1fx0XE4XGPltFIOFM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-0YVk_lTsNgWR7b9Rfa0pbA-1; Mon, 29 May 2023 03:56:32 -0400
X-MC-Unique: 0YVk_lTsNgWR7b9Rfa0pbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BBB1185A78B
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA1BB492B00
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 07:56:31 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Avoid implicit declaration of functions
Date: Mon, 29 May 2023 09:56:26 +0200
Message-Id: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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

While detecting a presence of a function via 'cc.links()'
gives desired result (i.e. detects whether function is present),
it also produces a warning on systems where the function is not
present, e.g.:

  qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
  warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]

We can check whether given function exists via
'cc.has_function()' firstly.

Resolves: https://bugs.gentoo.org/898810
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 meson.build | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 2d48aa1e2e..5da4dbac24 100644
--- a/meson.build
+++ b/meson.build
@@ -1797,6 +1797,7 @@ malloc = []
 if get_option('malloc') == 'system'
   has_malloc_trim = \
     get_option('malloc_trim').allowed() and \
+    cc.has_function('malloc_trim', prefix: '#include <malloc.h>') and \
     cc.links('''#include <malloc.h>
                 int main(void) { malloc_trim(0); return 0; }''')
 else
@@ -1818,27 +1819,29 @@ gnu_source_prefix = '''
   #define _GNU_SOURCE
   #endif
 '''
-statx_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
+statx_prefix = gnu_source_prefix + '''
+  #include<sys/stat.h>
+'''
+statx_test = statx_prefix + '''
   int main(void) {
     struct statx statxbuf;
     statx(0, "", 0, STATX_BASIC_STATS, &statxbuf);
     return 0;
   }'''
 
-has_statx = cc.links(statx_test)
+has_statx = cc.has_function('statx', prefix: statx_prefix) and \
+    cc.links(statx_test)
 
 # Check whether statx() provides mount ID information
 
-statx_mnt_id_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
+statx_mnt_id_test = statx_prefix + '''
   int main(void) {
     struct statx statxbuf;
     statx(0, "", 0, STATX_BASIC_STATS | STATX_MNT_ID, &statxbuf);
     return statxbuf.stx_mnt_id;
   }'''
 
-has_statx_mnt_id = cc.links(statx_mnt_id_test)
+has_statx_mnt_id = has_statx and cc.links(statx_mnt_id_test)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
   .require(targetos == 'linux',
-- 
2.39.3


