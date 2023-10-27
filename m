Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7F7D93F5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHQ-0002MP-Ph; Fri, 27 Oct 2023 05:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHO-0002Lf-6I
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHM-0002kB-Q0
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEgCgFnTAoeNOn2fWUZ+FE/CsbPbDRXUi3jBdNlv0VA=;
 b=RIntQAYAV2aAcpJSrIKBkM4zNPqIfTClrxcbDSJ/FCrCM4gUMwYECnPjZe3BA9KXiTwlPw
 1ag7VE9DQDSJZHuX2CaLPzSAAuPbsOXgyaN4QjtV/E55pdPDImuA1L/rB0J/aIr6nkUeeW
 ZFtq5bLvSgHa7ay65xk5zOO+8RcW/zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-8YFFD0jAP_uI2UGIATpykg-1; Fri, 27 Oct 2023 05:37:14 -0400
X-MC-Unique: 8YFFD0jAP_uI2UGIATpykg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9366E88D70C;
 Fri, 27 Oct 2023 09:37:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9081F1121319;
 Fri, 27 Oct 2023 09:37:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alberto Garcia <berto@igalia.com>
Subject: [PULL 02/11] tests/throttle: Clean up global variable shadowing
Date: Fri, 27 Oct 2023 11:37:01 +0200
Message-ID: <20231027093710.273558-3-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Follow all other tests pattern from this file, use the
global 'cfg' variable to fix:

  tests/unit/test-throttle.c:621:20: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      ThrottleConfig cfg;
                     ^
  tests/unit/test-throttle.c:28:23: note: previous declaration is here
  static ThrottleConfig cfg;
                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alberto Garcia <berto@igalia.com>
Message-ID: <20231009100251.56019-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-throttle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index ac35d65d19..2146cfacd3 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -618,7 +618,6 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
                                  { THROTTLE_OPS_TOTAL,
                                    THROTTLE_OPS_READ,
                                    THROTTLE_OPS_WRITE, } };
-    ThrottleConfig cfg;
     BucketType index;
     int i;
 
-- 
2.41.0


