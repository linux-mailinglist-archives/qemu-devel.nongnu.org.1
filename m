Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E6381BD26
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:24:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMia-0007YT-UA; Thu, 21 Dec 2023 12:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiY-0007Xh-Ux
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiW-0004U5-TA
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UebyFwaouzTqOLbyUOTcfC30JgB1MQMFJW2XtX7hlHw=;
 b=NA7m0oy1Z+iza1v98aniDz4JRqr5E7gYmjdR/T370B70StlyLzRHxC7I5LGgCn3JcjFtnF
 zhFYduP+Fx3c/AFwuNhbZP0CsXaa+2ouJGw4sPRTJFfubky6W12/hTEK7Fgieu1yFJYmpp
 rvnarlQkun7x4PqmDHrBclt59N6MYFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-8hAs3PC_Meq5JgnN1hcXMA-1; Thu, 21 Dec 2023 12:20:14 -0500
X-MC-Unique: 8hAs3PC_Meq5JgnN1hcXMA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368c5eebb4so372797f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179213; x=1703784013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UebyFwaouzTqOLbyUOTcfC30JgB1MQMFJW2XtX7hlHw=;
 b=A3b1+uNo/46FC5mbCcqpNFWKFChCO9zzbqQlcR74NKKiz69xHTwJe4gFMRFjAU2ptP
 H39P2tM/DZwHa8WJuYe6SAMouGOmHVsZMVc/t+VRWg6vC6UM+PIgkegMl6z2ZMhvAxB8
 qo7XlGeGZF4KdWLuqFu0mdK7tIEHOTdy9d19Xxc1SKijJ5zMit6Ov7fKzs2HBTiDxg4f
 SA0IcVS2IGNM6b1OZKHJCtY/mOm4WqnQuqtojZWiexPGDbR/vPuZCBeGopWXCBAV/BI8
 JXSLE6ICZZCBCOZjBfB4rrSNH/CKua5FrrC+ji0G1mrRtAvZGmtrNtwK8OSJfPJT3wId
 h+Cw==
X-Gm-Message-State: AOJu0YxqdKo78jHB83ZdoY1ucCteHzRtsJ9tzcRMWoZ/z0U8JcY7bYDF
 WsoHSaOKgQXzUjaPkfbTge/dGUJI33dHuvFS3dhh7v8zcvxnRgeAu8hTe3Enh7v8pJ1lImwTj6I
 ZYNn7HcJfiaUcjPbKdwPlJG9jwBwyctwWhaezkygXXPeKIty/ZDusQbIw5BjVAB4exy3aETSo7o
 qmdjn1B9c=
X-Received: by 2002:a5d:6052:0:b0:336:7a45:c134 with SMTP id
 j18-20020a5d6052000000b003367a45c134mr49479wrt.86.1703179212927; 
 Thu, 21 Dec 2023 09:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxbuR5UguQSGOqNuDsHctwu45FiOcUY838FBTt00QK2tgWZUYxN6H5792VLrPuJgaBU21hCA==
X-Received: by 2002:a5d:6052:0:b0:336:7a45:c134 with SMTP id
 j18-20020a5d6052000000b003367a45c134mr49471wrt.86.1703179212451; 
 Thu, 21 Dec 2023 09:20:12 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 cx1-20020a056000092100b00336598903e9sm2452334wrb.58.2023.12.21.09.20.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/21] configure: unify again the case arms in
 probe_target_compiler
Date: Thu, 21 Dec 2023 18:19:43 +0100
Message-ID: <20231221171958.59350-7-pbonzini@redhat.com>
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

Remove assignments that match the default, and group the
targets for debian-legacy-test-cross and debian-all-test-cross
into a single arm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 86 +++++++++++++++++--------------------------------------
 1 file changed, 27 insertions(+), 59 deletions(-)

diff --git a/configure b/configure
index c634948051b..38ca267096f 100755
--- a/configure
+++ b/configure
@@ -1272,16 +1272,33 @@ probe_target_compiler() {
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
@@ -1290,18 +1307,11 @@ probe_target_compiler() {
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
@@ -1310,59 +1320,19 @@ probe_target_compiler() {
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
@@ -1370,12 +1340,10 @@ probe_target_compiler() {
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


