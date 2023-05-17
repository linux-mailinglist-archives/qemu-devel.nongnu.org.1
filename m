Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB2706230
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6f-0002eI-K3; Wed, 17 May 2023 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6P-00023t-3W; Wed, 17 May 2023 04:01:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6L-0000b6-B9; Wed, 17 May 2023 04:01:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FFF8675D;
 Wed, 17 May 2023 11:00:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 346AA5E15;
 Wed, 17 May 2023 11:00:59 +0300 (MSK)
Received: (nullmailer pid 3624139 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v8.0.1 20/36] meson: leave unnecessary modules out of the build
Date: Wed, 17 May 2023 11:00:40 +0300
Message-Id: <20230517080056.3623993-20-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

meson.build files choose whether to build modules based on foo.found()
expressions.  If a feature is enabled (e.g. --enable-gtk), these expressions
are true even if the code is not used by any emulator, and this results
in an unexpected difference between modular and non-modular builds.

For non-modular builds, the files are not included in any binary, and
therefore the source files are never processed.  For modular builds,
however, all .so files are unconditionally built by default, and therefore
a normal "make" tries to build them.  However, the corresponding trace-*.h
files are absent due to this conditional:

if have_system
  trace_events_subdirs += [
    ...
    'ui',
    ...
  ]
endif

which was added to avoid wasting time running tracetool on unused trace-events
files.  This causes a compilation failure; fix it by skipping module builds
entirely if (depending on the module directory) have_block or have_system
are false.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit ef709860ea12ec59c4cd7373bd2fd7a4e50143ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index c44d05a13f..c7e486e087 100644
--- a/meson.build
+++ b/meson.build
@@ -3213,6 +3213,10 @@ modinfo_files = []
 block_mods = []
 softmmu_mods = []
 foreach d, list : modules
+  if not (d == 'block' ? have_block : have_system)
+    continue
+  endif
+
   foreach m, module_ss : list
     if enable_modules and targetos != 'windows'
       module_ss = module_ss.apply(config_all, strict: false)
-- 
2.39.2


