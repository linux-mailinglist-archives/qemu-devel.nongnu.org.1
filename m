Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 223757AC7AC
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 13:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkN6L-00086Q-FP; Sun, 24 Sep 2023 07:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qkN6H-00086A-2S
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 07:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qkN6F-0000Uy-DR
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 07:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695554189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=bTxbKYX56/BsNFMQRlSd/YG8rAiPIX/TOsqyHftQddI=;
 b=IYd1DVe7oYX/W2Lm7gUL34L4EsIW8gxKgtClXv5y3xMep83h3g3R+4MZrEMKp++wfE0UdN
 f51wXZU7ue8DKG/d9Y4jGHXmp2Hl7n7HCZ58ykSAxnAN0UWNme4gJJXo3Cf0su09ErCg/X
 46tLPj97qQeRXdcnPbORdk+ECZI9eaY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-N38yAYgMNjCThouJGeh0Rg-1; Sun, 24 Sep 2023 07:16:25 -0400
X-MC-Unique: N38yAYgMNjCThouJGeh0Rg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE15629AA2C3;
 Sun, 24 Sep 2023 11:16:24 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C99CF2156701;
 Sun, 24 Sep 2023 11:16:24 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id 9A38030C1C0A; Sun, 24 Sep 2023 11:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 965E13FB77; Sun, 24 Sep 2023 13:16:24 +0200 (CEST)
Date: Sun, 24 Sep 2023 13:16:24 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Huacai Chen <chenhuacai@kernel.org>
cc: qemu-devel@nongnu.org
Subject: [PATCH] mips: fix abort on integer overflow
Message-ID: <cfa02bbb-cdaf-4310-ac40-a2837d33c710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
+            do_tr_or_bp(env, BRK_OVERFLOW, false);
+            break;
         /* The code below was inspired by the MIPS Linux kernel trap
          * handling code in arch/mips/kernel/traps.c.
          */


