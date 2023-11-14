Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD647EBA62
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:02:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33Kd-0005Mp-Ay; Tue, 14 Nov 2023 19:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r33KB-0004hq-NU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r33K9-0007jd-5E
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700006403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXDGrYjydDAk912yeFLRg5uE4DlDrePfPNf5Uy50Q0g=;
 b=FagLtqs4CkoTbHh/onUCa1+pVsQPHuILx/Y/razBHO9+001nrNPgK2hgM7P/9l2+5Ps9T3
 xGIomYvNw0RC/gUANMD4BbVP+3o1pm1j3sVyfPKLgRzZWkgBeAD16AOi185GipRqn4TlYQ
 8oXNa16qlRBxTcXWnPFnXob+PPkjHow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-GJM9dJ_RMJGKGSxLABzl4Q-1; Tue, 14 Nov 2023 18:59:58 -0500
X-MC-Unique: GJM9dJ_RMJGKGSxLABzl4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B85F184AEE5;
 Tue, 14 Nov 2023 23:59:55 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A91C15885;
 Tue, 14 Nov 2023 23:59:42 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 philmd@linaro.org, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com, edgar.iglesias@gmail.com,
 bcain@quicinc.com, gaosong@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
Subject: [PATCH v5 13/31] target/loongarch: Use generic cpu_list()
Date: Wed, 15 Nov 2023 09:56:10 +1000
Message-ID: <20231114235628.534334-14-gshan@redhat.com>
In-Reply-To: <20231114235628.534334-1-gshan@redhat.com>
References: <20231114235628.534334-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Before it's applied:

[gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
la132-loongarch-cpu
la464-loongarch-cpu
max-loongarch-cpu

After it's applied:

[gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
Available CPUs:
  la132
  la464
  max

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/loongarch/cpu.c | 15 ---------------
 target/loongarch/cpu.h |  4 ----
 2 files changed, 19 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 6fdf5e60f5..a69ab595fb 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -481,21 +481,6 @@ static void loongarch_max_initfn(Object *obj)
     loongarch_la464_initfn(obj);
 }
 
-static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    const char *typename = object_class_get_name(OBJECT_CLASS(data));
-
-    qemu_printf("%s\n", typename);
-}
-
-void loongarch_cpu_list(void)
-{
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_LOONGARCH_CPU, false);
-    g_slist_foreach(list, loongarch_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 static void loongarch_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 00d1fba597..0c15a174e4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -466,10 +466,6 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
-void loongarch_cpu_list(void);
-
-#define cpu_list loongarch_cpu_list
-
 #include "exec/cpu-all.h"
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
-- 
2.41.0


