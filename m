Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E378FBA1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc19g-0001OJ-EV; Fri, 01 Sep 2023 06:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19W-0001LK-83
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19T-0001bq-Bt
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F35381E735;
 Fri,  1 Sep 2023 13:13:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 461152506D;
 Fri,  1 Sep 2023 13:13:04 +0300 (MSK)
Received: (nullmailer pid 3619008 invoked by uid 1000);
 Fri, 01 Sep 2023 10:13:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 8/8] util/async-teardown.c: move to softmmu/,
 only build it when system build is requested
Date: Fri,  1 Sep 2023 13:13:02 +0300
Message-Id: <20230901101302.3618955-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901101302.3618955-1-mjt@tls.msk.ru>
References: <20230901101302.3618955-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 {util => softmmu}/async-teardown.c | 0
 softmmu/meson.build                | 1 +
 util/meson.build                   | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {util => softmmu}/async-teardown.c (100%)

diff --git a/util/async-teardown.c b/softmmu/async-teardown.c
similarity index 100%
rename from util/async-teardown.c
rename to softmmu/async-teardown.c
diff --git a/softmmu/meson.build b/softmmu/meson.build
index ea5603f021..c18b7ad738 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -37,3 +37,4 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: fdt, if_true: files('device_tree.c'))
+system_ss.add(when: 'CONFIG_LINUX', if_true: files('async-teardown.c'))
diff --git a/util/meson.build b/util/meson.build
index a375160286..c4827fd70a 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,7 +3,6 @@ util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
 endif
-util_ss.add(when: 'CONFIG_LINUX', if_true: files('async-teardown.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
 if config_host_data.get('CONFIG_EPOLL_CREATE1')
-- 
2.39.2


