Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57D7E7AEF
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NtX-00049c-GB; Fri, 10 Nov 2023 04:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1NtR-000480-Cx
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1NtM-0005lJ-7B
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699608811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tBCjXd6MN5whkUidc8Z8YGzlyTzID2NTEQolnZ2fGZ4=;
 b=JqJVEBbS31viYTqgyRqZkBv78SHX829RP/6ucUJpNn/GYs23tE5iMg+YZPsRoBgSGJmUMY
 1NjHnpjmXhdVjg7YwCrYoZ4cLDPz0tAsocVKG0inVGVn6Nac7Xe7QjBcddVltDy6IuSiyB
 LA2yPOzB8a5l5/5Gow6nXMr0I36HqGU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-m7PAK_2kPCKXK_F-YK_Q5A-1; Fri, 10 Nov 2023 04:33:29 -0500
X-MC-Unique: m7PAK_2kPCKXK_F-YK_Q5A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-544b5d65a1aso1445659a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699608807; x=1700213607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBCjXd6MN5whkUidc8Z8YGzlyTzID2NTEQolnZ2fGZ4=;
 b=PefaML/Y7+6S1MyiUVp4a/OFLkBLleFeUBTiJqAsXeSlr0NkoaXKYOTLi0lCY6xIOu
 YJW0H92JeIJTXFw0e6k8TIcCytWBmFPW/4gFfBXlKwWaYq2Sf41lT7SQEGrI9HyU3D6Y
 L6qylFDjw2tqqkrro1taxx13EyEchyEVMnzKX9qfqOj+H8Mwvfi6xr/d3UYV6aF2wd6/
 sqt+YDmkjGuIxWN1uLoyf/l9P3hEE4ABVTYyZcpuVpWUzPkM5ZidP1J19YGRtzeLj0Ik
 sYQ9Srdy2F5G3gECvqd3OkayaVLydZIa4bf2VmBfhf05uZq2mp5doT3b4pyA1W9GlK/o
 WyWw==
X-Gm-Message-State: AOJu0YyfLodMhIxL49/EN+o95qytfCB0qVXmyy98SF4g9gEqih0S62sY
 2vAwLpBV4lKQDXCpygToGDX3aIEZJoCB92FlMRjSnB6SSGLxSKkuAi+8Znz4NA22fqquKOxCK5U
 fMTA3SmgT+Vj3Szqap1DgeRjCQOMrjhuMpsYm+dY51kMKF25ivLgk0GjuosQ0D+j9Ini4N9yyuE
 Y=
X-Received: by 2002:a50:8d12:0:b0:540:9d0c:75fc with SMTP id
 s18-20020a508d12000000b005409d0c75fcmr5703696eds.26.1699608807067; 
 Fri, 10 Nov 2023 01:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCppdBotkd6MbPdugOUvtPnMKzbPHQCE8NI7GyFimpWBq+zK3SVBmHnanSNvPSJMXdiVJxjw==
X-Received: by 2002:a50:8d12:0:b0:540:9d0c:75fc with SMTP id
 s18-20020a508d12000000b005409d0c75fcmr5703680eds.26.1699608806631; 
 Fri, 10 Nov 2023 01:33:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a056402114d00b00540e934bf8dsm884520edw.43.2023.11.10.01.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:33:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	jsnow@redhat.com
Subject: [PATCH] tests: respect --enable/--disable-download for Avocado
Date: Fri, 10 Nov 2023 10:33:25 +0100
Message-ID: <20231110093325.917900-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Pass the content of $mkvenv_flags (which is either "--online"
or empty) down to tests/Makefile.include.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 9 +++++----
 tests/Makefile.include | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index abcb199aa87..2da3c278db6 100755
--- a/configure
+++ b/configure
@@ -968,14 +968,14 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 
 # Conditionally ensure Sphinx is installed.
 
-mkvenv_flags=""
-if test "$download" = "enabled" -a "$docs" = "enabled" ; then
-    mkvenv_flags="--online"
+mkvenv_online_flag=""
+if test "$download" = "enabled" ; then
+    mkvenv_online_flag=" --online"
 fi
 
 if test "$docs" != "disabled" ; then
     if ! $mkvenv ensuregroup \
-         $mkvenv_flags \
+         $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
          ${source_path}/pythondeps.toml docs;
     then
         if test "$docs" = "enabled" ; then
@@ -1631,6 +1631,7 @@ if test "$container" != no; then
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
+echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index dab1989a071..c9d1674bd07 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -111,7 +111,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(PYTHON) python/scripts/mkvenv.py ensuregroup --online $< avocado
+	$(MKVENV_ENSUREGROUP) $< avocado
 	$(call quiet-command, touch $@)
 
 $(TESTS_RESULTS_DIR):
-- 
2.41.0


