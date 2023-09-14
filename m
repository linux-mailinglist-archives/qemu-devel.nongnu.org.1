Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F397A0C23
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqc7-0003Kv-0W; Thu, 14 Sep 2023 13:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc5-0003KO-9M
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc2-0002ER-I5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhhRFK0ZCoglrBy3GmbzRXf2oYIiYOmczFpn9U0TMwE=;
 b=aQy89sP7TOTwK2w5meoqKPc2GQMcs7HZSLdy2k6efrrihM4nMquOVOcDHbIFQOGpB7zbni
 Ca/v1P3Rdb0GdGKGX9DElLal3iLPSMHO6WabTIZtQIZLzdc8Q/zpzlXZ8ziMjB74VNOUMR
 DSZw/WpxCESRusI83CiFfN5zLQUBISs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Pt1WoCarOKGgs0fC9lJz3g-1; Thu, 14 Sep 2023 13:58:43 -0400
X-MC-Unique: Pt1WoCarOKGgs0fC9lJz3g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-655d7107e70so14181006d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714322; x=1695319122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhhRFK0ZCoglrBy3GmbzRXf2oYIiYOmczFpn9U0TMwE=;
 b=s7RPUXB8ijP6uhq7AnQZzyqyeBwkZ/x/tZa4WI43mUdDVsZX9cx8ZOO+benit6SO1T
 o9PJm4OQPt1MdwOdZuTfzHeYyaB2ntLziPTckprX0y94YKzIRHwDWKL5Y/LyFfqFLoGK
 RiqGuVc+gXiOzeqi+igIP5IWYbMPiYC3nwF3AgVfWb0eT/Yk4062PLQBoz+RV/26G9mm
 RFZWH+JMsIVpr/XjGvbvn+yWO7Dx7AcdS38wkBNPWu78bkxybbxdiQabM+m9j3Vg2xok
 cfAHJdBAPUdCRjsLwUroQIaweJgf1WWgdG0lkaKlJybEzIQNJzsSLyTnkn8daO4zQfHz
 xsFA==
X-Gm-Message-State: AOJu0YyShzT4kg81pjnHAKj9H4eCWuTRpXKEnZHv/e04R+Zm52vUlnL0
 HDBeoYeF5sAAwRE7XUF3Aryq8rqha9XQqLQRjgL+m5YUhAmKTA4iUQpFcQYrtxo4oF9njqoj+xf
 reMBoD065+nJhCAZ/VFUQyVbmP9x/UbKJrkZkxtI24vL4LIBqc+UlZ7RLHhqAG8gz/TSjBxmsfd
 ElZw==
X-Received: by 2002:a0c:ed4d:0:b0:64f:3bec:9b29 with SMTP id
 v13-20020a0ced4d000000b0064f3bec9b29mr6910288qvq.39.1694714321798; 
 Thu, 14 Sep 2023 10:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzo9lelr4NQTAzGe2D1O+I9Nxb6+S7xkx1vnm1PmEcgPIv/P4mZVUwP+UK1g/OkkCeA9eLVw==
X-Received: by 2002:a0c:ed4d:0:b0:64f:3bec:9b29 with SMTP id
 v13-20020a0ced4d000000b0064f3bec9b29mr6910274qvq.39.1694714321486; 
 Thu, 14 Sep 2023 10:58:41 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:39 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 1/8] Add SEV Rust library as dependency with CONFIG_SEV
Date: Thu, 14 Sep 2023 13:58:28 -0400
Message-Id: <20230914175835.382972-2-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
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

The Rust sev library provides a type-safe implementation of the AMD
Secure Encrypted Virtualization (SEV) APIs.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 meson.build                   | 7 +++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 target/i386/meson.build       | 2 +-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5150a74831..7114a4a2b9 100644
--- a/meson.build
+++ b/meson.build
@@ -1079,6 +1079,12 @@ if targetos == 'linux' and (have_system or have_tools)
                        method: 'pkg-config',
                        required: get_option('libudev'))
 endif
+sev = not_found
+if not get_option('sev').auto()
+  sev = dependency('sev', version: '1.2.1',
+                      method: 'pkg-config',
+                      required: get_option('sev'))
+endif
 
 mpathlibs = [libudev]
 mpathpersist = not_found
@@ -4283,6 +4289,7 @@ summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
 summary_info += {'virgl support':     virgl}
 summary_info += {'blkio support':     blkio}
+summary_info += {'sev support':       sev}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
 summary_info += {'Linux AIO support': libaio}
diff --git a/meson_options.txt b/meson_options.txt
index f82d88b7c6..c57d542c0b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -134,6 +134,8 @@ option('cap_ng', type : 'feature', value : 'auto',
        description: 'cap_ng support')
 option('blkio', type : 'feature', value : 'auto',
        description: 'libblkio block device driver')
+option('sev', type : 'feature', value : 'auto',
+        description: 'SEV Rust library')
 option('bpf', type : 'feature', value : 'auto',
         description: 'eBPF support')
 option('cocoa', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e1d178370c..d7deb50bda 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -83,6 +83,7 @@ meson_options_help() {
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  avx512f         AVX512F optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
+  printf "%s\n" '  sev             SEV Rust library'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
   printf "%s\n" '  brlapi          brlapi character device driver'
@@ -227,6 +228,8 @@ _meson_option_parse() {
     --disable-lto) printf "%s" -Db_lto=false ;;
     --enable-blkio) printf "%s" -Dblkio=enabled ;;
     --disable-blkio) printf "%s" -Dblkio=disabled ;;
+    --enable-sev) printf "%s" -Dsev=enabled ;;
+    --disable-sev) printf "%s" -Dsev=disabled ;;
     --block-drv-ro-whitelist=*) quote_sh "-Dblock_drv_ro_whitelist=$2" ;;
     --block-drv-rw-whitelist=*) quote_sh "-Dblock_drv_rw_whitelist=$2" ;;
     --enable-block-drv-whitelist-in-tools) printf "%s" -Dblock_drv_whitelist_in_tools=true ;;
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 6f1036d469..18450dc134 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -6,7 +6,7 @@ i386_ss.add(files(
   'xsave_helper.c',
   'cpu-dump.c',
 ))
-i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_SEV', if_true: [sev, files('host-cpu.c')])
 
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
-- 
2.40.1


