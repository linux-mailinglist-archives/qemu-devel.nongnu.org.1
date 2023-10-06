Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BF7BB622
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinL-0008Hj-32; Fri, 06 Oct 2023 07:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinH-0008Gv-AP
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinE-0000KI-AV
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOiT5Haq07zJc+LpYrAi9F7AEAvUR4uyjglw1xzimeg=;
 b=XU7snQf+5aDIhCStXwwkQQW3jRz9iahYR0a25vA72kxpriq65LoAeTWSZv4qKfY+503v2L
 LsyVg/PGdBN90zWYMPV5AE7vBgd74nnyB2f6nIScr4OYYVFMX4YZ+OR0bkZsGsoVQG44zE
 fxQQeyUpHN7NIDAOKm5GpnSx1puLQU8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-f6Vrja-GO-qR6u1qiAe3rQ-1; Fri, 06 Oct 2023 07:14:45 -0400
X-MC-Unique: f6Vrja-GO-qR6u1qiAe3rQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-537fb536554so1818298a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590884; x=1697195684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOiT5Haq07zJc+LpYrAi9F7AEAvUR4uyjglw1xzimeg=;
 b=sqFumtIhuIEAVyjA0zrGAFgK82rOmJDi7l1ION+G7IQn5hx3o46dGGoKkt1SWB8sox
 O6NWdaK0v5tABNap7yzV5B2XE3G+5HeSU3yRc9xpH2yu1E5/Z7EaCswj+wp5kYvmXvP7
 uGBXZQCOna1eZQPZ+jCO7vWq3yRhqHQvO9QHLS75yFjc1FMsQElU8XoiWb4a5XbNVg7W
 WN7f7bXVI2m28iwX0uxZlLrxv0Jns8whwmQKNkvjshzYTMZuF2o5YhqXrHw8daKPtmH5
 f44sIed8TrCRHJhYspgK9ARErXm2TdmzcGW7MUrqHZc5rvpj5qYYkZ1a0El0/VnSQIu0
 iuyw==
X-Gm-Message-State: AOJu0YyLrOfL4jQGjA+aEY1tdYDH/vlnwst7VHDpg3dSJ9eR9e5B2bQm
 +F/M9jJV4xdDeuOojEdjslzU0112nWchgyCf1+XqGK2I+HeYA3N2VxEokzjdbC3fvQ54sB5Iv6H
 QPvlmVyRs/vxn+ZIt03PJ+uK4d2ZDKs9cGBd8zlkCjYL9Qk4fTk4j74h9FitME8xzyGVB6HI9Wo
 U=
X-Received: by 2002:a05:6402:b0f:b0:536:aead:3486 with SMTP id
 bm15-20020a0564020b0f00b00536aead3486mr5798411edb.40.1696590883757; 
 Fri, 06 Oct 2023 04:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQ3d5bB2JDGDNngn5p9yKYPsBzbxZuqp6aAvHKOIj0gcXcEQ9442Zb3yEa1mKmiFkwOL4Vg==
X-Received: by 2002:a05:6402:b0f:b0:536:aead:3486 with SMTP id
 bm15-20020a0564020b0f00b00536aead3486mr5798401edb.40.1696590883456; 
 Fri, 06 Oct 2023 04:14:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 v4-20020aa7d9c4000000b0052284228e3bsm2420488eds.8.2023.10.06.04.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/26] meson: Rename target_softmmu_arch -> target_system_arch
Date: Fri,  6 Oct 2023 13:14:02 +0200
Message-ID: <20231006111412.13130-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Finish the convertion started with commit de6cd7599b
("meson: Replace softmmu_ss -> system_ss"). If the
$target_type is 'system', then use the target_system_arch[]
source set :)

Mechanical change doing:

  $ sed -i -e s/target_softmmu_arch/target_system_arch/g \
      $(git grep -l target_softmmu_arch)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-13-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst   | 4 ++--
 meson.build                   | 4 ++--
 target/alpha/meson.build      | 2 +-
 target/arm/meson.build        | 2 +-
 target/avr/meson.build        | 2 +-
 target/cris/meson.build       | 2 +-
 target/hppa/meson.build       | 2 +-
 target/i386/meson.build       | 2 +-
 target/loongarch/meson.build  | 2 +-
 target/m68k/meson.build       | 2 +-
 target/microblaze/meson.build | 2 +-
 target/mips/meson.build       | 2 +-
 target/nios2/meson.build      | 2 +-
 target/openrisc/meson.build   | 2 +-
 target/ppc/meson.build        | 2 +-
 target/riscv/meson.build      | 2 +-
 target/rx/meson.build         | 2 +-
 target/s390x/meson.build      | 2 +-
 target/sh4/meson.build        | 2 +-
 target/sparc/meson.build      | 2 +-
 target/tricore/meson.build    | 2 +-
 target/xtensa/meson.build     | 2 +-
 22 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 0f990bb3e90..21f78da7d1d 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -225,14 +225,14 @@ Target-dependent emulator sourcesets:
   The sourceset is only used for system emulators.
 
   Each subdirectory in ``target/`` instead should add one sourceset to each
