Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51883065C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5UU-0001kM-08; Wed, 17 Jan 2024 07:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ55b-0007PN-Dw
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:15 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ55Z-0000IP-6c
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:32:15 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36074b286d6so56019515ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494732; x=1706099532; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iHctnXJD8eFH8bk150pRtluXVjTj6U6yPwTHKmsAi5g=;
 b=OUIAVshEbp70dNgyaV1aPpN1z+pF2H7dMS7bEKJN8WwPIIliY8ePfiGuLq0hADLwwv
 HKf6jKC5j1zBYHSYVsld2sDkHqfhCU8TXg4RQa9LvxbblZyzs/yEabjght2l8wMtfjSm
 4tFwPPl7S9E1GWfuHmfp1MeG/kaE3iWtpeWdn/Ebd0lWGZEsGhEmyeOME3hSwvNU8GOr
 CefUFR8V0GGJ/au009rxqdmKvrEsXqoP9IlawA0ysT5L5MPV+2QVzvnDmVZGSWfXtppN
 eI4irZ8/GEdpZHqebIHXok3enp6RbonXHqM3o+l5a4w3camgcEJHABjKiH8fO+7tsosc
 m0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494732; x=1706099532;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHctnXJD8eFH8bk150pRtluXVjTj6U6yPwTHKmsAi5g=;
 b=jBP2lPvkvYnvmqJh0R/vbySVUTeZk+Xww6/+MmXtcI9e6ngj26Kh2Zo8aqPMbsciFs
 wdYQioFLm3WKSV+FhLItB1Fk4GoldeSfrpGVlEb3ZEREmejlVm6kSgVVhm24u0ekXIKH
 e142jDNWH/2Nt4Q+ufShW5sUpxsfPnmGVO9A5qsnxe9YHIEvcojugGZv3Iot4zqTb+ME
 y+RbPOuhjK4HDv7Y3T8LVbAOb9+6e1YjMZU0n08nIZlXYgqzVvexy5VL344i3mNHE9K+
 +bQVw0xnSGlz+RRm0S0od8qVvT6DH4orfDPBlgEYLQFvEdKq+9SgokH66psIEdnMzSOp
 Wx2A==
X-Gm-Message-State: AOJu0YxR/5NRTAH84ZkG9v24Ql4cLhyLewpNeb48hzDg3NjOJFbUu1rP
 ZC1aolSQgGOSZrHfZLmgvkg2sN/GZ/kqhg821vDjbsYRVZg=
X-Google-Smtp-Source: AGHT+IF0gjvckquQ/0TYNn5kjSdNpDmvtNW3IBWLgvfIqCYccE5z6/XaXdh4vQJoFdls84s8a+CC4uO9q9eNJ4SHDA4=
X-Received: by 2002:a92:de07:0:b0:361:96cd:98ee with SMTP id
 x7-20020a92de07000000b0036196cd98eemr613717ilm.14.1705494731893; Wed, 17 Jan
 2024 04:32:11 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:32:07 +0100
Message-ID: <CAHP40mkDymmXdvFUAEpiBTbVuaRUHVfW8UTdyuSDhoG4Ro+yzA@mail.gmail.com>
Subject: [PATCH 3/4] Allow tests to be disabled
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x133.google.com
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

