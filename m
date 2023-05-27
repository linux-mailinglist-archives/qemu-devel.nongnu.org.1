Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AB7133B1
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qEQ-0007Yi-QT; Sat, 27 May 2023 05:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEP-0007YM-Cq
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEN-0007X7-Tc
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aXRTwrxgAA8HszpMerKC6KzDUFfs18FqgX/EGUkzPz4=;
 b=hvVejPr9UB8B1K0IWPTquCoeE3HZT49HPjTw8wcQA0+oaxdWsy8WNDnaBWwvoU8DBl4xco
 M+kZx11FX0Fpi8ln4ClolUr7Gl7RwrWrTFSnuvm51951uxZLxQxTkN3cy0buCjHEd16TG6
 5aXxdDsF159wCzvkQccC2BnP9xV9A8M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ylMCdI2xNXWvfW8P4wboqA-1; Sat, 27 May 2023 05:28:57 -0400
X-MC-Unique: ylMCdI2xNXWvfW8P4wboqA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9737cde2ce8so203866966b.1
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179736; x=1687771736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXRTwrxgAA8HszpMerKC6KzDUFfs18FqgX/EGUkzPz4=;
 b=korlngkcb+z11OoHh11sDiHi5Cd3lHprz60pkrR3qdq7tX2iQcoI7nMl6gIdiSbeQ3
 LQajG1yfPhGVe7yGn5GLSCPIW/BeVxf67CktrPCZ4W+zbaOuqWamVIp0i1yNClBJ8B72
 uRwVd7/Uy0XB+nUmopFhuv0EhHmyrsUKzqlYRrL/7y2+TgMB7A6Y+YeuAFG1VJFTuibR
 uPeYq+2Zuhvm4CK70BE03ylepFACC6kIuFpYDwS9uQADt4bbg5pEBJpulTHKHufFlIrj
 2lydCARATChXn978+wZmGAI6RfdXtdhva2mRJ8oJzI0CEwXPxVWM+sNiOfafU5HyjyVo
 0crA==
X-Gm-Message-State: AC+VfDxiofnFJTscZTtkje//3quUDbvrlN6z6CT/XsRvuaWCxqX5AYXe
 u/WVM4r4qiejHr2PBTciaQU3BoRPZryiBNZweFuIFIg8lbz0mIsm7IwNSRcmCuj+pvUQo1XODsK
 05yCnpzHbCzp6ENq1RXepgugdHx0VDhSFVWRmBGBtJjZbG8EHtczsYIDVv1EwFZr3nmj7Ei5z6u
 I=
X-Received: by 2002:a17:907:2682:b0:96f:7060:9654 with SMTP id
 bn2-20020a170907268200b0096f70609654mr1407848ejc.18.1685179736298; 
 Sat, 27 May 2023 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58NhY4qNBx9TePu1wtj3/QwDwr+fgAR62n5bNRCA6ZfSYtR9va8t18KCo0l4R0WdPS0NfLHA==
X-Received: by 2002:a17:907:2682:b0:96f:7060:9654 with SMTP id
 bn2-20020a170907268200b0096f70609654mr1407832ejc.18.1685179735798; 
 Sat, 27 May 2023 02:28:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a17090603c700b0096a68648329sm3181479eja.214.2023.05.27.02.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:28:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 1/5] configure: remove --with-git= option
Date: Sat, 27 May 2023 11:28:47 +0200
Message-Id: <20230527092851.705884-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
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

There is not really any scenario where one would use any other git
binary than "the first git in the PATH" aka $(command -v git).  In
fact for example "meson subprojects download" or scripts/checkpatch.pl
do not obey the GIT environment variable.

Remove the unnecessary knob, but test for the presence of git in
the configure and git-submodule.sh scripts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                 | 2 +-
 configure                | 6 ++----
 meson.build              | 1 -
 scripts/git-submodule.sh | 8 +++++++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 08fb6a3b058a..eaeab979966c 100644
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ Makefile: .git-submodule-status
 git-submodule-update:
 ifneq ($(GIT_SUBMODULES_ACTION),ignore)
 	$(call quiet-command, \
-		(GIT="$(GIT)" "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
+		("$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
 		"GIT","$(GIT_SUBMODULES)")
 endif
 
diff --git a/configure b/configure
index d674a9667310..370e038e63d7 100755
--- a/configure
+++ b/configure
@@ -791,7 +791,7 @@ fi
 
 case $git_submodules_action in
     update|validate)
-        if test ! -e "$source_path/.git"; then
+        if test ! -e "$source_path/.git" || ! has git; then
             echo "ERROR: cannot $git_submodules_action git submodules without .git"
             exit 1
         fi
@@ -892,7 +892,6 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
-  --with-git=GIT           use specified git [$git]
   --with-git-submodules=update   update git submodules (default if .git dir exists)
   --with-git-submodules=validate fail if git submodules are not up to date
   --with-git-submodules=ignore   do not update or check git submodules (default if no .git dir)
@@ -1699,7 +1698,7 @@ fi
 #######################################
 # generate config-host.mak
 
-if ! (GIT="$git" "$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
+if ! ("$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
     exit 1
 fi
 
@@ -1709,7 +1708,6 @@ echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo >> $config_host_mak
 
 echo all: >> $config_host_mak
-echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_host_mak
 
diff --git a/meson.build b/meson.build
index 2d48aa1e2ef3..b11773ab39e8 100644
--- a/meson.build
+++ b/meson.build
@@ -4027,7 +4027,6 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 
 # Host binaries
 summary_info = {}
-summary_info += {'git':               config_host['GIT']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
 if config_host.has_key('HAVE_GDB_BIN')
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 7be41f594832..33e995bef1ff 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -12,7 +12,7 @@ maybe_modules="$@"
 # if --with-git-submodules=ignore, do nothing
 test "$command" = "ignore" && exit 0
 
-test -z "$GIT" && GIT=git
+GIT=$(command -v git)
 
 cd "$(dirname "$0")/.."
 
@@ -57,6 +57,12 @@ then
     exit 1
 fi
 
+if test -n "$maybe_modules" && test -z "$GIT"
+then
+    echo "$0: unexpectedly called with submodules but git binary not found"
+    exit 1
+fi
+
 modules=""
 for m in $maybe_modules
 do
-- 
2.40.1


