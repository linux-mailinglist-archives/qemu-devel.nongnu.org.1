Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE547714EA
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScht-0000N2-NO; Sun, 06 Aug 2023 08:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchb-0000H3-FG
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:43 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0001oC-ET
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=fLd9qhuZ16Xfpz7XDgXc4X9dd5C7qDtNCbmyF5+3VJ0=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=k7xXN+5t692GB70s/soLNU3vwBQv620GCgY5rOfBWmFbfJgI+ws1Dy7kV7D+B58b1/hC+Zi
 RkBu8gtKU3DjQ9G8vLYQa1bs2pRHSY6eaIWGU7wqyx4fs2Yzq1w1UYm8ZLR+Ell7I/XgAI/GD
 szf5W3ITeho6mCOWqtS1htRGks7OB8Ufm1WOCRmDNOhbn8D7XxRkuSeMgZQWteRE6XN07DWTv
 zPWrVNjMONv8uJVcJyHRzqh+CBa4+Dw5HVko0lORGMIdaXYtaxI0kIaD6uAkpxFzq4ISwHRQV
 fUvERYaAk8A1SHL3JNd2Lh/n7dflYw/xV40zGfK4nAJqh3pxiThQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1q0k4g2Ctp-00je59; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 23/23] cpu-defs.h: Reduce generated code size by inverting
 MMU_INDEX()
Date: Sun,  6 Aug 2023 14:17:32 +0200
Message-ID: <20230806121732.91853-24-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wylww5uZ2DkhLu7o42ZpBE48eepwyxOApgwgs54YI+HZZ50LAjZ
 DbiTGl0FrhPgzJGst16gZOp78OqdAhGQmjT2d9MLyFRW23gptXvj2HFcwLRXKCqO6reYI5U
 fdwH8luNTgZkMP94LAHdxWutnHrmObXu1gwSSOEWHrekj8XZYMyq2TqxDhwBuT1oCyuLtS3
 57RQOtskPNdCQdEdvfINg==
UI-OutboundReport: notjunk:1;M01:P0:AQQwiDFzcYU=;6NBmFMxVCPgonZQQQK6vd1taRNd
 RvjDOVHfvbkO5HLwsxrk1hFtffJRgkCNa6nUORJ6Of5db3LptP2TkplJx43Eqo7M9rEC6h1qd
 6ijElRS5N+FcTU19eVcEn9dDIIRcVgYhKl3J1YL0rU6NYMmb4xGphRf/i01QxFlDo9zibDnul
 Rjf68XrxF9ZHym5QJaZx7M9jtfcHl7jH0bbLINsI+iIUh98+KAJUJhuHXciclfB3teV+NPKmu
 D91yMYev3soCg+RmD858SkInY+1mDql8aLN6N94hiSn85CTGU6HKpazpFsqiWB3x1ikAC7CSm
 p8JgrEeTdN2qRrzVtBm3aau4bJg3HuUrOOL7UQbxo1IDImVF7KPuqImmmFrNQZI59E/HDddWy
 cEae5ymu+0oDLzvqs5yKz5AXlWuiWV5uhnvQi7WpJ3o1QGt0YfJhJmOxpYEWjs+uvs9xtlpoa
 jbSas7kYLmHnWpVhEB1/DZCMWixBE1ZIvhYNHYzAMMlUBglDt4qy9Cvsc3HnE36uUuIFAeyfi
 8ZChdoP9HOo3Y3IDEvU0SJqbuEhNIy7gymJW4lENjDkIgIJK49M5buuwjsrSNjcOMWHCHYW1d
 sVNScZziq2rN45xXXs5XmgiU3pGwA62ZRPBbL9iK4+gjEDNq7iJQlm1pPKx/UdCD2BSN90koC
 TqOGpZm86PsnpUNVUUWtr1k/i4UYDC1MQu6tABE1MFX+OXxWDtA+MLxnAvLZpI0ImDntFKb8X
 UJzRRMbfcxfgqcMWo7wVJuGAkJXFul3pu7UEYL6dqe/MwcpP2sA1h0wDKtEWIiztnprp7GIPY
 YIAq8BUvkayzAPnbdty0pexNNYYw0JEvvm5AfWjZ6S6zViX2bfhUKtqDVSDnbyM3lR1kDkWpA
 mU8oJDe+zK09EQpR9yRNRWwLzlrBlOl9+hxL3eQlfBcLNzINrEZjwbvdl7X2hArWgRvkntMRv
 uGnO/4XWN/YGQGi+MemhvRtsvw4=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

The MMU is placed within CPUNegativeOffsetState, which means the
smallest negative offsets are at the end of the struct (see comment for
struct CPUTLB).

But in target/cpu.h usually MMU indexes in the range 0-8 are used, which
means that the negative offsets are bigger than if MMU indexes 9-15
would have been used.

This patch inverts the given MMU index, so that the MMU indices now
count down from (MMU_USER_IDX-1) to 0 and thus the tcg will see smaller
negative offsets.

When looking at the generated code, for every memory-access in the guest
the x86-64 tcg generated up to now:

IN:
0x000ebdf5:  8b 04 24               movl     (%esp), %eax

OUT:
...
0x003619:  48 23 bd 10 ff ff ff     andq     -0xf0(%rbp), %rdi
0x003620:  48 03 bd 18 ff ff ff     addq     -0xe8(%rbp), %rdi
...

With the smaller negative offset it will now instead generate:

OUT:
...
0x003499:  48 23 7d c0              andq     -0x40(%rbp), %rdi
0x00349d:  48 03 7d c8              addq     -0x38(%rbp), %rdi

So, every memory acces in the guest now saves 6 bytes (=3D2 * 3)
of instruction code in the fast path.

Overall, this patch reduces the generated instruction size by ~3%
and may improve overall performance.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/exec/cpu-defs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 07bcdd38b2..7ba0481bc4 100644
=2D-- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -62,8 +62,13 @@

 /*
  * MMU_INDEX() helper to specify MMU index.
+ *
+ * Inverse the number here to count downwards from NB_MMU_MODES-1 to 0.  =
Since
+ * the MMU is placed within CPUNegativeOffsetState, this makes the negati=
ve
+ * offsets smaller for which the tcg backend will generate shorter instru=
ction
+ * sequencies to access the MMU.
  */
-#define MMU_INDEX(n)    (n)
+#define MMU_INDEX(n)    (NB_MMU_MODES - 1 - (n))

 #if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "exec/tlb-common.h"
=2D-
2.41.0


