Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708647CE76E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBxO-00038I-3O; Wed, 18 Oct 2023 15:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qtBxJ-000380-4y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:11:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qtBxF-0002ii-6a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:11:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1bac:0:640:75a2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id AAD326189E;
 Wed, 18 Oct 2023 22:11:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b667::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OBrB3JBOiCg0-6ch6UrvN; Wed, 18 Oct 2023 22:11:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697656295;
 bh=uCWN1FEOfx/pGWhankfrORwQTTCG7DNUgxjj2vFcKmk=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=CuR0n1/kmspglxWuxv+yJS1qXzi5fQRBUf//wcmFXSW/B5ZofQDlaUSarTPiWFRVZ
 JuL1vVpTU0mXm9kHZCM3O7kfdvKjNpYit+SLcNR/eqG3UL6PS9bna80DctSuovLntn
 rCd78I4fAJLJi82GRKv6snet+wRQbdlm68ql9tk8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lvivier@redhat.com, thuth@redhat.com, minyard@acm.org,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
Subject: [PATCH] ipmi-bt-test: force ipv4
Date: Wed, 18 Oct 2023 22:11:23 +0300
Message-Id: <20231018191123.1176602-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We open ipv4 listening socket. But "localhost" in qemu parameters may
load to Qemu trying to connect with ipv6 and fail with "Connection
refused". Force ipv4 by using ipv4 ip address.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.34.1


