Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FD7714E1
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchk-0000IG-V4; Sun, 06 Aug 2023 08:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchY-0000EL-7n
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:40 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001n0-Pp
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=wfGbH/9aMrmCkcIguPrZrqTIG36tr7GpA+9BI5L8PqQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=VsvG5AJi72BJueKhQv5u8aukQSJhsA2uVYmbdli8n/n6GZeP9LdcOnadJORf6z9mz5SOaSl
 jm6ucemraw8R4yVpJc5hkg/O3AlcUH62RqhTnpUqAWejFsoHHVAEzF0MJhXvyWV+3S8IKSwz1
 tUMjL2ma0AVIKK5pKbiP7CWB6QVcCPh6eCmJUWxFAOXNFmpuqBW1y+Ug+fQ+5pG5RM2uMPVY9
 R8qZH/CzNQvD8cpyhUnpmpRSB0K7+4TWqw1gqW5C1RrgTyjNi8GvbXVugbGPHhKNsvkV1V2ey
 JwuvinRbsVcnU0cYPVohZvKDukyxj/d9UxeAQKDGJtYQFA+YPn6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1qOLMc02gy-00Uqki; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/23] target/riscv: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:19 +0200
Message-ID: <20230806121732.91853-11-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:skJafiqlyVxSMrtYHp7K3EqyGmKTxyy0sZ+c/Zs4mezkz51CfM2
 IeRlNTIO/HdX1hWgmyYPJL0qPpjf0omIVJtq99jwJKoGaPB6drWnqkRs1UWAVn8e9l6Mxf4
 LtzNrqGGv/pDjs2Mav9Yw8uQXmVME+LoBl1YMe1gpQNkM5GNRpMYWaBBXfNPXhb65Vat/sS
 DOJV3NedBTDMLdKND2fDw==
UI-OutboundReport: notjunk:1;M01:P0:8kXlkgmtv4M=;r1zZfiqNPVdksd7r/Z/e0UrZAqh
 j81YwwWD3+ZHSSLWdtpypjGo93nJDfb3dfL3PMP07AbjoM+eQp1Gn0S0zwQhEGZXUvLgsqMAU
 jrNxjQ3Qjjsz9Get0vYOI//tN6ZqsaEylsOezyYRQT0ndNlVHHwGjo9U1HeBU8FHaBLWMUoy5
 pDPJMCZVjiSXvmgLo5H3W15N++wWFmFVVdrYhM5Y8j3/InbjNY3qYUHa1ctYQXTKNb7j6f+Xf
 yJDHK1nrYjan9tnCq7yRYbpObt3W6S4D22gnJ6i6xLUB9aGSUFkuNLz7smtVlMYWNAjq1HW8a
 5BBGAb+FIhoqesRyY3ycXj4VQKqVugT6hbpU9bEWDvioF+n90qYFgUzJNI1b6HsJqXxO5Uqxh
 kxPtqJkMRn1dSx9O+4CZ6c5DML2/ATSXx1hiaZE5DvG9Hq4AI9kwi/nGDHK+0FX6FjYN7/mww
 5eTIDBCW7uiFr5qaxuaj6wrMN5GS9rDetlXSnNYb3wWksPa5o4uQ34EDwHzrHV43mA9QQJMrZ
 dxYSh92pLhWG+N9SFOyo5abQQwSVt3tzPklfikW0FOZUrwxUifZtgplh2mDOW6k0qlJhYacY2
 b13VKASO+N7RhdaxTaQKajFJ5KVNBZl/to36P0lAnLeeX1wpcW1aZQZW1ZPPNGqoU47bN01sc
 CEg0C4OcMmLqgzzs5Y4Ct6S43UhlVLZr99qxyfdQHFZf2HhTAjVoGrSIZix8vHbQwF1kKIxDe
 XAKYH+XjpIRyHs0XccYRs1zKLDxYDYMscrVn2GpMXIW+OWZyAUy7nav1JBJayjVNIdcmaUOi7
 JyKI2OHOR9ydA5KFo1eKid1dC/Ja1zvg6dA33ckJPzcoymICIU2zY6qxPZX1MKQhsMh9WstpD
 0oclkRoTc1qc4z9w/v3Jlpb5z7HlIDcTG7XTmzqFEHbchSow/bdtwza+0/CZJ00cEZ4MGUYBp
 tLvuR4/dL+xfA5CmZq2t1jkoNo4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


