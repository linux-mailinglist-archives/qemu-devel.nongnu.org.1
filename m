Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DC820A84
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:49:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUU-0006cX-1D; Sun, 31 Dec 2023 03:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTG-0005SF-S1
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTF-0000xk-5a
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tvb+Au24fJMTJ/GoESfYz465Fu2V4RI0U1bPGcnmKmg=;
 b=gXBSyYBzDBot+h5v9X1knA7CGNNuHns1M2BAW+Gtanl8Ru68WzSyQuOcVN/xKB8iKZEz+l
 e5Xgw98Uy9p1I1+wIC4KEx9ZuHBxMx77FWYUi2Z8zmpmNKaLTzTkk7KBVWnY1enhHIdDbz
 QJnR9H8MhZCwIAi1aXGkXBwk6e4QdFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-29WTsqfiOleNj-qNzRbPOQ-1; Sun, 31 Dec 2023 03:46:54 -0500
X-MC-Unique: 29WTsqfiOleNj-qNzRbPOQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3369382a524so5064979f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012413; x=1704617213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tvb+Au24fJMTJ/GoESfYz465Fu2V4RI0U1bPGcnmKmg=;
 b=UJyKJtML6oyVJ/RcUpvNNGT8jiLZE4ubJyn7Fo0I4A/7u/+d/Fwcj5o0ilSCHuCDlI
 ZQVr2luGG7Il/JHMOYI/hXy+ne3npOSyZwxrAWRFtz3RNJ7TYbPb9xZpUw+jYF1lfiXT
 jmY1qNrrX0pD7f8v8NZzFtA8xRi7IC+2ww9ygJMGml+n7IJBFzLk4vLMqctUR6cU5zUn
 rRSrfGuvn1SNWFsC4/6PheTIk3SE1SSC169e5NBdwJYNiuYqXZgvFgOl5LmIzOrVLhff
 tJvNkYvah8/XUMLM57jlRdHErnGEUpBZqalDFK5w7XHXae15AH0qqlXMudQPOpgglAhN
 lPEg==
X-Gm-Message-State: AOJu0Yx58YmI/3JG/qcoYbkwyTZnApq3NL3J6HcRZBxgzPpp6GSJF1sL
 XoXxrXJEYYKB+smYeyhV217e/qSL1PGsEyggte2nFES3Z5lnxqXtliqXA6dBsWJAk9oFfyxs+Lr
 VxOPWbIjJgSQsSiOde8cQIzjlVsylw+G0FokCcWY3kWlfpNr8z6c7WMYw/TRvBpGaFwD04PLK3+
 H5SKEEA2g=
X-Received: by 2002:a1c:6a0d:0:b0:40d:60f2:d37e with SMTP id
 f13-20020a1c6a0d000000b0040d60f2d37emr3011872wmc.1.1704012412893; 
 Sun, 31 Dec 2023 00:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3eJGSh5mA7/WYVbtFIpHW+MzDb1RT9HrwUdMLbpKzQ1ojnl37gkQwHuscpwu28/s5FvnQzg==
X-Received: by 2002:a1c:6a0d:0:b0:40d:60f2:d37e with SMTP id
 f13-20020a1c6a0d000000b0040d60f2d37emr3011865wmc.1.1704012412585; 
 Sun, 31 Dec 2023 00:46:52 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040d6eb862a7sm10666992wmo.41.2023.12.31.00.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/46] meson: rename config_all
Date: Sun, 31 Dec 2023 09:45:00 +0100
Message-ID: <20231231084502.235366-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

config_all now lists only accelerators, rename it to indicate its actual
content.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/meson.build     |  2 +-
 meson.build             | 16 ++++++++--------
 target/arm/meson.build  |  2 +-
 target/mips/meson.build |  2 +-
 tests/fp/meson.build    |  2 +-
 tests/meson.build       |  2 +-
 tests/qtest/meson.build |  8 ++++----
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 900613fc087..f06d88f3430 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -5,7 +5,7 @@ mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loon
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
 
