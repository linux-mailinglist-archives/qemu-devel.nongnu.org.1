Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C879D1B8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg32f-0006Gg-BY; Tue, 12 Sep 2023 09:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg32Y-00065v-5u
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg32S-0008J3-W5
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694523762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MhK5ePKbVvcTPqNDbQxkzK12FuHL4I8462s3ywfXPFw=;
 b=ByI1T/hkmerEnwEtcZiHXT4+Jh1lU2x6NcAK6G1pYFNE3rRBmZJBDAMsTXF9mk+cZ8BWeN
 9nHe5pq7+P4dCVZzDJlevatmM9C/jxYkALv20aH2aWfeZZRjJnjaY1O+4hfgp5ZNdSmcyb
 2NVQbMNdJdnFe44xEsoMjwCN1Mzf4xI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-sQ66z81SPwO0kB9dGzmpxw-1; Tue, 12 Sep 2023 09:02:40 -0400
X-MC-Unique: sQ66z81SPwO0kB9dGzmpxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91893C0EAC2;
 Tue, 12 Sep 2023 13:02:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 961C22026D4B;
 Tue, 12 Sep 2023 13:02:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] subprojects: Use the correct .git suffix in the repository
 URLs
Date: Tue, 12 Sep 2023 15:02:37 +0200
Message-ID: <20230912130237.300014-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This avoids the warnings à la:
"warning: redirecting to https://gitlab.com/qemu-project/xyz.git/"

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 subprojects/berkeley-softfloat-3.wrap | 2 +-
 subprojects/berkeley-testfloat-3.wrap | 2 +-
 subprojects/slirp.wrap                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/subprojects/berkeley-softfloat-3.wrap b/subprojects/berkeley-softfloat-3.wrap
index a8fd87740b..c3e356d42f 100644
--- a/subprojects/berkeley-softfloat-3.wrap
+++ b/subprojects/berkeley-softfloat-3.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.com/qemu-project/berkeley-softfloat-3
+url = https://gitlab.com/qemu-project/berkeley-softfloat-3.git
 revision = b64af41c3276f97f0e181920400ee056b9c88037
 patch_directory = berkeley-softfloat-3
 depth = 1
diff --git a/subprojects/berkeley-testfloat-3.wrap b/subprojects/berkeley-testfloat-3.wrap
index c86dc078a8..b8b12e7629 100644
--- a/subprojects/berkeley-testfloat-3.wrap
+++ b/subprojects/berkeley-testfloat-3.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.com/qemu-project/berkeley-testfloat-3
+url = https://gitlab.com/qemu-project/berkeley-testfloat-3.git
 revision = e7af9751d9f9fd3b47911f51a5cfd08af256a9ab
 patch_directory = berkeley-testfloat-3
 depth = 1
diff --git a/subprojects/slirp.wrap b/subprojects/slirp.wrap
index 08291a4cf9..a93b048962 100644
--- a/subprojects/slirp.wrap
+++ b/subprojects/slirp.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
-url = https://gitlab.freedesktop.org/slirp/libslirp
+url = https://gitlab.freedesktop.org/slirp/libslirp.git
 revision = 26be815b86e8d49add8c9a8b320239b9594ff03d
 
 [provide]
-- 
2.41.0


