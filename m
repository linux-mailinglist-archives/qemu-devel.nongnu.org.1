Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5997D93F1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHs-0002ao-Et; Fri, 27 Oct 2023 05:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHo-0002aJ-FI
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHn-0002o0-3B
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kEW7BnJKaXli1N5Bzt3ZR13DvDGsRuqgH9ZXI6swEQ=;
 b=EApWM0QMTRc+eAWajHLVauYhbmcqoboQ1j99stUQvZPKVvWxK1tD+VmOyHqla3SteEHx8A
 og/SovYj8twvzD8c4UDOJXM6QMe19bHuD/1wB5/s/PyaYQIqMw05sz3nPTLxyzdYekQ18V
 VbO5XZa5XzM2wO8nqaKSH3WYV9KBKfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Gg8vosjeMNO0DN4B-tpqwQ-1; Fri, 27 Oct 2023 05:37:29 -0400
X-MC-Unique: Gg8vosjeMNO0DN4B-tpqwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97672185A781;
 Fri, 27 Oct 2023 09:37:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9C111121319;
 Fri, 27 Oct 2023 09:37:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Corey Minyard <cminyard@mvista.com>
Subject: [PULL 11/11] ipmi-bt-test: force ipv4
Date: Fri, 27 Oct 2023 11:37:10 +0200
Message-ID: <20231027093710.273558-12-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We open ipv4 listening socket. But "localhost" in qemu parameters may
load to Qemu trying to connect with ipv6 and fail with "Connection
refused". Force ipv4 by using ipv4 ip address.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20231018191123.1176602-1-vsementsov@yandex-team.ru>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/ipmi-bt-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
index ed431e34e6..383239bcd4 100644
--- a/tests/qtest/ipmi-bt-test.c
+++ b/tests/qtest/ipmi-bt-test.c
@@ -411,7 +411,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     global_qtest = qtest_initf(
-        " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
+        " -chardev socket,id=ipmi0,host=127.0.0.1,port=%d,reconnect=10"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
         " -device isa-ipmi-bt,bmc=bmc0", emu_port);
     qtest_irq_intercept_in(global_qtest, "ioapic");
-- 
2.41.0


