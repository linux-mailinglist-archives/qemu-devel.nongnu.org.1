Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E5820A8A
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUv-00089t-4A; Sun, 31 Dec 2023 03:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT6-0005GR-Dv
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT0-0000ri-6h
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLTcsIqH5PtnkvGR0o5eJVyrjzKfSjGxLGSVppVSxC8=;
 b=I35jNyfIYbWJEyEF5HKG1u5EoqgOtSbvtqE2PqXibgBsbnMMzaNBcUT0sPDMBaXTce8STQ
 AwcYGYVojiOpUe+QYiINHhCAQtdWzdBw3lG4KtMQiQf/XzVADBH9uAqIPDLHrCbHNIo96R
 VPRjSGpylNHMGRRiQAVWpDnOYRtoBbE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-IpilPC_pPiK3HZH_3YitIA-1; Sun, 31 Dec 2023 03:46:33 -0500
X-MC-Unique: IpilPC_pPiK3HZH_3YitIA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d4a29dca7so62704265e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012392; x=1704617192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLTcsIqH5PtnkvGR0o5eJVyrjzKfSjGxLGSVppVSxC8=;
 b=fxoK3BmKLhE3dlqin7a1KdkJ2Id85SsFRRH+70G+U8Gdsj4FC7iWhKOz39ooL51b9D
 LOp8ZtuIJkUFoB8OUzwxXMWvWeVSTKMEfuAnMZvDZqazcxmX0DAnVRsZwnvANdjLmM84
 I5Rm4g1swjoqPvybZ7lTmMBqnz6nUCT+9VcTU23FFTiltJHhfCeMEHziQsz9o6rf0h6Y
 +Q/PVwwG95BXNTP7hGnyN3254JxcX1tdZWEazGgscdZUaGhW82OT+zgXYVSY7eZtwB+w
 k8JghTOd5srdUM5jYxmfexmDacWWuh1iHbFMYsU5gMgnihkPwlGqrD4TaOTb7w/wpKTU
 KXvw==
X-Gm-Message-State: AOJu0Yxh/8PgeJfqYKLeyYn6qe3vLEh614X/150LyrVtZo6vql7oaSqW
 Ofns2nuJP2zqyrs4FGW/CggQHsaa2jmDNxCefPH17MnU93bUhLB78KbX7ZEOBa80Umsdk1oIvF/
 CFHY56Gnez+Aa0TGiAJO2vkxLrFJPlgkKgpLfJYlVTO73qjRmat1RakASRb0fO91WvGkxN2H9pj
 OQqi6+5So=
X-Received: by 2002:a05:600c:c10:b0:40d:84fe:4403 with SMTP id
 fm16-20020a05600c0c1000b0040d84fe4403mr513870wmb.51.1704012392277; 
 Sun, 31 Dec 2023 00:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp9/0HTpz2hdm2rnEpEsM113aAXNWyJUrszqpvfozQXdlVi2zqneWAEwbFc18I26PyTqAfVA==
X-Received: by 2002:a05:600c:c10:b0:40d:84fe:4403 with SMTP id
 fm16-20020a05600c0c1000b0040d84fe4403mr513866wmb.51.1704012391986; 
 Sun, 31 Dec 2023 00:46:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a05600c45d500b0040c3953cda5sm44628018wmo.45.2023.12.31.00.46.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/46] meson: move option validation together
Date: Sun, 31 Dec 2023 09:44:49 +0100
Message-ID: <20231231084502.235366-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Check options before compiler flags, because some compiler flags are
incompatible with modules.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 137 ++++++++++++++++++++++++++--------------------------
 1 file changed, 68 insertions(+), 69 deletions(-)

diff --git a/meson.build b/meson.build
index 3a1f4cbb90f..2c6f09352c9 100644
--- a/meson.build
+++ b/meson.build
@@ -108,6 +108,71 @@ endforeach
 # Option validation #
 #####################
 
