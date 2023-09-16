Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0617A310C
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 17:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhWyT-0005Ry-Nn; Sat, 16 Sep 2023 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qhVhR-0005GF-PG
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 09:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qhVhO-00022U-N7
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 09:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694872260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=V5Ps3a4lJ+EI3U+7BofjCe0p/UZQX+zLEOiygSYpzvo=;
 b=EV1sEhh0Kkya5YU+tB6u6bmvNQHRUBrlUmeL5JlYa/UK7VGxW7neGbkpdrx0Neug+RGqHK
 sxtzo0gMuubqUnaVohlh+63IYM3eL28c7shkkp88CF5mVD/Vn2cJMZXTVs/6/2OX/6O4M3
 1YnYqwJiEdtQbYJGhOYTDiBHly1VYxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-D1xesqKoMZSNQ706M3z0Pg-1; Sat, 16 Sep 2023 09:49:42 -0400
X-MC-Unique: D1xesqKoMZSNQ706M3z0Pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79D00101A529;
 Sat, 16 Sep 2023 13:49:42 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BCFA28FE;
 Sat, 16 Sep 2023 13:49:42 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id 4249730C1C0A; Sat, 16 Sep 2023 13:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 3E2EA3FB77; Sat, 16 Sep 2023 15:49:42 +0200 (CEST)
Date: Sat, 16 Sep 2023 15:49:42 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>
cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
Subject: [PATCH] target/hppa: clear the PSW 'N' bit when delivering signals
Message-ID: <f69ce25f-733d-7931-e59c-e3f1279b965a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 16 Sep 2023 11:12:44 -0400
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

---
 linux-user/hppa/signal.c |    1 +
 1 file changed, 1 insertion(+)

Index: qemu/linux-user/hppa/signal.c
===================================================================
--- qemu.orig/linux-user/hppa/signal.c
+++ qemu/linux-user/hppa/signal.c
@@ -159,6 +159,7 @@ void setup_rt_frame(int sig, struct targ
     }
     env->iaoq_f = haddr;
     env->iaoq_b = haddr + 4;
+    env->psw_n = 0;
     return;
 
  give_sigsegv:


