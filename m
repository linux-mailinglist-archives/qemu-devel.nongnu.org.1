Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAD7222A3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tJ-0002no-RT; Mon, 05 Jun 2023 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tA-0002kZ-Un
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t9-0006l1-BG
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaAJ541yFKl/6b2Y5DV4b0y0RM+YZJrtSH8fs7fEjXk=;
 b=eWnfWmjEkLlxtnO+Snq+C0m4B5M0FVnRxnB4pN1nRULmQdxIdGeDLrkBbZ0Rn5GXPuhbOy
 EjvaoquihjxHvEht17w/pyoOaNpXJF+nFap5OHj7AXhaH4ItiXuA8A94rknr+76L3x6eoL
 HBLHK4eJDz+QsU99CQzBZXJHgCjhorM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-uw2uJDn6PES2koMs_07Xyw-1; Mon, 05 Jun 2023 05:52:33 -0400
X-MC-Unique: uw2uJDn6PES2koMs_07Xyw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso384470966b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958752; x=1688550752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zaAJ541yFKl/6b2Y5DV4b0y0RM+YZJrtSH8fs7fEjXk=;
 b=aJ4GYDKoyEUDlzUexQHQfzP6E9PlWHPJE3l8xxmnlBpWQHdjmnkxWVgnu39hRYUuuG
 t30K4S4tTfOOYuN0TcD7nT/sZB07Cwriuy49RLPe5A37HEOZy94rpY8zTh2KERATAU8J
 p45OA+rXz9DWc4XoboWORcxZr4gNx0D4kqjNSwicdmJgumKZk8npzoIsD6TBmuc0/nkl
 YEnprEQjQwnLNEZlC07X/LdeKmZ1LPDB4X7W7xXqpFGiublSSU8tMS+9aABC0anpMocB
 EcPnkkOv4IMGhAKgLr9ib/I+tjEOOIEkmF1uMt7D7X/oYjK5AEF3Lsblz694AUweuJnQ
 n/vg==
X-Gm-Message-State: AC+VfDyOmjrweCmWbWkxVcWx+scv0MzEBI/H7WZ9EkBEMHtY8lWwR+AK
 rA6WlCfkjMnobPJl+Hq0Jmbe0HrMh98tXFYKj5AeZas1cTMwHfXRwrbrMve33O3C3oVxtxUKMtZ
 qKNCHRrNoXee9y/6BV91zkSVK27BQ1+FXVYjVDUHs0YeGBx6vWfIMlF+nqplLrteNj0TWECNZ1z
 g=
X-Received: by 2002:a17:907:c0f:b0:973:d953:4bf7 with SMTP id
 ga15-20020a1709070c0f00b00973d9534bf7mr6953293ejc.48.1685958752040; 
 Mon, 05 Jun 2023 02:52:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Adlv0T0ExwwXrNlspaJh95dbvrEBfWb9ZnQUQpB7x7azYzKIcEoZqBAgHnIfzrqON8b6D6w==
X-Received: by 2002:a17:907:c0f:b0:973:d953:4bf7 with SMTP id
 ga15-20020a1709070c0f00b00973d9534bf7mr6953282ejc.48.1685958751771; 
 Mon, 05 Jun 2023 02:52:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a170906494e00b0097461fecc91sm4031379ejt.81.2023.06.05.02.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 04/10] build: log submodule update from git-submodule.sh
Date: Mon,  5 Jun 2023 11:52:17 +0200
Message-Id: <20230605095223.107653-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

Print exactly which submodules have been updated, by reusing the logic of
"git-submodule.sh validate" after executing "git submodule update --init'.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                 |  4 +---
 scripts/git-submodule.sh | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8005f1cc53e..d68196acb9e 100644
--- a/Makefile
+++ b/Makefile
@@ -52,9 +52,7 @@ Makefile: .git-submodule-status
 .PHONY: git-submodule-update
 git-submodule-update:
 ifneq ($(GIT_SUBMODULES_ACTION),ignore)
-	$(call quiet-command, \
-		(GIT=git "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
-		"GIT","$(GIT_SUBMODULES)")
+	$(quiet-@)GIT=git "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)
 endif
 
 # 0. ensure the build tree is okay
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index b7d8f05352c..38b55c90e11 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -46,6 +46,13 @@ validate_error() {
     exit 1
 }
 
+check_updated() {
+    local CURSTATUS OLDSTATUS
+    CURSTATUS=$($GIT submodule status $module)
+    OLDSTATUS=$(grep $module $substat)
+    test "$CURSTATUS" = "$OLDSTATUS"
+}
+
 if test -n "$maybe_modules" && ! test -e ".git"
 then
     echo "$0: unexpectedly called with submodules but no git checkout exists"
@@ -75,11 +82,7 @@ status|validate)
     test -f "$substat" || validate_error "$command"
     test -z "$maybe_modules" && exit 0
     for module in $modules; do
-        CURSTATUS=$($GIT submodule status $module)
-        OLDSTATUS=$(cat $substat | grep $module)
-        if test "$CURSTATUS" != "$OLDSTATUS"; then
-            validate_error "$command"
-        fi
+        check_updated $module || validate_error "$command"
     done
     exit 0
     ;;
@@ -89,6 +92,9 @@ update)
 
     $GIT submodule update --init $modules 1>/dev/null
     test $? -ne 0 && update_error "failed to update modules"
+    for module in $modules; do
+        check_updated $module || echo Updated "$module"
+    done
 
     (while read -r; do
         for module in $modules; do
-- 
2.40.1


