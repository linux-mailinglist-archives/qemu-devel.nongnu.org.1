Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358EA7081B0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd22-0000Pu-Fa; Thu, 18 May 2023 08:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd20-0000PF-13
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd1x-00072n-RG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684414013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldhFLbWV0PQV6H1TtSjgnznB3WBP8NnvGKOcVIhlx2s=;
 b=R8ZgErWLY6e/gh2Qi8szMlwOg20q6O3UUeHAsMSGAn/0jDaT2I/UKQxVOpxL2PNsYNOyWg
 m6/HF/O0QI7XOflRrDSK0Txzu3b0H7vDmJw3FrvhMhSrQ35Q04hzUbwD+m6AF/5SrRC9Uw
 nPB5ZB6bmhxUV4HMQ17a0JKNRKcYJUU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-g_d5yg9JNhq7pxdcc-RViA-1; Thu, 18 May 2023 08:46:52 -0400
X-MC-Unique: g_d5yg9JNhq7pxdcc-RViA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-506beab6a73so2466600a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414010; x=1687006010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldhFLbWV0PQV6H1TtSjgnznB3WBP8NnvGKOcVIhlx2s=;
 b=W/fBrDRqh3FRiVKU2QtJdBb3Bd3l21FYcSjJrqKZap8788/F+i+vK/hPILc708xjTn
 L5FQEBlKbnxMJ4duVW1qFUHEVVR1ODwtlfx5fVFfSwY8VOflzDbUQdms/hN1BPZGD5F9
 JmKwKLWUMiXtrBztXWMiwwaa9qrhOBq9UlQ2gyH7en9punkobIY6MhjkWaAUPh9Ggl6z
 6tPjLscojhbKiYIDXLBMSZ69DKfLZhfwXT+n3qGrrJyzaaZJIoFdVW3DoirT9nJt2mQ4
 gbPKGm/N2stT03rNCmVzRpT8qzOtgLGVybbyz7Qb3dzZupkxq0hb+C6Qek8im+ehHFM+
 RzCA==
X-Gm-Message-State: AC+VfDwHNarfLFHoy9vUMVofoaqAnmhMTQf6nU/uggpYaXhFU4MOr58l
 nDZuUT5Hnfkcr3SN8N+wyUpl6qL5nVMXR4H73ypB5VdbcTNARcZLDpt8hibXI8Mq01dXrS5Sgqd
 nbBRnLOOOvwmqZVIhaAzuVQehEs0C6KQW1tW3qea/xqFIegnVsfTcGWQ4OsJ2dTqOPjLNhGtlGD
 Q=
X-Received: by 2002:a50:ee99:0:b0:50b:ca21:a85e with SMTP id
 f25-20020a50ee99000000b0050bca21a85emr5474566edr.35.1684414010560; 
 Thu, 18 May 2023 05:46:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6f9vHFNIoqXOwzbqCkjohwQ7a+R60ESTmP/TvUgeqRbNMlV6eMiaFwOvD/T+OzulGcS6Xrrg==
X-Received: by 2002:a50:ee99:0:b0:50b:ca21:a85e with SMTP id
 f25-20020a50ee99000000b0050bca21a85emr5474540edr.35.1684414010132; 
 Thu, 18 May 2023 05:46:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k3-20020aa7d8c3000000b0050d56dffc93sm552506eds.12.2023.05.18.05.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:46:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 2/2] meson: use subproject for keycodemapdb
Date: Thu, 18 May 2023 14:46:45 +0200
Message-Id: <20230518124645.1011316-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518124645.1011316-1-pbonzini@redhat.com>
References: <20230518124645.1011316-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

By using a subproject, our own meson.build can use variables from
the subproject instead of hard-coded paths.  In the future, it may
also be possible to use wrap to download the submodule.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules                      | 4 ++--
 configure                        | 4 ++--
 scripts/archive-source.sh        | 2 +-
 {ui => subprojects}/keycodemapdb | 0
 ui/meson.build                   | 6 ++++--
 5 files changed, 9 insertions(+), 7 deletions(-)
 rename {ui => subprojects}/keycodemapdb (100%)

diff --git a/.gitmodules b/.gitmodules
index 3ed5d073d630..f8b2ddf3877c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -25,8 +25,8 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = https://gitlab.com/qemu-project/QemuMacDrivers.git
-[submodule "ui/keycodemapdb"]
-	path = ui/keycodemapdb
+[submodule "subprojects/keycodemapdb"]
+	path = subprojects/keycodemapdb
 	url = https://gitlab.com/qemu-project/keycodemapdb.git
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
diff --git a/configure b/configure
index 5bbca83d9a31..2b6995e16756 100755
--- a/configure
+++ b/configure
@@ -254,7 +254,7 @@ else
     git_submodules_action="ignore"
 fi
 
-git_submodules="ui/keycodemapdb"
+git_submodules="subprojects/keycodemapdb"
 git="git"
 debug_tcg="no"
 docs="auto"
@@ -806,7 +806,7 @@ case $git_submodules_action in
         fi
     ;;
     ignore)
-        if ! test -f "$source_path/ui/keycodemapdb/README"
+        if ! test -f "$source_path/subprojects/keycodemapdb/README"
         then
             echo
             echo "ERROR: missing GIT submodules"
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index b15f6fe6b8fe..a0a3153faa99 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="subprojects/dtc meson ui/keycodemapdb"
+submodules="subprojects/dtc meson subprojects/keycodemapdb"
 submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
diff --git a/ui/keycodemapdb b/subprojects/keycodemapdb
similarity index 100%
rename from ui/keycodemapdb
rename to subprojects/keycodemapdb
diff --git a/ui/meson.build b/ui/meson.build
index 330369707dd7..e24d52b89941 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -162,13 +162,15 @@ keymaps = [
 ]
 
 if have_system or xkbcommon.found()
+  keycodemapdb_proj = subproject('keycodemapdb', required: true)
+  keymap_gen = find_program('keymap-gen', required: true)
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
                   output: output,
                   capture: true,
-                  input: files('keycodemapdb/data/keymaps.csv'),
-                  command: [python, files('keycodemapdb/tools/keymap-gen'),
+                  input: keycodemapdb_proj.get_variable('keymaps_csv'),
+                  command: [python, keycodemapdb_proj.get_variable('keymap_gen'),
                             'code-map',
                             '--lang', 'glib2',
                             '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
-- 
2.40.1


