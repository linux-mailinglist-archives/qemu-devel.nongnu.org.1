Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90938739DC9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGzw-0003e2-Mi; Thu, 22 Jun 2023 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGzu-0003dq-Hg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGzs-0004Lc-U2
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687427580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YuQfkPBKXqtkE7XvYAdHSZp0QD7WGR1NXwI/2X9SVy0=;
 b=jC+EXJzRYATi+rzQhg5+JpnuBFpwzBPLu/YH/Er9IRpaKPzFxMI8i2qYdWcRtn0U7WyJSF
 Lf61uoj7bIMz3kgMpPSncXfg/iXWijVGBzhmVQEAJz1JnKK5TXTVGwAjlt+LpSkdJDeWVd
 N6p8llq+CqJQZt4NACuwY+uRKO8STTI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-TfCTe3ltOJypGXVmoF0Jbg-1; Thu, 22 Jun 2023 05:52:58 -0400
X-MC-Unique: TfCTe3ltOJypGXVmoF0Jbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-988e344bed9so321333866b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427576; x=1690019576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YuQfkPBKXqtkE7XvYAdHSZp0QD7WGR1NXwI/2X9SVy0=;
 b=MezRNF6V996o3DgVq/MNyKtk1LVyynIC9uBJIfSEL+NbmXBX48hP6IUqKil47bXClO
 si+V1ODeLgcQeD2qhjmhnYePGI4cfA5Orw+FadjKw/hzO3R1JXhvG7ROAC5CluO+xV3c
 KG9SfKVp+DfbgWCzc44PElPhddHS/aq+z0XczMwBKRg8Jo8pyb+0hsh8pgRoTUjlTiQ7
 yugXhSmxFJmv6oqBL0H2hVaXO12PgAx1A8IK1r38nc1tXXvcp6O1wRfXBIErAOZoEAzD
 ELeVvp1mnwR6lA6Ekb4uV6z1/mXvUPE4cYw+i6TZHPk45mIkshYLgMOjR01Fmelkdy/a
 tIjg==
X-Gm-Message-State: AC+VfDyW14Jr9LDvID8lQVWxckwi0IGTesnDkOIkMSbtYEt+v00Y+Gxa
 bfjxawNL+EznKXRH441VpOJf7AYO1ZgI4NG0n9ruofLJ0L44kKZWmiOBVnr+P/haXgTL6v6hiPy
 SJ6+cqTHYsj9B0RlIR0XdC94sNdB7T9ObYA1SDKPBPN2Cg6J37auu0TlVANv8l/aRQDiXyAZ1sa
 k=
X-Received: by 2002:a17:907:318c:b0:987:e230:690 with SMTP id
 xe12-20020a170907318c00b00987e2300690mr13156285ejb.57.1687427576373; 
 Thu, 22 Jun 2023 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lJGbMw+7Cnv2BilPuxb4KhpPckcOeiOriGV8I6gPAe1iSZmcSGrPTH0UDfVAVJrtdHVDvtQ==
X-Received: by 2002:a17:907:318c:b0:987:e230:690 with SMTP id
 xe12-20020a170907318c00b00987e2300690mr13156267ejb.57.1687427576004; 
 Thu, 22 Jun 2023 02:52:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906390300b009893650453fsm4029664eje.173.2023.06.22.02.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:52:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2] git-submodule.sh: allow running in validate mode without
 previous update
Date: Thu, 22 Jun 2023 11:52:54 +0200
Message-Id: <20230622095254.52398-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 scripts/git-submodule.sh | 73 ++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

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
index 11fad2137cd..335f7f5fdf8 100755
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
+if ! test -e ".git"; then
+    no_git_error='no git checkout exists'
+elif test -z "$GIT"; then
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
@@ -51,42 +60,42 @@ check_updated() {
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
+        elif ! (set xyz "$module"/* && test -e "$2"); then
+            # The directory does not exist or it contains no files
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


