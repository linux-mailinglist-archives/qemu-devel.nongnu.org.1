Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC07907FD
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEE-00012m-Du; Sat, 02 Sep 2023 08:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEC-0000zj-Bc
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE9-0001gt-S4
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aPc6QuIQUSjFgfjtGm1gBlb1gbxgW+SxTCr4ISfE8k=;
 b=K1dE23B5nXjmroepP4APEtMgZi4ZQZZUouIMvtKIcS2Su6NQXZ+6YuYba6saAYjgaRimXf
 xvjsnhWCCDM9DQrSjyMV3b5ZHJ2n0aERucn4kHDqvQQujPNUyBa39lP/Wn1am4SI1j3sUd
 /MnUSfq9rQ1B78G/ZwEUEL38lttVLA8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-k-XUWVGUMMqVfckZzz1_FA-1; Sat, 02 Sep 2023 08:59:47 -0400
X-MC-Unique: k-XUWVGUMMqVfckZzz1_FA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f3233861aso360905f8f.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659586; x=1694264386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aPc6QuIQUSjFgfjtGm1gBlb1gbxgW+SxTCr4ISfE8k=;
 b=RhLRN5Kp5tlMxbMJMwTzsKvRkAz3Z86I35iLuSVpBMscoO0IYAsTXurUpdlrJMyreE
 IqCAQTquoJiqTN/9BEODlEISb/9qa7R5prqFyAtjsoUVBneQKSev6Dv7Pjd8Jqn4NuDk
 nlvF6pwjxzmzZoIgoeINqVhRkIFxitWmDjoTqL6wiR1LOoJYWf2MdRgx4X0PZ/W/uP4C
 duA7ZD8/2vONPgNYL4F+R+gJKpTlaD9lSCrwM/feIAcFYLOelbf3cNemb6k+jAgbFQZK
 XdmkPXEK10ZzzBfnKE7YFaD+KkpwM9dPvxel1Qeunx8kMmOCzEzHJ5+8UwB2aUINsxAR
 Oaig==
X-Gm-Message-State: AOJu0YyWbizfzCes+Vf+Y2/n4lSWjeEW8zDtadR/3TAqMuGmc1B7cFVe
 FSh5pRNRK0BRm43mIt12YKDP+rL5iMXNoQr9jMBxt553gYq35WyF4kRRZgQeC8EGd2hVEQfOWq2
 ScSVcN/p5VUtun1uUm0SC3Vvi+uwqIHkwTYvdPsGKPsjrDk187eOmRKLvY6cdr9cCmGkFmDulxr
 U=
X-Received: by 2002:a05:6000:10:b0:319:8261:2087 with SMTP id
 h16-20020a056000001000b0031982612087mr3524360wrx.43.1693659586017; 
 Sat, 02 Sep 2023 05:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDmtgGP6bA19E4YAQvgmKud8VQ2aGZfargJokHSkxUkJwjn2U9zC+Kl2hPf/xXPJauHtKDJg==
X-Received: by 2002:a05:6000:10:b0:319:8261:2087 with SMTP id
 h16-20020a056000001000b0031982612087mr3524349wrx.43.1693659585610; 
 Sat, 02 Sep 2023 05:59:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adff5c1000000b0031ad5a54bedsm8532813wrp.9.2023.09.02.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/15] meson: compile bundled device trees
Date: Sat,  2 Sep 2023 14:59:24 +0200
Message-ID: <20230902125934.113017-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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


