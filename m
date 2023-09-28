Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD47B262E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlx6h-0007ep-OJ; Thu, 28 Sep 2023 15:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qlx6e-0007bm-US
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qlx6b-0003LS-Kr
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695930923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CX3URt4n2TNHyKzUzTP0BMFqn6HeiZvGsicv8LZFWRo=;
 b=dfBxjsH5U6ajayRInM34KYT0E3nxgzFy0xjOQhImVHMi7Wiss1WmLMhRmhBd+unQBuo4Zz
 KJC27n419rj0SWhIqm1PcTN/uVGjpLuISXeFDv9TgBxtJ+gdyTnyW6o+WQ/GF0xFVGN7FA
 8J4YwYC1xEYnux8vc+70bTmM9d3SXfs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-1ARc1tHOMuqs_2jn_UekBw-1; Thu, 28 Sep 2023 15:55:21 -0400
X-MC-Unique: 1ARc1tHOMuqs_2jn_UekBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07E18185A790;
 Thu, 28 Sep 2023 19:55:21 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB28A2026D68;
 Thu, 28 Sep 2023 19:55:20 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id BE91930C1C0A; Thu, 28 Sep 2023 19:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 BAC3C3FD54; Thu, 28 Sep 2023 21:55:20 +0200 (CEST)
Date: Thu, 28 Sep 2023 21:55:20 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
Subject: [PATCH v2] mips: fix abort on integer overflow
In-Reply-To: <6148083e-ba07-798c-4cc3-6cf29236c53c@linaro.org>
Message-ID: <3ef979a8-3ee1-eb2d-71f7-d788ff88dd11@redhat.com>
References: <cfa02bbb-cdaf-4310-ac40-a2837d33c710@redhat.com>
 <6148083e-ba07-798c-4cc3-6cf29236c53c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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



On Thu, 28 Sep 2023, Richard Henderson wrote:

> Just call force_sig_fault directly.
> 
> 
> r~

OK. Here I'm resending it.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

Qemu mips userspace emulation crashes with "qemu: unhandled CPU exception 
0x15 - aborting" when one of the integer arithmetic instructions detects 
an overflow.

This patch fixes it so that it delivers SIGFPE with FPE_INTOVF instead.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: qemu-stable@nongnu.org

---
 linux-user/mips/cpu_loop.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: qemu/linux-user/mips/cpu_loop.c
===================================================================
--- qemu.orig/linux-user/mips/cpu_loop.c
+++ qemu/linux-user/mips/cpu_loop.c
@@ -180,7 +180,9 @@ done_syscall:
             }
             force_sig_fault(TARGET_SIGFPE, si_code, env->active_tc.PC);
             break;
-
+	case EXCP_OVERFLOW:
+            force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTOVF, env->active_tc.PC);
+            break;
         /* The code below was inspired by the MIPS Linux kernel trap
          * handling code in arch/mips/kernel/traps.c.
          */


