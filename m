Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3887708D4
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0Jt-0002qN-Ng; Fri, 04 Aug 2023 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Jn-000292-3W; Fri, 04 Aug 2023 15:18:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Jl-00079e-EA; Fri, 04 Aug 2023 15:18:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11A3D1846A;
 Fri,  4 Aug 2023 22:17:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 99A921B8AD;
 Fri,  4 Aug 2023 22:16:54 +0300 (MSK)
Received: (nullmailer pid 1875759 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 56/63] target/hppa: Move iaoq registers and thus reduce
 generated code size
Date: Fri,  4 Aug 2023 22:16:39 +0300
Message-Id: <20230804191647.1875608-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Helge Deller <deller@gmx.de>

On hppa the Instruction Address Offset Queue (IAOQ) registers specifies
the next to-be-executed instructions addresses. Each generated TB writes those
registers at least once, so those registers are used heavily in generated
code.

Looking at the generated assembly, for a x86-64 host this code
to write the address $0x7ffe826f into iaoq_f is generated:
0x7f73e8000184:  c7 85 d4 01 00 00 6f 82  movl     $0x7ffe826f, 0x1d4(%rbp)
0x7f73e800018c:  fe 7f
0x7f73e800018e:  c7 85 d8 01 00 00 73 82  movl     $0x7ffe8273, 0x1d8(%rbp)
0x7f73e8000196:  fe 7f

With the trivial change, by moving the variables iaoq_f and iaoq_b to
the top of struct CPUArchState, the offset to %rbp is reduced (from
0x1d4 to 0), which allows the x86-64 tcg to generate 3 bytes less of
generated code per move instruction:
0x7fc1e800018c:  c7 45 00 6f 82 fe 7f     movl     $0x7ffe826f, (%rbp)
0x7fc1e8000193:  c7 45 04 73 82 fe 7f     movl     $0x7ffe8273, 4(%rbp)

Overall this is a reduction of generated code (not a reduction of
number of instructions).
A test run with checks the generated code size by running "/bin/ls"
with qemu-user shows that the code size shrinks from 1616767 to 1569273
bytes, which is ~97% of the former size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
(cherry picked from commit f8c0fd9804f435a20c3baa4c0c77ba9a02af24ef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index b595ef25a9..c7659e5b0d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -168,6 +168,9 @@ typedef struct {
 } hppa_tlb_entry;
 
 typedef struct CPUArchState {
+    target_ureg iaoq_f;      /* front */
+    target_ureg iaoq_b;      /* back, aka next instruction */
+
     target_ureg gr[32];
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
@@ -186,8 +189,6 @@ typedef struct CPUArchState {
     target_ureg psw_cb;      /* in least significant bit of next nibble */
     target_ureg psw_cb_msb;  /* boolean */
 
-    target_ureg iaoq_f;      /* front */
-    target_ureg iaoq_b;      /* back, aka next instruction */
     uint64_t iasq_f;
     uint64_t iasq_b;
 
-- 
2.39.2


