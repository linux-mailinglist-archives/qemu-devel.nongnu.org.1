Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F972565A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nw3-0008V5-Th; Wed, 07 Jun 2023 03:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6nw0-0008Ui-Pi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1q6nvz-00046V-CM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686124222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g4yeAbUkfqDROXp7WZr3jaLIKaXa7y1xtLxoJAo6Ngc=;
 b=Dgju4fE58rhvrzlHAvGDRbnCLlDj3NqizNZDdV3mZEdreNo2pCovAymA1NiXkRqfATzayW
 ZqjrVx64WFtKyRGWeY5MJxjkQ6NeLeqvkRrZc8H2Ep6dTLYgvG5CKQIk4ppbjxbOjdkTZR
 bcnXl9Po6P6XSbb6Xp7CnGpa2o9ykbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-fvXU-YJ2O2-CECUecxbwFQ-1; Wed, 07 Jun 2023 03:50:21 -0400
X-MC-Unique: fvXU-YJ2O2-CECUecxbwFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD2AA185A791;
 Wed,  7 Jun 2023 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9AC140E954;
 Wed,  7 Jun 2023 07:50:20 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	pbonzini@redhat.com
Subject: [PATCH] configure: check for $download value properly
Date: Wed,  7 Jun 2023 09:50:06 +0200
Message-Id: <3236bc555c76dcd561d38a3aea6e8489e917bc15.1686124161.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
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

If configure was invoked with --disable-download and git
submodules were not checked out a warning is produced and the
configure script fails. But the $download variable (which
reflects the enable/disable download argument) is checked for in
a weird fashion:

  test -f "$download" = disabled

Drop the '-f' to check for the actual value of the variable.

Fixes: 2019cabfee0
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 8765b88e12..8a638dd82a 100755
--- a/configure
+++ b/configure
@@ -767,7 +767,7 @@ if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
 fi
 
 if ! test -f "$source_path/subprojects/keycodemapdb/README" \
-    && test -f "$download" = disabled
+    && test "$download" = disabled
 then
     echo
     echo "ERROR: missing subprojects"
-- 
2.39.3


