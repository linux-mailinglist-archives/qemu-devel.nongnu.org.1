Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FF73DD28
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkC2-0003lo-7y; Mon, 26 Jun 2023 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBz-0003fn-RS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBx-0000vr-Ky
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ath+2F7qJveL8sgT+2ECYF27f9KTqV0CItidFFplvAo=;
 b=PJJxY7b0k0lncq25OvxvgzYCMkGXjBYigDOfBEuOJIVQU8KaWiaYr6PojFzMTX5VcR4Sq7
 LWGhYX40eMlkY40ysJwGKvvmgOVFQOuoe111MRu/h0BgCfg1VvXyJkvmSqsSW3r55QQeqk
 yPj7K/NnDLFqKgdHGR55c6wjWfWYlyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-wkMPgA4gNiOGjhnICYijVA-1; Mon, 26 Jun 2023 07:15:31 -0400
X-MC-Unique: wkMPgA4gNiOGjhnICYijVA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa8562f6cdso6838975e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778114; x=1690370114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ath+2F7qJveL8sgT+2ECYF27f9KTqV0CItidFFplvAo=;
 b=Q8ON22zIEEe2nXtn5gwXAzfwsiFovFCYB3jAtjf2kuQoHpkfJ2di6zsffWlKETmeMw
 qGZg1ASOKhNYadRCcNOoYLxcq3TH99XR5Cv1s75lHtKbbbvRnKDpFINGBAVtr0wEHb0I
 mrJdpTg5hTsrsf0gxKjCez/I53hyWRXIe6LsootKAIdk2xj8VbYeu2iWMMaJ/9OHotZq
 EuZF2w0pUuKvQU0uUMSEpNtOO0VHvBIRGqI5vokuMj1OC6ErhIuWclhQq79/v9qadmk3
 c9iz2q05acK16xwdOjD94eyd41Z7qhlDPqmnPdb9qMyvfD+r8rWBuDNQ1befV/cvT2yC
 H1zg==
X-Gm-Message-State: AC+VfDxol1FrPA8KFilgyXjmjouCaO193ypnUnj+ZgKOpoBiYJQdE4d4
 doTqnlb+5CSOhS/RTFQV+dsgjsUXohhQ3AI1TTPrFay+xtRS3jMKS/9wo1h/F3TgiiACF2bfM3a
 CD8av7Kgd1EbUDja7+DG9wf61iRoFRM4+JOzrKNV09So9ASXiP9JA6ZXFipFGJhf388AMhKlQuf
 E=
X-Received: by 2002:a7b:c8c9:0:b0:3f9:82f:bad5 with SMTP id
 f9-20020a7bc8c9000000b003f9082fbad5mr17574630wml.35.1687778114362; 
 Mon, 26 Jun 2023 04:15:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZhH1IdDj5/52AsPvaf+66M4haJQwShcVe7RM0FwpI9/5lCfBrTjEDYvO5YSTlHQ9VR4D7Ag==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:82f:bad5 with SMTP id
 f9-20020a7bc8c9000000b003f9082fbad5mr17574613wml.35.1687778114020; 
 Mon, 26 Jun 2023 04:15:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0ac600b003f9c0a7c6bcsm7471459wmr.0.2023.06.26.04.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 18/18] git-submodule.sh: allow running in validate mode without
 previous update
Date: Mon, 26 Jun 2023 13:14:45 +0200
Message-ID: <20230626111445.163573-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
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
2.41.0