-  of the ``target_arch`` and ``target_softmmu_arch``, which are used respectively
+  of the ``target_arch`` and ``target_system_arch``, which are used respectively
   for all emulators and for system emulators only.  For example::
 
     arm_ss = ss.source_set()
     arm_system_ss = ss.source_set()
     ...
     target_arch += {'arm': arm_ss}
-    target_softmmu_arch += {'arm': arm_system_ss}
+    target_system_arch += {'arm': arm_system_ss}
 
 Module sourcesets:
   There are two dictionaries for modules: ``modules`` is used for
diff --git a/meson.build b/meson.build
index 8890dc57480..497a85eb9fe 100644
--- a/meson.build
+++ b/meson.build
@@ -3214,7 +3214,7 @@ modules = {}
 target_modules = {}
 hw_arch = {}
 target_arch = {}
-target_softmmu_arch = {}
+target_system_arch = {}
 target_user_arch = {}
 
 ###############
@@ -3734,7 +3734,7 @@ foreach target : target_dirs
   endif
   if target.endswith('-softmmu')
     target_type='system'
-    t = target_softmmu_arch[target_base_arch].apply(config_target, strict: false)
+    t = target_system_arch[target_base_arch].apply(config_target, strict: false)
     arch_srcs += t.sources()
     arch_deps += t.dependencies()
 
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 3f5253c0027..d3502dd823f 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -15,4 +15,4 @@ alpha_system_ss = ss.source_set()
 alpha_system_ss.add(files('machine.c'))
 
 target_arch += {'alpha': alpha_ss}
-target_softmmu_arch += {'alpha': alpha_system_ss}
+target_system_arch += {'alpha': alpha_system_ss}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index e645e456da4..5d04a8e94f2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -35,4 +35,4 @@ else
 endif
 
 target_arch += {'arm': arm_ss}
