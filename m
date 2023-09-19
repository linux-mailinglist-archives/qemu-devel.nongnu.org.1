Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D19877A6B61
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigEt-00064b-4s; Tue, 19 Sep 2023 15:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qigEm-000613-Hl; Tue, 19 Sep 2023 15:18:20 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qigEk-0008A7-OU; Tue, 19 Sep 2023 15:18:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 0A87ECE1302;
 Tue, 19 Sep 2023 19:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8EC433C9;
 Tue, 19 Sep 2023 19:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695151093;
 bh=XmuE9aZ81k3K7jMFdg2gxPS8pizbwALL2hfdIcy4sdY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TeGT28BJSAeZ7+IFXjnwrLRflgG1ytedG5/QvsiDAg86unC3C+dHX0k8KYlJS0a8b
 M+t8ekUWSMeiBd1zNYRODUdxdxWTp2Hv+3DPtquK+SCrGJeaBG1n+gY165KbVYJfKJ
 +YZO9RCYyL+qV2jBpQEl57MC14+4yNKeO9SjcdpecFJPwrw07Ejlfti9GNqPBIyT05
 KA1T9geYmvTRdTEAjhx5ZmspN4mUpEQngbTWBdK0kJbGw1GTPrfkSSgzodjTgsDi1+
 OALyRZ2PMarNTzlPJ73TlOIl0HwRA/v4JMvedSKMrtHNu6TFlJHK2D3JF4tL8m2tmB
 XNK8etrpz+RQQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 7/8] linux-user/hppa: clear the PSW 'N' bit when delivering
 signals
Date: Tue, 19 Sep 2023 21:17:55 +0200
Message-ID: <20230919191757.98889-8-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919191757.98889-1-deller@kernel.org>
References: <20230919191757.98889-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/hppa/signal.c | 1 +
 1 file changed, 1 insertion(+)

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
2.41.0


