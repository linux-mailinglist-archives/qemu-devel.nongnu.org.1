Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D830660
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5UU-0001ke-Fo; Wed, 17 Jan 2024 07:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ56H-0007RA-Us
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:58 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ56G-0000Ox-Ex
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:57 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36074b286d6so56022325ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494775; x=1706099575; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4cfDv1zNc8ypbqaAfakOCKh4GSh8+fG9b5alWz0fu4w=;
 b=SinXbgaVetJZrgJXvQG+TeGGxknV276rBFL8YHeFDF6yEWEdHrNKy+ALB04fkkNXux
 BCNJ0bOkEwEifx15pOZCwvsyTnaBTfneV1EvALGvIu6+Yx4NKIgi30Pt0BjLKxpw2VS+
 6K6RxZhV7/lGoc+WaPgH/kRR7XuMmRvDq/juLWZFFln6h7svnE5TqweEd0PCtIAKKL5X
 N2GfgP4CyM524qCL/nOx3wV3cOrYras/vRp5X5+wjlSOPKhmL0etenUFA7jwx9JZKhdk
 M3Yu047IBzG3qNXuB3lm2DAgBrfmYtcZvRS5+rvPJYc2bYi4oqXlcfC2qNJzdxvpNTS4
 FdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494775; x=1706099575;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cfDv1zNc8ypbqaAfakOCKh4GSh8+fG9b5alWz0fu4w=;
 b=iAbbbiDtnuuBb7rKBYtJu7Y9OduKmenSIl8erJG6hBPqo4+beL09WFqF9hr8fMuW8j
 RErMRQ843BhMuo47pHB9g86ldzj2tmGf7aDRM80+2ukIi1KZ/r7bFVtSUB2B0taw+05g
 t3Zn25F3jIPIDfHqo3cKEobNInxickX/MrjBaBUjXi3Qn0HBv8zY3Y1yZBBxtAVAqmCa
 oxFECk6II6XkZEehmk/Qpow+JDFCpXWLVMuwH//X4INSbjkJ1szc8uebWx6DrrAp8BHY
 xUUZPoFAaH4vuWyyprEtNcdU+2ZVQ1v9f0LXJ49lHlybM209jYzhiV734T4lVCtSQUD4
 hFSw==
X-Gm-Message-State: AOJu0YzX7S7ps4UHHsjdtNqcYX9HNllgXjc0MP9DrxoYN938j0hHBElK
 CgEL8qE0nOVH1g31B0AzXEY9XnYKng36GDcEy85jGV8OmU0=
X-Google-Smtp-Source: AGHT+IGCI3rGwJehzGRid5jc/4h5buQRLx19NVta+iD9FSojkoCTLMJKcWfWonFAGoTPJkNowf+ycaPIWpgdSHJvnVk=
X-Received: by 2002:a05:6e02:de3:b0:360:b53c:9710 with SMTP id
 m3-20020a056e020de300b00360b53c9710mr7493858ilj.108.1705494775231; Wed, 17
 Jan 2024 04:32:55 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:32:51 +0100
Message-ID: <CAHP40mnrTbwiTY7+_kK5sHAwR8oQ-2j9G3wekB9+Q30GZQQgAQ@mail.gmail.com>
Subject: [PATCH 3/4] Allow tests to be disabled
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 07:57:54 -0500
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

tests/qtest/tpm-* compilation is not disabled by disable-tpm,
for this reason compilation fails on systems that doesn't
support the linux/bsd TPM api. Fix this by allowing tests
to be disabled.

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index 21ab9a64e9..c36ce1f7e2 100755
--- a/configure
+++ b/configure
@@ -254,6 +254,7 @@ skip_meson=no
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
+tests="auto"

 # Don't accept a target_list environment variable.
 unset target_list
@@ -741,6 +742,10 @@ for opt do
   ;;
   --disable-cfi) cfi=false
   ;;
+  --disable-tests) tests="disabled"
+  ;;
+  --enable-tests) tests="enabled"
+  ;;
   --disable-download) download="disabled"; git_submodules_action=validate;
   ;;
   --enable-download) download="enabled"; git_submodules_action=update;
@@ -887,6 +892,7 @@ cat << EOF
   linux-user      all linux usermode emulation targets
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
+  tests           build tests

 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -1792,6 +1798,7 @@ if test "$skip_meson" = no; then
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
+  test "$tests" != auto && meson_option_add "-Dtests=$tests"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add
"-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
--
2.43.0

root@hurd:~/qemu# cat 0004-Add-the-GNU-Hurd-as-a-target-host.patch
From 5d7bf83c00168cede72a03d87d7546a0018b82a5 Mon Sep 17 00:00:00 2001
Message-ID: <5d7bf83c00168cede72a03d87d7546a0018b82a5.1705439227.git.manolo.demedici@gmail.com>
In-Reply-To: <cover.1705439227.git.manolo.demedici@gmail.com>
References: <cover.1705439227.git.manolo.demedici@gmail.com>
From: Manolo de Medici <manolo.demedici@gmail.com>
Date: Tue, 16 Jan 2024 20:12:50 +0100
Subject: [PATCH 4/4] Add the GNU/Hurd as a target host

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index c36ce1f7e2..d4648af96a 100755
--- a/configure
+++ b/configure
@@ -354,6 +354,8 @@ elif check_define __NetBSD__; then
   host_os=netbsd
 elif check_define __APPLE__; then
   host_os=darwin
+elif check_define __GNU__; then
+  host_os=hurd
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
--
2.43.0

