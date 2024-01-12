Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30482C3EA
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKh5-0001eb-Ud; Fri, 12 Jan 2024 11:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOKgq-0001av-Ou
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOKgm-0001vt-Fd
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705078042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K4dbY1sFlvEu0y40V/FK/PeF8bvIXS7fYIXnuzmJRdo=;
 b=SQjZXL+nNM5/l4oMuQR8oG5eF+1/Ul/kBQfAkaHpOfK2odMU/R5pRAdORUwsRl+JgDwBcd
 xl4fGr4TyVPAzliEXPJr8K75FDmTXrgNwAVAlCCDSoEL/6yzqQX1xwlZhdwsaxLX+hLvg3
 TxlpMb3a/omdKYwHQ4rpIMschb+rozE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-sE29lBphOBuPBKh0uCN6lQ-1; Fri, 12 Jan 2024 11:47:20 -0500
X-MC-Unique: sE29lBphOBuPBKh0uCN6lQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A097185A784;
 Fri, 12 Jan 2024 16:47:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 188763C25;
 Fri, 12 Jan 2024 16:47:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qtest: Bump npcm7xx_watchdog_timer-test timeout to 2 minutes
Date: Fri, 12 Jan 2024 17:47:17 +0100
Message-ID: <20240112164717.1063954-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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

The npcm7xx_watchdog_timer-test can take more than 60 seconds
when running in the gitlab-CI, see for example:

 https://gitlab.com/qemu-project/qemu/-/jobs/5890481174#L4756

Bumping to 2 minutes will give more headroom.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based-on: <20231215070357.10888-1-thuth@redhat.com>

 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fd40136fa9..b0bc5af09e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'device-introspect-test' : 720,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
+  'npcm7xx_watchdog_timer-test': 120,
   'qom-test' : 900,
   'test-hmp' : 240,
   'pxe-test': 600,
-- 
2.43.0


