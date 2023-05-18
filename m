Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F731708685
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhBx-0006VC-5f; Thu, 18 May 2023 13:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBu-0006TY-Oe
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBs-0000ff-TD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684430002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbUmN4Np0k7C5S0QmRLCXNeqruKAcVx4r+KXz18Q3AY=;
 b=NJwxTrOx6b6y6X7cyOL58fbSuOyf94r9ip0ZemfPCoT8o/RtaDtbsBcSCG7sGOB6ADO+uy
 ipNDDXGwsb735MM8CCtSFjTdU2gOsqp6v4sAFXGN1aYVaGNNeH4pXPFW2QLxsuFMOtkMfT
 cs51A76Wv4+8m2m+/8DdI8Pj6/Rwizo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573--stvgVC8MDmKQRKJUrlVrg-1; Thu, 18 May 2023 13:13:18 -0400
X-MC-Unique: -stvgVC8MDmKQRKJUrlVrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11B701C04321;
 Thu, 18 May 2023 17:13:17 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CEB940C6EC4;
 Thu, 18 May 2023 17:13:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>
Subject: [PULL 01/12] configure: add --disable-colo-proxy option
Date: Thu, 18 May 2023 19:12:53 +0200
Message-Id: <20230518171304.95006-2-quintela@redhat.com>
In-Reply-To: <20230518171304.95006-1-quintela@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add option to not build filter-rewriter and colo-compare when
they are not needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20230515130640.46035-2-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 stubs/colo-compare.c          |  7 +++++++
 meson_options.txt             |  2 ++
 net/meson.build               | 13 ++++++++++---
 scripts/meson-buildoptions.sh |  3 +++
 stubs/meson.build             |  1 +
 5 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 stubs/colo-compare.c

diff --git a/stubs/colo-compare.c b/stubs/colo-compare.c
new file mode 100644
index 0000000000..ec726665be
--- /dev/null
+++ b/stubs/colo-compare.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "qemu/notify.h"
+#include "net/colo-compare.h"
+
+void colo_compare_cleanup(void)
+{
+}
diff --git a/meson_options.txt b/meson_options.txt
index 11aec2a441..d1b6738c1b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -293,6 +293,8 @@ option('live_block_migration', type: 'feature', value: 'auto',
        description: 'block migration in the main migration stream')
 option('replication', type: 'feature', value: 'auto',
        description: 'replication support')
+option('colo_proxy', type: 'feature', value: 'auto',
+       description: 'colo-proxy support')
 option('bochs', type: 'feature', value: 'auto',
        description: 'bochs image format support')
 option('cloop', type: 'feature', value: 'auto',
diff --git a/net/meson.build b/net/meson.build
index 87afca3e93..6f4ecde57f 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -1,13 +1,10 @@
 softmmu_ss.add(files(
   'announce.c',
   'checksum.c',
-  'colo-compare.c',
-  'colo.c',
   'dump.c',
   'eth.c',
   'filter-buffer.c',
   'filter-mirror.c',
-  'filter-rewriter.c',
   'filter.c',
   'hub.c',
   'net-hmp-cmds.c',
@@ -19,6 +16,16 @@ softmmu_ss.add(files(
   'util.c',
 ))
 
+if get_option('replication').allowed() or \
+    get_option('colo_proxy').allowed()
+  softmmu_ss.add(files('colo-compare.c'))
+  softmmu_ss.add(files('colo.c'))
+endif
+
+if get_option('colo_proxy').allowed()
+  softmmu_ss.add(files('filter-rewriter.c'))
+endif
+
 softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('filter-replay.c'))
 
 if have_l2tpv3
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 52fb079a60..a66eb31dae 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -86,6 +86,7 @@ meson_options_help() {
   printf "%s\n" '  capstone        Whether and how to find the capstone library'
   printf "%s\n" '  cloop           cloop image format support'
   printf "%s\n" '  cocoa           Cocoa user interface (macOS only)'
+  printf "%s\n" '  colo-proxy      colo-proxy support'
   printf "%s\n" '  coreaudio       CoreAudio sound support'
   printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
   printf "%s\n" '  curl            CURL block device driver'
@@ -245,6 +246,8 @@ _meson_option_parse() {
     --disable-cloop) printf "%s" -Dcloop=disabled ;;
     --enable-cocoa) printf "%s" -Dcocoa=enabled ;;
     --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
+    --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
+    --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
     --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
     --enable-coroutine-pool) printf "%s" -Dcoroutine_pool=true ;;
diff --git a/stubs/meson.build b/stubs/meson.build
index 8412cad15f..a56645e2f7 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -46,6 +46,7 @@ stub_ss.add(files('target-monitor-defs.c'))
 stub_ss.add(files('trace-control.c'))
 stub_ss.add(files('uuid.c'))
 stub_ss.add(files('colo.c'))
+stub_ss.add(files('colo-compare.c'))
 stub_ss.add(files('vmstate.c'))
 stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
-- 
2.40.1


