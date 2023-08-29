Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D519578C047
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6q-0002nj-ON; Tue, 29 Aug 2023 04:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6h-0002fQ-50
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6c-0008Sa-I2
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FauAQsYjXDlu9ZECvKkk/e1x+qBM0JTooSFiC+XHukk=;
 b=Rbq4wM51nnppdIGVcKJVNSzbeoCD3Mgs39J+06Pw75GLjXMbl6LLwobJ9aYTeHodna/fea
 q68t1+i/xjzkn3hRr5IJDQndP/OBqBsTbKbfsvojFTunAQRMvLHuAAeqTJwz0mGCbmoYJB
 7AiYj4L+mBC7I1cxCiv4im0zIyI1VYQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-nHx35vO6PlGG6KedVehM9w-1; Tue, 29 Aug 2023 04:29:43 -0400
X-MC-Unique: nHx35vO6PlGG6KedVehM9w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso2968102f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297782; x=1693902582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FauAQsYjXDlu9ZECvKkk/e1x+qBM0JTooSFiC+XHukk=;
 b=ZsyKgs6GxAXlgXRDyJPVVPcyRU1H/B5s8N3IeE3pJKy/nPrilpzlbI5xod7vv2Kfab
 FhrkoGomZr5g0qbY2Mly+KiCKuwhNIEbHrmb+WZhqZrdXMz3smYPQtD8JXiyG3FcTmN2
 4euCaKsnkKLG6tPwLtRuQwUw7iyjvjsNOi8eGmBpoff40V0oAEwLvBIWEY7/0BAf1pye
 wp47mjRYro5UtQcEv+hWS3TB+IbOGYhWvCdkSZME1X3QiTIZwDqgWTVdGSVui0cqjibl
 DqC5WWdJj3pyabzSeWAp+ClhwoSQL8ztK7dsPUhYzH0zm8Y2vCO74F6U3x6dxmLtSX0C
 Cr8w==
X-Gm-Message-State: AOJu0YzEx07w7guW4581+3w2dcNdu4gYi4a5zVOTSPRhtWExWOxV9sLW
 Z88hHiOwqTWV6Luw+V4NkaxnQssLRPDmHi2sz+id0ibaK4+wTtrIyQy450eSAwp5ygyvdm4y7sT
 Kmi3H1i9BIBT+ytUK4mlYygtsRcs4u0cZeGTORBLBSgIMWrIXJr0AK9W8jkzUoH/HKLz1hfveSL
 k=
X-Received: by 2002:a5d:4ace:0:b0:317:7441:1a4 with SMTP id
 y14-20020a5d4ace000000b00317744101a4mr20415517wrs.29.1693297782253; 
 Tue, 29 Aug 2023 01:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcG0qdxlCep6bWalsGGEEk+Z2/oaXdJbS+n0tvSNu30ljmkx8elMC2HW2127tJpVjsJby2Q==
X-Received: by 2002:a5d:4ace:0:b0:317:7441:1a4 with SMTP id
 y14-20020a5d4ace000000b00317744101a4mr20415508wrs.29.1693297781906; 
 Tue, 29 Aug 2023 01:29:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a5d43c3000000b003140fff4f75sm12898569wrr.17.2023.08.29.01.29.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] meson: compile bundled device trees
Date: Tue, 29 Aug 2023 10:29:26 +0200
Message-ID: <20230829082931.67601-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

If dtc is available, compile the .dts files in the pc-bios directory
instead of using the precompiled binaries.

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


