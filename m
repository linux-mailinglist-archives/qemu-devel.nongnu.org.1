Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C972462F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xj5-0005aq-Gk; Tue, 06 Jun 2023 10:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xiw-0005ZQ-U4
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xiv-0001KI-Cx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDldL0xhfPvoE8avQxYF9j/S/qjA1eexqMtZkHxm0IM=;
 b=MaNm7fjB1MH88LL7hvonCjVmbZvqBpPAT2VuPmzZ/blfhlb7StAyyknhl1izAjTbyqagLC
 dYM9nWE7kJoLEWUn2Y66z5AgX+BnkxGtIeC397z4TNHj9l/rohuOcoEhvmNGbyKKYN6aCX
 QFyBAaUOOX57uIqyLUo/Xbe5faLxyzg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ZzSdp60kOqajJ9Uj-LxbMA-1; Tue, 06 Jun 2023 10:31:47 -0400
X-MC-Unique: ZzSdp60kOqajJ9Uj-LxbMA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355c9028so471426566b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061904; x=1688653904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDldL0xhfPvoE8avQxYF9j/S/qjA1eexqMtZkHxm0IM=;
 b=QBFr4+oyxxhOpDw/dXqX3zi4u8WlRg4GJhpgjql3Sv1Rvd7GzWCIZIKCfjS9non3E2
 8F6Ihnt8rdONQ1bB2mPNwY9AE2/Kr4BT+GXiPMUJbrisxWSYsDGYqD28Q/muMkaS9sz5
 y2CPCHZHkvhk/m7SHWtAIXdIO+s3UboGR8tiXMm/mMkUaaQfv74uQU5OLchdHiql6wuH
 x/zWSP9NTvhmL+oZddA69+RCPxqyStRYNIVz4hsjmSwsgrO8dLian11/Tsmk8cyRDYw0
 KfxYQ+tpyaAsxyXEKwg6v9WTAxgzQd+k1agPrwG6bVGq4OJqYY4iMZUAKvXB6f35v1bB
 EBtw==
X-Gm-Message-State: AC+VfDyYlapR0YoUuu6msIIZDL6QfR1fya+3pYj5/rF7Vf6ULLlcpUEH
 uWou60DOymW2xILbyHNemsVrcsBKUAI4SMmLlr1SoyHqA3CTVjf98mYRVxN/oLrpbBtaehsg6/W
 sRj5a8b1P3IHSXVwCmpRtL4NDCNrGkapLeFIba+qDb4TVBI/PuCsFaH0BeEJ1PTGaqhJmqSxrOB
 Q=
X-Received: by 2002:a17:907:72c9:b0:977:abac:9635 with SMTP id
 du9-20020a17090772c900b00977abac9635mr2572453ejc.20.1686061903160; 
 Tue, 06 Jun 2023 07:31:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DTLiNKN097Jw0UyEpwPlg2xhDNQL20uM7G2M0j03cRPlaFTAv075C1l+9kIHIQKaTjPksyQ==
X-Received: by 2002:a17:907:72c9:b0:977:abac:9635 with SMTP id
 du9-20020a17090772c900b00977abac9635mr2572431ejc.20.1686061900998; 
 Tue, 06 Jun 2023 07:31:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170906261500b00977cad140a8sm3851899ejc.218.2023.06.06.07.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 15/21] build: log submodule update from git-submodule.sh
Date: Tue,  6 Jun 2023 16:31:10 +0200
Message-Id: <20230606143116.685644-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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

Print exactly which submodules have been updated, by reusing the logic of
"git-submodule.sh validate" after executing "git submodule update --init'.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


