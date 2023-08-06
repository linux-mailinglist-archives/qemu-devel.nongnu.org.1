Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0537714EB
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchi-0000Gg-E4; Sun, 06 Aug 2023 08:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchY-0000E0-20
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mx-NM
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=KOwVOGLkUNJS93FOFZ3KD/tcWS4SN2K96HANSWFCUjM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Sy6fr1CGPH1DY6vBHzzSZfaeBxXVA0d6d3tcGWq7NsT/7Mpgnns2vTAIT8FY3iAV230zkMg
 j4JB6NziNbxti/B0T7DXK6rmOwE1SJJWv/8zXLAq3Ax3IxjirEbEoCzC9JCAJkd5nhzE1IoNf
 WQXlEVSmWPXJupCOcpDZpwpsLbz3y/CjPgXKBb7UMupOq1ljf6oR2dqIrUUjYHhOQ0NKLOI6k
 8H1TD5ZKikTqzvjBcL5Tr1QhMaEIskoyOzIApAZRRZ3ei98cOAQjWTid06i0rUJ/N4pIQOWjq
 qHH0EHlxugimEuzBY/LmdJFuOQBmmbzRZ6m4wRCgkLm2r6YW2PMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1pXtRb3ofm-00undO; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/23] target/openrisc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:18 +0200
Message-ID: <20230806121732.91853-10-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bMo8RRIM82HgHsy16zfnuiLcZqG52uLYaVbxBOr3CbjVzubpo4s
 VGh8+CJ5vreTeLRIIgtDBuvBU+Cy8t8wVYeUtHwb3OWsj8KMCf3Fpf/OqKi9vPklwP41+Q4
 76m5Qv5UDQAbEjZa1qn2VBoojHLnh3LC3MpVBmjVM8IfiOLmzaN+lRvrF8gLs4pTfCQdNWR
 KqU9Q0bBfIBj95HQ3LncA==
UI-OutboundReport: notjunk:1;M01:P0:G5RRCh346dg=;ht9KnBHKd+NrZYSxsK3qepmxjrj
 m1g/ZT/ib25XGpVYpm8v61cl//DN9ljhCieNkXYSYuVxkShkp5Ly+xZNjiK+1cgd+tFn19wEM
 fu+JzfLfngr+UWzHFYbrU7EHRt1+qOu/j18BZrBG+zREWTW64vixou2VPwCfB2TJuaQWx8kfh
 C9SO34IkY+GizQj/16ASTEZ0V37yi1mbEPYKYdyGyO9quwbNWrAI7hbDexJFawihVn9ynf6mP
 XhWc8+g/kMCLGHCJFX+upS+fX2xS2THbe8wUTT9/CCCiNLST7Adkc/pu5GJyASsGXH5m12lLo
 uEr98aEPG3AgZ4HIeYIEiCMpe0HvreTwZQtMzlVdugd/Zben7S/6tOA2giIM2c7qkyN0CpqB6
 NTGo7q8TK9SQpLOnsSH9JbTtFzvLVkARqTyMuCq7q6PfXBuvOzMe/pTIX53G/GfpBJX2Lmvus
 JEezNlJcXNijWtp9DG+sTyC+hLI0mIc7tSRtn3FvWNNK1/Yb19NlQ5jDeualEjT120I+i460m
 F0daRNR4UGs3igl9D59XrxS0ZVWj1rmkjeGgNapJm+JgeJecNWmDhVFAy18Slr042AMi5DOD/
 49gsWRX1aKYQQ27pTA68eEld95f/aOPgEZNNHf96EAjY4x/O4MOqFCOX33VmfL5UUeLUmnHGf
 yAFsFf0Y88pxK7MVlo4aeg3z32Jkp6awCLu4dixYWAe1wcKp0NrMV2nSuMKGpL6qkxoHCOq6+
 QbZmebd5iNTfj7XyoB2BrBa1R9s6E11fC0Cf+qON5JY/mmmCXwFPr2uy2s2r2Z/Q1vuAPpzq1
 Rzz5m/oe+Tk+TeprnL82YQOrIPEP1Aux7idCA1DEQa4Oh+Zw2W/ci+qLLkOJVD+IWmnFimZHS
 Ghoh7FytUDzQ+IAMR9izt9uoy+NPhAEp+vp+wgRaC9bQQpBlFU7My0Qs9KQF0QnN6U37nUavW
 pu9bMxxDZNQNL0PTce22CXEKPec=
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
 target/openrisc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index ce4d605eb7..c216f2fb77 100644
=2D-- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -50,9 +50,9 @@ struct OpenRISCCPUClass {
 #define TARGET_INSN_START_EXTRA_WORDS 1

 enum {
-    MMU_NOMMU_IDX =3D 0,
-    MMU_SUPERVISOR_IDX =3D 1,
-    MMU_USER_IDX =3D 2,
+    MMU_NOMMU_IDX =3D MMU_INDEX(0),
+    MMU_SUPERVISOR_IDX =3D MMU_INDEX(1),
+    MMU_USER_IDX =3D MMU_INDEX(2),
 };

 #define SET_FP_CAUSE(reg, v)    do {\
=2D-
2.41.0


