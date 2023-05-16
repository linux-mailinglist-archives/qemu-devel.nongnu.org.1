Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7D704E07
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6M-0004T8-9K; Tue, 16 May 2023 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6J-0004M0-AY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6H-00065g-Jq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:23 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MjgfT-1qQlg30Bxr-00lBVT; Tue, 16
 May 2023 14:48:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 8/9] linux-user: Fix mips fp64 executables loading
Date: Tue, 16 May 2023 14:48:09 +0200
Message-Id: <20230516124810.90494-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AYTWf1Mam0ZVYtNa5m1XT7zLsRBfphs3HPQ/TrTWuJmO8PDzCb2
 VL+deoivVtOubs+lBBFpOtiYZU6QbsROkK5UWfH/SsNny0+8KvNUhQ1ex1UFuqqNq8sLgPK
 38BqVHPC7ArLYYMBlMY9Q15T6K9CjUMuPubJYkougIOawZw00QQ+dgWde8kA+4OE2WvyMBd
 PTir/OfwJt7e4Xvs60mYw==
UI-OutboundReport: notjunk:1;M01:P0:3v2DLZyhhTg=;+8CoK5DTa67TNVOGd+smONANjP9
 7BiKXwhxdkE8Xlt68JAcPLq2YUpXNhnP4QVWQ2sDHEwW0BLJhmAzD4JBHclaKqmFOae3hm2ex
 Wp67A6dnrzQTUmimGk+EQo3ObWWxEzxzrSXqtyeuFGrqwlngyQddESJ18OlTWyAKlhHdyud0i
 Wi0O9/ncKGAA17kGsv8ejZFTAqZTl0pcQP1WVHXjWmPlpfc5ttS9dOSWiA6j8leMhVRtDMsOo
 7peZZM+2ISFT6tFuCUMIEZvqjhBJNNAx31XeeDOTEl81hQABs5gzmVqBrUx0SzfFUNSXBbHWm
 gsTbF43hc5pF4APOk4znrJVhF6oQhh2gcvGlpBHAnvV55WJOYHDMXhJJVKvJLOo3FLFrVaiPZ
 MnO7qahoTIT5g4yX7ViKq2lbEkyALBCrAMOqUjpOQJez/hQ8r5lKNl8JhJaiSjMBPo6qbREFB
 JAR/dB20lOJmFXxKlhoAhvT4OWGOrrvk2iY59AxxkTwgSg1HiZV+n8+FcAgJ24yuMPHscd1ro
 RNkcw+IqQIqP6lbmx648ofjsE1fXKTRULLxTzSeLW5vvHzzrJ0NJqk4HABzq7hA4GeKaEuVjt
 WdGGeHS2oQz9kHlkholPY9pTUktSbCUIHgM9SHfmHlgo4lHVlulgwx8k901jjxMF62n+/4QmN
 A8v2KWY9DE3Af79waKKIq96FcZI9kNFoHOLw5lK34g==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
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


