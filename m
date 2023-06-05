Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7497222AB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tG-0002n1-FK; Mon, 05 Jun 2023 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t9-0002jh-DO
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t7-0006ke-PN
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KV0us+lQFaTLaVt+18IRhS6KCTi0FFJV0G41ZssQkjI=;
 b=NnUxvrQyEpzbsS41nEzSXkTHs1YAgz6fWdIciPw/q51fsyIg6g3rqALAZFKRDatR563PRc
 Qo7piXaOw8O0L20zAkR76dJrO/WE2yAk7D+UzD17eBfr73ikDThJ+wn8d2sKOlmoPBO8Pu
 hDkTV3k9KCad7XRN3PD1/RdmWRLC0Fc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-wOZzSDAoNpCo7CRmI6_x-g-1; Mon, 05 Jun 2023 05:52:31 -0400
X-MC-Unique: wOZzSDAoNpCo7CRmI6_x-g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so624082966b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958750; x=1688550750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KV0us+lQFaTLaVt+18IRhS6KCTi0FFJV0G41ZssQkjI=;
 b=SvRT2yhYj/ydYhrpt2hjlW23SWPahg8d2+Gu+r4YdrsbARkbPyMNb6aCAPHQ4ML+eF
 yb6m2uXH8hmNPZYiqxt0yzxoF/5Yau4aDB3ViZIQtljjEnQflZ2wF/9IhKMFRvOv9mKO
 sMvOTYcY29lPvQF9oCAWSGGt61X4zPijJGT0yS1Xn7LwIzXRNGnyOs752o16LkR8umD0
 fRNx2rSs9RBGLVFDsSFWmZFuEmum39j6QD96DPdBanxw4auTZK8r1Geb0TdAl4J2/Ki8
 dOV+fq/GSTl71hrtkqdUfrRaKXgrvhQnKR55O5jTFqgc87qPLg2Dg8T5j5LllNzvDSS1
 143w==
X-Gm-Message-State: AC+VfDy6WL8XqHZAcUTPTW70+NgWwWyp12C+8uQz9PNZIQTKYF/njBDb
 UScn6ir8+SGJGR9jXQdM+69mZTv+E9Q4uE6kiavmZ+mca4V3WvySUtOVS6ANSutmwdSWvZ/w3BV
 LM2jurpLYGC0tocUymLDn5yvWBH8tNZYouISquZn+UaBYocahz8yM7Im/5gVips0XgyVz3YlMqd
 U=
X-Received: by 2002:a17:907:971b:b0:973:92a8:f611 with SMTP id
 jg27-20020a170907971b00b0097392a8f611mr5259933ejc.31.1685958750345; 
 Mon, 05 Jun 2023 02:52:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Vw91NmnTvVUCmw2LAOiD9lhwrx+mC0UDiV00d8JBbUXiXH6MSns8tyVuA8GU9E3+YRD4xmQ==
X-Received: by 2002:a17:907:971b:b0:973:92a8:f611 with SMTP id
 jg27-20020a170907971b00b0097392a8f611mr5259926ejc.31.1685958750138; 
 Mon, 05 Jun 2023 02:52:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a170906240d00b0094e597f0e4dsm4062603eja.121.2023.06.05.02.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 03/10] git-submodule: allow partial update of
 .git-submodule-status
Date: Mon,  5 Jun 2023 11:52:16 +0200
Message-Id: <20230605095223.107653-4-pbonzini@redhat.com>
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

Allow a specific subdirectory to run git-submodule.sh with only a
subset of submodules, without removing the others from the
.git-submodule-status file.

This also allows scripts/git-submodule.sh to be more lenient:
validating an empty set of submodules is not a mistake.

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


