Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B64706268
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC73-0003ZG-G0; Wed, 17 May 2023 04:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6p-0002sV-C0
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6k-0000vU-Qc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:07 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M27ix-1q1ewu3801-002UbS; Wed, 17
 May 2023 10:01:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 8/9] linux-user: Fix mips fp64 executables loading
Date: Wed, 17 May 2023 10:01:51 +0200
Message-Id: <20230517080152.108660-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JsZWCb8o+WmcOT6ilvaEAFIWLP7z2Z5KIRsBNi8BaAIsNL3BfhL
 IKylcOmLeELSsu2T98nm5rqf3O0CARiABc05/xOZALFwo2f8U+8rdb4Uo1/2CPQoW6//FMo
 8N/idZzWu0iBhf/Abhu0fTIOvhyp7zVCHxs/niyRmT4WzMB+yttqFoi4kdw03NOBrj2yihy
 Al7SwC6Tg84wvgpGzK7Jg==
UI-OutboundReport: notjunk:1;M01:P0:DsFU1jWjiYI=;Y/HXhQfn9DN+Vw3W5V7Ig3GZqh4
 PgkV0nas8Z4neXiUzDCscuiauwxSkFh2VEB+5vtzEZ6SXSmJJhfg3h42TZOlaCWePttDPWt/6
 yUrWHVlEBXbhWqBoECLf0zQObxYzcf/KzBvoUUC77a+HXxmWU+Mm5z6dXn0eMtNuVRfpq0CBK
 fJuvecTkDV1US1nIT+AZYJ1wXbjmENjDRoJ8IZmQDckAoV4WqscHX2lbkPjXplczLsj6DS5gG
 70i6MXFDQWHPxALSYcUShqM7TYyPCIWZnTgWsGCKei848vLhlIBFQzw7EQ7ztby+ejrsZr5yO
 rnIKOWE9rGBfZcgk6RdB9OJoXguxp6HPUFiL+9oJqSwG1Qk+OMyWbNPLSvBpR4YfqbmZkHsiq
 s7fhTAXG9iYs8LA8wQXGcW8tjZxHddOe+0xT39mgmv9J/zgqoPL1xcKNkDp/+h+kx8+gr6QSd
 go7maRyWyHBgEWHRVwWUEIH3yxbXBVG3AUbTmaBhpwt4ShdxrIVryJ1bmYtcWSMmsxkzwXVbF
 lzyiKV6PZCSjB83jSEihzIiQJD9GuP7A2DDRCDV0giHE4luwKbrnDqN1p5DGVpnX+2x0vAnXy
 jTUYbpgwcUcIHXhdk2Eau8gi/9d49DBeu4JRPEFd3175f31ugzDQ27FF1Wg+Uo7axZEeiRXh1
 PnY1UbDcUYP/ZRGzA+ZoIVeA67WWtfayS+kShyLBDg==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>

If a program requires fr1, we should set the FR bit of CP0 control status
register and add F64 hardware flag. The corresponding `else if` branch
statement is copied from the linux kernel sources (see `arch_check_elf` function
in linux/arch/mips/kernel/elf.c).

Signed-off-by: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20230404052153.16617-1-dkovalev@compiler-toolchain-for.me>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/cpu_loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index d5c1c7941d34..8735e58bada0 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -290,7 +290,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
             env->CP0_Status |= (1 << CP0St_FR);
             env->hflags |= MIPS_HFLAG_F64;
         }
-    } else  if (!prog_req.fre && !prog_req.frdefault &&
+    } else if (prog_req.fr1) {
+        env->CP0_Status |= (1 << CP0St_FR);
+        env->hflags |= MIPS_HFLAG_F64;
+    } else if (!prog_req.fre && !prog_req.frdefault &&
           !prog_req.fr1 && !prog_req.single && !prog_req.soft) {
         fprintf(stderr, "qemu: Can't find a matching FPU mode\n");
         exit(1);
-- 
2.40.1


