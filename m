Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464ED77DD19
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCct-0002BZ-00; Wed, 16 Aug 2023 05:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWCcn-000290-Ay
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWCck-0005yg-Og
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692177329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kAZls+ukqtgmfpIOkf2ZOibxu0VnVLpjloKrjo3GRVY=;
 b=CxIQ+Q+gNdNGRY9xJa9xQSu+UIz5wVlR43IUCbAu+3/t2RJGWgcgadc64YOHJ5lTSw6PEc
 f3mRr9uKqLKFoRC7/1httsYUMNQnWIz8Q/m3u9ufRd6QWjWe4+ANCcDEwL6G58gIVQRlJd
 A5JoUJzTsTKJ3HFIXFlst8AkJA67Q2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-XRXevl-6OFGc_VbQAZV5vg-1; Wed, 16 Aug 2023 05:15:27 -0400
X-MC-Unique: XRXevl-6OFGc_VbQAZV5vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4550101B44F;
 Wed, 16 Aug 2023 09:15:26 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01DF7C15BAD;
 Wed, 16 Aug 2023 09:15:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a problem
 with compiler warnings
Date: Wed, 16 Aug 2023 11:15:22 +0200
Message-Id: <20230816091522.1292029-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

Update the berkeley-testfloat-3 wrap to include a patch provided by
Olaf Hering. This fixes a problem with "control reaches end of non-void
function [-Werror=return-type]" compiler warning/errors that are now
enabled by default in certain versions of GCC.

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 subprojects/berkeley-testfloat-3.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/berkeley-testfloat-3.wrap b/subprojects/berkeley-testfloat-3.wrap
index 6ad80a37b2..c86dc078a8 100644
--- a/subprojects/berkeley-testfloat-3.wrap
+++ b/subprojects/berkeley-testfloat-3.wrap
@@ -1,5 +1,5 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/berkeley-testfloat-3
-revision = 40619cbb3bf32872df8c53cc457039229428a263
+revision = e7af9751d9f9fd3b47911f51a5cfd08af256a9ab
 patch_directory = berkeley-testfloat-3
 depth = 1
-- 
2.39.3


