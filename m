Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C57714B0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQo-0001pR-NS; Sun, 06 Aug 2023 08:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQf-0001eF-LS
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005dM-CU
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=ssg8jQPKMpMEyj4XWfdcML4VNlGF+SIF4/0Fv2zswF4=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=B6MQyZ0tGx09DgUY/tgX5zN6FRKgqRr++4B5LvzMTpXdjxfrLDtBXwbSyLYjDA5aHGptzAv
 rHQt4A1D7kWp9181YBNO8uWorHFT+DSWx1R3lhwbJCWhvNT3theDnTKxmkZKF/+S/KgaCg8Rc
 2ICsXZE2ZbxErwZTySnXCdoE3LQPIwZWiAHB4nDWg2YwhBExGDGf7k3VRKokwyTFUKd6Vphcs
 XH+WwwedY9idu2+udIvudVPZAu1XzJcBVK97mpSYusLsO2FARdjaqX3HEoA8k0ebXzTDyBU3i
 jT3orjiiG3MLkOH0mFQzYJp7UZZ7squr97qS8uOTTOPkFfzEMPnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1pu7Ys3vJt-00hJUk; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 15/23] target/cris: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:53 +0200
Message-ID: <20230806120001.89130-16-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8q1YF7nWrwaGms2ttrklD1E/uamDN8KeF+w5LCeKpj2Qo0Zs4iG
 Xzp+nV9zjzuWyaeiwKfDdEYYB6zsez0NwgNRBGLIuHJvJLr76hcXKv/dbxrI40fRP57R/+8
 L59ymf0ZXJ9IiVu/Uceb125t5L3zP02x0fQYzO45RyK5+ZfogNDTvf4SgiYJEfokCNZWVi1
 U/evUlUg1f8T4Kay9MNmQ==
UI-OutboundReport: notjunk:1;M01:P0:6uLFHju5jSA=;J6216/BIUYTbrUy11UFx2Qaw5Fv
 64VSXCPXRDiFaOQoJcT/rlOrctGZ6idPfInQYVyFg1Hg1hEwyZRmWvWbftmQaAwAI0Cfbq8Mo
 41OT8ZUEDhf9t2cNSv5dDnoiNyC2uO3htAovAeeu6wPqzzCoSsF/JDhoNirdwEn91sRYh21ot
 8eYRWBqmygPmN0MiejKFQvw6XCmmYwV/G1yq4nHcb4MplUM8m4synmgWO831YwA17vk6a6drx
 3Km7OPfS5qNhBHIHn50dTrPF4rJ1ZmfR6Pl/xcefIMIKWL2j0uAarKdgSNYhTrNp1O+bZpDQg
 LZbkf7egdD+/YrRO1Kqbpka5wwsJM22l8w2aE72g2BP1ZCERA4He666jxd0uFqzjQxXwsgr2+
 sSl/OMa6LDzThLMieUCFJ9vNwVP506genymmDCdhJr12WkIosFwhXeAEKDMdnon/7D//gojT3
 ANLKBidbWOz+r9NskQ2HrZCbzYhdgXRmOk5DKj7kATly9CcaHiqA/epef9++52JX95NC+82AM
 jZSsHdbr+sZELU+v1PK7Oubw4rtwHubTpEzZCXKsa89TygX3wS5Ea3RYUjBtoaLa4pk9YeqiE
 bBZiEqufSPuT2UTrOEQv/X7Gld7y4qYjXnuH+EDj5bsKUy0aFpaxg2BNAjD3io+SE08iTBV02
 GFy3PqNQwilOJIZ0TzQdgOOlEtRNewh+zwXF7G1BGZYwcPj0IBAJmt3sLwMxWGilkGGdQQ67M
 xk0M/aJF4evfS/ZKc/l30gTRaKu/pvcPQuOTf6OEmZDSzSgaU5090rzmUZM4fdxoTAbP8DR7M
 vRYjg63hPz7dFUEo1ku50F9G5P9s7sNs+y2sUgJf5gdjyMRyWomta+RYQGPdATaA2NkPwOTMm
 rUsGQru25xpXiSjVxHziSpNfhd+Cq0d7opGjU9FSFGbolKPV8evwSzLmu0TMRzBOsWPpj/WbB
 6aCduA4+kixYQ3FC1IX2BXFqaBE=
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
 target/cris/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8e37c6e50d..4064a16564 100644
=2D-- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -248,10 +248,10 @@ enum {
 #define CPU_RESOLVING_TYPE TYPE_CRIS_CPU

 /* MMU modes definitions */
-#define MMU_USER_IDX 1
+#define MMU_USER_IDX MMU_INDEX(1)
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-	return !!(env->pregs[PR_CCS] & U_FLAG);
+	return MMU_INDEX(!!(env->pregs[PR_CCS] & U_FLAG));
 }

 /* Support function regs.  */
=2D-
2.41.0


