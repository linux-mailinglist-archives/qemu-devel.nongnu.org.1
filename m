Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA2676A43E
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbZx-0004fB-5Q; Mon, 31 Jul 2023 18:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQbZt-0004ej-Bz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:41:25 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQbZr-0004Ft-7S
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690843278; bh=a/2Xu2mdLyVTDWdICKJBllW3ZyjEoTCXu+SkGy7jSYg=;
 h=From:To:Cc:Subject:Date:From;
 b=QD4xfFqoHe2wgpmG/2giYLxgSddc9ICzT46mpPCq26GPfJnqxA8aoTWoxKP7PJSWe
 RDndvgxt/u1cdGdJ++MhhCsYeLXQObZ8mmFurJ8dxnIV+OrrwVFqBMYkNBIn53ZyYZ
 AtX6067LtHFgR7Soxf/XlevYiDYjfEhUgP4T6IcFmkIoCTofug/xYwixdUfMRgADQQ
 Ktmnnpqql0NXOovPjjoemDIZFld5M62xDI04dMFhhFuN+brERqgaxFex6/xmEub0Mw
 48nC93hjNK92Plj1E2RYofpDIP6Vw2YwVvZLBNTNOJnrKOuJI9xH8FA85LrhQHCjTt
 ZibthY3JSHxBg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id BE3D63F206C6;
 Mon, 31 Jul 2023 15:41:18 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 38ysVk7h4n4b; Mon, 31 Jul 2023 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690843277; bh=a/2Xu2mdLyVTDWdICKJBllW3ZyjEoTCXu+SkGy7jSYg=;
 h=From:To:Cc:Subject:Date:From;
 b=PVeCUtnMyrXYcpg43UJ1WRazD5sb3laZkccJikqY0fGrDqwgTLnXLPu+/yAVttTEH
 F9jIdUDSLLpVbTVJmR7nbMGELG+LGc4wqjV44MWJOyd+hkRlyVCGWtHWWg7VZ2gc2X
 E4nJaRCiFWQ0oEOWGIeqytzXfOdDIrJVoyiDUFbazv5fbTp0vPiOaOaMiOZCz6HAY2
 heKqzR9ly2mTt1IVC/y2R5GJUWwwW/03TkWMHsKIFWHQA5n0JK0mcwnTIvc27z1/Wj
 I4pA6fXplpfltD4zV27Qy3+aVJ5MrDPxPp7D1vmt7XC59sgMJNa5NtkBN6PbK64EVM
 5ScX+XQf+SRyA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 3E16D3F20874;
 Mon, 31 Jul 2023 15:41:17 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id DF54E1E601E7; Mon, 31 Jul 2023 15:41:16 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH] target/nios2: Pass semihosting arg to exit
Date: Mon, 31 Jul 2023 15:41:06 -0700
Message-Id: <20230731224106.292845-1-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Instead of using the function number (which is always zero), fetch the
application-provided exit code argument and pass that to the two exit
functions.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/nios2/nios2-semi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index 3738774976..ffd1f095f6 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -133,8 +133,9 @@ void do_nios2_semihosting(CPUNios2State *env)
     args = env->regs[R_ARG1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->regs[R_ARG0]);
-        exit(env->regs[R_ARG0]);
+        GET_ARG(0);
+        gdb_exit(arg0);
+        exit(arg0);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.40.1


