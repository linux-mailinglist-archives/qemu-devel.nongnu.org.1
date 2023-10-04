Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3681D7B8E1E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8aG-0004Qi-MP; Wed, 04 Oct 2023 16:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8aD-0004Q0-A3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8a3-000207-4t
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gY0kQDX7B48qQXt1ECYc+xk6dihwe6NmbzvrGlL5xrU=;
 b=I6mk9hNX1GPHXsskwdUuj4jR4+RttPh17aEO45g8MLO9dZM7oVrqRxr4wRz6rcIn/9Zg0X
 C1MiYmnNA87bOW3G59mRqZyRefARdMfRjGAORs2o9kIXl/4o8N7R9b09NBogcLBL4dU0+U
 yBDgHyVwu2YI8elcDqshLgPz7SKadyQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-sEG0ejdsOwa7U80KEGPT8Q-1; Wed, 04 Oct 2023 16:34:34 -0400
X-MC-Unique: sEG0ejdsOwa7U80KEGPT8Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65afd7597baso1802776d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451673; x=1697056473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY0kQDX7B48qQXt1ECYc+xk6dihwe6NmbzvrGlL5xrU=;
 b=G6KWRj3mi85vsv2TfVHhBFGOBYIONQ7VGO1ctCbAKIcGlLpbAvrqT3vzqQ3ej9WEOh
 2IhuLkIH+b73A+QVc/pbYnOOr2Ip604z8EWgsN+N8i1B34JOmtufpAlGaZyStUhO8DJD
 i70Qhmj1+10sefm0pgmD0HenvxDXWf6gKnfYhv9IHy6xTPqMQnajSASKREixhbOaxZy6
 1OdEgz39PM3B+yx1rJOJQlVekPZHHJCnztA6Bvoz5TDoF38xNWxYsLwtPGafVYn2eVOV
 frXwMZxxUUweEAigxKueck59J6z8Fvn000ZStTe+3eXFkJmMerb5PZxc68NCdJ+oL+BS
 zIwA==
X-Gm-Message-State: AOJu0YyKz+re223X7dKpfcqTn2mOAvq6VuglC9ZEemku/aTZytqVJka1
 PzahRGe68dr9A2orUYehEPNzgjY2FhI8kn8invQ+GZoGJ4AS/Y9Uy84Fyy541W9Ps5xUDbF9I1I
 os0Dz98oeYkChpkyiIy5i8g7I0qqYTKQ4zNb27hCiHfmXCPhag6NGyrfM3PMyr31EaY4ffFoUsc
 NsZQ==
X-Received: by 2002:ad4:5807:0:b0:658:d8ec:c036 with SMTP id
 dd7-20020ad45807000000b00658d8ecc036mr3340325qvb.3.1696451672921; 
 Wed, 04 Oct 2023 13:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLS/2M2j2jhNeWk2DQUBwSbc2dZiGDVeOsckki27Hnjw2MW4WyXoj41E3N51+KbU07IsDysQ==
X-Received: by 2002:ad4:5807:0:b0:658:d8ec:c036 with SMTP id
 dd7-20020ad45807000000b00658d8ecc036mr3340309qvb.3.1696451672628; 
 Wed, 04 Oct 2023 13:34:32 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:32 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Date: Wed,  4 Oct 2023 16:34:10 -0400
Message-Id: <20231004203418.56508-2-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004203418.56508-1-tfanelli@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Rust sev library provides a C API for the AMD SEV launch ioctls, as
well as the ability to build with meson. Add the Rust sev library as a
QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
APIs provided by it.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 meson.build                   | 8 ++++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 subprojects/sev.wrap          | 6 ++++++
 target/i386/meson.build       | 2 +-
 5 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/sev.wrap

diff --git a/meson.build b/meson.build
index 20ceeb8158..8a17c29de8 100644
--- a/meson.build
+++ b/meson.build
@@ -960,6 +960,13 @@ if not get_option('slirp').auto() or have_system
   endif
 endif
 
+sev = not_found
+if not get_option('sev').auto()
+  sev = dependency('sev',
+                   method: 'pkg-config',
+                   required: get_option('sev'))
+endif
+
 vde = not_found
 if not get_option('vde').auto() or have_system or have_tools
   vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
@@ -4331,6 +4338,7 @@ summary_info += {'libudev':           libudev}
 # Dummy dependency, keep .found()
 summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary_info += {'selinux':           selinux}
+summary_info += {'sev':               sev}
 summary_info += {'libdw':             libdw}
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
diff --git a/meson_options.txt b/meson_options.txt
index 57e265c871..5b8d283717 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -204,6 +204,8 @@ option('sdl_image', type : 'feature', value : 'auto',
        description: 'SDL Image support for icons')
 option('seccomp', type : 'feature', value : 'auto',
        description: 'seccomp support')
+option('sev', type : 'feature', value : 'auto',
+        description: 'Rust AMD SEV library')
 option('smartcard', type : 'feature', value : 'auto',
        description: 'CA smartcard emulation support')
 option('snappy', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e4b46d5715..e585a548fa 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -161,6 +161,7 @@ meson_options_help() {
   printf "%s\n" '  sdl-image       SDL Image support for icons'
   printf "%s\n" '  seccomp         seccomp support'
   printf "%s\n" '  selinux         SELinux support in qemu-nbd'
+  printf "%s\n" '  sev             SEV library support'
   printf "%s\n" '  slirp           libslirp user mode network backend support'
   printf "%s\n" '  slirp-smbd      use smbd (at path --smbd=*) in slirp networking'
   printf "%s\n" '  smartcard       CA smartcard emulation support'
@@ -440,6 +441,8 @@ _meson_option_parse() {
     --disable-seccomp) printf "%s" -Dseccomp=disabled ;;
     --enable-selinux) printf "%s" -Dselinux=enabled ;;
     --disable-selinux) printf "%s" -Dselinux=disabled ;;
+    --enable-sev) printf "%s" -Dsev=enabled ;;
+    --disable-sev) printf "%s" -Dsev=disabled ;;
     --enable-slirp) printf "%s" -Dslirp=enabled ;;
     --disable-slirp) printf "%s" -Dslirp=disabled ;;
     --enable-slirp-smbd) printf "%s" -Dslirp_smbd=enabled ;;
diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
new file mode 100644
index 0000000000..5be1faccf6
--- /dev/null
+++ b/subprojects/sev.wrap
@@ -0,0 +1,6 @@
+[wrap-git]
+url = https://github.com/tylerfanelli/sev
+revision = b81b1da5df50055600a5b0349b0c4afda677cccb
+
+[provide]
+sev = sev_dep
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 6f1036d469..8972a4fb17 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -20,7 +20,7 @@ i386_system_ss.add(files(
   'monitor.c',
   'cpu-sysemu.c',
 ))
-i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
+i386_system_ss.add(when: 'CONFIG_SEV', if_true: [sev, files('sev.c')], if_false: files('sev-sysemu-stub.c'))
 
 i386_user_ss = ss.source_set()
 
-- 
2.40.1


