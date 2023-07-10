Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53A74D535
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpol-0000zP-MQ; Mon, 10 Jul 2023 08:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoQ-0000s4-CL
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoO-0003XU-TF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo6HpPaE719qne02JMdMJ84L5Ng2oSgjEWw9yCAACDQ=;
 b=Ok6FFwGd3ZI/HcTQRLvMlyiCqLElr1Kq2aStfo9HTf+qNDuG2P9zpEgLtu/Tz5vcwlooyZ
 H+HxqeKaRoh0rWJjcJuFW/wcXJ8LYVSvOqVYcmcFSy6AndTluXh8gS4dS3IhEIn108Eb7p
 Tk1n7GSFYChf8XKBdkeM1lpkeb5i4dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-VAZ6nix1Mw-xOoz11kP2QQ-1; Mon, 10 Jul 2023 08:16:13 -0400
X-MC-Unique: VAZ6nix1Mw-xOoz11kP2QQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C554185A7A5;
 Mon, 10 Jul 2023 12:16:12 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F57CF5CFA;
 Mon, 10 Jul 2023 12:16:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 19/21] tests/tcg/s390x: Fix test-svc with clang
Date: Mon, 10 Jul 2023 14:15:41 +0200
Message-Id: <20230710121543.197250-20-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

clang does not support expressions involving symbols in instructions
like lghi yet, so building hello-s390x-asm.S with it fails.

Move the expression to the literal pool and load it from there.

Fixes: be4a4cb42961 ("tests/tcg/s390x: Test single-stepping SVC")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230707154242.457706-1-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/gdbstub/test-svc.py | 2 +-
 tests/tcg/s390x/hello-s390x-asm.S   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 7851ca7284..18fad3f163 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -25,7 +25,7 @@ def run_test():
     gdb.execute("si")
     report("larl\t" in gdb.execute("x/i $pc", False, True), "insn #2")
     gdb.execute("si")
-    report("lghi\t" in gdb.execute("x/i $pc", False, True), "insn #3")
+    report("lgrl\t" in gdb.execute("x/i $pc", False, True), "insn #3")
     gdb.execute("si")
     report("svc\t" in gdb.execute("x/i $pc", False, True), "insn #4")
     gdb.execute("si")
diff --git a/tests/tcg/s390x/hello-s390x-asm.S b/tests/tcg/s390x/hello-s390x-asm.S
index 2e9faa1604..4dbda12d35 100644
--- a/tests/tcg/s390x/hello-s390x-asm.S
+++ b/tests/tcg/s390x/hello-s390x-asm.S
@@ -8,7 +8,7 @@ _start:
 /* puts("Hello, World!"); */
 lghi %r2,1
 larl %r3,foo
-lghi %r4,foo_end-foo
+lgrl %r4,foo_len
 svc 4
 
 /* exit(0); */
@@ -18,3 +18,5 @@ svc 1
 .align 2
 foo: .asciz "Hello, World!\n"
 foo_end:
+.align 8
+foo_len: .quad foo_end-foo
-- 
2.39.3


