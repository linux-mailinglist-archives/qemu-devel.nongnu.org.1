Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD6797CC5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKie-0002jW-Kx; Thu, 07 Sep 2023 15:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKic-0002hl-DM
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:31:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKiZ-0001lL-7r
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:31:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:549c:0:640:379e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1655860FA4;
 Thu,  7 Sep 2023 22:31:05 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:b5a6::1:1f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tUfIPI0OcW20-UthPuJ1Z; Thu, 07 Sep 2023 22:31:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694115064;
 bh=CYmbOkPoXn+D02Z9kxef/Ty+JYIXn6WuvGoDshA5GYw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=G9FkCCmWB5m7QY2E6WaiM8+d4D7S5KxhyOyxlZ7nVXKjf6K62dzn7xZxypMo640GE
 oaETPrXKdGAVvVjpB3vpeukscRu9M7AHLGuVW9eJV6LwErEkHZ/FG/a7VgtuvRkB/O
 1BZEUHbUPSWVpGfqRQOvLZyzFvur8uvF30U4whQk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
Subject: [PATCH v1 2/2] i386/a-b-bootblock: zero the first byte of each page
 on start
Date: Thu,  7 Sep 2023 22:30:51 +0300
Message-Id: <20230907193051.1609310-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
References: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

The migration qtest all the way up to this point used to work by sheer
luck relying on the contents of all pages from 1MiB to 100MiB to contain
the same one value in the first byte initially.

This easily breaks if we reduce the amount of RAM for the test instances
from 150MiB to e.g 110MiB since that makes SeaBIOS dirty some of the
pages starting at about 0x5dd2000 (~93 MiB) as it reuses those for the
HighMemory allocator since commit dc88f9b72df ("malloc: use large
ZoneHigh when there is enough memory").

This would result in the following errors:
    12/60 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 ERROR           2.74s   killed by signal 6 SIGABRT
    stderr:
    Memory content inconsistency at 5dd2000 first_byte = cc last_byte = cb current = 9e hit_edge = 1
    Memory content inconsistency at 5dd3000 first_byte = cc last_byte = cb current = 89 hit_edge = 1
    Memory content inconsistency at 5dd4000 first_byte = cc last_byte = cb current = 23 hit_edge = 1
    Memory content inconsistency at 5dd5000 first_byte = cc last_byte = cb current = 31 hit_edge = 1
    Memory content inconsistency at 5dd6000 first_byte = cc last_byte = cb current = 70 hit_edge = 1
    Memory content inconsistency at 5dd7000 first_byte = cc last_byte = cb current = ff hit_edge = 1
    Memory content inconsistency at 5dd8000 first_byte = cc last_byte = cb current = 54 hit_edge = 1
    Memory content inconsistency at 5dd9000 first_byte = cc last_byte = cb current = 64 hit_edge = 1
    Memory content inconsistency at 5dda000 first_byte = cc last_byte = cb current = 1d hit_edge = 1
    Memory content inconsistency at 5ddb000 first_byte = cc last_byte = cb current = 1a hit_edge = 1
    and in another 26 pages**
    ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)

Fix this by always zeroing the first byte of each page in the range so
that we get consistent results no matter the initial contents.

Fixes: ea0c6d62391 ("test: Postcopy")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 tests/migration/i386/a-b-bootblock.S |  9 +++++++++
 tests/migration/i386/a-b-bootblock.h | 16 ++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
index 036216e4a7..6bb9999d60 100644
--- a/tests/migration/i386/a-b-bootblock.S
+++ b/tests/migration/i386/a-b-bootblock.S
@@ -44,6 +44,15 @@ start:             # at 0x7c00 ?
 
         # bl keeps a counter so we limit the output speed
         mov $0, %bl
+
+pre_zero:
+        mov $TEST_MEM_START,%eax
+do_zero:
+        movb $0, (%eax)
+        add $4096,%eax
+        cmp $TEST_MEM_END,%eax
+        jl do_zero
+
 mainloop:
         mov $TEST_MEM_START,%eax
 innerloop:
diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
index b7b0fce2ee..5b523917ce 100644
--- a/tests/migration/i386/a-b-bootblock.h
+++ b/tests/migration/i386/a-b-bootblock.h
@@ -4,18 +4,18 @@
  * the header and the assembler differences in your patch submission.
  */
 unsigned char x86_bootsect[] = {
-  0xfa, 0x0f, 0x01, 0x16, 0x78, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
+  0xfa, 0x0f, 0x01, 0x16, 0x8c, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
   0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
   0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
   0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
-  0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
-  0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8,
-  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
-  0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00,
-  0x27, 0x00, 0x60, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0xc6, 0x00, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00,
+  0x40, 0x06, 0x7c, 0xf1, 0xb8, 0x00, 0x00, 0x10, 0x00, 0xfe, 0x00, 0x05,
+  0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40, 0x06, 0x7c, 0xf2, 0xfe,
+  0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8, 0x42, 0x00, 0x66, 0xba,
+  0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
+  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x74, 0x7c,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-- 
2.34.1


