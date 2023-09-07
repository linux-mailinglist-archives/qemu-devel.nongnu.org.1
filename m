Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3A79727E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdR-0003Oq-No; Thu, 07 Sep 2023 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdG-00034w-Hk
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdE-0007MQ-7W
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aPc6QuIQUSjFgfjtGm1gBlb1gbxgW+SxTCr4ISfE8k=;
 b=i9vdWX+KuwvfTyz3Gu058pYujZlIufOUHp3HQv6MgTnMiPm+OQRhKSoNtuwYs2yRRDpxbi
 jrSmfC5ri40jnDr3g/CPNwBc6elkOPdonCCUfoKT1f3MFJ0fKD+Gr/EqyRoDtn1As3VF1A
 6Nw0Yip5g7xxf5NO7+e54BKBr4FXPgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-7P5iIZPSOP-WnzFrWedf6A-1; Thu, 07 Sep 2023 09:01:05 -0400
X-MC-Unique: 7P5iIZPSOP-WnzFrWedf6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so7317275e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091662; x=1694696462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aPc6QuIQUSjFgfjtGm1gBlb1gbxgW+SxTCr4ISfE8k=;
 b=lxo8W5oQE9hOyTjY2jEMlgCifMrs1bCKt1pJcnW1ApnXztIRBbyDu3GscCgbDPQOjw
 18gyp+txQNnBvKF8v2Tx/fZxu41bzeYwoWwK55UTq6FVx5WqLccyVtxmZrE4Z8Qf8vBT
 DE/pd2CYOs6wGwEgSYoLG5WP3uhYMeRKBNnNBKEnKxdq2zf9C0eSyCZOTWT5WY4ILjXc
 Z+7LOUnj4I1Pr8bg8LOYwREeqWhPhpmYvkN6NoZDW0YcHkeMylxKPhPzURNXUEM0rPz8
 S3eEcs3PC2si/BHS1URji19oe/6k7RaCy+NrxO7eh4+Y9t7aqRrqlptXAMo27KtKUxS6
 lTFA==
X-Gm-Message-State: AOJu0YwUuwaE86BcrCWV/a5LaGN/fZmgZF1PXQhs2Kdf5/Ao2XonGFVn
 lLqvPlSWHk6fHe9FO5dC+dxUwlzkiwVjvb0EMzzMB7AXzbH8WFOvR2O6OalOfIqGvQs3Mec2Qsk
 ewF5fJ8/05+Pi39taGE4OB5MgcjsAvQCRAtluIplPfn0jkIHQ8E2NmjplZi1J+yW+68iBkeTytz
 Q=
X-Received: by 2002:a05:600c:378c:b0:401:8225:14ee with SMTP id
 o12-20020a05600c378c00b00401822514eemr4712834wmr.41.1694091662443; 
 Thu, 07 Sep 2023 06:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4rQOKbuE7DSiXMO4/yZfpgZ19rVvee6SeH45ms5GT89v7+aoihQafeIS6M9P1MZmbAeLtkQ==
X-Received: by 2002:a05:600c:378c:b0:401:8225:14ee with SMTP id
 o12-20020a05600c378c00b00401822514eemr4712822wmr.41.1694091662203; 
 Thu, 07 Sep 2023 06:01:02 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1c7917000000b003fe17901fcdsm2440260wme.32.2023.09.07.06.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/51] meson: compile bundled device trees
Date: Thu,  7 Sep 2023 14:59:33 +0200
Message-ID: <20230907130004.500601-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

If dtc is available, compile the .dts files in the pc-bios directory
instead of using the precompiled binaries.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/Makefile    | 19 -------------------
 pc-bios/meson.build | 25 +++++++++++++++++++++----
 2 files changed, 21 insertions(+), 23 deletions(-)
 delete mode 100644 pc-bios/Makefile

diff --git a/pc-bios/Makefile b/pc-bios/Makefile
deleted file mode 100644
index 315288df84e..00000000000
--- a/pc-bios/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# NOTE: only compilable with x86 cross compile tools
-#
-include ../config-host.mak
-
-DEFINES=
-
-TARGETS=
-
-all: $(TARGETS)
-
-%.o: %.S
-	$(CC) $(DEFINES) -c -o $@ $<
-
-%.dtb: %.dts
-	dtc -I dts -O dtb -o $@ $<
-
-clean:
-	rm -f $(TARGETS) *.o *~
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index a7224ef4699..e67fa433a1b 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -57,10 +57,6 @@ blobs = [
   'efi-e1000e.rom',
   'efi-vmxnet3.rom',
   'qemu-nsis.bmp',
-  'bamboo.dtb',
-  'canyonlands.dtb',
-  'petalogix-s3adsp1800.dtb',
-  'petalogix-ml605.dtb',
   'multiboot.bin',
   'multiboot_dma.bin',
   'linuxboot.bin',
@@ -84,6 +80,27 @@ blobs = [
   'vof-nvram.bin',
 ]
 
+dtc = find_program('dtc', required: false)
+foreach f : [
+  'bamboo.dts',
+  'canyonlands.dts',
+  'petalogix-s3adsp1800.dts',
+  'petalogix-ml605.dts',
+]
+  out = fs.replace_suffix(f, '.dtb')
+  if dtc.found()
+    custom_target(f,
+        build_by_default: have_system,
+        input: files(f),
+        output: out,
+        install: get_option('install_blobs'),
+        install_dir: qemu_datadir,
+        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
+  else
+    blobs += out
+  endif
+endforeach
+
 if get_option('install_blobs')
   install_data(blobs, install_dir: qemu_datadir)
 endif
-- 
2.41.0


