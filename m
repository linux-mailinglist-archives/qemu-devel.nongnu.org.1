Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867CE8C5A82
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 19:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBq-0004zd-2g; Tue, 14 May 2024 13:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004pz-J2
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:32 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wB0-0004sy-2R
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso68255166b.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708575; x=1716313375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPxY0E7yxbX5pVQ4/Szl3Q5MOqxhGDVnE0r/P4HexYI=;
 b=pswhmI1uyauhZKJvJDi23y4NcHuYpU4yG1KpHHRrdEBjXh/gzzioBJPEMkNUJRpxNc
 SbiWGKToGpgfmKY0bfdSXtLa5Rarp3IXF5XJQOPpStUdnu2kS1hJtyNxYc9NMV/0eLZi
 VaBdmiCxrmZeUV+ExCyAReLMNn2Ts3dUKwAESZPtSiYZKvNg2da7a93uzgPQpnIWnCaF
 rcmZKw/TPbNsm/W8Ck4NyXiGDzIfiGkVbiTtSxxmay5uLk3vVrq5ypnAIbjmlHj1buhl
 4indqUJEZlqBnTynUaTNoOvmeNqu8ZA6cGeS+NpkXVbmqSC7kooG+L4HK8sy/vuWdxQq
 6P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708575; x=1716313375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPxY0E7yxbX5pVQ4/Szl3Q5MOqxhGDVnE0r/P4HexYI=;
 b=csMy+DeYpDu5KZ7PdOzLFo9I0xFiYVZqvOe0W7/WGDAtnMH+jbM4LpHkMsdXmMK0jC
 TcvwHKUW7htjHi3sGGjWGNumL2FWie/hAU9Dd5vW3cR84deDFxAJVsW5v1Qj2yBb2yQf
 x2cIFBcqhiCGZ6V4qy7tPiQFjY/un6rsBawPpjmvUuIu082LGjsBiIzAAQeHsQjj+2B6
 +27cJfcClt+YPIb+cL8k88gQyNqz8zSjlY+4Lbb7OWWgl0UDQJYYZD+FXW+hCFvdvrPe
 6/tjU4ZDfEn55hePIu4aBiGyASTUryR0nkAtXWWDhOZEqJLu6Ibz7c/LlMqtiChwCWzV
 BbGg==
X-Gm-Message-State: AOJu0YxyoxkQfqFnG5DnGHSnczUpBLuwRQ/nWrVHeh6fc2Mcml1svc4k
 qZZh+1T/CbCNYRiz7sjxLC9PWBmSSdhHo6guZ2FnZCx+BfruhEdE/SwVG+CTt2M=
X-Google-Smtp-Source: AGHT+IHW8/2pSHteaIrQI9CuSbOuoVQfbUULwX7TH0x1Tt0WTVyfGG8JhpH5vBhs0f5DIyGF/VqXdA==
X-Received: by 2002:a17:906:3815:b0:a58:7172:1ab0 with SMTP id
 a640c23a62f3a-a5a2d1b0fe2mr1268419166b.16.1715708574915; 
 Tue, 14 May 2024 10:42:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17865sm737840166b.204.2024.05.14.10.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E3A05FA19;
 Tue, 14 May 2024 18:42:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 02/11] scripts/update-linux-header.sh: be more src tree
 friendly
Date: Tue, 14 May 2024 18:42:44 +0100
Message-Id: <20240514174253.694591-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Running "install_headers" in the Linux source tree is fairly
unfriendly as out-of-tree builds will start complaining about the
kernel source being non-pristine. As we have a temporary directory for
the install we should also do the build step here. So now we have:

  $tmpdir/
    $blddir/
    $hdrdir/

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240510111802.241284-1-alex.bennee@linaro.org>
---
 scripts/update-linux-headers.sh | 80 +++++++++++++++++----------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 36f3e91fe4..8963c39189 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -27,6 +27,8 @@
 #   types like "__u64".  This work is done in the cp_portable function.
 
 tmpdir=$(mktemp -d)
+hdrdir="$tmpdir/headers"
+blddir="$tmpdir/build"
 linux="$1"
 output="$2"
 
@@ -110,56 +112,56 @@ for arch in $ARCHLIST; do
         arch_var=ARCH
     fi
 
