Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316170925A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvv5-0002EX-3y; Fri, 19 May 2023 04:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvv2-0002EH-SU
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvv1-0000Bc-88
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7hu8guGS9407jlL+W5FPEBijG3LDRFTX9tNbWaP30M=;
 b=ZDJwar9w+/Irpv2Yr0Ve4ifckTv1jgeUBFrJ2ZLNIhxWAj7XoofS/qy9NW1/XaGvqnAGym
 +XOb+Ps0hulE0pHwK/2a584Gz+wHEJwiUOI9v4fl0cl5zDpeRBNFnctdTEmD6y2iOplD9C
 oSafIX5VdGYDFTIC/KuzK/2HKvJ6riI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-abV50k2VO1Su5Z0FdA7wNg-1; Fri, 19 May 2023 04:56:57 -0400
X-MC-Unique: abV50k2VO1Su5Z0FdA7wNg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f6e83685eso38534066b.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486615; x=1687078615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7hu8guGS9407jlL+W5FPEBijG3LDRFTX9tNbWaP30M=;
 b=VCL069G7sps2KyzRNRaKr8SaBwVgfAjTpvHIxS4xRTP3SR1mb5uT0xobzqG1zeoZES
 FySsTwARYUV7vsnrtDpTiR4RWBG5wtnaj/e5xIduMDsBeADw1zggV2EKPH9OeEksQrzV
 wt1+1Kb4IToCVmwjAF/FA7Q2C5lLILDey0aAr42g0dsBJ/9yAjH6QWGq+MtvHTg/Lfpb
 T0nGtZc/Yjeem3GSmKvXrY0nzM9QsjDwyvT4c3tA+Sk9pby3UFkfyJZ9xuZQHKWzh3Rs
 Rt/snDHinleNTuR29pYlmNBP1/+1nukt/4Ep5BNskTW5yABRuyRr7AexQfqWaJ2a4YTS
 kCaA==
X-Gm-Message-State: AC+VfDwPJzvg6X3BtWu7okQp9Zy8ATwGolPiWqUXSqxYaVp+Y9AWD1/r
 vxnOHzhTvN5UpkJAVoWsolO4DpFfmwoJZo1hcpt9obPURthqVRbeKPxqaFll7AY7kZQcOAoTkPQ
 SJPZGRxbTMXUJDm80XDvX1H8PRWoJBke4RSz3972K15XVmXpljkWoZ+MREjGA+a/O1tiDJm3noq
 8=
X-Received: by 2002:a17:907:86aa:b0:966:5c04:2c5a with SMTP id
 qa42-20020a17090786aa00b009665c042c5amr958718ejc.69.1684486615587; 
 Fri, 19 May 2023 01:56:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YYCVuSavaJKHFM08y4m1+JKo/f4GSTLgQK+yFuu924ABZxlyPgcBgyVNFjCXaeoRzWKofSg==
X-Received: by 2002:a17:907:86aa:b0:966:5c04:2c5a with SMTP id
 qa42-20020a17090786aa00b009665c042c5amr958697ejc.69.1684486615158; 
 Fri, 19 May 2023 01:56:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a1709063e9500b009655eb8be26sm2016200ejj.73.2023.05.19.01.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 4/6] meson: use subproject for keycodemapdb
Date: Fri, 19 May 2023 10:56:44 +0200
Message-Id: <20230519085647.1104775-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
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
the subproject instead of hard-coded paths.  This is also the first step
towards managing downloads with .wrap files instead of submodule.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules                      | 4 ++--
 configure                        | 4 ++--
 scripts/archive-source.sh        | 2 +-
 {ui => subprojects}/keycodemapdb | 0
 ui/meson.build                   | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)
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
index a7c2886334f0..dba5ae05b67e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="subprojects/dtc ui/keycodemapdb"
+submodules="subprojects/dtc subprojects/keycodemapdb"
 submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
diff --git a/ui/keycodemapdb b/subprojects/keycodemapdb
similarity index 100%
rename from ui/keycodemapdb
rename to subprojects/keycodemapdb
diff --git a/ui/meson.build b/ui/meson.build
index 330369707dd7..e09b616a66bc 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -162,15 +162,15 @@ keymaps = [
 ]
 
 if have_system or xkbcommon.found()
+  keycodemapdb_proj = subproject('keycodemapdb', required: true)
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
                   output: output,
                   capture: true,
-                  input: files('keycodemapdb/data/keymaps.csv'),
-                  command: [python, files('keycodemapdb/tools/keymap-gen'),
-                            'code-map',
-                            '--lang', 'glib2',
+                  input: keycodemapdb_proj.get_variable('keymaps_csv'),
+                  command: [python, keycodemapdb_proj.get_variable('keymap_gen').full_path(),
+                            'code-map', '--lang', 'glib2',
                             '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
                             '@INPUT0@', e[0], e[1]])
   endforeach
-- 
2.40.1


