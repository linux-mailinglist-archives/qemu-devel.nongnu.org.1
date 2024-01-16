Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B058282EA7C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:59:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPeKY-0002je-It; Tue, 16 Jan 2024 02:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKW-0002j7-98
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKU-00082j-Op
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705391869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY/0I2XojmiWkV1BF7mBoOC0UvyzVy2C3rOBFwJebGM=;
 b=XEZIZuPumtrMaorc3dm4fsmBBxYQz2tSrGFhMij5bbxdIzDGD0HvxMY99IBV3dx3WuVMEW
 B5cG70y7oQpOdtxKgwggVopD9+lzA7u49/zZpMZpEV2WwkaM6PjD8ii5UUSCusQ5NPBXOZ
 dYBPjINJk2SFRE2grPxoABoRDc2vvZY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-WE3oCqwwMKyhhH93M-IRLQ-1; Tue,
 16 Jan 2024 02:57:47 -0500
X-MC-Unique: WE3oCqwwMKyhhH93M-IRLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 716B129ABA2C;
 Tue, 16 Jan 2024 07:57:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 941F83C25;
 Tue, 16 Jan 2024 07:57:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/5] tests/qtest/meson.build: Bump the boot-serial-test timeout
 to 4 minutes
Date: Tue, 16 Jan 2024 08:57:40 +0100
Message-ID: <20240116075744.219169-2-thuth@redhat.com>
In-Reply-To: <20240116075744.219169-1-thuth@redhat.com>
References: <20240116075744.219169-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

When running with TCI, the boot-serial-test can take longer than 3 minutes:

 https://gitlab.com/qemu-project/qemu/-/jobs/5890481086#L4774

Bump the timeout to 4 minutes to avoid CI failures here.

Message-ID: <20240115071146.31213-1-thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fd40136fa9..78c298ce97 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -8,7 +8,7 @@ slow_qtests = {
   'test-hmp' : 240,
   'pxe-test': 600,
   'prom-env-test': 360,
-  'boot-serial-test': 180,
+  'boot-serial-test': 240,
   'qos-test': 120,
 }
 
-- 
2.43.0


