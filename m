Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E132D734890
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAzpM-0003Iy-BC; Sun, 18 Jun 2023 17:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qAzpK-0003IW-Bh
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qAzpG-0008Mx-Rp
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687123244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F10R9PGrKM5JoH3anCHxQlhdqGDXYV1PN+ushabGfdM=;
 b=g54vtRMUHDL0I5icJjBYvTfQio6MK5oVStGuWLFNXqsVWgWXeUtDshPVNzpBBIFiqtRmYU
 zG4j2WT6KpccWzX3cB5t3rnqcpOuRXAYo5GTif9HT4vdcOv71yY+KWF85ahPiM65P4DP/8
 Fo1NS+gu9bE9qqdrnUx0QyklxAbtgQI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Orr_unNNPv-kNfB5iPjQPA-1; Sun, 18 Jun 2023 17:20:42 -0400
X-MC-Unique: Orr_unNNPv-kNfB5iPjQPA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so126945466b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687123241; x=1689715241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F10R9PGrKM5JoH3anCHxQlhdqGDXYV1PN+ushabGfdM=;
 b=BS4cSPtMIrVC4Inikk+koLmsTob1b41IHOe/qlpjpgDER64LL8AO1g+OA2mP93mQgY
 YceX2X7lnEJujDsGXU5MJ+V6u9D26gIK2Lix/fST28p1Jhy+m7J8V7nya52OsipIhj6q
 z/hmZH8BrbTWXw0459CYA7Y4cwrP2wGanK/LNSmA77tx5VriEuxzzoV65sptsWrgMb7i
 nShr3wFKEmb3Fq376SkaWQJeKk9d9GH2M5gCd81HvTd/F55mpO/u1nofFdBhCDTSFet/
 0TlbwGDZayOd91EJWPEoymva5tLuJXizMa0CnrZFZinYPClC4fpSWAOKwZ/VbFcmCp38
 pXkg==
X-Gm-Message-State: AC+VfDz0Tr2QN31v75ckdQkIif0dVRhtbrErYAoJm4xfr9+WXFvbkQ7t
 Te+3YxDry2rx/o2AgtzFhKshPfXSEW4bDD+BHZ13VeV5Y90wePiJN6MaZqz153JsCODBb7BUBDx
 PWIyiW8LKUV0A+nw/j6QTjiJDUm0/edn/MsQeiShqhEh4bV7VEJPHapn9J0hvL6nan6lw8hA9YY
 UcHQ==
X-Received: by 2002:a17:907:6090:b0:988:93fb:2e94 with SMTP id
 ht16-20020a170907609000b0098893fb2e94mr1975843ejc.27.1687123241371; 
 Sun, 18 Jun 2023 14:20:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6M4erayhBACnboUHOKqTTGOTp24X0Jh0mHg1vKsci3wRRSPgfoKHKMJNfHexokIIlP4cSgsg==
X-Received: by 2002:a17:907:6090:b0:988:93fb:2e94 with SMTP id
 ht16-20020a170907609000b0098893fb2e94mr1975823ejc.27.1687123240924; 
 Sun, 18 Jun 2023 14:20:40 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a170906258300b00977d194bf42sm13661526ejb.161.2023.06.18.14.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:20:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH] git-submodule.sh: allow running in validate mode without
 previous update
Date: Sun, 18 Jun 2023 23:20:39 +0200
Message-Id: <20230618212039.102052-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The call to git-submodule.sh done in configure may happen without a
previous checkout of the roms/SLOF submodule, or even without a
previous run of the script.

So, handle creating a .git-submodule-status file even in validate
mode.  If git is absent, ensure that all passed directories exists
(because you should be in a fresh untar and will not have stale
arguments to git-submodule.sh) but do no other checks.  If git
is present, ensure that .git-submodule-status contains an entry
for all submodules passed on the command line.

With this change, "ignore" mode is not needed anymore.

Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Fixes: b11f9bd96f4 ("configure: move SLOF submodule handling to pc-bios/s390-ccw", 2023-06-06)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                |  2 +-
 scripts/git-submodule.sh | 72 ++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/configure b/configure
index 86363a7e508..2b41c49c0d1 100755
--- a/configure
+++ b/configure
@@ -758,7 +758,7 @@ done
 
 if ! test -e "$source_path/.git"
 then
-    git_submodules_action="ignore"
+    git_submodules_action="validate"
 fi
 
 # test for any invalid configuration combinations
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 11fad2137cd..c33d8fe4cac 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -9,13 +9,22 @@ command=$1
 shift
 maybe_modules="$@"
 
-# if not running in a git checkout, do nothing
-test "$command" = "ignore" && exit 0
-
+test -z "$maybe_modules" && exit 0
 test -z "$GIT" && GIT=$(command -v git)
 
 cd "$(dirname "$0")/.."
 
+no_git_error=
+if test -n "$maybe_modules" && ! test -e ".git"; then
+    no_git_error='no git checkout exists'
+elif test -n "$maybe_modules" && test -z "$GIT"; then
+    no_git_error='git binary not found'
+fi
+
+is_git() {
+    test -z "$no_git_error"
+}
+
 update_error() {
     echo "$0: $*"
     echo
@@ -34,7 +43,7 @@ update_error() {
 }
 
 validate_error() {
-    if test "$1" = "validate"; then
+    if is_git && test "$1" = "validate"; then
         echo "GIT submodules checkout is out of date, and submodules"
         echo "configured for validate only. Please run"
         echo "  scripts/git-submodule.sh update $maybe_modules"
@@ -51,42 +60,41 @@ check_updated() {
     test "$CURSTATUS" = "$OLDSTATUS"
 }
 
-if test -n "$maybe_modules" && ! test -e ".git"
-then
-    echo "$0: unexpectedly called with submodules but no git checkout exists"
-    exit 1
+if is_git; then
+    test -e $substat || touch $substat
+    modules=""
+    for m in $maybe_modules
+    do
+        $GIT submodule status $m 1> /dev/null 2>&1
+        if test $? = 0
+        then
+            modules="$modules $m"
+            grep $m $substat > /dev/null 2>&1 || $GIT submodule status $module >> $substat
+        else
+            echo "warn: ignoring non-existent submodule $m"
+        fi
+    done
+else
+    modules=$maybe_modules
 fi
 
-if test -n "$maybe_modules" && test -z "$GIT"
-then
-    echo "$0: unexpectedly called with submodules but git binary not found"
-    exit 1
-fi
-
-modules=""
-for m in $maybe_modules
-do
-    $GIT submodule status $m 1> /dev/null 2>&1
-    if test $? = 0
-    then
-        modules="$modules $m"
-    else
-        echo "warn: ignoring non-existent submodule $m"
-    fi
-done
-
 case "$command" in
 status|validate)
-    test -f "$substat" || validate_error "$command"
-    test -z "$maybe_modules" && exit 0
     for module in $modules; do
-        check_updated $module || validate_error "$command"
+        if is_git; then
+            check_updated $module || validate_error "$command"
+        elif ! test -d $module; then
+            echo "$0: sources not available for $module and $no_git_error"
+            validate_error "$command"
+        fi
     done
-    exit 0
     ;;
+
 update)
-    test -e $substat || touch $substat
-    test -z "$maybe_modules" && exit 0
+    is_git || {
+        echo "$0: unexpectedly called with submodules but $no_git_error"
+        exit 1
+    }
 
     $GIT submodule update --init $modules 1>/dev/null
     test $? -ne 0 && update_error "failed to update modules"
-- 
2.40.1


