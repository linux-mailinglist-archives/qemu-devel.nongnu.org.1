Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9D73D95A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhN7-0004Ff-Bl; Mon, 26 Jun 2023 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMw-00048b-Pz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMs-0000uk-VV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687767277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTZOd8LzKDFd+94pqKNpFDpp2D5xwv3z4f3c5drzGLo=;
 b=csEQYlbzmwHDS1z/kWvMNlNsGkagbImxpxJjL+/tYzstcTHkjWhdXCdh2NiZu4PQcYp2OT
 Wv2yk3KcwU2hmquYe3qIBwRabIiyZ14F7N7J0Dnf0ZOEOFrIT9ETamVUR/HSbEYtoLhKJO
 h/jqvZsS+ygYopnKv6BB8DlOb9dQwpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-yhk58wmsOxa2pJgptpWu4Q-1; Mon, 26 Jun 2023 04:14:35 -0400
X-MC-Unique: yhk58wmsOxa2pJgptpWu4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D56580006E;
 Mon, 26 Jun 2023 08:14:35 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ED36492B01;
 Mon, 26 Jun 2023 08:14:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 9/9] tests/qtest/cxl-test: Clean up temporary directories after
 testing
Date: Mon, 26 Jun 2023 10:14:15 +0200
Message-Id: <20230626081415.64615-10-thuth@redhat.com>
In-Reply-To: <20230626081415.64615-1-thuth@redhat.com>
References: <20230626081415.64615-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

It's good style to clean up temporary directories when they
are not needed anymore.

Message-Id: <20230622114132.372898-1-thuth@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cxl-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index edcad4a0ce..a600331843 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -124,6 +124,7 @@ static void cxl_t3d_deprecated(void)
 
     qtest_start(cmdline->str);
     qtest_end();
+    rmdir(tmpfs);
 }
 
 static void cxl_t3d_persistent(void)
@@ -138,6 +139,7 @@ static void cxl_t3d_persistent(void)
 
     qtest_start(cmdline->str);
     qtest_end();
+    rmdir(tmpfs);
 }
 
 static void cxl_t3d_volatile(void)
-- 
2.39.3


