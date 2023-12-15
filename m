Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E281421D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 08:06:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE2FA-0003u1-Rw; Fri, 15 Dec 2023 02:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2F1-0003sh-Mh
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2F0-0000uD-27
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702623849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kkn9nV3anUgghBhWaQltV6V3I/owTyq6zDGJctyyjbE=;
 b=Bk64bPb2b3rhM2Mgc9mG70Pc6K4NcwrUmRBBf4Ci5nUYgpwW5Yk0ZNQfppoZqHJXjd88ER
 lG1EfHzj6DrvLy8FT9XbPImbDmig/wPeOxdCltZxgAbKHo90cGpWdzazc/+CnwzfRW2oQr
 r7kGBxSi5L8WGSX1qQoXpj1dmsc3q1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-q-fuIc1mPcCz99tPpDrIIQ-1; Fri, 15 Dec 2023 02:04:07 -0500
X-MC-Unique: q-fuIc1mPcCz99tPpDrIIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02F4C1018819;
 Fri, 15 Dec 2023 07:04:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7422C2026D66;
 Fri, 15 Dec 2023 07:04:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 03/16] qtest: bump qom-test timeout to 15 minutes
Date: Fri, 15 Dec 2023 08:03:44 +0100
Message-ID: <20231215070357.10888-4-thuth@redhat.com>
In-Reply-To: <20231215070357.10888-1-thuth@redhat.com>
References: <20231215070357.10888-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qom-test is periodically hitting the 5 minute timeout when running
on the aarch64 emulator under GitLab CI. With an --enable-debug build
it can take over 10 minutes for arm/aarch64 targets. Setting timeout
to 15 minutes gives enough headroom to hopefully make it reliable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20230717182859.707658-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f184d051cf..000ac54b7d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -2,7 +2,7 @@ slow_qtests = {
   'bios-tables-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 150,
-  'qom-test' : 300,
+  'qom-test' : 900,
   'test-hmp' : 120,
 }
 
-- 
2.43.0


