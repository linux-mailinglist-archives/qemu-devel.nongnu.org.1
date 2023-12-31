Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C668820A92
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUl-0007GG-DG; Sun, 31 Dec 2023 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT2-0005Br-R0
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSu-0000r5-Bm
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5Hygw6BCLAW+/DX4uFrFssKIS5y1W7KlhzHWvHQ5z4=;
 b=DCKKebA66Fku0u6m8CRz5DZxAXlGhpDrFGmqyjZ1hHvBdOE3fV6X882glBZcQMfsdAl4J0
 n5bjSXDNc26BOl7SjqkpE3hgtHyBwvW/r1wID5hWTxqV9Wlemuh+IcMkl/pHzS6BInxCBR
 9xuau/TlhUK67WFIDklHVCzlhd4On6A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-JqV6R3QyNh-gPvKYJt-eeg-1; Sun, 31 Dec 2023 03:46:27 -0500
X-MC-Unique: JqV6R3QyNh-gPvKYJt-eeg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d68242598so20908935e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012386; x=1704617186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5Hygw6BCLAW+/DX4uFrFssKIS5y1W7KlhzHWvHQ5z4=;
 b=M+xR1HFx32Q3nv/rSYkyz9Zv4PAY4H892MeS31Yb7Da60vkHSM1QUVpSh7ejlrmTzI
 s7+Ormo/TELs5UgsFshBvL8we3+2spZ28EDvwXywQWO+6IW9GkK887+z5356sEqw5bmw
 qvEXlQNKQMTnkr1cPMJxMSGwMOBGsPSZKVdhi3ZcO4eM1KARp5dDffeuDwX89iftzRQ8
 8TWlswNXPvEP8ehf2CyXtZmVM45p8chHBa0hK5lo0/bO7v2CwjxHfGUfSdIa08RP4+pm
 WVg4SVeKdGo8vBeYx25V2Jy3d61i1g2rI9hJjavaVXXJgEXdn4O3qkEO15WB2NeaqKZO
 9TNg==
X-Gm-Message-State: AOJu0Yy4ygZ3FSqlfc6B9EK7gG4V/Q0iiYzKZoEAxhbCzDoqnl1AXoNw
 9blBo+/3w4CIUnbA9WDaCtWOcj1rKFPkiKM60+lpLn1fDsJXUv+rMlNETQf/ZlzXxopXwBXqzKS
 6shf3I99SW8ehDZ/T4wgGvzWSq/rG66IfKqCccxftXNdXUZ2tZ/YC8jxWr2SUjywiatyngnkNna
 XT0J5AaKE=
X-Received: by 2002:a05:600c:1614:b0:40d:12ad:e0ec with SMTP id
 m20-20020a05600c161400b0040d12ade0ecmr4181484wmn.236.1704012385911; 
 Sun, 31 Dec 2023 00:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1PuFBHgLEZb6QzFBmYgAxjOVFxdSgE3VEhnwqEZ6hr+XgxjRWg0eacWsvCuSSzYFCy+L/0w==
X-Received: by 2002:a05:600c:1614:b0:40d:12ad:e0ec with SMTP id
 m20-20020a05600c161400b0040d12ade0ecmr4181482wmn.236.1704012385565; 
 Sun, 31 Dec 2023 00:46:25 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 he3-20020a05600c540300b00405d9a950a2sm43800681wmb.28.2023.12.31.00.46.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/46] configure: unify again the case arms in
 probe_target_compiler
Date: Sun, 31 Dec 2023 09:44:46 +0100
Message-ID: <20231231084502.235366-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove assignments that match the default, and group the
targets for debian-legacy-test-cross and debian-all-test-cross
into a single arm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 87 ++++++++++++++++++-------------------------------------
 1 file changed, 28 insertions(+), 59 deletions(-)