-target_softmmu_arch += {'arm': arm_system_ss}
+target_system_arch += {'arm': arm_system_ss}
diff --git a/target/avr/meson.build b/target/avr/meson.build
index a24cf6d26de..3e172bde1ce 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -17,4 +17,4 @@ avr_ss.add(files(
 avr_system_ss.add(files('machine.c'))
 
 target_arch += {'avr': avr_ss}
-target_softmmu_arch += {'avr': avr_system_ss}
+target_system_arch += {'avr': avr_system_ss}
diff --git a/target/cris/meson.build b/target/cris/meson.build
index 07dc3a5682f..bbfcdf7f7a3 100644
--- a/target/cris/meson.build
+++ b/target/cris/meson.build
@@ -14,4 +14,4 @@ cris_system_ss.add(files(
 ))
 
 target_arch += {'cris': cris_ss}
-target_softmmu_arch += {'cris': cris_system_ss}
+target_system_arch += {'cris': cris_system_ss}
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
index 59b68e82e2b..f47e54f5fa9 100644
--- a/target/hppa/meson.build
+++ b/target/hppa/meson.build
@@ -20,4 +20,4 @@ hppa_system_ss.add(files(
 ))
 
 target_arch += {'hppa': hppa_ss}
-target_softmmu_arch += {'hppa': hppa_system_ss}
+target_system_arch += {'hppa': hppa_system_ss}
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 6f1036d4699..7c74bfa8591 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -31,5 +31,5 @@ subdir('hvf')
 subdir('tcg')
 
 target_arch += {'i386': i386_ss}
-target_softmmu_arch += {'i386': i386_system_ss}
+target_system_arch += {'i386': i386_system_ss}
 target_user_arch += {'i386': i386_user_ss}
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 7fbf045a5d2..18e8191e2b6 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -30,4 +30,4 @@ common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
 
 target_arch += {'loongarch': loongarch_ss}
-target_softmmu_arch += {'loongarch': loongarch_system_ss}
+target_system_arch += {'loongarch': loongarch_system_ss}
diff --git a/target/m68k/meson.build b/target/m68k/meson.build
index 355db26c6f5..8d3f9ce2880 100644
--- a/target/m68k/meson.build
+++ b/target/m68k/meson.build
@@ -16,4 +16,4 @@ m68k_system_ss.add(files(
 ))
 
 target_arch += {'m68k': m68k_ss}
-target_softmmu_arch += {'m68k': m68k_system_ss}
+target_system_arch += {'m68k': m68k_system_ss}
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 50fd9ff378d..3ed4fbb67a7 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -17,4 +17,4 @@ microblaze_system_ss.add(files(
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-target_softmmu_arch += {'microblaze': microblaze_system_ss}
+target_system_arch += {'microblaze': microblaze_system_ss}
diff --git a/target/mips/meson.build b/target/mips/meson.build
index f35e8f0ecad..e57ef24ecf4 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -19,5 +19,5 @@ endif
 mips_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 target_arch += {'mips': mips_ss}
-target_softmmu_arch += {'mips': mips_system_ss}
+target_system_arch += {'mips': mips_system_ss}
 target_user_arch += {'mips': mips_user_ss}
diff --git a/target/nios2/meson.build b/target/nios2/meson.build
index 8f0f9dc6289..12d8abf0bd2 100644
--- a/target/nios2/meson.build
+++ b/target/nios2/meson.build
@@ -14,4 +14,4 @@ nios2_system_ss.add(files(
 ))
 
 target_arch += {'nios2': nios2_ss}
-target_softmmu_arch += {'nios2': nios2_system_ss}
+target_system_arch += {'nios2': nios2_system_ss}
diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
index c1cd943f78f..31608b6dc7f 100644
--- a/target/openrisc/meson.build
+++ b/target/openrisc/meson.build
@@ -22,4 +22,4 @@ openrisc_system_ss.add(files(
 ))
 
 target_arch += {'openrisc': openrisc_ss}
-target_softmmu_arch += {'openrisc': openrisc_system_ss}
+target_system_arch += {'openrisc': openrisc_system_ss}
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 4c2635039e3..97ceb6e7c00 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -55,4 +55,4 @@ ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
 ))
 
 target_arch += {'ppc': ppc_ss}
-target_softmmu_arch += {'ppc': ppc_system_ss}
+target_system_arch += {'ppc': ppc_system_ss}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 660078bda1f..ff60b21d048 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -39,4 +39,4 @@ riscv_system_ss.add(files(
 ))
 
 target_arch += {'riscv': riscv_ss}
-target_softmmu_arch += {'riscv': riscv_system_ss}
+target_system_arch += {'riscv': riscv_system_ss}
diff --git a/target/rx/meson.build b/target/rx/meson.build
index 8de0ad49b9b..d196737ce33 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -13,4 +13,4 @@ rx_ss.add(files(
   'disas.c'))
 
 target_arch += {'rx': rx_ss}
-target_softmmu_arch += {'rx': ss.source_set()}
+target_system_arch += {'rx': ss.source_set()}
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 42ed38942a0..02ca43d9f00 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -40,5 +40,5 @@ subdir('tcg')
 subdir('kvm')
 
 target_arch += {'s390x': s390x_ss}
-target_softmmu_arch += {'s390x': s390x_system_ss}
+target_system_arch += {'s390x': s390x_system_ss}
 target_user_arch += {'s390x': s390x_user_ss}
diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index a78e9ec7e4e..fe09f96684b 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -11,4 +11,4 @@ sh4_system_ss = ss.source_set()
 sh4_system_ss.add(files('monitor.c'))
 
 target_arch += {'sh4': sh4_ss}
-target_softmmu_arch += {'sh4': sh4_system_ss}
+target_system_arch += {'sh4': sh4_system_ss}
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
index d32e67b287e..48025cce762 100644
--- a/target/sparc/meson.build
+++ b/target/sparc/meson.build
@@ -20,4 +20,4 @@ sparc_system_ss.add(files(
 ))
 
 target_arch += {'sparc': sparc_ss}
-target_softmmu_arch += {'sparc': sparc_system_ss}
+target_system_arch += {'sparc': sparc_system_ss}
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index 34825b60481..45f49f01288 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -12,4 +12,4 @@ tricore_ss.add(zlib)
 tricore_system_ss = ss.source_set()
 
 target_arch += {'tricore': tricore_ss}
-target_softmmu_arch += {'tricore': tricore_system_ss}
+target_system_arch += {'tricore': tricore_system_ss}
diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index 95692bd75fd..f8d60101e3d 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -24,4 +24,4 @@ xtensa_system_ss.add(files(
 ))
 
 target_arch += {'xtensa': xtensa_ss}
-target_softmmu_arch += {'xtensa': xtensa_system_ss}
+target_system_arch += {'xtensa': xtensa_system_ss}
-- 
2.41.0


