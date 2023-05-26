Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED92712A47
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzn-0004IW-N2; Fri, 26 May 2023 12:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzl-0004Hs-DS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzj-0002gn-Hs
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNAYahTYeswlLkdsp4UV78W2LiMyzPFTpEnfkmkx2I8=;
 b=ePSfyrv69PuPDJCUDz/ol8MpaOc9sl59tpzNPRMCkrn0hqHExx3ZqNMMzTuIwYpovP43yc
 veIKSUH9BvsuAqRLJLpqIWMQFZFhiP7X1PA8ugilk9E22sPhOKEI3Mql4r44q1/RBdak97
 aCah4XXvfM9Qnr0/KDzEAPYoLO5KPQs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-i9v8YQhKMwiye3ljrVbJIw-1; Fri, 26 May 2023 12:08:45 -0400
X-MC-Unique: i9v8YQhKMwiye3ljrVbJIw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514559574a9so1138004a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117324; x=1687709324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNAYahTYeswlLkdsp4UV78W2LiMyzPFTpEnfkmkx2I8=;
 b=KT1zqdnMp0X3kT3PxfuJgVz0H1kYbLje3RKAurg+pYjJd/I8C53YR2IzQ4zUAJHWBt
 3mAyyoSvLX5BykZOkHt17FFzkD1p68Y7hZ9KiSAesnZ3EwvqPPoCDg00I0gjSPCsJzc/
 5V8zbyOmyB1y9q+04Q0hxURFmVwxiAJpWpLaEWRI0otttEFRMkfdBqZysprYEAETc5Of
 CcrfZC9Exj27px1+ACXQHGtxFWPYPki6WimPLdAUulVjs2n6GvMpll0v4P5wN8iNWV7N
 3dhWDtXEYFFVO15alrVE0Y0v8YUXKwsNUL4YVG1TGcXc3lsqPrB8Rk3B1EJVNTA4Qp7A
 SLbQ==
X-Gm-Message-State: AC+VfDyb9/EtVz388t0zuD+5dIV8cgYbmduRPCWL/ShvfrBirLjCSNwC
 KpvNATv+DRKBcq7G4b+F+78IQSMA5W6d9Cg1Ofb+gzy19DgcWIqTSYpZuVwnHy3hOcyNjdA+XSa
 gMdAKytvZLYlPG3mnFkdgr8UV/gjhYnTVM0umvZV4CuE55W7eblfr/aapkZgREtn1OrEp5xZel+
 o=
X-Received: by 2002:a05:6402:2753:b0:50d:83d4:6174 with SMTP id
 z19-20020a056402275300b0050d83d46174mr5833045edd.12.1685117323898; 
 Fri, 26 May 2023 09:08:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vZsBDdACPKtRiOHMj8qX+puK0/lcQmSo/BX0tp5KIDhCvlTUvqDPQvQKxj1CsW0G8gBNq4w==
X-Received: by 2002:a05:6402:2753:b0:50d:83d4:6174 with SMTP id
 z19-20020a056402275300b0050d83d46174mr5833030edd.12.1685117323641; 
 Fri, 26 May 2023 09:08:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j12-20020aa7c0cc000000b0051446e55cb0sm85825edp.81.2023.05.26.09.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/12] meson: use subproject for keycodemapdb
Date: Fri, 26 May 2023 18:08:23 +0200
Message-Id: <20230526160824.655279-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

By using a subproject, our own meson.build can use variables from
the subproject instead of hard-coded paths.  This is also the first step
towards managing downloads with .wrap files instead of submodule.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
index d42bbd07310b..0e9305848955 100755
--- a/configure
+++ b/configure
@@ -253,7 +253,7 @@ else
     git_submodules_action="ignore"
 fi
 
-git_submodules="ui/keycodemapdb"
+git_submodules="subprojects/keycodemapdb"
 git="git"
 debug_tcg="no"
 docs="auto"
@@ -805,7 +805,7 @@ case $git_submodules_action in
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


