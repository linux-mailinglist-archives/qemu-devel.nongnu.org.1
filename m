Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60A797CB9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:31:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKib-0002dl-Sm; Thu, 07 Sep 2023 15:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKia-0002c6-AK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:31:08 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKiY-0001l5-28
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:31:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:549c:0:640:379e:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 0405E61DC2;
 Thu,  7 Sep 2023 22:31:04 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:b5a6::1:1f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tUfIPI0OcW20-YZgZLXO5; Thu, 07 Sep 2023 22:31:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694115063;
 bh=1ae5a0jNR8LuCovRSIsdYlZnQhMfptRwbn5E6cdAiJo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Mh9xt4vsKGHfMycv278mPs29OG28zUJS4uDV2WXeAGaN7aFRs80DOZ3ddiGPn7rIy
 rSn9Dn+ou8Pu+d7Jy+/SdDXKSy9ikm9M1HqS0xdZy7WKWOaFuCH71I/bD8mKu0e1sQ
 HV/aQCr7clUoIr4ADi9WwBF3FcMvUY2fsiOAo7aU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
Subject: [PATCH v1 1/2] i386/a-b-bootblock: factor test memory addresses out
 into constants
Date: Thu,  7 Sep 2023 22:30:50 +0300
Message-Id: <20230907193051.1609310-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
References: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

So that we have less magic numbers to deal with. This also allows us to
reuse these in the following commits.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 tests/migration/i386/a-b-bootblock.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
index 3d464c7568..036216e4a7 100644
--- a/tests/migration/i386/a-b-bootblock.S
+++ b/tests/migration/i386/a-b-bootblock.S
@@ -34,6 +34,10 @@ start:             # at 0x7c00 ?
         mov $16,%eax
         mov %eax,%ds
 
+# Start from 1MB
+.set TEST_MEM_START, (1024*1024)
+.set TEST_MEM_END, (100*1024*1024)
+
         mov $65,%ax
         mov $0x3f8,%dx
         outb %al,%dx
@@ -41,12 +45,11 @@ start:             # at 0x7c00 ?
         # bl keeps a counter so we limit the output speed
         mov $0, %bl
 mainloop:
-        # Start from 1MB
-        mov $(1024*1024),%eax
+        mov $TEST_MEM_START,%eax
 innerloop:
         incb (%eax)
         add $4096,%eax
-        cmp $(100*1024*1024),%eax
+        cmp $TEST_MEM_END,%eax
         jl innerloop
 
         inc %bl
-- 
2.34.1


