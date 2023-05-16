Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACC704E14
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6L-0004Sx-DE; Tue, 16 May 2023 08:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-0004KK-SS
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6E-00063X-7t
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:20 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MRVy9-1pmRn02J4X-00NTzh; Tue, 16
 May 2023 14:48:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 7/9] linux-user: Don't require PROT_READ for mincore
Date: Tue, 16 May 2023 14:48:08 +0200
Message-Id: <20230516124810.90494-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a0zkQxmXJBtx1G5t1mQ3oRg22b9CQ4/yxg0gcRFZzW4B5IEiZkr
 D2r1viVyfNtiA7jI0xrFdlzG8qyXBcn2H+co7mQV28TUdgEOv9q5lA8RFtApmLPOGlTS6wb
 GhFQx8Qlxni8BB27TJ2NdCvycHSRHffLu1WtddEh/3a+AYZTUnFpDPcWm1XaSK0z3S+Hyiy
 1OG3cMso0rsjDehmoO+GQ==
UI-OutboundReport: notjunk:1;M01:P0:A7uomkmtvSA=;dvxBXvojbEZY7GoroeXvRZBXROD
 mLXsOOxk8y4/i+vkirpLl5TJG8rEjg4qDad8zxwhoZ3rk+bVBdFE2m3kG3aaBCbs3wK5ymwQ/
 HJmExzHu8Y2yQ6v52YyDYGAzcclutNFiNrq2yY8c+0IjB7Wqo+HFRJeUyvISi5KN2UnP3vKQ7
 x/rcaRHaS5Ntqi5O8n/sTOYnu5JjVdnr8YtmB2e9M049sIzIuD5C0jdPGqDMXowzFVBoZomnS
 Ogof+3nAGe+g0lFnJLJAvE+PxsIYH9i5sD0JtaUqC9HgdURD439vCGlcWQI5JlJ+1jiNZ8kDs
 nW9q1db+aHFz0KCYMDVt4jXhCXXpco4JjlMZtoLmzVIGve1Tij2kn/DrmmSUc/8jiSP0FsCaE
 /xaoQ6B2D0iW2v0dw/RjZCOBQbnnqwYwk3gIiKaAcgCKz51u1xGWdgf3E+DcLaaV8ooFZQi3s
 lxoIAZMevCUo27wpnv9tXKDOEP3E0/FW0lB3g8QluAhFWmVoiBKTbbqFAuJ5q3c/uB18GsufK
 s9FUZoSUFBzrMMrpJhngZcrIY0OkKsabjw6swTn6ahuqjAM0SjZyk5LFyjqIsBGHbrFyxbz2d
 a75FunZrHXKq1XNqKp3YKx4992b1Y2TtBi+AL/3WNAqbfwD2tl80KH3pi5YKIrvAdR5DrxZTV
 iSve0acLr1MTej0oXKDGnHnPJehVdQqSqQeW42d1wA==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The kernel does not require PROT_READ for addresses passed to mincore.
For example the fincore(1) tool from util-linux uses PROT_NONE and
currently does not work under qemu-user.

Example (with fincore(1) from util-linux 2.38):

$ fincore /proc/self/exe
RES PAGES  SIZE FILE
24K     6 22.1K /proc/self/exe

$ qemu-x86_64 /usr/bin/fincore /proc/self/exe
fincore: failed to do mincore: /proc/self/exe: Cannot allocate memory

With this patch:

$ ./build/qemu-x86_64 /usr/bin/fincore /proc/self/exe
RES PAGES  SIZE FILE
24K     6 22.1K /proc/self/exe

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230422100314.1650-3-thomas@t-8ch.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 00a779797efb..6655982821ba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11993,7 +11993,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
-            void *a = lock_user(VERIFY_READ, arg1, arg2, 0);
+            void *a = lock_user(VERIFY_NONE, arg1, arg2, 0);
             if (!a) {
                 return -TARGET_ENOMEM;
             }
-- 
2.40.1


