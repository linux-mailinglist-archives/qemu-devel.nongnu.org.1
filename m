Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2998756C25
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSyL-0002nm-Cx; Mon, 17 Jul 2023 14:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLSy9-0002kY-8l
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLSy7-0004pJ-Rw
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689618551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLoa8Tdq2/09yXgHyMP6Pr8MBaBfgjrN7u/rFIf1b7k=;
 b=LIgvzdRbdGKew9SKnQSOmS7UOp9qLKbyncdf+KZ75lVXnnZZkB0sQwrDZzTfjWhRN3XfOr
 WKnRIVyVdRQms32bc/PBgS+NQoKrPVqrVjA1Rjl1kX+CrFT+HtkmI38YHdafFkoFWILiHR
 pHarvmD8JI7BH0XNgDMbiSqqcV+ztos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-czGxTwehM4mqN5_a8ISuEA-1; Mon, 17 Jul 2023 14:29:07 -0400
X-MC-Unique: czGxTwehM4mqN5_a8ISuEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D432185A795;
 Mon, 17 Jul 2023 18:29:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25EE52166B25;
 Mon, 17 Jul 2023 18:29:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/12] qtest: bump test-hmp timeout to 4 minutes
Date: Mon, 17 Jul 2023 19:28:51 +0100
Message-ID: <20230717182859.707658-6-berrange@redhat.com>
In-Reply-To: <20230717182859.707658-1-berrange@redhat.com>
References: <20230717182859.707658-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The npcm7xx_pwn-test takes just under 3 minutes in a --enable-debug
build. Bumping to 4 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e28f0925e1..1070c6dc64 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -3,7 +3,7 @@ slow_qtests = {
   'migration-test' : 300,
   'npcm7xx_pwm-test': 300,
   'qom-test' : 900,
-  'test-hmp' : 120,
+  'test-hmp' : 240,
 }
 
 qtests_generic = [
-- 
2.41.0


