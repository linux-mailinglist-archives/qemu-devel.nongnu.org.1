Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7E81BCF7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMiq-0007cr-59; Thu, 21 Dec 2023 12:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMio-0007cU-2X
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMim-0004YL-Jc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aC+zFBXfg2XfUMrGRAwKHIKbBC2VYBZ5admwocdXPY8=;
 b=LYXlHYRSrABFmYRbiFG2XlMBMj0rQUTebAFrYJX6qd7MvFEQHodh2TDN993ccYs0tP4PCg
 +A/7e1cBp0V9hDmmS6NKDeCtJs9mLzmJah+BfJJtNQSgKt+C/u1MA2y2nOf7JflCQRBOyt
 51rin6k5hqT0L4HJqccbEkzLK926UVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Cws0quYCO6G0aoH4SCM5uA-1; Thu, 21 Dec 2023 12:20:30 -0500
X-MC-Unique: Cws0quYCO6G0aoH4SCM5uA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c4297e070so7313645e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179229; x=1703784029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aC+zFBXfg2XfUMrGRAwKHIKbBC2VYBZ5admwocdXPY8=;
 b=gVJ28hkdsU60Wzh2AEDxoBxBw9VfmNyj3z3/k8tmo9jM+Pn9C+tTsb70zT61OilIWT
 cevdF+6jnHV9oqzqFNKkxuBYnWA7HmHjwxXznNasodVe/QxP20m44CeZwRve1PFQnOEd
 G7ppOyMR2JHAtx9u/bVXUsOlLNXv7CEmTMEVVUgl1Chrx3O0ebTqJmABin/ow7EUbAyQ
 SsakfecAR4OCV9kWeWp4+IdPf/onBDL3dg79y3rsYUXmzdn7FfMDTGsQeoWE/oVnzEbT
 R5X3UtlUBvv5GomLFbMgpvgIYnhNYYvtMF/6epq5B5bD7cgRRGJTzzd5xR2TmvhHIWTr
 +1Xg==
X-Gm-Message-State: AOJu0YwBYYI09uiDrRfjBAgXgWRJbC/lb4658haDhYDw6ukmUlygWB5I
 oILmcf5MPsMoUYwepKrBROTvF5o3RottZS7kEDPPpBWEYMar+f5+Zb37OU5wyo+EhwgSDnH1L3I
 EB9sGnaRFGUvGmeOUklVj2a8TRavUiy0Mjaee5zk0Cjzh6sar/LyBqSwQS8Fnj/gKpWATqgvOEp
 +1viPjREo=
X-Received: by 2002:a05:600c:4f41:b0:40c:32f2:a302 with SMTP id
 m1-20020a05600c4f4100b0040c32f2a302mr25285wmq.94.1703179228965; 
 Thu, 21 Dec 2023 09:20:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlZO6QrfiDWLpFRvV7NnBDz2RfpWCdV83LW/JrEFpfh7Z8PY6aYlN+kkaBtH8EzVrD54dsMg==
X-Received: by 2002:a05:600c:4f41:b0:40c:32f2:a302 with SMTP id
 m1-20020a05600c4f4100b0040c32f2a302mr25280wmq.94.1703179228645; 
 Thu, 21 Dec 2023 09:20:28 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 bh20-20020a05600c3d1400b0040d15dcb77asm11834336wmb.23.2023.12.21.09.20.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/21] meson: move option validation a bit closer
Date: Thu, 21 Dec 2023 18:19:52 +0100
Message-ID: <20231221171958.59350-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Not entirely possible for option that depend on compiler or dependency checks,
but it's a start.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 1a1e006ba13..f7e7deeabdc 100644
--- a/meson.build
+++ b/meson.build
@@ -52,30 +52,6 @@ supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64'
 cpu = host_machine.cpu_family()
 
 target_dirs = config_host['TARGET_DIRS'].split()
-have_linux_user = false
-have_bsd_user = false
-have_system = false
-foreach target : target_dirs
-  have_linux_user = have_linux_user or target.endswith('linux-user')
-  have_bsd_user = have_bsd_user or target.endswith('bsd-user')
-  have_system = have_system or target.endswith('-softmmu')
-endforeach
-have_user = have_linux_user or have_bsd_user
-have_tools = get_option('tools') \
-  .disable_auto_if(not have_system) \
-  .allowed()
-have_ga = get_option('guest_agent') \
-  .disable_auto_if(not have_system and not have_tools) \
-  .require(targetos in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
-           error_message: 'unsupported OS for QEMU guest agent') \
-  .allowed()
-enable_modules = get_option('modules') \
-  .require(targetos != 'windows',
-           error_message: 'Modules are not available for Windows') \
-  .require(not get_option('prefer_static'),
-           error_message: 'Modules are incompatible with static linking') \
-  .allowed()
-have_block = have_system or have_tools
 
 ############
 # Programs #
@@ -576,6 +552,34 @@ have_tpm = get_option('tpm') \
   .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
   .allowed()
 
+# type of binaries to build
+have_linux_user = false
+have_bsd_user = false
+have_system = false
+foreach target : target_dirs
+  have_linux_user = have_linux_user or target.endswith('linux-user')
+  have_bsd_user = have_bsd_user or target.endswith('bsd-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_user = have_linux_user or have_bsd_user
+
+have_tools = get_option('tools') \
+  .disable_auto_if(not have_system) \
+  .allowed()
+have_ga = get_option('guest_agent') \
+  .disable_auto_if(not have_system and not have_tools) \
+  .require(targetos in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
+           error_message: 'unsupported OS for QEMU guest agent') \
+  .allowed()
+
+have_block = have_system or have_tools
+enable_modules = get_option('modules') \
+  .require(targetos != 'windows',
+           error_message: 'Modules are not available for Windows') \
+  .require(not get_option('prefer_static'),
+           error_message: 'Modules are incompatible with static linking') \
+  .allowed()
+
 # vhost
 have_vhost_user = get_option('vhost_user') \
   .disable_auto_if(targetos != 'linux') \
-- 
2.43.0


