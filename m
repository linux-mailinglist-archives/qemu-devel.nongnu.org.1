Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEE7714B3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQl-0001lb-Ny; Sun, 06 Aug 2023 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQc-0001Zs-8S
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005YB-7q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323202; x=1691928002; i=deller@gmx.de;
 bh=fHh6ths4U489TH2R2+SXZJdWcst+4HBAcj/Wpwd6H8w=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=jlqqE66eJB0v1kftr6g60jtCMh44Y+oDF9R3M4MXLfF7W8ceSUlXYLMo8sEgQ+imWUML/Lc
 f61gS/XegdHAhMrKIB+epPQqs7SPUCgl+Ur9y0W1vzn6d7ioPr82ShxTeyGIswclbO4uOK0aE
 dwiAgt9i0NekZPzMJsKA6V2R01jRpLn9NlT9LRkjhr4i816dE6OreS0H7gV3aJQlxqHFCVqeo
 WjYl+0as7c6vrOg0Fz/BmxmdQd3+hGiX3AQtyrwih//QYL8nmPuX0e4bF2EbRkHcYBn8WLpzx
 1+28IEZO0KJaUFS0tLa+Dr/ekYMNmGtc8rysOiA5ntSenUy8j4YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1qFEHL2MjZ-00MLne; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 02/23] target/i386: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:40 +0200
Message-ID: <20230806120001.89130-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lVG28F6K7P7ov0tJxA/6yMHYRbg7V2qPD1Nzoaepi0JFecq8tFE
 dLZELm7wNJ8qvoZx31ceCbUCDvPQUX9mqmm5vAqlLl251PozzmawQRqpuIGcca+jzPIC6gR
 +jwXq+1WLs04wb61fvuYoR50yaEg6ughAklLPTI9js0q/WqEMdqRV/6nwBb2pHDjOAYtgO1
 Yyawfyu8F3TqsNx8pdFQA==
UI-OutboundReport: notjunk:1;M01:P0:OKgUmW+8Qfk=;zjBh0G0JgbqsWVOxjJ44E1hYdh/
 OAuw//wNcM88FFInhdtY4wMaD4ZPY8DTFiD5XMoU/8xJUr2ZBah/8uVG1sgEhlMNPuF2kZZDB
 hKwbDZ8KXmvxSTvLQlQ3IaRhjYhaLJ0AteK/QEKcc5AcZ/helnwT2IbQjwWeoP7qA+EY58LJR
 Ibfg3j2BKl78Jrrm9WrxZm6YjpLwFufvTo05+Upyas+02WJEq6zxPnSHlEbNkS/q+AKU95lfL
 hcgA00Mz04668XUXJuynJwuPu5mytE87ylaz+PRxkE+1mhUwbdhb2ynft4Ss8CbwtBAuEOBTX
 bJFgNT+EX4TMk7rJn2z2fsuW80i/GoHXi+z5JXJPbI7kxpZPQGUtnkczFfzcsJp/F+ja6ht9i
 1Phqfwm6KfP/dUJXwftzoqCfPK4VGAukqJAQaLpe0PeiQf9FGy1pZM3RwXBnN1O/CJV2YIti0
 jBwD/1Q2KhRKCAOhqcKk6BjS1ZKhmUfwQzgld79ZCGryfXzM7DCHSLyVjRzieVLv+wvX+JZJ6
 8er3rVj9CrD5ufE6Zo6KKvPi4Zci08Iyc9yiu4Trv1QYMKopt+Z8bdTtsNv6Tbd/NirLgp/U+
 lH9CqyY0VG24DpCAyBAIkNjJw4sl3ohx+8U7cg93LtXCbEHQGwlc0oUAkkUTiFPEhOdykdvLq
 dkDZpSTVADtQa5U8dWSYpt8U1c/aao1gvalWFZ1tx0O4vj+LhGbHKbgyh0WVPjcZAX0OPUHmG
 uabhk4MB9L8LWKSuVOO68c/MuDb39Z0fWrhe0i3igdcODW0eJ7lmwGBLwn5qKjNaZVof0cAGq
 8h6V2ANq110twj28oaGcy31QQD0y0vh36n6CF7MIzmzcz5dRvj+tBzy5mgHUb0HK6j3Fp2+iy
 qWBD/DzbDMEMTM092iKJrk8Vk1jD2egljDs8lGg7KK5m2FXqPCUJuMsJvDFU9qJjAIwjVOWlU
 KKZF2ARn+fl9Ag4vz3y0rc2Dyl4=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 target/i386/cpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..8fb1012346 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,11 +2251,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list

 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP_IDX   MMU_INDEX(0)
+#define MMU_USER_IDX    MMU_INDEX(1)
+#define MMU_KNOSMAP_IDX MMU_INDEX(2)
+#define MMU_NESTED_IDX  MMU_INDEX(3)
+#define MMU_PHYS_IDX    MMU_INDEX(4)

 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {
=2D-
2.41.0


