Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FA76D391
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZN-00063P-KZ; Wed, 02 Aug 2023 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZK-00062K-Sk
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:26 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZH-0006Fb-Kw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993159; bh=k8aWFrRyWz0HU2RDbR8GK1/MnJ0Zhzfz8Edrrl01Q2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jqAgh9SNUm+BUIRdYxTLR003/7UBqUIuMpPmb2wIkoNc9bGkaC8hqTTqE3Bjkl+/B
 DbaDjFDcKw25pixulAbHBqzaEMUA1glKCsuQKcnYi7Gbo+Mtq8VH/H52YveEkWRRJS
 kHsHcP6VU9oGIxPPPmMJvmiKM7IuSXVOUashf+9xfPJF4jaTWNbgyg4JchjiZWuCh3
 PfDKXsHxpIEcGo/pRXWKzOWw6wSJxlzt0xHKQ1Wp+ZpbjEYDadK/XasB6dd+DsXkMN
 3P+yWPnc6RxJr8dOeClDXGCy/iHTXtoljJSCQO17PmOPDrlu1ZQ9JXAkx+OfpMBUWh
 0QSVLU6/QbtdA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id A61D13F21D93;
 Wed,  2 Aug 2023 09:19:19 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id Jbfzdi1Uda7k; Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993158; bh=k8aWFrRyWz0HU2RDbR8GK1/MnJ0Zhzfz8Edrrl01Q2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ar3mq9SETzq7yAFGIQUG0dca9yhCA8xJERHH+B+iTMEbAz6Qf3ruqO911FmjBfhe0
 LPabTFT15bIVWAVrsL4UKq6Q3hncdGHy1+pfICaCcatnPy+uLRIngoaLSyBeKqtSYm
 t+uz/BwTmvRMo1HFWSUt6HjDwSSlcnBr9II/a669UG6SEP1q+q3pLn9ZWMq+mqvMUI
 WEQsyIkz2Kxi0CUd/I/6BsGhmY36dl74TPzjfC9kWe4Libqi3H+Qj/A13wh3cLrBKZ
 tdvSXBcQu3tPy0djLPJ0Bh8poYcUVsCbsYwX2bOXN7DNHmGn3QU1+SP7j1m3qdgFa+
 6SVVBT/5p4U9w==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id DCA853F217BF;
 Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 712FB1E601CB; Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Keith Packard <keithp@keithp.com>
Subject: [PATCH 1/3] target/m68k: Pass semihosting arg to exit
Date: Wed,  2 Aug 2023 09:19:12 -0700
Message-Id: <20230802161914.395443-2-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802161914.395443-1-keithp@keithp.com>
References: <20230802161914.395443-1-keithp@keithp.com>
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

Instead of using d0 (the semihost function number), use d1 (the
provide exit status).

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/m68k/m68k-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 88ad9ba814..12235759c7 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -130,8 +130,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     args = env->dregs[1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->dregs[0]);
-        exit(env->dregs[0]);
+        gdb_exit(env->dregs[1]);
+        exit(env->dregs[1]);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.40.1


