Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9DD814217
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 08:05:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE2Fb-000404-4F; Fri, 15 Dec 2023 02:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2F6-0003tZ-Rj
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rE2F5-00016c-Go
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 02:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702623854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MRljxL+Mgg50w2aYStZZLFbbSxEGHAeIeGwnSQLIRs=;
 b=Dv9iW6s8Hljz0EduXfhdQ2zSShy8BEtNmsLsnO2CF68nUcM0jeCnxt6VvmKDu6RlgxbQz5
 5qmEyhBdB/qIIA2ofVlCBRSxA7WvQlXh2bxLqkNw/L0gZx/S+LgCe5VEa7jjkLLlmkhkpc
 G56YRsPce3KIKOYP9up85fQbSb22Ocg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-pVapJaMgO62b1ijX68tueg-1; Fri, 15 Dec 2023 02:04:11 -0500
X-MC-Unique: pVapJaMgO62b1ijX68tueg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19678837222;
 Fri, 15 Dec 2023 07:04:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 915942026D66;
 Fri, 15 Dec 2023 07:04:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/16] qtest: bump test-hmp timeout to 4 minutes
Date: Fri, 15 Dec 2023 08:03:46 +0100
Message-ID: <20231215070357.10888-6-thuth@redhat.com>
In-Reply-To: <20231215070357.10888-1-thuth@redhat.com>
References: <20231215070357.10888-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The hmp test takes just under 3 minutes in a --enable-debug
build. Bumping to 4 minutes will give more headroom.

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-6-berrange@redhat.com>
[thuth: fix copy-n-paste error in the description]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 84cec0a847..7a4160df04 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -3,7 +3,7 @@ slow_qtests = {
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-  'test-hmp' : 120,
+  'test-hmp' : 240,
 }
 
 qtests_generic = [
-- 
2.43.0


