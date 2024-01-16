Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00482EA7D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:59:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPeKe-0002kR-Ht; Tue, 16 Jan 2024 02:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKZ-0002jw-SY
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKY-00083A-BU
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705391873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qxc1Z31L4g7jBm5lqK4iTAhCoVK0ENHit3yxqqr0drE=;
 b=YGg64+UmO07eyJ42BOPLFsAE6VEGuvj9+OmuE2gtO745cFKzZBrjlmr1Rl243XHnbm7X3Q
 3qO0/ZYilgo37G0Ha0pGtpMdZPNbUNMXxjm18DoQISfQrisovGFs2qFcq6VvXEdkG35N68
 6/AIs+nn/+aMFmaytgrRvYJiqE/Veis=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-wGh66j5WO2CamKqkWN-zWg-1; Tue,
 16 Jan 2024 02:57:49 -0500
X-MC-Unique: wGh66j5WO2CamKqkWN-zWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 005093C0ED69;
 Tue, 16 Jan 2024 07:57:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC0553C25;
 Tue, 16 Jan 2024 07:57:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] tests/qtest/npcm7xx_watchdog_timer: Only test the corner
 cases by default
Date: Tue, 16 Jan 2024 08:57:41 +0100
Message-ID: <20240116075744.219169-3-thuth@redhat.com>
In-Reply-To: <20240116075744.219169-1-thuth@redhat.com>
References: <20240116075744.219169-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The test_prescaler() part in the npcm7xx_watchdog_timer test is quite
repetitive, testing all possible combinations of the WTCLK and WTIS
bitfields. Since each test spins up a new instance of QEMU, this is
rather an expensive test, especially on loaded host systems.
For the normal quick test mode, it should be sufficient to test the
corner settings of these fields (i.e. 0 and 3), so we can speed up
this test in the default mode quite a bit.

Message-ID: <20240115070223.30178-1-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/npcm7xx_watchdog_timer-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
index 4773a673b2..981b853c99 100644
--- a/tests/qtest/npcm7xx_watchdog_timer-test.c
+++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
@@ -172,9 +172,10 @@ static void test_reset_action(gconstpointer watchdog)
 static void test_prescaler(gconstpointer watchdog)
 {
     const Watchdog *wd = watchdog;
+    int inc = g_test_quick() ? 3 : 1;
 
-    for (int wtclk = 0; wtclk < 4; ++wtclk) {
-        for (int wtis = 0; wtis < 4; ++wtis) {
+    for (int wtclk = 0; wtclk < 4; wtclk += inc) {
+        for (int wtis = 0; wtis < 4; wtis += inc) {
             QTestState *qts = qtest_init("-machine quanta-gsj");
 
             qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
-- 
2.43.0


