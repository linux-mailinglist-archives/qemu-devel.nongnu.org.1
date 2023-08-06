Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB37714E5
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchk-0000Hy-7K; Sun, 06 Aug 2023 08:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchW-0000CL-T0
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mZ-DL
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=+FFaZHj41P2ZukVhj09NDP9crnAlhHF9gw0dXa/YzCQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=WkpfATQMyDVsfLpmFh00N7U0Hytx8vb3C1dIqyA4c+wsiOmY2F+rVhqRubgdOCgy+3QOMOb
 0b49Fr+e/PvKWLv0SkpdFHPwf/sTWf++7bEJCvhGaxfmB/rdqZ8Jh5nvietT9qEsO0/ACvpSk
 8U7tlQePMW6TxTvanG58XBhTEktZqSYCQeuKYG+4/13jX9vl0PNY0fi13/0UPKDkBqUyNkCRL
 IRWVUijRl3/PSjO2wfajCR17TNBxt9Yi5K13E1jnpu9v1262wp1FWJa1Duk64+dqTGCaRgk7M
 Y9D+M8RKeBmGk8tYZP2jvzjhAkl9ukoV5nq1bT8jeyi3ulDUxXJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1qFEXk1EsD-00MI1x; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/23] target/hppa: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:12 +0200
Message-ID: <20230806121732.91853-4-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wh4MSDm0sLQXfA+QLQ3K+V17V7afNdBZV6FcXCdTeUVYGcpHSzE
 W1uDPk1uyyctiESnFvnLvKeFeIBWwhWZ0+95CTHAiNXXGcu1Q38bQaOB0uCyJnCvCiV5RvT
 N8YbjkgZeuoX3UXc7lmk3GhtnqQkO8/JhW33WKroIfY8ghMPnIyNlLaQASIfpdrVq5Uu88H
 KgXHnK/koHBvnOla60Q4A==
UI-OutboundReport: notjunk:1;M01:P0:fxJLcJ3jyxs=;RnepeVM6p3N0EQKhsloWNnXGeOb
 WdhuZiil3RmRn5LOXQAEfLN6IYMaS95ryebDyrwcuVnFy/bJFxAWQ5oUsloxlP7Hg5VuJRL3O
 tgadhv7IH1T4qHMuKI3tgIBlTS9Ra+AIqJ+D9Hsv7kJx3aQG1u/L0FK1FnbqBr1lsQE3YLajb
 Hh1V1m/ID590U4y86NF7NeZPQE86aoY+rJ1XkJYVNBhUzYxiUjp83YX/2lqEkB0j9dnPL0ZZd
 707TWuOHpCw+m+3CfWBEMreQOXpGo58eWmZz3zoVBQ7qYKXNLSxjf2XVUqn9eFYwKEEbo9Sin
 8KBq12Gyrf4+JO082M6C7YCM6qXIC304gE8S2OoSrowx8GqS5C9dbM0fVHK2oGzVa20qSUozQ
 YCQ23GXyDjySZKMv6kvM7dWMfpvlyfQYdYplZmSOuXy01AJX/WkDtcyuzBRfMxmSCFsU0bXW1
 4ix8tYnDaVxOW83eQd9/4cASHWGjjPW5TLEYJjTcTrP5HNJB5wibVre1Fntw9hLl664BkJI2V
 LxYCOExFQf27/odPedAKVHDhww1cTNxehRJQ839EXTZn9ZTkVvyl+0jT2n9sQkEE5G6RDCBYU
 W2uzwRJgBb7jNqKp4ahGbBYvh+L26SyhEa7tZOydCEQvHPQRev3rweDlxHxrJgrO45voimi+d
 AHLHZSDxcV3SriaFCIq+NYYuhQpqlL5Gle2TOD7r+EFjzlb+lh5K3rVO45fmES4FajNpf5tFz
 dwD8M7CuYoVaTg5o/kpMQevg3lo7qv9u6TbLiyzAFRIakpr9cA646alaUbyT7hhCDwYFX+hZV
 fFNE76SqUw71VhsntFNv5nI2cAigF5B37LZs7AEr0ouRKGY17uari9gFsYUOXdL0lewgLYsle
 AopRKYcZLgZ/7KhxwwwlTx2/6oXR/oCMm9g3huy+yKEzRhEOgvebmkLN6mzhfF/HaaxiwNRAh
 anh7S96QU4Kt/XY2fcXa1Qoy+0Q=
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


