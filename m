Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA372461C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xit-0005PA-2u; Tue, 06 Jun 2023 10:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xir-0005MA-Kg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xip-0001JY-4E
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nw8ksEi1LGkbWGe7Q/Qk6dPKsCnk9x+sAV4iBE3crXc=;
 b=cIWYPYhvpaX43H03FahOqGLkk4aMjYUX+jgCIw2AmGYwUWvvNh6gzyfyrY+Czsj2AcWRFi
 m5jpK/2fJs6h5bhdrHmXwBFUPZzAyOTf2jGgm6v8YAoG4pYoB5PLYujI91GotNZnQEGOn1
 2NF6TzI04JQtRdXp8ZxdtOAHwHUXtxs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fDKrQqXjN8WhHbNeQ-F7wA-1; Tue, 06 Jun 2023 10:31:41 -0400
X-MC-Unique: fDKrQqXjN8WhHbNeQ-F7wA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-514abe67064so4244296a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061900; x=1688653900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nw8ksEi1LGkbWGe7Q/Qk6dPKsCnk9x+sAV4iBE3crXc=;
 b=fzDraTGKIo9Msr+9/wnPzBLrZA+Le/9UIKtR9xYFSz+P0+JNndvtkV8GzYGrg2vElg
 nYfatshJwFSTrEHSq/0YOr6F+BVFClAE/V7e1mTVLY6NqnHXWdhyf3yI5JvTMisKon4J
 mefUmPkaZXxVwZGM2RRaaExWidDVUF4DxYn3rJ79rj2RQ0JeU8uw0w/FDhzi1DjhQObM
 lXfNLhVriFYX7NXPJRggdSPjIMZh4AO148RAxShH9v7qovr84pxIXR65eUiL+yCg58W5
 UBhPH8S8dK73HNB2qyZatmOmhXdnbRMz2nBL+hIomCEM47PBIp42glAASnvk21IvC0S6
 ZzyQ==
X-Gm-Message-State: AC+VfDxgvnzu8L/vGU5BxoQp/Vof6dRssTCeeVCApFKQcBI0y7Hrdmtm
 lC65Uhoka3SILxQKm1AidQ+rW2gomc61XlhFoDCjMN9iv5pNCLuay1/JcUDFRO3QMdlUs1nvGaD
 fwQm6b/KCA8YYHTbM7uTMKGxPd2lkbmu43Dj5tXhR9qR+/94n6/pp75TA2i68S5fC2wkIDaeCjr
 Y=
X-Received: by 2002:aa7:cacb:0:b0:50b:c3f0:fb9d with SMTP id
 l11-20020aa7cacb000000b0050bc3f0fb9dmr2081278edt.41.1686061899797; 
 Tue, 06 Jun 2023 07:31:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+ecvrBKy7Y4IG9jG08kL3nll0PG4PDSv5ggpHUODq41Xd0UxIe61Rptr4INIcC50HUXL8hw==
X-Received: by 2002:aa7:cacb:0:b0:50b:c3f0:fb9d with SMTP id
 l11-20020aa7cacb000000b0050bc3f0fb9dmr2081261edt.41.1686061899421; 
 Tue, 06 Jun 2023 07:31:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a25-20020aa7d919000000b005163008c6b7sm5078344edr.27.2023.06.06.07.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/21] git-submodule: allow partial update of
 .git-submodule-status
Date: Tue,  6 Jun 2023 16:31:09 +0200
Message-Id: <20230606143116.685644-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Allow a specific subdirectory to run git-submodule.sh with only a
subset of submodules, without removing the others from the
.git-submodule-status file.

This also allows scripts/git-submodule.sh to be more lenient:
validating an empty set of submodules is not a mistake.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/git-submodule.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 0ce1efc44e5..b7d8f05352c 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -72,12 +72,8 @@ done
 
 case "$command" in
 status|validate)
-    if test -z "$maybe_modules"
-    then
-         test -s ${substat} && validate_error "$command" || exit 0
-    fi
-
     test -f "$substat" || validate_error "$command"
+    test -z "$maybe_modules" && exit 0
     for module in $modules; do
         CURSTATUS=$($GIT submodule status $module)
         OLDSTATUS=$(cat $substat | grep $module)
@@ -88,17 +84,23 @@ status|validate)
     exit 0
     ;;
 update)
-    if test -z "$maybe_modules"
-    then
-        test -e $substat || touch $substat
-        exit 0
-    fi
+    test -e $substat || touch $substat
+    test -z "$maybe_modules" && exit 0
 
     $GIT submodule update --init $modules 1>/dev/null
     test $? -ne 0 && update_error "failed to update modules"
 
-    $GIT submodule status $modules > "${substat}"
-    test $? -ne 0 && update_error "failed to save git submodule status" >&2
+    (while read -r; do
+        for module in $modules; do
+            case $REPLY in
+                *" $module "*) continue 2 ;;
+            esac
+        done
+        printf '%s\n' "$REPLY"
+    done
+    $GIT submodule status $modules
+    test $? -ne 0 && update_error "failed to save git submodule status" >&2) < $substat > $substat.new
+    mv -f $substat.new $substat
     ;;
 esac
 
-- 
2.40.1


