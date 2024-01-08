Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA782761B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtCj-0007gb-6A; Mon, 08 Jan 2024 12:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMtCg-0007g9-RW
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMtCV-0007YU-JG
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704734046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQKkMMniJPq4dyGYEr2/n+gkqYYbxbxQDC7EpLRfCiw=;
 b=D3IMATqdbbeGfsY2cidjV3XJwEkg7obNe+z7flvuat5L4CC+QOKugSU/qzBsGNTGtX2Gth
 JttYHkLG3BrgcUWR9hiD3QB8eqpAQU9DldxfXfj97SolAyCJO0196wb78EssNMHxOShBAJ
 tJ62hnOr2EyK0Fea/khTBnzkF+qvJTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-vAG62R49MbqySw5-V3Tpvg-1; Mon, 08 Jan 2024 12:14:04 -0500
X-MC-Unique: vAG62R49MbqySw5-V3Tpvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74F01845E62;
 Mon,  8 Jan 2024 17:14:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7973C5190;
 Mon,  8 Jan 2024 17:14:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] meson: generate .stp files for tools too
Date: Mon,  8 Jan 2024 17:13:56 +0000
Message-ID: <20240108171356.1037059-3-berrange@redhat.com>
In-Reply-To: <20240108171356.1037059-1-berrange@redhat.com>
References: <20240108171356.1037059-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The qemu-img, qemu-io, qemu-nbd, qemu-storage-daemon tools all have
support for systemtap tracing built-in, so should be given corresponding
.stp files to define their probes.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 61 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 535f15da69..4db6907a20 100644
--- a/meson.build
+++ b/meson.build
@@ -3752,6 +3752,7 @@ if targetos == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
 endif
 
+traceable = []
 emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
@@ -3919,27 +3920,11 @@ foreach target : target_dirs
       emulators += {exe['name']: emulator}
     endif
 
-    if stap.found()
-      foreach stp: [
-        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / exe['name'], 'install': false},
-        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / exe['name'], 'install': true},
-        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
-        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
-      ]
-        custom_target(exe['name'] + stp['ext'],
-                      input: trace_events_all,
-                      output: exe['name'] + stp['ext'],
-                      install: stp['install'],
-                      install_dir: get_option('datadir') / 'systemtap/tapset',
-                      command: [
-                        tracetool, '--group=all', '--format=' + stp['fmt'],
-                        '--binary=' + stp['bin'],
-                        '--probe-prefix=qemu.' + target_type + '.' + target_name,
-                        '@INPUT@', '@OUTPUT@'
-                      ],
-                      depend_files: tracetool_depends)
-      endforeach
-    endif
+    traceable += [{
+      'exe': exe['name'],
+      'probe-prefix': 'qemu.' + target_type + '.' + target_name,
+    }]
+
   endforeach
 endforeach
 
@@ -3974,6 +3959,14 @@ if have_tools
                install: true)
 
   subdir('storage-daemon')
+
+  foreach exe: [ 'qemu-img', 'qemu-io', 'qemu-nbd', 'qemu-storage-daemon']
+    traceable += [{
+      'exe': exe,
+      'probe-prefix': 'qemu.' + exe.substring(5).replace('-', '_')
+    }]
+  endforeach
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
@@ -4006,6 +3999,32 @@ if have_tools
   endif
 endif
 
+if stap.found()
+  foreach t: traceable
+    foreach stp: [
+      {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / t['exe'], 'install': false},
+      {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / t['exe'], 'install': true},
+      {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
+      {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
+    ]
+      cmd = [
+        tracetool, '--group=all', '--format=' + stp['fmt'],
+        '--binary=' + stp['bin'],
+        '--probe-prefix=' + t['probe-prefix'],
+        '@INPUT@', '@OUTPUT@'
+      ]
+
+      custom_target(t['exe'] + stp['ext'],
+                    input: trace_events_all,
+                    output: t['exe'] + stp['ext'],
+                    install: stp['install'],
+                    install_dir: get_option('datadir') / 'systemtap/tapset',
+                    command: cmd,
+                    depend_files: tracetool_depends)
+    endforeach
+  endforeach
+endif
+
 subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
-- 
2.43.0


