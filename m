Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E2714BD2
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dc3-0002Ct-4d; Mon, 29 May 2023 10:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q3dbu-0002CW-Lk
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q3dbs-0001md-8A
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685369550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0s8dZVcN+QaEMREYs2yDVB3nklRumXGYJlpyr0UixXY=;
 b=ggOic34u/jPaUZtMN1WjcgLgUjL1fvI99txzdegZIskfhUDGRGoB5MLeM5iD3wupeBmCi2
 fLe3lUNRh6eh0l50+d9RUYz22ruqN6bxiNZ4oyTEJmhhkY1xM1K2AQq82EdWsa6+ZPvQZS
 RBRpQ5osZdrebNQBZG6OrmG739ld3Ts=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663--gV-zy_MMN2iPkEYp4Sy2Q-1; Mon, 29 May 2023 10:12:29 -0400
X-MC-Unique: -gV-zy_MMN2iPkEYp4Sy2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F253C0C880
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C813C154D1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:12:28 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] meson: Avoid implicit declaration of functions
Date: Mon, 29 May 2023 16:12:26 +0200
Message-Id: <bc49e796220153190019f5010b8e090e09441158.1685369482.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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
present (into meson-log.txt), e.g.:

  qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
  warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]

We can check whether given function exists via
'cc.has_function()' or whether STATX_* macros exist via
'cc.has_header_symbol()'.

Resolves: https://bugs.gentoo.org/898810
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---

v2 of:

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07138.html

diff to v1:
- Drop cc.links() as it's redundant

 meson.build | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 2d48aa1e2e..21061b19d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1797,8 +1797,7 @@ malloc = []
 if get_option('malloc') == 'system'
   has_malloc_trim = \
     get_option('malloc_trim').allowed() and \
-    cc.links('''#include <malloc.h>
-                int main(void) { malloc_trim(0); return 0; }''')
+    cc.has_function('malloc_trim', prefix: '#include <malloc.h>')
 else
   has_malloc_trim = false
   malloc = cc.find_library(get_option('malloc'), required: true)
@@ -1811,34 +1810,19 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
-# Check whether the glibc provides statx()
-
 gnu_source_prefix = '''
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif
 '''
-statx_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
-  int main(void) {
-    struct statx statxbuf;
-    statx(0, "", 0, STATX_BASIC_STATS, &statxbuf);
-    return 0;
-  }'''
 
-has_statx = cc.links(statx_test)
+# Check whether the glibc provides STATX_BASIC_STATS
+
+has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_source_prefix)
 
 # Check whether statx() provides mount ID information
 
-statx_mnt_id_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
-  int main(void) {
-    struct statx statxbuf;
-    statx(0, "", 0, STATX_BASIC_STATS | STATX_MNT_ID, &statxbuf);
-    return statxbuf.stx_mnt_id;
-  }'''
-
-has_statx_mnt_id = cc.links(statx_mnt_id_test)
+has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
   .require(targetos == 'linux',
-- 
2.39.3