+# Fuzzing
+if get_option('fuzzing') and get_option('fuzzing_engine') == '' and \
+    not cc.links('''
+          #include <stdint.h>
+          #include <sys/types.h>
+          int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
+          int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
+        ''',
+        args: ['-Werror', '-fsanitize=fuzzer'])
+  error('Your compiler does not support -fsanitize=fuzzer')
+endif
+
+# Tracing backends
+if 'ftrace' in get_option('trace_backends') and targetos != 'linux'
+  error('ftrace is supported only on Linux')
+endif
+if 'syslog' in get_option('trace_backends') and not cc.compiles('''
+    #include <syslog.h>
+    int main(void) {
+        openlog("qemu", LOG_PID, LOG_DAEMON);
+        syslog(LOG_INFO, "configure");
+        return 0;
+    }''')
+  error('syslog is not supported on this system')
+endif
+
+# Miscellaneous Linux-only features
+get_option('mpath') \
+  .require(targetos == 'linux', error_message: 'Multipath is supported only on Linux')
+
+multiprocess_allowed = get_option('multiprocess') \
+  .require(targetos == 'linux', error_message: 'Multiprocess QEMU is supported only on Linux') \
+  .allowed()
+
+vfio_user_server_allowed = get_option('vfio_user_server') \
+  .require(targetos == 'linux', error_message: 'vfio-user server is supported only on Linux') \
+  .allowed()
+
+have_tpm = get_option('tpm') \
+  .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
+  .allowed()
+
+# vhost
+have_vhost_user = get_option('vhost_user') \
+  .disable_auto_if(targetos != 'linux') \
+  .require(targetos != 'windows',
+           error_message: 'vhost-user is not available on Windows').allowed()
+have_vhost_vdpa = get_option('vhost_vdpa') \
+  .require(targetos == 'linux',
+           error_message: 'vhost-vdpa is only available on Linux').allowed()
+have_vhost_kernel = get_option('vhost_kernel') \
+  .require(targetos == 'linux',
+           error_message: 'vhost-kernel is only available on Linux').allowed()
+have_vhost_user_crypto = get_option('vhost_crypto') \
+  .require(have_vhost_user,
+           error_message: 'vhost-crypto requires vhost-user to be enabled').allowed()
+
+have_vhost = have_vhost_user or have_vhost_vdpa or have_vhost_kernel
+
+have_vhost_net_user = have_vhost_user and get_option('vhost_net').allowed()
+have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
+have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
+have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
+
+# type of binaries to build
 have_linux_user = false
 have_bsd_user = false
 have_system = false
@@ -117,6 +182,7 @@ foreach target : target_dirs
   have_system = have_system or target.endswith('-softmmu')
 endforeach
 have_user = have_linux_user or have_bsd_user
+
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -125,13 +191,14 @@ have_ga = get_option('guest_agent') \
   .require(targetos in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
            error_message: 'unsupported OS for QEMU guest agent') \
   .allowed()
+have_block = have_system or have_tools
+
 enable_modules = get_option('modules') \
   .require(targetos != 'windows',
            error_message: 'Modules are not available for Windows') \
   .require(not get_option('prefer_static'),
            error_message: 'Modules are incompatible with static linking') \
   .allowed()
-have_block = have_system or have_tools
 
 #######################################
 # Variables for host and accelerators #
@@ -535,74 +602,6 @@ if sparse.found()
                        '-Wno-non-pointer-null'])
 endif
 
-#####################
-# Option validation #
-#####################
-
-# Fuzzing
-if get_option('fuzzing') and get_option('fuzzing_engine') == '' and \
-    not cc.links('''
-          #include <stdint.h>
-          #include <sys/types.h>
-          int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
-          int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
-        ''',
-        args: ['-Werror', '-fsanitize=fuzzer'])
-  error('Your compiler does not support -fsanitize=fuzzer')
-endif
-
-# Tracing backends
-if 'ftrace' in get_option('trace_backends') and targetos != 'linux'
-  error('ftrace is supported only on Linux')
-endif
-if 'syslog' in get_option('trace_backends') and not cc.compiles('''
-    #include <syslog.h>
-    int main(void) {
-        openlog("qemu", LOG_PID, LOG_DAEMON);
-        syslog(LOG_INFO, "configure");
-        return 0;
-    }''')
-  error('syslog is not supported on this system')
-endif
-
-# Miscellaneous Linux-only features
-get_option('mpath') \
-  .require(targetos == 'linux', error_message: 'Multipath is supported only on Linux')
-
-multiprocess_allowed = get_option('multiprocess') \
-  .require(targetos == 'linux', error_message: 'Multiprocess QEMU is supported only on Linux') \
-  .allowed()
-
-vfio_user_server_allowed = get_option('vfio_user_server') \
-  .require(targetos == 'linux', error_message: 'vfio-user server is supported only on Linux') \
-  .allowed()
-
-have_tpm = get_option('tpm') \
-  .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
-  .allowed()
-
-# vhost
-have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(targetos != 'linux') \
-  .require(targetos != 'windows',
-           error_message: 'vhost-user is not available on Windows').allowed()
-have_vhost_vdpa = get_option('vhost_vdpa') \
-  .require(targetos == 'linux',
-           error_message: 'vhost-vdpa is only available on Linux').allowed()
-have_vhost_kernel = get_option('vhost_kernel') \
-  .require(targetos == 'linux',
-           error_message: 'vhost-kernel is only available on Linux').allowed()
-have_vhost_user_crypto = get_option('vhost_crypto') \
-  .require(have_vhost_user,
-           error_message: 'vhost-crypto requires vhost-user to be enabled').allowed()
-
-have_vhost = have_vhost_user or have_vhost_vdpa or have_vhost_kernel
-
-have_vhost_net_user = have_vhost_user and get_option('vhost_net').allowed()
-have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
-have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
-have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
-
 # Target-specific libraries and flags
 libm = cc.find_library('m', required: false)
 threads = dependency('threads')
-- 
2.43.0


