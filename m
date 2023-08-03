Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5976F5C6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:36:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRgub-0000QG-KK; Thu, 03 Aug 2023 18:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRguT-0008T9-7V; Thu, 03 Aug 2023 18:35:09 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qRguR-000636-F9; Thu, 03 Aug 2023 18:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691102103; x=1691706903; i=deller@gmx.de;
 bh=9LCv3E/g3KXY6V6I9LfqyAaTbpEeFoUpA3Aeuu9UwD8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XCZM6+h/asn2zWj3BL9Ebhe4sQXgZgszCf5masLOoma11qFHdzPYnLvX7pF/hU014bcghE9
 Is79P71vV8rwV9HjbecSn7mi3cpjCY/n+F+NdbzbILcpx5kM2O14IXlPxbrl5b4NGPYHID3Dk
 pnntQ93P3A7PU7/jWh91tRz3vzqyDsOU8zxoUK0QacugfT5T2w8jlijxxJrTsKElyN3uNOzM1
 /fXf/DILrLKCzb5QfwmMvjcz6lNGpFZdRO7KViZUEIaokZiKyLd9KppxzrDEg50nBR9DHmN5H
 lmEz4VYNKzrVnBz6uKBulxXCrIhw/7EXZtP/ysW25V6jyTHpVrOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1q4iUl0gT6-00nkPu; Fri, 04
 Aug 2023 00:35:03 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 1/1] target/hppa: Move iaoq registers and thus reduce generated
 code size
Date: Fri,  4 Aug 2023 00:35:02 +0200
Message-ID: <20230803223502.653223-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803223502.653223-1-deller@gmx.de>
References: <20230803223502.653223-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:830NITqZd9ri1T3pjzcHAHxfBnquY0sXQSHQYQ9P8PHa52y6flJ
 ujb9MnFM8T436v0hXcAfQZ+5LW+ie84HbonWgQdIOw/eF5hSPt3/8p4ZMdqfc6ukGOgcFks
 qvWj02ozc/pAlOcj9YzeEh1VLgqmOqjyqrI9Xq4SdRAceYEyW1Ki9ZJcmPNU13vyE4EbNde
 DJghT3CbrIlJZzAh8cE3g==
UI-OutboundReport: notjunk:1;M01:P0:wd/0gPt0QAM=;y/8uB2faRyRonPrhjLjIgM39EaS
 +axKW+dCCVPWUmIukCkH8N38tkw0dBfz3h0WLx7qvOGNV2kt4ub8AhjwrozCwP+C+Ko5oeiAn
 Jh4uXCKmwSRmFl/pJn9DDc5dQRg8yb8UkihQacKhk1GkfDmI+MaK9vmhJGh3zjG7z6+9aMmAX
 5+I4nTSyYIdo054kYja+wwamGojH22QV/p2cEMu1iomqeCuw2pY7Ptb5UiUBjOkT1o7bLNLQ4
 xOewD+BZoQ59JhHcAlSsf4Ej+W1Y1iAEJJbVnxSH8J2cdz05lJffAXBa6uevH95hk7Ipt0wlz
 ChBKaft863Acs27NIDWs881x5xV3ZNk8sbtxGIEbNp4Q1EfQXVZYj4k0lRAsXmP9zJSJ69rbB
 4qpTHk3L6QONZKBsHPaG/JRwa5B02k70ObrjII1LkW8grhvrsZWw4GY+QGYSc8z7NiEDi/utP
 Jr8RAtPPyJztUQ05ySCGRsx1OQyyX+ddG9NXJxbNnaOLvvmftTcY8F/8ApGuF/phhxWmIFBft
 Oe8yKm90KjIF1gGgMs0PV+Ayix+CJSDpdCiMvYqHg8CNt3DhRGX+nDFy8NXTRG/1vEoclhvFO
 RYF+40q6fEozN6HIQBfD/EmjjifZ+KPAVpQoIpR2ZXyRTwkGjb2yksfoBEoGMkFSbTHmnwPYF
 YrZ2RZ4DsfrqrIVMjPXr0mcl12vNdXb5mQYXTY7ff+77qUgjOFYEQ0LN4/l/hydxJ7j7nL3NN
 sx7OUdnN9GhO8rsUJlUU6C182/I4alynwSML/ZAcnkUVdHYAcxuMVfb/+npuE1weUR9NSqO9h
 11OnnKQMr0M7N+YCAwJHVCPqxgz5n4ZTziqNVc1WpuWjlLM/rx9lLxurY4oFPpkva2wSGLq7R
 EaFS33svvFMHSU5DH4KqFSKfFfWQuxvKzx1+/suWrUaYeDHCvie4w1xD21R29iPKU2KqxG7WO
 DEU5Jrm9eJ3clA9XUrNCen17788=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On hppa the Instruction Address Offset Queue (IAOQ) registers specifies
the next to-be-executed instructions addresses. Each generated TB writes t=
hose
registers at least once, so those registers are used heavily in generated
code.

Looking at the generated assembly, for a x86-64 host this code
to write the address $0x7ffe826f into iaoq_f is generated:
0x7f73e8000184:  c7 85 d4 01 00 00 6f 82  movl     $0x7ffe826f, 0x1d4(%rbp=
)
0x7f73e800018c:  fe 7f
0x7f73e800018e:  c7 85 d8 01 00 00 73 82  movl     $0x7ffe8273, 0x1d8(%rbp=
)
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
=2D--
 target/hppa/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 9fe79b1242..75c5c0ccf7 100644
=2D-- a/target/hppa/cpu.h
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
     target_ureg psw_cb;      /* in least significant bit of next nibble *=
/
     target_ureg psw_cb_msb;  /* boolean */

-    target_ureg iaoq_f;      /* front */
-    target_ureg iaoq_b;      /* back, aka next instruction */
     uint64_t iasq_f;
     uint64_t iasq_b;

=2D-
2.41.0


