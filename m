Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884527CD6A2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vm-0002sO-4w; Wed, 18 Oct 2023 04:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v8-00020b-F4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v6-0003hh-Sh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HByuZthEG86fBBuYqJCXFDeyXnbIS8dEpfmL1flA5kg=;
 b=UzT32DHrbmi+JqBgDi2mI+q+eNANdDb6cKnjonQ5qfAfcp3N4UuccwPA6NOPYcJWUKAkyT
 G7EHtW20azygJzwRHCRlE5Ml1ppHlUODkqubNY+pRD4Y1RThBO1E6hpl7PjdULq6VBcWAQ
 L2lNXZosNNZTnC8v17vpFu4+GU0zaf8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-bXSvAEylPzqnyGMCUYg08Q-1; Wed, 18 Oct 2023 04:28:46 -0400
X-MC-Unique: bXSvAEylPzqnyGMCUYg08Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so271150266b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617725; x=1698222525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HByuZthEG86fBBuYqJCXFDeyXnbIS8dEpfmL1flA5kg=;
 b=xI2D2zk88YVW7ESy1gN9fPztDAH2KiMAGcPa/o61E5cy+iBoccisr7zZlHnd24hsTh
 9TX3uJ391v8WyNHoZsgdZWNnFvlM/8VYgzCLjvrz41itmBA3s90IQ/DqgKIBBztLSYtT
 86BFpDZ3miyT8Q4zSnb8NkumAxD+6oEf5dXQR5WFBXzk9xbyjmeSsX3rC7PcKXIUHvys
 7PIoEQV4tUR3Lbm4ytILimKdX5r6FonV1GiJVtE7ciBg+p6fk2K0Gbdzt/UOz/Ek6xWH
 nXEtCDbz05r5UFzrsABe/F78UxzPCq7sRBWMXPWE92068MdC6VjTWLX9OubT7GHqgt2l
 UUKw==
X-Gm-Message-State: AOJu0YzJd7AsiPb2Po+qmLF8PnoqVNIBQsKlHVUwIofubibvDAvKrONj
 dTBynoV/KeN+bwRhfVDWEPXcsOQYaoXlepaRi6j0cGyR7sgYC6vD/4jLYqj2yloiufTrHteWDVQ
 RLNbPHkcgL0jPfThjOiJFcTC4VcrRcQmkxDeaQ+Zr4VwLOnsOHmCt3287svk6m8R95Pjwy7L7Wb
 s=
X-Received: by 2002:a17:907:7f23:b0:9b2:982e:339a with SMTP id
 qf35-20020a1709077f2300b009b2982e339amr3121268ejc.22.1697617725331; 
 Wed, 18 Oct 2023 01:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxicI5qaKHL//XioM5hXnJrEkRGKFlbjp9HqbWFIEkAYUJUl5yg4hoGvEtK9UMIzvwMFJdeQ==
X-Received: by 2002:a17:907:7f23:b0:9b2:982e:339a with SMTP id
 qf35-20020a1709077f2300b009b2982e339amr3121257ejc.22.1697617725021; 
 Wed, 18 Oct 2023 01:28:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 dc12-20020a170906c7cc00b009a1dbf55665sm1160257ejb.161.2023.10.18.01.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] configure: unify handling of several Debian cross
 containers
Date: Wed, 18 Oct 2023 10:27:48 +0200
Message-ID: <20231018082752.322306-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Debian and GNU architecture names match very often, even though
there are common cases (32-bit Arm or 64-bit x86) where they do not
and other cases in which the GNU triplet is actually a quadruplet.
But it is still possible to group the common case into a single
case inside probe_target_compiler.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/configure b/configure
index 200570a3d18..4b24c572d56 100755
--- a/configure
+++ b/configure
@@ -1281,10 +1281,6 @@ probe_target_compiler() {
         container_cross_prefix=aarch64-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc
         ;;
-      alpha)
-        container_image=debian-alpha-cross
-        container_cross_prefix=alpha-linux-gnu-
-        ;;
       arm)
         # We don't have any bigendian build tools so we only use this for ARM
         container_image=debian-armhf-cross
@@ -1299,10 +1295,6 @@ probe_target_compiler() {
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
         ;;
-      hppa)
-        container_image=debian-hppa-cross
-        container_cross_prefix=hppa-linux-gnu-
-        ;;
       i386)
         container_image=fedora-i386-cross
         container_cross_prefix=
@@ -1311,10 +1303,6 @@ probe_target_compiler() {
         container_image=debian-loongarch-cross
         container_cross_prefix=loongarch64-unknown-linux-gnu-
         ;;
-      m68k)
-        container_image=debian-m68k-cross
-        container_cross_prefix=m68k-linux-gnu-
-        ;;
       microblaze)
         container_image=debian-microblaze-cross
         container_cross_prefix=microblaze-linux-musl-
@@ -1327,14 +1315,6 @@ probe_target_compiler() {
         container_image=debian-mips64-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      mipsel)
-        container_image=debian-mipsel-cross
-        container_cross_prefix=mipsel-linux-gnu-
-        ;;
-      mips)
-        container_image=debian-mips-cross
-        container_cross_prefix=mips-linux-gnu-
-        ;;
       nios2)
         container_image=debian-nios2-cross
         container_cross_prefix=nios2-linux-gnu-
@@ -1349,22 +1329,6 @@ probe_target_compiler() {
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         container_cross_cc=${container_cross_prefix}gcc-10
         ;;
-      riscv64)
-        container_image=debian-riscv64-test-cross
-        container_cross_prefix=riscv64-linux-gnu-
-        ;;
-      s390x)
-        container_image=debian-s390x-cross
-        container_cross_prefix=s390x-linux-gnu-
-        ;;
-      sh4)
-        container_image=debian-sh4-cross
-        container_cross_prefix=sh4-linux-gnu-
-        ;;
-      sparc64)
-        container_image=debian-sparc64-cross
-        container_cross_prefix=sparc64-linux-gnu-
-        ;;
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
@@ -1379,6 +1343,11 @@ probe_target_compiler() {
         # default to the dc232b cpu
         container_cross_prefix=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-
         ;;
+      *)
+        # Debian and GNU architecture names usually match
+        container_image=debian-$target_arch-cross
+        container_cross_prefix=$target_arch-linux-gnu-
+        ;;
     esac
     : ${container_cross_cc:=${container_cross_prefix}gcc}
     : ${container_cross_ar:=${container_cross_prefix}ar}
-- 
2.41.0


