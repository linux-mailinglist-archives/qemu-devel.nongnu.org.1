Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BEA3D8E5
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 12:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4rs-0004ZB-2v; Thu, 20 Feb 2025 06:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl4rf-0004Yp-Vs
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:37:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl4re-0000rC-2q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740051429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S3+h0KILMZzEFjUXbmLqWGpqxuaheqFJv+xCK/jNY0=;
 b=XaKgTc8eX5apiHNUvGMjXbRmtJ8U71xVqd9KbfUINvYfLF7uueUBRnm/GZ13c0RT+HgY33
 Piu08L74Gfk3xDaqogskv+tF/S9TD7wapHHxbEyOcQ8+sytdjCkfa9AI+/IJAP3Gp7NbTg
 uJokDktspeG4OU9Z+meNJI/KWNkCuhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-PH49Mo7LPSOQCKEf43RfpA-1; Thu, 20 Feb 2025 06:37:06 -0500
X-MC-Unique: PH49Mo7LPSOQCKEf43RfpA-1
X-Mimecast-MFC-AGG-ID: PH49Mo7LPSOQCKEf43RfpA_1740051426
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4399c5ba9e4so4069375e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 03:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740051425; x=1740656225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S3+h0KILMZzEFjUXbmLqWGpqxuaheqFJv+xCK/jNY0=;
 b=ZwNX1P4knzU7fgimzm1yhRnL3cS04X3TnQxaF4xEnwWah6SbCaP9GX44oY4OsK5Ulr
 +lwnSHGe+BTxasiw9nEodUhUfhRTIP91430Qi9L1YAzXHNA9Fz4kqIvp1t6+dEg8DLHp
 UPOngnMe+8q4Mo/JE+y7+BooDGXNRk4Jp1kNotTSKFWzeBYas7huSlgaZXujNY4SDoIm
 4gjvMoL5Uhfz1W4jekG9TsIJ8IHdkEW2Py2YzkbrSFWL99yUpnRqf9uiVAdZ+Ubrk3iq
 YPOUPdOsKbvlU/VXj/IRMXBluxGSvW8luicVzbik1eiJ4shAsGfGTOF/2h9+S+4h+ANs
 R03w==
X-Gm-Message-State: AOJu0Yz6IyBwSyg7kpS9+W1eCg4ZRIuxJg6jk1MJWJ3yWtIvTG+Q6EPO
 kE03gdzUQQqAFeZAVz/S4oGxHj4oYNte2g41t8iWfeLDMJ0YHJ63VJ3GYEeiXEdsqrVnlizKsd9
 ZBeABKRyUrQWkVi8fcT5WjI8vQ8hunS1RjiV96o5Z4CMMlhnDpCsZiCoVqTWhFTc+RDAZQPBTvJ
 tyncR4bP1ZzP3H63e/BBPZn9sDfpzjlsAb9oGxqOk=
X-Gm-Gg: ASbGncv/CeOPo8ScBZkaWj+Eg1aX7lJVsmA3xs2bhWIsh/jeR4IWLrVqy0cn858cctU
 pQOu4tavdrmRACCD8z/kVXujWTGypc1iLGArBWubEmQNIc8iKWmyH1asRidomQ9/05sESPbY1WF
 R4iLE/tEc1Gt6HPwc8palhxe7024v6g22EwNkyf0I/TTcgb4VIT1tNhEyp29NXFkmRH+kR/2Tm7
 4xSV9444PsnAEp4UWbKSzAUbYhodFpFBPa1nbUPeJgJVzuVhHbnFwIfupSfQclCvCb4CEhbVELY
 3qUv6Njqb1s=
X-Received: by 2002:a05:600c:4f91:b0:439:9a40:aa09 with SMTP id
 5b1f17b1804b1-4399a40ad23mr54452275e9.25.1740051424880; 
 Thu, 20 Feb 2025 03:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdDebQN0Va1EShZ+Ns5WBCt7aWD3b6SYwM2p91cnbSoO84AKFL/zFeNW+wBGX5EPRNpv9bLw==
X-Received: by 2002:a05:600c:4f91:b0:439:9a40:aa09 with SMTP id
 5b1f17b1804b1-4399a40ad23mr54451965e9.25.1740051424346; 
 Thu, 20 Feb 2025 03:37:04 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a44264csm101397705e9.25.2025.02.20.03.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 03:37:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	kwolf@redhat.com
Subject: [PATCH v3 1/2] rust: subprojects: add libc crate
Date: Thu, 20 Feb 2025 12:36:58 +0100
Message-ID: <20250220113659.863332-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220113659.863332-1-pbonzini@redhat.com>
References: <20250220113659.863332-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This allows access to errno values.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                               |  7 ++++
 rust/qemu-api/Cargo.toml                      |  1 +
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/libc-0.2-rs.wrap                  |  7 ++++
 .../packagefiles/libc-0.2-rs/meson.build      | 37 +++++++++++++++++++
 7 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/libc-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 79e142723b8..2ebf0a11ea4 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -54,6 +54,12 @@ dependencies = [
  "either",
 ]
 
+[[package]]
+name = "libc"
+version = "0.2.162"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+
 [[package]]
 name = "pl011"
 version = "0.1.0"
@@ -100,6 +106,7 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
+ "libc",
  "qemu_api_macros",
  "version_check",
 ]
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index a51dd142852..57747bc9341 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,6 +16,7 @@ rust-version = "1.63.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
+libc = "0.2.162"
 
 [build-dependencies]
 version_check = "~0.9"
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec90..e461c1531ed 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -28,7 +28,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index 1b89b3423a8..8c3594a1a47 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -41,7 +41,7 @@ fi
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 50f173f90db..d12d34618cc 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-impl-0.2.0
 /either-1.12.0
 /itertools-0.11.0
+/libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
new file mode 100644
index 00000000000..bbe08f87883
--- /dev/null
+++ b/subprojects/libc-0.2-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = libc-0.2.162
+source_url = https://crates.io/api/v1/crates/libc/0.2.162/download
+source_filename = libc-0.2.162.tar.gz
+source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
+#method = cargo
+patch_directory = libc-0.2-rs
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
new file mode 100644
index 00000000000..ac4f80dba98
--- /dev/null
+++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
@@ -0,0 +1,37 @@
+project('libc-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.162',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+_libc_rs = static_library(
+  'libc',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2015', 'build.rust_std=2015'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'freebsd11',
+    '--cfg', 'libc_priv_mod_use',
+    '--cfg', 'libc_union',
+    '--cfg', 'libc_const_size_of',
+    '--cfg', 'libc_align',
+    '--cfg', 'libc_int128',
+    '--cfg', 'libc_core_cvoid',
+    '--cfg', 'libc_packedN',
+    '--cfg', 'libc_cfg_target_vendor',
+    '--cfg', 'libc_non_exhaustive',
+    '--cfg', 'libc_long_array',
+    '--cfg', 'libc_ptr_addr_of',
+    '--cfg', 'libc_underscore_const_names',
+    '--cfg', 'libc_const_extern_fn',
+  ],
+  dependencies: [],
+)
+
+libc_dep = declare_dependency(
+  link_with: _libc_rs,
+)
+
+meson.override_dependency('libc-0.2-rs', libc_dep)
-- 
2.48.1