diff --git a/configure b/configure
index ed2d220040d..0128fd30ea8 100755
--- a/configure
+++ b/configure
@@ -1231,6 +1231,7 @@ probe_target_compiler() {
   got_cross_cc=no
   container_image=
   container_hosts=
+  container_cross_prefix=
   container_cross_cc=
   container_cross_ar=
   container_cross_as=
@@ -1272,16 +1273,33 @@ probe_target_compiler() {
     test "$container" != no || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
+      # debian-all-test-cross architectures
+
+      hppa|m68k|mips|riscv64|sparc64)
+        container_image=debian-all-test-cross
+        ;;
+      mips64)
+        container_image=debian-all-test-cross
+        container_cross_prefix=mips64-linux-gnuabi64-
+        ;;
+      ppc|ppc64|ppc64le)
+        container_image=debian-all-test-cross
+        container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
+        ;;
+
+      # debian-legacy-test-cross architectures (need Debian 11)
+      # - libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+      # - sh4-linux-user: binaries don't run with bookworm compiler
+
+      alpha|sh4)
+        container_image=debian-legacy-test-cross
+        ;;
+
+      # architectures with individual containers
+
       aarch64)
         # We don't have any bigendian build tools so we only use this for AArch64
         container_image=debian-arm64-cross
-        container_cross_prefix=aarch64-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc
-        ;;
-      alpha)
-        container_image=debian-legacy-test-cross
-        container_cross_prefix=alpha-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc
         ;;
       arm)
         # We don't have any bigendian build tools so we only use this for ARM
@@ -1290,18 +1308,11 @@ probe_target_compiler() {
         ;;
       cris)
         container_image=fedora-cris-cross
-        container_cross_prefix=cris-linux-gnu-
         ;;
       hexagon)
-        container_image=debian-hexagon-cross
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
         ;;
-      hppa)
-        container_image=debian-all-test-cross
-        container_cross_prefix=hppa-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc
-        ;;
       i386)
         container_image=debian-i686-cross
         container_cross_prefix=i686-linux-gnu-
@@ -1310,59 +1321,19 @@ probe_target_compiler() {
         container_image=debian-loongarch-cross
         container_cross_prefix=loongarch64-unknown-linux-gnu-
         ;;
-      m68k)
-        container_image=debian-all-test-cross
-        container_cross_prefix=m68k-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc
-        ;;
       microblaze)
-        container_image=debian-microblaze-cross
         container_cross_prefix=microblaze-linux-musl-
         ;;
       mips64el)
         container_image=debian-mips64el-cross
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
-      mips64)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips64-linux-gnuabi64-
-        ;;
-      mips)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips-linux-gnu-
-        ;;
-      nios2)
-        container_image=debian-nios2-cross
-        container_cross_prefix=nios2-linux-gnu-
-        ;;
-      ppc)
-        container_image=debian-all-test-cross
-        container_cross_prefix=powerpc-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc
-        ;;
-      ppc64|ppc64le)
-        container_image=debian-all-test-cross
-        container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
-        ;;
-      riscv64)
-        container_image=debian-all-test-cross
-        container_cross_prefix=riscv64-linux-gnu-
-        ;;
-      sh4)
-        container_image=debian-legacy-test-cross
-        container_cross_prefix=sh4-linux-gnu-
-        ;;
-      sparc64)
-        container_image=debian-all-test-cross
-        container_cross_prefix=sparc64-linux-gnu-
-        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
         ;;
       x86_64)
         container_image=debian-amd64-cross
-        container_cross_prefix=x86_64-linux-gnu-
         ;;
       xtensa*)
         container_image=debian-xtensa-cross
@@ -1370,12 +1341,10 @@ probe_target_compiler() {
         # default to the dc232b cpu
         container_cross_prefix=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-
         ;;
-      *)
-        # Debian and GNU architecture names usually match
-        container_image=debian-$target_arch-cross
-        container_cross_prefix=$target_arch-linux-gnu-
-        ;;
     esac
+    # Debian and GNU architecture names usually match
+    : ${container_image:=debian-$target_arch-cross}
+    : ${container_cross_prefix:=$target_arch-linux-gnu-}
     : ${container_cross_cc:=${container_cross_prefix}gcc}
     : ${container_cross_ar:=${container_cross_prefix}ar}
     : ${container_cross_as:=${container_cross_prefix}as}
-- 
2.43.0


