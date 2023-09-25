Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1054D7AD3A3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 10:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhDI-0005j5-4w; Mon, 25 Sep 2023 04:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkhDG-0005ir-36
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:45:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkhDE-0008T8-A1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:45:05 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MV6G0-1rCiUh32pS-00SB2c; Mon, 25
 Sep 2023 10:44:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] disas/m68k: clean up local variable shadowing
Date: Mon, 25 Sep 2023 10:44:55 +0200
Message-ID: <20230925084455.395150-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w9Xc5IXrQvt3haz2KTcSi1nxmxTQ0zQ15RLdOj87X4BkTdTOy4r
 wCXxJb17lNEOWDl5L9jcgdkSCQl4k2AXeFCNmNwXjnjdGK1aMPXgKGvmlyrtZNdgl+bJbwe
 hlv4vFVG5Uj50YubG6bSMFsiXWL3EravSsRx1GAD/TQFc7MOHh+h9IKchihvNCZEnQCn+L9
 ZnXXYPUTNZs4v070CXBkQ==
UI-OutboundReport: notjunk:1;M01:P0:vG+g2/lMua4=;pKIivCpj+O11dMDaba3Rkaj1WBP
 uYdzvAoKqX+bWVnTL6aSJ2zQa7s0z0cUo9Xf5ejlWr1Hff1mvWcWavS7F0K0iqHUw156znqD+
 Rm+3JnobxGnXuXfyNtV0ZftsSIWiGyfFJctrPzRtem2sHY1QOwlkxSTQT9SMSTCwKSqYkP9YH
 a8yM9D1oiyWk2Zbc3ZucU8Bulw58XMLsCu9jFR1O8Oiu3sHx33FePxec9vEaTUzgCCAmZTJHT
 mY/K6v1i+tegmp8Pyd6BO0NNxqPLFJas5YSKg9/mmCLkeX/rxw6uiCdSEkobz7iNDu9GhZlz0
 ykDFpbQ1CSE9J7Gcw5SvlURmgEJES8lTuWN+3QhBws2LaWqLnB8mv6JlnfNQlym4XVabLVWnu
 AH8DVX8krK+Edfwk872Ku/FFkdo2Prn3zY1bybGB4LW87SEdDGXFYFl7evLaffmP7zdvPUPPM
 l8rQvRDxZozOZYnF0SRa7fvkyuw22jjuV0yM6Vh8VuCYzWgpUu1WuFMowP6Pj0n8CslTSEDUI
 YKsdtzMv9Jf/xJeN1L0fJWjmvTTHPX0jWgrvERrbBDGxtyBb3iu5eNteb56rW3KF7CbcJmhJH
 oxu5sv3lcUY5kjBz0rVV0iS51srhvVT58cmxVG3Kfvm84/WdNYtTYMaV1OmyaW/xMMMUE1M0g
 UOPby18wtVOCBC3V326kDTxt9pK75aGFqt9grNa0KG2GXU1wP7UVUrpK1bd9LVPXfJcGfSclG
 wQGdBTACJlVxoZDDdNMCsJSmvYtNzB/+aPzB9T4cY/Mrl8pfyn/DixBb1UwRXvC1yol1PuR1W
 8aIo/Vlf6fzWEARbhIKgGvW92sIXzXqlhYp2MEPisd+zebQELlvNGunrvw5HB4yiT+OxeAiXK
 mS4AdsKJ5HWQpDw==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix following warnings

.../disas/m68k.c: In function ‘print_insn_arg’:
.../disas/m68k.c:1635:13: warning: declaration of ‘val’ shadows a previous local [-Wshadow=compatible-local]
 1635 |         int val = fetch_arg (buffer, place, 5, info);
      |             ^~~
.../disas/m68k.c:1093:7: note: shadowed declaration is here
 1093 |   int val = 0;
      |       ^~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 disas/m68k.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index aefaecfbd6cb..1f16e295ab41 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1632,10 +1632,10 @@ print_insn_arg (const char *d,
     case '2':
     case '3':
       {
-	int val = fetch_arg (buffer, place, 5, info);
+	int reg = fetch_arg (buffer, place, 5, info);
         const char *name = 0;
 
-	switch (val)
+	switch (reg)
 	  {
 	  case 2: name = "%tt0"; break;
 	  case 3: name = "%tt1"; break;
@@ -1655,12 +1655,12 @@ print_insn_arg (const char *d,
 	      int break_reg = ((buffer[3] >> 2) & 7);
 
 	      (*info->fprintf_func)
-		(info->stream, val == 0x1c ? "%%bad%d" : "%%bac%d",
+		(info->stream, reg == 0x1c ? "%%bad%d" : "%%bac%d",
 		 break_reg);
 	    }
 	    break;
 	  default:
-	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val);
+	    (*info->fprintf_func) (info->stream, "<mmu register %d>", reg);
 	  }
 	if (name)
 	  (*info->fprintf_func) (info->stream, "%s", name);
-- 
2.41.0


