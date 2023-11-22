Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB437F4589
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5m8z-0007hE-MX; Wed, 22 Nov 2023 07:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r5m8u-0007eN-40; Wed, 22 Nov 2023 07:15:46 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r5m8s-0006ky-18; Wed, 22 Nov 2023 07:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=gzEdt4IIz7mke04dLp4NFBEK7maOCy0uinMh9XRkmf8=; b=qiLNIx5dMtcQ
 GnZNTJgEDGV0RAr5IeQbUrBa8nKS7/z+I6M9Meo5aOxxP3qArZDRNgIYVdpT/3cH2BZ/I4lprMmNz
 8AnUlv3V58EK58pKP6bbQnd/UWkUu7LYqdq4sH5DH98e9bN5XkTfQqVwMzIqfJhv1gOxMyGf1u8VX
 MelhNWoswts1+vEYHbPMIw4geQdkSM9ZcW7P3AHfGBM1e72mU+/meIfZpm8b3cLvgeX03TBtp5R7x
 I0wqoVh+gH3B1RQHAOVlJDB2VsGycvHOMRIwMFBLygQWxSdGnCOGLe/7ujH1KQiHgTU23J0lkKH7y
 hBJ50Zo9s/R9+goIhIfqpg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1r5m7Z-004kUj-36;
 Wed, 22 Nov 2023 13:15:26 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] iotests: fix default MT detection
Date: Wed, 22 Nov 2023 14:15:38 +0200
Message-Id: <20231122121538.32903-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MT is being detected based on "-M help" output, and we're searching for
the line ending with " (default)".  However, in downstream one of the
MTs marked as deprecated might become the default, in which case this
logic breaks as the line would now end with " (default) (deprecated)".
To fix potential issues here, let's relax that requirement and detect
the mere presence of " (default)" line instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/testenv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index e67ebd254b..3ff38f2661 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -40,7 +40,7 @@ def get_default_machine(qemu_prog: str) -> str:
 
     machines = outp.split('\n')
     try:
-        default_machine = next(m for m in machines if m.endswith(' (default)'))
+        default_machine = next(m for m in machines if ' (default)' in m)
     except StopIteration:
         return ''
     default_machine = default_machine.split(' ', 1)[0]
-- 
2.39.3


