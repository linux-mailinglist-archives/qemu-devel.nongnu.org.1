Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A47714A9
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQm-0001le-BM; Sun, 06 Aug 2023 08:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQe-0001c8-At
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005d4-89
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=wfGbH/9aMrmCkcIguPrZrqTIG36tr7GpA+9BI5L8PqQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=ZH9noynNXpM1upLuztI4NlN1t+GGSfRzsgQWEqQWGZHwys4cM24AUvBSCBQFid2TvdzHd9z
 OGukyTrnwcD+e5a27WouKErR0lrJrQX2000Tv5m+Tl1aDT6yJU/zNrSqvOPH/HlS2nzMRYuJE
 DRxmARqQWzuZVcTYdsM8qa+FkskrzcmeqLj8Kr4hbcse9Nd8MoP6lWrtZaB0BP7eCJgPt/UHV
 KO2Z0HApupTbwfMC6nNIbe6HIV3ijqIXxSTyLD2FmaxSYZI/L/3eU5nNbJUodXHrI4OIvTmJg
 8K1k4WUzVttEJFLYTc6PzEbjlNWSVTjw24QaK8Wxir+4ClgoP61g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1q8bVK1tpR-00K9wY; Sun, 06
 Aug 2023 14:00:03 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 10/23] target/riscv: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:48 +0200
Message-ID: <20230806120001.89130-11-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhwayiyMNk6h1XI8z5lRkJ/o9SfMn+0dMcvMRSVVpTcNDEIsQDj
 RIYYtBng/Zz4jbqOU9ijcLyJZomzdeXEIJP5AeMAkNBKn5oNdLWCJk5HFS0kZXF017Cqyd3
 jSEusGZtzfnj7n1+/11TuTQBKYzPvumXUSNWxPMfUexL+aYdcLl4f6+AwklXkJp9q1Xkk6U
 zKp7RKXj5CtFeWEtZDuWg==
UI-OutboundReport: notjunk:1;M01:P0:4YSeNkiZtz8=;0tcgoTbSIqx2+045DzcijRTJv7w
 O+2WHBX+DiATMG8jU+pSfxKiTN7E/S9sha6Ko2RQgsc8PSK4eLBX9g0d11DIKoeHF5KcqOxR1
 +chMmVYebqftiyILSHEiLBfZ2YBYZ87TsS9O0s3zanGMub/MjA4q4dlu42cTxZiKvDOmqlBB3
 VHLsD+RtlGoRZwqN/CEQLsH72ilCT6HhCIUWWTHOmZY5+XHUq5fx/w4fckg0oNpQJ3GLF2EZg
 GM9Gb0FGU+CYJtksF5TgC8G3eOIyo2Y2PWg58SvKoysMyO1znQOIZmee1raMAJbPHN9jfBZd6
 n63H4jpx/7tWHp6a+0q2UPZNgqs38arNVXaxcutgi3M4TQOMzuSsmL74CvUVSS+SOuZsZCRgR
 /ryznmVDlKi6xZutU6JV8VEJWYw8zo0BBWQxe9If/BU4ryULSZAV6wHcrSv0uPwBgpMcZRPrk
 qkE/zF2Mh7dkjhPtsTDJ6exfKv456cgfbYzU0B54w4AgGZx09FvX1fiJpTzaeogyL5EhW6qmk
 J4RaxHHwTxOPwnU7ClQDrN8Cc0MtRLCKQMtid0zYVo9iWO0TrjgINCBnhR3RfyAL/Ww54blE+
 CT6wog6v5cTaxIJSWn5+fd4HxLxQ50ucFrFfGxDq3WUztR7C7GpKNMKUmuDn9J3OlZzH7XHFK
 5qWyOVGjf1MnbZTgiezc4dNhZhWcQbNTSSUGZCDDY221yL0jn+OcH7ac4XX7a9os1FsjHQw0M
 oo6bptQbjmqTyTzS4Jpuf5w0Ofo2lKDKh2RdwE6AIFvLKTcsvDzU0LxXOdy7g1Dfo1O8PCH4+
 Lu8V6YHYkk0EApDoKOiI7oATssXsIFKYwHk5wCLPf/JVJUKQu7dlgJUyEYmmJTtSGrIdsfBfE
 L3KDKip4asRuIlsr5iWD1CCA69EOgfT1VJRdi/aI9ITgTLpyuds9/CtkfUsxK+f68NB2fg/6P
 Nku5bPEyUaPdInwo8OUeRoJyx10=
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
 target/riscv/cpu.h        | 4 ++--
 target/riscv/cpu_helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..6aba1df64a 100644
=2D-- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -88,7 +88,7 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;

-#define MMU_USER_IDX 3
+#define MMU_USER_IDX MMU_INDEX(3)

 #define MAX_RISCV_PMPS (16)

@@ -446,7 +446,7 @@ void riscv_cpu_list(void);
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);

 #define cpu_list riscv_cpu_list
-#define cpu_mmu_index riscv_cpu_mmu_index
+#define cpu_mmu_index(e,i)      MMU_INDEX(riscv_cpu_mmu_index(e,i))

 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9f611d89bb..a8e6950217 100644
=2D-- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -107,7 +107,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *p=
c,
 #else
     flags =3D FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);

-    flags |=3D cpu_mmu_index(env, 0);
+    flags |=3D riscv_cpu_mmu_index(env, 0);
     fs =3D get_field(env->mstatus, MSTATUS_FS);
     vs =3D get_field(env->mstatus, MSTATUS_VS);

=2D-
2.41.0


