Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003583685B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:34:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwJE-0003Iv-0i; Mon, 22 Jan 2024 10:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRwJB-0003HU-NA
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRwJA-0007LJ-61
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705937635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LRdW7EioD3mIsQpRjt1TCNE7qSACJFjDUt0MKhTIlsc=;
 b=SPLmAvfvvggVzqDpjklWV6EvvQJ/ggDzUcbRg03c/weiVCA+TL7NR7ORXcjeCat5ufEFSw
 +b1UQTjdHF50dgWaRRLEPO5jk7WHGvsWBBJgO4BswweqsCx1zRnTDT1obiPpqrbVLHDDqI
 Va6X8a5MQGlw9IFX/oCxkXz/DZ7lwwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-EbVfNEVtOCS9x6YPNeENCQ-1; Mon, 22 Jan 2024 10:33:53 -0500
X-MC-Unique: EbVfNEVtOCS9x6YPNeENCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C0CE85A589;
 Mon, 22 Jan 2024 15:33:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5FC0C259DD;
 Mon, 22 Jan 2024 15:33:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Brad Smith <brad@comstyle.com>
Subject: [PATCH] tests/unit/test-iov: Fix timeout problem on NetBSD and OpenBSD
Date: Mon, 22 Jan 2024 16:33:47 +0100
Message-ID: <20240122153347.71654-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

The test-iov code uses usleep() with small values (<= 30) in some
nested loops with many iterations. This causes a small delay on OSes
like Linux that have a precise sleeping mechanism, but on systems
like NetBSD and OpenBSD, each usleep() call takes multiple microseconds,
which then sum up in a total test time of multiple minutes!

Looking at the code, the usleep() does not really seem to be necessary
here - if not enough data could be send, we should simply always use
select() to wait 'til we can send more. Thus remove the usleep() and
re-arrange the code a little bit to make it more clear what is going
on here.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-iov.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/unit/test-iov.c b/tests/unit/test-iov.c
index 6f7623d310..75bc3be005 100644
--- a/tests/unit/test-iov.c
+++ b/tests/unit/test-iov.c
@@ -197,15 +197,17 @@ static void test_io(void)
                    s = g_test_rand_int_range(0, j - k + 1);
                    r = iov_send(sv[1], iov, niov, k, s);
                    g_assert(memcmp(iov, siov, sizeof(*iov)*niov) == 0);
-                   if (r >= 0) {
-                       k += r;
-                       usleep(g_test_rand_int_range(0, 30));
-                   } else if (errno == EAGAIN) {
-                       select(sv[1]+1, NULL, &fds, NULL, NULL);
-                       continue;
-                   } else {
-                       perror("send");
-                       exit(1);
+                   if (r < 0) {
+                        if (errno == EAGAIN) {
+                            r = 0;
+                        } else {
+                            perror("send");
+                            exit(1);
+                        }
+                   }
+                   k += r;
+                   if (k < j) {
+                        select(sv[1] + 1, NULL, &fds, NULL, NULL);
                    }
                } while(k < j);
            }
-- 
2.43.0


