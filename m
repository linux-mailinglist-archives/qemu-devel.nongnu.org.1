Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C77E6BF4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:03:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15bA-0007Ok-58; Thu, 09 Nov 2023 09:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zf-0005FZ-B5; Thu, 09 Nov 2023 09:00:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zc-0005Su-88; Thu, 09 Nov 2023 08:59:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B446D31BBE;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BEF5A344F7;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462778 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 08/62] linux-user/hppa: clear the PSW 'N' bit when
 delivering signals
Date: Thu,  9 Nov 2023 16:58:36 +0300
Message-Id: <20231109135933.1462615-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Mikulas Patocka <mpatocka@redhat.com>

qemu-hppa may crash when delivering a signal. It can be demonstrated with
this program. Compile the program with "hppa-linux-gnu-gcc -O2 signal.c"
and run it with "qemu-hppa -one-insn-per-tb a.out". It reports that the
address of the flag is 0xb4 and it crashes when attempting to touch it.

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <signal.h>

sig_atomic_t flag;

void sig(int n)
{
	printf("&flag: %p\n", &flag);
	flag = 1;
}

int main(void)
{
	struct sigaction sa;
	struct itimerval it;

	sa.sa_handler = sig;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_RESTART;
	if (sigaction(SIGALRM, &sa, NULL)) perror("sigaction"), exit(1);

	it.it_interval.tv_sec = 0;
	it.it_interval.tv_usec = 100;
	it.it_value.tv_sec = it.it_interval.tv_sec;
	it.it_value.tv_usec = it.it_interval.tv_usec;

	if (setitimer(ITIMER_REAL, &it, NULL)) perror("setitimer"), exit(1);

	while (1) {
	}
}

The reason for the crash is that the signal handling routine doesn't clear
the 'N' flag in the PSW. If the signal interrupts a thread when the 'N'
flag is set, the flag remains set at the beginning of the signal handler
and the first instruction of the signal handler is skipped.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 2529497cb6b298e732e8dbe5212da7925240b4f4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index f253a15864..3a976ac693 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -159,6 +159,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
     env->iaoq_f = haddr;
     env->iaoq_b = haddr + 4;
+    env->psw_n = 0;
     return;
 
  give_sigsegv:
-- 
2.39.2


