Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502E7C9FA1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH94-00042N-1e; Mon, 16 Oct 2023 02:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH92-000424-AM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH90-0005Tv-O3
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTKK/77t6XzfLamnizLTQ3k3sm0qSCgSBszZqr27Eb0=;
 b=a6vAab4XUg/8P8eYlN146EcUSk6WPHyQBtXDLwV8MPTdmZwwjiQD1dxRRoJ9CmGe2bBOus
 V13Fec3GN4M/CuVL9gXr8QwtjI2kYO2FfeHZnC9TwthLzFPgZ4X0BQe59gn0qN0cQnXCvR
 DN8t9M2nnTB/UpwhIQUfOA6iYljzQuM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-JJkGnngoNt6lLB5tY6pLAw-1; Mon, 16 Oct 2023 02:31:59 -0400
X-MC-Unique: JJkGnngoNt6lLB5tY6pLAw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b65c46bca8so10727566b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437918; x=1698042718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTKK/77t6XzfLamnizLTQ3k3sm0qSCgSBszZqr27Eb0=;
 b=vSJ/2a3qcGSDcSaWsktfg89SdWeDr+F/+VUIw04eFvS3jT9vKwRILDz3WEJmLS6WAo
 PjCOLDZ6IX6s+dBU3rjEf8Dkxdc1hbTspfFScroNwPSwFEMSKHU2rs4SJQ+0iFG+U78T
 V8JSWONUs4Ywtfb0LHWVTia+D+LqJEKRftW6PUx4tdngs52wgHOJrJKwHSsYCiFS56ne
 s5ubQUFwqc1ZevTrhWJ7kl9WAok283ROI7TAkTZr+JpzBsLTJoWEitKCnksFqxwUx155
 Lu6Chhu6GktrdoQmhDzOZeznckFCHxS7ZMHR6crqiSQBZEM3QICiZnC1Hz5HiQ/g4vQP
 +p6w==
X-Gm-Message-State: AOJu0Yw2hgVxCIHK1qjVz2Qsx+CzdsxopNGq5dmv+CAHPOIWKyaDGfZF
 3KfEYHGNPEfijymMvnubX2UPhkReDxWCWraxoDC9w2CaLadHseL83h8ABXzc36MGY3s/Sndg8/+
 V3E15hV2Vn2R4yV1BTpPl2bl4F9rN8drSrNdnz3d81Y14Whi7ZnN7ZiNLP7zEOvp25h3NkLFnxl
 4=
X-Received: by 2002:a17:907:6ea5:b0:9bd:f3b0:c087 with SMTP id
 sh37-20020a1709076ea500b009bdf3b0c087mr7358287ejc.2.1697437917756; 
 Sun, 15 Oct 2023 23:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR8J7NsENjnNe+omtLk70t6WQpPBQZaja0Trbg02g5PKqnxjSwj697c73tdhL9nyDEA/d0fQ==
X-Received: by 2002:a17:907:6ea5:b0:9bd:f3b0:c087 with SMTP id
 sh37-20020a1709076ea500b009bdf3b0c087mr7358271ejc.2.1697437917423; 
 Sun, 15 Oct 2023 23:31:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170906254800b009ae69c303aasm3338781ejb.137.2023.10.15.23.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/17] configure: unify handling of several Debian cross
 containers
Date: Mon, 16 Oct 2023 08:31:24 +0200
Message-ID: <20231016063127.161204-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 24f8866e141..18dcb0240ed 100755
--- a/configure
+++ b/configure
@@ -1278,10 +1278,6 @@ probe_target_compiler() {
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
@@ -1296,10 +1292,6 @@ probe_target_compiler() {
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
@@ -1308,10 +1300,6 @@ probe_target_compiler() {
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
@@ -1324,14 +1312,6 @@ probe_target_compiler() {
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
@@ -1346,22 +1326,6 @@ probe_target_compiler() {
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
@@ -1376,6 +1340,11 @@ probe_target_compiler() {
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


