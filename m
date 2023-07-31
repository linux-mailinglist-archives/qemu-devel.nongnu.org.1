Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C9C76A539
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 01:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQch7-0005Je-SU; Mon, 31 Jul 2023 19:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQch5-0005JV-Fb
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 19:52:55 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQch3-00055o-Cu
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 19:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690847570; bh=xrpd7miS6xdyyh0elVy6E4XLvhnZ9Y4rjUYuH/IPFbs=;
 h=From:To:Cc:Subject:Date:From;
 b=qlW1Kh8HwgCqvvoosaK6l1qwAey0GvqA+QCLaCTs6ukkoKuO3uJ8KYZs04EYfCRn+
 orBL1VxGJq4HT70Ot8+5Yb/jGG33gKfnpGIWhL19mv3KBj7T1KU1aZh1BQ9b0p5lKT
 F/D2JTZCdJtH85yVA4N0tatN5OtC9nWKHSWzp34GAkb0HMQFU6maFfJIVIkVUNrEJp
 xFRmm4cRQK3OgcrobdprmSYjHlVq8TJxgS2veaSFXbLvjeS5Jr6KEx4vun4W9QvQIT
 qfE7KJYsT9owb22rAOzdhb+8M3BH1rf+No8+AckRXZnU/hlj8GgIzX3zl7Z0xoxtzj
 vf6nhmgYRtWug==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 83B693F20874;
 Mon, 31 Jul 2023 16:52:50 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 6061EUqGBaY0; Mon, 31 Jul 2023 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690847569; bh=xrpd7miS6xdyyh0elVy6E4XLvhnZ9Y4rjUYuH/IPFbs=;
 h=From:To:Cc:Subject:Date:From;
 b=iKMtPkOQ8t/EQRsPF1eZTaXWZEd5lbny+qiufOCPxbA/rB+m1dWjCGpHDY56t7/2v
 GotkghX4Sonk2+b1aRy0Jy3caXwrHWhC1sJ7dTgG3tNY14pPiq/DDju1ilFperD1SP
 i6Hw6dLG9QYSJ0tve2akI+SQ+1s8Qt7JHwQwYMd8ekdwoRX/ZppIL7MWuHjLisPoJi
 IRZbvEi//jkoMRHQ5s1Hw18CytXeB3hmVMI11JWja9qC92ApG0nS+gnqwn9Mt3Vbkv
 hUBvuAieajhYgcmQWGtLRjx5fN6Ffzuedp8FqqRRMn87rkd6OIb50r/z8g8p+POiW2
 5Dc824XtOz1GA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id A73E03F206C6;
 Mon, 31 Jul 2023 16:52:49 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 7337B1E601E9; Mon, 31 Jul 2023 16:52:49 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH] target/nios2: Fix semihost lseek offset computation
Date: Mon, 31 Jul 2023 16:52:45 -0700
Message-Id: <20230731235245.295513-1-keithp@keithp.com>
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

The arguments for deposit64 are (value, start, length, fieldval); this
appears to have thought they were (value, fieldval, start,
length). Reorder the parameters to match the actual function.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/nios2/nios2-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index ffd1f095f6..fc1df1dfeb 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -170,7 +170,7 @@ void do_nios2_semihosting(CPUNios2State *env)
         GET_ARG64(2);
         GET_ARG64(3);
         semihost_sys_lseek(cs, nios2_semi_u64_cb, arg0,
-                           deposit64(arg2, arg1, 32, 32), arg3);
+                           deposit64(arg2, 32, 32, arg1), arg3);
         break;
 
     case HOSTED_RENAME:
-- 
2.40.1