-    make -C "$linux" INSTALL_HDR_PATH="$tmpdir" $arch_var=$arch headers_install
+    make -C "$linux" O="$blddir" INSTALL_HDR_PATH="$hdrdir" $arch_var=$arch headers_install
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
     for header in kvm.h unistd.h bitsperlong.h mman.h; do
-        cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
+        cp "$hdrdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
 
     if [ $arch = mips ]; then
-        cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
-        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
-        cp "$tmpdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
-        cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
+        cp "$hdrdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
+        cp "$hdrdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
+        cp "$hdrdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
+        cp "$hdrdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
     fi
     if [ $arch = powerpc ]; then
-        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
-        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
+        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
     fi
 
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
     if [ $arch = s390 ]; then
-        cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
-        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
-        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
+        cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
+        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
     fi
     if [ $arch = arm ]; then
-        cp "$tmpdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
-        cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
-        cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
+        cp "$hdrdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
+        cp "$hdrdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
+        cp "$hdrdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
     fi
     if [ $arch = arm64 ]; then
-        cp "$tmpdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
+        cp "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
     fi
     if [ $arch = x86 ]; then
-        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
-        cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
-        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
-        cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
+        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
+        cp "$hdrdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
+        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
+        cp_portable "$hdrdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
         sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
-               "$tmpdir/include/asm/bootparam.h" > "$tmpdir/bootparam.h"
-        cp_portable "$tmpdir/bootparam.h" \
+               "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
+        cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-        cp_portable "$tmpdir/include/asm/setup_data.h" \
+        cp_portable "$hdrdir/include/asm/setup_data.h" \
                     "$output/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
-        cp "$tmpdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
+        cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
     fi
 done
 arch=
@@ -169,13 +171,13 @@ mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
               vduse.h iommufd.h bits.h; do
-    cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
+    cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
 rm -rf "$output/linux-headers/asm-generic"
 mkdir -p "$output/linux-headers/asm-generic"
 for header in unistd.h bitsperlong.h mman-common.h mman.h hugetlb_encode.h; do
-    cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
+    cp "$hdrdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
 done
 
 if [ -L "$linux/source" ]; then
@@ -210,23 +212,23 @@ EOF
 
 rm -rf "$output/include/standard-headers/linux"
 mkdir -p "$output/include/standard-headers/linux"
-for i in "$tmpdir"/include/linux/*virtio*.h \
-         "$tmpdir/include/linux/qemu_fw_cfg.h" \
-         "$tmpdir/include/linux/fuse.h" \
-         "$tmpdir/include/linux/input.h" \
-         "$tmpdir/include/linux/input-event-codes.h" \
-         "$tmpdir/include/linux/udmabuf.h" \
-         "$tmpdir/include/linux/pci_regs.h" \
-         "$tmpdir/include/linux/ethtool.h" \
-         "$tmpdir/include/linux/const.h" \
-         "$tmpdir/include/linux/kernel.h" \
-         "$tmpdir/include/linux/vhost_types.h" \
-         "$tmpdir/include/linux/sysinfo.h" \
-         "$tmpdir/include/misc/pvpanic.h"; do
+for i in "$hdrdir"/include/linux/*virtio*.h \
+         "$hdrdir/include/linux/qemu_fw_cfg.h" \
+         "$hdrdir/include/linux/fuse.h" \
+         "$hdrdir/include/linux/input.h" \
+         "$hdrdir/include/linux/input-event-codes.h" \
+         "$hdrdir/include/linux/udmabuf.h" \
+         "$hdrdir/include/linux/pci_regs.h" \
+         "$hdrdir/include/linux/ethtool.h" \
+         "$hdrdir/include/linux/const.h" \
+         "$hdrdir/include/linux/kernel.h" \
+         "$hdrdir/include/linux/vhost_types.h" \
+         "$hdrdir/include/linux/sysinfo.h" \
+         "$hdrdir/include/misc/pvpanic.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
 mkdir -p "$output/include/standard-headers/drm"
-cp_portable "$tmpdir/include/drm/drm_fourcc.h" \
+cp_portable "$hdrdir/include/drm/drm_fourcc.h" \
             "$output/include/standard-headers/drm"
 
 cat <<EOF >$output/include/standard-headers/linux/types.h
-- 
2.39.2


