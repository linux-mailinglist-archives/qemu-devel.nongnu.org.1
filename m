Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7687714AC
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQe-0001aZ-8q; Sun, 06 Aug 2023 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQc-0001Zt-9Q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005ZP-9k
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323202; x=1691928002; i=deller@gmx.de;
 bh=+FFaZHj41P2ZukVhj09NDP9crnAlhHF9gw0dXa/YzCQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=iUiAQwvYnCk7i99/4Kzzx7v+4rY5SS7xTp+xMAuTGodmC4mb36i8Wrg0AbE8ugfGjhRQuLS
 vwEEgRIN7ZKEZDkeDN6MyetmmLmtU3g9DBNABwGZj1XnkjqsMVw5XT5Ar5eVvXQdAiE0+Jg42
 8rvA1qeoGXx0FFIU5pRh/E7iNj5pWR/4MD7k9KkEMCtYAbXBaLlFWv3qoyZw1kGiW+zLbPq/s
 zUo8iZjl3XdItHDYJbIgI/5fLBdY27cHKQQbvg/ZCNT7kbnVkfQfU3kTKXUhOOteFfRueoIuk
 XRGzmjukIspadmA34v8N2r9r4jO2WQRXmEgF8SFCNpYkfFF8uD/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1qfJke2l2A-00DnMP; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 03/23] target/hppa: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:41 +0200
Message-ID: <20230806120001.89130-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xCkeYXB4mGhhyZnU0lBpubommubAjOTyKMtGT4O/NponZqNlEHu
 adYMYsv/5m2orqw4Yu0zG0H3j3++4Xw/HFNgkJzCLfJTmA40Rexz1XXfKyPEIf9mn87llgv
 zDOR4OmyXOoU6DGyW/6L6k+aqUF1yKa65gLrrfJsamafC5tyFHebYGnCy5sLyN/joNMzZGC
 o6QRAi1J20DwjVKsNjaHQ==
UI-OutboundReport: notjunk:1;M01:P0:22D84i8iI+s=;YHIHKgqbpvzgR0Cif73F1C1ziyK
 0icBvi63VCIfs+ONi0pMjPp9RG1AsQjwfXrvPMO3l7Fo9he88GeMVYjc3uNaHBYCQFKlEMxc8
 ElYyAW2geQV06mYl5UOqTYwiF2GuTPdqJSgybR1BAs4BmJfM0evum8SQBTYltgwXCxRCx+Npt
 3TxMJ1RWbQnNe19BtMGJiNnwfHSgJWutASHd2YWkTnTmCbJje4IX1lBwi58EFQuysGRxuiq0e
 GAEHBegQgsVeATNuwYJHIKHmnSinf6kJdXAc4TXqU4Di3cVS2BEIpcTmDaWfwtL52pzLLMwXx
 GfR1OVnkP8wuOFLgLNyGhCixHtTI+prW+ywZVqT+lOw+df4XkIgjlDJcVLHARRhzdxHZpQWTY
 XnE5kbjTyu3Dc1NI7DjUME5ZFTP8lPmWmy2oHqKS1UURkkQa9LyFNQz+I/GODGajEmI9DoHT/
 Vx0+dZqK0Ioj0LQ28AsiNLBe19hlCsnkXa0Io/Ufbus8VaLO7mQEse1llhMWKCl3Bel5Y+1rL
 i/ubgpb6Z6zuL5r6hbf7uKGKgFjlHwGICSfec1xZDlZKHSWf2fDL51BJuJXxND2WYsJ+w5w7B
 stpc7IZn3kavv8I2bvsZ5lZw83xmMYPRbCaBXYXl6prS8gNLVSetEkqtyblyOVO0aOMFxB/Vs
 XifH76oTbEkRZ9gwyB7GKkWjaFDz0+Saw+an7uBs4TUrjjhrVkJRKHg8jpf0cgjJqUGyDY1e4
 VmR64g8Im6q89mE6T61Xv2TG3R62yJQ236u3B3+ck34+MOevUxZCwHgApxCK+5S157CETIFmB
 +vyzVWg8oHe/qlv/7+uHt04eCPViZxjavCO315/DIoBAcqVhF4fWrpKJuxy5prJQPQPYug/5q
 x/hmZMvx0H0Wv7PAC4de9x2Rz5pZCMpkx3qeBIrwGwfdsu37bU0eT9ExnJXHrxbZSl2XAxg4f
 ukabTnh4uI2fnFoJvrOxhrCHAbU=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/hppa/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 75c5c0ccf7..f32d328e95 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,9 +30,9 @@
    basis.  It's probably easier to fall back to a strong memory model.  *=
/
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL

-#define MMU_KERNEL_IDX   0
-#define MMU_USER_IDX     3
-#define MMU_PHYS_IDX     4
+#define MMU_KERNEL_IDX   MMU_INDEX(0)
+#define MMU_USER_IDX     MMU_INDEX(3)
+#define MMU_PHYS_IDX     MMU_INDEX(4)
 #define TARGET_INSN_START_EXTRA_WORDS 1

 /* Hardware exceptions, interrupts, faults, and traps.  */
=2D-
2.41.0


