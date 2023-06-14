Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB6372F9EF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 12:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9NJh-0000Fd-PE; Wed, 14 Jun 2023 06:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9NJe-000096-P4
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 06:01:27 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9NJc-0005Ft-1X
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 06:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zDPntnPHMN0dDBYGVMuf6Vv/5/cJel9Jtzzkqeampls=; b=J3bxWtGUcxp6/+n6AFAqnJe/Gx
 yNWY3Ij1BYYguN5DMdpITRwxGxHArhTw3z9ruQL6UDucXxoGx/fkuih/g5nehzfMnVeqG6nSLStwW
 x1LwxFK8T1oPLTXyUir9VQPVO6CF8zpHlhccNCPNMx8OLZn3+ugcEi6T1hSdgyMA5wP8=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v3 1/8] target/tricore: Introduce ISA 1.6.2 feature
Date: Wed, 14 Jun 2023 12:00:32 +0200
Message-Id: <20230614100039.1337971-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
References: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.14.95116, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=581771, da=174345944, mc=56, sc=0,
 hc=56, sp=0, fso=581771, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

we also introduce the tc37x CPU that implements that ISA version.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.c | 13 +++++++++++++
 target/tricore/cpu.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 7fa113fed2..f15169bd1b 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -104,6 +104,10 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* Some features automatically imply others */
+    if (tricore_feature(env, TRICORE_FEATURE_162)) {
+        set_feature(env, TRICORE_FEATURE_161);
+    }
+
     if (tricore_feature(env, TRICORE_FEATURE_161)) {
         set_feature(env, TRICORE_FEATURE_16);
     }
@@ -164,6 +168,14 @@ static void tc27x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_161);
 }
 
+static void tc37x_initfn(Object *obj)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(obj);
+
+    set_feature(&cpu->env, TRICORE_FEATURE_162);
+}
+
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
@@ -226,6 +238,7 @@ static const TypeInfo tricore_cpu_type_infos[] = {
     DEFINE_TRICORE_CPU_TYPE("tc1796", tc1796_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc1797", tc1797_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc27x", tc27x_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc37x", tc37x_initfn),
 };
 
 DEFINE_TYPES(tricore_cpu_type_infos)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index d98a3fb671..041fc0b6e5 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -273,6 +273,7 @@ enum tricore_features {
     TRICORE_FEATURE_131,
     TRICORE_FEATURE_16,
     TRICORE_FEATURE_161,
+    TRICORE_FEATURE_162,
 };
 
 static inline int tricore_feature(CPUTriCoreState *env, int feature)
-- 
2.40.1


