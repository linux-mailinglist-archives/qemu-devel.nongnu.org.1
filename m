Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F7820A8F
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrV2-0008KZ-0C; Sun, 31 Dec 2023 03:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT9-0005Ja-AE
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT0-0000ro-RR
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLBDwrGEYlc2Syie7CIrGEdhuYzgR0c12m14Bz/+U8c=;
 b=G9ImIPOH0l4OxM9QNe+Ljgdf3nckN7Fa0FLWfYRpjCGUzl8oXkA88KMp9zq3Z17LRN9FMN
 N4jd0VICpivx9JQF8BsuhGgF/KWodhlF/9rjETz2QLoWOArhiidneW6hBkiCC13v7VUXkW
 JQ3YuwGKspJ+SeYtNUjkjTaPRWalsyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-nZHYpfLuOJG4HMMMLBhEyw-1; Sun, 31 Dec 2023 03:46:38 -0500
X-MC-Unique: nZHYpfLuOJG4HMMMLBhEyw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33688a38636so5903775f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012396; x=1704617196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLBDwrGEYlc2Syie7CIrGEdhuYzgR0c12m14Bz/+U8c=;
 b=NF0gUIbi79k6Oe9aOfCpcu/YHC9o20miFaRwYWbTT7rmCw0Z+e3pWriJuokRQwzSlu
 pLtBofCO9HE+9N35HUfTH6F65jPYn9MsmlLbRpQBQsquVPgjbsQuB2wQ1UjUGgE7vNWL
 TbrUkBNKjpmxvAEmn0vvcCzZ8hYmwykw5rwgCklIkqnN+qT8OIH/ugo/oCJjhbuP2CRG
 opV1htmccSnBWMhcn1DFxH3/iATxcUFkNf1/46poJC97u4qencvLHrWYc0J1qcsXqD2F
 RhYUr6G8UJcbpU4g28ae+1xKJ8TKHwGGliClaNh+DXjIkfzzE1fDqYjgkXZaH4uMvpkL
 K4Rw==
X-Gm-Message-State: AOJu0YwOlVIRyk6NHBIsXbzGw4SzpwGEkMtNd3/dxGIiOXBe7fZm1uSA
 BEKoVoRzGedOrvJsCjmsWVClb7NtyGxu63BlKy40ZLYIQSLhJ8qGMNNmEJNgHDUOvvIj5+j/o89
 LOjsj2vtuZy5uu+aZoJAYp3/HdlOYWU5sq+v4+fztUxx/vVfWerTy3ZrpY6/JIyBB/HaZiuGGNz
 o5/hlFsX4=
X-Received: by 2002:a5d:6d87:0:b0:337:3ee4:9436 with SMTP id
 l7-20020a5d6d87000000b003373ee49436mr184820wrs.76.1704012396714; 
 Sun, 31 Dec 2023 00:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWRaCNBa/hNhdBkfy7iiTbP1KB0AKcv/wnp07sL7BRUL2/ms7ED9uVAw51mX0ACF8+j2l7Nw==
X-Received: by 2002:a5d:6d87:0:b0:337:3ee4:9436 with SMTP id
 l7-20020a5d6d87000000b003373ee49436mr184813wrs.76.1704012396038; 
 Sun, 31 Dec 2023 00:46:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a056000054d00b0033739c1da1dsm1901961wrf.67.2023.12.31.00.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/46] meson: keep subprojects together
Date: Sun, 31 Dec 2023 09:44:51 +0100
Message-ID: <20231231084502.235366-36-pbonzini@redhat.com>
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

And move away dependencies that are not subprojects anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 72 ++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index 1867e0428b1..efb36c762e9 100644
--- a/meson.build
+++ b/meson.build
@@ -1622,6 +1622,25 @@ if not gnutls_crypto.found()
   endif
 endif
 
+capstone = not_found
+if not get_option('capstone').auto() or have_system or have_user
+  capstone = dependency('capstone', version: '>=3.0.5',
+                        method: 'pkg-config',
+                        required: get_option('capstone'))
+
+  # Some versions of capstone have broken pkg-config file
+  # that reports a wrong -I path, causing the #include to
+  # fail later. If the system has such a broken version
+  # do not use it.
+  if capstone.found() and not cc.compiles('#include <capstone.h>',
+                                          dependencies: [capstone])
+    capstone = not_found
+    if get_option('capstone').enabled()
+      error('capstone requested, but it does not appear to work')
+    endif
+  endif
+endif
+
 gmp = dependency('gmp', required: false, method: 'pkg-config')
 if nettle.found() and gmp.found()
   hogweed = dependency('hogweed', version: '>=3.4',
@@ -2127,6 +2146,7 @@ config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
 config_host_data.set('CONFIG_BSD', targetos in bsd_oses)
+config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', targetos == 'darwin')
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
@@ -2190,6 +2210,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_PIXMAN', pixman.found())
+config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 if get_option('tcg').allowed()
@@ -3093,28 +3114,9 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
-##############
-# Submodules #
-##############
-
-capstone = not_found
-if not get_option('capstone').auto() or have_system or have_user
-  capstone = dependency('capstone', version: '>=3.0.5',
-                        method: 'pkg-config',
-                        required: get_option('capstone'))
-
-  # Some versions of capstone have broken pkg-config file
-  # that reports a wrong -I path, causing the #include to
-  # fail later. If the system has such a broken version
-  # do not use it.
-  if capstone.found() and not cc.compiles('#include <capstone.h>',
-                                          dependencies: [capstone])
-    capstone = not_found
-    if get_option('capstone').enabled()
-      error('capstone requested, but it does not appear to work')
-    endif
-  endif
-endif
+###############
+# Subprojects #
+###############
 
 libvfio_user_dep = not_found
 if have_system and vfio_user_server_allowed
@@ -3158,9 +3160,19 @@ else
   fdt_opt = 'disabled'
 endif
 
-config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
-config_host_data.set('CONFIG_SLIRP', slirp.found())
+
+vhost_user = not_found
+if targetos == 'linux' and have_vhost_user
+  libvhost_user = subproject('libvhost-user')
+  vhost_user = libvhost_user.get_variable('vhost_user_dep')
+endif
+
+libvduse = not_found
+if have_libvduse
+  libvduse_proj = subproject('libvduse')
+  libvduse = libvduse_proj.get_variable('libvduse_dep')
+endif
 
 #####################
 # Generated sources #
@@ -3391,18 +3403,6 @@ if have_system or have_user
   ]
 endif
 
-vhost_user = not_found
-if targetos == 'linux' and have_vhost_user
-  libvhost_user = subproject('libvhost-user')
-  vhost_user = libvhost_user.get_variable('vhost_user_dep')
-endif
-
-libvduse = not_found
-if have_libvduse
-  libvduse_proj = subproject('libvduse')
-  libvduse = libvduse_proj.get_variable('libvduse_dep')
-endif
-
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
 subdir('qapi')
-- 
2.43.0


