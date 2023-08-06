Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 433117714EE
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScho-0000JW-12; Sun, 06 Aug 2023 08:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScha-0000GN-6U
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nr-WC
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=Oh0k3yvvWbtkEZ2WV4849UsfR6Tag1RdVubVNLc9CMY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Z46YSmdTBe5Vv1ziQrgoww/rKXZ1YoocZtzIeyYBtb+TnXoW40LtOncbf/1MpKGdl7DuLRs
 zgWRnvvyyX0OBJ+ZgwH0xP7wpYmr6X9DodzFoqmHru8mDTi/9cj4mwbvFyU206QCMFacDjNmu
 f+CiJH9tUWA2BRcU588LPp29FDwJrC18GaGphDC1ena7D8WyyMlqWEw31N2iXACefjB2B9+Dm
 Xx60zYGklCKBeDFg2+fhd4EE9MN9fWNE+oVNH626mq7CUSQ2OCukcaG3NwnmTcxQScqBPaDG6
 q7B7rsfwQgt/TMlFeY/ZPgZPrUlXIu1ArH7zDTpoI0Wf0rCbZNzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1pjlQC0d19-010cQz; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/23] target/ppc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:28 +0200
Message-ID: <20230806121732.91853-20-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBkRo7b4hEndZRVxZjba0OR6sJpbV8lUPKkoowcnTz1oPcz9k+L
 GxksinvoYASIw1I9Q/ot5/BKx3zfbKHWlxc/BaYHv6PCDqjllETPxXUrFB/fg7Rdl00ztao
 lJFCQhPQtwOW/6BGUHlGrb9RJTEbwwdotbYx3uqEVaUE/RWZn67shFbVU/JtJMOqASw/kYN
 JP9lAeuQoS/3nTAGmzDgw==
UI-OutboundReport: notjunk:1;M01:P0:QgIHoUFHE1Y=;BpWn7kuXeaZCjCyDU0Reb1f6zj9
 ojX7agi7A/OkeM3ddGCY+sGEVgyKGViyERl6Eo9mkTejJ0+kNd6rR+R3nFMcTl27qvsRK67Eg
 2hh/mLf7lyReFXYJExMuf56uEGTSkuDu/P+wznPvIQigeRb2eiPTdkJPdsYZ98lKYNm82oXJz
 pcgmvHVz9up9vI+TI3zf14urwLiEfaZPp3YTJ3bbCK6sQ5wYtumnr+jpbKRSkl6MWxx8xlHrB
 qRIGHqgAbJ7f63qWOzgAh+2fJ+s0MMxfw2lsszuhyiqYHd11Fs5MyK+n+wQJt5kOxzW3SRpSx
 gO/fxgn5TnG5ePubd598zcjFe5BtfXD9jcW6ELqb9RC/IJHNisrBu55lSgaA14ClFGOVKc5gR
 /bPo75+ElkqM6OelD2GB88rUJGkuEUDQotcMFoOaFnGNN7NojZokhi2Y8QiPCoTQTS9JQPOxr
 VB3/qqgSrarKyyob0UBKplZWTk9fpS5/xrMU+RU5CLeKLkWexTmMK4v3SAoYiUBxQ3dER21oP
 kw+BahwOeXGvDFKC+9gluGjbQz3ZYRExWHqUpjGeaIx05fCG40pmBSRQDe4U5oCGhnxoPr4dZ
 a/CDK17uH2FWVqadsjvhVmmJ1l22Q6mG5YE7ecaPGEq0b6Kjx3E8LKUtndtNZ2L6WGmc3oq1R
 99arE7/6GY6QPkyBYGM9TM85sJETkurMYzZ2blSbXFizqEwacRIf+LTqNdQ/JRXhCHtcr3b/f
 FIGhClaTgL9TFVNnhfAfQ8adHcdMeaIPkMEHFf2u6eGsjgptzZ9XLxATo38uQoyDfcthLuOTK
 CZjEgLxT8ctKH8dGSWyL1QWlnw687ubIVz9Mq51gezjQrM0b2d6KXEBQDXNUQUe+LJk2uyQSg
 tj74OB0WJYjZhiDAQYtxzCiZnWHOf+Mh/Y5bSgPG8VsF5wH8eaOvSCbYRPjxZkFwRFIeecC1Q
 lkP+WeMXANCyKQKP1h3+PlHjwDs=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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
 target/ppc/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..dfd9ba2518 100644
=2D-- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1474,13 +1474,14 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, ui=
nt32_t val);
 #define cpu_list ppc_cpu_list

 /* MMU modes definitions */
-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)
 static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
 #else
-    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) =
& 7;
+    int idx =3D (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_I=
DX)) & 7;
+    return MMU_INDEX(idx);
 #endif
 }

=2D-
2.41.0


