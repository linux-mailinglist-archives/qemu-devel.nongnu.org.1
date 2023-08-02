Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739876D38F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZL-00062d-TY; Wed, 02 Aug 2023 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZJ-00061z-MT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:25 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZH-0006Fe-Kt
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993160; bh=FWaOaA0shu6E5Xxbp65+bl2i5eQeXmUhJ2RXCEKKVAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PGy9toFROtXX41tzZIedJtWuZScvPIFpszKD3H5zNJ5OkwHVZT6pNscoBhpNORTV+
 UmmQKtFVpuv3B+xKZIjHMNxQBbFVx6d0D0DkHRz27WLMgROk6UruzNy1DS76j1ShIX
 tkXl0tm2Kx35sfEOktMu00irinksdHzc65PkTujTHiNMkW/Qg2LbFVqLmpMceZxoLS
 sAVGWQuIvgYZS+GEOHCbp1Y7Kpoyg1F/0BhdqCI12bWHUP0vHWeT4/WsEGxQvauHzr
 0FlXJJMFr38zkLKXzsgHrWoYzG9mUix9YWeWKmxxmXIvv+weC35AENlj/sNv/iv1Yr
 8eDD5/EPBU42g==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 5930B3F21D87;
 Wed,  2 Aug 2023 09:19:20 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id obvMjmvgwiWO; Wed,  2 Aug 2023 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993158; bh=FWaOaA0shu6E5Xxbp65+bl2i5eQeXmUhJ2RXCEKKVAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AALJz+Q19qlswWaLcPmiFcngJ8NpYS1YSX3p8F5/TBdLwFstWobH7FSe7vR176NMe
 KOOe5sKBYY/Qt6m6YKeLhduaLb8iGqZw8RuJpdljFzYJSxCX2ARTHTy1fZripCJrEo
 +B9pSHVP/v9AHL/dWEM6QkfukS8vXgX0b9KCeMflpZREFm/Lry4Vo0jH+D7cyKs1OT
 AcQ8NUlgwcAqJxSxXzXHy+cR4VrxNxcUZ5FTitlIbaFRml0v1D1KTUPDsxVpnL1nMD
 60trsAJzuMK+H47TWCVMNyu3rQ+qqS/S0GhV3xvvm+8Q3qqjY2lhjYwszhDuV/DPo5
 gawlPDoPuyCig==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id DCB4E3F21CDB;
 Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 756AF1E601E9; Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Keith Packard <keithp@keithp.com>
Subject: [PATCH 2/3] target/m68k: Fix semihost lseek offset computation
Date: Wed,  2 Aug 2023 09:19:13 -0700
Message-Id: <20230802161914.395443-3-keithp@keithp.com>
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

The arguments for deposit64 are (value, start, length, fieldval); this
appears to have thought they were (value, fieldval, start,
length). Reorder the parameters to match the actual function.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/m68k/m68k-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 12235759c7..12179bde38 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -166,7 +166,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
         GET_ARG64(2);
         GET_ARG64(3);
         semihost_sys_lseek(cs, m68k_semi_u64_cb, arg0,
-                           deposit64(arg2, arg1, 32, 32), arg3);
+                           deposit64(arg2, 32, 32, arg1), arg3);
         break;
 
     case HOSTED_RENAME:
-- 
2.40.1