-if 'CONFIG_TCG' in config_all
+if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
diff --git a/meson.build b/meson.build
index 6e5a8a5b48e..754c469ec98 100644
--- a/meson.build
+++ b/meson.build
@@ -2886,7 +2886,7 @@ endif
 
 minikconf = find_program('scripts/minikconf.py')
 
-config_all = {}
+config_all_accel = {}
 config_all_devices = {}
 config_devices_mak_list = []
 config_devices_h = {}
@@ -2974,7 +2974,7 @@ foreach target : target_dirs
   foreach sym: accelerators
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
-      config_all += { sym: 'y' }
+      config_all_accel += { sym: 'y' }
       if target in modular_tcg
         config_target += { 'CONFIG_TCG_MODULAR': 'y' }
       else
@@ -4204,18 +4204,18 @@ endif
 # Targets and accelerators
 summary_info = {}
 if have_system
-  summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
-  summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
-  summary_info += {'WHPX support':      config_all.has_key('CONFIG_WHPX')}
-  summary_info += {'NVMM support':      config_all.has_key('CONFIG_NVMM')}
+  summary_info += {'KVM support':       config_all_accel.has_key('CONFIG_KVM')}
+  summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
+  summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
+  summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
   summary_info += {'Xen support':       xen.found()}
   if xen.found()
     summary_info += {'xen ctrl version':  xen.version()}
   endif
   summary_info += {'Xen emulation':     config_all_devices.has_key('CONFIG_XEN_EMU')}
 endif
-summary_info += {'TCG support':       config_all.has_key('CONFIG_TCG')}
-if config_all.has_key('CONFIG_TCG')
+summary_info += {'TCG support':       config_all_accel.has_key('CONFIG_TCG')}
+if config_all_accel.has_key('CONFIG_TCG')
   if get_option('tcg_interpreter')
     summary_info += {'TCG backend':   'TCI (TCG with bytecode interpreter, slow)'}
   else
diff --git a/target/arm/meson.build b/target/arm/meson.build
index d6c3902e676..46b5a21eb31 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -28,7 +28,7 @@ arm_system_ss.add(files(
 
 subdir('hvf')
 
-if 'CONFIG_TCG' in config_all
+if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
 else
     arm_ss.add(files('tcg-stubs.c'))
diff --git a/target/mips/meson.build b/target/mips/meson.build
index e57ef24ecf4..a26d1e1f792 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -12,7 +12,7 @@ if have_system
   subdir('sysemu')
 endif
 
-if 'CONFIG_TCG' in config_all
+if 'CONFIG_TCG' in config_all_accel
   subdir('tcg')
 endif
 
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index cbc17392d67..9ef322afc42 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -1,4 +1,4 @@
-if 'CONFIG_TCG' not in config_all
+if 'CONFIG_TCG' not in config_all_accel
   subdir_done()
 endif
 # There are namespace pollution issues on Windows, due to osdep.h
diff --git a/tests/meson.build b/tests/meson.build
index 9996a293fbb..32cc15a3ef7 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -76,7 +76,7 @@ endif
 
 subdir('decode')
 
-if 'CONFIG_TCG' in config_all
+if 'CONFIG_TCG' in config_all_accel
   subdir('fp')
 endif
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 40a8bb043e4..565eff4c0a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -155,8 +155,8 @@ qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
-  (config_all.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
-  (config_all.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
+  (config_all_accel.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
+  (config_all_accel.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
 
 qtests_ppc64 = \
@@ -213,12 +213,12 @@ qtests_arm = \
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \
   (cpu != 'arm' and unpack_edk2_blobs ? ['bios-tables-test'] : []) +                            \
-  (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
+  (config_all_accel.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
-  (config_all.has_key('CONFIG_TCG') and                                            \
+  (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   ['arm-cpu-features',
    'numa-test',
-- 
2.43.0


