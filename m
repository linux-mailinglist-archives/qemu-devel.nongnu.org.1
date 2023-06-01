Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECB71EF19
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lD7-0002Wv-QH; Thu, 01 Jun 2023 12:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lD5-0002WO-FX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lD3-0007Fh-RQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685637092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZJ+h6yEVR3M3K3/wAYWtQF1Ne5IREviDXco9o9kwFY=;
 b=YAtgWRiW3QLoHNgfM+EncAT6IaXhwA2/xK0gJorfithufHi7pDq2Z3cMZbk0Z9QU02jXMJ
 vsujUAMo5jR9F7f3+v02+VnzbMVNlNsoAwn82ickx9+PvlUg/dNvnyCMtS43zdKgaWufny
 JfQEJyYI2bNlwTjx3DYOM1q+ncbjBUg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-BfO_61ROObm5tceHdM6U6g-1; Thu, 01 Jun 2023 12:31:29 -0400
X-MC-Unique: BfO_61ROObm5tceHdM6U6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 749C728135A1;
 Thu,  1 Jun 2023 16:31:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFCB92166B27;
 Thu,  1 Jun 2023 16:31:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/6] qtest: bump migration-test timeout to 5 minutes
Date: Thu,  1 Jun 2023 17:31:19 +0100
Message-Id: <20230601163123.1805282-3-berrange@redhat.com>
In-Reply-To: <20230601163123.1805282-1-berrange@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

The migration test should take between 1 min 30 and 2 mins on reasonably
modern hardware. The test is not especially compute bound, rather its
running time is dominated by the guest RAM size relative to the
bandwidth cap, which forces each iteration to take at least 30 seconds.
None the less under high load conditions with multiple QEMU processes
spawned and competing with other parallel tests, the worst case running
time might be somewhat extended. Bumping the timeout to 5 minutes gives
us good headroom, while still catching stuck tests relatively quickly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 18d046b53c..6684591fcf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'bios-tables-test' : 120,
-  'migration-test' : 150,
+  'migration-test' : 300,
   'npcm7xx_pwm-test': 150,
   'qom-test' : 300,
   'test-hmp' : 120,
-- 
2.40.1


